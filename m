Return-Path: <netdev+bounces-214236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4A7B28974
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 02:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D977916AE9E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437A2BAF7;
	Sat, 16 Aug 2025 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n18C6mqF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADD10E9;
	Sat, 16 Aug 2025 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305635; cv=fail; b=fcysab4d/QIvz0t7COI/wHfwXiwMhNnP0d4YFhpurZFTYSIw0Js/T7JB/c38L4dAo4fIQvrld0E3IncQx5/xpTOJXfcoJwR03RoS4sYsYH3yYXOMdiJ0NA4WSFa1sW5gC/DE9ZmZN80291JpN+P0tPZeJuT7H+kWiseX8O2lfqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305635; c=relaxed/simple;
	bh=TUPjNVMoMn4jZCqRciZ5yH49RkbqIhj3jacIqOU+mAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMtIGQqHDvyy/PQ7DBea4H0TFIc8ouNBnRx1YtM92V1NjZJ8VcUeAcGSwYNvQ3rPSkcrjHi4iWXDB7CCuvE4IuAMs42F3k/VergKmd9NSvyGrfBqHoj3BPJUcZWHvNT8qgH2zxLoUqZd88PKER/BO0IvaDidyfE7ptYgmtchhEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n18C6mqF; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNGvHIMHXNmPIxS5zskWFYtELIIZK10IsvWoFTL3Ow/xQRonLdv1GpUZOgsPKEfYMb723cpEv7uWIlsiwJ/ErCm1fvVQ9WPfrDOEm949t3sr2mR5k+xAkxTeV5SvtNWs6khd70mRLRviXssag5oCHNqWLMkdnfPhmE10S2Fg1yQexhYApawVi9PspYQFnFZpmmucyjU+GQq9Xumts/QF5meGcv+jkGDem2EhmauOogVmA1tfKhXbDbWtqqJ2ZQGSjYVwshxH2yayd07dSEqKpDVM6i+hwI7YZDKINjFhQ1kuXTdhFyn5tS+/oIpRFrq1QCqWJuPYGey2IfNzgvSTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUPjNVMoMn4jZCqRciZ5yH49RkbqIhj3jacIqOU+mAE=;
 b=DuAN1IP6IQeJBGCFeMGElu3zsr2YVJ37w1rlbVayWz/Zs3VS5mXSCEvuoGNpBYlDZTTgDsXqJS1ZdeHutSFOcnbMRAUtJrMG4Y3201tHGTdzQOV9E2yIKH1WdH7OHWVDC+a0cNy4dhaP1KoLuCCbZiJqJvSO8rD/smHneRbbzmi1EGOxjzYNesFkVLT+df9m6jSArGnhSLy0VZobEcWmzWS1vYzct1QplioIGXwJOwzqrhnLWbClbkVg4SmICsVZxFZpDrpJLfZb6aKEebjE0bkr8VoExdu5eiIyKpCbkXhbOwqaYuTBFpEKYIF6rK7Ff3Nm0EfyCIxNvk8KHbo4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUPjNVMoMn4jZCqRciZ5yH49RkbqIhj3jacIqOU+mAE=;
 b=n18C6mqFGjHHAE6A86csfoZ9Y89HMo4BgOGUBBvosJB+Ki2RilDoztyl8l+wnFq8h0CW/J7rKSc1zm7PV8tKvGv+fymdnuG7mV/3EsxHxb/Acq1EzFNfUbmu6dNl9PZGF18Q3IRos7Bk941kRD/yvTVwhOhYQAdd/GXrMlgfw1hj2ExWjcol01KGzXtenfszpv+WEEDPlZWJ0OyFhzJxpQLtsHDr9EIFK6JevpC8xTYzhwE6wHr6nIAtR2ls7yNy2d1Sv+B5RvBrplbl+k+DDDIGx+rHoZqUGCq1jNWWbStduiuSajRV34tQlnGBcn5VZHhR57Q2hf8odMupsR7RpA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Sat, 16 Aug 2025 00:53:50 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 00:53:50 +0000
From: <Tristram.Ha@microchip.com>
To: <frieder@fris.de>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <lukma@denx.de>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <frieder.schrempf@kontron.de>,
	<florian.fainelli@broadcom.com>, <jesseevg@gmail.com>,
	<o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<rmk+kernel@armlinux.org.uk>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
