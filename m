Return-Path: <netdev+bounces-149348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9709E533A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6216723A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F91D9A51;
	Thu,  5 Dec 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CVuxBGzi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AB1D5CE3;
	Thu,  5 Dec 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396442; cv=fail; b=FrPp24U2jEq0sXdwnYNcC3Vx37ZbM2xvDCxn9obzze4ADt8miD7I/Q32SVkLF2/ylmQQmCghDINW2XgP/t9QU2BfqdDM5elpXMixz7M/BvcWGcUay9DcFj+eg1IMi5mj7OpPDoFDLb7xRYIfn5o+xuU7IIeKmyogYNsgRGO+Qcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396442; c=relaxed/simple;
	bh=RAJbbxcEJDm8isy3VuKh4hS9oRgsaZTHVVximeioP1o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iw+H0+CZEqITM3KUrv/rtV9w9gHoDNtNNZF6SWVMalYoxcgEgxvn1Ga1OTPmtUNxNmUwvseK7LJfpSJLSDbz69LiehmPIo4GYya+I+Xrcxtd1/lIzZfLVj0ZC+USTv3NOhm1wEbd6/3RTxKqEPuxCWfx7+JxnvhcqLrZJ/kGKGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CVuxBGzi; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEqT+8McT7SE8l8kMHiCOUv0WKiTlqZYxag1HQDfwua4QPLKn3H5Cl5u2nE5dZY78c8OGJVod8TZTP9MLWyMlXCKfuxs6ic9G1Usbr0fi9hKdKBCeUVSL2YEbsM6T5Rn9+RGTaHrZ74KAX8dTWoUmIUWNxki2MlAc32t+nKZeoOgy5BZaAU3Uf66i/0edEJqgklcMFicXixHVwplfmNCPNOdF8q8NJpqy5IiB/a4qafmni0af/JIHG3sb135cfT5pFxj+56pWvxBHSrq6e2zV44U3VMydUCi9FFTZCZe71XMVQGkdO9zjlttFSNISSLmV97fhS/AUH5zMWAzJFJVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAJbbxcEJDm8isy3VuKh4hS9oRgsaZTHVVximeioP1o=;
 b=qjMuWGz1J3u3NYEH9QpvUyTuXxx6xiMEpU0MCnxUphGIE4JCwqQGjOJPy/PaDePq3XnZRWErHBMed5kP9p9knKdmXGwfC/+hRLE34BfmMiJZ5BJfQUSba71/SEGvq37uEyF8hNBh5RDU1AiNBTW0a2Nw4Hr548qtY5j0JPxBj4q5eojqPQEqCGKGFMm+UVqWa9oNcjCrO5FNb243cAPhEtmPYnprpF6ixuIYs1dy2CLT6Wqf4LIlog74SlGwNUQ60EdmOVHzcyzB4Ad9O5XDlNP2X2AXVolWrZ/CpYT1BoK1cps6+GJHNRYYljdbNGC/nxu6r5D+36o5D0GeDU4gCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAJbbxcEJDm8isy3VuKh4hS9oRgsaZTHVVximeioP1o=;
 b=CVuxBGziEXWUtV/FljR8nfsnONZWjzXWlPlNUjOgCEN9jmFNAgVV4Q9CVmo4ABe3dh+Q10ubVY6T9b7b4Fn5I60pxsklHW4zm9LM2o/w+aSUDp61qs7uxsYY+w7nioCTT9zpW6WL+0GVFk+9dJG3sxWe0kcCf/eTsD14agln8MylMVejdcTRpj3fo9LynewSvrWIKuPM8umEe9qm3k78lJrUFYU3L7OqL2OhrGrZiGFhMTNm5Qcdw3ywUP/2o9eZCA5+ncUNoS2e8hZ6KJLWX2TcdGSNCWvOnJvBM7YrN+vAQUgPeOukkswQrV8Jju86k4Ov43KVaw1GrBrad2EQHQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 11:00:36 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:00:35 +0000
From: <Divya.Koppera@microchip.com>
To: <pabeni@redhat.com>, <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Thread-Topic: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp
 library for Microchip phys
