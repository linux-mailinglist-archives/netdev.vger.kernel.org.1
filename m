Return-Path: <netdev+bounces-235459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6544C30E7A
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D634D8DB
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F452ED87F;
	Tue,  4 Nov 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CR54QPO5"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A62ECE9E;
	Tue,  4 Nov 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258274; cv=fail; b=QCtuvTks6UL4NlaTIU6pKegDoCKNlPCMlQe4knBkzOspNjDVTwLtPMe7s1srxv8YoEtjdkjR6EsgbLOBRp8CDlbCGpuoOX3En0+UbbOh4G6SH/CHJqdaF0bOtG+KJcvQ8z+OQ4tjEQjXwW5YkJlg4uRlPJtWnbChVC88kiDbPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258274; c=relaxed/simple;
	bh=qPTBJzYTf+LtfVwZL4KcV5T2DgWmmGlcnY74pSXTh1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pqr/pXeu0sc/1WSXNUs64lpBu8AMyfEArjPZWKAQTGIaYpDNuS6V7otagZRbGKxzVT9jPZbnExj/lU9IqJCLxSQ6KGHYRmO5VweNl2sLSnu+6jr43vcsmgP9hH0kG//Dl1TuH60EFSeEpcGSYwdWipRljBFdE2ZxyB0pT2GdUHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CR54QPO5; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZusja4L6saxKxVwMjjoXVoT63EDGf3MANuKVeg6Z16ER5DAhqcbrpO/k7fUHHYDhNVQr7i3zrMct1YYMutUaS29qCF9wod3yBR/Hb6nIf4EdKIPnJfoQfWc+4p/4p77UNIsKLH+5Izjnsh7p4eeQWigboCUqYlHMELFr1A4xjDJW4VWWxH5RM4Py86V0iEqaMVf51Dc8KQzfNzOjZATEUzGrhbORUs/p3drnx0ATbz4laDPdtG71vO3/PWhy7kR3wt67TywYN+VkLERM4/N4OW3BMq3H4yAICDBHTCML0WTe0edVD/vSQQxVC4ChyASahfubqCEJC7ayShJufcHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUAWZOK4gDrgGwcOjflfX7agprCcrcbIjxXDlzqbEIk=;
 b=DUYTuMcci954hujCXoHmVCdvpYqsR5mO4zzNuqLRLBK2eT891x71TPeUiN/r0IJEDn38nMh51NH4lP6i7+IK25YFAG3Aq31bQm1e9HixomnyeO8zUD24B6QVtHNDaduNLuwRRhToNRO5RAjIFIJhVz3O7LhjQUtCNwBMKE5MLIlfmNMXAWIIgmxq/4Ry+5wh9hkd8EnyFstyHKlar6TTdxBo5JMBYy3dLE0rrvPRahARadfjP3/TgK+IiV5cDP+RWw5C9g9VRUUxPLG0RydKzzXcn+g8WeC3uxrliL7sMXpUJRSb8RNOnvxVti2LhPBHvHDvTI7TbdkHCMuLDiukpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUAWZOK4gDrgGwcOjflfX7agprCcrcbIjxXDlzqbEIk=;
 b=CR54QPO5FzcHhQ2KIC2z7KQMGuRoL7hVYWaVRM6qSwfj2aiVTrzDa9DA9qNplzLUT8P5k4kaqCsULjsyuetjZ5Pf4V8XoDmnNGMUlVC4fgATXWt9n4hB2TqLE95xvQMaSB1pPZ76ICUnyL8115PJ5FjCBeN9/ulGGl20uvhJEuK7q6WltO5rLueYs5VtwrEUF1DvhlqJxuepBnInn6SgEwrziAoMfISg1eU291Oz1sS53JK9YkdJbOh1LtB2rrZrGLyJ5EmHHs8hYY5I3DWQrZSZRjMDvCU/62XAscgwTXyOz3OJJpIxlT1Ks8iGYpjcY431cqeZsi5aCbKHqRHTgA==
