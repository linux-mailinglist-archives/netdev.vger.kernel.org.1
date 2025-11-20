Return-Path: <netdev+bounces-240219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD6C71ACC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDE1F4E2965
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7731DFE12;
	Thu, 20 Nov 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TP4/oL8x"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7D51DE8AE
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601646; cv=fail; b=QFJVgZOSbiGZezAjemot7tr6HEU1LnQqAKuqKxlMEmHhPnmPxt0PpE/4y0mQwZ+vMAkg1f8vGn9meK/E4YXx0EvllEGRQY2M/RkQeLTx7UP4GvHUBRXMsX0ilZnnmPrrljwIs8QzwA0H6RmO90kA73eY+s1nHqILZeaCPFw7BKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601646; c=relaxed/simple;
	bh=hxDlB7PWnTqhqfUeBB2ddpiFcgvlkhUjxjorCcdEFtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iEYWpms0WlW2RgSGs9brEwYalzR+ZbDDiq0ZQRVGErm3jxThQaTATbtyMc9ok6QoSKf8zDQ9lctnGuGTlEiw5/nO3oTl8HH5KE6uU2GOr60SVC9oob6BpjsFbyjiSiDylAXXf46xR7PKvma0/nyeOV8tip1XcWx++KISUvmtVJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TP4/oL8x; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to0mGmYtYzGR1vaj0vf9XJ319Xa/OvmiLKMQ8MRE8BQbV9LeChxCxTX3U/k7SS6OcfR3AhzO4Du0/RDDtmDMXBT36XUAdCTvbpnPXCPxTqpKShu0vU5FVJkcd8/mAVRJ0Wq1aPS0lvjT/8aUw13dPddqY/WJ53ft4o0IGwYiWswrxTbaS3AeITsWd/sQnl9tvt/oxVrJ8zp+VytXFhFFYnvkIKdHmjBbDeGWFxwcVnzavlaLuVHjr08nGdhWSh9SqmfcvVCFRjYT/659Z9O+qX+xLA7DgRl34WllG/wyFEXs2GbrxH+YLSZKIo4NSIDCCdaCcdm2XjEcbWG/lF5r5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM/yAORqji9YVvlH7o/4P5SszPEvWdbLC2xEHj3Xh84=;
 b=oDZM/RXAKwVGcl6Y5l/ZrhDhdU+BReoOiuv9xiV8I6CmdqXhZaUeNJTYrPcDsMXIocVKiKBXkglzr+bVC1r3/2p83YBp5cKO07jdd1ZNgQfyOjoKJCZFTWsEwUOU5dqGB4EemmOS6qx1QoX3W8uGjRjwQyV1mOb9pQ9qs5ktakF4G0UDTERRAfi4ua8NMNBeWdIvQmKMkG9PpVOQF1r+utwJuNzBC0mZtkfEgCcvlFTpEfwccrry6J9O9NF25SR0o6yNav05vuEenujhjeP4sb56f62M2H6tPcGCF9CsSNrYG998gEPOAfa/K3zuoL7sLn+xmGlx5dsu4++WMOpddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM/yAORqji9YVvlH7o/4P5SszPEvWdbLC2xEHj3Xh84=;
 b=TP4/oL8xfC6S0rTq5fgAwCFsmf3FVTkZbSLEW53D7akaH2b8PMCIDRFkBlFwZYMNUuxf4DI4FWt42XahZLAVZ6IwTBxCn6qMaDTXtk46K1NNpQFsIa18kZZj7fbdIZ+aMBrK7vSyVMY/aRrwg/aemG5PGJ7z0MV5ZUO9g21f4V/pS/kpeLmAsMRACZwbptSxTbumzL4mfOc0jCCG294UnZhGEJSPc+Z42rYdAhZ1GbqvvYj72AM5nV+6DP0NhZ+VjQwFEBr67RADOy1bZ7UP4KFnxtI753T/PnKDwLdVWjFlLaPJWB8ZluoKIlS405UohUxoEX/7KaaQEMS4ag5y3g==
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 01:20:37 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::4e) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 01:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 01:20:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 17:20:15 -0800
Received: from [172.29.249.233] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 17:20:12 -0800
Message-ID: <86801357-7262-40e5-b2bc-8429ac80ec7e@nvidia.com>
Date: Thu, 20 Nov 2025 09:20:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec] xfrm: Fix inner mode lookup in tunnel mode GSO
 segmentation
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>
References: <20251114035824.22293-1-jianbol@nvidia.com>
 <aRpaNMxGlyV_eAHe@krikkit> <d18ab53f-b91b-4c64-926f-4a1466d2d31e@nvidia.com>
 <aR2_D3iEQvAklDEW@krikkit>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aR2_D3iEQvAklDEW@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb676dd-3ffe-479c-5c32-08de27d30292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnR5cThtQURGaGtSYTlzRENsbWdLcjRqYko3YnpDbVoxeU5QQjcreG9Saks5?=
 =?utf-8?B?T3NqdmFXaWdBQnB3eTFSSGxESVhudzRYRGlaRUdxQ1ZVK2RmbUFubjNZRE1h?=
 =?utf-8?B?bnRCWEt2a1V0eFU1aDdHbG42WWdoTEU3ZDBYUXhsbUhhNnRTT01hQTVobkY2?=
 =?utf-8?B?WWJnSXpBRUQyQVUxMDQ4ajF0bzZ4ZTdVNExUUXA2Q0ZNL2l0V2xiYTBHY3R5?=
 =?utf-8?B?MjJ4SVBNano0ZU5CaUZjSlg0R1VsN0hjS2sxVzl4akVjaWwvRnBSY0JWMzAv?=
 =?utf-8?B?L21JMjFkQ2hxSUNiMVRUUU41QUY2ZEJMZXJ1b1ZvMDdNcmtBVGgrQjczNzJu?=
 =?utf-8?B?c1RlbkRTNEcrUVZVYmZheWhyTG1hSkF2MnR4VGFEUXhYTDFycTVINzQvZEsy?=
 =?utf-8?B?T1ZTVjVkcHJ6b0hyQUFWYlJiSHVCRmY1VDBMMnNnNSs3cllJSmxHdEMyRmlH?=
 =?utf-8?B?Q3M1aXRka2ttbm9Ic0E3WVBicmZBVTA1eWp6bWc3WG5MK2pTdGMvWkZZdENy?=
 =?utf-8?B?TjB4NW5GM011ckp1cEc5VXprV0cxeFhsUWYzMEthbDgxNk9GVTN1anR5OHVX?=
 =?utf-8?B?cGRWbDZRUGZ2Z0tCL25hWmQwTEVzQUR1cjN0TVlxUzNlQXJwQ28rRTZNdGJC?=
 =?utf-8?B?dEFJVXFJRFl3Nk5kNjZaTldJMzRUb2h0TWs2bXZXc20zN0RHSTM0MjJwaW5a?=
 =?utf-8?B?Vk4vVXdxNlpNWmVOYzBMZmlHdGQxUm5KM2dIWldmY2Y5cFlZaEtiYjh0WTM0?=
 =?utf-8?B?KzloTXVjdjhKcXFxUkxYNVZ6Z3V1WWNqT2JQT0dHMFBnWE5sRmE1dlMwYk4y?=
 =?utf-8?B?TVlzZDFhNEVCREd2bk5CT3FpTlFENEwwWEJqa0JlTlBXQTlrUGpJUUtzSndo?=
 =?utf-8?B?QXlGL2Q5dis3TU1SYjVnenl0L250Zm1XSjJQNWNzRmxoWU1BeGRGaE01aXYw?=
 =?utf-8?B?TmJhY2hHVmY3VnFIN3lxLytzRGlTYnNKcnVOT0N2NHNqMGRxTWsxL1N4ZGh5?=
 =?utf-8?B?dzE5Vy9QTWNJaHFmc3hXbmIzUnhCZk9RcG94bndGNHhwRDErSFRQekFSRWpj?=
 =?utf-8?B?Q3N1TG4zeDVCdTlMSU13RGdVbHZxWmcxR2ZJcjZlY01tMTY0V1gzZjFNV1V4?=
 =?utf-8?B?MDRvSjJ3eGVENng4K0w3VlNYNkY2cTdUdkYxZnlZeGhGcnF2UHNoTWUvaG9j?=
 =?utf-8?B?UkxQVTlKTVFqYUUyUGM3VzZpMnhUbFVWZHExTG1hempIYitzdWtsVGRpU3Rj?=
 =?utf-8?B?VGFQQy95TURlR1BjSGNNcVg3WUIwME9SUjEvOExNc0JjKzhSUWhjM0xpWEpv?=
 =?utf-8?B?aWlLUXFiNU4vTDI3bWRFcHFqSWVuQm5vUXg4RWVJT3NnbHZGbnM3SHRqWnh5?=
 =?utf-8?B?N2NxZGJ1MFM1K2RsVzh6SWoxV2dYd3hNSzJLVlBFVWM3ckxvMVNNOEVLOEhi?=
 =?utf-8?B?My9BSW1TSURaNWE2ekN3NkMrYVRUVGJJRks1MU0yT3d4bGFnR3NlTjhnMkdP?=
 =?utf-8?B?MTVuZEl2Q3NwWEFTUFhoZm5IM2hUWnFpZXRkRWJFNkFLdFoxZ3daVHFoOU4y?=
 =?utf-8?B?VTQrY1pIZTllbjZoWkdUcy9pU2dvSU9Ib29GUitiMmc2di83T2hWdVlaVG9i?=
 =?utf-8?B?cFA4d2xlQlM3VmF5TkNBalhsSVIxZy9OdkVKY3ZzOFBkZFlNMWdnWE9peUY1?=
 =?utf-8?B?MlQ1akRWSHJ0WExEcEd4d3Y1YkpiL25xK2ZWSzQ1Y2xuRkpCM2xQMVlqZW90?=
 =?utf-8?B?V1dvS09VSFJITG1PWDlvSGdIdGZFb3cxRUdBU2xld050WHhxTFBYa0xLd3Uw?=
 =?utf-8?B?eEZ3WktSVDlQZ2x6Qk96bnNDUWpMSjJxQ0dmNVZnQzdDQ1NoaVdnYVlLa1N4?=
 =?utf-8?B?d2gxaDVwS2xFTko0RTZpaUNiaDFoQnBpRVNRWFlGZGJNMHZQamRHSkxURS82?=
 =?utf-8?B?eE9qWTBQRUZTM0JKVndSVkxGUW9WeXM5SHc2aFNDelNRNVZ3NWxGRGR5TTB2?=
 =?utf-8?B?SE5hN25YaTBnU2VDQU5JM2FtTEpBUDBDT0R4Y002YjRLRHYrZmJCM2IzK3A0?=
 =?utf-8?B?MVF0OExvT3BVU3dKTlFEQytLcGlmNXY5RFY4ZEhrN0tINzAxemk0ayt4Z0NE?=
 =?utf-8?Q?9rno=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 01:20:36.6375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb676dd-3ffe-479c-5c32-08de27d30292
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520



