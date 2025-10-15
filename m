Return-Path: <netdev+bounces-229531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC1BDDBA8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088AF3BAE08
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3A231A81B;
	Wed, 15 Oct 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lg+xprXE"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AD3148BB;
	Wed, 15 Oct 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519695; cv=fail; b=BX0jodMmbtmcyPEwN3u/p48k31K4mM5yMZGFT0z7BMBrVPpDyA41m1yDbI/QGnnB+w/YvZZA4pY9vj1ZA/etZgR2bWD/F70re9Uq5ofegqEYwjYTjPAnfSLZFOHFF5DXl4VuPwLx2xVtJZU7gmujtj1jXH8Y85FDdcWkv3zdw+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519695; c=relaxed/simple;
	bh=UaQqIhwQBNW9rvan1o0ENanQprOfceUBQ98hij2udu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e1Me2fFSOxt2C8omLgOWR2hZBeWwxUzwf78Hbt10UA7N09wJ6+55+zyiMpeWGlNrKYYmv7zKQYgK/ZvfRaS+jHEPjeBDvIkNH6Zx1U6syNEvg7kZ+cZVvahbsFYuuSaiukNAcSewnwEdmVFpc4nOSh1wWM2Av4XkdzBoXsd1Zj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lg+xprXE; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+poN+mX8I5dVRRj3JhdKt9RKsenqTCZAsSdyH9sszYMIT3zBlTTUUiGJnDiM8cRPlah3NmKT0/LA8qN8lRaU68OC6mwOwgJ3QadcvxcHP8I5+K+HX6g5rIx2cmgJHwYKE1TqB/bNJ8EgbkXw+F8T92frYR6HjQAqNFgYO+Ltr3UyWvSL7dqnZS8oqNFpCgwk1/nhXopRyQ3w86J5CYWdyz7DJ8kEkDASrVVZpYvHYZ0HgMw1ieNbEnU/FZFaJJhU0QCIg1B6AMGtsZuN1qIaza3nEBcnGTZukcWH/62ui++WAcrdUraQoMMjB/utcwH6p1mhbjm3VP6/VT12jrIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK0SyvhVT9O6qvXrd94iSMbQgFKGbMtBQ2ztceMxvcI=;
 b=B+ncuS8LI3zKHr4bUGvqEc0kyyr81YjM/p6IKO+ZtezaZARp4prxYk2sht6kCzBKdbEgD+wgiODk3hhYrI9XpIyw7SBrepGwNI5VBhMCOPhUuBqn5FzdfcPjqYC+tkjg1ELAf9XGy1qQw4vDF0mI7BOoMxKVIIjwD33BiLxHYiTgmzLltc0F0a5/IYcQCp/Izd6dgZB86K2VGrPFCR9kzZg0Tu7D6ZaiqLB7w1+943e9bEi5uwitl8F06iMsBQsiNpGJjZjBL2K20iu7KPP6Y7cPnOkVV1JsSlKRNtG2emBgOPOfvyNOLbwYvNqfwzFFBsRWf00joCT5TzsXsNIVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK0SyvhVT9O6qvXrd94iSMbQgFKGbMtBQ2ztceMxvcI=;
 b=Lg+xprXEyQejF6a3DVxrZA1zpq0YricUwJq1hbdp+YZ9dMLDri1dmanVSnBwY0tXE+2UAZllrR1xLoUbLR3sUDIbnIxCCqZYJWcQIwHPJhQlqoXC7mKJpssQDhbmHuDCJmT9ySxEhOSvz2l/lOnoZ9mLTeRUYicktiztlwd0IYNkdrk2OijyolLzAFH0bV3po0vY/RwRQUnPzpSWMCI+4czmpivIjILNSBr2I1DkF93boDGKqLRFj+yFRheEWaiqC2m+8Ewccp/U8IEkxEcyyiAyPEnNc6YUAeGe91HUfXdvxNGYIpgke0bgZKmONUnj57HB83e1JzViEMkoAluo3A==
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:14:45 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::30) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Wed,
 15 Oct 2025 09:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 09:14:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 02:14:35 -0700
