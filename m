Return-Path: <netdev+bounces-169006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A60A41FC1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770153B5D66
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61F233724;
	Mon, 24 Feb 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eYu8lXyi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0318B47D
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401425; cv=fail; b=GQcQ7OZ+QJ+QF+8E7GVNQXlGIBhtIY/b7kxYX9pOMPxCKcWiELT+oN0E921QtZ2tKIMWXC8p9aq8YRRxjVpqiOMhjw/9EL1QTS1EN5l2UAUoCfQhC+6+8K3gpOulyzIAq7yJGQNeSwlJc301uEFTDQVR6nFlSTL+98HaiUVCK80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401425; c=relaxed/simple;
	bh=mUySc0Za11l7EE15f7P6U0q0Hy1mSAHchTZVjOmMsaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojTFmp8YlEqfZHKsKQ/Jmp0jQdvgB0UkAKC8B6ITTIIRd+hH9BTVEBwaDjb3lVxXxhV3wGvJYx+pvEf0af8gkkBk8Z6N1JILuAvu/YxlVPCzuLPQxAteR6WlB8MJ4xfJZ9Da2Og+ujNtVuYIHHMg4KGf0bhbREAeFxiyTX264bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eYu8lXyi; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7S7d9WioSiY4j9j9JOMYhfJv7EQvPFnU8IN8HHPBoIyj+cnd+dUapEcZ/IAnQoRDTbSnHeygZrZogBwaeIcBCwwzLL75V1DHVRyfwyAb/ZBl9xcOEOYoCl7CTBFEpFah8nlA4bOifWdhcR+ToUrP3LiEuOMgEyPLCcTrC05BmTzM4KTt7dL0wRomkwjd7lfiYUq7bZ3WB6++5ZgJQF0ugOvFQilV7QdgIWw6caUlRzZaxMQaZUZf7D7iU69XvACWqlQkBp7IjhDBlg7YV0oUwTToGpz9TnIz5w3EqfJ0mgh3hPaCpyWWl2VAV1vkxwoslNTO24hZiwFnXKuOOTAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGS6MSi3O4GrWbUiDy8V8Cm2ln2sMGKGYj5Ami+EM0g=;
 b=XzXYslNYUNUKMp0/Pqg/9lsZX4zQ18i2RvU9s7AjFA9SIxgIXD/Jgo3i1yGMfTPsySBkGNJA/ZUbTd/d7PxFeOTnB8kR6A4vSa/7kp0JSCVUpcsBSxKtRg2gJScpDibaSXrsWNVmnmn3DLJKutr80CIemWBFHYFu9JIGhKlzAug99bvV7dA3jaPYTy6HHa5yIkHvv2UViEqw0EooH7xi89zxecd8DUM8Vu7F/qUnDOWNL8HIXDtBWBwxptJ7/cP1joALuwjSuETRBg75wh1WcxU+IaH3jGdyfzsVIHIw7mJ6cW6HcxorTd75ZjCmZAKKvbxKeI0OtGjyWVjHgre7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGS6MSi3O4GrWbUiDy8V8Cm2ln2sMGKGYj5Ami+EM0g=;
 b=eYu8lXyiZPinJvkqnFsUB+FjkQVJM0ZSzX5d6CmPN6WRwu4Dc4H/XmAVXzzP2rCqi72Wab/mhPn3cDJDE7RvI0I6slMrLOs7tjV3ufuSeYHsndw5QzO4tBakTlisnXP0eXSICiA4QinFpxWr9acPYs012oSub16g40YED9tINaJQ/4F+wKFZARaLwpTGUVEEy5bHG5b7LllaxkNqjtO8fcj1777pFLXB+LxSxH1xaM78GOjT1ztd97p2oQJPndZChJMB+Uv6LQL/M3tgjOkT4unrrwSoAT2+42S0cz5UMVhPNCct5KQuPDeMP9xaSkkp3gxgOT9ed8Jzb6UY3J6DYA==
