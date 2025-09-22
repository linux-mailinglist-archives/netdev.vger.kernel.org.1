Return-Path: <netdev+bounces-225385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0483B9356A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7641F19C01C5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95828151C;
	Mon, 22 Sep 2025 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kJfW8jW+"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBA34BA39;
	Mon, 22 Sep 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575370; cv=fail; b=Nf78PAK4uCoxdqj7NXxAVMqwqLizPvk1FZGNGBRjNhfpJJlZa8anpCrEusEuYvdIwPW4m12M7cOgXd3Y0GLwoZcz6gbpuWxrLxuN+UzhDyJX82gi1ZPknsDfAL0sTTW6QG3QJpwP4jG4DL1NMysirIbrksrt0X61ZCTiAVY3gyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575370; c=relaxed/simple;
	bh=4Q/FIQkVQeNEL5IH1xfXmJNpfh5YMDtmx16jSbgIQJE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=TjIzZTn7c/XYIPI+nBem2vlPWv2MptzVE9m/H7DEuBjHaCxySzAQUEKRB0oWiU9Hr4N2xmBXekSduM77crI1ezwHyGaq3LzEcieqKfQTWlGnQTvKhnzYloUy4BinY4WSZGRKbXQOmodb1dK4LYf+ESucjVm9jOOjQBMMOHr5rno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kJfW8jW+; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8PS2nQIAOqFwp1JLopvcasJeV7DRPZRM/s9gpM4hz8W/9eXnaUx4Ea/7fCCXTSz+/slRSA/0KRyEAnwEyfPnU2+JJm9b/EKAABcBVZNjyDRk5HW7u8P0kIs6gGX5TWWvStdtr0kTge7J0grufUO8/gRdW7cjJmzU3xjXnKyxJf72WvU/OFFfLJbBlTCxFBDBOndWoZhhk8s0DNdImR0ZXIFR1IPjODWFdntsrSe6tQzr5i4dgLjSDMmAwrNvBBDq+GBti0pdniVa7MTNcZ/cC7+YSCvxl8pnN6+EII4RCzvllN7gcvvp6YAw/r+UBGv8ZbPqbCfTijWWbC7AObQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDW9rBQ37zU9o438if7etKRHGWeykKUSYh1FUJZyoA8=;
 b=xSYrxrrGP5+h0USvF+RU/+cHTQ5tWj5Me4sBAXKlm64w+tQOCwX9rAT8Ohcr6CPva5iifJa2b1DGx4dmt1zkKvivRnRmL1d5R0lTZCpj1bqyUKTk+cjW6iIM+bIs6W9yyHBoUqHZGA203Bw/zgrTDuKo5DVg0PCEZD4ne8i+8BGgMTE1dmLCcJ+5h/KhtLBXL4NzSWJiCBjv7EDDte2AL99yFgXTMSyTlZqmE52TaNBcSpQyboBuoexC3jD01YfXXCzhW48V6LPPMcak0py8mopgAKfZeaBmXsxHY9vLNwnm4NL6CBnXkGazKwCACTLtuk5evkcMKRnRVmwQjkOOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDW9rBQ37zU9o438if7etKRHGWeykKUSYh1FUJZyoA8=;
 b=kJfW8jW+q02NltK5E/iW6n0ZCCqW8aSsv0mSdIFeWe52ZKFMsgLbT0hgXvqGgNSsDaHDggYP7bRN3B4GERPMwlFe+bh8RNuVhYHRRZPmAXtyMpvwbUDVvvHEl4lak/DP45pqXIKyY3Zpr6fSdN0YMj99bo0yvPifrpILlLF07KQ=
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:09:22 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::f4) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:20 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:19 -0700
Message-ID: <4242f497-6594-4fc1-abdc-adf83d72f7d2@amd.com>
Date: Mon, 22 Sep 2025 16:09:18 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 10/20] sfc: get root decoder
To: <alejandro.lucero-palau@amd.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cdf36a-c326-4660-e053-08ddfa1c4ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnNQSXYrRWFSeHpyTnlTMk5jdGp3NkJsRStILzZ5bzE5YW5oYWF5QzNEVTZw?=
 =?utf-8?B?c05pMEZ6V2pyM3RqYWd5eDFpU0R3MFhTLzNwbDM2T0ZyV21uR2hHOHBJV25V?=
 =?utf-8?B?TEt6OWErZzBwNis1bG9ZMmwvNmtpOW1SVTdjeHRVd2t5bzA3bWJMZGdkc0dT?=
 =?utf-8?B?cktRV0w0SDhuZmgyMms3L2FJRnB1UW5JZnY2bnBRc21TTWpBZUZlTytqY2dX?=
 =?utf-8?B?YzZhREJqOFFQdytlWXR6OEVmV0tDUTloZThXazRtL2h0M2xaVG5ScjRzTm1M?=
 =?utf-8?B?SnFlVXh4Sjl2dmlUZWg2R0dHcExjUG9BaXN6eUdYM2UxY09iN0lXa2o0aWlG?=
 =?utf-8?B?akxZaVNBajVjcXVZV1FKK0RKWWllRllyZHRIWDR2YVIyekRnSkZmdFUvR1pM?=
 =?utf-8?B?MGpRQU82SUlUUWF5YUNXdEtUQ0hmTEVKdmNKT04wdGNQM3BFZWhrd1JpK1lv?=
 =?utf-8?B?b3lHcTk2Wk9wZ0xqd1BkWXF1R1BhcWFvRXFueXl2a1MvSjhuNEdSUFVNblY4?=
 =?utf-8?B?S01uS3kwaEhYbEVvcU1vYkpsY2ZTZzNORGxIbitRcVBJeTJja3R5QzZ5blkw?=
 =?utf-8?B?R1JWTEtza0J5MGxRLzdtYmw5bXV0T2d0TXlyNGNCekRtS3JvUWlmSXBUdGRx?=
 =?utf-8?B?YnBSVkQvZ0lDTEV6MmVjRmZRQTM5cEhtRllCVk5maXFYdzdhZ1lkcFJqbFN4?=
 =?utf-8?B?OXBkbzlRaHU1OS9QYWN0dlhpMllsMWlvVU91YmU5aVRvKzI1UzVJTmdpZ1VN?=
 =?utf-8?B?QzhsMjVMOEFrTWhjVVMwS1NQNCtQTXMvTGYxY2RudllVcmo3c3RuSFJzTVRr?=
 =?utf-8?B?a2lpNTVLam12aGRzYTF1NGl3b1g3QUkzSkhhOGZlUDBaTHZra0xCTk55Z0k1?=
 =?utf-8?B?bkpMRWsxYzZjaUR1N2VGcXVqRlR0WGN1MjFjVjRhRU1XSkpNd3RFRmsxMm5z?=
 =?utf-8?B?WEgxNGNPYUd4SkI4UG85bHVnN0ZkZ1F1QmxUeWc1T0g3NVlYLzJBWnRiU1Qv?=
 =?utf-8?B?K1JPRk54d21xZDlESlRXMmdjb0xWdHd4YUpuK0d6NFZodWlhNVZpZnFhWTR4?=
 =?utf-8?B?aExRNnNGbVdwS2wydElNaTYydHRDcktFMFdjKzlTcWxRTjlLZ3FJM0JSNVdo?=
 =?utf-8?B?TXBDSkcvc2I0ZDJ1a2ZZK01meFZkTXZwcVMxREFuK0lTbHB5VlJVb1ZoYmZO?=
 =?utf-8?B?L25BWWpKM0NkeGtReDlrSDc3clppbFZ6TlBNK0FzVXk4NEpSM2Q1cHFrVVZn?=
 =?utf-8?B?WFNQZHZVSVBqaDRzTXdjb3loSFlFVEtPejZTWG8wTUxwanJ5UUpCWld4ODc0?=
 =?utf-8?B?QVpnVkVIZ3dYbnVPSHY1bWxkbnh3RkozYkUweHphc2sxUEtnL1hIbDBDdXlR?=
 =?utf-8?B?em1DTUxGUnUzclBKZGFUc2hKVERVby8yc2Z5WmNGdVFJdlovdGc0bGU1aTVx?=
 =?utf-8?B?V0dPQnFsMmJxUVRzOUxpbjArWGxqL3VxcWRSV241d2NKMVoxODZYNE9mbkU2?=
 =?utf-8?B?Q1FKRGJjTjU3bS8wUCtEV2c3b29EZ3lpTjRQdzlUWlVUSHIvNCtqK0owRTJQ?=
 =?utf-8?B?MjNldE1TNU95YWFvTU40WlhVK3pUT1R5R3NhRktOVzBBNytocWFtZWozY3lu?=
 =?utf-8?B?Slk2bGhRVXNCRG1HMldHVEpqOVBMUkJOcS9rWTJtNXY4bi9SWTBsTDBWVlJi?=
 =?utf-8?B?ais4WDZJRk14YkZONE5kM1ZVZjJmcVdxZnpaZ3FQanR1Z1hWaHBFT2pyTzQx?=
 =?utf-8?B?TWYzVTRxbDdrU1ljcmc0TXJQc1NVREFSSWhCR2dOSnlZSTZWNXllQmlVSnN5?=
 =?utf-8?B?dldETGJkb1FhK3RFcEdNR05VaWNETGFQemIrMVRZWXNkdFZqY1IzYU9nRnlm?=
 =?utf-8?B?R1FlWlVxVFNQRHU0dEVDYytaZ1dHNnRYODY1SVVMc0FiSG5VcGZqU3FCcjdY?=
 =?utf-8?B?ZWNGUGZGaHcvZHY0ZmFrd25keWpaYWU0KzgzamVjQlVISGE5WE9TQU1VbExP?=
 =?utf-8?B?L2pVRG9XWENNTjFNVGpDZldORVd1MVRCZytJNldtN2pJek9YZG01anVYdU1j?=
 =?utf-8?Q?MR5Wcj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:20.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cdf36a-c326-4660-e053-08ddfa1c4ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting HPA (Host Physical Address) to use from a
> CXL root decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

