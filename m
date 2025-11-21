Return-Path: <netdev+bounces-240615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C2C76F3B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294564E6D69
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79D1D90DF;
	Fri, 21 Nov 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgACORug"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15456226D18
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690631; cv=fail; b=Wlk+c4sKNZZupUjZiaQFAiBEtt9Hn44TCmwMG3y/2ZyeujgE/4iXWBUkAEg/Djj9ccQkZ3PyiOotGqQCKphvmra0Wk4akQiK5aayFVrkPumyWksZzBaLwtW1AjQQnwO4/PU1VmJiL9Sf11KLFaaVPUdBSct2uuZLGj+G8bg4AkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690631; c=relaxed/simple;
	bh=aWW72w5bEnstRBLAebGnVK6flZmKRmzTFFJ6oK9hzPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QKO8w7xIpBDTgHCTpQaCfJD8QVbHgZW4yfv0R3z0E0Rd2d/LHRf5oMP1zBFiD7EFEUDPTl0WPePxZEBL+irLYleuwzU4IlDQfILOL4SRsZP9+R04ESzQxhijwKaY1mdho79aReJQS99uAta4yvsbQTM2e7g4MglU6fgMwGN1Kv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgACORug; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmHzhFnmm2XpuQ5Di3yeA7U4KFQGhZ0Ky4cgy67nbdK2J6HkHajBJikonQKEPX+MT5K6R16LiK68cqfyGQdbzzr5kqBAnFf5g4/yLUyydZTmNQy9dUCE7qeX4MNPx9k8/SiujXQzrxnW0XZwo5EDq5djVwq6khpq8CvM1Gsx6jq0LgdGGyNUHqX3TsWC2HcAsmx+aBUxcdXTD41Xs5XLTcQSLw2ImaDgv4hSbp5k/vWwkr06OzMoXVcu61jz/5eV4Dadu2iXiXRK8J88zuk1FHV6hC1Hv35+5GwL0sYzt9yiWfptmJciiNVhbWrXui5HiPbLgb/ecNrbWjqV3O+6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VkEgWIOAmLX4aburOJP5PReH3yCRP1jeRsE3k7mzhI=;
 b=Tk6H02vmdE7Qit9DgOKx+FfnLWBvts2P8TqX/Xc906sabeGjSu2n1Q2IWqahMu8FspfgVtJfUMYW+xCpBArMZwNfJKlDB8eEpeJ009V79we3r6HihFQ4STjd7/8+cmX1DZw5o8PG98E8vKO0y7KbwBwwRfHA8PhtMxkSuIVNR5JR66SPh6fFrrsgqTovIRHoP4Dygia4VgYYcI+TMu0SXs+D5d3EoH2IN6Y/2IX+F8AEKQcXqBJuE530BtHDznYw/dSErpJbqlwLWEKf8D8uet6wC+DRaEMxZlyvG3iD6ERjA7xv2dlI2R55VTH+ri0J8Yu+VaCGG1J/ragUyjAv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VkEgWIOAmLX4aburOJP5PReH3yCRP1jeRsE3k7mzhI=;
 b=cgACORug52yJrFhG2mAka0hqRj2KdEr9AE2g/8qctTBgP8R/UoVP946GInccl4NbJHJHoh3OGn2UC8FbrreaMh/yCt2vEXIff5b7c5xVUezj1VvquTpY/tnJyfzyX2Ew/2Mrcfz15UBb3fwFbQywR0jzIR6FaY+pPjvcCe/A3aWkE41/NIMxHOkTDm5kOTwZZnFvenUhrpHMp/XV28qrRg40ymnrT/xyMfa6dAheY93GSZTTXbUj7U0yzCtLDToEqEFn3aWDbSGgMmDFhySFQPVuCwaCxUnmm/CShaJ2bKLZSoXRA4hsj2w1cUYJOBj/1F0cBBUtWh+AsuEVgxfwVA==
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 02:03:43 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::65) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Fri,
 21 Nov 2025 02:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 02:03:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 18:03:21 -0800
