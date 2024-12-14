//
//  PreferencesView.swift
//  UYSpoilerPlateSwiftUI
//
//  Created by Utku Yeğen on 12.12.2024.
//

import SwiftUI

public struct PreferencesSectionModel: Identifiable {
    public let id: UUID = .init()
    let sectionTitle: String
    let sectionRows: [PreferencesSectionRowModel]
    
    public init(
        sectionTitle: String,
        sectionRows: [PreferencesSectionRowModel]
    ) {
        self.sectionTitle = sectionTitle
        self.sectionRows = sectionRows
    }
}

public struct PreferencesSectionRowModel: Identifiable {
    public let id: UUID = .init()
    let type: PreferencesRowType
    
    public init(
        type: PreferencesRowType
    ) {
        self.type = type
    }
}

public enum PreferencesRowType {
    case viewNavigation(PreferencesViewNavigationModel)
    case socialMedia(PreferencesSocialMediaModel)
}

public struct PreferencesViewNavigationModel {
    let title: String
    let view: AnyView
    
    init(
        title: String,
        view: AnyView
    ) {
        self.title = title
        self.view = view
    }
}

public struct PreferencesSocialMediaModel {
    let imageName: String
    let title: String
    let url: URL
    
    public init(
        imageName: String,
        title: String,
        url: URL
    ) {
        self.imageName = imageName
        self.title = title
        self.url = url
    }
}

public struct PreferencesView: View {
    let preferences: [PreferencesSectionModel]
    
    public init(preferences: [PreferencesSectionModel]) {
        self.preferences = preferences
    }
    
    public var body: some View {
        NavigationStack {
            List(preferences) { preference in
                Section(preference.sectionTitle) {
                    ForEach(preference.sectionRows, id: \.id) { preferenceRow in
                        switch preferenceRow.type {
                        case .viewNavigation(let model):
                            NavigationLink {
                                model.view
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(model.title)
                                }
                            }
                        case .socialMedia(let model):
                            Link(destination: model.url) {
                                HStack {
                                    Image(model.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .padding(4)
                                    Text(model.title)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
