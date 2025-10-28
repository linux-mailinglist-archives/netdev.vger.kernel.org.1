Return-Path: <netdev+bounces-233384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04786C12964
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B62704E9E4D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A992494FF;
	Tue, 28 Oct 2025 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udUHRTRU"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195F215F6B
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616141; cv=fail; b=WutOFuIrz7NgjZ51Jv8Tx+22BBsjDvDKj4LHTliOg3z7F/3i6DNoww0zD2JVNJ6fJ5uWb4D/c9HcQgDtDp/yukFzYp+n9QxwKRk5F44xk+pJyygw/Cu9dfOgAUZzlNXjKBODA9nqHSmaX1UY3JwZ0APLohQ7cEM2fjzJg0kg/yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616141; c=relaxed/simple;
	bh=LRhbQopkXDGyHs8+4ZkL94KPmoR/p3+F6O4wXgmJa9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rnUaNIWvP21XYvhA099i1ZGGHZtZwOlyxX8pfH3Xd4zh7XLKTTX1YJynLCTSzZTX8aGNXVZxxkP00aA7E7521QyxZy4xNBGn5klN1p7FOY1RpXZhPCFrg8/IhV/xKsPFTToTeuOEFhbWEWuiegV427MWly0pwLqtsHmCwxqmXJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udUHRTRU; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIiA1V1WBSdNcYET3gi+o1NRVQhCMKqrZ/qXk1UB7/M0Z6Tzjs5WBq0XRDccIGf5VmN+2zu6ivDHGIGdtVHcHSnn/juz62HZrbVGYM1VdxGz7DDsBCi4aUuENl6AUfDsW40Rft001qLLpQw2zPf6GiVXUAlf0SSVf/cjn0ORllwWwqoznUrzeVqnwmZ68dk57ZvdKXqYcyMsLQcwFjhZ/LSDEb6wErbOHU3WvQLp0SWCQI3SqRff12QgbLo8VKKyVpqjbmarIKhxI9iq8eT27i5sLp1I92M4zcgfMlq+fXWrw1vVNqQyEJ91a0mlcI2Ebxs1G7HKnNai1ANnXlTpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyhSZrb58g7/mhkC8mdhCxWJp1P0VyqtpGrXvdFyZyA=;
 b=PWR6M5O3WsIqtXQVIJ9jPpRX3wtsEJknTIRpT1SRJQg8S6/gC2KGzlxuYH/VEXfPJ0QGrMtN7drn7brauEc9x16pTVhMFpOopdhqS26GC/0psEJtznjqd11inpnC2kr7dMao81YjMYrNESiG7k4v6LhqxHMoUCIliBP3CVz2Y86FkRWsgK9mpIYPWUsik1oPZXjTjt4/V0FMB1cMZO38MPLp0+GMKAR0B9SWVInmu/wVn1p4MFz8dArlSYJGvDk3LhojFVFHnmCqUOdFQXjoJVYHKm40sJRHXGrwqRHPNVusVZ6iCvj7mVFzY1nL61cdrgT7KnbL8AjSE1hhimXE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyhSZrb58g7/mhkC8mdhCxWJp1P0VyqtpGrXvdFyZyA=;
 b=udUHRTRU4nL32MMfPV+9QpzYNUn7l115T55aIAUEg/3I9YTHTjz9dSZdGcFWgyGsomagVvRKnl6+TfOxbB7U//3Cw6U4Q9b2g/PSAbDncPDmvzj3bxQ/jEJd6giYXrtmUbifeCeVIXN5g+AsAtJFs98jZknFAIv2ABdiLwIzyrIDl7VGu4kIQQNe5muHatK0tenDcfTzmzGzn/RE6Gvf+pluCG3CsYSvIDanFoIOtRqyvDYXZNN6X1m+n5bmYPKaZW3VSDEKK/ztHcSM4WViMlh5R6uF5WxeenXVTg3mVk32NMAzDMQYuq1O8qMD16kl1h7jWhHXbqeBlRd8l3vT4Q==
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 01:48:55 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d8) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Tue,
 28 Oct 2025 01:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 01:48:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 18:48:38 -0700