Thread-Index: AQHbRWDeoKQTJpwn0UGXX3zNeIOo77LXapmAgAASttA=
Date: Thu, 5 Dec 2024 11:00:35 +0000
Message-ID:
 <CO1PR11MB477140866E76B0FCEFA05735E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-3-divya.koppera@microchip.com>
 <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
In-Reply-To: <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: a718e43b-6ddb-45df-92a4-08dd151c0bbc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXE4YjVPTXliZExHK3BWYXRTSHZZK2VqYUxxRVZxT0xpbHJ0OXZJNHozVmo3?=
 =?utf-8?B?b3c3MHNhUzVjNyt2Wk9sLytLbFBKRHB5VlYvSDdkdmNVdFpyU1ZjaW1GaWdM?=
 =?utf-8?B?YkhqRDFRK1dmb1JiSEdoa3BmR1FIUUcweTBCbW5iRkQ4VFl5WnFXUE9TZkdO?=
 =?utf-8?B?Wm9kZ0cvZUI2b1R6Y1owTThlMTRpYitLNzNsZXdUTDRWcDVwUjF6enNCUmpO?=
 =?utf-8?B?UG5yZmN1U1o3QzIwdGNSaWhuaTFKdGpFeE5JbEN3eDMyODFpREhvd1FDaTR0?=
 =?utf-8?B?Q01IS2VzVFNnY1dKbE1sN00xQ212LzJocXdMaENVNmlVNEUxT2NQWVByNUs3?=
 =?utf-8?B?Y01nSnFhTmRSUUxwaldCT2t4ODk1VWFTNVE5aWoxYXJ4eG1ZQy9WajB2UElY?=
 =?utf-8?B?MVFHaVhVc01ScjE0QXdmd3AzSHFEMkNZSDNrYU10aXZIOVk4a3ZHQmo3RVFz?=
 =?utf-8?B?c3JPbnNTWDNGdEV6Lzc5bWRrZ2JnRGozV0FsOUMxWVllc0syMGhMVlpqajZM?=
 =?utf-8?B?T1FoK0VBTlZXVDEvS096TmYrU1h4dHAycWd6cDlvN25ubDRHdGNUV09nSFBp?=
 =?utf-8?B?RFdrVGcyR1I1VG9ySEhMMVl0dnpNbFZsQ0tKY1ByYmFMZ1NBUlRXQSt5Mmk0?=
 =?utf-8?B?T1VoT1dlQ3R2Wlh6UGhreEI2ZlVxaWVMNDM2L0twSHBQUXlEZStCaUNMcmVo?=
 =?utf-8?B?UUxhN2NQR3M0ZWNVOU5ZNUZwbEgydHBBWGFkSnJmWDNrVW9ubVlBYlhYWjVt?=
 =?utf-8?B?SENkeGhnRzUvQzZyU2V4T2J4TkV4NDJFek1peXgrcGhCcVhhZXYrclplVkRP?=
 =?utf-8?B?QkZNV0h2Q0I5b1E2Y2lRSFFmd1lxLy95Rnk4a0tvdERVclIxekNETjdUb0V5?=
 =?utf-8?B?YlI5ekVyRHh4YUtzYTErV2dYVklUaFJZa3dzRUtRMVNsajA3TDNSNVNCRjBp?=
 =?utf-8?B?T0tVVGxZRmVpRVhFU2xuamlFZUM3bGprNHYzYWtCRUkrYjRuM21jR2l3YWlJ?=
 =?utf-8?B?TjdKZENBdXVDdEovOW9lWDdaNXdUeFh2dXY2NDR5c0dBY1FDQ3dmZjdLaWVM?=
 =?utf-8?B?MldGZUs3QWFucUhLRi96djE4UXJXNXp6VldjQlFBblN3dnJRbXczYS81bndD?=
 =?utf-8?B?ZUJwNkl4QzZOQ01lZTE2cTR5c3U0UXYybTJYQmgwQ0J3RGVOZitEenJWM0xk?=
 =?utf-8?B?dHpMNVMwclIveXMzai90SVd2ZzV4b05lZ2h3MWpFTHVOalg5UURKelludTVF?=
 =?utf-8?B?bDlmNG9tRzJoeE5KRDkvak5WbzVPdFN4OWoraTFiTWxUK055THZtL1o4dUV5?=
 =?utf-8?B?S3BvL1N5ZmYrWlNrRGtvSFpvVkIyY0U0YWJreTN4LzlZOGp3RXp2YUU1ejhv?=
 =?utf-8?B?MHlvSU92cnFhR2RydHgyOU10WW00Z1g1ZXRYSDYrK09aekQ3YUhtemJ0MzNa?=
 =?utf-8?B?aS9peXNMeisrbzNBaXNqakdnMCtYL09qWVpISUVGN3JCdWVEbktmVE5kLy8z?=
 =?utf-8?B?WURoalgvbkwvcHhVRmpRZTk4T21XRU1yYWdUbC9lVk1TL3hpZy9ScjcrWnlD?=
 =?utf-8?B?ODhRV21qc0dYUkF1ZmxTU2NETWlwZSt6YWF2bForSDUwbTVVbmp2RXlYTndk?=
 =?utf-8?B?eS9kNDVMejJaSXBzUlB5N05xalcveGtRWDQ4cUd4dGVCMDJQc0xqMWNhN3Ay?=
 =?utf-8?B?T3F5eU5YS3dkeE5yczJLNE9EUVU4OEpXaWR2bDkySzhBeGNxNmlyV0V1cnpn?=
 =?utf-8?B?a2JIUE51RDRnNHlGMlhqOExTR1BCS1pPTkp0YzlWcFdlNFV4N3BQbFRPRlVC?=
 =?utf-8?B?L3lFSDAvOXBRbk92S2hzZUtBR01vNUszdXpncDR5VVpUUmwyWlY0S0JvcXhl?=
 =?utf-8?B?NzRUWFEyYUxaaDhRbjVwYWx4SVFXbjhKODN0a043WVJ2eGo0Nm9teG5ZSFIr?=
 =?utf-8?Q?GjNtjUOwQLc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkpNdWI2V1QrWjYwSkhZbHhEUTF2N296WUlwVTNhQ2dxR0VRRUsxYWNLT05j?=
 =?utf-8?B?dzFEU045Ym52MWxpRDlzV2Q5TG1WM3BhSklPWnRxZzJRelB3Q3V0ZDhWdVNs?=
 =?utf-8?B?UFVBemthT2w5L1VPOHZ2QTlTTm1MeERxa1Q0bER0SWpndHFFOURCdW90RktN?=
 =?utf-8?B?dGx2aXMwdzQwMkZ3MzJMNVVqbU5QZEpaNDdWdUdDRWFZRGdPM2pEbW5OOTJF?=
 =?utf-8?B?V0xwQjNGd1pTc0tSN0NGcUpNeUxKczRXQ3ZydCt0dFhOVVRFVFQ2R2VUNmhO?=
 =?utf-8?B?aFFyZFdnVTNaUWVULzdHQlBqTXVNcUEwSlhRNTB6YUpTc01RNHlBTHU0WXJQ?=
 =?utf-8?B?a3FkcGk5OVlRanlnaGU3WHNQTVk1SmZWSk9LZm5jam1UeTRKWGcybXdYUnVI?=
 =?utf-8?B?bUNGZXRtYXBxc21QOGNlYkNKR0lkMUxKVlpGa0g4KzRUVXZwNVFqeWJDTEhM?=
 =?utf-8?B?VWF2NG5yS25UcG8xa2dFWDR4SGZKQ01wUVlMRU5aVC9neWIxS21iZkwyODRx?=
 =?utf-8?B?WHdobC85QzM0a2VIaXprS29CSEQwdEFkS2FFcDloU3pZUzVoeWV5eGlHU0Zp?=
 =?utf-8?B?YTVvc24zVnRhZDQ5ZlI1VnZ6Z0VqK21GVVFYYlJFSmpBbzZHNnREdE5RY0ZN?=
 =?utf-8?B?WTZ4eTFpRHhWOTVFaXlKS0l3QVpLMmNLam1Kb2luak9jRzNUb3djaXFwTnBt?=
 =?utf-8?B?OTdWdDdJaHN3T0tUaDNSMTZaSU15Z1drbWhsZTYvdUhkUHFqUlhyY2VOV2Ft?=
 =?utf-8?B?QWJSN0trNTdRTzVScnlJa3Jhekt3KzJraEszaXFvcDhGM05TRnpLRlJWOWdO?=
 =?utf-8?B?bGV1RjRlYkkvakdXeWhvTkFZZ1VCeWhPWlkxaXd4WGhsS3NzRjNRL2pjQSti?=
 =?utf-8?B?a1lockFHS1BmWVZVZTdIMVFzTUV6bjFPVUFLQ3k4LzhOaGxMOWlmTDN5MTAv?=
 =?utf-8?B?MVI1dlZzUFVnV1VtbktId1VSMXpKaHdaOXIyY2FhUy9CVWplaHRlVTVsaXZr?=
 =?utf-8?B?aENtc2dGZ0J6MVlna1R2WG1OU2Z5cTNDL1htUmtjYnhxRkw2RXNQSkNyY1ov?=
 =?utf-8?B?blFUalpaWnJHK1c5M25PTisxbUhMb3E2T3d1UXNtRE4vOXdNNUE1NDVsRUg1?=
 =?utf-8?B?ZTQ0ckVPOEdCMnVOZTZjajNodW9nR3JTWDRwSm9rTVhxWXVQWU5icTRROUQ0?=
 =?utf-8?B?ZTBDbld6eHpBQmZaRnlrZmgvZ3JTaFBEUzJTQWRJdk9LL3haSWFmVWxUNEJv?=
 =?utf-8?B?OGJMcnRiYlRWYTRSWmdsRXZNQkl2VmhUQUltUlRnSWFONmxyVnR3clhHVm5Q?=
 =?utf-8?B?RGxGOXRNVTlLdk1wTjlDc0xCNEFtTDgxWEl2VTVYdzZXK2hnaWVCc1E1MmJ4?=
 =?utf-8?B?UTRIMmJhbGVwOTB2d1JsTGJLNXRUS1VmeENleUJtRjZkUGswVWs4WGV0dGo3?=
 =?utf-8?B?aGQvbmE4Y1ZUWVoxVFUzMnRCemRKNnZUZEJnd3R0VHdmTFRpdmI2Z09Ecm4v?=
 =?utf-8?B?UFlQNitsdnl3dDF3cndZNXRWRTg1UUo5STh5WjdIUXJ1NWowekRPS0c0cFZS?=
 =?utf-8?B?UmZWWkxKaExzWUtaMUVlTjhUM2xsVkFZVytqenFmejVMWHN6bGovR3ViRG1k?=
 =?utf-8?B?dU5VMzVQSXBBbUhBS2p1YkNBZUsra3VyOTUrY3pJUlhoVWFRb2g5Mk9mc21I?=
 =?utf-8?B?S3VVa25sa3dCRC9tNTB6VTUyU0FsbzJRTTcrOGZQd2FBM2ZDOHlrU1RBSkhk?=
 =?utf-8?B?SVg1TVMwVDNlZ3M4bmNZVnNYcHpEelE3VCt5ODZaeXF2OHR1Y2YwUW5ucDRF?=
 =?utf-8?B?SXppSzBGbUZ4dDdTeXFvTGZ0d3FNVm92bmMzUE9HUk5yQUtrQXFjMUI2TG14?=
 =?utf-8?B?b3l5TU9abERGMWozU3dmTGh3ZWtxYlNFays4RlR2NTArcXFSd3dXN0pYQ1hv?=
 =?utf-8?B?TkVzTVNxU2RrV2hiZDRzNWVUcDFFVTlhU0lHWTZua1d3TVIxTWdlejhaYklw?=
 =?utf-8?B?UDQxZFlYemQzZUZBRkZTSFFWWW1WSzdaNlFFME9TYnRZNUFzcVpUdVdpOHhL?=
 =?utf-8?B?STJtR1JvNXd3R3NiNVhnNU1NRytFYW9RWkc1SFdPVW13L05lRGQ0OWMycXVx?=
 =?utf-8?B?Z3ArUmZlWThsV00xTmdwaVh3d0NaVE4zclhmRFR4czBzd0srelJkS29oVmY0?=
 =?utf-8?B?SHc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a718e43b-6ddb-45df-92a4-08dd151c0bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 11:00:35.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZU9a/su0omM45uQ4U2qyGXXXsNzyqqD0/3s4ByNrAl6TgbO+SdK2r03I0PsIQE5Jgk8bL/hRrqphWX4brv7aSEaGWnBnpDgt87LofmzXZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992

