Return-Path: <netdev+bounces-159505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9499A15A9C
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A28168901
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1F7485;
	Sat, 18 Jan 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZOxcfblA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096D4A28;
	Sat, 18 Jan 2025 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161357; cv=fail; b=p8V7h94P6TUfRVK48wC5Uxim42okPeTj0734Gcw7gG8gLZ4wTxxE4l82LAFzI1DqplWTj5sbJZq3NwwPQvyXBOkDgSpM2O8T4DoIHoNkglhxnbuJqcwyUepqNKBlUKGt/h8byU/VEsIVNkz/E66PHErGsiwiiIV2K9vRFLQLFg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161357; c=relaxed/simple;
	bh=ABOTjuSb1jlu1cWuaPSVYAhlcSl4AgwzPfdbhzJlBc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=es0dmzAx/GxkMB6RQnHgpX5+QqSdhyx2H/SMNWJVOTR2puG3SkGKG+u8nvohEivuHHW1/PfrZomvd2mB3cC0Za20dKxhklXp7kY0OOlM5v64AkkS0nnpB6KBQ7OKj5MGF5kK30S4tTsA9CDvPvSgrehvb848olvLcIxk7rwj/bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZOxcfblA; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJDiKALkRU3iOaplhMSCE6yiiAv/M6Kub5By0pIzlx8/N00XUWI9Q6FMU2AsN5tmXHXo0MBTWR8f1HneCPvZitQPSSGSQAtA3iG21TLuMnuXEL0tQGQUwYsr+gLuzg+PLchU+G3VbeZa5Yc+NDw2Di7BCJjpE44WL7o8h26CJjJcjsisbOErlz2kMmNQjzvepJjbOvkPA/Wz6RrjtaCef+eRAi79uf9sPPUeACO71t6che1nK1AKYzdhcLKq+B7aPCyXm+abo3ZejXZn2gT735GOhOwecN4Un17n8UQc+49QNWXAulAwMVOEcfLrXq1411ElCWlWyqiuyguSEBJK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABOTjuSb1jlu1cWuaPSVYAhlcSl4AgwzPfdbhzJlBc0=;
 b=eG41AId+uDXDm4WilE63R4ekP0IZt97pfKOmIVBvIx5vtGKJUPaxYMFijp/72pq7gwVt5nGCie+x2kbFORheC7bv7pWuO5LRQNhCuYdr1+X+uZy/8JgMeAP/39SR/d7OzArjGK+CG4ym5NQEPql0lRnFMitzhdybZoVPRqlHabzJNH96iv2/AW/A316AUmSU7Fi9oazr0telNzhyrkRUUwp0vmsNcOJVfYBsyr3qtZslev/TZ/DIpp7xEUjC+Bc3qwuusTqSF7jMzenViclO4Y2uLtnjlYIVTs1Z5goo656ABFkd4Q/nnqUz7QdTOVhsW8Klqxa9jEjQKxOgssEHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABOTjuSb1jlu1cWuaPSVYAhlcSl4AgwzPfdbhzJlBc0=;
 b=ZOxcfblAW2uDPWCHcqlCC/C24wcP8TVffUGyRPtVYmMouZ8HeiXOs062L15E8SwLMK054tiHO0oeHM5yX1ufxxgtkHghfmE+Yn9IjgiQlT54XhLmOzXIznmnzrIFwp41qD0eGVGbXvyOJDZ/6YrOIrpHVIi2ixlIbqNA5Nq0myTSAf4w6Ql5YsmkyIQx12/CyONtWNTCUuMe0bd0VeM0fuSXuXtPfrt+mJ549n1O2S6fvFBHqOVxO7dZjIyBL9R285BFujteXjMxJ97z3b/XXUPogQKwEapsI3GdfHF/Hee8VM7/Q6QEQlAWIh7DlYjtA2WzY0Cz+/y7+Ns/g9h8og==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sat, 18 Jan
 2025 00:49:10 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 00:49:10 +0000
From: <Tristram.Ha@microchip.com>
To: <tharvey@gateworks.com>
CC: <Arun.Ramadoss@microchip.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<olteanv@gmail.com>, <Woojung.Huh@microchip.com>,
	<linux-kernel@vger.kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: RE: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Thread-Topic: [PATCH net] net: dsa: microchip: ksz9477: fix multicast
 filtering
