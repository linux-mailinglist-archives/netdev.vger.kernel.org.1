Return-Path: <netdev+bounces-147672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5A9DB13E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EA816539E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323253E23;
	Thu, 28 Nov 2024 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1VN7bb+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA76126C08
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758509; cv=fail; b=GdsyZeHxJ6E/FIlXGJwETvMA8rEylpxYX7pPUxGaGexXlk0vvd3AV2o4kRQqUAxxdFadcWb4sFSkwN/odagt1yN7QmJGXmhu85ucR0mH26/UYKgykpLC/ntGtJSjL2h7AECutwtGbyT8ZWsrG9JvlYrnP0qOQ0xti3vaBN4yb/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758509; c=relaxed/simple;
	bh=/RHEY0hyvfHT/ah9NRiHYsXrxuB8oaYWr1HwECs66vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VDvsFgEouCC0WRyVkPsfelna3Unpm6UeHc7W+on50ssIcJ7lJOO7i1r7BSNBfmUB7ZoSCHLCyLaL2kukgQQXTJeUaRZnSNVrxWEB7DdVwmKL9xknEts0EaAfS0Khb3+521z2rcOBDXLms7J8CA8mVdnzWGBOMUGBIOps0peUcEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1VN7bb+; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq2fI9CieChxgHJQsLvxMUKf1qARkEYYwUsooyOPIbqwRYz/HK2Yth64x2oPYfvV9+WqVHDCyD+R25QvRqdLh47Ds2Ish2M6UuaPliCtq6L0dp1HDu0sgdH3rHU0uyJhTmoh261aLOaPma7ULZLbKi42Bh2Qp5ikE4+OtE6n66T4oNP0hxLH4FicwlxpJBSQhzUvkO07h6A4EW3uJ8ef4HRQCzZVYthfY0suWRNJqyjox9bZ+UFpdrbztCA+zNZKO4ycxEhlK9W0nxqcvuT4RUhc3Wie+2NXLo2HN5i90nxVboH0EvKB0HFVtH/xvfv6zJ96vycyxQcmZFmJ+TzOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78AYU0yvEBsKDWNMsxkBNLwTPUJtIXE6TcMcjGbwGEg=;
 b=vzNqym/WPHPyreYXhui3wFFBaXFNgWrfz9KgzVkATFVHQ/jPCu9WbaqbpG5/QemoFHqbu09VealH5gO7ml7NlxCE8PrEIy5xvB92tJ/5tS0RHpZs+ug3RWkgMhUmwcizuW2qpuK+dSc3dAMK4kWHGNHt+8Dafoz87mSUXgL6tyjTl1SzC4WUNRGaXpV5eKqmDUrpgc9lYz48NTKppNW6eEH6oR4ZdG019N0YUOC9RqsieR6XZIDAHakpSw4u+xS5rvQ2Yuun+4MLWYaVaeBuQ+xkzzPXnJSylEEwvdYlS856zr4RMyoKMCHvUVF/x4OaP9XQtltYzpN4YCHCk9ZetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78AYU0yvEBsKDWNMsxkBNLwTPUJtIXE6TcMcjGbwGEg=;
 b=g1VN7bb+OT/JVB2drkQyTKWwdfXU2Bb+DdbVAJZy4UErpVwfR5vamWv3JMUVjoueXtMfq7fdV45Kctkt9ss6iuSvkAhk8lzNFg3LUa1/cw8vNfPYi6BrkFEFkci8t+IgkQmAo+DDEEsp/3HXqM8GwZgA2fOunGYglgacrlTzUFIPYeSiq4P8uDlcMIS9JylFTOiB4Br/yKCIraBP+TOoO9ZuF67WPYa++Da7BCP+H2m7O2t7Iu/yBWLk3tWyejDI57xBR+SJ1pxxkn8Mjl6OUzvzmvLXxuXbGAyzxyERRfDb1jDqlmNni0ogWhRmflyrJc/8XnGcE8ddpBvZ+UXbNQ==
Received: from SN4PR0501CA0071.namprd05.prod.outlook.com
 (2603:10b6:803:41::48) by DM4PR12MB8451.namprd12.prod.outlook.com
 (2603:10b6:8:182::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 01:48:23 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::b3) by SN4PR0501CA0071.outlook.office365.com
 (2603:10b6:803:41::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 01:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 01:48:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 17:48:12 -0800
Received: from [10.19.167.61] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 17:48:10 -0800
Message-ID: <c9b051af-b4c7-49cb-aab5-74450bca7288@nvidia.com>
Date: Thu, 28 Nov 2024 09:48:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-rc] xfrm: replay: Fix the update of
 replay_esn->oseq_hi for GSO
