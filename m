Return-Path: <netdev+bounces-126772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53597269F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A6B1C23490
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD413B2B8;
	Tue, 10 Sep 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VhEyeqJ/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8D43AB0;
	Tue, 10 Sep 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931951; cv=fail; b=XFoDPA/V493i+zgrDUEUsODtvg7l30/jMZK0NvlGjhbXiUIrjcKrsVIv7/QgzkTPSaZrm3eNoAQv5jMjGVWntYcXvX80E2utc1ot3gdgQzf+0m+5u8OfBmS6mtbFoPm5KAqDXjaORi65rBHRVLb3SBbQ0c/I4GqnhXBOHeRxPxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931951; c=relaxed/simple;
	bh=Hp71JKr9n3EixzO5mjBhZw9wITm577myrYRIStkzCdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjaY4yZFLkURHiNPYhFtuny0OFedN/NjY0Rn/fsGEQhCRKWJCztwuV3YqCx1a9FMphzL0cAW5bXQtgC4pwvpOUDZhntsQNdu72gcHRJsIRGa7wPUP1SYbgxs5TbO4Phm8aiuc7JvPlswjSxIySJ8NsUEjSapZO7iFdhilrp0SFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VhEyeqJ/; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKSFRUVbcDSKkHQh1M5lX1e1IE1foxXSVBPPvDxyoT8Wgc6Csgl7Bppv1HLVVKm1DvF37I34LKYPVC/Z/5f3nXIZW7xw2ruXJnGOucqKbBjIfjFKfn/n+ZOwSSI/nISmr2aqNJUID6RmaJLNTSRqkQxhXQ0sRgdasiYI+hYg4584VCfMoAOsauQTKeaz5cqYrZiuaKwjSDNL9pkvwtRx21oBoWNnaeOibYkIqjjYWFjUwKj2Mc3uAdzkJkjKSWgfyBlnPKxjYNIorhf83eLbhO60zV1qkUwvefE+1tkZ5EYYgYwMf0OT3eMKIbMILPsxLLlKXl5xZFJrMKkwmPo//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOcgfJgiBlvXmZuGuSa2qrHqi+vHWwMQxHq6b51ib5M=;
 b=fbl0kMT1xuGXZhrT+C1olgKUIt8UM4OuEJJeR8DKO4jPvKQFKzqM/9PreMFvXfPExauGOaGVGUolQTzRz/x/g3slMgMcpe55lHQKcNsPQ5jK/D3GeYfjR5Osz98MPcYNe99eko9QgwlTgDv4n30rpOj5LRnFMMZZgj1sHOc1sxva0HE9ms40ckwrxUSpT4kAdOqz95K2ZXNEICPosMLSjE+2J9NmVcIcTUzXhO7EMXNzIemKdrm6Kmg29eDulY70S1H6OJZdes+q+AsCgwX6eOPW3p2FIzOEsljsVPvQLhXmcEbifqnP241KoQ1g/EiXjrcgcTOf5qeWIqVKYo+7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOcgfJgiBlvXmZuGuSa2qrHqi+vHWwMQxHq6b51ib5M=;
 b=VhEyeqJ/8sd+d8xtl09RQeVgBsNzTwMjzPU6jIeTSS3eK/pvsSx4xn0TtliEqXsloy5gmCQba8wD8kOMV9j8rxSiDMcovoQt2N4Dflj9dWfH8657vL/rdNa5kFHXCUgyP8BYx/x1XUWFybFa8bkf5VpmrwOE+jpYU2uNCQauRF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 10 Sep 2024 01:32:27 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 01:32:27 +0000
