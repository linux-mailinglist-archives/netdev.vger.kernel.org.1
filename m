Return-Path: <netdev+bounces-233527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27BC14ED6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 129C3507462
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09532ED3A;
	Tue, 28 Oct 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Afytmdmk"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD6328619
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658669; cv=fail; b=oTsX2aREchK/Sqa0bdzVI/JeHT8UzJjzUEh+itDa1XM03HN6ewxdzHbodRDbfNo/WOK2GVptO3SYxjySnertuoDuMiwAOS0dqMSFrvQnu5z+k+aAbSEsFSPaaHz0L8rCALPblQsJ2vgeO55O9ye2VxhPZsCzJN/iLkL2BCVjs7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658669; c=relaxed/simple;
	bh=X1AZqLiCmZrytRoZEZg5a7B0bwzgC9iTxo7TVL3+lAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ejWg9vAn6fzK3S+FLOGtB6Gqjl/T1EIpd+jX6ZolH/MbMH/W5Ywm+Lmaxd2wsECT6X/euQDYqqESqoQrpjW4u6zlNLg1b55YSJ9uDuVZasETDxsHA7zcys6648f8bz7pEX/dDqVhGarw2G+A2OSV0bx/uRE5D0JAPyRlQps5J64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Afytmdmk; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulQfk+8z7UZwE9b812SEUJyriMQdtb+oNbQIg6pmr7ReiOWmyMr3/qwH9cqW1MoDdsdfrM2sWzlYcFX2NHbi2rNtnN5JZggOYmjCwtT3HnKZKM19sZUD/M9hZHQhVEK3xMJk4ogCoL+V5uIknkwXgB+zIBMOM6G8usk3DrmU17p12UXcBsWqiIgPn46rRuFyOexHamoto3TClolvXWhl29jnCZZV5yamiw7mKmSsn29SBsKkrhRE4lOW/AMJv8dbZUw06voJDVtMTjhh21/8WkwmIBaLFtoVQM7LkMkAwW28uPpwwy9oN7xm1nffS3ZyQaKGBrVCqSg538kJosIaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJVhMNhqTwH9hNgDAdNYh2LuNm/0LbSnrNqdg4aoZeY=;
 b=ORuSzcBToLX0nMqXMvdXFZMuYl9G8Lz9YjMFzKPcdWu490vkt/IU+pWVqi5KpRVCOkT3XEMxu/AH7h27Hpt2EJnaWTxMxrV/TTSztcLKqXqnCNWrBA09zKK8g8L02CeuQNmhp4rZYmxODbpl6ParlNqRjXrravAW8w7oSTHCxAIy4/aldiWqfXbykXDvT516YqenFEMNbgD9W07/k7JCD4dlRIzwv39PVFQBP67CWjm8YVYozXFF9f72dEbZqf41y5J/JImj+Ej76qLAF2YHfRe6bYrZaBqvJ+KUinc4rCPZ+u3hATPC3Sc6vzkZSqPRytUmkWQQZyJ9gAshxv+wOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJVhMNhqTwH9hNgDAdNYh2LuNm/0LbSnrNqdg4aoZeY=;
 b=AfytmdmkpXE2n2+wkip0U1g2CpJqrnQJgIzgaNtxsSuYyMK3ZVZO4TtGe05kv+gs/N/IiPezF9Oic/KF9XOEvJrr6HOYX5Gb+xYNRg9ipevxBCcjVQ87yuuTwBaN8G+4B4JBgYSC2F2v0yapGdbzJVvolpFTcgcGwpDeS3aHwcHDLrhisLznztc7LNvy/KmSn3U4t2EWVCaQa8WjQp5Ad681gzgGICYxr0Ds7fNOk9c1Yb2YRfCXr/bWTaYkO1tIdllYLHiXK00veUEsTH9wtfxw9TT+motCRMlIMDBVPmMyNEMVUb5xrUeGLiuZzd+Uz4BWCNhphhh1iWJlTlvz5A==