Thread-Topic: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
Thread-Index: AQHcDGbxOJiAIjJzr0e3AfYWoSbidbRixWKAgAFHF4CAAGnvUA==
Date: Sat, 16 Aug 2025 00:53:50 +0000
Message-ID:
 <DM3PR11MB8736A15C582626DE95429F6EEC37A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250813152615.856532-1-frieder@fris.de>
 <d7b430cf-7b28-49af-91f9-6b0da0f81c6a@lunn.ch>
 <27ccf5c4-db66-491c-aa7c-29b83ebfca3a@fris.de>
In-Reply-To: <27ccf5c4-db66-491c-aa7c-29b83ebfca3a@fris.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DM4PR11MB8225:EE_
x-ms-office365-filtering-correlation-id: 77d9b6af-bebd-4034-8464-08dddc5f5d5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YThZaklaUTYrQ0dCTG9ObzJWRGVQTDJTYVpnNUQyU0NnWUpRL1phaGlDL0t6?=
 =?utf-8?B?S2pGNTQzaW1uVGdzWXdWc0NFSndBcWFuQ1N3VVJ0MEF4RFRIOVVsc3UvK1Na?=
 =?utf-8?B?dWJSeHRydkNhb0w0RThmdlVlR3NNUnpRS1kwU29hckxGR3ZyelJSYXU4Z3pq?=
 =?utf-8?B?TmMxMjJRNEJMZ0JjRGdSU3p1RXo2Y0kvbGM5d0hFekRVaXZtL3VIQThEOXVV?=
 =?utf-8?B?Zkl2ajFBUW1KUlE3OEM3bTdNTHV0M1ZoM29BSzF3L1luNVB3QW5GOFhNdThv?=
 =?utf-8?B?VFhtTmdwT0hTUHdSOXdmR2dCZURKOWd2L2JlVlI4OCtNNzBKYU5KVHY0QmJx?=
 =?utf-8?B?TWJWWnZSZ25IZmlaeVdUdkFVeGVHRTZnT0phMmVqLzFnYXZYTGw4NWpMNmha?=
 =?utf-8?B?WGcrbTVhNGZid2E0RDBEZjdWajYwRy9CU2dkV0dpTHNBQS9IemJYeVpwd2I1?=
 =?utf-8?B?bDhSUGpwdnYzNHFYdVo1UEZiZnV0QWI5dDVLWFRYeDRzVEVSaFFpNzVHZDY2?=
 =?utf-8?B?RmtCNGRMT0E0WXI5eXVURndPZ2MzUG9PSmdGUEJ1KzVadzFaeW9zV2I5RTJY?=
 =?utf-8?B?aHZXMnc0b2QwTkZxR2o4Nm5tZnBoMm9EWnl6U09IMXF2bVBtQlpxTWZhbUd3?=
 =?utf-8?B?ZkljanlPSENiMjJ1cktkWUhZSTB6SzdJaVZNKzJ2Y2ZEbjBXOU1vNmtCdDVt?=
 =?utf-8?B?MjJSNlVnOWdOZlJRTDB4US9MY2lDS2NqR3IyaUVRcFltOEpIWG9ybDJDVU9j?=
 =?utf-8?B?WUZsQ1UwRTVwVE1mSUFzWGs5bWZSVGlZaDNoQ1RuQTJFWHBkeTV5UDVGY3pG?=
 =?utf-8?B?NWliRldINnhqYU5WaWVyMlpPdVdMTXdmNU44U2pPSVVyWlRROVRBNVQrWktG?=
 =?utf-8?B?T3VSUzQ4UDZtZnNQcUxvdVNJSElMWVhTRjFiSnB5QjdFYytFbVRKWlc2bU41?=
 =?utf-8?B?OHJrZDhXOCtKK09BK2hxc0wxZHdkVXZ5M1dSaXpWRzJLSU05VFBhMTdxd1lD?=
 =?utf-8?B?REdTMlhrUkprVUJDeGZ4NXdYdVlEcGwwRmMxN2NOODlEWTg0MXNod2t1Z3lu?=
 =?utf-8?B?WEEyU0lVZEsxVGtJWmREcFJQYTROdDArZ20zRDVRa3RXVVd1MUZMRmNwcDZI?=
 =?utf-8?B?c0xobVdSODdpQmpDT2ttWnkvV1Z1ZUpuMTFRaWsvc2lKRlYrSzRzdFhVbkZU?=
 =?utf-8?B?YWpFSkU1eTV3NTg0YWlxNVNUYk1ESFl2Q2ZCc1RZUHBVTVF5NkloUXg1Ymh1?=
 =?utf-8?B?bndKYjVDYnNlM1NvL0RDek5nVTZwZTRab0ZEclUrZU9ES3MwRTA3T3ptdEl2?=
 =?utf-8?B?STlUeTRLT0wvNzVwSWdvV3lER2x0OWlYL1N2UFBjQmhkNFpWYXlsaEtoZnBw?=
 =?utf-8?B?cHZhYTgvWTRTcC90NVYvR3FQM0pHSU9PejlxeENVcFR2T2RNcHdQQTJYZytr?=
 =?utf-8?B?cTNkMXN5cE5hZ1VhY3M1YU9BRVZsbEZKTGFyUGFobnptRDJtWmE2V1lETVRR?=
 =?utf-8?B?NDhYWmdCZXd3UGtaUlA5ZmYxVkR3enFGNVUxWGFIRVZKSEY0WkZvRW1SMjRZ?=
 =?utf-8?B?MW5KdG1LZ0J5bDBybTd1Z0hZSTdkNURhODdlQWMxcEFsaS9lUmtXcE1kZlpr?=
 =?utf-8?B?eVdyK243VklOcThFTlZ6NlIzOG0yMkxXVTU2a0dTbVY5bnpReEgrT1duS0wx?=
 =?utf-8?B?ZG94Um00WDBWOEJFQUxCSWFuZ1lhWi9rSUx3b1lQdGFDRENwMk8vOVA1YkJS?=
 =?utf-8?B?Ri80aUlPVU84bUdyM1NoTVNOeWNxSjI2YURnVCtTYmdiclJUWVRwdlBoTU1m?=
 =?utf-8?B?RXIvSlkvbloxS0xUQjY5clBZNVVieUMvMHY4dDdLOVE4YisrY0R5SHJwc2xR?=
 =?utf-8?B?YW9nM2NWOEQycmJtTlY4TkZmWExYVXhTaVpkdGpKZU9PUkJ4RnArTC96V25q?=
 =?utf-8?B?TWRaTEZrZXpLRDEzZVE2UzY1TzEvOUZDSUNjRWxJUHNoYVI2UUJQN3ZpM0U1?=
 =?utf-8?B?bVQySWpwMVZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWhTM2dRZVVJNWFMbFFyTVNkaGh0b3pwOFMzb3pmWURQMlo0Sjg4OWg5U3lK?=
 =?utf-8?B?cml0dnVKd0p6ejhjRi96UHdYcTV3TEt2dVJTLzg1cm5CcVA2WE1Bc2cxRmRS?=
 =?utf-8?B?d0FNcnhheStzQWtkS1VrMGhLeGpjZzlla1RId29SSlVNUTRDYmR5eTNsbTNS?=
 =?utf-8?B?dEtGa01ZbEZoQWdodkE2elBPTVZmSzVmL2tpeU5TMXpUTFF4Y285dExrVEp4?=
 =?utf-8?B?VHkzVHAxU2drUUh4TkVsYi9uM2hsajFvN0pDSm15RWJFVUJVaVV6cEp0OFFN?=
 =?utf-8?B?cjJaaitjMXlWVVQyOWEwMnpYb2drQnpoeDFGWEt3ME5iWWEyQUtNbXl1YzRM?=
 =?utf-8?B?eEllWGZrUlNKYmxrdjg2OEE3T0VqajhuMFR3UHVGSjJWQ0FUYlArLzFqemNu?=
 =?utf-8?B?VkVjR2xtZSsyYUVURTIvQU5vTXFQSWVnQjRNYjFSYzlzMERRa2tRR1E0ZXp1?=
 =?utf-8?B?N3lXeDVHdWFINGhnVFNkREgrZC9HWDRjcEgva1ZFZ0Y1VS9UTnIza2t4M1RI?=
 =?utf-8?B?QjFqWVAvdE1ZUHV2Wm04VTgxYkpmcjNETGxHZGZJazlzTHNPdXJrWG92SFly?=
 =?utf-8?B?ZVlSbVE4UTdBRzlIZyt6Z1RuQ0JZL3F6dW5mVml2RzhpNmtDT0g3eEo3QnR1?=
 =?utf-8?B?T0NpdE52MVZjNDVJZktZVVIvNzVKeG5lMkZNalFVLzR3Y2JYMXFpYXc1Wnk5?=
 =?utf-8?B?U1AzYWg0NENGTDNPbEIvMThSV0ZKMm1vaFNDcU5CSFJ6b0oyMkhXVDI0bTFK?=
 =?utf-8?B?U2FFU0NzTExOOU1wdjMyMFg3Vzl6K1czdHhuSm50bTE0d1pEcUpsTzdxZE1Z?=
 =?utf-8?B?M1YrTnQ5bC8wMWRQSnhBNlJNZGVZeW1teGRpTFZVT085ZlNZVWhESTVhTm41?=
 =?utf-8?B?bmgzLzBtN2tINGhzUk1YUWY3RVQ3d00vclhaaE1oSUdhekpFemtQSXkyYWdv?=
 =?utf-8?B?ZmZCMzBwdUwzNGFrNDNLSUFWUEVYYUJIT1Bqa0xtR3dxZ2dNTjlLNVY1c1d5?=
 =?utf-8?B?aFJPTi85UlBkM3pyQWJSS1Yzc1lxZlhtYjRWVDdIUS94dUVpbDM1dzUzS3pM?=
 =?utf-8?B?OVlja1M1ZnFNN1JkV01mM3BaeEYvWXp0Y0RFMVR4Vzh1M004UDBlb01JVkdL?=
 =?utf-8?B?WnpSdEoxWGVhbnNCN050OUhMampqVE0xRzhRNWMyQW1hM3V1dFphazFHMFhv?=
 =?utf-8?B?dlVoejJCUC9YQTRzcGkyWjQ3MVNVMVVZQjIzV3VUMEJocy9nQWVYOUNmenBm?=
 =?utf-8?B?OTJ6c0RtUnhiQU44TmVmcWo0ck9OM3RoVFVLOVJlQ1BxWmZOZzhZZVV3U0JC?=
 =?utf-8?B?akN5R0lVNFJWNWgrR2l5bklUTmg0S0g4MkJiV2Nkd29aa1F2b3BocEZ0L2ZI?=
 =?utf-8?B?QkthTU1xajg0bWJ4bUZzK3Q5endlc0o0b1lJbHVuT0V1VlU2dFBJYjEzUUpr?=
 =?utf-8?B?bmdMRWFscU9XcjlRN3VwUjk5enJLWEdwTmV3SGRyYmdnRkVGM2tmY3JQK0E5?=
 =?utf-8?B?dnBqVUR2akpNZHhMMmVmTzVUQmRrd2x6QytmSHdFMkhSWDVCUUxRM1VWVzNy?=
 =?utf-8?B?d2tKSmY4MFhaYWNSNTRHOE84TGpGMXh3S25jd0Y4U1l0TWJxSlhGRE9UOTZ6?=
 =?utf-8?B?SHg3ZGxPYytIaWhBSW1qeVV6M1ZNUGZBa0pHVzU1eFMvazZZS256NVh5VDZQ?=
 =?utf-8?B?YUNuaTJySjN2NG5KR3NWejJMU2dQNWo2QWQyQkJtUC9YYno4VW9MbURJSEpp?=
 =?utf-8?B?ZEc1WlJFMHErS2Z2QjlzRDRYbE96UDMwQmxvZjVIdmhIOFlabjJjWnRCYmN5?=
 =?utf-8?B?SnFaV3p5RWpYUHdQd0IwbW93bnNIcVNocWJoZURCMkxIYzlhelRtT2srbUNF?=
 =?utf-8?B?bTEyOEU5eVlNY2VjcXhkL0l2UEtLSG40WkJlSFZrRFl5ank2Z3hHVmFvbXl3?=
 =?utf-8?B?MnRRK1h3VHVMZGs0L0lielJqNXMyN21vL09YcFlaZ2tEM094djU0V3FJTmJh?=
 =?utf-8?B?Y2l4ZThhOFM4ZGV0N1Y0ak02SnBjU25UNGIwU1BMWEFObTdlL1BOcDNYNmg4?=
 =?utf-8?B?cEtudytHZE10OURiSCtnQlFoVEIwWjkva05IM3JvaVhLRWNZekxjdmo4NnFU?=
 =?utf-8?Q?ZDKzkQ6KGE1BJPwhoxei0fOsY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d9b6af-bebd-4034-8464-08dddc5f5d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2025 00:53:50.2333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7O6QsfVe4d56ECBMqokBfeP3PWm1YrNPzqEFl3zl1s5vk8ld5DSNcNL1E9Eqj50O8xy8vkGHrsmkQxhatiD0qHVPbUuTb9PsIGfZN60dns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225