Received: from [172.29.249.233] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 18:03:18 -0800
Message-ID: <c1300ba2-d4c8-48a8-b5e6-f8cb4e492fac@nvidia.com>
Date: Fri, 21 Nov 2025 10:03:16 +0800
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
 <aR2_D3iEQvAklDEW@krikkit> <86801357-7262-40e5-b2bc-8429ac80ec7e@nvidia.com>
 <aR7-Vx4du2M6HGl2@krikkit>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aR7-Vx4du2M6HGl2@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 745a3a6a-089e-41ef-1439-08de28a23266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk9uRjF1SlN6NlBaVnhSOW9TUjh6Nzc3RngzL2xRUjNMeDkzTzg4U24ycTQz?=
 =?utf-8?B?T096V2lhRU1Ya0gweHY4MUI5czdwV1BkSUxydzNTMDJ6THdyZDlhVG5nZldP?=
 =?utf-8?B?Wlh3WFRDSVp2Rzl5SWtaVFJPYWw1dFFNejJKNUhRa2lUVGR6QVVpTmlGTVgy?=
 =?utf-8?B?Q3NJelFNek1aUkRvbzFBdVRCNEN4MHNPc3NSS09DQWVQTHRlRTBIdVB5QWFi?=
 =?utf-8?B?TzZLTHZFR2NTUkp2aWJKdjJMZ1lEL01BYTJkV3BtUHd0cXZ0SnNkMUpsTW4x?=
 =?utf-8?B?VlIzVVM2Q295VC9yTzZBM2NoNC8vUk15QkQ0N0FFMzczd1FqMkVJU1NtV1Jr?=
 =?utf-8?B?ZE5Ic01HdjA1WE50dEw3N2pxMVp6ZDY5a0tqRURDYkhzU1E2U2hadnFqcy9z?=
 =?utf-8?B?NUl0b3FXN1l4V2tkVVdCNEU0ckVaRnM3WkRBQk0zbTNPR1lmVDdBdjFucHhh?=
 =?utf-8?B?ZG1iVUdDcXhnMERIYXVnZWZTV1ZLRTFKdGFSbzgvQm1tYWNzeHhzQnJNMjhn?=
 =?utf-8?B?NDl6R0EvUGVTK1BkN0pnbWFWVkV4VFFzd2dFblFvYkdwR2VvTm9jMEtSTUhW?=
 =?utf-8?B?MXhqTDUxNkRTVW95UzJWV0NLaVNHT08rcm4yeUhuVk5yWGpVeGNZdWoxODlE?=
 =?utf-8?B?R2cwNS9kSkdJTW55bW9PUXAyRGFFZXczUmxuK2hzbkoyTjBQVko3dCtZQ3lB?=
 =?utf-8?B?cnlhbkVjcmg3TWorV05YbUZHeTlPd1Z5SGo2WWNPVVczaS85cC9FRHJieTYv?=
 =?utf-8?B?WGhFN0VKNHcxek9GT1NuUXEwNk5GRXAvalVacC9wdkVDTjgyVVdUbCswOE5B?=
 =?utf-8?B?UDZoSnNmelU4OURScGlwdEpXaU1VdVJOaEhUa0VHOHhGVG12bnQxQ0dtL0NF?=
 =?utf-8?B?bUpOV0puclhTOGF3ZUxCV2x6cDBoZzdTaXdhdEtlYVlmVXg2TUJ2ZityWEZR?=
 =?utf-8?B?TFo2VUR2QUNzK2FNR3VFeVRHQVpGbmNHUzV2YTFvNHVrNG1jYlR1YlZXRTNH?=
 =?utf-8?B?ZDRWWmJTSWtRb09PeWVNZUs1MVVJYnRiOU9EdmlybTRpNUh5RXlHbHlRMSto?=
 =?utf-8?B?UVZLN0FCdE5nNDBzbUNFUGtsRnZUcjh0YnFMVGxDdHdhMS8vRUIvVWZSRk9D?=
 =?utf-8?B?MjJjQ3FBRmdPSWpQeDFJcTc4QUxLSTNpTSt4TTFwR3dUNStINlRXNFVLWmpP?=
 =?utf-8?B?WHVHaU1CbHpGNlFBQXZpQ1k4SHduWkJFdnBESmh4b0xlTmVWQXNTSkVRL0tC?=
 =?utf-8?B?SGYxbjRJejcycUJRd3IySnA4M3ZQVkwwMVFBRXlkb3dPV2FrY0l1TUNPSlE2?=
 =?utf-8?B?b2FnNHNTNzJYQTduUDRHSkdEWi83WFRjMG9QTVl2RzdTYlQ1YnFhWlpsZmgy?=
 =?utf-8?B?N2hqdjl6ZHRBMzhIREtoTWI2Mk9qcTAvWlFFbW9pVmdQM3BOazJjM2RRTUM4?=
 =?utf-8?B?VDRoL1lueHRBRUJxa2h0akVEQlQyWmZxZGZZUWNITHNwcnlsaWRuMjN5YzN6?=
 =?utf-8?B?cmZXTktxTWcwV1pxQVJXZFFVbGZjektaVlpjRmk4WTRheVZ2czFZam5OU0lS?=
 =?utf-8?B?bC9Xd3BLbFVLdWdvOVVHTms1Q2prdTBVeGVqSmR0YUxDK01hamVwaE5ldGp6?=
 =?utf-8?B?RkNmSklDR05jNVhiSkJwbjlkQUkvVmU5a1M5ZHhDYVduQlRaNndMTk54ajc4?=
 =?utf-8?B?MVU3UmZldXVrQXdxMk5ZRGxKaTYycmxhSVVTSEJZemIrcUNCdUFDV2NQa1pq?=
 =?utf-8?B?SW1GMWZ4Ym9QZjB6Y0s3MC9zK1BxRTFwdDI3YTRtU0pEcWhTTk9TamtWbmd5?=
 =?utf-8?B?TGdCb1F0NzZVaFhTTU5kczZUTCtyR1kzb215MStqZlRnWXJEd0JqcFU5dDRC?=
 =?utf-8?B?NmpNOW9wYzZ2TnFXVi9NM1UyNkx5N3A2QjI2bzI2QWdtbUp5SWxXZlRUTVlF?=
 =?utf-8?B?dHRSdldma0JyQUsvM0VVS2t2NHJ3UkNreEVZMTJnUEN1aUhUd0lrTmtGb05H?=
 =?utf-8?B?eGl2UXpaT21HYitCVUhnVnd4Rml6UEtQVk1BRjA3MFlmUDloOE9lWEw3a0Fo?=
 =?utf-8?B?Y2sydlRiMjRpRlZhTjBqV3FESUxHVU5SeWtQeFRvTWhyYWsrQXVONlRmelRm?=
 =?utf-8?Q?oJdc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:03:42.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745a3a6a-089e-41ef-1439-08de28a23266
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788