Received: from [172.29.246.187] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 18:48:34 -0700
Message-ID: <b92ec23d-f877-4dc3-a95f-c9b66120686c@nvidia.com>
Date: Tue, 28 Oct 2025 09:47:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec v2 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
References: <20251027025006.46596-1-jianbol@nvidia.com>
 <20251027025006.46596-3-jianbol@nvidia.com> <aP-QvtNf-Vp5oHLX@krikkit>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aP-QvtNf-Vp5oHLX@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3a8cdb-3647-4356-ad60-08de15c426e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVUzMVJ6RVE3T1ZqejdPRjlrVFg5Tm93TC90VUh1ZzRuM0dXeVhVQU5ndG95?=
 =?utf-8?B?L2VFeS9mNEJMbU5XUE42Y1l1Ykpaam9RYitiQ3BGcmlKSVlEUUlpa2xNc0I0?=
 =?utf-8?B?WmRTR2IxaG5jWnhoL2hQai9rRnRWSmhXTkhrdkduenZ5YVY3S3dvNEZtam1z?=
 =?utf-8?B?M3lBYlRhRkdFY09WNVRJcVR2dHlFYnYyUEVicjJzaUpVcnJ6ZER2RXNyMWlZ?=
 =?utf-8?B?Wld4WExYQmhrRVhBTTNYQnBhZVRnWndZZEdYbktzS3FpaTRZK2l1aVNiSjRs?=
 =?utf-8?B?Um55cURwbC9YRVhyeVhmaTdGLzNDaHV2T2NkSk1hc25yMjhXM2NqazBUTUNZ?=
 =?utf-8?B?dWVwV1FJOElhQ1RLaWxoZzNRZUpKMDhkSFQ0K3JCR01sMm0waVpKYmNOVHFv?=
 =?utf-8?B?SjZ1YzdsLzNUVTd0V3ZOTEdXaUViSFVhSGlONlE2YThhVWUvbW5xVUZLdVFt?=
 =?utf-8?B?bnZzcXBaRHhOS3plN3pFNERiR3Q2cmpRTUs4RWM4YzBxcWxSdFEvYnZhUmJk?=
 =?utf-8?B?OEVMeTRPT3Ywc0UzeW93eFR6dkx6VzNBM1M2NG1zSko0cXRUdlhYYm1EVnlR?=
 =?utf-8?B?WnY2TmU5SHBXTzg3amM3dTN6SVJkOGVFVnIwSmN2RE50SEdPakFCRlY4WlRz?=
 =?utf-8?B?bEx5WXJUL1ExMGhmWjN5V1dOd1gyZWVvSzB5WndpUVpwc1RyYzFXL1pIanRE?=
 =?utf-8?B?M3RKNVRPZXVzOU40SEdROTAxblp5YjJRVUloMmhjRTlGOHpBSDQwNHJyRFl6?=
 =?utf-8?B?ZUJIZWFFeVpNMjdWNCtSVWdocHkyNjdSbUFpblU1Smxuc01HVlhDZEdIT1cv?=
 =?utf-8?B?ZFNTcjFJRElYV3NXQjMvWkRtU3h2citLcUNzTGRRbkJwS0ZjN2g5R1lVbGxF?=
 =?utf-8?B?dFZIQVM5c3NKM1N6ekFuNk9jNGY0dkwxQXNzb2tYT2Z1ckFzTWdjWFovTWJw?=
 =?utf-8?B?d00yb3h4bmxMUzNRRXF5VmRZQU5UbS9zMHhGNVFRdHdDdWNRbVBOdTVzQTVX?=
 =?utf-8?B?M2tOSGpGVFRiR1RKL093cFZmMFo3VFNsaFRQZ2xsMTRoYUVTNHlOQnVJUG1y?=
 =?utf-8?B?RENwR0x0ckxTcjNwZHV5cUQwQ2JHL3oxL1BmVGZaM1YrYzVRMDlhMXp5Z1ZJ?=
 =?utf-8?B?VWhCYis0c1lhV3ltelkwN1h1V0gzT0hJY0MzbDhHdFZaMFhOVmUxeUgwOFEy?=
 =?utf-8?B?WXZFQlZSbm45S09MeXBKOTJTc2Q0WkZFTGJvTFRkSm83bDVzdXk1RWwyUG80?=
 =?utf-8?B?S1VUbDF2MlBoSEtNREk4bjJtQlN5aHlhOUVPczZSQ2JWOFl3V1Jxb1NHazZD?=
 =?utf-8?B?UkZucFJQbHJ6a1ZwZVJsajdiVE1PdWlZVXNoczBVaUswTUhnenpkQkQweXF4?=
 =?utf-8?B?VWlrWmErd1FsVGx3MmcvcW81bGkreW9YYUp3dkdZczdsYWV3OEphNGs3aTVh?=
 =?utf-8?B?V0phUFFTc3ZEb3lOT21reWQxZmNKdDVFcnljWGMwQWUyTGxQd1ljbXI4MGF0?=
 =?utf-8?B?SVpBVERZZGZkamNnL2RBblV6dldjMzVueE9abkNvZEdQaEdEZTdMbXFQUWUw?=
 =?utf-8?B?a2hSYzlrRVFGSFlvTjRWQ0R2SUoydHdCQVlONGtnLys2Y1pjMzFRQ3h1S2I1?=
 =?utf-8?B?NzRDeVBTSUMxUXE2elp6SDlwWkVFamI0UHBvWFFxZ1A0a3BmNzJRbk1lc2py?=
 =?utf-8?B?ZjJMQ0M0SHo2ZkpTMldBd1JWd0dGdmpQaGcybE9XTnFaMzVRODlPWWJzOFBB?=
 =?utf-8?B?N1RDb1JGNTVFYVhqZGw0aktoV1RzdnJUbURJOW8wUXdwVmUrRG90MExZdEdB?=
 =?utf-8?B?WEI5Tll1eldyY2JvTmtaTmhleTVKY1JWa0pxbVJ0aUJ3YlhEZWhHSlhnZVY4?=
 =?utf-8?B?LzVxMVFZM0U4ZGRrVUp6STBQVHJDZWlHc3Zzb2tjTnFjU0xZcnNNa3ptOTN2?=
 =?utf-8?B?bVZ2V2ZtQkVBN21aZFZtUUFlRjJHVTV6SEl1clE0Y0RYK3EraUI2UzlSeE91?=
 =?utf-8?B?RWhSZDl5UG9iT1M0MkxxbUFEMDBjd3ZiT3VaNW5Yb0RNeEFHdmEzRFdIbytT?=
 =?utf-8?B?Snh2T3VSZU9OMjAyRDVXY3NRdXNzUW40Y3dxZz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 01:48:54.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3a8cdb-3647-4356-ad60-08de15c426e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234