PiBBbSAxNS4wOC4yNSB1bSAwMDo1OSBzY2hyaWViIEFuZHJldyBMdW5uOg0KPiA+IE9uIFdlZCwg
QXVnIDEzLCAyMDI1IGF0IDA1OjI2OjEyUE0gKzAyMDAsIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6
DQo+ID4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5k
ZT4NCj4gPj4NCj4gPj4gVGhlIEtTWjk0Nzcgc3VwcG9ydHMgTkVUSUZfRl9IV19IU1JfRldEIHRv
IGZvcndhcmQgcGFja2V0cyBiZXR3ZWVuDQo+ID4+IEhTUiBwb3J0cy4gVGhpcyBpcyBzZXQgdXAg
d2hlbiBjcmVhdGluZyB0aGUgSFNSIGludGVyZmFjZSB2aWENCj4gPj4ga3N6OTQ3N19oc3Jfam9p
bigpIGFuZCBrc3o5NDc3X2NmZ19wb3J0X21lbWJlcigpLg0KPiA+Pg0KPiA+PiBBdCB0aGUgc2Ft
ZSB0aW1lIGtzel91cGRhdGVfcG9ydF9tZW1iZXIoKSBpcyBjYWxsZWQgb24gZXZlcnkNCj4gPj4g
c3RhdGUgY2hhbmdlIG9mIGEgcG9ydCBhbmQgcmVjb25maWd1cmluZyB0aGUgZm9yd2FyZGluZyB0
byB0aGUNCj4gPj4gZGVmYXVsdCBzdGF0ZSB3aGljaCBtZWFucyBwYWNrZXRzIGdldCBvbmx5IGZv
cndhcmRlZCB0byB0aGUgQ1BVDQo+ID4+IHBvcnQuDQo+ID4+DQo+ID4+IElmIHRoZSBwb3J0cyBh
cmUgYnJvdWdodCB1cCBiZWZvcmUgc2V0dGluZyB1cCB0aGUgSFNSIGludGVyZmFjZQ0KPiA+PiBh
bmQgdGhlbiB0aGUgcG9ydCBzdGF0ZSBpcyBub3QgY2hhbmdlZCBhZnRlcndhcmRzLCBldmVyeXRo
aW5nIHdvcmtzDQo+ID4+IGFzIGludGVuZGVkOg0KPiA+Pg0KPiA+PiAgICBpcCBsaW5rIHNldCBs
YW4xIHVwDQo+ID4+ICAgIGlwIGxpbmsgc2V0IGxhbjIgdXANCj4gPj4gICAgaXAgbGluayBhZGQg
bmFtZSBoc3IgdHlwZSBoc3Igc2xhdmUxIGxhbjEgc2xhdmUyIGxhbjIgc3VwZXJ2aXNpb24gNDUg
dmVyc2lvbiAxDQo+ID4+ICAgIGlwIGFkZHIgYWRkIGRldiBoc3IgMTAuMC4wLjEwLzI0DQo+ID4+
ICAgIGlwIGxpbmsgc2V0IGhzciB1cA0KPiA+Pg0KPiA+PiBJZiB0aGUgcG9ydCBzdGF0ZSBpcyBj
aGFuZ2VkIGFmdGVyIGNyZWF0aW5nIHRoZSBIU1IgaW50ZXJmYWNlLCB0aGlzIHJlc3VsdHMNCj4g
Pj4gaW4gYSBub24td29ya2luZyBIU1Igc2V0dXA6DQo+ID4+DQo+ID4+ICAgIGlwIGxpbmsgYWRk
IG5hbWUgaHNyIHR5cGUgaHNyIHNsYXZlMSBsYW4xIHNsYXZlMiBsYW4yIHN1cGVydmlzaW9uIDQ1
IHZlcnNpb24gMQ0KPiA+PiAgICBpcCBhZGRyIGFkZCBkZXYgaHNyIDEwLjAuMC4xMC8yNA0KPiA+
PiAgICBpcCBsaW5rIHNldCBsYW4xIHVwDQo+ID4+ICAgIGlwIGxpbmsgc2V0IGxhbjIgdXANCj4g
Pj4gICAgaXAgbGluayBzZXQgaHNyIHVwDQo+ID4NCj4gPiBTbywgcmVzdGF0aW5nIHdoYXQgaSBz
YWlkIGluIGEgZGlmZmVyZW50IHRocmVhZCwgd2hhdCBoYXBwZW5zIGlmIG9ubHkNCj4gPiBzb2Z0
d2FyZSB3YXMgdXNlZD8gTm8gaGFyZHdhcmUgb2ZmbG9hZC4NCj4gDQo+IFNvcnJ5LCBJIGRvbid0
IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIGFpbWluZyBhdC4NCj4gDQo+IFllcywgdGhpcyBpc3N1
ZSBpcyByZWxhdGVkIHRvIGhhcmR3YXJlIG9mZmxvYWRpbmcuIEFzIGZhciBhcyBJIGtub3cNCj4g
dGhlcmUgaXMgbm8gb3B0aW9uIChmb3IgdGhlIHVzZXIpIHRvIGZvcmNlIEhTUiBpbnRvIFNXLW9u
bHkgbW9kZS4gVGhlDQo+IEtTWjk0NzcgZHJpdmVyIHVzZXMgaGFyZHdhcmUgb2ZmbG9hZGluZyB1
cCB0byB0aGUgY2FwYWJpbGl0aWVzIG9mIHRoZSBIVw0KPiBieSBkZWZhdWx0Lg0KPiANCj4gWWVz
LCBpZiBJIGRpc2FibGUgdGhlIG9mZmxvYWRpbmcgYnkgbW9kaWZ5aW5nIHRoZSBkcml2ZXIgY29k
ZSBhcyBhbHJlYWR5DQo+IGRlc2NyaWJlZCBpbiB0aGUgb3RoZXIgdGhyZWFkLCB0aGUgaXNzdWUg
Y2FuIGJlIGZpeGVkIGF0IHRoZSBjb3N0IG9mDQo+IGxvb3NpbmcgdGhlIEhXIGFjY2VsZXJhdGlv
bi4gSW4gdGhpcyBjYXNlIHRoZSBkcml2ZXIgY29uc2lzdGVudGx5DQo+IGNvbmZpZ3VyZXMgdGhl
IEhTUiBwb3J0cyB0byBmb3J3YXJkIGFueSBwYWNrZXRzIHRvIHRoZSBDUFUgd2hpY2ggdGhlbg0K
PiBmb3J3YXJkcyB0aGVtIGFzIG5lZWRlZC4NCj4gDQo+IFdpdGggdGhlIGRyaXZlciBjb2RlIGFz
LWlzLCB0aGVyZSBhcmUgdHdvIGNvbmZsaWN0aW5nIHZhbHVlcyB1c2VkIGZvcg0KPiB0aGUgcmVn
aXN0ZXIgdGhhdCBjb25maWd1cmVzIHRoZSBmb3J3YXJkaW5nLiBPbmUgaXMgc2V0IGR1cmluZyB0
aGUgSFNSDQo+IHNldHVwIGFuZCBtYWtlcyBzdXJlIHRoYXQgSFNSIHBvcnRzIGZvcndhcmQgcGFj
a2V0cyBhbW9uZyBlYWNoIG90aGVyDQo+IChhbmQgbm90IG9ubHkgdG8gdGhlIENQVSksIHRoZSBv
dGhlciBpcyBzZXQgd2hpbGUgY2hhbmdpbmcgdGhlIGxpbmsNCj4gc3RhdGUgb2YgdGhlIEhTUiBw
b3J0cyBhbmQgY2F1c2VzIHRoZSBmb3J3YXJkaW5nIHRvIG9ubHkgaGFwcGVuIGJldHdlZW4NCj4g
ZWFjaCBwb3J0IGFuZCB0aGUgQ1BVLCB0aGVyZWZvcmUgZWZmZWN0aXZlbHkgZGlzYWJsaW5nIHRo
ZSBIVyBvZmZsb2FkaW5nDQo+IHdoaWxlIHRoZSBkcml2ZXIgc3RpbGwgYXNzdW1lcyBpdCBpcyBl
bmFibGVkLg0KPiANCj4gVGhpcyBpcyBvYnZpb3VzbHkgYSBwcm9ibGVtIHRoYXQgc2hvdWxkIGJl
IGZpeGVkIGluIHRoZSBkcml2ZXIgYXMNCj4gY2hhbmdpbmcgdGhlIGxpbmsgc3RhdGUgb2YgdGhl
IHBvcnRzICphZnRlciogc2V0dXAgb2YgdGhlIEhTUiBpcyBhDQo+IGNvbXBsZXRlbHkgdmFsaWQg
b3BlcmF0aW9uIHRoYXQgc2hvdWxkbid0IGJyZWFrIHRoaW5ncyBsaWtlIGl0IGN1cnJlbnRseQ0K
PiBkb2VzLg0KDQpIZXJlIGlzIGEgc2ltcGxlciBmaXggZm9yIHRoaXMgcHJvYmxlbS4gIElmIHRo
YXQgd29ya3MgZm9yIHlvdSBJIGNhbg0Kc3VibWl0IHRoZSBmaXguDQoNCm5ldDogZHNhOiBtaWNy
b2NoaXA6IEZpeCBIU1IgcG9ydCBzZXR1cCBpc3N1ZQ0KDQprc3o5NDc3X2hzcl9qb2luKCkgaXMg
Y2FsbGVkIG9uY2UgdG8gc2V0dXAgdGhlIEhTUiBwb3J0IG1lbWJlcnNoaXAsIGJ1dA0KdGhlIHBv
cnQgY2FuIGJlIGVuYWJsZWQgbGF0ZXIsIG9yIGRpc2FibGVkIGFuZCBlbmFibGVkIGJhY2sgYW5k
IHRoZSBwb3J0DQptZW1iZXJzaGlwIGlzIG5vdCBzZXQgY29ycmVjdGx5IGluc2lkZSBrc3pfdXBk
YXRlX3BvcnRfbWVtYmVyKCkuICBUaGUNCmFkZGVkIGNvZGUgYWx3YXlzIHVzZSB0aGUgY29ycmVj
dCBIU1IgcG9ydCBtZW1iZXJzaGlwIGZvciBIU1IgcG9ydCB0aGF0DQppcyBlbmFibGVkLg0KDQpG
aXhlczogMmQ2MTI5OGZkZDdiICgibmV0OiBkc2E6IG1pY3JvY2hpcDogRW5hYmxlIEhTUiBvZmZs
b2FkaW5nIGZvciBLU1o5NDc3IikNClNpZ25lZC1vZmYtYnk6IFRyaXN0cmFtIEhhIDx0cmlzdHJh
bS5oYUBtaWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pf
Y29tbW9uLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jIGIvZHJpdmVy
cy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCmluZGV4IDRjYjE0Mjg4ZmYwZi4uYzA0
ZDRjODk1MDI1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29t
bW9uLmMNCisrKyBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jDQpAQCAt
MjQ1Nyw2ICsyNDU3LDkgQEAgc3RhdGljIHZvaWQga3N6X3VwZGF0ZV9wb3J0X21lbWJlcihzdHJ1
Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQgcG9ydCkNCiAJCWRldi0+ZGV2X29wcy0+Y2ZnX3BvcnRf
bWVtYmVyKGRldiwgaSwgdmFsIHwgY3B1X3BvcnQpOw0KIAl9DQogDQorCWlmICghcG9ydF9tZW1i
ZXIgJiYgcC0+c3RwX3N0YXRlID09IEJSX1NUQVRFX0ZPUldBUkRJTkcgJiYNCisJICAgIChkZXYt
Pmhzcl9wb3J0cyAmIEJJVChwb3J0KSkpDQorCQlwb3J0X21lbWJlciA9IGRldi0+aHNyX3BvcnRz
Ow0KIAlkZXYtPmRldl9vcHMtPmNmZ19wb3J0X21lbWJlcihkZXYsIHBvcnQsIHBvcnRfbWVtYmVy
IHwgY3B1X3BvcnQpOw0KIH0NCg0K

