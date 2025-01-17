Return-Path: <netdev+bounces-159120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE9A1475E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E8A3A9CA0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC171F957;
	Fri, 17 Jan 2025 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lSjeDjhJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F612175A5;
	Fri, 17 Jan 2025 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076166; cv=fail; b=iOOYFrAPgjCFeDembjli55CTJcbmBGxGd7FDQY2yA3pCUqKcI1ORXE0ejle/TlO9s8je1Bu9wQX0hsr1zWQoUqfAz/A+tvvMyzovPGetn/WNhs4I8KpmjI4WDL8gEneTBUfHwrTnvFSwWjCUjkFYpqVYugbeaZCb3skXa5GVufI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076166; c=relaxed/simple;
	bh=Imny9puIROVa1oZsLvWSrnNu+NS6MJwRK82v9D9hcQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOUnKsY2u/TJ81cC2lROyggUGzf1bU5iSvQ3X3iMnC9sFMuA8aD7YOj8wOAmj8Qm0F8pW7oqN+SWZ7hGkA4o7zl3RtqPWAf777GLC60Ki7VJ2fXRO/S59zZ3D3Nx9c8cnPLoavrCrMh4rgIjrZjEOFmLvxiwWI0K03Qtnx49JFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lSjeDjhJ; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsWzkG7RudTmULd488OBdYqTdwAZDoEcfcdP8BIj/2cEWhbcC8Ug3WIy/jbOTWVt9pOPXWcALK8QourSsfzuiANBbtiNkLBytiLFW2jSzoSudnd63KAJeT+ls4mHPNkLQo3jI/GhJlUSGCWo4OVT7tfk9oTJx1cIn3Sh3vBdeIreOFAS2rsTeIUsxiBOowy1WXlvgPTzmVFdd9Bl78/UQKd8p0266VFiMnllekiCVVzkbbqUQgoYwuW7MhtV0/qhYAqZ/2Jhqvcf7cqdAE2UmamsD0PltdevPZsfx9evW6C1KCXv72V0bSY4rx3+MIJwoS4Ec6v75PzKs0ffCI7Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imny9puIROVa1oZsLvWSrnNu+NS6MJwRK82v9D9hcQQ=;
 b=FgcyAE/0enimtRjdUB69zTVyXigIqB6+AjEMkUF8FaczfuxP4G/MERRAxFhCeL0JWyGAzlxevL0o7UKmKNR+LcZ3jcsaPmWEjAgJ6et0jSainSGPHGM7qtwb/RFD8NnMfRAehB+v+pR/tom6SRk2rPdF1lHlG4hE1hdFHSX+y1wmjVVSeRmIrRz6wF7Ggz1XCQyFqnpU5tAjdF5imtbQZGfYALGA6KFkOnqmK+QPDPPzbDPf+SBtu0E2ipZOQWJwqCJa1iXgPdKTtSarIPAs6y1tyZY2mNrwv0J33tmLhbJq4Bl75LMnXgm8zLq6dEB64b5rmjVLCbKbWKl5nX8QrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imny9puIROVa1oZsLvWSrnNu+NS6MJwRK82v9D9hcQQ=;
 b=lSjeDjhJ7G+Uc9c7oPErGP8PsxT+lTDR3xztzDioDKWu0TIj4Znl5OBh3vKapJoOPbFvhYbLTKJE6SzlbM8nilhWN3eJINfxvMIubGa+cgoLOgwRzP8Iy1gKgyI1YtQmCzmrXLzJFF/XCaEBU18JzhZm2HkkqA7Kuhs2jlnzS3m4jFxh9T4LSCX8d1++ZtOXvU1GgLmFB1Rd8P+eTE1pgYJ136HAab4rPvp4JMawlfUJzgvS9GX9AVUqvpCMp+UvP8d/GwqWBe64K6BqYnbKgonF8+0jRNNnTnMpgfEX4g/USCpzXJU131DnU5ZFZG0MgED+CGRuN9i6aM0QjqYV3A==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 01:09:21 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:09:21 +0000
