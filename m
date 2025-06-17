Return-Path: <netdev+bounces-198453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D030ADC3B0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A3E16968F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F128D8EA;
	Tue, 17 Jun 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QH7tapkH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F228A700;
	Tue, 17 Jun 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146581; cv=fail; b=KA9tjekrRv6081B7AuRBdOEVHwUeoStdDf6N4f56YhSfWyA+bd/Y98cFFqA+SOcpxwdABjSQZyMNXGTxp/FxmuX38dS8QBE+riptD/XXJHEX9j9L2SWSB/SsEN3upWJC43zMHVlN6wkPQOZDQDbx8HURO7WKAEz5i7ZlKmO6R88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146581; c=relaxed/simple;
	bh=4djIvyIx6U7E68umMePOkEF15HIVaPqHb25II+V61dw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a2XXaOvf7+fTzFRLMMwwlLGrIcFYJqTgkeqaBNEDHPNxhMju6CoeFfgriOe5V5Cu7OSZXxRWcm4EHyOMtwFi6YaRR9eJK1fg8sEOHRyGxO0BApHip0z6YvunuowYq7FH2ak/WRoItybv4wGMSSpRaR3hWj6WdCmBf9XewlUQ9lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QH7tapkH; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsyFOoIZE95BNT105rvYpMVKbYxHMhkvbp0/vdPr4jLarMuw+sIPOhoPZ5/74aEv8jGFAxunsGAYC0CF47xyEWQplFOn3om7ohCdUlY4iVfljmkZ0PAF6yEmGTEkh+IxBq0EwVCsiij25YvSm//fEEm/ue8Op4gnhm8PgatH4UF6Ds4Be6BGBSpRU17ueXT8C44iyCy8+XXq8d9XidXmcdrtNh9w7oP9/HNZ6DtWbYNjeSHu3ZhhDXw4xDc6wG3pi7tIGnBMsjfEhTxQG0vuCBy/2rYBiRExbLYan9MRJTzgqSXQNwdMbIObGvXeTxgU9ieVv9QoXYeC+rBqRkah3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SGg+p3bUyED74XJma+JMh3NOEyyecJu9VaF/LmbFe4=;
 b=e4xtVBH7ANdLv73WZUfCl1tC/aamHf9fJiS2YiGs4sFM87D9Gfg7TXt8RaSazjj36+32bHXSb342m1WLFcJcbV7qJaF81Vk95vTcjBUJW/7b7YLIHc1ir2A1kRgWw5rogqqUsAXPm9dfLPemrIt4i0cJJ/WdGRgC+w1D5FORp0QKYZGPM6WxSYFBOT4XeIprGwFi6PJsKlrAtqQCaGuUnSt2uanHi3BtSkOR3xnL72JipeRYKyWtVzNLJ9IyDmjsEtuaODMrCrsukiqqKStNo+0VeQ2sPNDkmL8ZANvfT0d4wfPuEvcQd9G5/8Cqo+v5zI9ROkOi7SwyhcLi5V6naA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SGg+p3bUyED74XJma+JMh3NOEyyecJu9VaF/LmbFe4=;
 b=QH7tapkH4h2j8glZ/EpDLX2W0cQ9Tqyc2lpBG8tbat9lwehoqCgcysADEoJN3IiHKnV7Ym+nddkcXyaWrc9FJJCk/FfQMPpQG4TSOIuzidZLBl7PYKhXF22HK7XP1yqUUNP2kFcP2YZ5yyKtBxOwlxarM8AxxTvsWzsRSoi+/gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 07:49:34 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%5]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 07:49:34 +0000
