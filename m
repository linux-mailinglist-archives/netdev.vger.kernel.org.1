Return-Path: <netdev+bounces-179582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BAA7DB96
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9773B01D1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545EF238D28;
	Mon,  7 Apr 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEb8xO7z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C8235347;
	Mon,  7 Apr 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023216; cv=fail; b=TekQs5snNdtKCA0RlcFftzAf0XOxQfHzFIIM6tUOJQheWPCKABT+F9xflApB8Ab5GydRu9dRq8HwE17HElcM2AxmZ797xDHQk2ugrHO3c/FZBTEpfIEDJBK2EMXyljTHDNBpLPSVN8N+8vtmJMx+5w2m/6bj2ph2bBqByMPxvYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023216; c=relaxed/simple;
	bh=A1JosHR8QJhgiDpLsmIj8d0Xb0DWq/Xn2Rs9O/eiFJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CcsXh0cj67FlbiTDTSyfV9zoyWwK1DeGdoxRsFNHwAR7jlvRcTs3Z/oeuPNO0wk6PD/iOJzRrgG4t9wD+6Yk6hY5QE4J8LgpY3nZXGmFjd0IVygeHemuZI5NIyjSq0YOxKN923KWT+1jWlr6Wi9nc1PdCWvBUwYNepB2MA9zmrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEb8xO7z; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1Y4Oz9iuJXAstjJ3IICVg/BT7I8zPGtGAtqFeSrFboe2yIxrNp/rQUu6sHbJxCzcPRCI+VR1TsXKgzsb4B07TahmWdQkQ9qOLhOR7pN0Udtz6Z4fBRjXjkKKj9r/dkecGO8VjRRrwH990tgLsS7CPMCqnQsg3rsF0KjIdfRMKcQXn+0trKStuJIxcQtN/PU//VHVQHqLAYJ3l1rjC/RwwmkWeqyvuXYVq13pjf91Jtf2bV2UN8PKMgWfAdUKrQEikYGpAZFvUmM54ma2rkkb7B4UQf8UVS+/jNuBBKpwn8X6HyGe6bgpyq7WIrOVURHOMmSaWfLdRJJF9HHd1FS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw2kIK8HMRZc28c95iRW9r2ggVwhJKMFfAu5p2pV8Vg=;
 b=jdI3HJaZOsCHvi83N/PSs6w1h7ZvYj2opqD9NqbhwiPp8zkFCWMf+7wz/xnAsR7pp/bO3jW/qO6MxlKdLm6uO0bOTkPkL5WukyOAGyOgivMZfo18w3ifghMwvODDKQasSdpC23HlCY73Flw5l0R+PRRaZdlhHU0NpCE5pr3W+ZHn+p1mN+yRXgjg7+rdl/+GZ+FvxgdCpipcNpkWC/iDUPN9J3kbVzLlsfIK0dVZ29MFEDoKGwru/Fe76fSLHSF5B/fAG/qLxwyM8QpjE5UOiZ30mq904DYxCBddKDKX62yeGn75F6IGfZzjHyc9zAplz2Kf+c8oh++jzeqlAeRu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw2kIK8HMRZc28c95iRW9r2ggVwhJKMFfAu5p2pV8Vg=;
 b=AEb8xO7zsMsYg/Rw2xfesYJNHxBTAxqFG0VWQCg/MdRO0ZqGUztC0zFgdIo/rE2uKhSov4AWTAr7cETD/JEnPE0bDgfU9eh87g/Qa7jtlWC4d8hpgGnedMiuivgPJGYyMSVZATvMbQm9xGmx1Z1s+OiH9sKJF1riF2aZvTyJS7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 10:53:32 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 10:53:32 +0000
