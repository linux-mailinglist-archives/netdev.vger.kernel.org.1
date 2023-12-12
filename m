Return-Path: <netdev+bounces-56320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D586880E868
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DD61C209F6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655E5915F;
	Tue, 12 Dec 2023 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK6DNvzR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA6E9
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702375204; x=1733911204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ETlRTSpyHva2wdv1I0Giw4pxRX958Trt3ZIGNkYZal0=;
  b=fK6DNvzRfAdz/DOwhcFcnfSaweNzyE+lFbB6LM8MQvLEyt/9XaTFMgvJ
   XCpJ9E+7AhzZVnfuQGEgqlhj7tMYFXnoo9NYXW+54IgLkuhKUAaeuXaAz
   KEhxxQnhyvZ9zdrH0zrxXYRIGwgks9NlatJo4cEWT/IFP7939QOllQxjh
   MCnoh9ICQ+T93TKLNqwEWHBO0w88vMuZbzFnXrRLKFr8uPybkih5osXrv
   BVRjRkJ9ASCXC+DNmeB2yadwSBLYG3HsaKN2jlASOVHsDBSekXPxtvtCM
   NnOKvwnZnQ6va4naHRf+KI5QnqTWInoSp360yxJenAHrZwAUUOmoEaDEa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="385192504"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="385192504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896855665"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="896855665"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 02:00:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 02:00:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 02:00:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 02:00:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acm4VYa7ZZVEgT2ZcMKwmoL3WE2Kx8fFT9Sd1m3pIzYyTJFPAlVf/y3ymSwP8LC9clwVT10WVzjd8voBf8Q/TYieArb5tmg4nGhGB8nK1ij+Xi0SOpE+mlP3TdGRdQeKKt/MjNv5fiOeEDD/6hBHg8OtUU85o/JvWYbPcbqIB2SXgOKxICIYiRM9sdlC/KcyJRxzWpB8fG/vtiDwxvBVeuk/DFRm0BBwvU2Yztric0qE531jPDsw1/2FCeUZTQqpH/ASylQeDovX4Dx5YuJUpSVejnFhLBOOPZwbl9aJg65HLF5ehcJNRUGBSsPS7RTvDVp3d5ScvELNqZfu24/ZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETlRTSpyHva2wdv1I0Giw4pxRX958Trt3ZIGNkYZal0=;
 b=JzTL49ShOmbd6S2uIbKktJ1hUFOoWPQn+ysFbv2CFcDzu0RonLNogrKREr8ck/RF6+sJZgW7W+PmahkaSsB7ZlmdkO3hseG0+o2x+jMvQ35UcJ8z7Jf8blpnuCYBDm7EwRFNYMWOXYyGxX/D1WMM+DoKRrcN273/bgibpgyk9TXIlxaTcwu6QaUmRc/H/myWm3eAzF1cjKR9Fns0GE8WSAGuPUsaUPk9PBT9jIn0cf25tSLkTEiRxebJp/TRD5aOXZdbngUVIke0lNKtJLTRsEcSy31fQJXzuPyufcyRDvswashZJ5M3T2bkidAhr+NHlbwY1ZhLJvb06GwfkJcgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2731.namprd11.prod.outlook.com (2603:10b6:5:c3::25) by
 IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 10:00:01 +0000
Received: from DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::d315:1202:838:9b76]) by DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::d315:1202:838:9b76%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 09:59:55 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v3 1/2] ixgbe: Refactor overtemp event handling
Thread-Topic: [PATCH iwl-next v3 1/2] ixgbe: Refactor overtemp event handling
Thread-Index: AQHaKbbUapXDIsgTSkm9rVA3FeW0I7CfKSSAgASnxOCAAM94AIAAzoHw
Date: Tue, 12 Dec 2023 09:59:55 +0000
Message-ID: <DM6PR11MB27311DFB55E477A8E8CB671BF08EA@DM6PR11MB2731.namprd11.prod.outlook.com>
References: <20231208090055.303507-1-jedrzej.jagielski@intel.com>
 <20231208090055.303507-2-jedrzej.jagielski@intel.com>
 <f63dca8f-0082-6e22-5ab5-3b940b646053@intel.com>
 <DM6PR11MB2731EFF4B5E7BDE8886EA913F08FA@DM6PR11MB2731.namprd11.prod.outlook.com>
 <3a899036-be91-4ac3-1ced-f32df9ba9c13@intel.com>