Received: from [10.221.201.210] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 02:14:32 -0700
Message-ID: <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Date: Wed, 15 Oct 2025 12:13:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
To: Breno Leitao <leitao@debian.org>, <saeedm@nvidia.com>,
	<itayavr@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dcostantino@meta.com>, <kuba@kernel.org>
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1a8443-e9ff-49e0-54ab-08de0bcb480b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2paWVZldXdwNFFjSWpHT294YlpNSGhyVUE5N1VSVkVObXRyWXp2QkttQmMy?=
 =?utf-8?B?TDFsaUtQMnhoRERqbEFhV0xQQVAvOWF0TWRSVUU2ZWlPS3h3dTZSdlh6Q1ZE?=
 =?utf-8?B?Qk5oMGlVN0I1RG5wZ2NtSGIyMHE5YVZlbWlLNHlQUXpXWUdRM2x0TndHdll6?=
 =?utf-8?B?S3NrQnhxL255cG5NWUpqYmQ4Ri9kcjZoMllmL3NVTHNnZ2JVUU43SWpUZm9a?=
 =?utf-8?B?UGNzZFAydFdOSVJmYk5CQnRqMDZESzltNU5QcHpRR1g1WE5HNUlIT3daeFhT?=
 =?utf-8?B?VlFsd094ZXBhbU5FWFhwWlcycytFS2U0NWU4c3JYN2VNWDY0NEtmWk10NGNw?=
 =?utf-8?B?MTR5WHBhdG1wVE8wRmk1cjlOeVBWNDZpN3IyWXFGRE43WlRydmhLcHdBMk1U?=
 =?utf-8?B?L3FRdW5JN1AwdUUxMGhZUFFqai90WitIMGY5aUNaRmtPZXRzSUx5Yk9Mblhz?=
 =?utf-8?B?bXJCQndqalByenpTK01lTlppUGtGeC9TSUl3WVVWWDl1c2hpTTFuZStFd2lU?=
 =?utf-8?B?dlBKcjkzNW4rRDc0bXBYYzN3b2ROcnk1MHI1dlZvK1VPUXoxTUJQc3hacDd0?=
 =?utf-8?B?cmtmaGtHc2FoaGhxb0Z1RGNCTURpUWlBbHg3akV5Ni9QK3Z3K0JYTWh4WGJr?=
 =?utf-8?B?N2psRzhvaFlTd3NtOTl6TUZ1dVZJZmJVQkhTc1VFWUpVK3NFQ3p3WTM0RFh6?=
 =?utf-8?B?K21BL1VqYTJMQVM4NTBtbTFHQkxlcExydTY4TUpQY0pzMEVKRTF1ekM3SE9a?=
 =?utf-8?B?bHJWaFpJUUp1c25TUFBROGwrM1MxT3dtcTlVMFl4UHVrd0M0Z1N2MVVMNzY2?=
 =?utf-8?B?U01LN216dk84K215RVU2cVY4WGd0elpMT0wrUUc5VkdKaXBrMld4YmkvbzdE?=
 =?utf-8?B?c3EvV1VTK1pza29WR21rcTUzZEF4RHFIRDBscU9GcDYybFp6YXUrbnB3cEpw?=
 =?utf-8?B?R1R1azI1aWZHU3BiQm9XMnU1My9OYldUL29LQXdyWVhEc0IvakhzUldiaGcy?=
 =?utf-8?B?b2VJY1FJV3QzL0g3R3dDY2RpbjNvVDVXODNBcFh4akdxV21HVFN3QkdlRXpD?=
 =?utf-8?B?bmFZUTdzS3FZVmVOUW9TY3kyRGllMFBrMU81NFJoVDYxUktUVDRVU1haQ1Q0?=
 =?utf-8?B?Z0RCbUtVSGthOFJIL0UxSXFrZis1ck0rbFJWNmcrdjVoZkhRVXBQTk9FSmE3?=
 =?utf-8?B?Qzdxa3dqb3NGRDhQL2FpU05qeERkdWJVek5EalhFQ1hIRlcrUHRjNUgwUWRk?=
 =?utf-8?B?cTEyN0lmRmlQNzdWOEdTMGRQODdWd2ZaejB2bDdNQk9DTXNiSVVUUi8rTVg3?=
 =?utf-8?B?Rk9vajRxaVR1cWpaUXFUMXpDQStuWWxQRlZlMmtGVU1BWjRzZTRSdytyRFIw?=
 =?utf-8?B?RFkydTlxbWt5UjdoVkxGOU9iRDVQU2xCb2IxY2JqcmNsdTczcGJQK0ZIVjhn?=
 =?utf-8?B?NytaM08wVitScHh4VmFKOGowNFZTTEdjVExhRUNTV1NvNXVBN3ZNK3NtTWk1?=
 =?utf-8?B?R0xvMjhGNW5NRWJYODRWeGl2ZkpjZjNwQUtTbzJHa0tJWjVYQ3lIK25zS3pV?=
 =?utf-8?B?QVNLYWhnakx0cTYwVTk0OU9sTnZjcjZsQWVIV0JoM3NQci9qcVpFNnRlVGZF?=
 =?utf-8?B?M3lxNTZwclk1cVFEU2pqUTc3VjNlWkUxdVlpNjFjblZSWGcvams0T3dvV1dn?=
 =?utf-8?B?WnRqSkxiNFZKemdBMlRoV01CZXBwdGdSMU5GaHcwdUtOZE4rRTJ0QURrZDY0?=
 =?utf-8?B?OC9peVlJVy9XT0trV012eUZiWmJKTmhBNHV1cXhNZnpjb3M0NExwRk9uZ2Rj?=
 =?utf-8?B?R1NhUUYxWnF0TXBWL3BCRXRodVlUSGE4QTNSMWJOa29vR1Fibjg4OU5YVys0?=
 =?utf-8?B?YzFmTXhnRVNPZXJNa3ovdFJiT0ZFd2YvM0JiYWxrMGhWZDl6enB1MC9tamNC?=
 =?utf-8?B?bUJ4cGtoek4xY3dVSjBzZnkrMTdsSE1Nelpidjk1MDJaakxYcy95eVN1aUhH?=
 =?utf-8?B?d2lldnRVWFRXekJkTm5zU1h6RGM1MUtvSGE0Q29CK3RQLy9yY2psUEJXYkF0?=
 =?utf-8?B?ZU92ZFM2UnV3OWNsUzVLb3ZsSks3VzkyTnhEOHUrbXJZL3dWVHRyYTBlM1ow?=
 =?utf-8?Q?OGvw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:14:44.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1a8443-e9ff-49e0-54ab-08de0bcb480b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034