Message-ID: <fadd937c-dbcc-4cb1-ad98-b787dd244d8d@amd.com>
Date: Tue, 17 Jun 2025 13:19:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for
 Tx coalescing
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616104232.973813-1-Vishal.Badole@amd.com>
 <1c1e7c9c-5143-43e9-a40b-42dfc3866a56@linux.dev>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <1c1e7c9c-5143-43e9-a40b-42dfc3866a56@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 15443af7-d654-41b4-cc3a-08ddad738075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFQaGUvdk1PZzlFckpaNi9malZFN1NzVjdYUWIyTkUyMFFBTk96NVk1UE5S?=
 =?utf-8?B?NldqTFQ4RjNvQXRrbXZnd3Z0a2hpNEhCaU1nWGFYMmF5NVpPS3lmMncwTmtU?=
 =?utf-8?B?U1dUSGhBOThTa1RVQU5uYnJ2MDRvSzNQSTZ5WTBEQnkrTFpSZWdkVEY2aFM1?=
 =?utf-8?B?Y3hodERXeklFRktCdkM4ejVFNS83YlMzNUFXUGVEV1hBQlAzVzFVb3J5ZmM2?=
 =?utf-8?B?YnBhaG54M25mazhpWGJLTlNlSkpCekROOVU2OUdJMjNpKzJmaDFrK0dCTzRU?=
 =?utf-8?B?UGNIOWtoMzh1b3JGVmdUSk42Q1BXYWI1N2kwUHdGU0Fsc2wzNzAvVnJSQ0JE?=
 =?utf-8?B?eWUrd1ZnWStNQ1lkQ0t5NFE2YlJsYVozbGlXK3hBR2NvMDRYaGlpZHNMYlBt?=
 =?utf-8?B?ZGxPR3llVVRBNE51Sm9GcEg4YlRWWG9DNWE5ZEtBbmdRQkxCRVhHOXhBL0c4?=
 =?utf-8?B?QWpHVFFzSlJvajNyVXRSUFMyaDR1Q2RQS2p0d2tGUDN6VUpGN25xbXg1WWlv?=
 =?utf-8?B?ZURKZzNRL2V0R2dKSTNTbjdJNEtpMnZOVkpFREt0VTBPUWNlbFE3MmxzbkZO?=
 =?utf-8?B?YkhoekRCNVArUnZwOXBXR2JISnZNeEVyVnRMY2szNEhNSXJmS0JCZG1vRnR5?=
 =?utf-8?B?dVRuaGFXci9sNGZvczJmZXNUZDl2bHBFYzBwUytMU3EyYU5JZUpzOUZQRDZ1?=
 =?utf-8?B?RHJ5SkNydHBvQWJVY1Q3M2RkY2hIRm9nTGVCVG1UYm5jRHdBNStETlIvYVNE?=
 =?utf-8?B?RXNSdHNIazFaUFNzNW90MVE1WVBNaWQrMnBSa0V3YXdkVytzVURDQ1BVMjJn?=
 =?utf-8?B?MVh3Qk9Ib2RCU2tVYWFwTURoZTZqZ3pFOXJyVlBYbTQwYXJkVjIyZnd4ckFH?=
 =?utf-8?B?VmhHUmVyZU1zSG1VdVFzN25jb0ZuTmdNUnd6SmhsaUZ1S1JTcE0ra0hsVWxW?=
 =?utf-8?B?azBoM0tidHp0MXhycXIvOVJUTnFhc3BDbWNORFlkaHU0RFoycnlKa01kQ0xE?=
 =?utf-8?B?YzRVOTA2aWpCSFZOdFVvRDAxVDZ3SUVkQmlaWDc1SUI3ZW9JTnhmblRmUEZH?=
 =?utf-8?B?c1NoYjVXRmFpbUV0Z1dqQXE1WnlNd0l5L08xMkRIMHNkWHJGZjZrSVl4cUFy?=
 =?utf-8?B?bG9LSVVCbE96cDhabXpFVHRaMlFVMEtnS0R5b1N0ckNyQnZuU0hITllXc1dN?=
 =?utf-8?B?MFhiaG9RWk1kNWoxak1uQXh1cmhpbytEWklIVjhqc1drRkgwR1g0YVdob21Z?=
 =?utf-8?B?MEErT0QzYmhvTGZIRFIxemN5QzgzbUgyUlpyRElnbkNsU0dwWmFBM09hY0tp?=
 =?utf-8?B?Z3RCRnJVVFdWNGxOdWI2aHAwWmQ4bit6eTVkeXdBcDh4dzRhd3lPR1UrdWJT?=
 =?utf-8?B?ZGxMM1h4dnczdlM0SkEzNE1YWVhDQTBEVkpRN2JQOE5KWXRVUEdTTVc2V0Z0?=
 =?utf-8?B?NmRWWnI0TEFMR25XcHJBM1kxQldnTlZ4ckFTUS9yVVh0YmxKVVd5RnJiVzVt?=
 =?utf-8?B?dDU5ekpvcHJrTlpwanU2QXJTaXZ5WEx3bWtoMEhCZk1NUGpDSFVrWEtuNTJY?=
 =?utf-8?B?VWxBMTFlMXFjREdvSC9pQ2Y2YUtSQWMrSmN2R0dSdUw2djZpRFBxTGFBUSsr?=
 =?utf-8?B?ZDF0Uytybjc4YWR2Q1NQczJsZzZGZnYvNUZjK3l0NVpRQWduV1N4M1lwL2Zl?=
 =?utf-8?B?UmtrdjFab2RKVHJ3a2t0SXpDbEg1VkdVY25uYS9ZdW1ZT0JxMVVDMy90Ukxo?=
 =?utf-8?B?VDE0SEpQVVFDZ1k5b0k3eUsyQUdxS21CTlU4aE1zV3VkQXh2OE9URDBiQkJn?=
 =?utf-8?B?Wmk4ZlpONXVrWk0wd0E4cnY0TmZoVVNTUmhXOXpSbUNDeUdXOExQZ0pVZ0xm?=
 =?utf-8?B?U28wWXE1dTlaWGkvMXNhampJbm16SUwrekkzR080NmRyaG1rT3Zra3BUUW9M?=
 =?utf-8?Q?zmO0asrd8ls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnJ0L3M0bGFqelhUNFZzUFA0eldmZ2NiNWRpMlg1bWlDUUM0RVVmTHVqdVYz?=
 =?utf-8?B?bXU3SkJsTFlKY3FjalNkdWFuU0w5Y0dwRndTb0JkU0F3eFNDRkw4YW1iRGNT?=
 =?utf-8?B?dG1XL3ZhV1pwTFc4MGdSbThnKzlYWU5nekgvQlJ2VGZ1SjU4RFViU01UcHlx?=
 =?utf-8?B?Y2h0V1dyTktkb1o0T0ZuRXNod3pUOUU0bzI1bUlxUjZuQU9HNDAyMzd4V2V6?=
 =?utf-8?B?ejlwdU9TSzdCUGtFZGwydzVQbGhmaXRiSXlTbWkybzR4ZnpVNUl1Wm4zbCtT?=
 =?utf-8?B?MDZVUXVNUkVXUGZoZkVjMWxUQXp1bzNMOWEwQUtXMSs4QVd0ZnRxakJ3RmVh?=
 =?utf-8?B?bDM1eE1IYUo1TEsxbzJrVFJGdDExYnRzTEpHK3J1OHpsSTlqVkxieDF0akRq?=
 =?utf-8?B?VFM3WjZ6RVcwdkJiQkJGa0FEUlJsd3kvYmVtR2FIZWxzK2kvWUFiQmFMdlFI?=
 =?utf-8?B?RjV1bVI1YWFObDFPNkZpTUl0UHNjcEdZc1BHQm5lQlRSMTNXaEFJUWdBcjdL?=
 =?utf-8?B?aWQ3TXlxVkRIQjBYbEEzcDVUdXl3ajVoOU5jNVdsUm1ESFZpeTFpMDQ1dS9m?=
 =?utf-8?B?QTVlZEF6MUZrazAwSXdCcWl0SDRBNzlwaVF6STFvR0lzSUg4RnNRaE5nM3d5?=
 =?utf-8?B?QTMxaXd0dGxPMDF4U29yUkdEeTdwODlPS2JOT2RPRGVzeXJBNWNuOVBxNFg2?=
 =?utf-8?B?cERhaDFuNkt5QlNVdzU4cEtzVnQxOGxSaXZvcGZNNm50cmdmZ0ErS0c5bFBM?=
 =?utf-8?B?c2U2bkpGaUlOOEoyUFlOOVNXNzc5WUpMZ1U0UEVCRXRIaS9lZnJXVjJUZ2Vh?=
 =?utf-8?B?YnkzNUFVVjJxUjdaU05QSWJKTmc4aTJwWVBuT3cxM05MOHFPTk01U3FHOTN2?=
 =?utf-8?B?UElpcHVFVWFyWEd3L2U2eTVVQ0d4YnJjMDY0UFlIQmpPb3RBOHUxOTJpTXRi?=
 =?utf-8?B?NGYrNW1xeFpYZHJtZEtOVC9GeVNvYk90SUVRdVRCSHVuenJWbmszeHZvVVRX?=
 =?utf-8?B?OGFNL2ppRzVyMGpTdW9hUG5Fd0xiWm5GNFdGeXZKc3JUSU1LMjlVTVQ4VXFm?=
 =?utf-8?B?RDdPVXZ3RHFrREtyZDhKKytPdjVsUGlPRURuYUliTEd5Rzdob1cxNTFkSjlH?=
 =?utf-8?B?Y3RtTG13QjVEcHIzcEtONlQ0SGNmcHJUdDNLeTBvRU9YeEpNMkYzN2dYSWdi?=
 =?utf-8?B?Rlp6bHM0YWtybExNdVBjNjRFa2pHckwrOFB6dVBBSGxuMTVQbENsZnNyUHVk?=
 =?utf-8?B?YzBmRURrMDdwUnp5VFAvcVRqRHF6TjBNTWdtYXBoaS9uWXZ4MWtkbGJTaVd4?=
 =?utf-8?B?dDM5djJLd0x1K0M2UlhYVDBITjl1MEpTdGYvMnBWb1VNZFFwOTZ0OVQrbkoz?=
 =?utf-8?B?WHM2TlppUG5NdENFczVDOHFHbFY1L2dsQk04Tkc4RUpmQUM2emNmTzVWS0dr?=
 =?utf-8?B?RmJqLzlWT09KM1pqRzRCTWJFQTdoQXF6cmU0S1U4OHBBWlBCOXJJWXBralRm?=
 =?utf-8?B?Q1V4N3Zramg5WVY5OWRLNkVkZDRSci9qY2ZEVW9YaW1xYmN6SGhhdnJ1YlBY?=
 =?utf-8?B?eUVHaytPeWE2aEtLeEV3M1VYN1F5bTNhRUZGaEhlbUE4cWhVTUI0Y2R3ZVFi?=
 =?utf-8?B?Y2xCS3I4RkFKWis5UXdJeHRPbVV2QytldWFkQlFWS0FTbHB1cjFzMGIzbDMz?=
 =?utf-8?B?VWtIL1dQSkRmZWtsM2xLdUdLZjNVZTFqME5TYnhOOWhKMWRHS2RvWThzYU16?=
 =?utf-8?B?VEJRVTRSVEVZOVBvREZTZ2FrcThOK1NYMW9rWXVvMXFDalJ3bWJ0VDZJNkZI?=
 =?utf-8?B?Wm1BbzN6b3NqVXd5eGh6aHdhSVl5ZmdOeFV2YmgvNk9LNkk4WnRYbTNsUjMw?=
 =?utf-8?B?eWkwV3VqUHpJY3pZZzRJMGRXSWMxUGduYTNyeW05Q25EdFE5M1YrcEVrbGVE?=
 =?utf-8?B?Nk8weXBVWTNJWmJuK295UWF1NEcrUlJyai9WVEZLSmc4K0QxektZcjdGU3dX?=
 =?utf-8?B?MGZRaVE3YVYwMVNETjk5Q2hWdVJoMDV3SFQrVitjUnF6ZG9LSE9hdDdDYndE?=
 =?utf-8?B?SUV5L3F1MnN5OVpDRU1nQlNTang1Y0pPK0x2N0ZWdDd3Z2FSSjJ1ZURIb1l2?=
 =?utf-8?Q?PcV7+YaYcDPd2FO9I5MUkR4Md?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15443af7-d654-41b4-cc3a-08ddad738075
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 07:49:34.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiZ6ShyAYqcVVPSfxURoEzWzop3ARbfLGaZnxT8BES3ETwRYC1XUFVWLhNBOJSveFVGKkT1mMzNVJLBd7TYoMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349



