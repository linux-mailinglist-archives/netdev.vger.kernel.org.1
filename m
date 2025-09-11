Return-Path: <netdev+bounces-222328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD1B53D8A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1105189A524
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57902D8788;
	Thu, 11 Sep 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4mbla2LG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551671DA55;
	Thu, 11 Sep 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625100; cv=fail; b=aSDSXMAIljI5SgP3neiATV2tBvOpUqzTgc0sQPF3CM/dJmy08eAqNKx+MFp0+DcS7WScBvsV4XDO1xgHPkrhsLA0ZR0zIW4tFbiGmo+A//XPhU5FSzSg91qhuUPbsvx+5i9LRl01JBwaC3h5ugQOQNtjXp0YWKfFxcNPTT0ZF14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625100; c=relaxed/simple;
	bh=e6d+VHvKsF00soq5NEEP4fCk+FrbIcTK+jfimY8Fd4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VROsXekViYLnusuErPmKvdCrDyyxiz3Y5Susb5C+F/qUb0E2XccfFwvRb00VLUJn4SGVHXd894/vp0LxwztVwzT2TyAAUqIR3xFo6/LOBZ7pWLMbWy7ukyEe4KMoA2Un1+tATV/i7M/1fQiRnFwNLfo2dcrvevBJ2Up/XuW7Q70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4mbla2LG; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCdpmr7bN6uUCSKXSU8LlZ5Q7lr9KF0wEGv1wJARclRIJAtZQ5gFFOi0AXGS/FjABudcy/KPHG8uTJOZMQa8OYWf1ZVyRUthXhBME6cenYpodPqNW6PKmUD6FR6bOracuXCiCBDqM0dzHj/eTl0xExjhYC6LokqZvsQ3VsWmyA3WgQW4XOvoclJbT32J/tY7X4+GEhB+J66nPLwaV3dROGxKiGzyw3H680lpLaLX499PApiheum7E8TXIXR8pYC9/3Siamqu3gE1RLmrzMGSFp2vRDyP/XWrjvCQcEoLRbl14J0Pj2liiGMLANHtrvpoT2oKRjjT0CN3fATLZHNwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6d+VHvKsF00soq5NEEP4fCk+FrbIcTK+jfimY8Fd4U=;
 b=iQ08mTuJTkyCA3rKSBklzmLIas0d1bsvKGsUFfx3I+VV+Qhw69BAOIwDP+Twocxige0QkfIv2iKM0mH9zveDoNiaWBTtWMjmi8L+cEWslypYjEESLDChPah+mi2ui78xPuLnVkewIT0YSL74DR4JUfiP7sSLbiJFE34xmmsotTpWq4yALDcR+yIYluitgQir03KOOoSK2v9f/bvUUp1fLeOEhj1ZB7jd/7cZcQYxPZs9JQ3cnlFy2DqKITCmZBl4l/P5ETN8guHIo5LC32UVY800zq9h06X+CvixUTVaLe25oRsyYO7KUg4h9ePd5AadEj6X+QAswdQ0EhaoosBFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6d+VHvKsF00soq5NEEP4fCk+FrbIcTK+jfimY8Fd4U=;
 b=4mbla2LGPkhNjaG9u982eGyvq4nDOQb9fz/dhWfTZiQdwQLMtKd4/aEZGQUdwi1mkduhuULEw+8DpN8KM9bfm/TTprYFt4Nbvd7LgSVQoGonimmPWuj62ODSdBDa4VWg4nHpFyhZV3/TSoM8ljH9vnAR9vDeQnjUVZFgEoRuazzvC9PchRjGk8Yk9QIZIfNHhXFPRC0UCdKMQn5zT15OggFqB9tI6OBcavjtOcQ2xScLwfSndBko2y/q6Iem9CIX+Eo9ebw4tuBqr8qkrG43rv0ro880kZlGyAxADDPaHX6HtMjJW0q6skHxqVV3w5QP7BM3dPMcXF3TOXQJa4U0Ag==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:11:33 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 21:11:33 +0000
From: <Tristram.Ha@microchip.com>
To: <bastien.curutchet@bootlin.com>
CC: <thomas.petazzoni@bootlin.com>, <miquel.raynal@bootlin.com>,
	<Woojung.Huh@microchip.com>, <pascal.eberhard@se.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
