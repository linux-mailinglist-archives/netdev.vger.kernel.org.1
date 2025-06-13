Return-Path: <netdev+bounces-197427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E530AD8A26
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B784C16A26E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22326B761;
	Fri, 13 Jun 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKUekF/b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD51E5B65;
	Fri, 13 Jun 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813359; cv=fail; b=JwSruiDQKTwgQwpQS/G1OPpEuckKtj295G+XNUMLFEVHngLPJseWyy7UCCJi/q0ytdmzy2BPN3u3yxLly22rSfVnpwTFWR1DKMKcN0MbIrvwPD8CT9RWRQU8fF+xEU3VeJvVZjktrHPi8MLX6LlZy1JxinmsiXlLH1HEDObPr20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813359; c=relaxed/simple;
	bh=tX5Wz2b2Ejk3QxdNPGEQ6YFhrI/E9a8GclbUoqYUW+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbhVJIuNFPWGseydKIGagPKnzf3nv8HIuF2Ih9BCRMpOPwYU81uTqhYIM6Sm3oefQTCq1eG7s769Vrr1FDIpxQOG4dt7ClwGFiJjEYZoYV8GPz4tJpMx1KOD20v/jOIVyhsUzcWktppVMXLH3qcSpnGMtjna+UERToBDDImjw+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKUekF/b; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wau4Mw9L/AF5F7nbGmq44ovRAX0f1IFOJnT/KfI2/1R8UXSRgWnUE3jXp/tGtIsaJcvhoIaFsFH2CcTbgjCszsxsetgJjOyo8aOPVbcgmNKEjx5vSnSWCRn5Yx3yuBDmHWnyQwten4QhbrYbIU08DKmPZb4aXXMVUhPfpfcR7p39KTvbyLF62sq8YYEkrOHn1X8e8D3TxB6KgSEKMHthefWUvzlQETWPpwdftNoeLJLJs12wmSMHxhkG4Hn3n7Gy/x8qnjtBJlmkR4d+GH4JpGoUXsnnJ868umMsTP++kcDmpEPf7vX5xdxjBgAcme8wO0v1/s170G/0Eca00S93zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv+RLeB9n6fgGJ+6doeTYbkW/40FlCKQZQaVaNK170o=;
 b=POl/Bkpsn32B7YkkO2ZCkg+LN/8NLSX7kRwuR6BQB1StWVszG9XFyw3wFMuc0P2ZwGUlyepORj8gWeXfezgri+lCN0VVEDwMVJpcJff6Utw8eqFpzehDzFTy9DUhd6MLnA2Do9BX45bXqsvG7FHgh0Sce7guqeY7ML4r5qCTCywEZYmvsBeHLj6rwWryAmSSLKpCdmjFHBgVJR6i9xPqkw8EXE07kWIqcdv11kyJvduHT7jtv8/gFmtbL1Q9/D7BAWHhwpvTb34c9FXlSeCc4qOF/UZ25m3N5mKhn8mQp/QmVTQgnJtbPNUcU2ZYDJQip4uRENu89pcrgo5OxNvISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv+RLeB9n6fgGJ+6doeTYbkW/40FlCKQZQaVaNK170o=;
 b=UKUekF/bS0HtCDabtp+Veb4+FyNd1dlb9/U2Z95rI1dDuDyxH6WkqL0x9NwdC6IJNV6VHbpB76FrBYS4titpKGmTpggfiJZqx7Y3CNVjX9rTGZNPNwCzZ/Jc+pSbSX0/z2KTdwACRmbXHsqRclMrsQ3Byqb+gzWgp5LiKJake5t7VRdPbYTPfyOY6dpEqXKjq7cLrX6LvOZfdYUTAPcU+V/lv9VBqfi2InCx6Jl6/S3EZTXBWN6VjdzPasvioNmbwFHSikVRO//JXy4he1KAGHADPGFKsg/YPsoeD6XqSPzIrNRzbj4DDq8T5kH0We4RfD42sf5cVIUWRYqLEuR7Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 11:15:54 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 11:15:54 +0000