On 6/16/2025 4:59 PM, Vadim Fedorenko wrote:
> On 16/06/2025 11:42, Vishal Badole wrote:
>> Ethtool has advanced with additional configurable options, but the
>> current driver does not support tx-usecs configuration.
>>
>> Add support to configure and retrieve 'tx-usecs' using ethtool, which
>> specifies the wait time before servicing an interrupt for Tx coalescing.
>>
>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>>   drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/ 
>> net/ethernet/amd/xgbe/xgbe-ethtool.c
>> index 12395428ffe1..362f8623433a 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device 
>> *netdev,
>>       ec->rx_coalesce_usecs = pdata->rx_usecs;
>>       ec->rx_max_coalesced_frames = pdata->rx_frames;
>> +    ec->tx_coalesce_usecs = pdata->tx_usecs;
>>       ec->tx_max_coalesced_frames = pdata->tx_frames;
>>       return 0;
>> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device 
>> *netdev,
>>       struct xgbe_prv_data *pdata = netdev_priv(netdev);
>>       struct xgbe_hw_if *hw_if = &pdata->hw_if;
>>       unsigned int rx_frames, rx_riwt, rx_usecs;
>> -    unsigned int tx_frames;
>> +    unsigned int tx_frames, tx_usecs;
>>       rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>>       rx_usecs = ec->rx_coalesce_usecs;
>> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device 
>> *netdev,
>>           return -EINVAL;
>>       }
>> +    tx_usecs = ec->tx_coalesce_usecs;
>>       tx_frames = ec->tx_max_coalesced_frames;
>> +    /* Check if both tx_usecs and tx_frames are set to 0 
>> simultaneously */
>> +    if (!tx_usecs && !tx_frames) {
>> +        netdev_err(netdev,
>> +               "tx_usecs and tx_frames must not be 0 together\n");
>> +        return -EINVAL;
>> +    }
>> +
>>       /* Check the bounds of values for Tx */
>> +    if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
>> +        netdev_err(netdev, "tx-usecs is limited to %d usec\n",
>> +               XGMAC_MAX_COAL_TX_TICK);
>> +        return -EINVAL;
>> +    }
> 
> ethtool uses netlink interface now and coalesce callbacks have extack
> parameters to return error information back to user-space. It would be
> great to switch to use it instead of adding more netdev_err messages.
> 
Hi Vadim.
Thank you for your observations. Since this driver is quite old, we have 
used netdev_err() to report errors to maintain consistency. In the 
future, we plan to upgrade the driver to use netlink interfaces with 
extack parameters for returning error information to user-space.
> [...]