Subject: RE: [PATCH net] net: dsa: microchip: Select SPI_MODE 0 for KSZ8463
Thread-Topic: [PATCH net] net: dsa: microchip: Select SPI_MODE 0 for KSZ8463
Thread-Index: AQHcIlPnFyyQv8DZ50KECFfamsKQ3bSM+YWggACJE4CAAPmBYA==
Date: Thu, 11 Sep 2025 21:11:32 +0000
Message-ID:
 <DM3PR11MB8736FE9FB85FC264B6399849EC09A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250910-fix-omap-spi-v1-1-fd732c42b7be@bootlin.com>
 <DM3PR11MB87367B6B13B1497C5994884BEC0EA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <85faa80c-0536-46d8-8f3a-00ae78499fd0@bootlin.com>
In-Reply-To: <85faa80c-0536-46d8-8f3a-00ae78499fd0@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SJ2PR11MB8585:EE_
x-ms-office365-filtering-correlation-id: 1e820790-33be-45b5-1ca6-08ddf177c8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlF5NExPWUw0WCtKOUFiUVB6VGJvV3dtcGY3Um1lZzFsRnBESlEzTVlRTnIv?=
 =?utf-8?B?dkhpNDNHcVVzZ3lGMkVkY2ZWTGpMcGRaTHQwZWR2akpWaVVqUzdLdnJxK1NF?=
 =?utf-8?B?V3VrSjdhQ2dpTEJ6c0hKTkozY3hQSmo5bkMwSWVEMGk3a0kvY2ZrOXI2cFJX?=
 =?utf-8?B?WlhRd085ZTRjcUFqVFVyTWoxMFJuVGo3OXFpbFo2ODI0QWwrdVkwVStpM2dn?=
 =?utf-8?B?MWdCOEV2SnZTbml4Tkh5Q0U5QUlscitKRXJTUkJOa3dwdERCZi9RaDdEbGFh?=
 =?utf-8?B?aU5hVTRSZmRDb0psd3htaHhRb003a2puc2hiTmJmcEhzeGZiVFZTbFJMNVFY?=
 =?utf-8?B?b3ViUFNKeTZyb3BLemhGU0VXK0NHY0tUMEJvd1ZRRGpGbjJVVWRYNENaSERS?=
 =?utf-8?B?Q1hWOUM2M2pKb212c3VybUdDSldMeFdUcC9naU90NWxod1N3UWhrR2dDcUJL?=
 =?utf-8?B?TVpGSWpvY1MzZmRmUmVrTUxla2xSZ3k3SDVWUFRCckdHeURIeW1vYy9LYk9V?=
 =?utf-8?B?NXQ1aU1GTURFQVlManQzM3doWmIvNnNHZTFlbFlDcGJ4M1NORVRuSnh1Z1l5?=
 =?utf-8?B?cTYyN3FNaWVMN2t3VWNmdUpXWWhKVS9XajRabkdQRzVXMjdqQ1lia0hNVzBa?=
 =?utf-8?B?SXJWQVZ2MXgyNWhLY1FSb00xa3lZOEh4UTBxdUgzU01SY3RVekMyNVhvV2Mz?=
 =?utf-8?B?ekV6VkRzTlVzVHprZ0tYTGFjckdHcjkxWjF4WDJtbkdNM0EweFVvUEVMYmlp?=
 =?utf-8?B?U0FvWFJGQjkrdkR5eWZkMHhuTnk0aUtvY01weHBhRS9EYU4xSTlWWU1kbzI4?=
 =?utf-8?B?OWRiTDR1VzBLWHNENHNyamtyeWtPa3ZCRHVpSE5jQUdyM3FaQU9tZkFqbml6?=
 =?utf-8?B?eXJ4R01NNFU0em0zWnNEbUcxTzFCSHpNR3d1NzlZZnV5NDZvanduSStWejN2?=
 =?utf-8?B?WUNzUlRFb2JzbUVFVGZFTElpY3VLL1FCR09RblJFOG1VUzc3MHRKcm9LaWNo?=
 =?utf-8?B?cmpBZWFVekhteVdpUk1scmpocXdUaCthcE5pS3RnYUk0eEtFMzAvaVBqRkRI?=
 =?utf-8?B?WjVrOTh5ZDZLVVVITUZUd01ycXM2OUl3VUUxRXM4NTJDcFhZekJPYlpLY1FG?=
 =?utf-8?B?NVo5MVN0TVp0ei84TVNwelQ0Qm9rY2NRUEo1WW8rQ2UzK1hibjdBOFFVZVE1?=
 =?utf-8?B?Uit6eURkSnhRRytvajlUMGY4eUxKdTNnOEdDSU02S0F2b2lTWTQyN2FOekxt?=
 =?utf-8?B?R3ZBN1pabWdUWTlVaTFxR04rVVpNWGh1dUpWT1ZIVnp1ZndxV3gxYm5qQ3Vt?=
 =?utf-8?B?bTBJL09CaXhJRk1nSStjMTRIOHBDWUt5RG1uN1d2RDVUejJVcDZmdjRaMGh4?=
 =?utf-8?B?bVU3bnBvVHdzZGpHSThJK0VYN0xXZGdRSHpFSUY1T1VvbURwM1o1d0Z2bXgz?=
 =?utf-8?B?eklaeGRJbjhVZ1NmRTJTLzdKdnpmbzM0dFJJeWtBSnN5d1FUTml4WEZIaDBW?=
 =?utf-8?B?OEdIUTgwR3Z2MnVacjQ0cEhRN3VYSElZR2t2VXBpdnk2R3ZXYjRpc3NlUnAw?=
 =?utf-8?B?RXpKNllQb0ZyN2JXMXh2YmNGK0JuQ3pPU2R6MXhZTlVOMW12Q203QU44SGc2?=
 =?utf-8?B?TWNGaUR1SDI4bi8vVk1uZHZRK2h0TVJYRlFGclVrbm9ZMWtsQ3FRNUN3WWU5?=
 =?utf-8?B?WmlxZDlNRnZXNHUyREdPSVl1TVUwOEM5cldUTkhSZWxKa3BvSGlJRlhLYWRD?=
 =?utf-8?B?Z0xMenFNY2pwZlA2L3hhL3oxSnVhV3h3SHhEbkROV0l6bU5BL1lEMDBTSmZY?=
 =?utf-8?B?KzdHYWpoQWhPSlJLS3UwYTNsRW95NTNlclduVzZ0QktpOXZtaGNuL0JJWjRS?=
 =?utf-8?B?T1c0dUx3U0daWVlGK05jcURCVEhoaGQ3RDVwL1Z1TnVZeitLTjBVM1JxV1h3?=
 =?utf-8?B?K0dneGV4bFFpYzNTS0k4VnF6ZFVIRHA3YkhoZVdXVmZnOVJaUVF2Q0ZqM0FZ?=
 =?utf-8?Q?AaG51499yS0nDtQMlRtCUQaWKWnvDU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWUzYzBtblptMzZIckRkQ2ViSE1neVU4eDgzWHN3dUxsMHUrVVJaUW0zVTR4?=
 =?utf-8?B?bDVMK3g0RlBqVGpUSVF5cWs5WWtiTlFyQ3ljWW5XSnBoUDMvT001OGljOS9q?=
 =?utf-8?B?SUY3Y0d0NU43bm42N1lPeUJXR05iZDRnZ2cyQWgyUit0U0xHUGJJMUVWRGNQ?=
 =?utf-8?B?Rld4eUlRZ2NsTU9FMGdNRVNmdmtNV2NWQkUxaWs1SHdXNzI0cVZsWm9nek1B?=
 =?utf-8?B?WEFEY2Y3emN4VTdkTk13amVpVjhGbjNIaVNDRmRiYk15SHVsOGl2SzhIOVF6?=
 =?utf-8?B?OTk1UG11Si80czRTWDZ1ckp5dlZpa0xqTm1xQkhRdGFUT2NTVTNGMHdLSHlh?=
 =?utf-8?B?Z1NiTHRhNEx3TVJrWjFoSXN4Q0FWUGhvS3NEbm5vby94T0FTUmJIRk1GeWNm?=
 =?utf-8?B?aXl2SXo0dWRyU3ZhSVhrR0pzd3hCdWg1M3RyUnR3cm5xVFlHcWE5dHhIMi9V?=
 =?utf-8?B?ZDBWZTNwTEprS01MaGFTQkYwN3pMb0orM09oalZIeEg1VElvRVAwUzFkSjRZ?=
 =?utf-8?B?Unp1KzlxZ2VHUlptY1ZUS1B0Ync2Yi9KbzBpZTNtSHV4QmpkU3pXS1hIRlE0?=
 =?utf-8?B?dzhLM0pORVpYMWF4cFF6ZCtCcmVxbGZjb0hWWUZpNXRTN1ZiVHE2MVcrS3h5?=
 =?utf-8?B?azZVQlVBVFFzUG43RjZxczZEYVRoOU1KR2tTdXNmRHY4T1dRbDEzVGlzMlgz?=
 =?utf-8?B?NXBTa2hxK0I0ZXBHRkdEdWJJeis1b2NKbG5XcGVoalRhTEk4MVJDSFZreWk5?=
 =?utf-8?B?RHFaR01yZlRhcktyRGtaRXhkMWVzQ09wQkhjQ0lweW1CQzRKQnNzUkgyaHJC?=
 =?utf-8?B?UE1xSUlMcG40dTFlNGdqcFJoMTJMQjc4T3d1UFJWV2tXT1Fhd0pVT21aaTZB?=
 =?utf-8?B?Tm45azFvRmxqNmFtYzFUMzhFajdxYmwxZEhnNmd2T2dFeUpkdjV6bFRvZVd5?=
 =?utf-8?B?U0VvVGt6NTRvdWVDNjJQQ2pNejhvMjZjZ1oyc2dpNXJjQUt2WWZUMG9Bb0xy?=
 =?utf-8?B?R1F5azRuQjNIdDZndkZ4YkN2VUdxVkw3YzhBMDNTWDhjaVdBelRMWnJCQ1NZ?=
 =?utf-8?B?S3AvSHdYLzFSY0I1KytlMWpCZWVvTnR1TUg2NElqakFhTzByZ2NoRVo5a2Nt?=
 =?utf-8?B?NEZaZEtXQ3JxT2ErZlVUV3FsYWtIbnBxeEdEVFlENVpRSnQ1NFhVMis3NXV4?=
 =?utf-8?B?OWgyeC9PU0lkd2x4bTBaZ09Ickp6OVlDb0FVNmN4a1BJaU5xbVFTYldSZ211?=
 =?utf-8?B?RkVTTmRUNGV2NDdmcXdGSUFid3hNQWVJQ08wRkk3QlFSQ3ZEb3FhV1ZKZVN1?=
 =?utf-8?B?OGRxSDJnMklOemRwalZDdmd4NXdMd1pURHlPTlpIenFUbUE3clRRV3ByaDVl?=
 =?utf-8?B?aTJCcW4vcjAzNUpFNDFCcDFXdUlZdjNDcDZscndLcFArc2lkVStjdHRqdGU3?=
 =?utf-8?B?b3Ard0xSSDErdEQ4bUtnZGRVM2huRGVjVUtFRThrT2lLbTFYYUdhWWYwNmZ6?=
 =?utf-8?B?RERzY2I4UUFBSDBTYjZIQ0ZzUEFnN05JMllkb1VXZHVxaTVmL1lxUk5BY2dN?=
 =?utf-8?B?STNZY2tSRUtrTytMMUhYR1U5cEdNVElzbld4dTRPbzFSd09ycENHM3BOY3VP?=
 =?utf-8?B?eGJSWjU4eXRMejZjS1pOYmllQXd4bW4ydVNncnNwT2E4dmsxTWNOa2VJZGNa?=
 =?utf-8?B?UWxheTRtS2Q2emdGRmtkSXR4RitnNThTWllzT2dMWTR2RE1lcXppcTlzbklH?=
 =?utf-8?B?UHQ2L0ROdXpnb2xXcWZuMkNIb1NrR3FvSG9VeU53L0ZEV1l0N3NrZUNNU1p6?=
 =?utf-8?B?YXZ2UVhkNzh4N2oweWZFRzFsYmgzYktHY0lpcFdVbTl1UG9rc0NXODY4VHUv?=
 =?utf-8?B?TGhVNHMzQzV3YlkxSmdXS244QUtHaHo1U1NKVUcxOUhxQjFkZHRwaHRGay82?=
 =?utf-8?B?SXlGZCtCS0xUaU9mUjFnaDJJb0ozRmRvb09XbWQ5dzZsWW94L1hlWnViS095?=
 =?utf-8?B?YVJNZWs3VWpqNVVQZWtWekVWQUV6bFNnS0c2ZkFaVWx1WlU3ZnZpOTRObmhj?=
 =?utf-8?B?SHBVWk1Oa3JSYkdsTU1qUHVlWTFFTTRGOTROY3RHWFJzWndaeDMyVjh6QW0w?=
 =?utf-8?Q?IBVedkaAwVgG2rbzmChW1vHlP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e820790-33be-45b5-1ca6-08ddf177c8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 21:11:32.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o26o46URihKnuvs07cAArIVKxKrDNwlyt2RjSvW1knu7qCkvamcbwv+F9yS2WTYFM/vT/kmuD294n9OSU15V3ymhdotp7yodroy9qjphaoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585