Message-ID: <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>
Date: Fri, 13 Jun 2025 12:15:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
To: Andrew Lunn <andrew@lunn.ch>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 Alexis Lothorrr <alexis.lothore@bootlin.com>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
 <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 340f048c-3a6f-423c-5a55-08ddaa6ba984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmNKTk1LL2xLNHIwbjNDQmpTeXErYkpkRzhvdzJSR3lOZk9zZTZlOEx0Z2JJ?=
 =?utf-8?B?R29lVXJhbXgzY3NSWW5Jc1ZudzY2ajJoYlpPV2p3RUpEV3pZRnB6bWNZMjV1?=
 =?utf-8?B?bzhxa1FpN21NVHVpRUxhZEV0N01pMXRiTEFOWXpVZ0Ztdm5WREJLQzQ5MXdh?=
 =?utf-8?B?YWVOTjg2SjBqQmNNL0lVSEtOUG9HMTNLOUlqczRCNlRhZUFFNlhsak5KcCsy?=
 =?utf-8?B?Kyt5ZnZoeVVhZWZ0bU9TMytzdm0rTmI3MUFPcjllaG5YSVdnbDYzemVRLzFX?=
 =?utf-8?B?TUhyb1I4UGJDeWs4YmdjeFd4YThnK1VsNk9QSldlWXhDVnN3ZmFnSlZyYWFy?=
 =?utf-8?B?R3M3QkNLL1g2TXFPak9YZE91bzdXZlc1TS9PNmc0QnpKcnNhVDI3d3pOdTVK?=
 =?utf-8?B?Zzh2VWVubmRWU0VGcnJMRlAzSGZRb3k1aGlUUUZyMHA1dXZFSHV2bFRyZUVN?=
 =?utf-8?B?RXB0d3RoUXJrc0FxT1hqaGNXR2MvMHNlcFBCV1ZkV2tNbEc1eGRmVjFSbEQr?=
 =?utf-8?B?U3YweE93MFRVWkg0eEVYYzdYTUZoVVQxeGR6N3I4Z2tQYm1nOTVXdEtUSEY0?=
 =?utf-8?B?cVJTcXZiZjBQOTFWRGlvNTZGTmwzSUlaRDRHandLZVNxKzl2Wko3MUNFY0N5?=
 =?utf-8?B?TVlyb1hrZE1wUDNVNjVoR21yUEF6aHM5RVA2VEdTbkNJK0h3WnFtbWJlVTIz?=
 =?utf-8?B?VGtPK0xVR1oxRzFxb3FNK0Z0cE1SUjl4WnY5UG1XV1JQb01iTndaZFFtbnRS?=
 =?utf-8?B?U2VFUkFXVERreHkrSXV5WG9tenIzNUJNenJmUlNhZFdtdm5Lb1grMmYwejNm?=
 =?utf-8?B?eVBDbzRMdkFlbmcwbTZocDdKS3A5d0lxRUJWUnBmVmRVSDFNYlFJV2ljNU11?=
 =?utf-8?B?RE9rb2ZSaTNvcnJ2RHRGYy9yRGZlWWFRYys4Z3cwMHdYY0VFNktNN1RVY1dz?=
 =?utf-8?B?ampyd1QxbkZqVHQ2Q2gzL2lmYllaVDhuSmhpb1BZamoyUjBpTktxa3d6Qk81?=
 =?utf-8?B?RkdRM1VycXBUWHVtSjFqVEQ0TlZ6Z2VLdzR0QldoRmRlelg5bVB2MlNaSTJJ?=
 =?utf-8?B?WDlVR0dDMzUzNXY0RFFoUFdSU3ltbDZYdi9heEdmUlExVHVBR0UyZm1oZnBF?=
 =?utf-8?B?Z3pyWUo1ODdyVE1DWTZRcWVWRk5hTW83WmlkMEpjM3crL3VvZjNjSURkNS85?=
 =?utf-8?B?djByWENEQXA0bzVMeWVKQUppUVpoQzVYVU1kRUNIbWJlMC95Zkl1RWQ3TTJB?=
 =?utf-8?B?VkRwQjBuTDVIQVRWYkR2MVA4cGw2SFNpZTkyTmNBRjNIQWROSWJmdDBiRlpS?=
 =?utf-8?B?NmxlZlhPbW1vajUwRnE1aTcwWitiRTZ6bnA3ZTV5K09XeXM1YlEzalUvSEt4?=
 =?utf-8?B?MWpaVFpoVko3Z2N1SWpLSjZrUkEwZjVKeXFLTyszZ3VGNFlMSlYrMjNYOGhm?=
 =?utf-8?B?Q3ZQVkZ3OTVBY0U5OVZkN0RLQmtPTFpjNHJpMGJacHVFZmlObjRJU1l2dlFL?=
 =?utf-8?B?S1J0WXg3ZFhveUx3R2dXV0Q0cFhnLzRHZ3h5UlhVajFFV2VIN1V5NWhoRzFU?=
 =?utf-8?B?QXZsRTBQejB1S1hKbmkrcnpJTTBmU1JvdWlmVnpBcEhvSkdIOHM4cXIycmtJ?=
 =?utf-8?B?eVlOdS9hYzlYRmhJNHFCOGJ2U3pTR2dWZFM3SGhvdDB6U1Rla0tacmdCSTN6?=
 =?utf-8?B?U2hLN3RWRjlrUXdKUVE5bms1ZlFYVUZCNEg1ZGFFbzNCZGhJbk5RVmp1aFc1?=
 =?utf-8?B?TE5aTGp6U0RYZmt6SG5XSlNDcEJLeDU5NC9uWG5qK3lvYzg1UEo4Tzk3eS9B?=
 =?utf-8?B?a2NicEpCNVVPRzgwSHQyK0owL1pLc3NKMzdaVzJxYlZ2eFAzd0xyVkFtNW5Z?=
 =?utf-8?B?RTVRS1o3WUFHaXpBYklUVEZvVWt1WU9uM1p4N2lsOWlMNnU0ZWpscDU3ZnJ3?=
 =?utf-8?Q?p41Aa6MITBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JMQk5vWmlVNFNJVGptSW5VcGVKT0pqVjZRTXZmNDdFZFZETVhGQmIxcmk1?=
 =?utf-8?B?TkFYN09zeWprRzBWdThXaGxwMllzRnZWN1ZXUmxHTzMzZis3d0gzZUovalpz?=
 =?utf-8?B?OFBlYUhoT3hGY1VjVUxRVit6UkVkb3ZJdjl2Ty81azVPNWRTc2NZVWEwQkp0?=
 =?utf-8?B?YVkvczVRQllPTUVkWjNkTXdoY0xuY3VKQ09MVi83NEtuZnNWY3VzNXdZOTBX?=
 =?utf-8?B?MXhWS24xWjNYZUlMd3B3akJhc3FGY3RkTGlobWgrQWVkVDJVMUdUN0VMb1VQ?=
 =?utf-8?B?bHlVZ3V5MFFCR1I0OUxvZzJ0Mk03MDhHbDNNb3VmVjNtZDJSSFhVOW00cnJt?=
 =?utf-8?B?Q0xIY2k0UGlnbGZHOEJRSHFIL3phWStsSE52dzZJTnd2ZjVIbFpaVWpnbTV1?=
 =?utf-8?B?dXNJejM4NkpXZWRXT0JTVklTbk53UkNDTDBqYWZrUzZOc0I5S2hZS3JZK3Rw?=
 =?utf-8?B?QUlxUVVuendRNmJkSHdSWE9HVDZnaFAwMzdvdGVrRnV1VldUTkU5c1RSbnNW?=
 =?utf-8?B?YkMzVGQva28wYXNoZlhaaGtnamRqNXBXS0huVDk4V3BibDZ2WHc4V2U3NXp0?=
 =?utf-8?B?WU12ZHFZYWtYdWgwK205RUtBQ2wrZXVVdHhQNVhBYVVvQm5Xb3ZGcmcraTlY?=
 =?utf-8?B?UGk5WDhnL1pEMktoOThmbEk5b3lmUFQxYkY0clFTNms0dEljcWxmaC9RRDNm?=
 =?utf-8?B?Z0w5cG9qNkh1T2ZHN2h2SkhyQSs2UlZLR3gyZzVXTkZpTU0wRlRrd3FTUWp3?=
 =?utf-8?B?Nkk1UkNxOFZhRUVCbjEzS2RMdmo2cjJQaitieHRaZEFaQkE0N1o5ZmduZFh4?=
 =?utf-8?B?YzhMSXdWOVpieG1yYjlsdVo5c29HTndwd2FyRnVkbXptRXU0MWhPT3pGNG9r?=
 =?utf-8?B?bStFa0FFbmZMcStuaWI4NEZDMmhDNmpyWkRWWHllcXVUYjBrV2lBWE53MWhO?=
 =?utf-8?B?UHRkeXZ3bVlFaTVYZDBjc0NXMVlqNmlFMytpZnl4c0lRZVpDc1FEQnR1cmRw?=
 =?utf-8?B?UVo4dTZrU0xzQ1lPTU5BMnNQdlpscWtvU2Y4bDVkdDJCMjRzNnN5aU54VGJz?=
 =?utf-8?B?U05seHcrSCs5VCtLaUNsd3drM0xjVDFteGpFYUFSRVVDWll4ejRubE1sdWtD?=
 =?utf-8?B?S0RDbzVDa2dwUnc2cFhxLzV1Zm9WUFBwaHQ1K3BnV3ZLdGtKeVA3VklSS0sr?=
 =?utf-8?B?eEsyVGVZUWNVNXdIc0UvbzZmK05VQXh2ZUdVOFh5Y2QvYXp4bzUvYWJFK2Zu?=
 =?utf-8?B?UGE0dytEcDZmbm1UczE2NzlPaFp1T2hsQ1QwaE9lTXFtNUxKTmtDdGFDeU5Q?=
 =?utf-8?B?VlgvQ0N3ZGlsOUxENGFNS1FvU1JFNzZDejlhVEFiQStjZk9KK1FTMzRYNloz?=
 =?utf-8?B?SGVVVEdJZUdRc1RBa05KVHltWHZ5a1FJQkJyUHA2ME41bDd1bms5V3FIc3ht?=
 =?utf-8?B?N0lLd1Z1dEFza1hPSDdaUkV3elRGanhWZjlTQjN2S0cxSnlTZzMxbTlrc0Nt?=
 =?utf-8?B?ckhFcHlaRXRtR0dGTytZZ0pUcG8zSHk1T1FWaGZjc0tYOUVsZXM1Y3UzYUdI?=
 =?utf-8?B?cFFKWGJ1aW5iUlZBZ3U3WUtEK1gvNjZVTStWak1GV3ArWExRb2xvV3NJN1M5?=
 =?utf-8?B?ckZ6YjZOSXZVUFBCckM0UmRsdGg5V0YxTThnY1ZnOURGWmdySzA0ZllHYTBP?=
 =?utf-8?B?UlV1K21ieUtwWTZxTy8zZXB5V2ZxVDl6c3FuaWxOTGdKSWoyRHhXRkJGS3Zn?=
 =?utf-8?B?NGhRY2I2TXFybnFDU2dxVlhERElEWmdYeTdNckorSDZnbHNEdUpUNEtpYkpZ?=
 =?utf-8?B?ODBJc2tjZzh5bXE2RkFBRlI2VzRpOW5ld0V2ZythSmtUOXd4ZGxxYVJmcWxm?=
 =?utf-8?B?WVpWQjFBVUNJT3E2UkRKZHh1Qi9sM1RhUERFbnR5TXNPcTU3YWE5UmFkeVdV?=
 =?utf-8?B?SkJ3WjF2MzJIaXNWRmszL3BUV0FLY0xzWVUrUmZFd3k4bURPalBQZmQyZE16?=
 =?utf-8?B?eXNIR2VKdklaQnkvUXVLeDgyTDNGVHBNMEFmejA1ZUh4UnFyUlFORkMxR3hy?=
 =?utf-8?B?enRGc252L0RQMllXRzlLOTFvNWNOT0FKUHEzVUVLYXhyeEQzUXRiQllNcVZr?=
 =?utf-8?B?ZFVVeFRQZkxrdUdlVGpycDZnL2dTOHVYNENJcVZ1c20xaklmQmVwOVNQWFdL?=
 =?utf-8?Q?6jQrQEqhg/s2w3/R3CY3Wv4dUULZEJUtK0ZlrH837FlE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340f048c-3a6f-423c-5a55-08ddaa6ba984
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 11:15:54.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PdANwrEy5c6dYyh7O6LzEhdoMPwZuH8UpwE4B4B/HybITlp3ABbZXI+rDYKsqGO+StpELMYVSDOj/AXuedUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433


