Return-Path: <netdev+bounces-221968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FEB526EC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ED9468486
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF9223DCF;
	Thu, 11 Sep 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="10dDHLp0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95C4AEE2;
	Thu, 11 Sep 2025 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560428; cv=fail; b=f4s9AwAfKVYledZESgEFjHJaIoP/0oVm9wg1mMO/wq1xuAKJlb2cIBUwCEDJ1Xj0ZBl3OobydCISzH1oiwJsQ0zCRpQ7yiSJuNKT1wICKxXpvGZx7BpH60XZ2zrR26OP83ffftPFKtbCHfrXi0d5fzI/2MMbKEioTxsSGeWXyTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560428; c=relaxed/simple;
	bh=hWpXBjuLA/jjRBOYD7ChYutpKUMX1yUeqTVFFN1yipw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NEgZLJGKcgE+dMYi3GwDLVC4AJVS+at7i0i9Sj5lhJ6dU9x+hTSsa+Nfa2vv11RVUgTuEDS8Oxag7V35MCD2bbcLjbFwMsEaTW7y+kykxrDJfUNnFmg1A6eDdX8X8BGT2D17CqVCa8szy8me40MSwR9iJOjQTJcOHpcd7VdpwOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=10dDHLp0; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYz06rdTx9eMRImXJxlhSJ3r3sFn+XaWmwrV+VJ+U8B1uQYZzDGPjzmYsjzhX2ciFNd835Ra2IdpIocz3DP58QrKZXr4DtVpgJoSyB9D7XRyLC9ebWfNUzoLOBcoYHhZA2eqTIGoWyEaZ3nHXZ+07ipHwvHjRTeSOODteegYxW6vGzjDsGAudqj94Z+T9/D6RFo8sJutkJoIe5REUwOCyRCN4avTQdX74NKRsD3qtlQeiwvNMi+IZyrqvmwvU/m6haMx9x70vvNrsYOjM8dGkJn7Pol2Tqkpg1EQF3wsKWgWeLmnWa6OoOEkBKT2y1+wW15S+2oRlIQ351hyIePEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuB7RsShioQ7IAm0nBgCLj3rV0piVvqJHStYWnwKTFU=;
 b=ttGCpR+MO3PRXNRGArLjB5cstqYuiAmUgkKcBi1U+rTFlORi1n59kgBndJVLVkg7PjN47+49SiLHiErKD/8xCI7s9pv+f9XH7UTRpxMamWjG3cgLadsxlxd9sEWIxiUfTj/M0RYvKZ+TS7unZrermOMheHR5ztC/zYCxMQolv0y26uWdTBnMxJnv3Q29xezRyOsujDXB4/NRxCkDyQ7EHVSFN+TCou2x5Ls2ueH104azX4s/xI7kU9HB0DL3yoqDf9bY4mlFVZBV1PGmlShfNUMvnAXmbtps8CC8YKQqXp+CNI2FlzgQ1lOXvR8TnR/cJRS66ZObmHPBuwbWo/wsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuB7RsShioQ7IAm0nBgCLj3rV0piVvqJHStYWnwKTFU=;
 b=10dDHLp0nG4O7XjNT4ToQqi0BWOAx2YFbT1c0SoSIsOheKqTvpboY2ARl5bQw+VQDr0FYIMb0Y0Tf8QmRu3KLl0UahbkdCxLTLvOiW2t3VvPWMHddJWZue6+nVf9NDc8YpfHjMCYabSaT3YVykXeYbG6vETcLcL2lK0oZUEty9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Thu, 11 Sep
 2025 03:13:44 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 03:13:43 +0000