PiBPbiA5LzExLzI1IDEyOjEwIEFNLCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiA+PiBLU1o4NDYzIGV4cGVjdHMgdGhlIFNQSSBjbG9jayB0byBiZSBsb3cgb24gaWRsZSBhbmQg
c2FtcGxlcyBkYXRhIG9uDQo+ID4+IHJpc2luZyBlZGdlcy4gVGhpcyBmaXRzIFNQSSBtb2RlIDAg
KENQT0wgPSAwIC8gQ1BIQSA9IDApIGJ1dCB0aGUgU1BJDQo+ID4+IG1vZGUgaXMgc2V0IHRvIDMg
Zm9yIGFsbCB0aGUgc3dpdGNoZXMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuIFRoaXMNCj4gPj4g
Y2FuIGxlYWQgdG8gaW52YWxpZCByZWFkL3dyaXRlIG9uIHRoZSBTUEkgYnVzLg0KPiA+Pg0KPiA+
PiBTZXQgU1BJIG1vZGUgdG8gMCBmb3IgdGhlIEtTWjg0NjMuDQo+ID4+IExlYXZlIFNQSSBtb2Rl
IDMgYXMgZGVmYXVsdCBmb3IgdGhlIG90aGVyIHN3aXRjaGVzLg0KPiA+Pg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBCYXN0aWVuIEN1cnV0Y2hldCAoU2NobmVpZGVyIEVsZWN0cmljKQ0KPiA+PiA8YmFz
dGllbi5jdXJ1dGNoZXRAYm9vdGxpbi5jb20+DQo+ID4+IEZpeGVzOiA4NGM0N2JmYzViM2IgKCJu
ZXQ6IGRzYTogbWljcm9jaGlwOiBBZGQgS1NaODQ2MyBzd2l0Y2ggc3VwcG9ydCB0byBLU1ogRFNB
DQo+ID4+IGRyaXZlciIpDQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbmV0L2RzYS9taWNyb2No
aXAva3N6X3NwaS5jIHwgNyArKysrKy0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2RzYS9taWNyb2NoaXAva3N6X3NwaS5jDQo+ID4+IGIvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3pfc3BpLmMNCj4gPj4gaW5kZXgNCj4gPj4NCj4gZDgwMDE3MzRiMDU3NDE0NDZmYTc4
YTFlODhjMmY4MmU4OTQ4MzVjZS4uZGNjMGRiZGRmN2I5ZDcwZmJmYjMxZDRiMjYwYjgwDQo+ID4+
IGNhNzhhNjU5NzUgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
a3N6X3NwaS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X3NwaS5j
DQo+ID4+IEBAIC0xMzksNiArMTM5LDcgQEAgc3RhdGljIGludCBrc3pfc3BpX3Byb2JlKHN0cnVj
dCBzcGlfZGV2aWNlICpzcGkpDQo+ID4+ICAgICAgICAgIGNvbnN0IHN0cnVjdCByZWdtYXBfY29u
ZmlnICpyZWdtYXBfY29uZmlnOw0KPiA+PiAgICAgICAgICBjb25zdCBzdHJ1Y3Qga3N6X2NoaXBf
ZGF0YSAqY2hpcDsNCj4gPj4gICAgICAgICAgc3RydWN0IGRldmljZSAqZGRldiA9ICZzcGktPmRl
djsNCj4gPj4gKyAgICAgICB1MzIgc3BpX21vZGUgPSBTUElfTU9ERV8zOw0KPiA+PiAgICAgICAg
ICBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyByYzsNCj4gPj4gICAgICAgICAgc3RydWN0IGtzel9kZXZp
Y2UgKmRldjsNCj4gPj4gICAgICAgICAgaW50IGksIHJldCA9IDA7DQo+ID4+IEBAIC0xNTUsOCAr
MTU2LDEwIEBAIHN0YXRpYyBpbnQga3N6X3NwaV9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
KQ0KPiA+PiAgICAgICAgICBkZXYtPmNoaXBfaWQgPSBjaGlwLT5jaGlwX2lkOw0KPiA+PiAgICAg
ICAgICBpZiAoY2hpcC0+Y2hpcF9pZCA9PSBLU1o4OFgzX0NISVBfSUQpDQo+ID4+ICAgICAgICAg
ICAgICAgICAgcmVnbWFwX2NvbmZpZyA9IGtzejg4NjNfcmVnbWFwX2NvbmZpZzsNCj4gPj4gLSAg
ICAgICBlbHNlIGlmIChjaGlwLT5jaGlwX2lkID09IEtTWjg0NjNfQ0hJUF9JRCkNCj4gPj4gKyAg
ICAgICBlbHNlIGlmIChjaGlwLT5jaGlwX2lkID09IEtTWjg0NjNfQ0hJUF9JRCkgew0KPiA+PiAg
ICAgICAgICAgICAgICAgIHJlZ21hcF9jb25maWcgPSBrc3o4NDYzX3JlZ21hcF9jb25maWc7DQo+
ID4+ICsgICAgICAgICAgICAgICBzcGlfbW9kZSA9IFNQSV9NT0RFXzA7DQo+ID4+ICsgICAgICAg
fQ0KPiA+PiAgICAgICAgICBlbHNlIGlmIChjaGlwLT5jaGlwX2lkID09IEtTWjg3OTVfQ0hJUF9J
RCB8fA0KPiA+PiAgICAgICAgICAgICAgICAgICBjaGlwLT5jaGlwX2lkID09IEtTWjg3OTRfQ0hJ
UF9JRCB8fA0KPiA+PiAgICAgICAgICAgICAgICAgICBjaGlwLT5jaGlwX2lkID09IEtTWjg3NjVf
Q0hJUF9JRCkNCj4gPj4gQEAgLTE4NSw3ICsxODgsNyBAQCBzdGF0aWMgaW50IGtzel9zcGlfcHJv
YmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPj4gICAgICAgICAgICAgICAgICBkZXYtPnBk
YXRhID0gc3BpLT5kZXYucGxhdGZvcm1fZGF0YTsNCj4gPj4NCj4gPj4gICAgICAgICAgLyogc2V0
dXAgc3BpICovDQo+ID4+IC0gICAgICAgc3BpLT5tb2RlID0gU1BJX01PREVfMzsNCj4gPj4gKyAg
ICAgICBzcGktPm1vZGUgPSBzcGlfbW9kZTsNCj4gPj4gICAgICAgICAgcmV0ID0gc3BpX3NldHVw
KHNwaSk7DQo+ID4+ICAgICAgICAgIGlmIChyZXQpDQo+ID4+ICAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPj4NCj4gPj4gLS0tDQo+ID4+IGJhc2UtY29tbWl0OiBjNjVlMmFlZTg5NzFl
YjlkNGJjMmI4ZWRjM2EzYTYyZGM5OGYwNDEwDQo+ID4+IGNoYW5nZS1pZDogMjAyNTA5MTAtZml4
LW9tYXAtc3BpLWQ3YzY0ZjI0MTZkZg0KPiA+DQo+ID4gQWN0dWFsbHkgaXQgaXMgYmVzdCB0byBj
b21wbGV0ZWx5IHJlbW92ZSB0aGUgY29kZS4gIFRoZSBTUEkgbW9kZSBzaG91bGQNCj4gPiBiZSBk
aWN0YXRlZCBieSBzcGktY3BvbCBhbmQgc3BpLWNwaGEgc2V0dGluZ3MgaW4gdGhlIGRldmljZSB0
cmVlLiAgSSBkbw0KPiA+IG5vdCBrbm93IHdoeSB0aGF0IGNvZGUgd2FzIHRoZXJlIGZyb20gdGhl
IGJlZ2lubmluZy4NCj4gPg0KPiANCj4gT2ssIEkgZGlkbid0IGtub3cgdGhlc2Ugc2V0dGluZ3Mg
d2VyZSBhdmFpbGFibGUgb24gdGhlIGRldmljZS10cmVlLCBJDQo+IGNhbiByZW1vdmUgdGhlIHNw
aS0+bW9kZSBzZXR0aW5nIGluIGEgbmV3IHBhdGNoLg0KPiANCj4gPiBBbGwgS1NaIHN3aXRjaGVz
IGNhbiB1c2UgU1BJIG1vZGUgMCBhbmQgMywgYW5kIDMgaXMgcmVjb21tZW5kZWQgZm9yIGhpZ2gN
Cj4gPiBTUEkgZnJlcXVlbmN5LiAgU29tZXRpbWVzIGEgYnVnL3F1aXJrIGluIHRoZSBTUEkgYnVz
IGRyaXZlciBwcmV2ZW50cyB0aGUNCj4gPiB2ZXJ5IGZpcnN0IFNQSSB0cmFuc2ZlciB0byBiZSBz
dWNjZXNzZnVsIGluIG1vZGUgMyBiZWNhdXNlIG9mIGEgbWlzc2VkDQo+ID4gcmlzaW5nIGVkZ2Ug
Y2xvY2sgc2lnbmFsLCBzbyBpdCBpcyBmb3JjZWQgdG8gdXNlIG1vZGUgMC4gIChUaGUgQXRtZWwg
U1BJDQo+ID4gYnVzIGRyaXZlciBoYXMgdGhpcyBpc3N1ZSBpbiBzb21lIG9sZCBrZXJuZWwgdmVy
c2lvbnMuKQ0KPiA+DQo+ID4gQXMgZm9yIEtTWjg0NjMgSSBoYXZlIGFsd2F5cyB1c2VkIG1vZGUg
MyBhbmQgZG8gbm90IGtub3cgb2YgYW55IGlzc3VlIG9mDQo+ID4gdXNpbmcgdGhhdCBtb2RlLg0K
PiA+DQo+IA0KPiBJIGhhdmUgaXNzdWVzIG9uIHRoZSBmaXJzdCB0cmFuc2ZlciB3aXRoIHRoZSBB
TTMzNXgncyBzcGktb21hcDItbWNzcGkNCj4gZHJpdmVyLiBJIGZpcnN0IHRyaWVkIHRvIGZpeCB0
aGlzIGRyaXZlciBidXQgc2luY2UgdGhlIEtTWjg0NjMncw0KPiBkYXRhc2hlZXQgZXhwbGljaXRs
eSBtZW50aW9ucyB0aGF0IGl0IGV4cGVjdHMgdGhlIENMSyB0byBiZSBsb3cgYXQgaWRsZSwNCj4g
SSB0aG91Z2h0IHRoaXMgd2FzIHRoZSByaWdodCBmaXguDQo+IA0KPiBCdXQgSSdsbCBmaXggdGhl
IFNQSSBkcml2ZXIgdGhlbiwgdGhhbmtzLg0KDQpJdCBzZWVtcyB5b3UgbWF5IGhhdmUgdGhlIHNh
bWUgaXNzdWUgSSBmYWNlZCBiZWZvcmUuICBBIHdvcmthcm91bmQgaW4gdGhlDQpTUEkgYnVzIGRy
aXZlciBtYXkgYXZvaWQgdGhlIHByb2JsZW0sIGJ1dCB0aGUgY2hhbmdlIGhhcHBlbnMgaW4gc3Bp
LmMsIHNvDQppdCBtYXkgbm90IGJlIGEgZ29vZCBzb2x1dGlvbi4NCg0KWW91ciBiZXN0IGJldCBp
cyB0byByZW1vdmUgdGhlIHNwaV9zZXR1cCBjYWxsIGFuZCB1c2UgbW9kZSAwIGluIHRoZQ0KZGV2
aWNlIHRyZWUuDQoNCkFub3RoZXIgcXVpY2sgZml4IGlzIHRvIGRvIGEgZHVtbXkgd3JpdGUgaW4g
dGhlIERTQSBkcml2ZXIgYmVmb3JlIHJlYWRpbmcNCmFuZCBjaGVja2luZyB0aGUgY2hpcCBpZC4N
Cg0K

