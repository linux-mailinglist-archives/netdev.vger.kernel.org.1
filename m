Return-Path: <netdev+bounces-212452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4241AB2084D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B1E188A935
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F392D23A6;
	Mon, 11 Aug 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uyGIc+Bj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2120D50C;
	Mon, 11 Aug 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913889; cv=fail; b=cJOwgMV9FEhHmcRWY8kEMCMpW/aNGY/pBMVLXPZAFsyziScdJkZWJolP+cglrFEi7hxuqidfMOMMfx0/iLjwECkQ7LlhsqmPwmkGxInFbO/0ts6KmzCfRmB1p2ia02M20FWRFgsEytH4OZelB3qzgiBQW6ME/x8GeHKEiiWvDbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913889; c=relaxed/simple;
	bh=C5jb3mn1a+SCwHebUqhpa2F46aBTi7r1xBIGx8VCyHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q87tSE4WWxxQ6pIwHQWQEv40TLPvuqgPfZjnuZTb/h2VE+WJU07NmtqmH9zE1Uxc0WxrR9rhmmH8hCFg9XAUqO9y4HX9uaLGrskzca1Yo106DbqAzk0MfroA9YEznct/B8K2DOIkqsUwEViYWGs2RZUtKyUHEpqCmDxRf9n2TBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uyGIc+Bj; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmLz+RJhKXt/aRm+CiSJcCyPiFXqdobLQwS/AHaegjUAXk+WDA/V1JcngzhSdaIhtav0jsJPEMW66e0k/xnutNa4579U1vRq1NQTmbRnOroeGDAM9lxZfswNlICieCvQ4Mo0A0gejIi0WoI0hMIZ9U9prmgWjjhf5CB2pCyYv3PUgGpO0N9DbKwywe/tceK74RIYUwimO1D5190NDCl4MKr236dH3+QX3224xLnRJo66SNtCL6Yrq1BOWMMSRKZQ+leBfyZLo56cMK9+4kIXpdZUAFL/4IHDUsYQzYNZHq6M2vzGi3V14WolowawiCK/i8hLDvZKtWGmpMQ+CtUTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkL7rLbzx79ihECib9Bp87E7Rqmh3Q6OJ9bEBR4qE4M=;
 b=G+mqAxcbteFq9n+eONbJVwi0yUc9IBE/yoMVC24nZk7HGpU/Flss8NM4x0Ox7XiNAhcxrLSVZ7WD6GCDjsH2VF8McSk9VEvsTeJ+tS05qA5fkaihZMzk6q8z0AeO1QlIUcWd+ZBiVF5Vph+69T4MwXQ+aSCeIdaJRUzjCeiJ49xp0sqiOqs8a7BxlVVyZz42HsBm8FRg0LDuI0ATwoXTRnH2h+IE/3gcaNrzrsPrQyrcbIKwo1HkJqHf/USmmuWMEbEUAPgEEhRvSMOEbppy2aMWzIbp3VtRrprr+6A3fHcfqgw37IsYC8+88uXPdhtIxKyTgnypKvXWzfcJnlBD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkL7rLbzx79ihECib9Bp87E7Rqmh3Q6OJ9bEBR4qE4M=;
 b=uyGIc+Bj5KlOjH5uVXxlngxqQBnumpWuNUH6/o951rXey1snmfcd/54ArZlOob4+pBBWIs3VaFAq0i29amnAivGAdm8Wn04par5QNc7xSRKr9iXVV2AWBnCnF6JgXB6hYmhktWGcafjQBG9kKjroiJJVgvb72CBG6pPSqTe89EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:04:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:04:43 +0000