In-Reply-To: <3a899036-be91-4ac3-1ced-f32df9ba9c13@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2731:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: ecd23603-5b1e-4aeb-472d-08dbfaf917cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGG56oA+InjYbBo/ioBGNgOcNIxLxn4jnPz5PeHwp9C7lcAjP2k61vfr6vCOqDpKLKwSo1ja4zuQ510T0K1H1c3g8gXJT3986r0RmaKw+bpLWDRlyPK7CO+CPSXMzC0amaN3DVVnEL9e70SDwwuuUWe2WzNV1RE9jrrqgt/jTqaKw3qcb1Xp5xtMx6BJisxmfW8VoOCalnwgtCl/AiJPBDYlzsRz16nSuzGZIJAeEHGW87F98x0xQgCSSy7mQXOHb1Sdyu/t09cffomAHh2IrA3VwLUsM7HqNlo9SRtHD9u5C4W3WeohVi1BBFwzP6f+RxzrPwaRPZRIOz+Hc7RyZi7lUV8Gq1J1v0CUwccHBx628IEnVB2hi5HxRd9Mv7vKzLuvXJMEjjqh8wihenX9NNeq0mdzS+veuoq9fcdmhHhdchIriU5NO50JZ1rcSHQ82XQSaOSBH9n2DjvE1GxTXZ6iW5pzbMLlgAe4KxzuOdGSnEWWUVEsvqv7EFjYyEAj1YNJ1wb1Jqf3W3Zt+2jvUzjHLR+VJilEFlsiDr9//0rrS59wnE9vdIflRifP+0qJOXR2u+4vbjzTsYfYj7pQeTAXRnkdGdGXi2Hv+EikOTB6qMMuPu4VMxR0l/3eoMy5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2731.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(55016003)(52536014)(2906002)(4326008)(71200400001)(122000001)(7696005)(6506007)(38100700002)(41300700001)(38070700009)(8936002)(8676002)(86362001)(33656002)(316002)(478600001)(82960400001)(83380400001)(53546011)(9686003)(110136005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y25kYVNwT0dyZ0g0TjZuWFV5anpaRHk2dzdLOGpVMmduQXpZY1NBbnFlTmRH?=
 =?utf-8?B?WGtTcFlab0JmN2JTTDIrNXRVSEZXVVRGNng3VHZKYXdyU2lpZ0pIWld2ZWho?=
 =?utf-8?B?ZXc0bDBNYUdIRXcrbTNWMFBpUitIenFkbWdrMW1uTHhTYXJpQkw0dnl1VEU0?=
 =?utf-8?B?UUVUSmIvZzMrbjUxTDhuUGQzamxHcVRQN2U5TE9NRWV1WW1mTExrV0p0NS93?=
 =?utf-8?B?MTdqdnhRSHNmNjdUUjQ1b2U0SjkzTnJFclA3bVBNMlZyUHhNR05tWU1EM0dD?=
 =?utf-8?B?UC9lbS83TkRLRVoyWEdzZGdsNGR6ZDVBbW9OUkJEZFVjb3Y2bm1nREs0TVN6?=
 =?utf-8?B?azNwZWovU0NjaUN1TVBZRVVJaWcvNEl4Wlp2QWtMb3pqejBpV2FFenhya09C?=
 =?utf-8?B?cU8wTXNKWmpiR3Y2ZlQvVmtpNXJocTFoT3BMK2pUS0NHR3lXNjk1SGlWQTJD?=
 =?utf-8?B?akN6WnJla21nckJoN3RiTlI5QTlTMkl3Rk9GM0FkOTNtUi9NcU4vMENPR20v?=
 =?utf-8?B?T2ZhVmhpY3AzaVVWaGo3bVRkYlphYnNVdXppZkhERmR5cnJ6ck9qRFpXazNj?=
 =?utf-8?B?cW9GVDY1REQrVTZVUE1UVnVPNC9reTRFbHdzSkJQazRnMkZ4TzRtMkU4OVVO?=
 =?utf-8?B?ZlZSWUViRjc4c1N6dTNFbHE1TWRBQUQzbjlXck1UL05haWozS053MUlJNXNy?=
 =?utf-8?B?SEFwME9UNFVGbUpwUk9OWTJEMjJzdUZvM3NwK3cxcmJiWmVxckxwWEc3UW9C?=
 =?utf-8?B?aXVVNHNOUWd6S0RKLzVWUUdYMmYxaU1uZkpXei92ak8wNFdxM2oyMklLbXY4?=
 =?utf-8?B?UitrTlU1UlBSbWRmV0trZkY5aEZ5dDFuTUVJSm9teFI2c3hDZ3oyaWNXeGhq?=
 =?utf-8?B?WlY5Y1MwdUt3L0JmeERzdi9Nak15SkJPK2FMQ0Y3MmVRcXc5dFVBc2Z0eFBO?=
 =?utf-8?B?c0JPOFVqZ3JTRlhjUU15cWdzZkNEdTUwUVQ5aEIxMW5sL0tYeENyRXdHbDVa?=
 =?utf-8?B?MkcwUWhGaDJ0aWptL3FNNE5BTFBtV2dLTDhyTThJQ1VvYnFrYVVQSFNpZGhz?=
 =?utf-8?B?anMvY01VUmY4bm9ZRWFyZVRJVkh6YjJ4TnVJdWYrcXQ3MnQxclU5clh5Snk4?=
 =?utf-8?B?SG10ZUkxVkZKVitneWVsblk1WEFOMGtxa3h6TEwwVmpFNjNQU1NmZ1lqamlX?=
 =?utf-8?B?VWgyTGFRbzZzNENVNUdudnNROXIyQVBkL2lnQ2pyVU5HdXBSQ1JUQW54a3Qr?=
 =?utf-8?B?T2swQUpob09rc2FJbGpiT1pmUUNzQS9DS2FaaXVnbGQvVnRHNGMxaitrc0tJ?=
 =?utf-8?B?Vll4aTg2QXc0OEliQ1dPbFNMNTllU3N2cElucjh4eVVOWVVUNlRqc0dzMzZF?=
 =?utf-8?B?ZTZQVXJkQjQ4cS9vNzg2S3hHM2E3T0p3OE5tOE5LeHZUVXB6M0JucXFGUGk3?=
 =?utf-8?B?Qk0vVHNaL21XRFlpRkpJblJ2bFpsNzNock5QZnpob2IxMDlJdklxNXUzbVRm?=
 =?utf-8?B?bkhhNU03NXhPRU9IRE1OTzRzb1MyNXQweTllZWNyRDVYUmd2blhKdmt5SmlT?=
 =?utf-8?B?anJDOXJXSDhOMHJaSllQN2dnMnpyOFVVZnIxa1BPZjJNRlgwbVN1RlZaWHVh?=
 =?utf-8?B?UVZlcUhxQXFiS2ZsU3haZDRmanVFMnhZblo3aUVqMU1ZQnJEZ0ppRmhNWmRE?=
 =?utf-8?B?OThEZXdlbzlOSFlkY2p2WDc4SUhrU0pLeTdIWCtVNFNXUUZicHpoOW5aRzVL?=
 =?utf-8?B?T08zd28vS29reE5WMDFVVi9DbnFld2pUS2Rtdks2aFQ0SnVSOHZHbWl6R3g3?=
 =?utf-8?B?ejJjSTA3MVYzUGxMNEJ4YStOdThBaTF1UWtBT3NuTDJpT1p0bGpIaUlUN0Iv?=
 =?utf-8?B?RFhpK09LUWk2Q1NjUlJzL1lENExtck5yZUJSQmdCWjcyM3FtSUdRbWNtbzhU?=
 =?utf-8?B?bW9raGpnUGFiUksxZlJMTWpXT2tpaGRaZXo2VTRwaW1wa1IxWWpzVVVQQmZm?=
 =?utf-8?B?UUVrMkVDYVNrU2Ftczl0ejhuMmIyVEVJTVhKcFJYNFdmWG1IRFVtUkF2Yk0r?=
 =?utf-8?B?OS9waURZMHFaWUlpRzhNTE1GaFk5d01uc3FxdmgxdGZQSGx5Ly93L3Q1MDFZ?=
 =?utf-8?B?Sk8yOGlvV1VmcUd5RTNuMFJvYlV1cnpteFZubUtsL1REdC9LbFVuR2F0eFFL?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2731.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd23603-5b1e-4aeb-472d-08dbfaf917cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 09:59:55.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mM0xH+HzZsG7njQQ9LDxIDezMo5J543p2TDY2C4SYotxOr1bIx9TU62NQetF97zTgUmXEJ+Pbyo37doOngduXMr6Z8/k0qE7Pso8e4sUTZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com

RnJvbTogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPiANClNl
bnQ6IE1vbmRheSwgRGVjZW1iZXIgMTEsIDIwMjMgMTA6MzUgUE0NCg0KPk9uIDEyLzExLzIwMjMg
MTo0NSBBTSwgSmFnaWVsc2tpLCBKZWRyemVqIHdyb3RlOg0KPj4gRnJvbTogS2l0c3plbCwgUHJ6
ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4+IFNlbnQ6IEZyaWRheSwg
RGVjZW1iZXIgOCwgMjAyMyAxMTowNyBBTQ0KPj4gDQo+Pj4gT24gMTIvOC8yMyAxMDowMCwgSmVk
cnplaiBKYWdpZWxza2kgd3JvdGU6DQo+Pj4+IEN1cnJlbnRseSBpeGdiZSBkcml2ZXIgaXMgbm90
aWZpZWQgb2Ygb3ZlcmhlYXRpbmcgZXZlbnRzDQo+Pj4+IHZpYSBpbnRlcm5hbCBJWEdCRV9FUlJf
T1ZFUlRFTVAgZXJyb3IgY29kZS4NCj4+Pj4NCj4+Pj4gQ2hhbmdlIHRoZSBhcHByb2FjaCB0byB1
c2UgZnJlc2hseSBpbnRyb2R1Y2VkIGlzX292ZXJ0ZW1wDQo+Pj4+IGZ1bmN0aW9uIHBhcmFtZXRl
ciB3aGljaCBzZXQgd2hlbiBzdWNoIGV2ZW50IG9jY3Vycy4NCj4+Pj4gQWRkIG5ldyBwYXJhbWV0
ZXIgdG8gdGhlIGNoZWNrX292ZXJ0ZW1wKCkgYW5kIGhhbmRsZV9sYXNpKCkNCj4+Pj4gcGh5IG9w
cy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmVkcnplaiBKYWdpZWxza2kgPGplZHJ6ZWou
amFnaWVsc2tpQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IHYyOiBjaGFuZ2UgYXByb2FjaCB0
byB1c2UgYWRkaXRpb25hbCBmdW5jdGlvbiBwYXJhbWV0ZXIgdG8gbm90aWZ5IHdoZW4gb3Zlcmhl
YXQNCj4+Pg0KPj4+IG9uIHB1YmxpYyBtYWlsaW5nIGxpc3RzIGl0cyBiZXN0IHRvIHJlcXVpcmUg
bGlua3MgdG8gcHJldmlvdXMgdmVyc2lvbnMNCj4+Pg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfbWFpbi5jIHwgMjAgKysrKy0tLS0NCj4+
Pj4gICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfcGh5LmMgIHwgMzMg
KysrKysrKysrLS0tLQ0KPj4+PiAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9p
eGdiZV9waHkuaCAgfCAgMiArLQ0KPj4+PiAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
eGdiZS9peGdiZV90eXBlLmggfCAgNCArLQ0KPj4+PiAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9peGdiZS9peGdiZV94NTUwLmMgfCA0NyArKysrKysrKysrKystLS0tLS0tDQo+Pj4+ICAg
IDUgZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMzkgZGVsZXRpb25zKC0pDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdi
ZV9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9tYWluLmMN
Cj4+Pj4gaW5kZXggMjI3NDE1ZDYxZWZjLi5mNjIwMGYwZDFlMDYgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX21haW4uYw0KPj4+PiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9tYWluLmMNCj4+Pj4gQEAg
LTI3NTYsNyArMjc1Niw3IEBAIHN0YXRpYyB2b2lkIGl4Z2JlX2NoZWNrX292ZXJ0ZW1wX3N1YnRh
c2soc3RydWN0IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0ZXIpDQo+Pj4+ICAgIHsNCj4+Pj4gICAgCXN0
cnVjdCBpeGdiZV9odyAqaHcgPSAmYWRhcHRlci0+aHc7DQo+Pj4+ICAgIAl1MzIgZWljciA9IGFk
YXB0ZXItPmludGVycnVwdF9ldmVudDsNCj4+Pj4gLQlzMzIgcmM7DQo+Pj4+ICsJYm9vbCBvdmVy
dGVtcDsNCj4+Pj4gICAgDQo+Pj4+ICAgIAlpZiAodGVzdF9iaXQoX19JWEdCRV9ET1dOLCAmYWRh
cHRlci0+c3RhdGUpKQ0KPj4+PiAgICAJCXJldHVybjsNCj4+Pj4gQEAgLTI3OTAsMTQgKzI3OTAs
MTUgQEAgc3RhdGljIHZvaWQgaXhnYmVfY2hlY2tfb3ZlcnRlbXBfc3VidGFzayhzdHJ1Y3QgaXhn
YmVfYWRhcHRlciAqYWRhcHRlcikNCj4+Pj4gICAgCQl9DQo+Pj4+ICAgIA0KPj4+PiAgICAJCS8q
IENoZWNrIGlmIHRoaXMgaXMgbm90IGR1ZSB0byBvdmVydGVtcCAqLw0KPj4+PiAtCQlpZiAoaHct
PnBoeS5vcHMuY2hlY2tfb3ZlcnRlbXAoaHcpICE9IElYR0JFX0VSUl9PVkVSVEVNUCkNCj4+Pj4g
KwkJaHctPnBoeS5vcHMuY2hlY2tfb3ZlcnRlbXAoaHcsICZvdmVydGVtcCk7DQo+Pj4NCj4+PiB5
b3UgbmV3ZXIgKGF0IGxlYXN0IGluIHRoZSBzY29wZSBvZiB0aGlzIHBhdGNoKSBjaGVjayByZXR1
cm4gY29kZSBvZg0KPj4+IC5jaGVja19vdmVydGVtcCgpLCBzbyB5b3UgY291bGQgcGVyaGFwcyBp
bnN0ZWFkIGNoYW5nZSBpdCB0byByZXR1cm4NCj4+PiBib29sLCBhbmQganVzdCByZXR1cm4gInRy
dWUgaWYgb3ZlcnRlbXAgZGV0ZWN0ZWQNCj4+IA0KPj4gR2VuZXJhbGx5IEkgdGhpbmsgaXQgaXMg
Z29vZCB0aGluayB0byBnaXZlIGEgcG9zc2liaWxpdHkgdG8gcmV0dXJuIGVycm9yIGNvZGUsDQo+
PiBkZXNwaXRlIGhlcmUgaXQgaXMgbm90IHVzZWQgKG5vIHBvc3NpYmlsaXR5IHRvIGhhbmRsZSBp
dCBzaW5jZSBjYWxsZWQgZnJvbQ0KPj4gdm9pZCBmdW5jdGlvbiwganVzdCByZXR1cm4pLg0KPj4g
QWxsIG90aGVyIHBoeSBvcHMgYXJlIGFsc28gczMyIHR5cGUsIHNvIHRoaXMgb25lIGlzIGFsaWdu
ZWQgd2l0aCB0aGVtLg0KPj4gDQo+PiBATmd1eWVuLCBBbnRob255IEwgV2hhdCBkbyB5b3UgdGhp
bmsgb24gdGhhdCBzb2x1dGlvbj8NCj4NCj5XZSBzaG91bGRuJ3QgY2FycnkgYSByZXR1cm4gdmFs
dWUgb25seSB0byBhbGlnbiB3aXRoIG90aGVyIG9wcy4gSWYgd2UgDQoNClN1cmUsIGp1c3QgdGhv
dWdodCBpdCBpcyBzdGFuZGFyZGl6ZWQgc29tZSB3YXkgaW4gdGhhdCBjYXNlLg0KDQo+dGhlcmUn
cyBubyBuZWVkIGZvciBpdCwgd2Ugc2hvdWxkbid0IGhhdmUgaXQuLi4gaG93ZXZlciwgYXJlbid0
IHlvdSANCj51c2luZy9jaGVja2luZyBpdCBoZXJlPw0KDQphY3R1YWxseSB0aGVyZSBpcyBubyBu
ZWVkIHNpbmNlIGp1c3Qgb3ZlcnRlbXAgaW5kaWNhdGlvbiBpcyBjaGVja2VkDQoNCj4NCj5AQCAt
NDA2LDkgKzQwNywxMiBAQCAgczMyIGl4Z2JlX3Jlc2V0X3BoeV9nZW5lcmljKHN0cnVjdCBpeGdi
ZV9odyAqaHcpDQo+ICAJaWYgKHN0YXR1cyAhPSAwIHx8IGh3LT5waHkudHlwZSA9PSBpeGdiZV9w
aHlfbm9uZSkNCj4gIAkJcmV0dXJuIHN0YXR1czsNCj4NCj4rCXN0YXR1cyA9IGh3LT5waHkub3Bz
LmNoZWNrX292ZXJ0ZW1wKGh3LCAmb3ZlcnRlbXApOw0KPisJaWYgKHN0YXR1cykNCj4rCQlyZXR1
cm4gc3RhdHVzOw0KPg0KPlRoYW5rcywNCj5Ub255DQoNClRoYW5rcw0KSmVkcmVrDQo=