On 10/9/2025 3:42 PM, Breno Leitao wrote:
> Hello,
> 
> I am seeing a crash in some production host in function
> mlx5_tracer_print_trace() that sprintf a string (%s) pointing to value
> that doesn't seem to be addressable. I am seeing this on 6.13, but,
> looking at the upstream code, the function is the same.
> 
> Unfortunately I am not able to reproduce this on upstream kernel easily.
> Host is running ConnectX-7.
> 
> Here is the quick stack of the problem:
> 
> 	Unable to handle kernel paging request at virtual address 00000000213afe58
> 
> 	#0  string_nocheck(buf=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe59, len=0) (lib/vsprintf.c:646:12)
> 	#1  string(end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe58) (lib/vsprintf.c:728:9)
> 	#2  vsnprintf(buf=0xffff8002a11af8e0[vmap stack: 1315725 (kworker/u576:1) +0xf8e0], fmt=0xffff10006cd4950a, end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], str=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], old_fmt=0xffff10006cd49508) (lib/vsprintf.c:2848:10)
> 	#3  snprintf (lib/vsprintf.c:2983:6)
> 
> Looking further, I found this code:
> 
>          snprintf(tmp, sizeof(tmp), str_frmt->string,
>                   str_frmt->params[0],
>                   str_frmt->params[1],
>                   str_frmt->params[2],
>                   str_frmt->params[3],
>                   str_frmt->params[4],
>                   str_frmt->params[5],
>                   str_frmt->params[6]);
> 
> 
> and the str_frmt has the following content:
> 
> 	*(struct tracer_string_format *)0xffff100026547260 = {
> 	.string = (char *)0xffff10006cd494df = "PCA 9655E init, failed to verify command %s, failed %d",
> 	.params = (int [7]){ 557514328, 3 },
> 	.num_of_params = (int)2,
> 	.last_param_num = (int)2,
> 	.event_id = (u8)3,
> 	.tmsn = (u32)5201,
> 	.hlist = (struct hlist_node){
> 		.next = (struct hlist_node *)0xffff0009f63ce078,
> 		.pprev = (struct hlist_node **)0xffff0004123ec8d8,
> 	},
> 	.list = (struct list_head){
> 		.next = (struct list_head *)0xdead000000000100,
> 		.prev = (struct list_head *)0xdead000000000122,
> 	},
> 	.timestamp = (u32)22,
> 	.lost = (bool)0,
> 	}
> 
> 
> My understanding that we are printf %s with params[0], which is 557514328 (aka
> 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
> is invalid, and crash.
> 
> Is this a known issue?
> 

Not a known issue, not expected, thanks for reporting.
We will send patch to protect from such crash.
Please send FW version it was detected on.

Thanks,
Moshe.

> Thanks
> --breno
> 


