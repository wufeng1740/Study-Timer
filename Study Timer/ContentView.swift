//
//  ContentView.swift
//  Study Timer
//
//  Created by 吴峰 on 24/6/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var studyTime: Int = 0
    @State private var timerInterval: Timer? = nil
    @State private var isRunning: Bool = false
    @State private var ratio: Double = 1.0
    @State private var increment: Bool = true

    var body: some View {
        VStack {
            Text("Study and Fun Timer")
                .font(.largeTitle)
                .padding()

            Text(formatTime(seconds: studyTime))
                .font(.system(size: 48))
                .padding()
                .accessibility(identifier: "timerDisplay")

            HStack {
                Button(action: {
                    stopTimer()
                    increment = true
                    startTimer()
                }) {
                    Text("Study")
                }
                .padding()
                .accessibility(identifier: "studyButton")

                Button(action: {
                    stopTimer()
                    increment = false
                    startTimer()
                }) {
                    Text("Fun")
                }
                .padding()
                .accessibility(identifier: "funButton")

                Button(action: stopTimer) {
                    Text("Pause")
                }
                .padding()
                .accessibility(identifier: "pauseButton")

                Button(action: resetTimer) {
                    Text("Reset")
                }
                .padding()
                .accessibility(identifier: "resetButton")
            }

            HStack {
                Text("Enter Study/Fun Ratio:")
                TextField("Ratio", value: $ratio, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                    .padding()
                    .accessibility(identifier: "ratioInput")
            }
            .padding()
        }
        .padding()
    }

    func formatTime(seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }

    func updateTimer() {
        // Update the UI to reflect the new time
    }

    func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        let intervalTime = increment ? 1.0 / ratio : 1.0 * ratio

        timerInterval = Timer.scheduledTimer(withTimeInterval: intervalTime, repeats: true) { _ in
            if increment {
                studyTime += 1
            } else {
                studyTime = max(0, studyTime - 1)
            }
            updateTimer()
        }
    }

    func stopTimer() {
        timerInterval?.invalidate()
        isRunning = false
    }

    func resetTimer() {
        stopTimer()
        studyTime = 0
        updateTimer()
    }
}

#Preview {
    ContentView()
}
