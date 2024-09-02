Return-Path: <netdev+bounces-124077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ACE967E28
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21846B213F2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 03:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6762811F7;
	Mon,  2 Sep 2024 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s7tSPRzI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4E2C80;
	Mon,  2 Sep 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247940; cv=fail; b=RjvE67CcyJ+4H74uxY05JQG6+wQ0DOkJbY8dqHYnQLTAkkezfwTyLhV5LpqFUL2/LDLL1HEXcdTM7Nq/V+cRQUpC8COiTBk6i/t+rKK0X2gFLjZr4o1wKVTQQ3RuM/uxgZ1pl/l6PAysatcYKGKQx8OQ4eAogFLo6Fk21YNerlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247940; c=relaxed/simple;
	bh=p2Q0EcvqZoEIJ67ZvblxYO5DCL+ozF472x68FlOiBJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QzGQo4mtdACIf+XZc/PYmrZyjzfT38nZZ3GISc5zzqat40MKKnYVODGQJR9IGllIcRGi0NagYaD8zlo7k1yyqo+7ZNWoWvgLnw3lasbMrsM4JlAHDWkfl70xRTpb62DvR9i6E+PVn4NO6EfEijhzsaxlFmIu6px25kWgrY6d7LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s7tSPRzI; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF89EHaHfotvi0Dklx9+y+6nWwdTifhw/2TRG9lfqSW0+ELLOAWX5fLMOA4FNCDzfKQ20gTj2PR76ddb1IxAkyCzR6VRZzmHm6WugpS1Z6Zu4PBIgNjYoQOZYg1PhxPwgYFvAw5QNvTe4Z3FNt7KtPTNE6wPcSKRgxf3UHfYGJ2/hFC4e+oFKQY32W5xXzR6+Fvc+8ZLZvtNd4NE3LwLhfwplYkC/04JXcLgW/QP/aw9Yg1pHlevJ4j79upQiZiYUjPYRxDxHUFrMJOuSYt3MN0LIeBRu7bXtGpIbC16/zQnCzCJFcG+OaO5vC16Qdf8bwUJ6ZeGGwbZZ+b41ZUQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Q0EcvqZoEIJ67ZvblxYO5DCL+ozF472x68FlOiBJ4=;
 b=U8Cpsw4byIxWMZMj9yS6TE36RBAicC2IBehaeXBDhEHea0o/N5CyVm9iRGCvH40vMmvRJxpxBLL4mW+e3aVZ/HPNC0IsMwu62rhJ4YWeXeaO/XXkuSFVXDJO1yKUv1cR6Y7SfjQLudda2cm+axvuaQ7uZ36xEUw292EamgBBmCmNfnI4/tVH4yMRybsO/psLD3qqzmNPWBHRjyh83qhIDC/WoQGtJVYMLPq0ROT739aKPaXX5nggzlLsFfCGw2sFTY7f97scNwsWp2tb1zybJ+yH7XN/ZD95QmwMwd0+hQSS36VwO7RHPWnLfvd5rAg9Q0BF7cb4EoPQ2HiSrnd48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Q0EcvqZoEIJ67ZvblxYO5DCL+ozF472x68FlOiBJ4=;
 b=s7tSPRzIqjuck2tkTUPGxfX7XPs+3qjsgkzN/K3FOOcaaavqTUKdp3H1QjthnlOCJMp7KWJYkeZZ+AnZ2sgLFWe+++oXI2o67qazJLrgyCq43NEHAsbE+h10s7M4pbrdDJfKeKLufZUD95K1x67MoG7tdwpKZT5Davqv0K5MiuvIv9z4UfwLZy0tI9MWNLrpWwwwPVyhOcPGlNeSwEoS4aIRXKaIgD7S3qc6kdMPDj4UhVEmsgE7zXaEQkhvwqmF40KJREQmBqp5f/Emp04ImCp3Yg7BufhQdnL+OHPX1NVQrVtnlcVXWGhyQOv+GleGP7mTxB/QqVVq9/beku1W6w==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 03:32:16 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 03:32:15 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<Tristram.Ha@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
