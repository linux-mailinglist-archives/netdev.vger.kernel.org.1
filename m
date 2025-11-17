Return-Path: <netdev+bounces-239008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C277C62112
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 03:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D54E549E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F44024BBF4;
	Mon, 17 Nov 2025 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D979VUdv"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB283246793
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345576; cv=fail; b=EfxWcYv2HUk0DHN2bOcwuBWnu7p0bLPP2Qo67LwXlcoGHDU66v+T/j5eJxtykJUy0uaOah7ErAd/h3L0cTil68Wh45oV6gH1FOMx1alB9EK191gaRBs4HpLK9S08NaQFekBzuAkUf6pTtWQVq2UB3qrX44Ydn2R5Giq6gRtKTcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345576; c=relaxed/simple;
	bh=UqsvxrGFxwnp0iLRes7PQMvf/C8p35Oi5vpuucfMlnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FLC7F7i7uDqu3LYyFGmZWbdlP2gLeh8JmHud6W2wKYLIH7/WTh0Cj8UKEoFKD1uuC4gmzcQl4lnZaty2DfScsym5Zv5VnGd3onJAVAVc6ThyK7LQnfOhoehgdbJDIU2z5MQ+T0bFlib7dEORY4G/rbu6F6dLsQx7NgRYXfRarwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D979VUdv; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx1uek+iF6rTQItqvsfqsAMwAQ18hC5VXWQAylWPqsSnbPfA3uORuiostcW054zQAfMe2o1vIv/fvb7NDFluxCOUiTnL6OjllPym/Ott9JXS56N83UdugEs5MUq5BW2UkvM1737tUPiT2086o6+ZtdwgdiZDKhBretxLLVK0mhEwHSdh89Y6fdRnVsTeTzPT9Klttn1Dfj0ppolzE6RHvbDfwS78ZF4Y+d6YmJbXFCpWDZQ7BB38q7QKvbxhtEt6GhUzzBLCLVGot+3d5UKQGx5a3SarmC2UBlwugQFbQ7gXJqi6PL4HixhMExzosYfQ1Pikd1apzpGE/Nb6PpPu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7VBE6wAB+UpqIweJHn2OxSEo2ePBDvU+DrR0BG4s1E=;
 b=TwjrVFTaJ7l9ex9YD/In3mBSM6kgyfoOUxGP9ryNUU/zMTO4TfL8vIe0fHlp05tQbkZz0eJXl5d12GBb/fEiK2/aPxSzHhJNc9GFBurVBF9rjYnu+wwHaJX/kpnpANYpDteYjqFV48Mi7+2YKD0GgTYYp1U5NThOsaFon0RQvwACHzrV64Dm9CU6UHKew5p1qtVKb75CtHfX9YjWizrVE7u7Ggo8b1CdpGbjmwSZUmSI50LZ21gUPa32shbVAhZ0HPcoJhGrXoiaGQknpcGYekYkHb7czF2PET0cZiv5e1732xX4dEEnIJeiycebT4FbaTFzKhDJZhvLeO1z6vfl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7VBE6wAB+UpqIweJHn2OxSEo2ePBDvU+DrR0BG4s1E=;
 b=D979VUdvyI4kCKOwoVy8DLbYDZbIkrVHqx7AM2cSjfn5hGsUWOd56CNlXOSY+YLRY4RnIa3+9mLWfo7RsII/YjzP4zUhNYQcrpJpi89PpV83fLhbrgx5L0Tc8OaixpYG9ofwlYW0iTfT/WmPGts2NZOp31bbXstRl8AiwSFom5+gL4Loih2bCGzpD3XQprq5u2zQq5ncY1+B/15A4NkkdOCFiQpVaoERve6DOdJKSLo76IpifSaJZpHgzr75pG8GAIB5qBz/1urvqiHpie2vW4p3WywuGDab2Eo0tLkLa8W+UU0dUWvynXMMR5o02hreGaT9bbwwvHULoScScbT7sw==
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 02:12:51 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::62) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 02:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 02:12:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 18:12:38 -0800
Received: from [172.29.249.233] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 18:12:35 -0800
Message-ID: <d18ab53f-b91b-4c64-926f-4a1466d2d31e@nvidia.com>
Date: Mon, 17 Nov 2025 10:12:32 +0800
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
 <aRpaNMxGlyV_eAHe@krikkit>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aRpaNMxGlyV_eAHe@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aca0a0f-0168-4669-731a-08de257ecf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2thangrNFo3SlN5Y2w4eUVCR0pwNXNqUGs0TXBVQW5ianhLdTBWU29aMGJz?=
 =?utf-8?B?dkNMWGNvLzZ3Q2JVejhLdncyK3hjV2ViNTFMRUhjRUNISUl5ditkNytIeDdj?=
 =?utf-8?B?MkdoZHFjakRTbE5nQUlENWNHSkVRanNJZGQzcnlQNkI4czA1eHdHR2ZQQXFX?=
 =?utf-8?B?ejBjeE82THgvc0l0cG1NakhnMk9oMTFsMFNhNzhzY2lYN1o5TWx0azFodFFi?=
 =?utf-8?B?RjJWTXNTV0YzUHZRenVJRzNIYTdyVXpPS1R3MmRZejlJSUFOQkRVL043YUtD?=
 =?utf-8?B?MkFZR1VSN2NpcGljUUdCU3lNTmd6dVJwM3pKdm9UVHNXUUU0SDErMUVpcnd2?=
 =?utf-8?B?c3ZHdk53WEJjLzRjNHl1UXA4TjRmWDNoQm9rOWZIVFJJbVpvUnZicGIyKzRy?=
 =?utf-8?B?R3phbXVGTFdFNWdzUEZiZEtlOWVLOWtrQnVjcndybVdlZk4rdGRhZFRUd1hZ?=
 =?utf-8?B?VHYySDJpMXNnSnlsQ0lNbkdocUlsVTNuRWl1SUNaN3lQQm0zelMyYVg5Q3Yr?=
 =?utf-8?B?R0VDSm5zQ3VFbHVva25SMlg2SG9BQkUwRWx5OVB5S2cwNEd1dUZCZ1NIdTcy?=
 =?utf-8?B?d1Y1d2xyRkhaVkRPUkdPZk16ZlY4bEtzT0t1dVl6VU8wRkpvQ1o3ME5YRjlV?=
 =?utf-8?B?RHpibWFTWHM5OHJzK1FQYVF4R1RxdG9aMU5JclVJL3RVaVRDZ29Cc1NXWnNK?=
 =?utf-8?B?NDAyVEl6MjNVY0JIa2pYcG0vNmoxY21jOE4xc0RFNGJ3bmJlRnRRdzVRZEs2?=
 =?utf-8?B?OFFlUm1hcUZSaVBMWEV6dkVPbHI5VGFGOGVqN0JrOEFzK1ArS0lDb2lLMmJz?=
 =?utf-8?B?U29tUXNBNVdIUXEvaUwxeUI5c2pNU20zbHkzNldsNjE0OFFIcDkzREdEbWE5?=
 =?utf-8?B?UExKU05JUmo0S01EV1lNQ0ljZDc2R1FJempHL1h1OGpTOFZLMUJqaDJJck1h?=
 =?utf-8?B?UTVvUk1mNmN5QnhVQjgrRXhVVk14STdyK0pVR0R4Mk1oMHhUTEFlWkowYXFz?=
 =?utf-8?B?b2NvaXFrc1RPaXlraG02bXE3cUhaYmMwOEVEd2RWYVgxY1VOYUg3YkhOR3A1?=
 =?utf-8?B?V1RGK0hsWXdJUjJpKzFYK0JqYUFwWXJvTDZwbG5ydkhzaHl4YU0xWGJFenZT?=
 =?utf-8?B?T21Va01leW0va2FBOTlEOC9pdDd2eG5ieVI2R0x4WTd3Z0ZxMm1rT0RCKzhM?=
 =?utf-8?B?REhrSTFrTjFWSjhtWUtDcmFSbktrbllYMFljUzVpcCs5dXJlQUJPOFYyZ0hi?=
 =?utf-8?B?YldkOEZ6L3NVWklkM0doc1JsbFhFVUsrUC9zNklUNWpjR0N3di9SSStoK2hz?=
 =?utf-8?B?bVFLYUVTT1BMMC9tVVN0TGxyOUFVUW9RT3RvVjZwL0dGak9ld0FaNVg2Q1RP?=
 =?utf-8?B?bnNCRHA4QzYwZ1NPZmRUWE5HbC9zSFR0RmpxV2k0QkxyT3dkWWcvL1VkUjd5?=
 =?utf-8?B?d0dwd0lHbDR3cnFhbFRhQkYxZUI5WGVVUFpnTnJjelEvOTlOTVRYUDJHTFc4?=
 =?utf-8?B?MFVlNis0a25aYTlWWmxnbVJCZGFvcjIxMzErbkFVUlNhcnJSa1ZWYzNvakhn?=
 =?utf-8?B?QkwyWFBuZEl1TkFqWEs5b054NE5FN1hhSnd6azBiV3d4T1NnRHlabGNnaHpE?=
 =?utf-8?B?ME9jd2R2MGNSN2pBWTlhZjBEckNkSXgxdXIyTU55Z0UxR2RnOUUxMmh1b3JG?=
 =?utf-8?B?UysrOW9FU2hEdy9BTDVCSDFpeUVLbVZwMjYvK3JhVGIyL24vaVlrV3RlOC9C?=
 =?utf-8?B?UjcrZkhCRDlPVXNxa1BuUnczNW4xM2VCOHY3Tksyc3A3WkoyTFFQZUkvWnJa?=
 =?utf-8?B?RFJTQjNqVTYyaSs1Y3FscXRhSG9LNXZpUHVwM2FqMCtINHhYYWRhWG9HTlNF?=
 =?utf-8?B?RGwrVWJMZGVIaFd2RVBIU2F5SlMxRlFVRVZSdFUzb2JFV1VuZGJZWjFLcDUz?=
 =?utf-8?B?alJkY3pyZkl0SnlSUThKV3FTZTRWOEhEY2wzSGlpK1E3T3YyQ2xNUDhCMDI5?=
 =?utf-8?B?dmt2L0p5dWo3OHliNWRjeFY4V1prM2pSWWU3N1I1YXQ1Mmg1QWF5bnNCMmdy?=
 =?utf-8?B?c0lpczgvN0l3TDRJdk8va3laaW1tSW5pVmxTdU90NkV1UDNFemYyTG5odUh2?=
 =?utf-8?Q?wOIM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 02:12:50.9892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aca0a0f-0168-4669-731a-08de257ecf93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309