On 11/20/2025 7:41 PM, Sabrina Dubroca wrote:
> 2025-11-20, 09:20:11 +0800, Jianbo Liu wrote:
>> On 11/19/2025 8:58 PM, Sabrina Dubroca wrote:
>>> 2025-11-17, 10:12:32 +0800, Jianbo Liu wrote:
>>>> On 11/17/2025 7:11 AM, Sabrina Dubroca wrote:
>>>>> 2025-11-14, 05:56:17 +0200, Jianbo Liu wrote:
>>>>>> The correct value is in xfrm_offload(skb)->proto, which is set from
>>>>>> the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
>>>>>> is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
>>>>>> or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
>>>>>> inner packet's address family.
>>>>>
>>>>> What's the call sequence that leads to calling
>>>>> xfrm4_tunnel_gso_segment without setting
>>>>> XFRM_MODE_SKB_CB(skb)->protocol? I'm seeing
>>>>>
>>>>> xfrm_output -> xfrm_output2 -> xfrm_output_one
>>>>>     -> xfrm_outer_mode_output -> xfrm4_prepare_output
>>>>>     -> xfrm_inner_extract_output -> xfrm4_extract_output
>>>>>
>>>>> (almost same as what ends up calling xfrm[4|6]_tunnel_encap_add)
>>>>> so XFRM_MODE_SKB_CB(skb)->protocol should be set?
>>>>>
>>>>
>>>> I think we both made mistaken.
>>>> a. XFRM_MODE_SKB_CB(skb)->protocol is assigned in that path, but it is
>>>> assigned the value from ip_hdr(skb)->protocol. This means it holds the L4
>>>> protocol (e.g., IPPROTO_TCP or IPPROTO_UDP). However, to correctly determine
>>>> the inner mode family, we need the tunnel protocols (IPPROTO_IPIP or
>>>> IPPROTO_IPV6), which xfrm_af2proto() expects.
>>>
>>> (not "expects" but "returns"? or did you mean
>>> s/xfrm_af2proto/xfrm_ip2inner_mode/?)
>>>
>>
>> Yes, I meant xfrm_ip2inner_mode. I apologize for the confusing mix-up in
>> helper function names.
> 
> No worries. Thanks for clarifying.
> 
> [...]
>>> And looking for all uses of inner_mode_iaf, I'm not sure we need this
>>> at all anymore. We only use inner_mode_iaf->family nowadays, and
>>> ->family is always "not x->props.family" (one of AF_INET/AF_INET6), or
>>> 0 with unspec selector on transport mode (makes sense, there's no
>>> "inner" AF there). (but that's a separate issue)
>>>
>>
>> The inner_mode_iaf is required because it holds several fields (maybe more
>> if extended in the future) for the inner mode, not just the address family.
> 
> But the other fields are never used (and have the same value as those
> from x->inner_mode, no need to check _iaf). Anyway, I'll propose a
> cleanup later.
> 

OK, I'm happy to see your proposed cleanup patch soon.

Just a friendly reminder. Could you please confirm the latest version of 
this patch is okay and add your RB?
https://lore.kernel.org/netdev/20251120035856.12337-1-jianbol@nvidia.com/

Thanks!
Jianbo