From: <Tristram.Ha@microchip.com>
To: <Arun.Ramadoss@microchip.com>, <tharvey@gateworks.com>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: RE: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Thread-Topic: [PATCH net] net: dsa: microchip: ksz9477: fix multicast
 filtering
Thread-Index:
 AQHbTPIKP6fOA0qWjUGHDotcQ0fDfrLjUxUAgAALoYCAFyxhAIAJ+m0AgBJEcACAAofrgIABCazw
Date: Fri, 17 Jan 2025 01:09:21 +0000
Message-ID:
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
	 <20241213000023.jkrxbogcws4azh4w@skbuf>
	 <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
	 <20241213011405.ogogu5rvbjimuqji@skbuf>
	 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
	 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
	 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
In-Reply-To: <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA0PR11MB7210:EE_
x-ms-office365-filtering-correlation-id: 7b8d9934-eec7-4dcb-6a04-08dd36939368
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1dyaGlJTkpiZFlkU2cwVTZxelhYajl0YVlhdEUreWlzcUQ2OUtCa040aUNF?=
 =?utf-8?B?d1BNbEd4WkM3ZURINnJ3LytUQzE0MDdZMGh4VGgyRThrTm9hL2I4NG5ub1p6?=
 =?utf-8?B?cUY5ejNOS0FQM2RqZnEzMWNPUkZZb0VBZHp0OHM2eS8za0haQ1NQL0lQV29j?=
 =?utf-8?B?NFA2UWErMmJ2WXB4NXJWUmRoYVdKeDZHaVR5ME5IcGVwVkJGRFB0a1FBZGpr?=
 =?utf-8?B?dFlBMDZHNEVZeFdNMWdvQ09UWHdHcVdGTU5NNmpFS1VBMHpZNTVWaE9hUVBr?=
 =?utf-8?B?WVorWmxOWWN3aTdNd0NWamNIZktxYUVNL0lScW1jVlpuTnRYalFBWWhCanRy?=
 =?utf-8?B?L1ZwTFgzcmgwTE1aRFpQc2dWMXBiK3k1WHRyWXJucVlyU2tkT05XZmppYXcw?=
 =?utf-8?B?WUlUblhteERqNy9yQ3JKU3JsRzJTSlRPTGx5aUJVQURZSWV1M01hWFQzM2dt?=
 =?utf-8?B?eE9VVlRHbStyUEFkTDJSMFRYZ0FQcFMybVpHYzU4RjZ4cWVONllBZU10a25s?=
 =?utf-8?B?aUl5c0dVT1FVYnptVHFyd3l2eGE3TjFiUzZCRW55Ly9pYTNGVktraTRRNHcv?=
 =?utf-8?B?ZDh6bzVWT2xZSkxLM0oyY1d5dEppWC9NektPVk5TQmVXS2xQOUs5dndKNzhE?=
 =?utf-8?B?MnFvaWdHR1pVWEdCS2JFNGdvdXFpVW1ON0ZnbmFJeW50YjgxU3hud2VneXBF?=
 =?utf-8?B?OUZqOE5uU2Eva2Z3VTZieGtRQzZWcjc2NWdRQjFndlFhK3NOeWVlOXlISHJH?=
 =?utf-8?B?MDdhSzNEcUlQVEZpUHhMNGlDSmMyaTVxaTVLMVVyemwzVGpNV3Y4aitiYmVC?=
 =?utf-8?B?dGdjRDE3eU1KMkhLZ015RjVrY1NvRTlrSG9VUTBId0JNUlVOZVFWYzRUZUtX?=
 =?utf-8?B?cThLejluSFh0K1hPOEw5eDVOZlpwNEUxWE5uREU2TVVOVzRIYjlmOTVQbmEx?=
 =?utf-8?B?UjhraGhGQ0Ftbk5qb2ZFREtvb3g5T1Fhb1NVckRxSmhYL2pyWEhxeTY5K1ZU?=
 =?utf-8?B?QTNXUXZDcUJ5S000ayttR0dGQjV5ZWcyZXpoQ05PcHZSeTBrWStYVE83d1NY?=
 =?utf-8?B?bitJeGRRd0pwK3M2V3krZVMzVVFYeUZ6dUtjUlpPc3ZTR3Q3Kzl6YU1PdEYr?=
 =?utf-8?B?SjRhWFdkbWdjRTNFOE94WmxtZUFUVTR4V3p2MXA0OXFTTGRRcGNrRk8wckYy?=
 =?utf-8?B?cEpCTi8zU0ZORGZvZU0yeVlYSFVDSTg4dTJTa2pzZnlYcE4xallDYzlINXFs?=
 =?utf-8?B?Qkt2a1hnZVlDanRGVml1OUtlaTFZU0xUUTh5a2FaUThweDF4YVY0dE8zUXha?=
 =?utf-8?B?aG9pZmYzTjJ5bXJvUFM5RmxWTEJ0UVNlN0NFWkxjcHZockJGSmhqZUxSU1E1?=
 =?utf-8?B?dkRqNmVJQ00wVHczMXpMZkNJU2txUHFTcUExU281Z0dYNHdXMjRVZGdSRjN0?=
 =?utf-8?B?bWlaRjBwc3N0a1BNb3UxLzYraGQ2ZytpUjhwVXptdVFvTmhvWjR1eG5BRm5F?=
 =?utf-8?B?Z0FFMi8rZThiSXNPSVVuRkoyd1M1YXFkamVaNnVIV2s0eFpXM1FEMnhUVVNv?=
 =?utf-8?B?YVM5V0VVUFJCOVNINnlvWkxZa0RrKzdTWjJ1QjlhdTZuak9qakpuWDdSU2Rx?=
 =?utf-8?B?cjVXRzI3SlJHUmlmSGhrejkwcjBlVCtJVW9hWjdLbDFRRVE5SklwcFlFamxC?=
 =?utf-8?B?WG04eVJnZm93bmV1ZGRjL3ZVT1FKdm12RUJXS1B0YitFV2VSa09xMmxZQkJs?=
 =?utf-8?B?L3Rha0dydFljS09jcm5WaW91ZGRaWVJ5QWJrZmd3SUZSN2d1RjU2bm1Jbm1K?=
 =?utf-8?B?bmpEK3NKLzFvWUZwbG1SWXFRSXFPYzkySVVtdEV0Y2RFN3ptbE15L21DcENT?=
 =?utf-8?B?cUl6UGZJWVFReGxIcHNCK09jeURSWEFLOXVsNG1oRGVRamcyNHpBWjloeGZw?=
 =?utf-8?Q?HJB6NzMQU3ZJLCVU751dQcck3AX2NmgV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1NYbFVLeXpZdGpvYjY3eFBiSnpKVEFRM3hMWHJSdXNZNG1uWTVSempHQ3dq?=
 =?utf-8?B?L2lUSFlQRlVNN2t3UHZCS1VHWWRsOTk5ZTNkTUpjcG1JbGtTOXc1VFUrNzVl?=
 =?utf-8?B?c05OOFNCZzVKYXdHQ1dJbHJ3Z05HY0lhSDYzNUxYb201MHE4dExYWVEyaEE2?=
 =?utf-8?B?d2E4SWZEWGtOSklBb0M3blFKVWZKTTVGcndQdXNGekVMSWZzZ1ZYdG1MZFlN?=
 =?utf-8?B?MkllaDkwcVNhbDk0SnI0RVhYRGxXMXd2Wm5JeTJQQnI2ajVNQVVEREpLZ0kv?=
 =?utf-8?B?aEZEeUdGMDhPNmVqQ0hRU25BMzJUMVZDU0ZjcFltUGlERkVCR055TW1JR2hB?=
 =?utf-8?B?RktmOHRsYmttSWZxbmpPUzdtWC91YlV4cldWajR0S3YvMER0QVRBRW1CR05N?=
 =?utf-8?B?QzB3SGF3OGllNFErb3hocDJWLzQ0b0hrQTFrZ3kzVEUxMCs4MXVqbTlsOVgz?=
 =?utf-8?B?MGZnbFRUeThzMmhVTExiWW1rcTdBZ2h4UE9ZRWprT2VjVUFjSUJVb0E3WU9Z?=
 =?utf-8?B?Nk5XS3lwakF2QUtzNzI4WnRva0M3ZitCNFRFa2lvUHIxS1FVTnJFOEpac1Z5?=
 =?utf-8?B?cy9CWWRQQ1FETnNlWDk5Vml0WUZNWTJYZmFLMFMvbWZIRWhSNFdQVjRZUUcz?=
 =?utf-8?B?OXRveFNoQ3hIUWU1Q0wrRzVjcGt1K3M3L0t0NUpMU3Y4KytDS0tKcWpMMXpT?=
 =?utf-8?B?eVI2ZEYxQTdCZnFqdytEU0J3U09CNS90cDl4S0R3UEs0NHhTeW5iL0dCRWJH?=
 =?utf-8?B?Tk04MWpabEwycnpJbk1UY2ZoSE1RZmwrT09oaHg0SE1WZFEvbWJhV3RBdjF2?=
 =?utf-8?B?WUVOakUraGlab09qOGxOTTk3L04raVdpcEU3SGJjRG1UbmZJbHUyQ2lSczdW?=
 =?utf-8?B?MkM5S3d5UURkcExhVUpqeEpScVZJUUVPNlFJejRodWRvc08raDk2eDlwekV1?=
 =?utf-8?B?OUZsLy95NThMd0lZRzlPWUdSK2N4Qmc3Ryt2b0cvQ3lMaXZOaDdqQ0pHOWhI?=
 =?utf-8?B?QUxTd3ptcmdBMm1TOUxWa1l3TVVHTm1Rb24va3B6UTd6WUdkTElXNVRmcUlu?=
 =?utf-8?B?dmZDTHVSK21hM1V3NTRKT2c5RnE2TzhsTzVsbFRwMllzSFFvT1FUNFcxY09x?=
 =?utf-8?B?U0pLN28rQzJqZEh0MTc5dUJ3cDVkL0o4UXR4WTZZRGJSanpIYXRpV2FCakNs?=
 =?utf-8?B?RnNYSGIrTW95ZndTTDkyK0RYZDZVcTB2OUdkcDFmUUdKRUlmaXBabTJpaGFk?=
 =?utf-8?B?Ym5qMksvOXFBbi81UE1sTWk1OFpuYWk4RjRZaGRicVlhRWU4SGVFVTY1MXVa?=
 =?utf-8?B?QSs0VjdvVkxUQzRyYzNoQktCWkd0RXhyaEFDcXJJekNnWThRbG9QS2hQV2Vu?=
 =?utf-8?B?NDhPQS91R3FhY0NvRENXYkRtc1RCNUxMd2RYekhrVFp3QUtPTkltSFVFYnpn?=
 =?utf-8?B?L1NrbWU2ZGVHcXUwSVZ4QVV6RTdVeHg3RDQyYUFyRnFMLytJWXEvVC9pb1VL?=
 =?utf-8?B?aDJwSmVyVmNWWm84andLSEVIMlZxYWE4bTZLR0JJbDhyVXlCS0NOY05iRndP?=
 =?utf-8?B?K21xODhoY1FvZDVjV2hrVTU1NXNhQUZUN3FJNlE4cEhad3VHOTRUY0xkZ2JJ?=
 =?utf-8?B?ZXZDaVNrVEdBcHc0cFZ4c2liUWhyNkNwVHhGeVZoVWtZVm0vNlBTNUMvOURB?=
 =?utf-8?B?OFZQNXdtdzZHVkl3T2FaSDlFKy9pOVJxTXVNVU12bk9UOFgzZHFzWXo0Z0JW?=
 =?utf-8?B?MTZWVlZRZ0creWxzNko5NENVbng0NUE2YXNSV3p1UUx5RGJPNmZUR0FxTTNw?=
 =?utf-8?B?d0pHOU5OMkp1clFaejFrRUQ1U291ZG1NdlNWd3F5NWZEVnBNVHpFOWozV2JC?=
 =?utf-8?B?NDMyTWgvdU45d1dKYXlBS0RlRnFpalNXWmVnaGRVZHFiSkdSZUVtYjZsZTE4?=
 =?utf-8?B?T3BxeVE2V2pKdG9MMTk4TG84K0ZTeHc4MXg1ejh3S0VHUlg5TWlhUDJDVThT?=
 =?utf-8?B?TmMzN0hVL1lMQ1F2YTYrZVBHeTJnWGtadTJhQnhwaUlDSDJFWVhNNXB1VkVU?=
 =?utf-8?B?K05OejhsN05UZ2RBZGViRisySWxXWGxWV1hOQzJrODVueElUL2VuNU9tWUhB?=
 =?utf-8?Q?6J9NeNnWFj+mkMGO2HlTRXwxB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8d9934-eec7-4dcb-6a04-08dd36939368
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 01:09:21.7292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNUDIac0jNfIeiNKnLPcbFCJwi6+J2JTFp1ToBbp/hX5gFBRKlZyDHJPsfvTT/iTtYsdan4h6s6gFWq7h8hDln5DNtV900WUXSww+SqWEtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210