To: Leon Romanovsky <leon@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>
CC: Christian Langrock <christian.langrock@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>
References: <d364e4f9c5f04ed83b777b96e6e1b48f11cb34cf.1731413249.git.leon@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <d364e4f9c5f04ed83b777b96e6e1b48f11cb34cf.1731413249.git.leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1fecb3-e010-4fe5-5100-08dd0f4ebe60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak9VM0lFUURDYUdPWWpNbWFlSHdUQnJ3T1cwdzhtM1A1b3FVZmIwRHg1dUl0?=
 =?utf-8?B?bXdwQVBMYmM4bXhMaktPa2dEOGVMZjJaY0dGanBaVTZXUXgrQk1BMzM0MndZ?=
 =?utf-8?B?WFhOejVKSm1uRldLSmcvaDNuOUMxZlhSVFN4djBHTjM1eXNXdisrTWV2TjJF?=
 =?utf-8?B?RHBHck5LdFdLeHlaWUdTVUVCaERwUVNtU2wvQXhPbVdVV2tXMGpTdVIyL1J1?=
 =?utf-8?B?TWtJL0I0QlptMEo3VEtnZFdMdEw3dnZoa01UNlRhUjk4WGNKd0lyZGpZUCsv?=
 =?utf-8?B?dFlrTGNYenM5NG45MytET1RhOFBpbmhyMEtjTHQwN0ZmOHN5SlY5K0ZsNUw2?=
 =?utf-8?B?YXJxcm1TM21vcUtMbHpIbUxZQ3RlVGtsU3F1bmNNK1V6QUkrRndyRGxNWCtl?=
 =?utf-8?B?Ynlua2dTOEdITEhLempQcVk3MmdzMlpzcUF1cmRBREd5S2lLWkFFWitjRm1R?=
 =?utf-8?B?cDhaT2hCK2ZEVTF5eTMxRkxjWTVCTjBTZ2M5bEM0RFRwWFl2MTB6bVRBQzBT?=
 =?utf-8?B?VUoyK0tpUTQ2aXIwSTUxNjAxcjRhcWVYK09OVVVrNjZZNDdHZkJFYk13WkZ3?=
 =?utf-8?B?Nm90ZndBTjBHN296YkRvUTM4OWpYRytNYzN6c0IvMG96NC92bzVpNHBYTm0x?=
 =?utf-8?B?QmJnWmtFdEpvRGFyYm1ZNjBqY0FqTWlEZWR2NXpWMjlxU2VYdVhCR245NjF1?=
 =?utf-8?B?RVVWZ0Y5T25wcnNiZzlwcGxXRkgwSTZIOFdkbjd1SzV2QVM1SnFweW84djgy?=
 =?utf-8?B?a056R1JSV2xlcGNicTZ4YVc1bnRSczh6OGMyWDJHNHJ0bVBBZEYrSnYranQv?=
 =?utf-8?B?WmJRMXhORE85UzVVb3QxdUZCZnVPa3FwNVZZdGJOa1R1eU9EK2hBMXNxY1Rv?=
 =?utf-8?B?eEQwbEttWG9qVTRubU5td3M4ZmF4TGo5d0RCL1JBNUMvcDVnOFBSaDVSakxs?=
 =?utf-8?B?Y3gxbE9XRm5odTU0emtlNTVXVEUzTnlzU1VIT2VCU3RtbnRHTllWUHBYNUh5?=
 =?utf-8?B?T1FTMTVFYWNRN0lvWndPNldKcGJ5LzZKSHgxV0RFa1o2UEpFSUFmMUI2cnZM?=
 =?utf-8?B?cUtXc1M5blpDQXgxUjB1ZHBrSmUyTU4vdmVaWVZMc1hoazFIVGRlWHdCZ0FW?=
 =?utf-8?B?ejNNV0hhUHRNamYxb042Qk1uUDZ4c3VibFloeTh0dEVTTDFDT1g4WjI5VCtT?=
 =?utf-8?B?aUZmcDJ3aXZjSXJ0WnJXNHZDU0pqYXErZ0FjaW9GZG5ZTHVZV0c3L3pJTzgw?=
 =?utf-8?B?RzlUS3JJck5jMU82cTV3ckxhaXpIaDhQc0RhRk1UdnhRMDhHR3JQblRNbFpY?=
 =?utf-8?B?TlJreC9ZcW94WHVESC9hcS9nOVYxZkR6dXUzSjF1VTdyQmVTQnIrWjRJN0Nr?=
 =?utf-8?B?bFVZR3U2RWJZTFV3SzBFQmFUY082Rk00YXROWFhVQVZzQzFyK2t0TEFqMVli?=
 =?utf-8?B?YWdLVWFnN3pvTWNCcVRYVU9XdnQvZURHUDZaUlM1Q1p2YndLRkphbld3amhJ?=
 =?utf-8?B?aTVhT3FiTFNZYWI5YU5OZnJaODFFcnc4SVBJTXl3MG54Z2prWlpDTllGcDB3?=
 =?utf-8?B?YjJrbGRRWjlsVWxZdTRDSlJlS0IxM3lpOXF4b1NsYU55bFBvd3o1SHp6U0Fi?=
 =?utf-8?B?T3ppald2SXFaKzN6WDRRU0NFbEFrYUFra1luSnNHZnB5UTZlb2NiSjNtOXBv?=
 =?utf-8?B?elh3WDB5Zzh3YlJJN3BuaFErRHVlcWlidkl6UGlpeGNKRkhVcElCbHRtVW95?=
 =?utf-8?B?R0FQUmVmQ3JNbGRSL01ib1FocXVBVlU5RkoyK1hQRzZCM0RCUHNlNkNYTE9Y?=
 =?utf-8?B?c2FBSmtCZnZhK3RnUjJZM1NBUDdmdDNia1dpMnRpVTJIR0hvMGNqelpRSmhU?=
 =?utf-8?B?UU4xbjVCTFgvZ0pKelh0NnpBcS9ibzVSS05DcDl2eEd6WDA2UzY1SnUzODlv?=
 =?utf-8?Q?YBquFsmKJGS0ANe0W4jj0kQoiqw6CG7Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 01:48:23.1233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1fecb3-e010-4fe5-5100-08dd0f4ebe60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451