Received: from BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:50:15 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::f4) by BL0PR05CA0014.outlook.office365.com
 (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Mon,
 24 Feb 2025 12:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 12:50:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 04:50:00 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 04:49:59 -0800
Date: Mon, 24 Feb 2025 14:49:56 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Chiachang Wang <chiachangwang@google.com>
CC: <netdev@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<chiahcangwang@google.com>, <stanleyjhu@google.com>, <yumike@google.com>
Subject: Re: [PATCH ipsec v3 1/1] xfrm: Migrate offload configuration
Message-ID: <20250224124956.GB53094@unreal>
References: <20250224061554.1906002-1-chiachangwang@google.com>
 <20250224061554.1906002-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224061554.1906002-2-chiachangwang@google.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: e4268db7-e147-4c27-47e9-08dd54d1c8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3E5MiktRRvj7+pek/HakWo6E4a2VxvPiAEztxsO8ROMmlCuxDh+4eMxkf9GO?=
 =?us-ascii?Q?td+2C0MI33hcjhn5bmiYZNEtAULBX/DplgNl9yBSqB5OhAicOR2W6FiKhc0n?=
 =?us-ascii?Q?+rtELVHSQbxSMlqm00tRe9XOrmTbEurV7XW4Eqo3ajeb2++FmwrtsJrG4rxC?=
 =?us-ascii?Q?ygZnEjNF8dtNvsNXDuxoX1hD69lBOOKuY9VPBf/bkfEAJ7vH6tXW5GJ0uC6Y?=
 =?us-ascii?Q?TU4AWyr/DGRZilsCP6EWjzQdsUnhKuKk+dwDQ+b0NM88KKYEmWNj/DVR+YrX?=
 =?us-ascii?Q?c/5zS+zFhNXEuCBKL2N8KmQPaziYRrgRu//bMi6TmUNfdKDndd7G8/q8FBcI?=
 =?us-ascii?Q?jA+rjbrj3dvpQCBN5O5VyQTcKW6j3esvaVMEl2Ae7E0ooao3yHld6iHKa92f?=
 =?us-ascii?Q?yPfpZljqeaJnT3oiTFbrP4hHl9++ys8EZ+xLQ28zL1mAAdKVKkN6f7+xKIB1?=
 =?us-ascii?Q?iX4Hbdpv8Wv8Im4ubPvjsDAx3KatB9iqv7PUvp2ssqWj3LdZwv11x2vQDueG?=
 =?us-ascii?Q?TJWp0YCCYaclEVlJbjdCBB5LJAqR3Xhs8RAcA6RPfZXEf7+WU300TxgOyJXt?=
 =?us-ascii?Q?/BP32dud0CzJBS+NeK86tt2fBS5d1qPuiR2vvofSssEt7d3cosupTjeeiKah?=
 =?us-ascii?Q?+y8Shz/u64reaAmYhEfaEz770ApEmdWXglNt22EVdZhKQ0vYQNrPHzlEhThC?=
 =?us-ascii?Q?3ab6HZ1NTbe4IQMOS4od/yp4SIf2KxmVZcKr1CQIuWG/jAWDp8zFsnwKJTlK?=
 =?us-ascii?Q?vWF9Zd2pG3EjkeYPFII2krEG01JYq3epFxTu4YuO1Ou7fHJAwY3TrUywogQe?=
 =?us-ascii?Q?Gu7mUW6pUuVs2sCLgn3W13NoY8MucP03zlNiwWCN9clqB7OGQxlaht+KHHj1?=
 =?us-ascii?Q?U2eoqQTQinjdaffp+/BrrTs+S1IHuAVSD1ITlR0oWBGyU71S1C2y0CkCkkBv?=
 =?us-ascii?Q?YG9cqYF8ZWqz/UNaZrHYB2s6wj3tYzH0pogWpt0LAr9NMzq0kPdySTHa4/9z?=
 =?us-ascii?Q?9U+SNA8BYAnBpe3LaA7Q2jBwlp4zUz1gF1naKI0WFrmLf1y/y+gmDUt+ebe9?=
 =?us-ascii?Q?uvh6LrdR0no5QpPD2yix+7jXUVRJG470OgLQSbx7b83y46K6rb5oMn9DnMM5?=
 =?us-ascii?Q?wjTj19lnFOH/+YRlURkreYwU5yQxp+Q0O0Jze0fgt+IdRnRozu1qqAhlTmh/?=
 =?us-ascii?Q?G8T2CC7e60g3ISOkSYQ6VgDmeenKK+BJ2s2Hum7Td61IZRqNGre8iGaFFB8o?=
 =?us-ascii?Q?qUkkkxPgM3byx1QVaDlWj04xDIAFRsMwqeaiHvrKq1XuwHdElcTC0SqDkQf6?=
 =?us-ascii?Q?Py3CEzbJe6ECMxVp2brKJ77nZWv7t+TobCHDA46I35yGAdrxPMTSV/KM1gIF?=
 =?us-ascii?Q?SRsvHifQFbENBIV9n7AWoYLhYXjAcarZpCdCA1xOAgBW6dSOPUe4kej4NQsd?=
 =?us-ascii?Q?cuCfAon4lRcMhs6rl9rAhKnRVx76Xj+0E4ytpKB+WFvy7CX0aLUN2sluH3cn?=
 =?us-ascii?Q?qp+DPd+7ASS1k5o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:50:14.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4268db7-e147-4c27-47e9-08dd54d1c8ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

On Mon, Feb 24, 2025 at 06:15:54AM +0000, Chiachang Wang wrote:
> Add hardware offload configuration to XFRM_MSG_MIGRATE
> using an option netlink attribute XFRMA_OFFLOAD_DEV.
> 
> In the existing xfrm_state_migrate(), the xfrm_init_state()
> is called assuming no hardware offload by default. Even the
> original xfrm_state is configured with offload, the setting will
> be reset. If the device is configured with hardware offload,
> it's reasonable to allow the device to maintain its hardware
> offload mode. But the device will end up with offload disabled
> after receiving a migration event when the device migrates the
> connection from one netdev to another one.
> 
> The devices that support migration may work with different
> underlying networks, such as mobile devices. The hardware setting
> should be forwarded to the different netdev based on the
> migration configuration. This change provides the capability
> for user space to migrate from one netdev to another.
> 
> Test: Tested with kernel test in the Android tree located
>       in https://android.googlesource.com/kernel/tests/
>       The xfrm_tunnel_test.py under the tests folder in
>       particular.
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
> 
> v2 -> v3:
> - Modify af_key to fix kbuild error
> v1 -> v2:
> - Address review feedback to correct the logic in the
>   xfrm_state_migrate in the migration offload configuration
>   change.
> - Revise the commit message for "xfrm: Migrate offload configuration"
> ---
>  include/net/xfrm.h     |  8 ++++++--
>  net/key/af_key.c       |  2 +-
>  net/xfrm/xfrm_policy.c |  4 ++--
>  net/xfrm/xfrm_state.c  | 14 +++++++++++---
>  net/xfrm/xfrm_user.c   | 15 +++++++++++++--
>  5 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index ed4b83696c77..9e916d812af7 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1876,12 +1876,16 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
>  						u32 if_id);
>  struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
>  				      struct xfrm_migrate *m,
> -				      struct xfrm_encap_tmpl *encap);
> +				      struct xfrm_encap_tmpl *encap,
> +				      struct net *net,
> +				      struct xfrm_user_offload *xuo,
> +				      struct netlink_ext_ack *extack);
>  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		 struct xfrm_migrate *m, int num_bundles,
>  		 struct xfrm_kmaddress *k, struct net *net,
>  		 struct xfrm_encap_tmpl *encap, u32 if_id,
> -		 struct netlink_ext_ack *extack);
> +		 struct netlink_ext_ack *extack,
> +		 struct xfrm_user_offload *xuo);
>  #endif
> 
>  int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, __be16 sport);
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index c56bb4f451e6..efc2a91f4c48 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -2630,7 +2630,7 @@ static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
>  	}
> 
>  	return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
> -			    kma ? &k : NULL, net, NULL, 0, NULL);
> +			    kma ? &k : NULL, net, NULL, 0, NULL, NULL);
> 
>   out:
>  	return err;
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 6551e588fe52..82f755e39110 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4630,7 +4630,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		 struct xfrm_migrate *m, int num_migrate,
>  		 struct xfrm_kmaddress *k, struct net *net,
>  		 struct xfrm_encap_tmpl *encap, u32 if_id,
> -		 struct netlink_ext_ack *extack)
> +		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
>  {
>  	int i, err, nx_cur = 0, nx_new = 0;
>  	struct xfrm_policy *pol = NULL;
> @@ -4663,7 +4663,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
>  			x_cur[nx_cur] = x;
>  			nx_cur++;
> -			xc = xfrm_state_migrate(x, mp, encap);
> +			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
>  			if (xc) {
>  				x_new[nx_new] = xc;
>  				nx_new++;
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index ad2202fa82f3..0b5f7e90f4f3 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2122,22 +2122,30 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
> 
>  struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
>  				      struct xfrm_migrate *m,
> -				      struct xfrm_encap_tmpl *encap)
> +				      struct xfrm_encap_tmpl *encap,
> +				      struct net *net,
> +				      struct xfrm_user_offload *xuo,
> +				      struct netlink_ext_ack *extack)
>  {
>  	struct xfrm_state *xc;
> -
> +	bool offload = (xuo);

There is no need in extra variable, rely on validity of pointer.

>  	xc = xfrm_state_clone(x, encap);
>  	if (!xc)
>  		return NULL;
> 
>  	xc->props.family = m->new_family;
> 
> -	if (xfrm_init_state(xc) < 0)
> +	if (__xfrm_init_state(xc, true, offload, NULL) < 0)
>  		goto error;

Please rebase this patch on top of https://lore.kernel.org/netdev/cover.1739972570.git.leon@kernel.org/
The __xfrm_init_state() was changed there. You can use xfrm_init_state()
instead.

> 
> +	x->km.state = XFRM_STATE_VALID;
>  	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
>  	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

It should be placed inside xfrm_state_clone() and worth to rename it.

> 
> +	/* configure the hardware if offload is requested */
> +	if (offload && xfrm_dev_state_add(net, xc, xuo, extack))
> +		goto error;
> +
>  	/* add state */
>  	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
>  		/* a care is needed when the destination address of the
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 5877eabe9d95..4c2c74078e65 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3069,6 +3069,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	int n = 0;
>  	struct net *net = sock_net(skb->sk);
>  	struct xfrm_encap_tmpl  *encap = NULL;
> +	struct xfrm_user_offload *xuo = NULL;
>  	u32 if_id = 0;
> 
>  	if (!attrs[XFRMA_MIGRATE]) {
> @@ -3099,11 +3100,21 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (attrs[XFRMA_IF_ID])
>  		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
> 
> +	if (attrs[XFRMA_OFFLOAD_DEV]) {
> +		xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> +			      sizeof(*xuo), GFP_KERNEL);
> +		if (!xuo) {
> +			err = -ENOMEM;
> +			goto error;
> +		}
> +	}
> +
>  	err = xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, encap,
> -			   if_id, extack);
> +			   if_id, extack, xuo);
> 
> +error:
>  	kfree(encap);
> -
> +	kfree(xuo);
>  	return err;
>  }
>  #else
> --
> 2.48.1.601.g30ceb7b040-goog
> 
> 