On 11/17/2025 7:11 AM, Sabrina Dubroca wrote:
> 2025-11-14, 05:56:17 +0200, Jianbo Liu wrote:
>> Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet
>> inner protocol") attempted to fix GSO segmentation by reading the
>> inner protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was
>> incorrect as the XFRM_MODE_SKB_CB(skb)->protocol field is not assigned
>> a value in this code path and led to selecting the wrong inner mode.
> 
> Your testing didn't catch it before the patch was submitted? :(
> 

I admit I didn't test all the cases for the previous submission, but I 
have tested all the cases now with this fix.

> 
>> The correct value is in xfrm_offload(skb)->proto, which is set from
>> the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
>> is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
>> or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
>> inner packet's address family.
> 
> What's the call sequence that leads to calling
> xfrm4_tunnel_gso_segment without setting
> XFRM_MODE_SKB_CB(skb)->protocol? I'm seeing
> 
> xfrm_output -> xfrm_output2 -> xfrm_output_one
>   -> xfrm_outer_mode_output -> xfrm4_prepare_output
>   -> xfrm_inner_extract_output -> xfrm4_extract_output
> 
> (almost same as what ends up calling xfrm[4|6]_tunnel_encap_add)
> so XFRM_MODE_SKB_CB(skb)->protocol should be set?
> 

