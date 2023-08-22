Return-Path: <netdev+bounces-29560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95A783D10
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB541C20A8F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530D8F63;
	Tue, 22 Aug 2023 09:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005B8F59
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:39:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F21CC9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692697190; x=1724233190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XSYej1Hbmbj5A+SsspPjS80qPxYv3GT74WNZnz2XZjc=;
  b=fICAwehQrvEGg7yS6b1QOYikhQRwy1ZLag0LsDf834oR+Ulq/tX4khpI
   K/yfnJUO77GUyXhuzfPh5NivkiQ4LG0bQmlkjSRPccq3o8g4+aKFPI7SK
   huBOOd9VA8dGMNermHSqHvypf5M6PM+CEJUGb9MfO8ozcl69Cm19uExPZ
   Yv3KranfiGg/aCLYxBcz2cTa72ERMhiJI5dw4kHpU4h8nFBYVcOxecBcJ
   0Lj+hVL+dcGdJuHQ9FvKEDlO+/QGvzNUyU0IIrNI9u12aafjou0J34BPQ
   ZzbAZsojV3NAUfX8FHxb3JkjCm/v1F75xIO92i7yZTnDLaL0t6vUi3w6o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371258648"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="371258648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685982152"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="685982152"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2023 02:39:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 02:39:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 02:39:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 02:39:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 02:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGzeiz+Q3MhVHA8z+Bbi0KSUIWZeV7ZarFOVTxIA1YRNtZ3Q2Gy4pKwMY1t5T4bKgq7iA5ChxUNg0vGE+8Odn1zGGoEYJ5dtsLVozwe0Bo2EeHzDGPgkMLT6oUILfCGUsXjOPTlL0r+TB9ZxMGtWuJ4nCm2nVQqpkwm1gR8Eb2Va+ZcDczZ4EQBAiMXciMAgS9vysuHYcSgRb8COe8bNomoh/vl0etao86xedM3NVwFXUk3ZcJAbY1L3QeTUzQ7tGLtyarSni5KjyDKpeswWea9jtXohtvf2iUDZqGJK6wtdSO0kJIQyGWPZUk8ii6XckWqdUfnjTVS2pFNz11VXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSYej1Hbmbj5A+SsspPjS80qPxYv3GT74WNZnz2XZjc=;
 b=Odea91ALZPziHrVuCTeY2sMDeyjRzrXEm5rwbBuSzNvj5Eqb544+O+cNRkSP38Jwl6r9U6G6to04YgrvpC6Ity3Jp9eC2MUz4I/MmV2EKOxioq9Km9JZn3Nnu4JOQj8fkpM7Kx1Zu+YRnis9Z6ovY0va+VxINdXDfob1lMJVTFPt83huZRg1VKF/4EotKVMbWPiEm8YH0noHpM/VrJ5qGyoYcAFcO+hH7ZyBhOzExMHqZDVsUv1/aP5oygZeBi0Gxp9jsGbjs77WXKQsRWzfwoot0SOedwVRwNRmJX7rIUvorVq9169u63QsBOzwrTkC8BRiohL42sA1sl0Lv9HIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 09:39:46 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 09:39:46 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next] ice: Disable Cage Max Power override
Thread-Topic: [PATCH iwl-next] ice: Disable Cage Max Power override
Thread-Index: AQHZ1NEKbpMgCaXCCE6+x/ZDvFpCaq/2Dppw
Date: Tue, 22 Aug 2023 09:39:45 +0000
Message-ID: <MW4PR11MB57768A5C5E5670CFE680C5D7FD1FA@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230822073452.28446-1-wojciech.drewek@intel.com>
 <dd439a56-81da-a7ed-84ed-c04afd50b836@intel.com>
