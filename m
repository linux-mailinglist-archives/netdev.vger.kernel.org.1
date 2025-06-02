Return-Path: <netdev+bounces-194572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3E7ACAB7E
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FB8161F71
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AB1DE891;
	Mon,  2 Jun 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="KnMXc7X4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1362C3249;
	Mon,  2 Jun 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857118; cv=fail; b=et4ilTibEqFNjBLVJk9oblMHPkFq/jZ+P96YMAmn2umvi03DEJLDrsH/Wj52oxKw48vJFly4IiU2z+U/nxWjDIzgpeLuew1k25NJUntNuikkQK0mpu+cwJRvZm717Hw1eU5+vKhIKo4RN1EGHDOWng8T6A+zMtFx9Ca8+FLQrb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857118; c=relaxed/simple;
	bh=UpzbMfAAlCFOXGeTmdjf/5RurVxJllkOQNWyWlaFGtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pU6kC8aMAu//xJZ1WG6bZ1ZCzXQWQdUPEyxx17/+13WtVOqVoYxcwirG7pAq2Anbi4PZZ5xG/cd87EjQhb/3l2o4gWSp3SjFKkYFgu2mGBC+2VEfGEvvmb7/cAyM6RpwXpWv7453XX9nY+qMRioadDFdLLo3U+dZOF3gWJxS01g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=KnMXc7X4; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlrncO+H5DALZ0sN8MEIQYKAviZk+fDieoBL3v518y/NadT0tmXgqJFFttrPBgqqOtr2/S/tqZkbyOVT12Ju9Y4g7+7G4v+44CSt660LVFvpqkZung9edBJsy3bYNe55D9fZwqsQH6HQx7DBs/J0M6SJrGm6krraU6qf4ybDxrITuLccxZMvduqimS9zGRX6knTfcMj/J+xhcqH171oh97agzRVxKNLAozMd6qWWhbFYg96j/Kzn9s3zqBnZ3GHvb48DyQ+SPAmquRGzXMloZn6SrRik711FwOwVE916WPntr09VE+BCgyGNLVDvCosl9hPLPeKWPf3bQLE1SbY5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmFAq+QSJoP3+fnGu8m1hDfaAXpwtms89R4Mc7eBlR4=;
 b=jzNLPSaWVV8ood8CB70ahf4YQdpao4e1RNv3te0CZIQk1F6WldZ0SWSWo97gKEAU9qFzjsrgL+pfI1l09SxDLpjg91ydIYpovtJUXCfVPgAr5BRaUixUF1kzMVHM3bAYYAcOAeGBXDKR9PT7i5Z9hR9fbqWlHmaymXkErPNyWrEwxURB8Iqy+QYmC2sQOVEpUFi6WhIVxF5JEOc470UtbFrcHtZLaNj6JBdHhG+J5WvmapowAsEMTUls/HHoSsDAx3Vf2br5G5BLjiO0fX3ERgi9G/KGOMhXSiU/yGjGHAM+tcvO4b4CHW+/Oi6tdLg7119cqFWOcuqDBR1SmuCV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmFAq+QSJoP3+fnGu8m1hDfaAXpwtms89R4Mc7eBlR4=;
 b=KnMXc7X4VwqZhVOPe7RfoeP0NNFoOSVyj1f+DBJ9FFcBKwCftrCn8mVvPPSF+r/FeSJKtkbqzzm1yJ4WEpj+thg+atQ+N7QTdggXy/YQHDwgEfaBsDsQ4HEDEzc9xQI7y5EsItv68nGusVV70At9yZAukTyKfa1BdMpKJpGsmpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB8001.eurprd04.prod.outlook.com (2603:10a6:20b:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 09:38:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 09:38:31 +0000
Message-ID: <e912504e-651b-4992-953e-1a239cbf2550@cherry.de>
Date: Mon, 2 Jun 2025 11:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: platform: guarantee uniqueness of bus_id
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Paolo Abeni <pabeni@redhat.com>, Quentin Schulz <foss+kernel@0leil.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250521-stmmac-mdio-bus_id-v1-1-918a3c11bf2c@cherry.de>
 <b3e3293a-3220-4540-9c8b-9aa9a2ef6427@redhat.com>
 <090efb05-eb2b-4412-aa85-16df05ac9fb5@quicinc.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <090efb05-eb2b-4412-aa85-16df05ac9fb5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: CWLP265CA0456.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1b7::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cfda0b-217a-428a-2d41-08dda1b93cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUlQczBLQUZCRGFZODR3MmZZS1VGZnYzQk1BSkVNbTcrWXk3TnFUd3Y1dk1s?=
 =?utf-8?B?am96R05GZDVDR2JzN0laSjlnVkFRejJtYjE1WUtiS3F5U0NlbXNDeVArVWtV?=
 =?utf-8?B?OUpuSXk0emRSUVh0YncwVnE3a0t0NG9GYzNreXV0eDg4SHVnZmhZUVpEQ1F0?=
 =?utf-8?B?MUg3OFpqZ0NLZjRjendJcG5FOHMvS21LYUh2ZHk5eEVOR0xDb2Q3VllYUWZ0?=
 =?utf-8?B?UUlGN2dkbkwwTUZ3enBwSXRYOHl1QW1jenVaOEVjS21DSXpWd2oxMW50bnFz?=
 =?utf-8?B?blkvekk1RWN1ZUdxelM1M3J3Ly9SNkRoSFRkU3RGU3o1eW04YWhObkRjOWpj?=
 =?utf-8?B?T01xZ2FLS2ltV2V6SEpaMkdsMWNGYUVSYWlaL1R3cU1kWEdEUnNINDFtOVdq?=
 =?utf-8?B?WnRrZ2x3cnNxdG5CT0ZOUnVlMkdwSWorVmczcWNpNERtK1ZQODYzOGkvbFhE?=
 =?utf-8?B?QW1IYlY3NXlMRHRwbG4ySzJvcGh2NEpCcjVWVlRJUlREV00yc1MxVFR2S0Zm?=
 =?utf-8?B?NHdNTXhjY1YyWUJ0bCtUTnQyampMeUtpc3ZpLzk0aWFrc2Y0L0VrdEVxR1Ur?=
 =?utf-8?B?ZWZ2UGN1THY3eDh4ZHdlNkRmUmdhZE9VMnkzY28xdkk2dkE5a0ZkM0lQbEIx?=
 =?utf-8?B?VzQzM2tkSnhqSzNJcjhLVTZvV2lldUlEaXRxYmgzWlJ0ZDZBZk1WektYUkly?=
 =?utf-8?B?dVAwdmtRa1VYUGVpOTlMZmJBd3FoS0U2QktlQit5MXhaU3d5OEpMRmxVeWxu?=
 =?utf-8?B?L2Z2T1A4c3BlT1pwRUFkZVNFSE1BTURBYm9KSFVGdWs4MllTSU1kRkJ4dkM4?=
 =?utf-8?B?YWxSbVZHN3BSWTdJSFpjbjNHRUxJZVZpVGVBaERQS0YvckpnSEI1d1ByT0x2?=
 =?utf-8?B?NUxvMGw3Z21oUUk4dkdQNTNhajdJTUU3L2NMcjB2dkpRVEZLWXdxODFJWFN4?=
 =?utf-8?B?blZyNnFVcytuOEZqMmVIVzROVmsvTmFaTklaaEYyZjhrRWlHS0FMREt5elFo?=
 =?utf-8?B?TFQxY0J0US9wSXNuVUV0ZnpzWWlWRUlFdEtWTUdxbmtYR0FWOVA2L2hjVGxq?=
 =?utf-8?B?di9JdEY5N2FRcDlNOEl2NWlwbW52TEFWNTFnYWZ2anFLVE5GMDJoNGJtMFFT?=
 =?utf-8?B?RG91WVo3cVZvWGJBbEZmZ0s1T1NlWFpNR0IwSGJ1K0ptS0xSajJyZGdCSWNT?=
 =?utf-8?B?QVcxbTVTMWIyMHRKUERxcnNOc256TU8rY3JlNVc4QkJweWRXZmFKL0t6OVJl?=
 =?utf-8?B?dkI2WDZoeklCTC9HdThJZ1ZodCtlU2ZBRFdHdFgrazJJaUtjcXpEaGp4K3VS?=
 =?utf-8?B?ZnVSbTE5T1dyMS9uTXMzZWxPdDkvRnRSUE9SYW80UFBLdHgwY2xud21INHFl?=
 =?utf-8?B?dHVyblJtS252M005MTFoTDBnYVFhSUNqWEI0WFFxZEVOMUtmRHE0bHBsQ0p2?=
 =?utf-8?B?UC81aE9obWRXSEswdjkwVjFZeGM0S3NJMnU5MDd6bHhGMW04TUJCbnMzdnhh?=
 =?utf-8?B?N243YzV5Ti9YcmlGak1RNjdNU0o0SGw2Nk02UWFIU3NvTDNwbmlMUzRLejFz?=
 =?utf-8?B?c3czbXQzaVAxaUJBQWtEckJ6aXVUbjVyNHcreHFMdFZybm9YSFpEc0NEZFV6?=
 =?utf-8?B?Tm91MDUvMy8rdFRqUFFXbEY0Y081enVTbmIvVXhDMUh3VFAwQWR2ZGdlci9R?=
 =?utf-8?B?cmJ1UXpxVnppMk1ycWVWVGw3ajZpTytCL29KTmxUVTJhM3Awcjg4aWpTWkxh?=
 =?utf-8?B?cmZYQkZqeWE0YzFFSFVMK2JET2RmQUZRblpLb3lkcUdGQVQ4dlF0N0R2YjVY?=
 =?utf-8?B?S0tpdUxWcjlyRXhzMkZBZ3VkdmFlVDVTRGNCa1MveURKRGYwTWZxWGhFbWxE?=
 =?utf-8?B?TFg5Zis1NFkzai9iYWlVa2lEM0h3eDY2aFFZUVFxVnYwejlHRUsyNzUwL2RM?=
 =?utf-8?Q?1zNNeZUabsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWVOL01xRHVMNCs4dEpTczloZHB4VDQrb2lCOGNHc2RVSDhYM3M0MXc1MUJR?=
 =?utf-8?B?bUNqMWx4Wk5zcDVpSGt1TXRSamhDZXQxdTBjbldMV0MvUE42eVUwRndxaGRQ?=
 =?utf-8?B?ZHZTRjlldnowR3MrTlZXZ3ZUT2huemZqQmdVL3ZkU3VEWE5DaWRmUFhFK21E?=
 =?utf-8?B?SG5jWDFZLzhRcWQ5eUVaVU83RnFRa2RkTlpBeC9ITUJjR3FzVngxZlY4UzAy?=
 =?utf-8?B?ZVRyYmJadVJnVy9reXVudTRFaDVpR01UUTh2MWZFMFJjOTFBa00vODNtVHR3?=
 =?utf-8?B?Z1Ard2JGMTJQYTVsS3RNa01QUG5QaEFtdW9Yd2FIcmwwZy9oVnUrR1VnRUc4?=
 =?utf-8?B?RnRtcFJDOXJUZE42VXlxbmt1TVByeGNESTFRMmgvR255Ly9RQ0pqR2VFTm9t?=
 =?utf-8?B?blBOamxhbG5OZTVWcWZET2VkdUFqaHNKUVFrUmdDL2pkT0Q5NnEzeTBOazhP?=
 =?utf-8?B?aG1jWGNiVVBycm1mb3RWanNpa2p0aEJKNXpMQkI3aUxMOFBxMXlUM3NCRlg3?=
 =?utf-8?B?eWxEcDd6YjdSclY3eE1HY1VaUDNFc0ZrcXhlaDd6WnpubE95VlpNdEdZUDNw?=
 =?utf-8?B?eFRzZkpLWER4ZENpRHJCNC9lb0psa0xlZEo1U215QkxWTC93TlBuVVhnSW00?=
 =?utf-8?B?dDNpeDZaT0hjdWovanlNbjBmVGpPVE4xR2plZ2I4VURnVGhDVVZIeGhJUmN6?=
 =?utf-8?B?YURwTGtJZis3c2h1OE9ReVpBN3ByMUVDSWJJWTEyZGJBa3QzMVZrR0JsRy9i?=
 =?utf-8?B?S2djZldYb2NQR3RTRkh5VFM1Zy9wekM4ZFJhK3FDTkYrOXQyd1NTVk9ZbkRs?=
 =?utf-8?B?RSt6UEN6Y2RoWmgvUW5TdkM2cWY0MXBIOVBOdGt4V1Z2NVV3cXFucEp0QjMv?=
 =?utf-8?B?T0MrdmpGYmJzQzFCelVBMHZpWnlTUC9INjRYVVZqeG1oRzRpMHBuQjBUN1pW?=
 =?utf-8?B?ZEE5RVd1T1BucG9xRVpwOVBuVDNSMUtaN2xFU2Q2TnY4QVFtaCtTd1RMS08w?=
 =?utf-8?B?OGNzcXJTaVUrRWd2RzB6cVdyRW0vZ2tpb2pqeS9TVC9IRjJNVGRDOUZMSDdj?=
 =?utf-8?B?enZtVVpNQTJFajVMaTRHUmsyV3E1VjdQK1FFYXlFbkE4SDZmaGpqTkUvaGNP?=
 =?utf-8?B?LzRUS25kYnpSaU4yYXFzNEZtV3VNVHk0QldjeVJ5VUh3a1Rkeko0ZlUrRmhs?=
 =?utf-8?B?NDRjeitueUpiaEdacFFIVWtkQXcrUjRjb0pHNjJMdWxseG1SY01wTlhzd2Fo?=
 =?utf-8?B?UFNjQXlSS1ZYblhzRHFtU0dCN2d0MXJwWGI4dDFTQndoMlgzNmlrc3JUMFFs?=
 =?utf-8?B?UnFUZ0xtODNOREEzSis0ZEt0ejhNNHF4VGx5OXJseTgwZlBvMThZOWI3MXpo?=
 =?utf-8?B?TzJ2RFB0YVEzYzAvSEpobDZ5WXltVDYwM3JydjhHekZoK21Hbnd0b1BvQ0JU?=
 =?utf-8?B?SkowMzN4SXhtOVhGNkcxc1lQbTJKeFpZZWJqL0NyMHNyejFOOGtRMFBsY0JP?=
 =?utf-8?B?emp5Nm1tQzhRcXJwUm1hTXg4TDZtbkFsaldxNStWSWRwN0tET3NBTzFHaFRY?=
 =?utf-8?B?QkhIdUxVU21oa1lhWWVVVmo3SSsrQWtCYTZ6U1dSZ25WQXpEdnFDVmt0Zno5?=
 =?utf-8?B?aGxOemNONlFXb3BpalpYenpFaWZ1aGpJKzVjMXNyOU80cEEyNkVSZ05xQytM?=
 =?utf-8?B?ck9wR1crS2huMlpxZHpBdG5hcEJCdHl4akFyRGlUYVBpU2lhcHhMY3l4RmEx?=
 =?utf-8?B?dFVJR3RwTldwOU51WHVFUnNhdCtsVktpSUNYc09Ic081a1ZxZFlUY3RvUGE1?=
 =?utf-8?B?cURkVWtZdDRrTEVmM3B4WkJpNVRzY1JEajBtZEREWTdNeHFGVUYrUnJySWNZ?=
 =?utf-8?B?WlhLRzVVL2EyeDdQT2tHcExWTEFOKzZqdkZyRm5PL0FZcFZIOTRUaFZQdENh?=
 =?utf-8?B?WSsrdVV0S1Y5dzEwOXRCM1AvMzBTTjR2eU01dUsvaVdzOWhDS3ZlWitFdS9i?=
 =?utf-8?B?SS9KeS93c0FwTEVUREo5MWU2RG9XQ1FSY0dETno1OG03SnU3L3JOSEtkdHBJ?=
 =?utf-8?B?MDA0Q3lNcExudUJ5NmJtajhLUC9jMXFoYlYzOU01dFdZRGh2bE0rWmsyTEVH?=
 =?utf-8?B?MzRGODJrWlgwdG9PSytPYXM4QXl5T0Rtenh2ZERhTzB5TmVmV2I0L0JaRktM?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cfda0b-217a-428a-2d41-08dda1b93cc4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 09:38:31.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjZrxOL5mfUs5+xKRzYBhjz1Nv3YmgKqIQUy+1nYYxeva4uizdABuwk2MUC2ZwacuF8el5Spqv6YXLUSt9+vortLtnwniTQqQzLoBZej9AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8001

Hi Abhishek,

On 5/30/25 12:16 AM, Abhishek Chauhan (ABC) wrote:
> [Some people who received this message don't often get email from quic_abchauha@quicinc.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 5/26/2025 1:26 PM, Paolo Abeni wrote:
>> On 5/21/25 5:21 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> bus_id is currently derived from the ethernetX alias. If one is missing
>>> for the device, 0 is used. If ethernet0 points to another stmmac device
>>> or if there are 2+ stmmac devices without an ethernet alias, then bus_id
>>> will be 0 for all of those.
>>>
>>> This is an issue because the bus_id is used to generate the mdio bus id
>>> (new_bus->id in drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
>>> stmmac_mdio_register) and this needs to be unique.
>>>
>>> This allows to avoid needing to define ethernet aliases for devices with
>>> multiple stmmac controllers (such as the Rockchip RK3588) for multiple
>>> stmmac devices to probe properly.
>>>
>>> Obviously, the bus_id isn't guaranteed to be stable across reboots if no
>>> alias is set for the device but that is easily fixed by simply adding an
>>> alias if this is desired.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I think no need to CC stable here, but you need to provide a suitable
>> fixes tag, thanks!
>>
> Quentin to make your life easy.
> It fixes this patch
> https://lore.kernel.org/lkml/1372930541-19409-1-git-send-email-srinivas.kandagatla@st.com/
> dt:net:stmmac: Add support to dwmac version 3.610 and 3.710
> It goes back in time to 2013 when this bus_id was introduced through dts
> 

Fortunately, we ended up finding the same "culprit" (see v2 of my patch 
that got merged[1] :) )

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eb7fd7aa35bfcc1e1fda4ecc42ccfcb526cdc780

Thanks!
Quentin