On 10/27/2025 11:33 PM, Sabrina Dubroca wrote:
> 2025-10-27, 04:40:59 +0200, Jianbo Liu wrote:
>> The GSO segmentation functions for ESP tunnel mode
>> (xfrm4_tunnel_gso_segment and xfrm6_tunnel_gso_segment) were
>> determining the inner packet's L2 protocol type by checking the static
>> x->inner_mode.family field from the xfrm state.
>>
>> This is unreliable. In tunnel mode, the state's actual inner family
>> could be defined by x->inner_mode.family or by
>> x->inner_mode_iaf.family. Checking only the former can lead to a
>> mismatch with the actual packet being processed, causing GSO to create
>> segments with the wrong L2 header type.
>>
>> This patch fixes the bug by deriving the inner mode directly from the
>> packet's inner protocol stored in XFRM_MODE_SKB_CB(skb)->protocol.
>>
>> Fixes: 26dbd66eab80 ("esp: choose the correct inner protocol for GSO on inter address family tunnels")
>> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> ---
>> V2:
>>   - Change subject prefix, and send to "ipsec".
>>   - Add Fixes tag.
>>
>>   net/ipv4/esp4_offload.c | 6 ++++--
>>   net/ipv6/esp6_offload.c | 6 ++++--
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
>> index e0d94270da28..05828d4cb6cd 100644
>> --- a/net/ipv4/esp4_offload.c
>> +++ b/net/ipv4/esp4_offload.c
>> @@ -122,8 +122,10 @@ static struct sk_buff *xfrm4_tunnel_gso_segment(struct xfrm_state *x,
>>   						struct sk_buff *skb,
>>   						netdev_features_t features)
>>   {
>> -	__be16 type = x->inner_mode.family == AF_INET6 ? htons(ETH_P_IPV6)
>> -						       : htons(ETH_P_IP);
>> +	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
>> +					XFRM_MODE_SKB_CB(skb)->protocol);
> 
> I don't think this is correct. inner_mode_iaf is not always set by
> __xfrm_init_state, only when we have a AF_UNSPEC selector, which is
> not always the case for cross-family tunnels. So we would end up with
> inner_mode->family = 0 here, and pass the wrong type to
> skb_eth_gso_segment.
> 
> Other users of xfrm_ip2inner_mode (in ip_vti/ip6_vti, xfrmi) only call
> it when we have an AF_UNSPEC selector, then we know inner_mode_iaf is
> valid and can be used. Otherwise, the selector (ie x->inner_mode)
> should have the right family for the packet (and all callers of
> xfrm_ip2inner_mode use x->inner_mode when the selector is not
> AF_UNSPEC).
> 
> 
> Maybe it would be better to move the AF_UNSPEC check into
> xfrm_ip2inner_mode, something like:
> 
> static inline const struct xfrm_mode *xfrm_ip2inner_mode(struct xfrm_state *x, int ipproto)
> {
> 	if (x->sel.family != AF_UNSPEC)
> 		return &x->inner_mode;
> 
> 	if ((ipproto == IPPROTO_IPIP && x->props.family == AF_INET) ||
> 	    (ipproto == IPPROTO_IPV6 && x->props.family == AF_INET6))
> 		return &x->inner_mode;
> 	else
> 		return &x->inner_mode_iaf;
> }
> 
> 
> since that's what all the callers are doing anyway?
> 
> Then it would be valid to use xfrm_ip2inner_mode like you're doing.

It makes sense. I will submit v3 soon. Thanks!

> 