Received: from SN6PR16CA0070.namprd16.prod.outlook.com (2603:10b6:805:ca::47)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Tue, 28 Oct
 2025 13:37:44 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::f1) by SN6PR16CA0070.outlook.office365.com
 (2603:10b6:805:ca::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 13:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 13:37:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 06:37:23 -0700
Received: from [172.29.252.152] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 06:37:20 -0700
Message-ID: <c1a673ab-0382-445e-aa45-2b8fe2f6bc40@nvidia.com>
Date: Tue, 28 Oct 2025 21:36:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-3-jianbol@nvidia.com> <aQCjCEDvL4VJIsoV@krikkit>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aQCjCEDvL4VJIsoV@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 557903d9-ea4e-4488-887f-08de16272cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTg3NStVd2JVc1ZReE9vYTljbmVkVTFURWg2cnBhNVB2eGI4eG1kMGIwVXlE?=
 =?utf-8?B?SFRxZ0FHV3pvdUE1eDF0ZkN3UFJrNUVySlo4M2hOSUVVcVFFWm42NWllaHo4?=
 =?utf-8?B?M2dRYVFYa2Z6TTcwcDhMTUVMUC8rQUs3U05YR2t6UG1tUVZ6Z1NRbExRQ2RI?=
 =?utf-8?B?aHgvRys5NDZiYXpQSkJaR2ZIS2dDZ3RKbGI5aGg0OXQwOVM3bDliZUxiUDNT?=
 =?utf-8?B?aGRtMzdGMk00dHBueUlzcUdaOHpHL2pneVliTi96Rm5FZE0zbUpZOEFwT3kr?=
 =?utf-8?B?YmQ0c1lwdjZvRG5scFNKNmhaRWdaN01NRmMzRFZWWnF3K1lqQzdTK3p6cnlp?=
 =?utf-8?B?dm5BU2NCeUpiaGZhOG5UeHduRlRGTnBpM0pGcmhzQ01tR3pzU1VPaUhqTXNi?=
 =?utf-8?B?cmR5K0NpRWdLNlB3TzlNUDNmZkVNVXVVZVNKVC8vRWt6d3lMTW1Uc1pSWTVk?=
 =?utf-8?B?cm9QWG90RlVvd3Q4anA3dFFvSWxpUjh6WEQzQVdueVlqUzRuNXF3SDQ1a0Zp?=
 =?utf-8?B?Y3lsdEdBckJYWHpOUERkSDlVekNQVExJWGN6Q3Fyb3Y0eVRlYVhXUm9oTjZF?=
 =?utf-8?B?SW10ZjhvZWtTVFBldVNBRGgvcGQ0NUtMVWZuWDJZRzkwd1B1a2ZYRnJBRi8r?=
 =?utf-8?B?Nm9aM1p2d0dFeUJFUlpPN3g1SmpjTlVJTUZpYkhlaUZoV0IzdkVET253RlVU?=
 =?utf-8?B?ZURDNWVEbXc2S1NUZ2xBSzZWeDl5T0VYelpUalhnN2xZeENjQk1xZ0cyUzA0?=
 =?utf-8?B?QU0yclZCSzZXeTU2RGRpRitUQXdPKy81cUYwVEdxcnNaRXk5VDN5Ny9qWHRp?=
 =?utf-8?B?VjF3SmNnQ2FFT2Y4aWhYMGUybEVDRmVIZ3VvMndvUTNDNGpiS1lrRXlmbWtS?=
 =?utf-8?B?ZEg4RXVwNUYveG9IMGI1RW8waUNvUFhSelk3QU9leXRQVERqUDRMWklCRWhZ?=
 =?utf-8?B?Ymdpd2VuSnA0THl1UHJpc0NHT3RWbDExOHFiT1JPeUNMb2M3NmlDVFA0Uldu?=
 =?utf-8?B?YUE3VVVJeHA1WEl6NmxBSG5OdUl2SnI2aU42VS9SUWN2cXkxMStlU3JqU0J0?=
 =?utf-8?B?RGhqT3RCWmRueDIyR0dHWjdKTDhYYW02dlpTaTdsdEdwZE8xN0dqekttdXB5?=
 =?utf-8?B?c0lDbWNTaVA5Q0NPcFJ0RkY3SE5yR2JUYlA0WnZTQlVNSEpROFA0QVpoajY1?=
 =?utf-8?B?enNvL2EwSThEUDdOcSt3b2FjT2lhV0p1SWxEWGdCKzk2SE56bU1oQkVZUnVx?=
 =?utf-8?B?eFo5VWhjbXA5WURZQnc2V0g2WTVUblVmMG9yV3lDbUhZLzBtVmJHMTl1a0Yx?=
 =?utf-8?B?ZzZvUHlTN21BV25GeUtmN094K2lGQzNZemVCZ0JWWVExdTdteVBGaEVhSndv?=
 =?utf-8?B?b2xwUWs5ME9vbVBxNTFINmhZbFQrVDU1OVRiYWFmOVBIYVJLVjFscnEwZURF?=
 =?utf-8?B?aHliN1lJekthVitCWDBtMURLV3Rxd3dTU2E1YlFoN2pZVWJtcmd5WWlWVkF1?=
 =?utf-8?B?RWUvRmh6Z3RFVHFNcXVCemlyNHVZakd4YTgrdDJQYUg5Tk5ZQjhHdmVKWUxx?=
 =?utf-8?B?b2dxQlI4MHFYaEJoU0ozOHZQczNaU0RTbUd5SjQ1alNUZGkwWVV3M2NlZUtM?=
 =?utf-8?B?bUh4ZWJiQ05kMzUxMGNQNm5uQjZDbEFHelpweGlFRlR0VGxDbFBuL3lIVFdL?=
 =?utf-8?B?RjgvN0FLN1hLSWM5SDNLYzZVb3o2dWhZOVVkYmpxNEE3cmorNVZjNUtiQ1NT?=
 =?utf-8?B?cXB6anpENElCWWlLQjJ4TVYzNHBEeEVyaUYzQ1hJYkp5elFkYVh4YmFIaS84?=
 =?utf-8?B?YmxITWk0WllFUEYwRFc4RGJvTGZjeXR3VWRWdnNpZVl6Nkt5Z3FQY0FTSEor?=
 =?utf-8?B?aUJsMFozdlJ2RklScWg0S2tmRUpxeUlFb3lhVjZDS0NOSkFxNFJBbSs5UHRW?=
 =?utf-8?B?aENTOWxsalU0T0x1VDhoUUtyeXpabjVDdU0vQVRiQXBwZzJRVTFIOGRpMHNV?=
 =?utf-8?B?S3ozUzRXaG5ZTmpyOU80MDVRSmIzWTZEZ29MaXgrbVp2S20rd2o5QVhkK3ZF?=
 =?utf-8?B?ZHBLbklnOHpCR1dlSCt6M0srZmcrekt1NUJxd2lhcTBmZFZFQ3AxRDYzTVZH?=
 =?utf-8?Q?z804=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:37:44.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557903d9-ea4e-4488-887f-08de16272cec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652



On 10/28/2025 7:03 PM, Sabrina Dubroca wrote:
> 2025-10-28, 04:22:48 +0200, Jianbo Liu wrote:
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
>> Instead of replicating the code, this patch modifies the
>> xfrm_ip2inner_mode helper function. It now correctly returns
>> &x->inner_mode if the selector family (x->sel.family) is already
>> specified, thereby handling both specific and AF_UNSPEC cases
>> appropriately.
> 
> (nit: I think this paragraph goes a bit too much into describing the
> changes between versions)
> 
>> With this change, ESP GSO can use xfrm_ip2inner_mode to get the
>> correct inner mode. It doesn't affect existing callers, as the updated
>> logic now mirrors the checks they were already performing externally.
> 
> Sorry, maybe I wasn't clear, but I meant that the callers should also
> be updated to not do the AF_UNSPEC check anymore (note: this will
> cause merge conflicts with your "NULL inner_mode" cleanup patch [1]).
> 
> And I think it would be nicer to split the refactoring into a separate
> patch. So this series would be:
> 
> patch 1: fix xfrm_dev_offload_ok and xfrm_get_inner_ipproto (same as now)
> patch 2: modify xfrm_ip2inner_mode and remove the AF_UNSPEC check and
>           setting inner_mode = &x->inner_mode from all callers
>           [no behavior change, just a refactoring to prepare for patch 3]
> patch 3: use xfrm_ip2inner_mode for GSO (same as your v2 patch 2/2)
> 
> Does that seem ok to you?
> 
> 
> And to avoid the merge conflict with [1], maybe it also makes more
> sense to integrate that clean up in patch 2 from the list above, so
> for ip_vti we'd have:
> 
> diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> index 95b6bb78fcd2..89784976c65e 100644
> --- a/net/ipv4/ip_vti.c
> +++ b/net/ipv4/ip_vti.c
> @@ -118,16 +118,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
>   
>   	x = xfrm_input_state(skb);
>   
> -	inner_mode = &x->inner_mode;
> -
> -	if (x->sel.family == AF_UNSPEC) {
> -		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
> -		if (inner_mode == NULL) {
> -			XFRM_INC_STATS(dev_net(skb->dev),
> -				       LINUX_MIB_XFRMINSTATEMODEERROR);
> -			return -EINVAL;
> -		}
> -	}
> +	inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
>   
>   	family = inner_mode->family;
>   
> 
> 
> Does that sound reasonable?

I have a concern regarding backporting.

Patches 1 and 3 in your proposed structure are bug fixes that should 
ideally go into the ipsec tree and be suitable for stable backports.
Patch 2 should be targeted to ipsec-next as refactoring often does.

If so, patch 3 becomes dependent on a change that won't exist in older 
kernels, making it difficult to backport cleanly.

To maintain backportability for the GSO fix, I'd prefer to keep the 
modification to xfrm_ip2inner_mode within the same patch that fixes the 
GSO code (which is currently my v3 patch 2/2).

My proposed plan is:

Send the patch 1 and patch 3 (including the xfrm_ip2inner_mode change) 
together to the ipsec tree. They are self-contained fixes.

Separately, after those are accepted, I can modify and re-submit that 
patch [1] to ipsec-next that removes the now-redundant checks from the 
other callers (VTI, etc.), leveraging the updated helper function.

This way, the critical fixes are self-contained and backportable, while 
the cleanup of other callers happens later in the development cycle.

> 
> [1] https://lore.kernel.org/netdev/20251027023818.46446-1-jianbol@nvidia.com/
> 