SGkgUGFvbG8gQWJlbmksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA1LCAyMDI0IDM6MTcgUE0NCj4gVG86IERpdnlh
IEtvcHBlcmEgLSBJMzA0ODEgPERpdnlhLktvcHBlcmFAbWljcm9jaGlwLmNvbT47DQo+IGFuZHJl
d0BsdW5uLmNoOyBBcnVuIFJhbWFkb3NzIC0gSTE3NzY5DQo+IDxBcnVuLlJhbWFkb3NzQG1pY3Jv
Y2hpcC5jb20+OyBVTkdMaW51eERyaXZlcg0KPiA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNv
bT47IGhrYWxsd2VpdDFAZ21haWwuY29tOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGRhdmVt
QGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGt1YmFAa2VybmVsLm9yZzsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
cmljaGFyZGNvY2hyYW5AZ21haWwuY29tOyB2YWRpbS5mZWRvcmVua29AbGludXguZGV2DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjUgMi81XSBuZXQ6IHBoeTogbWljcm9jaGlwX3B0
cCA6IEFkZCBwdHAgbGlicmFyeQ0KPiBmb3IgTWljcm9jaGlwIHBoeXMNCj4gDQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTIvMy8yNCAwOTo1MiwgRGl2
eWEgS29wcGVyYSB3cm90ZToNCj4gPiArc3RydWN0IG1jaHBfcHRwX2Nsb2NrICptY2hwX3B0cF9w
cm9iZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCB1OA0KPiBtbWQsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IGNsa19iYXNlX2FkZHIsIHUxNg0KPiA+ICtw
b3J0X2Jhc2VfYWRkcikgew0KPiA+ICsgICAgIHN0cnVjdCBtY2hwX3B0cF9jbG9jayAqY2xvY2s7
DQo+ID4gKyAgICAgaW50IHJjOw0KPiA+ICsNCj4gPiArICAgICBjbG9jayA9IGRldm1fa3phbGxv
YygmcGh5ZGV2LT5tZGlvLmRldiwgc2l6ZW9mKCpjbG9jayksIEdGUF9LRVJORUwpOw0KPiA+ICsg
ICAgIGlmICghY2xvY2spDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsNCj4gPiArDQo+ID4gKyAgICAgY2xvY2stPnBvcnRfYmFzZV9hZGRyICAgPSBwb3J0X2Jhc2Vf
YWRkcjsNCj4gPiArICAgICBjbG9jay0+Y2xrX2Jhc2VfYWRkciAgICA9IGNsa19iYXNlX2FkZHI7
DQo+ID4gKyAgICAgY2xvY2stPm1tZCAgICAgICAgICAgICAgPSBtbWQ7DQo+ID4gKw0KPiA+ICsg
ICAgIC8qIFJlZ2lzdGVyIFBUUCBjbG9jayAqLw0KPiA+ICsgICAgIGNsb2NrLT5jYXBzLm93bmVy
ICAgICAgICAgID0gVEhJU19NT0RVTEU7DQo+ID4gKyAgICAgc25wcmludGYoY2xvY2stPmNhcHMu
bmFtZSwgMzAsICIlcyIsIHBoeWRldi0+ZHJ2LT5uYW1lKTsNCj4gPiArICAgICBjbG9jay0+Y2Fw
cy5tYXhfYWRqICAgICAgICA9IE1DSFBfUFRQX01BWF9BREo7DQo+ID4gKyAgICAgY2xvY2stPmNh
cHMubl9leHRfdHMgICAgICAgPSAwOw0KPiA+ICsgICAgIGNsb2NrLT5jYXBzLnBwcyAgICAgICAg
ICAgID0gMDsNCj4gPiArICAgICBjbG9jay0+Y2Fwcy5hZGpmaW5lICAgICAgICA9IG1jaHBfcHRw
X2x0Y19hZGpmaW5lOw0KPiA+ICsgICAgIGNsb2NrLT5jYXBzLmFkanRpbWUgICAgICAgID0gbWNo
cF9wdHBfbHRjX2FkanRpbWU7DQo+ID4gKyAgICAgY2xvY2stPmNhcHMuZ2V0dGltZTY0ICAgICAg
PSBtY2hwX3B0cF9sdGNfZ2V0dGltZTY0Ow0KPiA+ICsgICAgIGNsb2NrLT5jYXBzLnNldHRpbWU2
NCAgICAgID0gbWNocF9wdHBfbHRjX3NldHRpbWU2NDsNCj4gPiArICAgICBjbG9jay0+cHRwX2Ns
b2NrID0gcHRwX2Nsb2NrX3JlZ2lzdGVyKCZjbG9jay0+Y2FwcywNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwaHlkZXYtPm1kaW8uZGV2KTsNCj4gPiAr
ICAgICBpZiAoSVNfRVJSKGNsb2NrLT5wdHBfY2xvY2spKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gKw0KPiA+ICsgICAgIC8qIEluaXRpYWxpemUgdGhl
IFNXICovDQo+ID4gKyAgICAgc2tiX3F1ZXVlX2hlYWRfaW5pdCgmY2xvY2stPnR4X3F1ZXVlKTsN
Cj4gPiArICAgICBza2JfcXVldWVfaGVhZF9pbml0KCZjbG9jay0+cnhfcXVldWUpOw0KPiA+ICsg
ICAgIElOSVRfTElTVF9IRUFEKCZjbG9jay0+cnhfdHNfbGlzdCk7DQo+ID4gKyAgICAgc3Bpbl9s
b2NrX2luaXQoJmNsb2NrLT5yeF90c19sb2NrKTsNCj4gPiArICAgICBtdXRleF9pbml0KCZjbG9j
ay0+cHRwX2xvY2spOw0KPiANCj4gVGhlIHMvdyBpbml0aWFsaXphdGlvbiBpcyBjb21wbGV0ZWQg
YWZ0ZXIgc3VjY2Vzc2Z1bGx5IHJlZ2lzdGVyaW5nIHRoZSBuZXcgcHRwDQo+IGNsb2NrLCBpcyB0
aGF0IHNhZmU/IEl0IGxvb2tzIGxpa2UgaXQgbWF5IHJhY2Ugd2l0aCBwdHAgY2FsbGJhY2tzLg0K
DQpJZiBJIHVuZGVyc3RhbmQgeW91ciBjb21tZW50IGNvcnJlY3RseSBwdHBfbG9jayBpbiB0aGUg
Y2xvY2sgaW5zdGFuY2UgaXMgbm90IGluaXRpYWxpemVkIGJlZm9yZSByZWdpc3RlcmluZyB0aGUg
Y2xvY2suDQpSZXN0IG9mIHRoZSBpbml0aWFsaXphdGlvbnMgYXJlIHJlbGF0ZWQgdG8gcGFja2V0
IHByb2Nlc3NpbmcgYW5kIGFsc28gZGVwZW5kcyBvbiBwaHlkZXYtPmRlZmF1bHRfdGltZXN0YW1w
IGFuZCBtaWlfdHMgaW5zdGFuY2Ugb25seSBhZnRlciB3aGljaCBwYWNrZXRzIHdpbGwgYmUgZm9y
d2FyZGVkIHRvIHBoeS4NCkFzIHdlIGFyZSBhbHNvIHJlLWluaXRpYWxpemluZyB0aGUgY2xvY2sg
cHRwNGwvYXBwbGljYXRpb24gbmVlZCB0byByZXN0YXJ0Lg0KDQpJbml0aWFsaXppbmcgcHRwX2xv
Y2sgYmVmb3JlIHJlZ2lzdGVyaW5nIHRoZSBjbG9jayBzaG91bGQgYmUgc2FmZSBmcm9tIHB0cCBw
b2ludCBvZiB2aWV3LiANCg0KTGV0IG1lIGtub3cgeW91ciBvcGluaW9uPw0KDQo+IA0KPiBDaGVl
cnMsDQo+IA0KPiBQYW9sbw0KDQpUaGFua3MsDQpEaXZ5YQ0K