Message-ID: <17d518ca-d35a-4279-b4fe-6930c5e279cd@amd.com>
Date: Thu, 11 Sep 2025 08:43:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 5/5] net: macb: avoid dealing with endianness in
 macb_set_hwaddr()
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Harini Katakam <harini.katakam@xilinx.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Sean Anderson <sean.anderson@linux.dev>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
 <20250910-macb-fixes-v5-5-f413a3601ce4@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20250910-macb-fixes-v5-5-f413a3601ce4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd06e12-d887-41fe-8508-08ddf0e136e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXp5V2NlNlh6bThxdmNDWmVQd2FPN25jMVloQkZtTVlnTG1vK2FLaGdtcy84?=
 =?utf-8?B?Wk5HSFZwTU1lOXJSeldPRTBDWmJBelNneitycmdYRGMrb3NHUnd4dUxMS3FC?=
 =?utf-8?B?MUpHSklCZS9qM3RFR0dtYm56c2FJd0ZMY1p2YWhVeEQxTHpwM2syZTlTWUF6?=
 =?utf-8?B?K3lQUXNFSEJEMXRJZVVmVUhTc0liNHZnMVJRelFDSWNlOHRKdWQyV25UYXNW?=
 =?utf-8?B?d05FVEhWOVAzSUNTWnJxLy9CRlZlWjluZnJjRmZ0T1dpLzYyM2FzU0JzNThP?=
 =?utf-8?B?RWxsMm5tUjBkSm9ySjZOUng4Snd0NjErb3JWMmFDRElvUFNoRlNhRUVqQ3dG?=
 =?utf-8?B?YXlRdGhCT2lKMHVrTG5UWHhYSENORExkenl6TnlPUkw1MU0rK2pTZ1JTMU1X?=
 =?utf-8?B?RU1OMXlack03S2JVaGdEc2I5WVQrOEt1bXpVTzl6OUlVMW96eTBsbE9zTzdY?=
 =?utf-8?B?MFQ1bkE2SWpqcHk2MjM0T0s0Z2FsS0s4V1ZPbzRWa2dTZXY0RE5GeUJtR2Ft?=
 =?utf-8?B?RTdVcnJKUWFvRDFXMFpZNWFpRTFtU0g4a1NjZW50TVRPekFOdW83cmFZT3Jr?=
 =?utf-8?B?OUx5U2xURzBGQ01MamhLT1hrbnFIc1UxQlRDelI1ckZsU3BmRU1GYWVYRWts?=
 =?utf-8?B?M3F2VlZQVWVpV3VJRERja2I2MUpvSDB0dDh6SW1vY0VUM3BPVUN1Y2o0Zmkw?=
 =?utf-8?B?bnZIc2QzU243UVhnSWt5ZkE1VHordG55N2RhV1VuMXdDYkZNeWpYcW5LRjZB?=
 =?utf-8?B?c255OVBSSDRUbTNwOEY3V3YyOFM2bWlRa1VlMis0WVAvZXN4Wk85SVU1T3ly?=
 =?utf-8?B?ZjhlWkJUdHBpRWUwTTFpc3NaSHdTNXFnanA3d3VaUjVPMTU5NEQxNEpDZmxW?=
 =?utf-8?B?VlFDRXNuQ2tBdTMwREgrNFZvYjUzQklNTFlmcjNIQ292UHVDcUl6aUJmRG5s?=
 =?utf-8?B?eEpNVFp4MjBrWno2U1NNd2FheW15WW5NNjJsblorUEpkc3JIQnFuKzFmM0dJ?=
 =?utf-8?B?Y1pPM0xvVU5VQ0NjTis1dmFXUWhUcFVNbDV1OFBFc2plQ0pBY1FQR2RtQTVI?=
 =?utf-8?B?cFJUbkZkZ2hVYVJTWnFPN1grSHIwUnIvdUlzcUg1TnhmZ2FqN0lzbzVLYWht?=
 =?utf-8?B?SEhaZlZNUzR5N0hUdTNUelJtc2Y2dWNPWlREYnE4SGJKUXFRTmVMaGx5dTV5?=
 =?utf-8?B?Zm5odlNRMEU4eGdmdTZGcVV0d2NUYnZqd1lpUjFMMlZ2cFZ5U25VK1R0RkJv?=
 =?utf-8?B?NWFob3FmZGF3NVFNZEVmbFhwUjdVK3NuYUFGSGF1SE9VNXZaRm1WK1BQRmh1?=
 =?utf-8?B?cGwrQ2xFSnFxQnU1VWZpZnR3K2xBcWtGd2p3MGJoOWs4enBwb0RvMXZLY0ti?=
 =?utf-8?B?QzM0S29namcxZ3Z2UnRkdUtScGIwVGlsQkp1NWpkTjFUcmNyWFJlQ0hlUGtm?=
 =?utf-8?B?T2VzZUZuak8wd1g2emZ4V1pzc1hoNHBubHBwcWNtNUwrYkJhMzd4TzM4Ymt2?=
 =?utf-8?B?aFFEWnF4WEJpc3FUSU1zcnRibmtPdTdOR0kvUHRpQlhpamFYTFpNMGpVeTBw?=
 =?utf-8?B?RndTV3pnQi91SU4rMDYzVFBEcGZpOUVOdHUyMkZ6RXU1dmxoSURDZ2NmS0tl?=
 =?utf-8?B?T2hqL0RmT3BVUTUyaHNaRE9GdjZYOFNCRW1xNmIvcVZ6MXR2R0R4emZDSnNl?=
 =?utf-8?B?N2xQZ1hhT1cyREJjWHdQRzMyR0dkeHp4N0ZLcnBXaC9GRVF4eXdUc3hhdWtQ?=
 =?utf-8?B?dkhSQjgxc05jbG5uMTQxcWdlWXdwYStRQ0ZIVlJnK3hWL0ZOb0oxSkVDS1hx?=
 =?utf-8?B?UGNiWm14Y3NYM09KcHRpbGhlZ2I4NTVOdlQxdTNPa3VDWGRnUUVkVStzaGox?=
 =?utf-8?B?cTJJeEJteWMrNDc0czNoa3o5dVZ5QkFvK2hGOGtsY3E2dkM0cS94WlZZK3Bq?=
 =?utf-8?B?MzRLSjhhMFVkOUFFRnhDNEg1dkk3cmpOS1lxVWlmSDhGcjR4R1VDNGxWSThj?=
 =?utf-8?B?Ujg5R29McFJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHdVV3hWaE9HLzRyUTQ1K0tXV0VMSm9XOUpobTdUb3p5OVpaSUpuTzlpYVI0?=
 =?utf-8?B?RVRBSGRGNmdKM1QrUi8rbHNrdW9uTnVoR3NVVGEyV3J2ZHQ2ODlrSW5qSHlB?=
 =?utf-8?B?S2F5WHJ2bjRmWmdGU3NRZSt4dWdITk9wakxub2NkMGdqN09xSUJmZGFqOE9q?=
 =?utf-8?B?VDFybHl1OC8rS1NLekpqSzJ2eDkvYnBnRGsrakVyVjFjc2MwaFlEZzRMZHY4?=
 =?utf-8?B?NVdjUlpRZFZ2d3I4OTJmMWRLdkVOS296RTFZbEw0eTczMDNLaXYyMk5nNVVG?=
 =?utf-8?B?bUN3NGVNRlFTRzJ1Tml3QTVjTC8wSSsvZmVKR1pTK2w4ZWdYdGh3dDVxK255?=
 =?utf-8?B?M1NpanBTZHh4Tk11cjhxU0JJbUplcEoxZS9oL2hTVkMrUnVKYk0zRUQvSDYw?=
 =?utf-8?B?cGRjWUJuQitkQlRJZHpWVjZFbzlHQjFJRkx3Unp6MEhiQzc4RVUyTUp1d1lt?=
 =?utf-8?B?VkJEQ0dyeis1QzhOaWl6SDBqcDI5b2svNmZJRWNaY3l4TmF4L0ZMSE8ycVNi?=
 =?utf-8?B?NVBBSE5ZdmhaT01NMGlaRjJnQ09meEp6SEtURExGaC9wSHRtdExYWENUd05J?=
 =?utf-8?B?Q1BpU0t2QzMrYTNHN2VlaTJuZHJDVFloVklIUlpHa1N0RUl6TWhZUjcxa0Yy?=
 =?utf-8?B?L3JMVzB2b2dFaWs3R0RGS1RFZWpIdDdYV1RPR1NqeUVkVWQramY0WkFvZTlB?=
 =?utf-8?B?bVFZY3FFNTJMWUFETERrbGJMQ3hsSms1OXZ5TWJLNXpSa1BpVHR1aHZCck1C?=
 =?utf-8?B?NWtTU21MbnFpSUYrTUhqS3hMQzk4VDk5S1YvUGM2enBTV2NOTzNkOERKTXhE?=
 =?utf-8?B?YU94eEQzTnZ4blZPTWlpOHI0YW5TWVRNTTV0eVZUS2RvWDRkbzZ3dGdKOVoz?=
 =?utf-8?B?b3IzYVhqR2MrRWpDYXdUM2tBbmN1SzUxTVVuZEM2VGdvMUx3bHhjTGFHS1pL?=
 =?utf-8?B?cFZCZnlhTnlxOVJxUEJSYUVWcUxuMVhaamlKYWw4dWQ0L2ZDZmlzR0I2dDV4?=
 =?utf-8?B?UFQ4TjVDNWJpc2hpa1JEUTIxZjFId0R4WHY2UU5SckV3MXZXYkFyR0ZJKzRm?=
 =?utf-8?B?Z3dmTVRKNzFZR3Y2bWtXODNrQWo5dVdjNWVVZ3BvVDE1VngzT24vL29KWm5M?=
 =?utf-8?B?RVU5R1g5TmNzZ3hTeEN4TEFXeThqZlhGUTJ3eHJ5aU1QVzl2UmxlRWQwM0pC?=
 =?utf-8?B?dzg3TUp3ampEZGJuREIvUGtiRkpMeTF6UDMwZUhRSEQ3NVBvL0hRTFdZN01u?=
 =?utf-8?B?MmJ4Rk9QRTh0Zld1N0hIZWM2YThsTnJxemRoZ1FlOEpNYWFtbXBnWU5yY0Vw?=
 =?utf-8?B?OTZvREJlRFErMFpmZlBBRFM0OG1Ka3ptMGx2OXR1MW00ZzJ2cnl6MDhFVVJM?=
 =?utf-8?B?ZGRFT05oRmJsQ2FobEExNFd1ZTd6UlhDM2R1dVNBcXRCOVhQbTB0WCtDQll6?=
 =?utf-8?B?bk0xSUs1akZLSkxGa3lSRG1ZUm13d3pDbU5jT3VQdFEyNUsrN3RQbDdTVmFo?=
 =?utf-8?B?Z2RaYTUwckN2QzV2NDNIYTBXYkdVWDA0U1p3UzJYRnBOWDl6NjNodnFFanJE?=
 =?utf-8?B?L045ZjdRa0oydEVCT3ZBT1VHOE5Wb0wzTWpOM1l4bE9rc2FveXUzUU9DMTdh?=
 =?utf-8?B?MWNGaTEwYWNveFEzM0ZqbzJ0R0R1WmhKNkFuMzN6SVFtdjBnVHN2NjFmZThl?=
 =?utf-8?B?TGZpakVNQmJyOEwvQi94WXZnOUN1UlRrR1lZWlh6WTAwNlV0aG9nUElNUkhG?=
 =?utf-8?B?NTJxTkdTcDZwWkd3TWF5T0hMc001K0l2YWdIWk1aTXd0VStsYXUvd3JLa1Qv?=
 =?utf-8?B?c0dPMzNhSWhVVEVBL2NvU2FXSEVSTEx3ZDk0QmVZYy9TMUdOa2JvRjRVVWl3?=
 =?utf-8?B?Y1AzVU9udGlVbEN1MkJETVBzUkk4WDRMaHJwS1g4ZWVqZWNTbGxmMWFpc1Jh?=
 =?utf-8?B?ZkI1dXhTTkV2eHhkTUFmSTZhRitabTVLbVRaME9DSlpsdTNwclM1N1hZWllG?=
 =?utf-8?B?ZlF1QysvZlY0TkI1YkZxRGZFbDUxMDhJZDVkL3p5ajgrT25RcDNXNmNOblJP?=
 =?utf-8?B?bWZtRGpRT2ZaNEFEeDZwNjNOR0hhcDAwajh4RjB2UXRqNm9HOVZYdi9VemFt?=
 =?utf-8?Q?rvNnqcNt9FRey+T8MN5RGRHtu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd06e12-d887-41fe-8508-08ddf0e136e8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:13:43.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwzcIgJrU4daG9VWFDzbqFToJTeKUIIrDDYWRgk3Uf2gI1IsZM2fkuT9KO+GzAP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

