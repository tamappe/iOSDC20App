//
//  ContentView.swift
//  DC20App
//
//  Created by 玉置 on 2020/08/22.
//

import SwiftUI

class Counter: ObservableObject {

    @Published var count: Int = 1
    
    func increment() {
        count += 1
    }
    
    func reset() {
        count = 1
    }
}

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .blue
     }
    
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("iOSDC 2020 App")
        }
    }
}

struct Home: View {
    
    @ObservedObject private var counter = Counter()
    
    private let list: [Int] = {
        let intList = [Int](1...25)
        return intList.shuffled()
    }()
    
    private var buttons: some View {
        ForEach(list, id: \.self) { index in
            Button(action: {
                if counter.count == index {
                    counter.increment()
                }
            }, label: {
                Text("\(index)")
                    .frame(width: 60, height: 60)
            })
            .accentColor(Color.black)
        }
    }

    var body: some View {
        VStack {
            HStack(spacing: 10, content: {
                Spacer()
                Text("現在の値: ")
                Text("\(counter.count)")
                    .padding()
                    .padding(.trailing, 20)
            })
            
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 5),
                content: {
                    ForEach(list, id: \.self) { index in
                        Button(action: {
                            if counter.count == index {
                                counter.increment()
                            }
                        }, label: {
                            Text("\(index)")
                                .frame(width: 60, height: 60)
                        })
                        .accentColor(Color.black)
                    }
                })
            
            Button(action: {
                counter.reset()
            }, label: {
                Text("リセット")
            })
            .accentColor(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