PiBIaSBUaW0sDQo+IA0KPiA+IEhpIEFydW4sDQo+ID4NCj4gPiBPaywgdGhhdCBtYWtlcyBzZW5z
ZSB0byBtZSBhbmQgZmFsbHMgaW4gbGluZSB3aXRoIHdoYXQgbXkgcGF0Y2ggaGVyZQ0KPiA+IHdh
cyB0cnlpbmcgdG8gZG8uIFdoZW4geW91IGVuYWJsZSB0aGUgcmVzZXJ2ZWQgbXVsdGljYXN0IHRh
YmxlIGl0DQo+ID4gbWFrZXMgc2Vuc2UgdG8gdXBkYXRlIHRoZSBlbnRpcmUgdGFibGUgcmlnaHQ/
IFlvdSBhcmUgb25seSB1cGRhdGluZw0KPiA+IG9uZSBhZGRyZXNzL2dyb3VwLiBDYW4geW91IHBs
ZWFzZSByZXZpZXcgYW5kIGNvbW1lbnQgb24gbXkgcGF0Y2gNCj4gPiBoZXJlPw0KPiANCj4gDQo+
IER1cmluZyBteSB0ZXN0aW5nIG9mIFNUUCBwcm90b2NvbCwgSSBmb3VuZCB0aGF0IEdyb3VwIDAg
b2YgcmVzZXJ2ZWQNCj4gbXVsdGljYXN0IHRhYmxlIG5lZWRzIHRvIGJlIHVwZGF0ZWQuIFNpbmNl
IEkgaGF2ZSBub3Qgd29ya2VkIG9uIG90aGVyDQo+IGdyb3VwcyBpbiB0aGUgbXVsdGljYXN0IHRh
YmxlLCBJIGRpZG4ndCB1cGRhdGUgaXQuDQo+IA0KPiBJIGNvdWxkIG5vdCBmaW5kIHRoZSBvcmln
aW5hbCBwYXRjaCB0byByZXZpZXcsIGl0IHNob3dzICJub3QgZm91bmQiIGluDQo+IGxvcmUua2Vy
bmVsLm9yZy4NCj4gDQo+IEJlbG93IGFyZSBteSBjb21tZW50cywNCj4gDQo+IC0gV2h5IG92ZXJy
aWRlIGJpdCBpcyBub3Qgc2V0IGluIFJFR19TV19BTFVfVkFMX0IgcmVnaXN0ZXIuDQo+IC0ga3N6
OTQ3N19lbmFibGVfc3RwX2FkZHIoKSBjYW4gYmUgcmVuYW1lZCBzaW5jZSBpdCB1cGRhdGVzIGFs
bCB0aGUNCj4gdGFibGUgZW50cmllcy4NCg0KVGhlIHJlc2VydmVkIG11bHRpY2FzdCB0YWJsZSBo
YXMgb25seSA4IGVudHJpZXMgdGhhdCBhcHBseSB0byA0OA0KbXVsdGljYXN0IGFkZHJlc3Nlcywg
c28gc29tZSBhZGRyZXNzZXMgc2hhcmUgb25lIGVudHJ5Lg0KDQpTb21lIGVudHJpZXMgdGhhdCBh
cmUgc3VwcG9zZWQgdG8gZm9yd2FyZCBvbmx5IHRvIHRoZSBob3N0IHBvcnQgb3Igc2tpcA0Kc2hv
dWxkIGJlIHVwZGF0ZWQgd2hlbiB0aGF0IGhvc3QgcG9ydCBpcyBub3QgdGhlIGRlZmF1bHQgb25l
Lg0KDQpUaGUgb3ZlcnJpZGUgYml0IHNob3VsZCBiZSBzZXQgZm9yIHRoZSBTVFAgYWRkcmVzcyBh
cyB0aGF0IGlzIHJlcXVpcmVkDQpmb3IgcmVjZWl2aW5nIHdoZW4gdGhlIHBvcnQgaXMgY2xvc2Vk
Lg0KDQpTb21lIGVudHJpZXMgZm9yIE1WUlAvTVNSUCBzaG91bGQgZm9yd2FyZCB0byB0aGUgaG9z
dCBwb3J0IHdoZW4gdGhlIGhvc3QNCmNhbiBwcm9jZXNzIHRob3NlIG1lc3NhZ2VzIGFuZCBicm9h
ZGNhc3QgdG8gYWxsIHBvcnRzIHdoZW4gdGhlIGhvc3QgZG9lcw0Kbm90IHByb2Nlc3MgdGhvc2Ug
bWVzc2FnZXMsIGJ1dCB0aGF0IGlzIG5vdCBjb250cm9sbGFibGUgYnkgdGhlIHN3aXRjaA0KZHJp
dmVyIHNvIEkgZG8gbm90IGtub3cgaG93IHRvIGhhbmRsZSBpbiB0aGlzIHNpdHVhdGlvbi4NCg0K
VGhlIGRlZmF1bHQgcmVzZXJ2ZWQgbXVsdGljYXN0IHRhYmxlIGZvcndhcmRzIHRvIGhvc3QgcG9y
dCBvbiBlbnRyaWVzIDAsDQoyLCBhbmQgNjsgc2tpcHMgaG9zdCBwb3J0IG9uIGVudHJpZXMgNCwg
NSwgYW5kIDc7IGZvcndhcmRzIHRvIGFsbCBwb3J0cw0Kb24gZW50cnkgMzsgYW5kIGRyb3BzIG9u
IGVudHJ5IDEuDQoNCmVuYWJsZV9zdHBfYWRkcigpIGlzIHVzZWQgdG8gZW5hYmxlIFNUUCBzdXBw
b3J0IGluIGFsbCBLU1ogc3dpdGNoZXMsIHNvDQprc3o5NDc3X2VuYWJsZV9zdHBfYWRkcigpIGNh
bm5vdCBiZSBzaW1wbHkgcmVuYW1lZC4NCg0KSXQgaXMgcHJvYmFibHkgYmVzdCB0byBoYXZlIGEg
c3BlY2lmaWMgc2V0dXBfcmVzZXJ2ZWRfbXVsdGljYXN0X3RhYmxlDQpJbiBLU1o5NDc3IGFuZCBM
QU45MzdYIGRyaXZlcnMgdG8gdXBkYXRlIHRob3NlIGVudHJpZXMuDQoNCg==