Thread-Topic: [PATCH net-next v2 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
Thread-Index: AQHa+ubDwewIOEWJBUyTMdMV3/rdT7JD3EgA
Date: Mon, 2 Sep 2024 03:32:15 +0000
Message-ID: <efce22790603dff9cff21eaf39f74b6a4b5d4a97.camel@microchip.com>
References: <20240830141250.30425-1-vtpieter@gmail.com>
	 <20240830141250.30425-4-vtpieter@gmail.com>
In-Reply-To: <20240830141250.30425-4-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|BN9PR11MB5306:EE_
x-ms-office365-filtering-correlation-id: 71ff79cc-0573-4bc3-0db3-08dccaffd760
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bERodVpvWXl3eXY5M2duRDU3cEROOFdsNUFkenRnYkJzVFpEZnBncVJqKzBm?=
 =?utf-8?B?MlR5VlM2cHREYm81a080RlUwb1BqUlZ2ekxZZUUrUGVjMUN3M1ZyYXRQejE0?=
 =?utf-8?B?U1BBNGZTMldpdndqbDYyNjlWR2E4bi9FUzBibWZVK21NdGJKQ3JQYi9KN3Rq?=
 =?utf-8?B?UmY3K3VIQnZNQWtuR25yZkpjSFZBY29UbG1GdFFjdmZGWmpHMlRKNTFsaW96?=
 =?utf-8?B?NzVtbHhPM2JpTlZjUUZNT1RWQ3pDd3RVa2c4am9LRkFiK1BFelk4VkNxVFRJ?=
 =?utf-8?B?V0p1d2RWdDBpM1l1MXBCd3JVYnlvcnlxTWVVSi9qUE5VckZQTW1wRW4wMDdt?=
 =?utf-8?B?KytUcmlmRHVCNWdZTDVPMEFXWHVoUGF4dXFMN1ROUExFSXdXN2hKZGk0TjAz?=
 =?utf-8?B?Zi9TekYzSUU4cVNqczJnV0NmVnErWmYyZ0dGd2k5NHBmU1FsTVRLN05yR1pU?=
 =?utf-8?B?V1l4QndscWtNY3ZHN2gxOFJUK0xmT3VlVVVLZDF2WWNveW5ERmJjV292bWhV?=
 =?utf-8?B?U0xPdVlrejdGYU1LT09US2NKck1JTElINVlqZURGc1k3cGVMT053VG5zY2Va?=
 =?utf-8?B?T0YyRHBTQVlCU2k0aFRhbWZ4YldNYzF4MUx2UTRvTTZiSldVb0RVUUhEWDBB?=
 =?utf-8?B?cmNqUUFkWXozRzhpaXliTUhYTExVNzJNb2JzeGF5L1dBTWlkb3grRlpyb1I0?=
 =?utf-8?B?VXhqbGRwL0gybEtJKzlPYjU2NHB4MGp4NmhvM05UZ0g5eTdCTW5UVkV4OFJV?=
 =?utf-8?B?a0xQS3NJYm1KQllBbTdaOTdZb3JZRXp4S3dUTExGM0ViMVpwSHBFOXpWbmNQ?=
 =?utf-8?B?U0huMzNITnBESlpLb2xYbXhlYmhnU2ZYL01zVmRiaHg1SnhWUHZKK0xxY0RV?=
 =?utf-8?B?dFczNWtMZ05RTzJyL1N6YXdpU1U3S21XenBkRlI1eWhJWVlDYXlmbUdKei9X?=
 =?utf-8?B?K3o1VytCQjlxaS96cHJtSWI1d3NidEJzVmpTR2o3aUdSb3NGL25hREJvMTEz?=
 =?utf-8?B?N3RVRi9pRExtZFJNSWpWU2s4QmlaYTFnZ21BTlBzeU1abjMrSlB0OWVoQ2d4?=
 =?utf-8?B?cnhpT1Naa0xWMHVLc2tWeW4rZEw5Y253REI3ZVNyMWRUbGNmU2pXMnQyeVAx?=
 =?utf-8?B?V1ZCWXM0MjhoS1Z6L0pVekxaRmp0a3lGNUtFQTgxZzVlVjVVZGNsd0ZOaEJt?=
 =?utf-8?B?aW1qWXpRKzBsODhjRlJzWGNwcmVWa3p6TTNqS01MTEJrVkFhVTFRaTlNWVJJ?=
 =?utf-8?B?VVllVks1WnluR2l6SUs3cG4vNzRGcDBiaTd3YXFGZkQ4OVBUTDhjdmJHdW9w?=
 =?utf-8?B?bXVhdWRjWlNHYkRaVzA3VFIwa25ZTzBHamNyWG0rRlg0WXZXckkxbGo1S0pF?=
 =?utf-8?B?WmhZcDNqMlRKZzBwaE9pMjNJcTk2WFliQ1RvWm12VjE5VmVwSXRzQm84clo3?=
 =?utf-8?B?VkIwSlFnQW1ZSm1RVG9veE9tcWdzK21sNlVJbFZUeWJpTnpuRXRvdFczcmlo?=
 =?utf-8?B?bjQrM2ZZYXpnU0licmRLb0NYZ090ZE9Lay95Rmd2K1BWaDdCK2VKYjlLQ2tN?=
 =?utf-8?B?REl4U3ZaQ25ZalFkMWN0V2h4cW1uUUV1Ry9ZclhxbHI2cmtQRTZrMC8vajJj?=
 =?utf-8?B?SmlBdjlEb1cxSzE5dGFDZHhJUnVBaFlXYUUzMUphMzdKeFAwaDNoalBJTHJE?=
 =?utf-8?B?UThKV0lZRWhqaHovb1ZhSmQ4ZXpyeFIyMEhaS254TFJJcm10Z200RmZlc2hz?=
 =?utf-8?B?elA2cXV5TjVCRE5NNmF3elpid2tUeUJDYk1vVExiaEhYRkN4THFvN0VvTy92?=
 =?utf-8?B?Yk1nR1J1dHk5TFpoZzg5aFdHV0tqNGxnNEVuN1dMRkZPRloreW1XVWxFeGJ5?=
 =?utf-8?B?WVdGeSt2UVBISXllTjJlOEtBeHFqZHE4YW5TZHljUmQwQnhoNjl5TnVaYUxY?=
 =?utf-8?Q?79rtiTQnVKs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dU5DSFp0VlJSRU8zd0gyajA0azJKRWhJR1FqeUFma056OFpkZXh6MFBaRUpw?=
 =?utf-8?B?WGsxUWhrV0FpdkxEL0oveW14TkgwYmJ4bkw5UUVKdlJKZ0lYRnhod2RHZzBL?=
 =?utf-8?B?UEgxN0l5cG5hMzVCWTZRQnhqcVo1cGVxeXhhKzJMTFRCclhOdTVleWxnNDBD?=
 =?utf-8?B?MzVWZ3MrSjV4VEhwb1gvdXpSMnRHam8zZzY3WFVXdHkzTy9aNkgrZ1IzL3ZT?=
 =?utf-8?B?YmY3cHQ4ZjRucFlzV3p4Q01wOUloUmh6enU5ejJOUkxTeDQyMllobWdXWVRX?=
 =?utf-8?B?OFpvbDB3c1dvY1Q2OU1wTWtlbzlnd2VDVDdONUFkVzY5bUY5eFJBS2V4dmhi?=
 =?utf-8?B?YWorVVFET1BRZ2RiSDhHVUNFODhsbVowR21jYkQ0T1dZVTNmS20xc1JKUGNa?=
 =?utf-8?B?dE1CSTZEWSs3TGNwZEU3NUVybmZOQlVsY2MwakhMYkxZaHpBVjFUUkQ1SENK?=
 =?utf-8?B?OWRyQ0NEa1pEdlBTQkswRm8rZlptU0hTVWxnZXltZTdQRFpFZlh5NFVMTWV2?=
 =?utf-8?B?WWJVNHdrTTBUWXdmd3NYdEpxb2N2MU1zRUVHelVJQklEbXFPMlFSNGs5SnNY?=
 =?utf-8?B?bm5mMEgyZEVFQ1N5VW1nalppRlkvdm84aFBQc3RoNXgwWmx0RFJ4STR6cUs5?=
 =?utf-8?B?OEswYjdTcnZiMmZOUEFNM2l1YWxaWi9YblZhRmRDMU9iZ3RidGlaM3c5a3Uw?=
 =?utf-8?B?UFhZeHJmdEdFbzNZT2s0dFk0M3k0Q3ErMWk5SWdYVjR3bGNBSFk5UmVKcHE0?=
 =?utf-8?B?ODErYVBBWE1YbDVJMnlranFEMW9BYW03Rkx1cytPTnFLMzhzOEFYUndOV1NP?=
 =?utf-8?B?SkVMZ1hmR2E3Z2YxQVJ4RHFoREFzVjI5QTMzN1E3NkR4SnNyLzdsTHY0dUg3?=
 =?utf-8?B?c0lGb2Rkb3V5a3JVS0pPdkp5ZjZheDYwbEhHY3h1VkxhMjdlWDNraitET1NJ?=
 =?utf-8?B?WDVkQVAwWkxBYm5EdDFFeGtpdUFUbDIyVWdLczVabkphN203UG9nSUIwbm41?=
 =?utf-8?B?NFRxS2hHN0xxRjBTYmlyc3ptNGZTSWJWN2MzeXdSUGMrVytGd2Y0SXB6ZnBT?=
 =?utf-8?B?WmdCS0ltQUZPOGZCT1AxR0pKQW04bFFOSFNha3Q1ZHczRHpTMWtIVE4rVDZJ?=
 =?utf-8?B?eHVFZU1qV2Q4WHNmd1RtVVJUV0Rwd0IvcG90eGZ4TFNQcytFZ1lwREVSaEYz?=
 =?utf-8?B?VXFnK1p5eW55bFZrSVZrOHN2UGl4a3dRUDRhSnBOOVRQTjNnWkR5eUUwVGdv?=
 =?utf-8?B?MkpKWUFPcWRKWFVjZ2QyM2p4Ry9hdW10TlhwMk4zdVpvdzNRWnlUL3JUZVJz?=
 =?utf-8?B?MGhMaSt0MVRxcFdjWSswT29RRlhtUENZdHlvWWg3bFlyMGFUcEV4aGhtMWVV?=
 =?utf-8?B?QzNQMDZ2aUwzNmE4b2ZjemdrWkV4aUgvc0JFUjArcnEwYmEyd2xEdmxLMFNQ?=
 =?utf-8?B?Y1NRVGNSTSszUmpDckdia0VlZjZybGVoTmRXK1I4a0kwWTdEcnozeTFqK1l2?=
 =?utf-8?B?QnNzbzkrZlVPcHJXRitUWDhGdWZib3pWTjNIS0JBVzRmbzdPVVp4VXo0SFY1?=
 =?utf-8?B?V3lTbkpoREZ4bDduYWV6T0N2UUlXZVlBZ1pWcVljOU02YmQyUWF5SWkrWmE4?=
 =?utf-8?B?RmFYSXVMQXRQNzR0M0RPZFQvejVQTk9CaVhSdnJBUGN6ZFlkTW9ua0xPREpp?=
 =?utf-8?B?ZlJqQVp4d2JZVFFzZS9QanJ4bnlDTzR0VGVnbVo1V1A2KzVOVlRuSlFIUlNm?=
 =?utf-8?B?S2tMQ1JwQlVWQVY2UXZqVFFST09GamJvb0E0eFVwVUdiVS9zazRYWXhQMWhr?=
 =?utf-8?B?WEtrbjNUejFZU200aVRaYjRUYVprcjh2eFhoNzEraHJBR3ZJazBKODI2L2Rk?=
 =?utf-8?B?NmpYYWRzSE9nM3YxNWJCZHpMY0NGN3c3U29vbmMyRFRhd2RLMkprbGVTRGtp?=
 =?utf-8?B?cWVhbUF6SkdKclJpWWhZTUdaUTV1ODNvODZieHpDNlhQckRMZU9uemp1dVpJ?=
 =?utf-8?B?WVNTWllxOWdSV2E0cmpDa3VHeHRCTS9SdzdTQVhPRWYyQkZtMWdiZXUrQTJj?=
 =?utf-8?B?NzlncWhqQlJ1bEFiL2NwamRVcS83cm5jWmZrd1kzSnFIWGhLN2dVWVZVSk5r?=
 =?utf-8?B?YlBsOEFWTlhudmc1QkppNVJuZzhhUFdrMUpEYUFHWm9HQmN0blFwa3l3MThK?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B65368ADF71448A27A818DBA68DF47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ff79cc-0573-4bc3-0db3-08dccaffd760
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:32:15.8126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvyokWIgQAdYjPJr1vFczePdSZyAPoxDli+PlGh9RKjPzWVZzZsRv9n210ahYetiy0iLxBxx16SR/ORPHgrXdzUSj/yLwCei83JCAes6dJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306

SGkgUGlldGVyLCANCg0KT24gRnJpLCAyMDI0LTA4LTMwIGF0IDE2OjEyICswMjAwLCB2dHBpZXRl
ckBnbWFpbC5jb20gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPiANCj4gRnJvbTogUGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vy
bi5jaD4NCj4gDQo+IFJlcGxhY2UgdXBwZXJjYXNlIEtTWjg4MzAgd2l0aCBLU1o4ODYzIA0KDQpT
aW5jZSBLU1o4ODYzLzczIHNoYXJpbmcgc2FtZSBjaGlwIGlkLCByZXBsYWNpbmcgS1NaODgzMCB3
aXRoIEtTWjg4NjMNCmlzIHNvbWV3aGF0IGNvbmZ1c2luZy4gQ2FuIHlvdSBlbGFib3JhdGUgaGVy
ZS4gSSBiZWxpZXZlLCBpdCBzaG91bGQNCktTWjg4WDNfQ0hJUF9JRC4gIA0KDQo=