Message-ID: <38a14584-0638-417c-b9e6-ecc6b711b25b@amd.com>
Date: Mon, 11 Aug 2025 13:04:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
 <68922e004131f_cff991001e@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <68922e004131f_cff991001e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0326.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 08022d0a-6559-4190-9f22-08ddd8cf4201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1BuWmhhUUVXYnIyQVNXSU96cVRzK0prbzEvbmc1bjBsck5EWXB2Y2dOaHI0?=
 =?utf-8?B?MkhLWXBpZWJ2N282a3gyODNreUgwYWtDc2hyTk9XVnRkMWV0Um1BZHdjRmV4?=
 =?utf-8?B?N2IrdVo2d3BUdGo3RXBmL3FkbG9udTkyZUdZbFpkL0FoY2FqMFBUMXBXZ1R1?=
 =?utf-8?B?RnRpMGtvNGpjZStVVEJiVkVkYnFiaVRyY01zdm1PdVZ2WkJhUVBMSEs1SlJ0?=
 =?utf-8?B?SnRiRHEzMTVNOW4wc1hKY0w5SkRGdGFHbE5xSWRHWGZHa1k4YlF6cmwyYm1O?=
 =?utf-8?B?QlVmVXVrSXJRS0Z5T2VCZ2l3eDlCWTQwMkV1YUpuU0h4ejZCbXRhdHlWalZX?=
 =?utf-8?B?cXBZbk9nTkM3MTBjdk93bURzZlNyWDlOeDNDUHVpK21FUUo0N1RXY25PMEtP?=
 =?utf-8?B?d3RIb2NlSHBocTNkMmVVUEhoR2M4dUZmdFY5MS9Na2o1NlRTU2JKckpCaXAz?=
 =?utf-8?B?N2NidGJWVHZSeVZKc2ZMaXArOVNteDZuZUNLY3BVMk91Mys3OERiZDdSKzJ0?=
 =?utf-8?B?ZmtQZENEZVZJTjVUeFdJM1JZTEl3NkJERHd4MjMwaUJ2ell1RFkvUFVzY1Vn?=
 =?utf-8?B?SHhoWStOT0FIT2NueTE4UWVpWmdMRHhyV3FxbDBML09JZGJjemtEVktwamFU?=
 =?utf-8?B?d3VkcGg2aXFNaXJUY3RLanM2M3J6dldBekprbnJpTTk2dTU5dkhNN1BoSHRl?=
 =?utf-8?B?WW1kaHE0T1RHTFRzM21ORGRYWCswQ2FqRi92d0NHNlJsZDVGZzRUVWp3T2RQ?=
 =?utf-8?B?VFUrRlNSZXYxYmNoMU5aWjJWYkRJb2pibElJU05LaHVxRnhkNjN1WlFWM1Z4?=
 =?utf-8?B?RkwzQlNOODNLTWhiNlk3MzZiYmZyTmIwZEtYekhHNmVxaHZGcURnalMzUUhC?=
 =?utf-8?B?aTkrMGlGeFRPTTdGRTYrYm1JMWQvcm9aRDY4U2FkWjk0cU1EbXVFK1p1Q1pM?=
 =?utf-8?B?OWhSR1pOV1l1UENBTnMzM2M2YmxGdVdheFlVRG15d1FzLy9FVVppU1FqQWdT?=
 =?utf-8?B?aFhDTEgwZGRmZGl0MnhKS1pkZTlXOTRsZ1d3dk54TlFmb0pXMm9UZHNGOTd4?=
 =?utf-8?B?cFRoK1VqUHF4REt3ZmZZbllpWmZrTzB6SkZzaFZBZFJEQUZGbnZ4aGd1dzg2?=
 =?utf-8?B?eit0UE5SYk04dHp6VjZ5VThLM21KZG1hL2ROSnZCYkJreERZQUtBYjNNVE5x?=
 =?utf-8?B?enFGcTdsOHY1T1NBRHpTTS9PMkJ4K0JPNHp2NUhPS3FwdnFSNTFKQlpWUzBM?=
 =?utf-8?B?d0FyQ3V0UWMyMHI2NVNWVnhocjhiS0ljZWdkNkQ0d0pSc0ZCSFhGYVBEZzNR?=
 =?utf-8?B?QllLM0N6R3ltd0dhdHZrOVJPYW1FaDdhMEdpVEZkNlFYM25FZW41c2pZOFlF?=
 =?utf-8?B?ZHM2VVJsVjFwWUVzVjlOYXZNcEJTY0hMbStseXExUjJsZkNXcDM4Vm5MMUhj?=
 =?utf-8?B?VmFIQ0ZvVjY2MmM2TmdGYmhieGd6VjZkcnlhTDlGdlB5YlJLdFpVTTgyWmN2?=
 =?utf-8?B?SGhFOUJLcGYydW1zcmdXeE85ZWhiWkZFSnh1ZjhscVZYK1dnWjBsSTFrZklE?=
 =?utf-8?B?aGh6YTh4NTJ2VmxJcUhyZlQvNHQ1ZWo5U3Nkb3IzQVJmbDFwWUNjQmpPNE9u?=
 =?utf-8?B?NEFCeGVkSU9aT0crQmozM0U5dDFydEcraVhHdEhkOVJpWEJSOFRySE4rbkdz?=
 =?utf-8?B?cm5HZEtnOUl2bnhXWmhnOWNLYjkvcTJRaHc1Sld0aUZXSVZPK1p1NXEvd2Rp?=
 =?utf-8?B?Z3RHYXN0QUQ1eTdxQnN6ZERqSWxLYmlqdWFHZ2ZEUDhVemI3MVo5T0UwdnZ5?=
 =?utf-8?B?TllvRUtFY0tnclg1alFud2JON005bTcwN2pXNEZkY1ErbWRLWlFjdGJFK01z?=
 =?utf-8?B?SXBHcmtoTE9XMllEUUdCTkwvUk9FaTQ2TXFObWtzaTdxN2k4ZExPYVVnNHZu?=
 =?utf-8?B?a3YrSDZPdG5MMy9CNUVPWm9pMFRuMVJ3dzNxUmlPNjVEKzljcGVIYTlNd09Y?=
 =?utf-8?B?ZUZGeFMxc2V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmhEOER0V0tUaVZodGVOcHlMZlh4ZDFyY0duTUJUQWdZVWxDSitJNXZWR29B?=
 =?utf-8?B?REp4SEg3Znl4cGdIeVV5dHhwbSs5QzhZS0NoaGlzU1ZxbWNzOFRjQ2dHeVcv?=
 =?utf-8?B?SUxzY3ZsY0FONGlxOXJrM0h2YWJZcHBtNEYySS9lVDIvZXJqZVhUMnJCU3RK?=
 =?utf-8?B?SkdQdlF3c2lsS2trTEZ6a3ZyUkFHNzFjZGgxOTk2Y2hQUkdBb1R0VjdxNnBO?=
 =?utf-8?B?ZTJ1TXZxbFFIenRYbENKYkRMNDdrOStoSXY5M3h3dVM0dzdKZ2VramZUeVJV?=
 =?utf-8?B?Rk1aNGpRU1RkR3VsazhXZmpJRFdhb0pwUnJjbU8ySXBla3J3ai9aSjcxSGpB?=
 =?utf-8?B?NzdiQXRubFdYMEI4a2Rsa2dWcmp1c1hRZ0JRWWZEY1dvSjRha01YSVlxbTM1?=
 =?utf-8?B?ZWR0OEROSjNQV0RhWWhkMDJRMGpVVngzdk1DQ3RrOHFheHM0U0Z3TGovMjQr?=
 =?utf-8?B?azlkbVdyZFpUbnI1NHQ1RThZSzVsOHBGMkhQQldLSHV6S0RIUm1YMHRxcWFy?=
 =?utf-8?B?SGgwTy9qVElkZXpKL2h3WWltbjRaMlVkWXFISUpZdXlITDJoQ2xlZWJxT0Vn?=
 =?utf-8?B?dkg1b3J2eE1LSHoyUUZVMXhaK2pLSi8xdXV3QnFQY1ZqQXhHNG9NcnppVG1a?=
 =?utf-8?B?QUhhMjVXMWl5TW8vZTQrck9vZ2V3TWlVWEFJQkY4VXFBZWxsTERNSVJNb21m?=
 =?utf-8?B?RUIyOVRCdDZoQ1ltREZKREZJN3dXL1YvM2NXU2xFS0ExVmNoVVV3MTA0QWlK?=
 =?utf-8?B?TEVkM3lLWkIyaWkyUGprMVhnK3NzQlNyd0pMa2hlUWpybzRQMkZvQlZDNXNk?=
 =?utf-8?B?MDJSa3kzNzYxeXJYa2F2cjRkckZKamVmQW1sbjNKUm5KT2VJVk5nMnBtSDIr?=
 =?utf-8?B?YlNYbDlCd0FPUU5kbUFia1pJOWx2TkNaRXpLME5sTG1GWWtQWVpuR2Nlai9U?=
 =?utf-8?B?aTZ2aGxvZDJMdXFJQ01vQ21wUDdTRU5RNXAyUllMallnVHJua1BtM3lWOUVx?=
 =?utf-8?B?cUsxeTRCVmFLckQzSmsxQmx3Wnc0RWFiL296UnUvUzBNN3VYbUpiRTUvdXpt?=
 =?utf-8?B?dFdPa2RPUmR0QTdZM2tFTEF4enZ6MUZNK0FLVHZmdS9DNzdLeEZnSHhOMmJs?=
 =?utf-8?B?M2JIVng2ekh4QTRHSXV5V2ZBakwxaWd4bTJmUDBDZysyUEJQSTN5S2lPME5y?=
 =?utf-8?B?WjAwVEFzYXo0cXp6dW9LZUtqMnFjNnlFNnBoRUsxYWVnZWJ0b2QwVkRUUVIx?=
 =?utf-8?B?TEVkczh1bE9kekRzYklacyszM0V4ZUdmcFZzbjJxVFFzeFpVVTFKRjBMUWdC?=
 =?utf-8?B?NHRoMVFYdGFmdzRqS08wZXR3dzJPMTJmQmN6NHdudXUvZzVPT2NkY2dFTjdV?=
 =?utf-8?B?Z1JnbGNjVHVCaER2bW1IVkx3eXJRWjZhN2xac1RUejNNM3BmQlhTdGVzRnFN?=
 =?utf-8?B?WmJpUmMxcEhYWVE3MXE1U2tPL01TZnI4MGErTWxIYnRETHFHbGs1c25DZkJ2?=
 =?utf-8?B?YlBQT01wbHRSaGV6NUN2UTdPRnI0UGNDeHI2T1lnVU1OQ0Ird0FBVHpJbWtC?=
 =?utf-8?B?ZUVLM0tUOFZCUWRDWFZPRno4TWY0cjV3K09TaEcrLy84OTFwTWNsSm9aSkdS?=
 =?utf-8?B?cy9nbExpTzVMdktxcnBhSmZZZ0ZLSXE2Z1FQamxZZlVod0VYbjY5R1dHMXMw?=
 =?utf-8?B?b2xsN1RqZ0tHL0JKN1V0OG52WUxBQzBPWkVjd2JaYUVOL2h4UFNleDJia01w?=
 =?utf-8?B?WDM5aXNCZWdjdVgxa3oyL3BJZmVMQndhUjJQaGdIN3drb1hFU3lHQmt2Q3NJ?=
 =?utf-8?B?TnhTTmNVZWVod0RJOEVoNEVOTWtKM3NRNDg0ME42c2JXSml6czZBV1lZU1NC?=
 =?utf-8?B?SW1jem5CemV6OGNkWlFqd3RZNnhBRlJuczBRU1B1bkR2WVpnay9vMkRoRHpv?=
 =?utf-8?B?TDBNSHZXeXc1dWxYSGhMS2hPU0VWMmhGVFNCUjJrSno0bnBwcjRHLzladVRk?=
 =?utf-8?B?UjhlR09RdzVJZjBmd01sdzZIZGwrQ1NZKzJrS1E1Z0RZYlJmV2gzZEw1QWRI?=
 =?utf-8?B?dGJJY1dMY1d1aXY2bXhEMmRHZFBCTXNwZ0xIZWpKdGJYOXJoREIxRFo4K3E0?=
 =?utf-8?Q?wx/X63lCu65/ySI1bNSUkr1Em?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08022d0a-6559-4190-9f22-08ddd8cf4201
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:04:43.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCZPT3zxnlWLkRdlO2yY/lkxImsJf/nR7JXAaBDrkLZJYytNZ6A8HvnBTqp/oW9D5O7AA8iHG8W0Hs3Wr7w8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924


