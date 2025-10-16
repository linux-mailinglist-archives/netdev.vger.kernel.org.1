Return-Path: <netdev+bounces-230136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F14BE44C8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8461C4EFA3E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1234AB10;
	Thu, 16 Oct 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TjnkIM6b"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15705259CAF;
	Thu, 16 Oct 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629262; cv=fail; b=TvLtIm2eMO3ziHkYXPJk3tLDvONoo3RNicZIF+/vM+eX8y+VBzUE3bvMunO2tUHhR+Icsa6Uqtnn3UvHJmxtbjJER48l30pQ2Vmo0YneysqNkyHPdnKoQkfonzKG3LDFlYir4vjbxq2HOubZ/ktz5n5Ag/oGNDwYYJkx41l9CIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629262; c=relaxed/simple;
	bh=huK8BF65JqHy9UM+Fo+TVRbSEW2+juatN1h+V/NcNwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgCa6HiLlTFoLL2SFO7IcZlFhEcflO1voWFR/7UDnR+7q2pACpbswAL2aODDaQOe2XUyWNSEkOW9n4JHt/fARRZB+NQXzbwMEJXAJFP99uPlgS7hikt1gNnIfAeUh4+HOWMAESCbgAH40iYjZaSE1NDKmvhxs6Kn0uoZ1so9E1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TjnkIM6b; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx9XrKAu6fd5ZS1v7y2PQjlWJzK2frSNomVqonoR+N+ecNA56xEj+HEfaFztWwTimJ9fHk0LPTDS37+/OahvTrbF7R7BpQMh9Koj//Id+b6yyPUDWWq6pFUM28zVBEpnVMAwtrn22RjaigE0BhZ/2+PKrtruWPakXT1vWtA+dtyWPcNNp4r5jdXcHzEDR86ry5IaDEiHJH0QYBEdOoVyphqgXxTtmoIMpNj5bLMkyyotIJ6HsS5VLDs+roGC9QEO+hMoePQkZhkOfIB5L/2G+2cBAWD/Y5L6qJVYBu83bLwJ5xFICIqvSO88YIWQ03cPlTf3OnWgJk9UotV++jEDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlwHwHy7ylsRR4ifdhQ79wcLj3BNmChu9MRHJOMBWDk=;
 b=ygqa/C4OcGJ3Sk9rJomIqMhrDzSv3QQuA6CgDpVZcEIPyrJO1SgkxtCxCUHls99rwY6p0RF1EdT9I1V6ZBl94kcQWgnt52Y0yTZz6mswKoXXtDEW2T8Tyv7HTC7H2aaXKY6SE/JiHOcbpIuD051aEN/gcFYjpP6Q/6mrJsr9dRSWn+28ElS3deZTeW4Jtpu2LAo65zDzgtwKM4d8YdMi5fmfzmawlDdbjBjfV5iSsBJUroMXtYnbvenvWuQoUKGZgFG03jUBcInUM+p8tDoW9ihfL1gS3AtMJs8kxy//tVLVglrYZC3dLIFDRtsNH68lrx88s0Z/BvvsDbYJ4x4qTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlwHwHy7ylsRR4ifdhQ79wcLj3BNmChu9MRHJOMBWDk=;
 b=TjnkIM6bW48HMnziEdjx6rjq1bIjVHXhLW72lCxFLY97nXevvrajLaoJH9m4LKFtWr02k7vT3JtlWLdyLwbYZS9jjZAtH71w/6jpR0ZOJV8LoXYTSyDPvO1+yTO1IrXGfcW+cVLta9IIBWniCtnggmuE/rTBsx0G3E4dMbDiiTbMhZIInh490tqHyj/Il/nC2NjjX/ExzKzfDG1vbsKPh0EKSGdOwLZgeU8ir0QKMgBKFDr8N0Yu3xZxgi8uHzPj38b1SBqT1of1MgeH8ptbq4ZQRb3CyOnR642O42eaInh/0nXApLvIKyCX0x0zjkoihmpD6B6RrfCdHn/fKrWGTA==