Hi Theo,

On 9/10/2025 9:45 PM, Théo Lebrun wrote:
> bp->dev->dev_addr is of type `unsigned char *`. Casting it to a u32
> pointer and dereferencing implies dealing manually with endianness,
> which is error-prone.
> 
> Replace by calls to get_unaligned_le32|le16() helpers.
> 
> This was found using sparse:
>     ⟩ make C=2 drivers/net/ethernet/cadence/macb_main.o
>     warning: incorrect type in assignment (different base types)
>        expected unsigned int [usertype] bottom
>        got restricted __le32 [usertype]
>     warning: incorrect type in assignment (different base types)
>        expected unsigned short [usertype] top
>        got restricted __le16 [usertype]
>     ...
> 
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>   drivers/net/ethernet/cadence/macb_main.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fc082a7a5a313be3d58a008533c3815cb1b1639a..c16d60048185b4cb473ddfcf4633fa2f6dea20cc 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -271,12 +271,10 @@ static bool hw_is_gem(void __iomem *addr, bool native_io)
>   
>   static void macb_set_hwaddr(struct macb *bp)
>   {
> -	u32 bottom;
> -	u16 top;
> +	u32 bottom = get_unaligned_le32(bp->dev->dev_addr);
> +	u16 top = get_unaligned_le16(bp->dev->dev_addr + 4);
>   

please change the order as per reverse xmas tree.

> -	bottom = cpu_to_le32(*((u32 *)bp->dev->dev_addr));
>   	macb_or_gem_writel(bp, SA1B, bottom);
> -	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
>   	macb_or_gem_writel(bp, SA1T, top);
>   
>   	if (gem_has_ptp(bp)) {
> 

-- 
🙏 Vineeth