I think we both made mistaken.
a. XFRM_MODE_SKB_CB(skb)->protocol is assigned in that path, but it is 
assigned the value from ip_hdr(skb)->protocol. This means it holds the 
L4 protocol (e.g., IPPROTO_TCP or IPPROTO_UDP). However, to correctly 
determine the inner mode family, we need the tunnel protocols 
(IPPROTO_IPIP or IPPROTO_IPV6), which xfrm_af2proto() expects.

b. Furthermore, XFRM_MODE_SKB_CB(skb) shares the same memory layout as 
XFRM_SKB_CB(skb). This area can be overwritten during the transformation 
process (for example, in xfrm_replay_overflow and others), making the 
value in XFRM_MODE_SKB_CB unreliable by the time we reach GSO segmentation.

> 
> Also, after thinking about it more, I'm not so sure that
> xfrm_ip2inner_mode is wanted/needed in this context. Since we already
> have the inner protocol (whether it's via xo->proto or
> XFRM_MODE_SKB_CB(skb)->protocol), and all we care about is the inner
> family (to get the corresponding ethertype), we can just get it
> directly from the inner protocol without looking at
> x->inner_mode{,_iaf}? (pretty much just the reverse of xfrm_af2proto)
> 

I still prefer to reuse the logic in xfrm_af2proto()/xfrm_ip2inner_mode 
for two main reasons: a. It keeps the code easier to understand by using 
standard helpers rather than open-coding the reverse mapping. b. It 
keeps the logic directly related to the xfrm configuration and state 
properties.

Thanks!
Jianbo