On 8/5/25 17:14, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 169 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  11 +++
>>   3 files changed, 183 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c3f4dc244df7..03e058ab697e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,175 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	/*
>> +	 * Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
>> +	 * 32 bits, the bitmap functions can be used.
>> +	 */
> Comments are supposed to explain the code, not repeat the code in
> natural language.
>
>> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
> How is this easier to read than:
>
> 	if ((cxld->flags & ctx->flags) != ctx->flags)
> 		return 0;
>
> ?


I think it is not!


I'll simplify the code with your suggestion.


Thanks!


(more comments below)


>
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++) {
>> +		for (int j = 0; j < ctx->interleave_ways; j++) {
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev,
>> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
> With the benefit of time to reflect, and looking at this again after all
> this time it strikes me that it is simply duplicating
> get_free_mem_region() and in a way that can still fail later.
>
> Does it simplify the implementation if this just attempts to
> allocate the capacity in each window that might support the mapping
> constraints and then pass that allocation to the region construction
> routine?
>
> Otherwise, this completes a survey of the capacity that is not
> guaranteed to be present when the region finally gets allocated.


If we use alloc_free_mem_region the resource is reserved so it will not 
fail later.


But this requires a major change in the current approach since if we 
keep trying to get a suitable root decoder, the one with larger 
available hpa, we need to release the previous allocation once we obtain 
a new one. Then, because allocated DPA will likely be smaller, another 
release will be needed later on. I would say it is not going to simplify 
things.


IMO, although such change makes sense and it will be needed when CXL is 
hopefully massively deployed, the risk of the HPA allocation hint not 
being there is quite low at this moment. The function is explaining the 
potential problem as well, so I would prefer to not try to get the 
perfect implementation at this point, and to leave such a improvement 
for a follow-up work which I will be happy to work on.