On 12/06/2025 13:45, Andrew Lunn wrote:
> On Thu, Jun 12, 2025 at 01:26:55PM +0100, Jon Hunter wrote:
>>
>> On 12/06/2025 13:10, Andrew Lunn wrote:
>>> On Thu, Jun 12, 2025 at 10:57:49AM +0000, Subbaraya Sundeep wrote:
>>>> Hi,
>>>>
>>>> On 2025-06-12 at 06:20:32, Jon Hunter (jonathanh@nvidia.com) wrote:
>>>>> Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
>>>>> 0 before configuring timestamping") was added the following error is
>>>>> observed on Tegra234:
>>>>>
>>>>>    ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>>>>>    WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
>>>>>
>>>>> It turns out that the Tegra234 device-tree binding defines the PTP ref
>>>>> clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
>>>>> exposes this and that the PTP clock is not configured correctly.
>>>>>
>>>>> Ideally, we would rename the PTP ref clock for Tegra234 to fix this but
>>>>> this will break backward compatibility with existing device-tree blobs.
>>>>> Therefore, fix this by using the name 'ptp-ref' for devices that are
>>>>> compatible with 'nvidia,tegra234-mgbe'.
>>>
>>>> AFAIU for Tegra234 device from the beginning, entry in dts is ptp-ref.
>>>> Since driver is looking for ptp_ref it is getting 0 hence the crash
>>>> and after the commit 030ce919e114 result is Invalid error instead of crash.
>>>> For me PTP is not working for Tegra234 from day 1 so why to bother about
>>>> backward compatibility and instead fix dts.
>>>> Please help me understand it has been years I worked on dts.
>>>
>>> Please could you expand on that, because when i look at the code....
>>>
>>>
>>>     	/* Fall-back to main clock in case of no PTP ref is passed */
>>>    	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
>>>     	if (IS_ERR(plat->clk_ptp_ref)) {
>>>     		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
>>>     		plat->clk_ptp_ref = NULL;
>>>
>>> if the ptp_ref does not exist, it falls back to stmmac_clk. Why would
>>> that cause a crash?
>>>   > While i agree if this never worked, we can ignore backwards
>>> compatibility and just fix the DT, but i would like a fuller
>>> explanation why the fallback is not sufficient to prevent a crash.
>>
>> The problem is that in the 'ptp-ref' clock name is also defined in the
>> 'mgbe_clks' array in dwmac-tegra.c driver. All of these clocks are requested
>> and enabled using the clk_bulk_xxx APIs and so I don't see how we can simply
>> fix this now without breaking support for older device-trees.
> 
> So you can definitively say, PTP does actually work? You have ptp4l
> running with older kernels and DT blob, and it has sync to a grand
> master?

So no I can't say that and I have not done any testing with PTP to be 
clear. However, the problem I see, is that because the driver defines 
the name as 'ptp-ref', if we were to update both the device-tree and the 
driver now to use the expected name 'ptp_ref', then and older 
device-tree will no longer work with the new driver regardless of the 
PTP because the devm_clk_bulk_get() in tegra_mgbe_probe() will fail.

I guess we could check to see if 'ptp-ref' or 'ptp_ref' is present 
during the tegra_mgbe_probe() and then update the mgbe_clks array as 
necessary.

Jon

-- 
nvpublic