On 11/19/2025 8:58 PM, Sabrina Dubroca wrote:
> 2025-11-17, 10:12:32 +0800, Jianbo Liu wrote:
>>
>>
>> On 11/17/2025 7:11 AM, Sabrina Dubroca wrote:
>>> 2025-11-14, 05:56:17 +0200, Jianbo Liu wrote:
>>>> Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet
>>>> inner protocol") attempted to fix GSO segmentation by reading the
>>>> inner protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was
>>>> incorrect as the XFRM_MODE_SKB_CB(skb)->protocol field is not assigned
>>>> a value in this code path and led to selecting the wrong inner mode.
>>>
>>> Your testing didn't catch it before the patch was submitted? :(
>>>
>>
>> I admit I didn't test all the cases for the previous submission, but I have
>> tested all the cases now with this fix.
>>
>>>
>>>> The correct value is in xfrm_offload(skb)->proto, which is set from
>>>> the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
>>>> is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
>>>> or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
>>>> inner packet's address family.
>>>
>>> What's the call sequence that leads to calling
>>> xfrm4_tunnel_gso_segment without setting
>>> XFRM_MODE_SKB_CB(skb)->protocol? I'm seeing
>>>
>>> xfrm_output -> xfrm_output2 -> xfrm_output_one
>>>    -> xfrm_outer_mode_output -> xfrm4_prepare_output
>>>    -> xfrm_inner_extract_output -> xfrm4_extract_output
>>>
>>> (almost same as what ends up calling xfrm[4|6]_tunnel_encap_add)
>>> so XFRM_MODE_SKB_CB(skb)->protocol should be set?
>>>
>>
>> I think we both made mistaken.
>> a. XFRM_MODE_SKB_CB(skb)->protocol is assigned in that path, but it is
>> assigned the value from ip_hdr(skb)->protocol. This means it holds the L4
>> protocol (e.g., IPPROTO_TCP or IPPROTO_UDP). However, to correctly determine
>> the inner mode family, we need the tunnel protocols (IPPROTO_IPIP or
>> IPPROTO_IPV6), which xfrm_af2proto() expects.
> 
> (not "expects" but "returns"? or did you mean
> s/xfrm_af2proto/xfrm_ip2inner_mode/?)
> 