On 11/12/2024 8:10 PM, Leon Romanovsky wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> When skb needs GSO and wrap around happens, if xo->seq.low (seqno of
> the first skb segment) is before the last seq number but oseq (seqno
> of the last segment) is after it, xo->seq.low is still bigger than
> replay_esn->oseq while oseq is smaller than it, so the update of
> replay_esn->oseq_hi is missed for this case wrap around because of
> the change in the cited commit.
> 
> For example, if sending a packet with gso_segs=3 while old
> replay_esn->oseq=0xfffffffe, we calculate:
>      xo->seq.low = 0xfffffffe + 1 = 0x0xffffffff
>      oseq = 0xfffffffe + 3 = 0x1
> (oseq < replay_esn->oseq) is true, but (xo->seq.low <
> replay_esn->oseq) is false, so replay_esn->oseq_hi is not incremented.
> 
> To fix this issue, change the outer checking back for the update of
> replay_esn->oseq_hi. And add new checking inside for the update of
> packet's oseq_hi.
> 
> Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   net/xfrm/xfrm_replay.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> index bc56c6305725..235bbefc2aba 100644
> --- a/net/xfrm/xfrm_replay.c
> +++ b/net/xfrm/xfrm_replay.c
> @@ -714,10 +714,12 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
>   			oseq += skb_shinfo(skb)->gso_segs;
>   		}
>   
> -		if (unlikely(xo->seq.low < replay_esn->oseq)) {
> -			XFRM_SKB_CB(skb)->seq.output.hi = ++oseq_hi;
> -			xo->seq.hi = oseq_hi;
> -			replay_esn->oseq_hi = oseq_hi;
> +		if (unlikely(oseq < replay_esn->oseq)) {
> +			replay_esn->oseq_hi = ++oseq_hi;
> +			if (xo->seq.low < replay_esn->oseq) {
> +				XFRM_SKB_CB(skb)->seq.output.hi = oseq_hi;
> +				xo->seq.hi = oseq_hi;
> +			}
>   			if (replay_esn->oseq_hi == 0) {
>   				replay_esn->oseq--;
>   				replay_esn->oseq_hi--;

Gentle ping ...

Thanks！
Jianbo