Thread-Index:
 AQHbTPIKP6fOA0qWjUGHDotcQ0fDfrLjUxUAgAALoYCAFyxhAIAJ+m0AgBJEcACAAofrgIABCazwgAAIC4CAAYawAA==
Date: Sat, 18 Jan 2025 00:49:10 +0000
Message-ID:
 <DM3PR11MB873600D47EA64FF199EF0FE0ECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf>
 <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf>
 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA1PR11MB6219:EE_
x-ms-office365-filtering-correlation-id: 558305e8-5b53-48c7-958a-08dd3759ebb5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VG41VVBxRzc0SWZTZWEydnFYTERDM2FWRGI2cHBITjlTR2hVRFNXUjhpVGp0?=
 =?utf-8?B?NjJ2QVhvMURxV1pmek1KTEFDcmZNeFArbnpvRHMvNkNOcHhUQVdWLzB3UXNi?=
 =?utf-8?B?R3M5ZXdvM1ZpODFZN2FIS0NOWmdLQVNleEdCajcrV3JtRTVhcTR3UnlNMkZj?=
 =?utf-8?B?MkgvVGlxd29KM3JPeVNMR3RQekdiVVpodHFqNWZVVGorKzNFUjVhcnh3NW5t?=
 =?utf-8?B?ZkEraURRWkl6V2x0Y1BIQ1ozRGNlZTEyUlYwcnFsd28wVDZ2ZDhnVTlHZ21h?=
 =?utf-8?B?VjYxVWx0QTlTYXpkZmwyQmtaNjZudVU2T0VtRmdvRE5ValIydVRaTDFGaHhT?=
 =?utf-8?B?eTFGWUZ6V3hNRVc4UlQ4akpudXJKVzF1aWs1SVJwczB4V05rSEg0Q09hc0FX?=
 =?utf-8?B?bU11Z3dIVkg4Q3h6NjFySWxqbFZUMCtLdzkrQ0ZRWGNwU002bzJJN1hnZy9p?=
 =?utf-8?B?TmpWeGVrc0IyRnJGMWVqRys4dk1oTUgwWXZRalQvWVpOQSsxemxTeGJlcWsw?=
 =?utf-8?B?cUhiQzhlUGZsTHJ2Z1E2Z1BndHNiK0ZneXpHWi9SSjZmTFZMYU1JYUpLSHR4?=
 =?utf-8?B?QlkvRDNlbFQzVTJUQkJrVStKM2UwRkhDTFdraVczT0lFWFJHQTJKd0VTTzl6?=
 =?utf-8?B?ajRic3UzYjZpa3lhWndhT0RvM0NtQTV1azl6cFZxZkRkMEJZYlhBTXdqNk9w?=
 =?utf-8?B?Rkd4VThUb2VqMU5lZW5OSmtVc1JhdTlSb2xuQTB0RXl6TE5rUiszWGFlTWtP?=
 =?utf-8?B?VENFS0l0ZCt0YlMrNmZNQzBVeDZHOWtSam4rWFJBbWNHY3Yvbjh5Q2FmWjNI?=
 =?utf-8?B?d1ZvN0V2ZnNWT0I5NFNZRzRmZms0SGU2dHN4MUo4OGtJdVZaeUg1Tm9MWTlq?=
 =?utf-8?B?anJjNXpYb0d6TVhnaWxzQyt2QXo0UmYwdCtZVTNKZUh2TjFKUEVlWTBUMUxT?=
 =?utf-8?B?SWdaSWo1NW5ZZ0tpa1NVMy9OMkdBUm52UXZYeENXaXdFcDBYbjBSS2czeXFi?=
 =?utf-8?B?d0NzeGlMRlZxZTlmOGVSMDVYYW5UUUo3aHpzWlRHc2FzZEZvT3NYUHFQL2lF?=
 =?utf-8?B?MitqNCtaZlhjT25DNjNXa1JJNzRQWmJiaFRRTnpuR1YvaUswRDRGM2p2aGVs?=
 =?utf-8?B?VlZranZEWmZrK3NGMTZXUmFBRWhkcU9NemNIK280L3Y5VVZCbjhRTjFRUVJ6?=
 =?utf-8?B?MlhJUnhueHZObE5Bb2xrcjhjL0xvQWY2L1lObndmZng3VXJJY0NLUVg5dUVj?=
 =?utf-8?B?UTRObmtoQ2VESm5qTm1KNlp6L1Y4UGVpUmVZb0FudEw5VFlXZFdDbWg0Vnk4?=
 =?utf-8?B?SkdicnlQOVhLSHFzYVhKT2M1TWR5djV2N2R0S2RqQzBDRSt5SXRtWEVjczJk?=
 =?utf-8?B?WEd6L3JCODJsMUEwQ3F2cndvU0NVcE5nMTUzV3ZXU0FobUtid2xVeUM3MjQx?=
 =?utf-8?B?TkduS3lkMTJhUFpzT0JRUXRDZVByM0FaUDVvS0xZRXBQbmNHLyttVDBzRDBy?=
 =?utf-8?B?WmFINGwwUHI1SWl3L3k1SmhsYWtXS3hIa0ZNdyt1aEx5ZCtzWTdxQkcyQXBh?=
 =?utf-8?B?TEVmcmJpamFZVzBYUzR2ckxMYjJibUZWV0xPNFB5bWJPSkt5T25uYlZ5S1g2?=
 =?utf-8?B?eVZEODdaLzFUOGYzUlg4dVNvM21sZTRjQjFmQ1lCNUJvN2VNZTlvb3RiazNN?=
 =?utf-8?B?Sm0zVVc1VkVJYXZxSnlKYk14Ym9sQ21SaUp6TGZYL05tNERlV2I0VHZlWW9z?=
 =?utf-8?B?ZGh4dzJSTVB0REZYcWRmcG9NZ1hpZHVZamJESURNR2oyZ2NOZmtTTE40YkIv?=
 =?utf-8?B?MStjZk16Z2NScE05b3BwTGxxdDZQMWhTRk9YcTQvYXZTMWhINS9lMmNlcFQv?=
 =?utf-8?B?TEZjVE1uNWVaQ3R2N243dkJtcE5wQmFsck1kRElBWEJQV085TEhQZUtTTXJ6?=
 =?utf-8?Q?+cyVsGwAZBzLD73gFV12423Trt1Iwgfy?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDFBSUYyV1lyUXFWMkl5cVJNd2Z3c0lHcEdvRmRLZU15NVdKOERVeUpOSWRL?=
 =?utf-8?B?YjV2bDU5MyswaU9ITnpzcVNhUzZmTStRRys5eGtBb1BSYUluZXgyM3lwN3Bv?=
 =?utf-8?B?aDRTV0Q1Y1pLaDZyTGNaak1nTzArY05oWlNWNXZYN0w0clFMM0R0NExYZlo3?=
 =?utf-8?B?M0t2dkl0SjIyNE9qZGlmVW1sQ2tERmhmYkd3dWVxNHFTbTg0d3M5WG4xRHhl?=
 =?utf-8?B?M1EwSWFzQ0hXQTdEcVNlZ2llZEI3NE1jcGVjMjJCZGp2c3prdURoR1QwQkI4?=
 =?utf-8?B?ZzVvZG5VY0haNkhuZU5EUzE3d1c4R3p6ZGpOTmk5ZGZFZHlYVUF3NEhaYk1u?=
 =?utf-8?B?Y0lxM0hNY3Z2Rk82bzc1TmNKNVJGNVJJR0dRNTMyS0VTMVp6VlFEQXZlSDho?=
 =?utf-8?B?MzhhNWIweFM0NzlIZVpzRmVtVm4welltRU5LZTlYWGwrcFAzWXFzYnp0OGZ6?=
 =?utf-8?B?RWcvTGtXSzFITXp5djJqUzlLUWFjeHp1UmVpTktJOFd0czBlS2xTUXJyQjVX?=
 =?utf-8?B?WEowVEFKandxVWxIR2NNajVhN2NlMHNyaHFtTTRpcWcyeGxBRWFxQkJZSUNR?=
 =?utf-8?B?M3IxRzI0VHk2NUVLN3FSOGdxK1ZvNVc0aCtMSFNueC9aTDFRR0NaNm5SUEZo?=
 =?utf-8?B?SEdzY3gveUtMZEducmZCZGRZUExDTFRlUEpOUkcrWm9BWlJGSTN6d21SelBF?=
 =?utf-8?B?bkZBQmp2MWVIZmFydkdKWU9ZRjJ3UjhoTHNKOTJUdzBGUWZFdkRWbXNua2J2?=
 =?utf-8?B?UHkxL3gwM0FCMnNscVlhMzJyQUMzMjNFWUprUi9DZG1zS2VOOCtmaVNCeEVU?=
 =?utf-8?B?d3YwaUJOazVRd0Ura0RMWmk0NjZ1WUNnTzFlZm50U1FoUTc4eW1DNm02TUhE?=
 =?utf-8?B?YlFqY2M5NlRsMXhkTVYvRHRrSHd6T296T0ZHR2p5eGI2TmlYMkpOWmVFZzR2?=
 =?utf-8?B?TlpuMmdtT3hocDdiTUdxT1ZRN1BQMWpwNjczQm82YUFsUU1xYWlTUklHdDAx?=
 =?utf-8?B?Z3htYkMrRlpiYisrUjNkZ0w4RnJNcmJxcERUUEM0cXk4OGVGU0tMcEYrTXRN?=
 =?utf-8?B?KzZTVm82OStFalJZUlBEdU1NQWVKb2diM05lTEJVS3lXVVNEbS9rZmpLSzdq?=
 =?utf-8?B?bUhIbDM0cUFaVjhLNHBXUGk4dnlLNitlYkZYYkxUaFdNa2tkU0RHY0Yzc1dT?=
 =?utf-8?B?aWpMWjAvTlJ6RVZpT0hrbkhRYUViek5NSjNidzlLc1ZncUp1L0FmRjd2WnpK?=
 =?utf-8?B?MU1LYyt1M0FTR2dXMHVjMmZJREVLbUJ4U3hNQkpkVEMyTkh1SjMzSU44bjNo?=
 =?utf-8?B?Y0NyQ05KcWJHNHFIQkd2cXI5M3o2RjR0MmFudFZGOWk3aXFsUlA2WnZvM2pl?=
 =?utf-8?B?cVFqZWU1UFdGS1hxTGNodm1SQWhiVVpiWHZmc0hiQ1VHNy85cTdleHVhbmpP?=
 =?utf-8?B?b0ZJV09udExkR1REQ0I2dGUyVU1BeUlhWGtiL0NEcmJXTWxKV3FTSTkzTng2?=
 =?utf-8?B?a2d3NjlReHM1QWNUMXRQSUc5eGdER0RPZ1pMWmRZLzJaVkg3L3haSHlabGlZ?=
 =?utf-8?B?QUk2U0F4OWZRMG5tTzF3QnV0b1lZN3NhVW91eGw3US9pQzlHN0tBc2w5ZlhU?=
 =?utf-8?B?UkR2RlJ3V3RHcHh0dHJMRkZnS2xoc2cxODQrdHF4ZTZza09uNVdIK05Sb1FW?=
 =?utf-8?B?ZzFqRWU3M1ZCdXFGTzc5SThHdnUvb0JSczdSVFgxZjh6akZFQUxseldIYXhC?=
 =?utf-8?B?em5XbnUra1JKc1RsYUo1U1BKSWdiRWV3aTA0MVpsdHUrSEFFQWtpeXovZ0sr?=
 =?utf-8?B?MmNwcWZCcFh6bmc4UTdXeVZTYmFPZHR1NEgwVFVRUi9PMThsKzJiZ1dIaWhO?=
 =?utf-8?B?Y052VmljTTFmdHhhWDFIK2cyeEtWUUs0RXlQcFVNdVFOalRyOVN1UTdLYjlI?=
 =?utf-8?B?djlQVGswSFRMYnBVUCt1YmxCdUJLdzk4YWFNZnJMdVdwZm9tUmlUOHpVb2Zl?=
 =?utf-8?B?bzBiUm1sRS9VSzJTb29OMktsUTl3Uk9nOCtTM1A0VGs1STlWNG02SWhXU3pD?=
 =?utf-8?B?d3NlYTYwQ3RmRmlLSitVY2I4Mi96NWNyb0xVaEJiU2ZMMWZOQ2x1N3BaUVc4?=
 =?utf-8?Q?z8yxIrb6JUcGp9hW4BHcFn+Ia?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 558305e8-5b53-48c7-958a-08dd3759ebb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2025 00:49:10.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LERQ4pZge12WA3mOd8cIPPtjZdc0eaKRERjT8H3tgSzpZT0dJB4kQTDqDil67M0UQJhq3u5+wXPGcvxZtk5UkVa1zcQTaIrk1UxzFCG18qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219

PiBIaSBUcmlzdHJhbSwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCj4gDQo+IFdo
YXQgaXMgdGhlIGJlaGF2aW9yIHdoZW4gdGhlIHJlc2VydmVkIG11bHRpY2FzdCB0YWJsZSBpcyBu
b3QgZW5hYmxlZA0KPiAoZG9lcyBpdCBmb3J3YXJkIHRvIGFsbCBwb3J0cywgZHJvcCBhbGwgbWNh
c3QsIHNvbWV0aGluZyBlbHNlPykNCj4gDQo+ID4gVGhlIGRlZmF1bHQgcmVzZXJ2ZWQgbXVsdGlj
YXN0IHRhYmxlIGZvcndhcmRzIHRvIGhvc3QgcG9ydCBvbiBlbnRyaWVzIDAsDQo+ID4gMiwgYW5k
IDY7IHNraXBzIGhvc3QgcG9ydCBvbiBlbnRyaWVzIDQsIDUsIGFuZCA3OyBmb3J3YXJkcyB0byBh
bGwgcG9ydHMNCj4gPiBvbiBlbnRyeSAzOyBhbmQgZHJvcHMgb24gZW50cnkgMS4NCj4gPg0KPiAN
Cj4gSXMgdGhpcyBiZWhhdmlvciB0aGUgZGVzaXJlZCBiZWhhdmlvciBhcyBmYXIgYXMgdGhlIExp
bnV4IERTQSBmb2xrcyB3b3VsZCB3YW50Pw0KPiANCj4gY29tbWl0IDMzMWQ2NGY3NTJiYiAoIm5l
dDogZHNhOiBtaWNyb2NoaXA6IGFkZCB0aGUgZW5hYmxlX3N0cF9hZGRyDQo+IHBvaW50ZXIgaW4g
a3N6X2Rldl9vcHMiKSBlbmFibGVzIHRoZSByZXNlcnZlZCBtdWx0aWNhc3QgdGFibGUgYW5kDQo+
IGFkanVzdHMgdGhlIGNwdSBwb3J0IGZvciBlbnRyeSAwIGxlYXZpbmcgdGhlIHJlc3QgdGhlIHNh
bWUgKGFuZCB3cm9uZw0KPiBpZiB0aGUgY3B1IHBvcnQgaXMgbm90IHRoZSBoaWdoZXN0IHBvcnQg
aW4gdGhlIHN3aXRjaCkuDQo+IA0KPiBNeSBwYXRjaCBhZGp1c3RzIHRoZSBlbnRyaWVzIGJ1dCBr
ZWVwcyB0aGUgcnVsZXMgdGhlIHNhbWUgYW5kIHRoZQ0KPiBxdWVzdGlvbiB0aGF0IGlzIHBvc2Vk
IGlzIHRoYXQgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIHdpdGggcmVzcGVjdCB0bw0KPiBMaW51eCBE
U0E/DQoNCldoZW4gcmVzZXJ2ZWQgbXVsdGljYXN0IGFkZHJlc3MgdGFibGUgaXMgbm90IGVuYWJs
ZWQgdGhlIG11bHRpY2FzdA0KZm9yd2FyZGluZyBmb2xsb3dzIHRoZSBzdGFuZGFyZCBvcGVyYXRp
b24gd2hpY2ggaXMgYnJvYWRjYXN0IHRvIGFsbA0KcG9ydHMuDQoNCk5vdGUgS1NaOTQ3NyBhbmQg
TEFOOTM3WCBhcmUgYWJsZSB0byBwcm9ncmFtIG11bHRpY2FzdCBmb3J3YXJkaW5nIGluDQplaXRo
ZXIgc3RhdGljIG9yIGR5bmFtaWMgTUFDIHRhYmxlIHdpdGggaGlnaCBlbnRyeSBjb3VudCwgc28g
aXQgaXMNCnByb2JhYmx5IGJlc3QgdG8gbm90IHVzZSB0aGUgcmVzZXJ2ZWQgbXVsdGljYXN0IGFk
ZHJlc3MgdGFibGUgYW5kIGxldCB0aGUNCkRTQSBzdGFjayBwcm9ncmFtIGVhY2ggbXVsdGljYXN0
IGFkZHJlc3MgaW5kaXZpZHVhbGx5Lg0KDQo=