Yes, I meant xfrm_ip2inner_mode. I apologize for the confusing mix-up in 
helper function names.

> Ah, right. Thanks. Then please update the commit message to explain
> that XFRM_MODE_SKB_CB(skb)->protocol is not the right value, rather
> than being unset.
> 
>> b. Furthermore, XFRM_MODE_SKB_CB(skb) shares the same memory layout as
>> XFRM_SKB_CB(skb). This area can be overwritten during the transformation
>> process (for example, in xfrm_replay_overflow and others), making the value
>> in XFRM_MODE_SKB_CB unreliable by the time we reach GSO segmentation.
> 
> Ok, that could also happen.
> 
>>> Also, after thinking about it more, I'm not so sure that
>>> xfrm_ip2inner_mode is wanted/needed in this context. Since we already
>>> have the inner protocol (whether it's via xo->proto or
>>> XFRM_MODE_SKB_CB(skb)->protocol), and all we care about is the inner
>>> family (to get the corresponding ethertype), we can just get it
>>> directly from the inner protocol without looking at
>>> x->inner_mode{,_iaf}? (pretty much just the reverse of xfrm_af2proto)
>>>
>>
>> I still prefer to reuse the logic in xfrm_af2proto()/xfrm_ip2inner_mode for
>> two main reasons: a. It keeps the code easier to understand by using
>> standard helpers rather than open-coding the reverse mapping.
> 
> We don't have to open-code it, we can add something like
> 
> static inline int xfrm_proto2af(unsigned int ipproto)
> {
> 	switch(ipproto) {
> 	case IPPROTO_IPIP:
> 		return AF_INET;
> 	case IPPROTO_IPV6:
> 		return AF_INET6;
> 	default:
> 		return 0;
> 	}
> }
> 
> 
> I don't think xfrm_ip2inner_mode, which does "if [some ipproto value]
> and [some x->* property] match then use inner_mode, otherwise use
> _iaf", is easier to understand. To me it seems clearer to add
> xfrm_proto2af.
> 

The simplicity of your helper is appealing, but I think we need to 
preserve the functionality of the existing helper for now.

> 
> And looking for all uses of inner_mode_iaf, I'm not sure we need this
> at all anymore. We only use inner_mode_iaf->family nowadays, and
> ->family is always "not x->props.family" (one of AF_INET/AF_INET6), or
> 0 with unspec selector on transport mode (makes sense, there's no
> "inner" AF there). (but that's a separate issue)
> 

The inner_mode_iaf is required because it holds several fields (maybe 
more if extended in the future) for the inner mode, not just the address 
family.

> 
> I'd be ok with using xfrm_ip2inner_mode for this fix and trying to
> clean this up later in -next.

I will incorporate the feedback into the commit message and push the new 
version soon.

Thanks!
Jianbo

> 
>> b. It keeps
>> the logic directly related to the xfrm configuration and state properties.
>>
>> Thanks!
>> Jianbo
>>
> 