Received: from CH0PR03CA0323.namprd03.prod.outlook.com (2603:10b6:610:118::6)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 12:11:10 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::c0) by CH0PR03CA0323.outlook.office365.com
 (2603:10b6:610:118::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 12:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 12:11:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 04:10:58 -0800
Received: from [10.242.158.240] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 04:10:55 -0800
Message-ID: <f04438b5-2f62-498b-91f4-07085f46d6b9@nvidia.com>
Date: Tue, 4 Nov 2025 14:09:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
To: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>,
	<saeedm@nvidia.com>, <itayavr@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dcostantino@meta.com>, <kuba@kernel.org>
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
 <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
 <0c2cc197-f540-4842-a807-3f11d2ae632a@gmail.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <0c2cc197-f540-4842-a807-3f11d2ae632a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 495778df-2aa4-4a4d-aba5-08de1b9b3db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG15Z1pndFhWZDV3UzBUSFdEZjYvRHgxcmJKVjh6Wm9kRkpVTW5DcGc5cTdX?=
 =?utf-8?B?MWJUbHZPZGxITVlabzZiaGllbG1EeWs5bDVzRy8rZU4wOWsxcGRaeFIwMGZI?=
 =?utf-8?B?V1pmV3g1NE1VK1dGVFd4UTRaNzErbWcrYXd4cWEwYlFBcFRiVFBFYnl2Sjcr?=
 =?utf-8?B?TnhueEtFbmxPTWZZT3JObGgvcXFBVHY2K2hleDArRmg0NlVzdk1DenhVWDhD?=
 =?utf-8?B?NGxDSGRYdE04V2tRbzZ3Nm0ramdPSGNVczkvWmZFdFpxR1IxckNndmtUdE1O?=
 =?utf-8?B?WWhaMmpxeDdoZll3N2pOaUxsWmk4M05aQ2RqayswK0ZvKzFzN0RLTlNIV3NI?=
 =?utf-8?B?cjdsVS9ndFNzTnBFTE44dS9xWDJlUW9JTm9qTnVleXN6Z05rTVlxUGh5Smw4?=
 =?utf-8?B?SVBuSlZqS2dHY2xONUdBaTZEcEV6dWx6V0ttYXVKVGdRRi8vc2piRTZPaGVM?=
 =?utf-8?B?Si9MTFdPUEZKMWlyOUloSjRUVWl0NGs2WDliOTVvVkZNbDhhaU5WNGZxdTBw?=
 =?utf-8?B?VmJvODF5c044MHp2YWxaK0lHN3Vqa1pTWUpZWnI3RHpOcjRyNFZiWDFyaTBa?=
 =?utf-8?B?dG1jaFhzQU5KdGpGTWRkc013VmRCWjgzbHZUWDUxLy8zcldkU1gwRkUwVExW?=
 =?utf-8?B?UDlmUmxUcGh1dm1lci9ta3hiUzIzd2I2RFBkSUUxS2Z6RWRXMjRzS0pRTVZO?=
 =?utf-8?B?WE9lMHA4MDFjbG8vcFNlWFhqRi9MYjh0YWdPa3JSdi9hWnh0L0IwN0Z5NFlO?=
 =?utf-8?B?OEdNTnBLa3gzVjNpbVdPWDgvK2V1T3VIV2tnMzQ1T2NXSTU3b2QrK1QyQ25v?=
 =?utf-8?B?RlNUK3F5QmtxL29oc1FNWnUvVU42Q0czTHJDN2FpTVpQaWhyTC80S0xSL1Jr?=
 =?utf-8?B?cTRFYVRwaVZNNi9oNVJMMWtvbHdUZUJOZENrVEx1QUlBRlFLSVNiZnI1c1R4?=
 =?utf-8?B?VjY2NjZHZlljZy9IUmhYM3g5dCtvVG1aNlN3eG5aNjY5TGFDZUNIKytxbnBV?=
 =?utf-8?B?T0NUckpqMDE4c0RESEw1Y3ZDbFU1KzFvdHR2aHI1QXBQY042SUxTOHlocnQ1?=
 =?utf-8?B?U1puQ0lEd3cxQVB1N3RsdzlCek9xVEw0WlFqbzJMeDVzR1JrUjlmdGkzQ1RV?=
 =?utf-8?B?MVUwaFI4ay9TL0dCaE5NeHJRZ1d5VjNzWG1Hek9WdkhFR0xudXRqSTd0UUVv?=
 =?utf-8?B?RExwZFlMdUxIRFQ5SDBHWVZiUUlIWUg2eDI4YlBsSXhPeWYvbFBWU3lGNjBZ?=
 =?utf-8?B?Z2ZmeFNic0FDR2xzMm9ueGp3dWppOWx3SktRMkEzdjNaS1IwcWV6SHJXUm1t?=
 =?utf-8?B?WXg0N3YwRFBlRzA5TVR4UVliY0xVUEZXNWE4Q1V5c0tjUm92YjVXWFR0RjRR?=
 =?utf-8?B?RDFqSVNnNlpTbDZmeHBPRGNPcDIveXUzTktidU5sdDFDekVKNFN5ck9sSCtu?=
 =?utf-8?B?OVlOblJlWHBwUG12NDZlQVVxdkVYaFNwelhkRFJmdUJ3MURqRWpGYmVtaDZG?=
 =?utf-8?B?cHI3NERmSEE4UnJtOUtNUDZkVmdkT1NRTmZyMWtMbnpBY0tFQ1ZyN0x1d2FI?=
 =?utf-8?B?Tll3eEdzRmNCZHQ5ZXJtMGoreWJ3b3hGdEFQTUpzL2xWWVlodGphYTdkOFIv?=
 =?utf-8?B?TzQvQUR4eG5EQVp2ejBFZHAvL1J4cVZPS3RxVjYrQk9QUksybVdZeUFTR0xp?=
 =?utf-8?B?Z2tIejNDT1hTNDFGS2xKOVlXaEoyVzNUMS9qTDlZQTJRRnRiRG05dzJxZmsx?=
 =?utf-8?B?UE9Jejl5WWQrRFpVK2JLZ04xdUw3aldRVGFUd1FRNml6dFgxMnJmZ1VING1x?=
 =?utf-8?B?MXBUUVRmYVZpRmlLWWpod3FvbGJQcTdJNG1ya21YUll5OVVGNmpWNVUyajB2?=
 =?utf-8?B?NldITk0yaTQrK3pPZWU5SEkvUjdSYkpwYVUyaVBZL0JmUVl2ZkxIQTc4aERB?=
 =?utf-8?B?QzJWTnVjbDJER3I1Lzh2S2RFdEVaUnFCSUliVVNzZkRIc0hxVDlkUDV2bFcv?=
 =?utf-8?B?bTJZM1d6VDk0S3I4VDdjaU1xQTlLV0V5dVM1dDU3dmVHZ2VRTkh6bEJoWFhi?=
 =?utf-8?B?VXRxNnBvbEFBQTdHc2hHbmpXOGoyRlY0OXFwQ1NJWCtsWGxGUlVpcmZCNXU0?=
 =?utf-8?Q?TZHM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:11:10.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495778df-2aa4-4a4d-aba5-08de1b9b3db8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845



On 11/3/2025 12:45 PM, Usama Arif wrote:
> On 15/10/2025 12:13, Moshe Shemesh wrote:
>>
>>
>> On 10/9/2025 3:42 PM, Breno Leitao wrote:
>>> Hello,
>>>
>>> I am seeing a crash in some production host in function
>>> mlx5_tracer_print_trace() that sprintf a string (%s) pointing to value
>>> that doesn't seem to be addressable. I am seeing this on 6.13, but,
>>> looking at the upstream code, the function is the same.
>>>
>>> Unfortunately I am not able to reproduce this on upstream kernel easily.
>>> Host is running ConnectX-7.
>>>
>>> Here is the quick stack of the problem:
>>>
>>>      Unable to handle kernel paging request at virtual address 00000000213afe58
>>>
>>>      #0  string_nocheck(buf=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe59, len=0) (lib/vsprintf.c:646:12)
>>>      #1  string(end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe58) (lib/vsprintf.c:728:9)
>>>      #2  vsnprintf(buf=0xffff8002a11af8e0[vmap stack: 1315725 (kworker/u576:1) +0xf8e0], fmt=0xffff10006cd4950a, end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], str=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], old_fmt=0xffff10006cd49508) (lib/vsprintf.c:2848:10)
>>>      #3  snprintf (lib/vsprintf.c:2983:6)
>>>
>>> Looking further, I found this code:
>>>
>>>           snprintf(tmp, sizeof(tmp), str_frmt->string,
>>>                    str_frmt->params[0],
>>>                    str_frmt->params[1],
>>>                    str_frmt->params[2],
>>>                    str_frmt->params[3],
>>>                    str_frmt->params[4],
>>>                    str_frmt->params[5],
>>>                    str_frmt->params[6]);
>>>
>>>
>>> and the str_frmt has the following content:
>>>
>>>      *(struct tracer_string_format *)0xffff100026547260 = {
>>>      .string = (char *)0xffff10006cd494df = "PCA 9655E init, failed to verify command %s, failed %d",
>>>      .params = (int [7]){ 557514328, 3 },
>>>      .num_of_params = (int)2,
>>>      .last_param_num = (int)2,
>>>      .event_id = (u8)3,
>>>      .tmsn = (u32)5201,
>>>      .hlist = (struct hlist_node){
>>>          .next = (struct hlist_node *)0xffff0009f63ce078,
>>>          .pprev = (struct hlist_node **)0xffff0004123ec8d8,
>>>      },
>>>      .list = (struct list_head){
>>>          .next = (struct list_head *)0xdead000000000100,
>>>          .prev = (struct list_head *)0xdead000000000122,
>>>      },
>>>      .timestamp = (u32)22,
>>>      .lost = (bool)0,
>>>      }
>>>
>>>
>>> My understanding that we are printf %s with params[0], which is 557514328 (aka
>>> 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
>>> is invalid, and crash.
>>>
>>> Is this a known issue?
>>>
>>
>> Not a known issue, not expected, thanks for reporting.
>> We will send patch to protect from such crash.
>> Please send FW version it was detected on.
> 
> Hello!
> 
> I work with Breno and just following up on his behalf while he is away. Just wanted to check
> if there was an update on the patch?
> 

Hi, patch is currently in internal review.

Thanks,
Moshe.

> Thanks
> Usama
>>
>> Thanks,
>> Moshe.
>>
>>> Thanks
>>> --breno
>>>
>>
> 