Message-ID: <c0f95226-7a7a-470f-a64b-8b5064568e80@amd.com>
Date: Mon, 7 Apr 2025 11:53:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/23] cxl: support dpa initialization without a
 mailbox
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
 <20250404170554.00007224@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404170554.00007224@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0403.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6b6bb0-3e81-48af-fb18-08dd75c26fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3VuNVJOcFJSNE1PRnlIMElMQzNRT3cveUpVNjh2N3V5bFV1K2p2Mndrc0NG?=
 =?utf-8?B?NzdpelhzbzV0YS9zQVNmY1lnaEVBWEdnc20yOG1rNENmT0NrR3JWVFhFOVlZ?=
 =?utf-8?B?WU9nbHpSaktQV1EzeFphcTIrajduN3IwK3Qybk5nbXpwaXMzQm1SWkV6bnB0?=
 =?utf-8?B?SUVid1lmc1pmZ1F4Si9IQTlJZGVLZFk2KzBybExVOHkwQ09Vdk5ZNWlOQXN0?=
 =?utf-8?B?UGp2aGduK05JbUFDY0d0cUlBVVFSRm5icEZMWmdNN1p3L2R3cVVKZmw2aTcx?=
 =?utf-8?B?ZnU3ekxjQ09DcnBINHA1ZldpMzBDWm80UFJsemtZRUpJZmlkRHNObzVHVFIw?=
 =?utf-8?B?aDlBUFBObDNGMXBxcVJzL0dNVnpobStvUmwzb1doWklIdXp0UWNhQXpsTW9h?=
 =?utf-8?B?QzlWUS9UN1M3TklDNXpTNGNBcGFyTU1iWDJIZlhrZW1lZkh0bUVEQUdrYlRJ?=
 =?utf-8?B?MkZzK0FHUmtjQ1JjbXRvdDBJS3lDdTZkU0xNeitOYkxvTUZuUWNSVVp0eWYr?=
 =?utf-8?B?Q2pjMWszenlWenV2RW9QRm5KM2dzY0UrNU5hUER5VzA3am1qVHFkZndjUGN2?=
 =?utf-8?B?N1JsZVpTSm5rQ0FRUU82S25DT3dnSk80M004WXdobDR5VjI0azF2c2xiUFE0?=
 =?utf-8?B?N1kvelI4eS9jUzFOLzFhSklVaVhVaGtOaTV4cVAxc2p4MzlEOEhRbVlWVEFi?=
 =?utf-8?B?djU2alp4VkFlUkdMY3E0cksvZ1lXeWRYYVNIQlNaMFZpWFlmMzdBZFVoTE1D?=
 =?utf-8?B?b2FPOUdLcjhKK2t4bFNMa085cCtIT0RDY2tvQ2tSY2tQdU9ob0J3NkRsdXh1?=
 =?utf-8?B?M0ZscHB4eEJ1RFIwRWd4eHJjYnVPQmlSRjdGTW5uNVpacUdFc251aGR4eUQ0?=
 =?utf-8?B?NjRqWU1jRDBtaDFML00xSlppV3hGcEpQZlJwN2ZSM0tSL213OWN2VlZFL0h3?=
 =?utf-8?B?cStIMnE2RVdUZi9SZXkwOERBU056TXRqWHkreFJuUmRUaXNqN05sbUtyK2N6?=
 =?utf-8?B?djF1RkNndUlyTjFpWGkzNG1zMGh0MCt3YW5wSFdTbllCSmt6ZndSd3B0dGw3?=
 =?utf-8?B?MWhtTEMxeFBvYlFtVnhGdzhTekZwNzhZd1BFU05Lejd1ZG1hNE1mUnN6aytW?=
 =?utf-8?B?blZjM2EvWm5vWVhFbnhtNHRwRzVIbHMva0cwV3ZSbDNWRzI4bW4ycG43YlVZ?=
 =?utf-8?B?VnZqUG44ald6VDlVcmQ4U1dmQ0xCTzhxQ1F2L1BJNkFJOVJrV2JkN1dsdWRt?=
 =?utf-8?B?TmdFdlZwUVBqQ1BmeWNSS0pvbDdFR0tIZDl2Y1VtR1RFVHVRVEU3Y0xPYjhI?=
 =?utf-8?B?SUhuaWtrZjhUcW1qT2dpcHJ5NXhYWTFMQUpkZ0xjRHBkOU42WldXMVFzbDk0?=
 =?utf-8?B?Y2VTNVE0MjVCTml2cCs4MWdrMnVhd2IwQ0pyUzNFekdSY3pmS0tLMFF4Sitq?=
 =?utf-8?B?Y2xLblJsVlAyY3V2MW12YzZod0QvUStlTFd4UDFzU1NTb25qa1pOYlZ5NHhI?=
 =?utf-8?B?OGl6NTRIak85YWkwdWNjS3JxYmdUdUR2aVNOUkhvQ0JpVHh5YWlTd2RoZkRN?=
 =?utf-8?B?RG16aEFTakxTZythQUFISjZ2VldLVDM2S2Y1Mytia0JPZ1Bha3phQVNEYUdt?=
 =?utf-8?B?cjd1NlBrK2c2Y0RCM1dtQTZ0L0R4eDJoQmlQV1V3bld4akZmKzUraG9LY3Fs?=
 =?utf-8?B?LzhNaFdTc082bVFxeHVuOHA1SFhDb2tadGpEZzZadEV1a05tb3pNcG82cktp?=
 =?utf-8?B?ZHdNc0JtdGliU29nTlU3U2R1ZW83bFhQQWc3R1FkVEZuemJJZGtsa0c4NXdQ?=
 =?utf-8?B?blRxb1c5QWNEcVZEREUwa0M4TUVjR1BCSVBEbWhydzNIM2VwNGs1UGZ4VTR1?=
 =?utf-8?Q?ogZ5vdGNjp7Ax?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmFrcEtzR2poSW55c2krT2kwT1Q3WWJ5TDhzNkhxV3dCbEJ3eTRtWDBtM3dl?=
 =?utf-8?B?WDFpNVJqbS9HbXZkUTRua09zR1d4Y25rUnJBUitjSWkrUFpSelhOL00yRHR1?=
 =?utf-8?B?aXlVLzFwY3FDOEk2UjZPZG00c0ZhWXU5WlBlcCtncFNsMzFpTjJGa3FidzFI?=
 =?utf-8?B?NGF1QjNucFhMWko0SnJDL0M4RkgyeUQ4RFdnSUJlTjNKMWFQUEYzWWxSemx6?=
 =?utf-8?B?ZzN4eDBtSWVSbm5YODUxVEY5OHNqWDl4ZkRQQ1pjZHRxbm8vL1Q5WVY1Ritx?=
 =?utf-8?B?WmNRWDlOT1RCelU3b3pEcXMrWFNIL2VxWFNHYmFYeUJ3WEMxemg1V3Y2WDBs?=
 =?utf-8?B?cEdIVW5EWHZLb2s2d1U1d2tSYlJIYUFzMzBWT3B2Q3VJMkhNU1doMWw2Mjdn?=
 =?utf-8?B?OCtUS1RFb3VMZFJWY0tPamNKb1BEYW9qN2JFSTRxcDN5UmhvbUtLVldaaFA0?=
 =?utf-8?B?WDJuQlJjblR3UUhDdTJMTk9YMy9DY09aUWJsallNaDl4TngrNEcvUmkvT1JB?=
 =?utf-8?B?VGEyZHlYRWw1REliSSsvT1kyYklWNmJwMlhvL0JyaUYyd1lkdGxGY3djcUkz?=
 =?utf-8?B?N2FiQzc1ODJpNVVDeWVLTlpPczhSUUkyY1NNOUhwWWRIK3phMjNoRnI5OFdQ?=
 =?utf-8?B?VEJJbVh4MXYxcklRc3ZKMnIxVlp0ZjQxOXAzdDJCUkZNcWRWSXowZk13MmlG?=
 =?utf-8?B?TTMwaVRIT0hHQ3Y0WWlPVnVnbUg2VjF4YzNzZUxMK1h2SnZDNVlYY2thaW9J?=
 =?utf-8?B?cVVIWnE0YXI4RjUxMm95aCs0MmhyZHhqTGwwRldQT1FSUUJLUzBOYWxZaGNa?=
 =?utf-8?B?RFZBUlRUS2FDQ3ZYWlFPSWMwL3NYRDJIYktLNzVEWnBBRnFBbUFHWE5IcVRC?=
 =?utf-8?B?SkUxVWhnL1FLSmRSY2hESncwSnB2dzN6blJKM0pHQVQxbjBVVjVHOFJDaXNQ?=
 =?utf-8?B?TmJNWUx1K0t4T1RBSnhjRWxtWlVWMVdtblJZaHNMRXR4clE2SVNjQUIxVWlE?=
 =?utf-8?B?UGFtQUYybjdYaUtvTUw5MlBGVVZSMzlhY2VSalVUaWNRQ3d6emFQY2ZYdzRs?=
 =?utf-8?B?MG51SER6MTZoMnNNUUdqTU1vUHJMTnl6ZS90djVjYmFkOWZNWVhBd1BXOVQz?=
 =?utf-8?B?bnI3VlVxczZzc2xETC8wM0RhUVpmM3dzeURKbmtwUlA1M0lVNVdFdTVYQWor?=
 =?utf-8?B?NHJaUzRIR0dORDlxTUZkV3o0bnVXTTltUVI4d3YxVW1GeWdtaXJVdVZtYXB2?=
 =?utf-8?B?SUpjNUNVUEVCWGNsTkM4TU9HVGJUbHRVS28yMFhQOUJqdXRNdDUzZ1pmeUNw?=
 =?utf-8?B?NkVJVFN3TGEwWnlRakJIYnhJMHk5eFZyczZ0VVlSamY5YzFKSWlFaDJDOTBY?=
 =?utf-8?B?MDJ6WnVLeTNPU2NKSEVUUHZZeUJna0duWnErcWRBNTljNitKNCt1QWhrVWo0?=
 =?utf-8?B?RGp4c01MbHRaM1pNbUtGcU9qQXhMYmRPOGwwRm1uUTkxWmlzK0RyeFF0d2hY?=
 =?utf-8?B?bnZ0ZGNlUTk5WjJLSXVhOTlEN3pJSUdZcW9RQUVDdFhQRVVCbUg1aHd0ZEov?=
 =?utf-8?B?QUZ4SXpTK2gzM1hkM1kvS1Fkd0lBRENUVElGS1VpQWhxaVprQ3Q0TGN2TjNU?=
 =?utf-8?B?MUxuMlBMTDVMU3pTMVdEb09KME9WOEhIZGI2NW0vYldCTEV5ZzljRVkwdVMw?=
 =?utf-8?B?Zi9hVHh0WDl5MjRUV3R2MnNqVlNWMTVGTEZ4akluY2U3R3FzWE5ESkp2SUhy?=
 =?utf-8?B?KzRnNk9wVTJTa1NVWk9iTXF1cUg0SG1Rb3dTVXplK3VRZi9ZbkpzQUorL1hw?=
 =?utf-8?B?YW5IelN4V0x2azZrQm9BdG15V3ZxczNlQmhzMkt1WDM5V2gxOU5ySFJ2MWxR?=
 =?utf-8?B?c1dGd2ZMMElxYmRrRVd2Y3FobklKeEg3TW1EK1pXL09BSDJFWUlSbU4xZlpR?=
 =?utf-8?B?SFJOYXM1MFVOd3E0bnd0dEdXeE41TjhNQnplUGJCU1Z1RkZuandtY3BqUnFu?=
 =?utf-8?B?VzhJOTd1Tzlua1VNNGZucGF2NzBGYXVoeHBNUTk1OVZMMVhPaWxtakxIM2da?=
 =?utf-8?B?UmZ2a1p3djM0d0ZDVm1YTXh6UVBubE9wV04wUVZUUkVZN1poTVJPeVhscHph?=
 =?utf-8?Q?ZWIRyHvVc5ZpO9hYP08zqUIn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6b6bb0-3e81-48af-fb18-08dd75c26fe2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:53:32.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/lGG2vuhff0CkMhvv5L81v6CQZ8u1Q/282cA1C1B6vDrsAH5fxyvdgF8im9P8awM5Mpr6K5s6kvyJ6rV0/Fug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487