In-Reply-To: <dd439a56-81da-a7ed-84ed-c04afd50b836@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|CH0PR11MB8189:EE_
x-ms-office365-filtering-correlation-id: daed2724-8726-4481-6e7d-08dba2f3b881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1WSO1yHZcmdBdUlKjfxl5C7pXhcYv3INGu57jjEaq470PjnaOv4oeU+byheL/9P3Y4x21YEv3IUQpJ7XSrvMcwBB10v6wFhPq095b6XanBYtMtvGZzQaUDDgmWY/NcBTuMNnSF0Vloti6l7Lj36VyKmDGSZCtWCD83Xj+4/ahKaH4h4U0TSOj1YoKxGyAHRVUPWOij7GbGpwcLe5R2FsK11vywz+5fUwv5qvGAqpFwbvJuDo9oNwoHkMnXmRhf960S5PIt8LonsanPDo+ysDSh46Q54B0/gCBuG9pbTXRcRms+Io0tDcDY4HIqbhhmS7/LruKH5EEgZkfcaIfhptCnOCAaZdmJnKzLEa4QPaYGx/XCG7uV4u8qvYCyVnPbSbuQo3vcVHreGW/eOU811icWlnI6R3Vi3FrOPX/qRRQhqBwA4/9c6yum08uUwqkLApp4iycf7Iepebc01Lku3vHt7K9RHYmGaShGkB0bRu66lejW9C2OJ+JcqbAVy2OWVHyNqh3klIed6MtFIimuGycVFOM15qs5Z46yDlshXoocoKZCq1JndCkgA3Ua9F21VtB/MkBLjorSfO6FvfRHm5kFnlKHZPwBoNqx6/rPwLzYpbRimSv6Xq+xvK9squFF8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(53546011)(38070700005)(38100700002)(6506007)(83380400001)(5660300002)(52536014)(33656002)(26005)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(66446008)(76116006)(66556008)(66476007)(110136005)(82960400001)(478600001)(122000001)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDZKWG9Mb0lNc2x6UGlYQVFXTzIyTE5zSXh6NTI5ZUZxbXZPTStyNGRzN3d6?=
 =?utf-8?B?UzhiR09mTmczek1jTVpIbTVFS2J4djdTcnNPWkZxNFBKblVqQzRrWENtWDZN?=
 =?utf-8?B?OFNZdXZZWk9GYTZWM1pnYXpxQTdtOWNCbmZGWDE2VVlUUTR1dDVoQUpMelR2?=
 =?utf-8?B?dm9sK2tmTEg4K2tXMktwa3R4Rk04ZVF2eFcremVUTHlkdWRPL3dvMlltSGJq?=
 =?utf-8?B?ZlR1TU9lMVFIOEJkcDNYZ2EvZEh4RXhBOFFzWjliRU1QVisyVElXSkFkb0hs?=
 =?utf-8?B?NjhWenpKeFdWZFIzMktTN3FZMEZHMk5xOURrcnFNeEZvNHZFMGl5eGsvcHFs?=
 =?utf-8?B?dGhGa2FGQXQxYzZJUThFTEE3SUxLSldhM0ZTMTBuNVRpNU5aNW5wWTNJeXhI?=
 =?utf-8?B?QWxnZE9QeVBFUTA3REhsanJTa1dJaUdiNlhSZlI2WXBJZ0RhNUZ5aGtaRkF0?=
 =?utf-8?B?UzJETE5oSGRJN0VqWWZaSEFxZExGWFNQSW9MeWdhZFd5Mmd4YldoSkN6VVEw?=
 =?utf-8?B?UStDaUplYUlYVis3dkp1Y0ZaQW42c2ZCWUZ6RFV3UFExZzdZRTlNeERCUTcx?=
 =?utf-8?B?aXFHczJuaytWTEVzak90S2dUbEhwWGRCRzJoQmNpZHVKeHZSMWJtUkdxTnd1?=
 =?utf-8?B?Q2pDMnV6WHdnZUxJLy9HbUVndmFSSENIa3c5czR6Z1F1MG0xT25hNlVuUnl1?=
 =?utf-8?B?WEN4VDZsL09aakFPQjJqbCtXS2VBQ2l1a25nWVl3bDh5My85a29HQ09zMm42?=
 =?utf-8?B?NjdDc2tGZmtHTEZXZk9vdThWeEppNWVHUTFBZFZjdi96Z1VrNzkzSEtLa29E?=
 =?utf-8?B?VWVxOTRZVDZmblFHczZFbFQrbE5FS0o3QVQ1ZDZpOWNNV1VBYnYyYVNNWmxu?=
 =?utf-8?B?WFBrNE4wTng3SVpDV2Zzc2U5dnM1TFViSmt2MXQ0c09aUDNjNFhrTmQ1N3JL?=
 =?utf-8?B?RnFYYklpQ1AxelZvTmxET1Y3b1JKM0pxT2RTNHZndktrOWV6M2NrdGswa2xQ?=
 =?utf-8?B?Z2s1WEJhRGtPbmlWOUtPdzRPdU4yQnEzVS9HQ2JFUmpQYmx4Wi9KVjBmcWc4?=
 =?utf-8?B?MnZGY29QTW1sRURrZGQ0WThiajhWSEhlMERZNkdBYmFjcEJwNCtzWkl2QmZ0?=
 =?utf-8?B?VXBsQVZXTmRjaTJXUEdUVStvNTFVbG9rZlBhclN1VVpqSWNxblhQSzdwMGtk?=
 =?utf-8?B?dHE3d3ZvK3FQZ2cxZEZFODJLcXdGTGJsanFwOXhWTFdRYkE4MkFqcEYwN3A4?=
 =?utf-8?B?QUxUaUtqVHJPUzVwL3BoU3hIS2RVeXJPWUQ0d0VuakE5V2o0azJPWW5iTk9s?=
 =?utf-8?B?WFlTU3c3ZkFWbU9PRkhZQUVLWCtlMHFZWEd0bm0rcUlEVVNyS3Nid0ppTG84?=
 =?utf-8?B?WlpIVnN3bkQ2czRlam9xeHVWME9VRmgzZFEwT1Mva0ZsL2phQTZTQkFhNjhU?=
 =?utf-8?B?K3A4NnR2SDIxeUNCWlU3TzlIUUZVcTVpam8veERXUWVQVFNLSTNKT0krQlY3?=
 =?utf-8?B?eFhJRzVPSU9CaFZSdldpTnhneHphTGtpVUhNeC82cjVsQ0JjQWpTTStUNFl0?=
 =?utf-8?B?dUMrdFZzQVhnQVBJdVN1UlJURzluMEdvOS9oUDlzL3B1TSs0NlJaQ2d6UkVO?=
 =?utf-8?B?Mytjb1laWi9KcWVOZXRnWTZ2SjN3VTBMU1pQR2grZ1RFbENmL1dVZ01rdTZx?=
 =?utf-8?B?WW9wMmRhM1lENVBEMGpveW9MNWo5L0V2S21pbkJUa0QzOTNzSXloWTNDejE2?=
 =?utf-8?B?c0xOYVFsMXlEYjBpeC8rRnM1OEIyalhPdXJyQU5RU2huL1EwTG9uYXZpK0kx?=
 =?utf-8?B?azRJL3Y2OEZyN1h6eHB5ZWVZNjdTMGU3cGQ1Wk16MlBhRUZCSWgrYXlQRkZF?=
 =?utf-8?B?S21IRjZ1YThGWEpFN015WldJazdVblRyeGh4UlVYd0diNlFVbm8yYXEzeVpC?=
 =?utf-8?B?SlorRzVVN09FUUQ1VEZnZVFCcGU1RHNnSTdZUXh5dGMvb3QrYm5ram9lcFhh?=
 =?utf-8?B?c2tmU080a0FEdGpLekxCNUxDc2dzT0swZGs4QUlSOXIrdVROQXU5SENzNXh3?=
 =?utf-8?B?UFZ1K0xCc3Vqc3NVVW9TWVlobGYzeHRtclZvdFpOZU1Cd2pJODY0VTJDbTI3?=
 =?utf-8?Q?7YhN3nrxakbep/Nct9fIqMhu8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daed2724-8726-4481-6e7d-08dba2f3b881
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 09:39:45.9239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bn1YxiA7fAhYJ6G03PDQriDtE3wvoElyWrW2dyW1y/hyS1C3kgrwkHJPpXBHm9GXF7DO7Ku+la7lXZ02Y75yymzDZmnTLQuioTDYM52PC9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2l0c3plbCwgUHJ6ZW15
c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2VudDogd3RvcmVrLCAyMiBz
aWVycG5pYSAyMDIzIDEwOjE3DQo+IFRvOiBEcmV3ZWssIFdvamNpZWNoIDx3b2pjaWVjaC5kcmV3
ZWtAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV4dF0gaWNl
OiBEaXNhYmxlIENhZ2UgTWF4IFBvd2VyIG92ZXJyaWRlDQo+IA0KPiBPbiA4LzIyLzIzIDA5OjM0
LCBXb2pjaWVjaCBEcmV3ZWsgd3JvdGU6DQo+ID4gTlZNIG1vZHVsZSBjYWxsZWQgIkNhZ2UgTWF4
IFBvd2VyIG92ZXJyaWRlIiBhbGxvd3MgdG8NCj4gPiBjaGFuZ2UgbWF4IHBvd2VyIGluIHRoZSBj
YWdlLiBUaGlzIGNhbiBiZSBhY2hpZXZlZA0KPiA+IHVzaW5nIGV4dGVybmFsIHRvb2xzLiBUaGUg
cmVzcG9uc2liaWxpdHkgb2YgdGhlIGljZSBkcml2ZXIgaXMgdG8NCj4gPiBnbyBiYWNrIHRvIHRo
ZSBkZWZhdWx0IHNldHRpbmdzIHdoZW5ldmVyIHBvcnQgc3BsaXQgaXMgZG9uZS4NCj4gPiBUaGlz
IGlzIGFjaGlldmVkIGJ5IGNsZWFyaW5nIE92ZXJyaWRlIEVuYWJsZSBiaXQgaW4gdGhlDQo+ID4g
TlZNIG1vZHVsZS4gT3ZlcnJpZGUgb2YgdGhlIG1heCBwb3dlciBpcyBkaXNhYmxlZCBzbyB0aGUN
Cj4gPiBkZWZhdWx0IHZhbHVlIHdpbGwgYmUgdXNlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFdvamNpZWNoIERyZXdlayA8d29qY2llY2guZHJld2VrQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIC4uLi9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZG1pbnFfY21kLmggICB8ICA5ICsr
KysrDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RldmxpbmsuYyAg
fCAzNSArKysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX252bS5jICAgICAgfCAgMiArLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9udm0uaCAgICAgIHwgIDQgKysrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQs
IDQ5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkbWlucV9jbWQuaCBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRtaW5xX2NtZC5oDQo+ID4gaW5kZXggZmZiZTlk
M2E1ZDc3Li5hM2E0OWQ5MjI2NTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9hZG1pbnFfY21kLmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX2FkbWlucV9jbWQuaA0KPiA+IEBAIC0xNTY5LDYgKzE1NjksMTUg
QEAgc3RydWN0IGljZV9hcWNfbnZtIHsNCj4gPiAgIAlfX2xlMzIgYWRkcl9sb3c7DQo+ID4gICB9
Ow0KPiA+DQo+ID4gKyNkZWZpbmUgSUNFX0FRQ19OVk1fQ01QT19NT0RfSUQJCQkweDE1Mw0KPiA+
ICsNCj4gPiArLyogQ2FnZSBNYXggUG93ZXIgb3ZlcnJpZGUgTlZNIG1vZHVsZSAqLw0KPiA+ICtz
dHJ1Y3QgaWNlX2FxY19udm1fY21wbyB7DQo+ID4gKwlfX2xlMTYgbGVuZ3RoOw0KPiA+ICsjZGVm
aW5lIElDRV9BUUNfTlZNX0NNUE9fRU5BQkxFCUJJVCg4KQ0KPiA+ICsJX19sZTE2IGNhZ2VzX2Nm
Z1s4XTsNCj4gDQo+IFsxXSBoZXJlDQo+IA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgICNkZWZpbmUg
SUNFX0FRQ19OVk1fU1RBUlRfUE9JTlQJCQkwDQo+ID4NCj4gPiAgIC8qIE5WTSBDaGVja3N1bSBD
b21tYW5kIChkaXJlY3QsIDB4MDcwNikgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9kZXZsaW5rLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2RldmxpbmsuYw0KPiA+IGluZGV4IDgwZGM1NDQ1YjUwZC4uZTkzMDBkZjll
ZjQwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
ZGV2bGluay5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9k
ZXZsaW5rLmMNCj4gPiBAQCAtNTkxLDYgKzU5MSwzNiBAQCBzdGF0aWMgdm9pZCBpY2VfZGV2bGlu
a19wb3J0X29wdGlvbnNfcHJpbnQoc3RydWN0IGljZV9wZiAqcGYpDQo+ID4gICAJa2ZyZWUob3B0
aW9ucyk7DQo+ID4gICB9DQo+ID4NCj4gPiArI2RlZmluZSBJQ0VfTlVNX09GX0NBR0VTIDgNCj4g
DQo+IHBlcmhhcHMgbW92ZSB0aGlzIGRlZmluZSB0byBpY2VfYWRtaW5xX2NtZC5oIHRvIGJlbmVm
aXQgZnJvbSBpdCBpbg0KPiBzdHJ1Y3QgZGVmaW5pdGlvbiBqdXN0IGZldyBsaW5lcyBhYm92ZSBb
MV0NCg0KR29vZCBwb2ludA0KDQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogaWNlX2Rldmxpbmtf
YXFfY2xlYXJfY21wbyAtIGNsZWFyIENhZ2UgTWF4IFBvd2VyIG92ZXJyaWRlDQo+ID4gKyAqIEBo
dzogcG9pbnRlciB0byB0aGUgSFcgc3RydWN0DQo+ID4gKyAqDQo+ID4gKyAqIFJlYWQgQ2FnZSBN
YXggUG93ZXIgb3ZlcnJpZGUgTlZNIG1vZHVsZSwgY2xlYXIgb3ZlcnJpZGUNCj4gPiArICogZW5h
YmxlIGJpdCBmb3IgZWFjaCBvZiB0aGUgY2FnZXMuIFdyaXRlIHRoZSBzZXR0aW5ncyBiYWNrIHRv
DQo+ID4gKyAqIHRoZSBOVk0uDQo+IA0KPiBSZWFkK2NsZWFyK3dyaXRlIGlzICJob3ciIG9yIGFs
Z29yaXRobSBoZXJlLCBidXQgZG9jIHNob3VsZCBqdXN0IHN0aWNrDQo+IHRvICJ3aGF0IiBtb3N0
IG9mIHRoZSB0aW1lLiBTbyBJIHdvdWxkIGp1c3Q6DQo+ICJDbGVhciBDYWdlIE1heCBQb3dlciBv
dmVycmlkZSBlbmFibGUgYml0IGZvciBlYWNoIG9mIHRoZSBjYWdlcyIuDQo+IA0KPiAiaG93IiBw
YXJ0IGNvdWxkIGJlIGluc2lkZSB0aGUgZnVuY3Rpb24sIGp1c3QgYWJvdmUgInJlYWQiIGNhbGwu
DQoNCkknbGwgcmV0aGluayB0aGF0Lg0KDQo+IA0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGludA0K
PiA+ICtpY2VfZGV2bGlua19hcV9jbGVhcl9jbXBvKHN0cnVjdCBpY2VfaHcgKmh3KQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgaWNlX2FxY19udm1fY21wbyBkYXRhOw0KPiA+ICsJaW50IHJldCwgaTsN
Cj4gPiArDQo+ID4gKwlyZXQgPSBpY2VfYXFfcmVhZF9udm0oaHcsIElDRV9BUUNfTlZNX0NNUE9f
TU9EX0lELCAwLCBzaXplb2YoZGF0YSksDQo+ID4gKwkJCSAgICAgICZkYXRhLCB0cnVlLCBmYWxz
ZSwgTlVMTCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+
ICsJZm9yIChpID0gMDsgaSA8IElDRV9OVU1fT0ZfQ0FHRVM7IGkrKykNCj4gPiArCQlkYXRhLmNh
Z2VzX2NmZ1tpXSAmPSB+Y3B1X3RvX2xlMTYoSUNFX0FRQ19OVk1fQ01QT19FTkFCTEUpOw0KPiA+
ICsNCj4gPiArCS8qIERvIG5vdCB1cGRhdGUgdGhlIGxlbmd0aCB3b3JkIHNpbmNlIGl0IGlzIG5v
dCBwZXJtaXR0ZWQgKi8NCj4gPiArCXJldHVybiBpY2VfYXFfdXBkYXRlX252bShodywgSUNFX0FR
Q19OVk1fQ01QT19NT0RfSUQsIDIsDQo+ID4gKwkJCQkgc2l6ZW9mKGRhdGEuY2FnZXNfY2ZnKSwg
ZGF0YS5jYWdlc19jZmcsDQo+ID4gKwkJCQkgZmFsc2UsIDAsIE5VTEwpOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICAgLyoqDQo+ID4gICAgKiBpY2VfZGV2bGlua19hcV9zZXRfcG9ydF9vcHRpb24gLSBT
ZW5kIHNldCBwb3J0IG9wdGlvbiBhZG1pbiBxdWV1ZSBjb21tYW5kDQo+ID4gICAgKiBAcGY6IHRo
ZSBQRiB0byBwcmludCBzcGxpdCBwb3J0IG9wdGlvbnMNCj4gPiBAQCAtNjIzLDYgKzY1MywxMSBA
QCBpY2VfZGV2bGlua19hcV9zZXRfcG9ydF9vcHRpb24oc3RydWN0IGljZV9wZiAqcGYsIHU4IG9w
dGlvbl9pZHgsDQo+ID4gICAJCXJldHVybiAtRUlPOw0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJc3Rh
dHVzID0gaWNlX2RldmxpbmtfYXFfY2xlYXJfY21wbygmcGYtPmh3KTsNCj4gPiArCWlmIChzdGF0
dXMpDQo+ID4gKwkJZGV2X2RiZyhkZXYsICJGYWlsZWQgdG8gY2xlYXIgQ2FnZSBNYXggUG93ZXIg
b3ZlcnJpZGUsIGVyciAlZCBhcV9lcnIgJWRcbiIsDQo+ID4gKwkJCXN0YXR1cywgcGYtPmh3LmFk
bWlucS5zcV9sYXN0X3N0YXR1cyk7DQo+ID4gKw0KPiA+ICAgCXN0YXR1cyA9IGljZV9udm1fd3Jp
dGVfYWN0aXZhdGUoJnBmLT5odywgSUNFX0FRQ19OVk1fQUNUSVZfUkVRX0VNUFIsIE5VTEwpOw0K
PiA+ICAgCWlmIChzdGF0dXMpIHsNCj4gPiAgIAkJZGV2X2RiZyhkZXYsICJpY2VfbnZtX3dyaXRl
X2FjdGl2YXRlIGZhaWxlZCwgZXJyICVkIGFxX2VyciAlZFxuIiwNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9udm0uYyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfbnZtLmMNCj4gPiBpbmRleCBmNmY1MmEyNDgwNjYuLjc0NWYy
NDU5OTQzZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX252bS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9u
dm0uYw0KPiA+IEBAIC0xOCw3ICsxOCw3IEBADQo+ID4gICAgKg0KPiA+ICAgICogUmVhZCB0aGUg
TlZNIHVzaW5nIHRoZSBhZG1pbiBxdWV1ZSBjb21tYW5kcyAoMHgwNzAxKQ0KPiA+ICAgICovDQo+
ID4gLXN0YXRpYyBpbnQNCj4gPiAraW50DQo+ID4gICBpY2VfYXFfcmVhZF9udm0oc3RydWN0IGlj
ZV9odyAqaHcsIHUxNiBtb2R1bGVfdHlwZWlkLCB1MzIgb2Zmc2V0LCB1MTYgbGVuZ3RoLA0KPiA+
ICAgCQl2b2lkICpkYXRhLCBib29sIGxhc3RfY29tbWFuZCwgYm9vbCByZWFkX3NoYWRvd19yYW0s
DQo+ID4gICAJCXN0cnVjdCBpY2Vfc3FfY2QgKmNkKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX252bS5oIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9udm0uaA0KPiA+IGluZGV4IDc3NGMyMzE3OTY3ZC4uOTBmMzZlMTllMDZi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbnZt
LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX252bS5oDQo+
ID4gQEAgLTE1LDYgKzE1LDEwIEBAIHN0cnVjdCBpY2Vfb3JvbV9jaXZkX2luZm8gew0KPiA+ICAg
aW50IGljZV9hY3F1aXJlX252bShzdHJ1Y3QgaWNlX2h3ICpodywgZW51bSBpY2VfYXFfcmVzX2Fj
Y2Vzc190eXBlIGFjY2Vzcyk7DQo+ID4gICB2b2lkIGljZV9yZWxlYXNlX252bShzdHJ1Y3QgaWNl
X2h3ICpodyk7DQo+ID4gICBpbnQNCj4gPiAraWNlX2FxX3JlYWRfbnZtKHN0cnVjdCBpY2VfaHcg
Kmh3LCB1MTYgbW9kdWxlX3R5cGVpZCwgdTMyIG9mZnNldCwgdTE2IGxlbmd0aCwNCj4gPiArCQl2
b2lkICpkYXRhLCBib29sIGxhc3RfY29tbWFuZCwgYm9vbCByZWFkX3NoYWRvd19yYW0sDQo+ID4g
KwkJc3RydWN0IGljZV9zcV9jZCAqY2QpOw0KPiA+ICtpbnQNCj4gPiAgIGljZV9yZWFkX2ZsYXRf
bnZtKHN0cnVjdCBpY2VfaHcgKmh3LCB1MzIgb2Zmc2V0LCB1MzIgKmxlbmd0aCwgdTggKmRhdGEs
DQo+ID4gICAJCSAgYm9vbCByZWFkX3NoYWRvd19yYW0pOw0KPiA+ICAgaW50DQoNCg==