Received: from CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38) by
 SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 15:40:57 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::2a) by CH2PR05CA0025.outlook.office365.com
 (2603:10b6:610::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.4 via Frontend Transport; Thu,
 16 Oct 2025 15:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 15:40:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 16 Oct
 2025 08:40:36 -0700
Received: from [10.242.158.240] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 08:40:33 -0700
Message-ID: <19e13479-861a-479c-8f5e-b9db229bfe38@nvidia.com>
Date: Thu, 16 Oct 2025 18:39:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
To: Breno Leitao <leitao@debian.org>
CC: <saeedm@nvidia.com>, <itayavr@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dcostantino@meta.com>, <kuba@kernel.org>
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
 <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
 <uhlgxrlphs6cufrbm7mkp3nmtkrvhtoxbgd6rt7uojogfrbdoc@4mgzpab3dv3a>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <uhlgxrlphs6cufrbm7mkp3nmtkrvhtoxbgd6rt7uojogfrbdoc@4mgzpab3dv3a>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e69ca4-c2c5-4941-0f20-08de0cca661d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1laWFN5OExyMWIrRWd5NGhNYTVabnB0akhwVUc4SGhRT3hKK3VYVGhXUnp3?=
 =?utf-8?B?WkN4ZDA3VHZuaE8vMDdGMVRsYTl2SDFHelpjbnJqaEtCWEdZS2d0cURNZnpK?=
 =?utf-8?B?RW5zV0pocTVKNGszMGc3Q0lxMXlIU2VGMTFITU94dldtdlp5RVBzZ3RHandk?=
 =?utf-8?B?eDh5UEdhbjRKMGlZa0hwL0lncnhzRDYzY3VZdE5oRHYzbjB4NGdTRVYxYmRY?=
 =?utf-8?B?L3VVM0IwZjFHSFg3M0JpOFJrNFI2SzlpL2pJd0lGOHF0Q0NKckRCY3pqS1pK?=
 =?utf-8?B?a05GSkdiKzIxQUtuL0N5ZFMxdzFxQ1lyZmVGTmlROXliVDgwWUtXVnBERk03?=
 =?utf-8?B?eXNIRUJlUkczOGJGeGhSYWNxa3p4YVdPdXMxNmEvMkx1MmdPVFJLbXhMZCt3?=
 =?utf-8?B?MTRjaEhmNi9ySHl6WG5zTzZsS2VHZFc1NjlBaVUvQ3VUdEFsUnZ6WlgrOXN4?=
 =?utf-8?B?d0ZpWFUrWFBUVVRQbGJ0TjQ1NE10S2NIVTV4cjhZZ0NnTjVLd1lGQ2NlMkVJ?=
 =?utf-8?B?SlVLK3JRNjJIMzQwZSswaVJkaWFBR1pscEh3N2lleTBSVmdDcDBkQ3NpR2d2?=
 =?utf-8?B?TFZPVnF4UjNNQUpmRzVzMCtwWlNhd0dGZHh1c21hMUVUTm05cnV4VkM1RjNu?=
 =?utf-8?B?U3NTWklXWGVJR1V3dng4VCtoNlJuSjRzV1BoS0EwVEZlKzJZTVgwc0FITDJr?=
 =?utf-8?B?eWx1c3lySEdicVJDTXkyWUtTeng3U2x4a1ptSU8zdzg1bi9KQlQyRXNZcHl3?=
 =?utf-8?B?OEMxNEVzR3FKZUhKTTVsVGhiTDRhWGI2aGlWbEYvVmZhbm9aLzI4VFlWNmc4?=
 =?utf-8?B?WlU5bnFWTW5GTlNCZC9rWjNwWmdlM3I5bVZWUDFuSDY5TzIzNkdxZnJ2Y0U5?=
 =?utf-8?B?eCtMdlk1eFJBMnBWaHNYU3crRk4xcUQ4TEZmLzZnd2N4R2c0YlNLWlJHcnVI?=
 =?utf-8?B?cXZxelZZQytPQlR6cSs1SkdMWnJCZUVqSXFKQy9WN213NHBSVERlaUJSZUM4?=
 =?utf-8?B?NGhlbDFURFEwbnBHTnh5M1ZyaW0zQ0FaMTM1eVlSNm5DWUZyNTBzOFpNU2pZ?=
 =?utf-8?B?bmRNNEsvRmE5QXBHVmZLb21BOEJzelpKYVA4VEdBNjI5MFU5clBxZGtzVTdl?=
 =?utf-8?B?K1NuVGdYeHE3cE42ZmpGWkxSME9zaTB4eGFJV0wrb29zSTMza3BEWnYrQXM2?=
 =?utf-8?B?Tjk3bFJkOTBHVzdMbC9Oems5ekpQQ0RZNGgyN2d3VWVwc2tBMHJEbFUreDRl?=
 =?utf-8?B?UzNhTUM4NlpRUHFSMHgrMktXQU0vMU9BRzB1VFdaZlV1ZUtRMDYvcjNIRHJK?=
 =?utf-8?B?bG9GT0FRcDA0YjZNaXY4clpJMzJwWFl6UExmRm5yYUMyYk5GcnlVTmI0bnFM?=
 =?utf-8?B?MU05VkFHYTdYWVYvKzhYekVYdmtyYml2VFByVFlrTzMrZUt3b3lrbjA4dFFZ?=
 =?utf-8?B?ZjFBWW9IQ3B3VEJ6aThNNnZmVW9uUnhIZzErOUpoSG4xaVR1dC9PdjMyTGcv?=
 =?utf-8?B?Z01XNDFXQ3NoRXdVaDBZMzIybVgwUWRjcHd5N0JZeGF2bjFJd0ZrRytpb05S?=
 =?utf-8?B?RitJUERsNXBnMDB5YWFzMUsrcGM3SlBDbHI1VFo5cFpJT21rZ0Ryc1hwOUVx?=
 =?utf-8?B?R2lpbkNJalNFcHc0ek1RdDVybXJWNFF1UzgvRTZZMHQzOXNyQWNWZzBqcmk3?=
 =?utf-8?B?NVFOR2FzNThUM1lsSGhqS0Njck4wZHhrdzV5eVlQZHg1MmVBZ2hqV1Zvamx3?=
 =?utf-8?B?SUdJWmwzSGd4cVRJWkRrZHVOaEw1UEE5TUJLL2p2Qjg1RlcvT2VNVkVDLzhu?=
 =?utf-8?B?UUIzNmhCYUtxeWRQOEdtVVViL2NmWG9lbXF3MmN5YkZpWHVGeUhOUS8wdmNo?=
 =?utf-8?B?SEkvRUlORnFrOUZtL0l4U3JxdFEwMHhKcEQzWC8zb0NtTktYTEl0WU84SEFB?=
 =?utf-8?B?UG1MeGlyQWxwQVRsMGhmRzl5bjZtanJxUGltdGpTNGN2NTVXK2FwTFJHVVFW?=
 =?utf-8?B?RXVTVDh2NDc0YXYvV0orYURrREpRc3JTQkE4TmNFNUI4MmhZVkRxRGdQQitL?=
 =?utf-8?B?TS9wajh4clRVNzNjbVk3TTU4NFRqNWNkUVpyT1ZLZ1dxMml0MTEyamk3WTJD?=
 =?utf-8?Q?qH+c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:40:56.7646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e69ca4-c2c5-4941-0f20-08de0cca661d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B



On 10/15/2025 3:26 PM, Breno Leitao wrote:
> 
> Hello Moshe,
> 
> On Wed, Oct 15, 2025 at 12:13:29PM +0300, Moshe Shemesh wrote:
>> On 10/9/2025 3:42 PM, Breno Leitao wrote:
>>>
>>> My understanding that we are printf %s with params[0], which is 557514328 (aka
>>> 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
>>> is invalid, and crash.
>>>
>>> Is this a known issue?
>>
>> Not a known issue, not expected, thanks for reporting.
>> We will send patch to protect from such crash.
> 
> Thanks. how do you plan to protect it? I understand that the string is
> coming from the firmware and the kernel is just using it in snprintf. Is
> it right?

Yes, but FW should not use %s. Driver can check it.
> 
>> Please send FW version it was detected on.
> 
> `ethtool -i` outputs:
>          firmware-version: 28.44.2506 (FB_0000000030)

Thanks.
> 
> Thanks for your answer,
> --breno