Message-ID: <d811db1e-6aef-40f2-b152-7d77b8a8c2b3@amd.com>
Date: Mon, 9 Sep 2024 18:32:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 6/6] net: xilinx: axienet: Enable adaptive
 IRQ coalescing with DIM
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
 <20240909235208.1331065-7-sean.anderson@linux.dev>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240909235208.1331065-7-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb5f40d-9e67-477d-5425-08dcd1386e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFFPS3E4Y2RNZXU0REJCalQrZ1BKbXNmWG9JRHNvaWdLRFJ3dnppbHVpS3Vw?=
 =?utf-8?B?SDdjRDhYVzZ5TlEzc0Vxb2VMK0pHTFRsVzFOYTlpTlFndGRsOVFwaUJNcCtS?=
 =?utf-8?B?VE9RcWFvRjBGd2VkZmczakdvOE1WZGVwekwrTzN3NUhDVC9iL0xlMFhoc205?=
 =?utf-8?B?ckdoWnFoS1J3bzJLUy9RNVphbndxeXhUeTlWcFBwWGlYd3hUclVjWm40VFpR?=
 =?utf-8?B?QXl3eWVTelZ6dDFwZGh2d215aVQ1QmtwbzV1YTNEdVoxKzVLU3BXNmpYR1dh?=
 =?utf-8?B?dTZEa0lzVGluYmpleE1VWmFrNjBoNE40UUM0aGp4N1IzeDJ2YkRJaGNIQngx?=
 =?utf-8?B?T2dTdG9PREFFemN0WVduN3M0NlV5bXNEZE14bGFKZ1ZBUktmR1VHejhVdVpU?=
 =?utf-8?B?bjRIWkoyZWxyVTJIb1RuNEFuVnFSZHZwa3c0UTdjOU5HYjlvZGwyTFQvbm40?=
 =?utf-8?B?RjcxQkI4RHFCZ20vNGhhRmt4MU5vbi84SVk1eUt6VFRweStLb1lBbmdBdDBU?=
 =?utf-8?B?WUFEckZwRG9BMFlYK3pHbmhBY1JCbmNYSXUzTm44Q0t4dEFJeTFlYVBFa2lj?=
 =?utf-8?B?VHFkN2o1eitpa1BBcGlYRUZQQVFTTnRkdVlIQlAxeWVrWC9wY3NJWk4zVnA5?=
 =?utf-8?B?UG52eUwvYkdqR2piN0l6ckRUd0I0OFdWdTVqS244N0RCRWtlNmhCU3B6WU1F?=
 =?utf-8?B?eGtMeUs1cTFyMWwvUHNwZ2VoNzRxaGxQL25SUEdxTVZ1ZFJGWlJCd245Nmdt?=
 =?utf-8?B?NkxJbjlEZHNpM0lycHpmMERUT2w4ZjdjZ1JaeHBHemRnYUpiNWdzeHFZMVU0?=
 =?utf-8?B?UGZTSmRJMHJqOFVIenlvbE1ORHZJNHkrOEVpZm1UcDlobmpxRW1lUUl4bTkw?=
 =?utf-8?B?WHRWNWtKOHlZdTBpRXZuUmN2WEN4L2xwVFlCZ3g3OWZCcVdoajZPM2hQd2hj?=
 =?utf-8?B?YkdXMnlLTUdGVzRzQlZna09qU2hJYTh2M3VHaE1TWXpKTjI0QlZMcXVIbkZY?=
 =?utf-8?B?Zm9XU2FtZC9oWXZTajd2RlkvWllvMmlEck9WamsyUnJTU3VOUEd3MnY1WURQ?=
 =?utf-8?B?OWp2V2RQakpZZmZFQk40WDRlK0czVGt5bmNWMDNIa0c1ZlZjUWdMcXN1TkU1?=
 =?utf-8?B?WU5HRGhUYjFMR0l5bHlsVzNFNW1GWTRvaExsSVQxV3VFakxLdTdXbXpnWkhR?=
 =?utf-8?B?ZXZlSjNHRjY1ZU1kdTQ3T3g5Y0V3eUtvRnBRdEcxanR5RDJIWkpldlNybGxM?=
 =?utf-8?B?VEZybjdxUmJpc3NzM3F5MWFYNEp1ck5qRTg1aG5qR3pkMFFyUTNaM003UVhp?=
 =?utf-8?B?Z080N3FNRFlhbi9aYTlwOXdoMCszNWlhQUF1cXdjbmV6a1d4cHhYdUFUbCt2?=
 =?utf-8?B?a05hNUZVb0ZMZHNESEE0VDRPZCsyY1RDQkxiVUpkaDVEOStnM1htaHIxUjkv?=
 =?utf-8?B?RTVKcnBZby9Udmp4MEdZZ1BsbGtkcW96MkRadThPTVNrNE52NGdNanZoY2VB?=
 =?utf-8?B?bmxFUjROWGpMbG1XT1ZxNVhEVWd2OThiOE03dGZPN09mcTgyMytlSXplTTNE?=
 =?utf-8?B?OVQxL0Q4ZW9kaXZVWmF6YzJRaGlUUDVENjV2OGFiWFEvdjhRZTIyR045Nlgr?=
 =?utf-8?B?RkZpK0UrOGJqTnJuelFFbWcyTFFYNUIrVGxDTyt6NmF0TFM2QUVSWnFUODgx?=
 =?utf-8?B?L05ic3VLaVJRcytVNjdncndzN0taUGpXSGhBcFFxRnB1ZHJJOFVMSDJUY053?=
 =?utf-8?B?cERzelZWa1JWUGRkU1NSVnM1bGNVU2tsTUlRNHg0OHBJdkU1aG8rMzlwOGZj?=
 =?utf-8?B?SXVGTmxkUzlzTVZZcjFjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2syRmdxa0ZoWTRiZDVteGlJUUx2WGN3emNDdXBKZy92QmRybDM3eE1SQWo2?=
 =?utf-8?B?M2FLTXhsR0hNWUlFYnVoaUJuWlo0ajBvVEVSeUVLQ2dzc0FTYkFUdTR5U29o?=
 =?utf-8?B?aGtBY2tTeC8zdHc3UDE4d0wxYk5OQ0FjdDdtNUxNVGdmd2ZUVzFLTDlRQWtF?=
 =?utf-8?B?eHZqWXpIV3ZoMWtsNWdLSEErS1oyZ2hxN3AxVTlwOENHOEQ5a1IrbEFCRzJo?=
 =?utf-8?B?TS9pSHlrVjdpTTJxOUJMb3JHZlZVT0h5VmhDakwvbHZ5cTJOVjc5dFV3TldI?=
 =?utf-8?B?TDlGTjE0dzg0MTg0YW44RHNIdmtKUHJheStobE1HWnlSckU4QUZiOWRrcnMv?=
 =?utf-8?B?WGtOR05BMlB0L3FLaGVmM2UySGdVZFZFM0hZMUpxcmJnUnpIOTFkaFRkVFEv?=
 =?utf-8?B?TTNMdnY2WmE4M0tDRSt3MmxIMHh4MjdGb01VRFhRenRBK3RYaTRLU1pWVmpP?=
 =?utf-8?B?TlM3OVhmVzhkQ3Z6ZmlKdTd5cnRWc2cxRFNNakFDZ0MvcU1QUVd5Ukk5RUVz?=
 =?utf-8?B?eGk4WGN2TjNvZWI1U1YvRXZEZ3BTd0RjUW1TSzYyL2Jhb2pEMDNzbDErdWJY?=
 =?utf-8?B?STFVY3RhRXJ1eksxTzVCblhnL1F1dzJXL3RJWGFybElMamZEZ1FlN0dFekF1?=
 =?utf-8?B?UTg2MFZyT3lKY2srQ3lOWEFpL3N1emMwUTFKWG1ZQVZQTDBYZTJRem5ZRFJI?=
 =?utf-8?B?d0RaZ1VMWkRkSWM2M1RacDRLVnJkajdtUzdqRnJlR2VhU1BkUVdVa1pSdnpJ?=
 =?utf-8?B?NEpMRnFwWk9BYlE4dWE4bCs5L2crLzF4andLdFUwS29JeWx1SXB5SGZZR1pG?=
 =?utf-8?B?WjNDWkhKS0RSUDBPV3c5RGljbmxUVTFCdTVqVFcyMDhmRkh1a2w4eWtLTldB?=
 =?utf-8?B?S2ZrbElpTUQvdGJndHBubEt3QVk1QXZuR0hUTFJYRTVGMlBIOVVJbjBQU0tE?=
 =?utf-8?B?ZmhMS0paK25ObFhoR3Q4aUtyMmxaY0tDc0w5bGNVMVludUk2WVFrcTQwbnhx?=
 =?utf-8?B?YlBDUXZYNnFINjJiTjBuaUlKZUUzbkp5bUo0QzlsY2pOak5Yeml0RlNDZ2pw?=
 =?utf-8?B?TDY3NDlBYVYxTWJMV0VKQ05JM2JmeVMrU1cxSVhJMDVtREVYaFVpbmlGeXJK?=
 =?utf-8?B?R3dpWXlPQzFFYmRYREt6YzV6bTY5TDBVenpoYlF2c0F2WlRwaHg2bE5GVG11?=
 =?utf-8?B?RTNaVlZmVDZqVmpjTXh2Wk1VU3RzT2k1SVMySTRBT3Nsd0ZHYUVkdWRhd1E5?=
 =?utf-8?B?VHJQRFhKcGFtenRuVG1uNTU4YjVLcWM4MXMzU0N4U1pId3paSkY3SWJUUEpW?=
 =?utf-8?B?enB4SlBZcmtIS2JlNWxXNGRnbkJBOUVjRDJGWlZ1MDhnRlZZQWZoT01BY05h?=
 =?utf-8?B?WDU2aVpCNFUrQ1p3SlY4NS96eDlVQ2FUYUZNN2g4TUJlcUVzcTFYS2JiMmtZ?=
 =?utf-8?B?eHV3TVFISXFtbGFrYXhVeDI2c0ZNNW85Z3h3ZGYwdXZ6USthMStYWnhGVE5q?=
 =?utf-8?B?N2FUVlh1TkRMdk5hK3AwbGkzNCtEanE0SWZPQ1FkU0pzWHg0TVY4b3lQYWZh?=
 =?utf-8?B?MlZXMXhuRFVXZWJDclNZQkppNGpQbTZhS24xSmNuZWJIRTk0U3pOMTNUOVp1?=
 =?utf-8?B?TVpvNVdPUEg3YVB4ajYrQlJNSklhVnJta3ZBT0RsWHNMTXZNMzlINldONkJp?=
 =?utf-8?B?SEo2M1ZWRk5jOTZZMFdpWVc2N2dMaXFBVkJKOUQvNGhDUU44TThMcEJWU1lq?=
 =?utf-8?B?NmJVN3NPOEh2M0VIT1Bkc1VZeEQzZWd2WGZxeXlJQzE4djBlQ25WL0JIR2NI?=
 =?utf-8?B?cXVEb0M4emZUWThIaGxaWTVMdjdOVENSdWFVcHNPcFRoWndza0NwaXEvQ0sz?=
 =?utf-8?B?N2haU094R0JIenoxcWtDbERpODA2ditTbTgyMnE4UEdINXhORXIzWXZxMCth?=
 =?utf-8?B?VmNkei90TTJkZ3dwbDRMMlc5L1lqa3l3aDZBSXBnWmE3TnYzSFMyVFRFOGZh?=
 =?utf-8?B?bVJDcWhISjlGYzI3bnB6TVpBTUt6UmU0WC9SOXZJeEFlN2NiYmdiOEF1ZTJx?=
 =?utf-8?B?TzdFVEl4cVo0V2tEaXpvdFRvcytGckl1bjhNVis3Ymx0WWdGZFNNbUl6c1FK?=
 =?utf-8?Q?unnudc39w2+dorqfUV5sDH2Dh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb5f40d-9e67-477d-5425-08dcd1386e0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 01:32:27.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yluiivyRxO6GtpTVVVEtDi63ssRzQ36bM6/xMLDVGXhh/aVebNgI69IgalKeD/9k7k0WYBn2wu22BTPH/jNHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