On 4/4/25 17:05, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:39 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for dma initialization.
> DMA
>

Ok


>> Allow a Type2 driver to initialize dpa simply by giving the size of its
> DPA


Ok


>> volatile and/or non-volatile hardware partitions.
>>
>> Export cxl_dpa_setup as well for initializing those added dpa partitions
>> with the proper resources.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>>   drivers/cxl/cxlmem.h    | 13 -------------
>>   include/cxl/cxl.h       | 14 ++++++++++++++
>>   3 files changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index ab994d459f46..e4610e778723 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1284,6 +1284,18 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>   	info->nr_partitions++;
>>   }
>>   
>> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>> +		      u64 persistent_bytes)
>> +{
>> +	if (!info->size)
> Why?  What is this defending against?


The new function is used by cxl_mem_dpa_fetch as well for avoiding 
duplicated code, where size is initialized before the potential 
invocation of cxl_mem_dpa_init.


But with your heads up, I think I can just set the size unconditionally 
and to change the caller in cxl_mem_dpa_fetch for setting is if such 
invocation, because partition_align_bytes != 0, does not happen.


Thanks!


>> +		info->size = volatile_bytes + persistent_bytes;
>> +
>> +	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
>> +	add_part(info, volatile_bytes, persistent_bytes,
>> +		 CXL_PARTMODE_PMEM);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");