On 9/9/2024 4:52 PM, Sean Anderson wrote:
> 
> The default RX IRQ coalescing settings of one IRQ per packet can represent
> a significant CPU load. However, increasing the coalescing unilaterally
> can result in undesirable latency under low load. Adaptive IRQ
> coalescing with DIM offers a way to adjust the coalescing settings based
> on load.
> 
> This device only supports "CQE" mode [1], where each packet resets the
> timer. Therefore, an interrupt is fired either when we receive
> coalesce_count_rx packets or when the interface is idle for
> coalesce_usec_rx. With this in mind, consider the following scenarios:
> 
> Link saturated
>      Here we want to set coalesce_count_rx to a large value, in order to
>      coalesce more packets and reduce CPU load. coalesce_usec_rx should
>      be set to at least the time for one packet. Otherwise the link will
>      be "idle" and we will get an interrupt for each packet anyway.
> 
> Bursts of packets
>      Each burst should be coalesced into a single interrupt, although it
>      may be prudent to reduce coalesce_count_rx for better latency.
>      coalesce_usec_rx should be set to at least the time for one packet
>      so bursts are coalesced. However, additional time beyond the packet
>      time will just increase latency at the end of a burst.
> 
> Sporadic packets
>      Due to low load, we can set coalesce_count_rx to 1 in order to
>      reduce latency to the minimum. coalesce_usec_rx does not matter in
>      this case.
> 
> Based on this analysis, I expected the CQE profiles to look something
> like
> 
>          usec =  0, pkts = 1   // Low load
>          usec = 16, pkts = 4
>          usec = 16, pkts = 16
>          usec = 16, pkts = 64
>          usec = 16, pkts = 256 // High load
> 
> Where usec is set to 16 to be a few us greater than the 12.3 us packet
> time of a 1500 MTU packet at 1 GBit/s. However, the CQE profile is
> instead
> 
>          usec =  2, pkts = 256 // Low load
>          usec =  8, pkts = 128
>          usec = 16, pkts =  64
>          usec = 32, pkts =  64
>          usec = 64, pkts =  64 // High load
> 
> I found this very surprising. The number of coalesced packets
> *decreases* as load increases. But as load increases we have more
> opportunities to coalesce packets without affecting latency as much.
> Additionally, the profile *increases* the usec as the load increases.
> But as load increases, the gaps between packets will tend to become
> smaller, making it possible to *decrease* usec for better latency at the
> end of a "burst".
> 
> I consider the default CQE profile unsuitable for this NIC. Therefore,
> we use the first profile outlined in this commit instead.
> coalesce_usec_rx is set to 16 by default, but the user can customize it.
> This may be necessary if they are using jumbo frames. I think adjusting
> the profile times based on the link speed/mtu would be good improvement
> for generic DIM.
> 
> In addition to the above profile problems, I noticed the following
> additional issues with DIM while testing:
> 
> - DIM tends to "wander" when at low load, since the performance gradient
>    is pretty flat. If you only have 10p/ms anyway then adjusting the
>    coalescing settings will not affect throughput very much.
> - DIM takes a long time to adjust back to low indices when load is
>    decreased following a period of high load. This is because it only
>    re-evaluates its settings once every 64 interrupts. However, at low
>    load 64 interrupts can be several seconds.
> 
> Finally: performance. This patch increases receive throughput with
> iperf3 from 840 Mbits/sec to 938 Mbits/sec, decreases interrupts from
> 69920/sec to 316/sec, and decreases CPU utilization (4x Cortex-A53) from
> 43% to 9%.
> 
> [1] Who names this stuff?
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> Heng, maybe you have some comments on DIM regarding the above?
> 
> Changes in v2:
> - Don't take the RTNL in axienet_rx_dim_work to avoid deadlock. Instead,
>    calculate a partial cr update that axienet_update_coalesce_rx can
>    perform under a spin lock.
> - Use READ/WRITE_ONCE when accessing/modifying rx_irqs
> 
>   drivers/net/ethernet/xilinx/Kconfig           |  1 +
>   drivers/net/ethernet/xilinx/xilinx_axienet.h  | 10 ++-
>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 80 +++++++++++++++++--
>   3 files changed, 82 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 35d96c633a33..7502214cc7d5 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -28,6 +28,7 @@ config XILINX_AXI_EMAC
>          depends on HAS_IOMEM
>          depends on XILINX_DMA
>          select PHYLINK
> +       select DIMLIB
>          help
>            This driver supports the 10/100/1000 Ethernet from Xilinx for the
>            AXI bus interface used in Xilinx Virtex FPGAs and Soc's.
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 33d05e55567e..b6604e354de7 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -9,6 +9,7 @@
>   #ifndef XILINX_AXIENET_H
>   #define XILINX_AXIENET_H
> 
> +#include <linux/dim.h>
>   #include <linux/netdevice.h>
>   #include <linux/spinlock.h>
>   #include <linux/interrupt.h>
> @@ -123,8 +124,7 @@
>   /* Default TX/RX Threshold and delay timer values for SGDMA mode */
>   #define XAXIDMA_DFT_TX_THRESHOLD       24
>   #define XAXIDMA_DFT_TX_USEC            50
> -#define XAXIDMA_DFT_RX_THRESHOLD       1
> -#define XAXIDMA_DFT_RX_USEC            50
> +#define XAXIDMA_DFT_RX_USEC            16
> 
>   #define XAXIDMA_BD_CTRL_TXSOF_MASK     0x08000000 /* First tx packet */
>   #define XAXIDMA_BD_CTRL_TXEOF_MASK     0x04000000 /* Last tx packet */
> @@ -484,6 +484,9 @@ struct skbuf_dma_descriptor {
>    * @regs:      Base address for the axienet_local device address space
>    * @dma_regs:  Base address for the axidma device address space
>    * @napi_rx:   NAPI RX control structure
> + * @rx_dim:     DIM state for the receive queue
> + * @rx_irqs:    Number of interrupts
> + * @rx_dim_enabled: Whether DIM is enabled or not

nit: These should be in the same order as in the actual struct
sln

>    * @rx_cr_lock: Lock protecting @rx_dma_cr, its register, and @rx_dma_started
>    * @rx_dma_cr:  Nominal content of RX DMA control register
>    * @rx_dma_started: Set when RX DMA is started
> @@ -566,6 +569,9 @@ struct axienet_local {
>          void __iomem *dma_regs;
> 
>          struct napi_struct napi_rx;
> +       struct dim rx_dim;
> +       bool rx_dim_enabled;
> +       u16 rx_irqs;
>          spinlock_t rx_cr_lock;
>          u32 rx_dma_cr;
>          bool rx_dma_started;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index eb9600417d81..194ae87f534a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1279,6 +1279,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
>                  axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
> 
>          if (packets < budget && napi_complete_done(napi, packets)) {
> +               if (READ_ONCE(lp->rx_dim_enabled)) {
> +                       struct dim_sample sample = {
> +                               .time = ktime_get(),
> +                               /* Safe because we are the only writer */
> +                               .pkt_ctr = u64_stats_read(&lp->rx_packets),
> +                               .byte_ctr = u64_stats_read(&lp->rx_bytes),
> +                               .event_ctr = READ_ONCE(lp->rx_irqs),
> +                       };
> +
> +                       net_dim(&lp->rx_dim, sample);
> +               }
> +
>                  /* Re-enable RX completion interrupts. This should
>                   * cause an immediate interrupt if any RX packets are
>                   * already pending.
> @@ -1373,6 +1385,7 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
>                   */
>                  u32 cr;
> 
> +               WRITE_ONCE(lp->rx_irqs, READ_ONCE(lp->rx_irqs) + 1);
>                  spin_lock(&lp->rx_cr_lock);
>                  cr = lp->rx_dma_cr;
>                  cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> @@ -1670,6 +1683,7 @@ static int axienet_open(struct net_device *ndev)
>          if (lp->eth_irq > 0)
>                  free_irq(lp->eth_irq, ndev);
>   err_phy:
> +       cancel_work_sync(&lp->rx_dim.work);
>          cancel_delayed_work_sync(&lp->stats_work);
>          phylink_stop(lp->phylink);
>          phylink_disconnect_phy(lp->phylink);
> @@ -1696,6 +1710,7 @@ static int axienet_stop(struct net_device *ndev)
>                  napi_disable(&lp->napi_rx);
>          }
> 
> +       cancel_work_sync(&lp->rx_dim.work);
>          cancel_delayed_work_sync(&lp->stats_work);
> 
>          phylink_stop(lp->phylink);
> @@ -2068,6 +2083,31 @@ static void axienet_update_coalesce_rx(struct axienet_local *lp, u32 cr,
>          spin_unlock_irq(&lp->rx_cr_lock);
>   }
> 
> +/**
> + * axienet_dim_coalesce_count_rx() - RX coalesce count for DIM
> + * @lp: Device private data
> + */
> +static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp)
> +{
> +       return 1 << (lp->rx_dim.profile_ix << 1);
> +}
> +
> +/**
> + * axienet_rx_dim_work() - Adjust RX DIM settings
> + * @work: The work struct
> + */
> +static void axienet_rx_dim_work(struct work_struct *work)
> +{
> +       struct axienet_local *lp =
> +               container_of(work, struct axienet_local, rx_dim.work);
> +       u32 cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp), 0);
> +       u32 mask = XAXIDMA_COALESCE_MASK | XAXIDMA_IRQ_IOC_MASK |
> +                  XAXIDMA_IRQ_ERROR_MASK;
> +
> +       axienet_update_coalesce_rx(lp, cr, mask);
> +       lp->rx_dim.state = DIM_START_MEASURE;
> +}
> +
>   /**
>    * axienet_set_cr_tx() - Set TX CR
>    * @lp: Device private data
> @@ -2118,6 +2158,8 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
>          struct axienet_local *lp = netdev_priv(ndev);
>          u32 cr;
> 
> +       ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
> +
>          spin_lock_irq(&lp->rx_cr_lock);
>          cr = lp->rx_dma_cr;
>          spin_unlock_irq(&lp->rx_cr_lock);
> @@ -2154,7 +2196,9 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>                                struct netlink_ext_ack *extack)
>   {
>          struct axienet_local *lp = netdev_priv(ndev);
> -       u32 cr;
> +       bool new_dim = ecoalesce->use_adaptive_rx_coalesce;
> +       bool old_dim = lp->rx_dim_enabled;
> +       u32 cr, mask = ~XAXIDMA_CR_RUNSTOP_MASK;
> 
>          if (!ecoalesce->rx_max_coalesced_frames ||
>              !ecoalesce->tx_max_coalesced_frames) {
> @@ -2162,7 +2206,7 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>                  return -EINVAL;
>          }
> 
> -       if ((ecoalesce->rx_max_coalesced_frames > 1 &&
> +       if (((ecoalesce->rx_max_coalesced_frames > 1 || new_dim) &&
>               !ecoalesce->rx_coalesce_usecs) ||
>              (ecoalesce->tx_max_coalesced_frames > 1 &&
>               !ecoalesce->tx_coalesce_usecs)) {
> @@ -2171,9 +2215,27 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>                  return -EINVAL;
>          }
> 
> -       cr = axienet_calc_cr(lp, ecoalesce->rx_max_coalesced_frames,
> -                            ecoalesce->rx_coalesce_usecs);
> -       axienet_update_coalesce_rx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
> +       if (new_dim && !old_dim) {
> +               cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
> +                                    ecoalesce->rx_coalesce_usecs);
> +       } else if (!new_dim) {
> +               if (old_dim) {
> +                       WRITE_ONCE(lp->rx_dim_enabled, false);
> +                       napi_synchronize(&lp->napi_rx);
> +                       flush_work(&lp->rx_dim.work);
> +               }
> +
> +               cr = axienet_calc_cr(lp, ecoalesce->rx_max_coalesced_frames,
> +                                    ecoalesce->rx_coalesce_usecs);
> +       } else {
> +               /* Dummy value for count just to calculate timer */
> +               cr = axienet_calc_cr(lp, 2, ecoalesce->rx_coalesce_usecs);
> +               mask = XAXIDMA_DELAY_MASK | XAXIDMA_IRQ_DELAY_MASK;
> +       }
> +
> +       axienet_update_coalesce_rx(lp, cr, mask);
> +       if (new_dim && !old_dim)
> +               WRITE_ONCE(lp->rx_dim_enabled, true);
> 
>          cr = axienet_calc_cr(lp, ecoalesce->tx_max_coalesced_frames,
>                               ecoalesce->tx_coalesce_usecs);
> @@ -2415,7 +2477,8 @@ axienet_ethtool_get_rmon_stats(struct net_device *dev,
> 
>   static const struct ethtool_ops axienet_ethtool_ops = {
>          .supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
> -                                    ETHTOOL_COALESCE_USECS,
> +                                    ETHTOOL_COALESCE_USECS |
> +                                    ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>          .get_drvinfo    = axienet_ethtools_get_drvinfo,
>          .get_regs_len   = axienet_ethtools_get_regs_len,
>          .get_regs       = axienet_ethtools_get_regs,
> @@ -2964,7 +3027,10 @@ static int axienet_probe(struct platform_device *pdev)
> 
>          spin_lock_init(&lp->rx_cr_lock);
>          spin_lock_init(&lp->tx_cr_lock);
> -       lp->rx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_RX_THRESHOLD,
> +       INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
> +       lp->rx_dim_enabled = true;
> +       lp->rx_dim.profile_ix = 1;
> +       lp->rx_dma_cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
>                                          XAXIDMA_DFT_RX_USEC);
>          lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
>                                          XAXIDMA_DFT_TX_USEC);
> --
> 2.35.1.1320.gc452695387.dirty
> 
> 

