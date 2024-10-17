Return-Path: <netdev+bounces-136690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7C9A2A4E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AD12832AB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9911E00B3;
	Thu, 17 Oct 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B+L8piVo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681C1DF986
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184673; cv=fail; b=KZG2/bGl+7OncoKgtSch+U+xJFywAQi6tPyIqS11+X8kSYCKAZeIXC16pgKdqt2NYvkJR5i4hwZs/6+76cr7EdfG1BchvpzJbqy0al7Kmkl7ZAHUkkkNZlAKFcTnFbhHmHxMvpfkDdvIakV7aWSuBhp0x/C+HiEeAwa1KrYWwBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184673; c=relaxed/simple;
	bh=WkJVJDunP/6roJ3X04tMbhKtl2wdhCrqWmbJr0i8o2c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RaPuAX6Z4c7gEAbiDS77aw3jgkj4NscbnjMBfAAkCC9eMM+bd6olhFLyQ/q9LHEBavT6qrbYmL/HAOUQtB+eU+7VewWm3oc0blmHoRfAYCKBVPlqh5nhQbGzdZXf9o6lRkKA+5I7ZslDYRW6Nu29MrRLUQ5za1KMLjGpPGOFG+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B+L8piVo; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vz//lVE8vdkkxdZvGlZUrQIjrxEmohw8ZzU4g9/SZ5kSztJDDvN5wqu/X1NnyFU/0EKVvONB5OzSXgddxGIsUZcpUqePpjqjK7gClxdjqGjJleKg5mzuRklNDeRWZPGXRJX94EfHUgpVzjDcbGpOOvQaagxRD6MbgQxvPTGXQISvDLYPrFBill0ZiZV+TA6Bxk9vjXFU0UCp2v+k8cxMavQZqjvrBaz6ByPKcVmBQmxsoEfD8/sRO4ifJf71rC8u2vGjqePu7txZm2TlcYRvh0af2fW+g5A7feIUDvKb4fPyFvqslIPIuv437YpKMUT1iz3sOvQ6MOIR4RP/TrdPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BxCUd3fVMM76A0IxanraLV9R1Byf34nLVC2YqFNy/w=;
 b=k9Z2PsA2rTDOZxIuOk2TuJv0hbdjPzSLOVSi9dWifI0f6vjvP2bT9R7RlO/UsARktV3lUK43XawpZAaciyJfESIsxdYeiUVHI9M8UwbubqyPbieFGKl/22s5WeQxvHmrYkbHCe8AHlfhDbrPqzE2rqe2NFoIzrhSUIPNSIXDPTDDNI4G5bub3TZw21EcG3zzJoMkRspUVNv6Rvneja2aooCJ4+Mc/pud+b4KTOpzRKy734DmJlYvYEl/gpb/dO5qjXEi8chPcssarefmPDU8Fs1JkgNLMt/qcQl+YDZ8liUu81EQsAFVoWy7VCpNeGK58mXZhVuceqIkycA7q+FsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amazon.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BxCUd3fVMM76A0IxanraLV9R1Byf34nLVC2YqFNy/w=;
 b=B+L8piVojq7jS6LVMTbbrpCDWVHRKHLgFlrSOINnda2VBvUw11LwZ+jBHuYMeDbNO4RlnFhMxhAhZKIIj82/Tkc1NZCeKSU7mkWIDnEdTn/hwMIkM3aotEwOuVwkUnGMubgLyAwXw0ScqYJVyrhQN+eSubMUFA9Lbnv1I50p4PVXXjYSIxIvtC+sgUd9HsdaOXJAucKVEa5ivVlY5YxW9cD4pbmXj934sqeVo6dKXRnF+bTxkbfAqtYI4iC2qUJI915Dsasyrl7OoHON5U45pJWRs9mbmjF/KfVEV3indrcfCXMI//bjJOn6zn0xA3RH6XpT53F4aaUmsqhkP3yu9Q==
Received: from CH2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:52::18)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:04:23 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::59) by CH2PR04CA0008.outlook.office365.com
 (2603:10b6:610:52::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 17:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:04:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:04:11 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:04:07 -0700
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
 <20241017070445.4013745-3-gnaaman@drivenets.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Gilad Naaman <gnaaman@drivenets.com>
CC: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 2/6] Define neigh_for_each
Date: Thu, 17 Oct 2024 18:26:28 +0200
In-Reply-To: <20241017070445.4013745-3-gnaaman@drivenets.com>
Message-ID: <87y12mk6f0.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d157b39-d5ff-4134-356f-08dceecdbfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wdTe8TeHWW4Plm1Ld9oNI1aC+4PtgRjNCXut0oemqvOnSlZxK26KQV6AIQCx?=
 =?us-ascii?Q?e9O24rDwfjM2arr3S8noje3GQvIzL1BRdpSbASSIS5AoB/QVXQDUdYljUnBr?=
 =?us-ascii?Q?LsF2KlIjD9wV3CXK4Xlv3L5/lhXbH34xs6P5kQ9gK97roy6Fe2m04oQfwdEA?=
 =?us-ascii?Q?4/w5k/jPHU9kQL+ATmT7s7V0f1jTo5b2SK0nQmZMg6XTqtynCosIanl+en/r?=
 =?us-ascii?Q?FexhJYJAoHKz6N4jnx3Tj+5mMCpr9lbl/dj9xy52uYqFhHWtOujLyF43WnAr?=
 =?us-ascii?Q?kfJc/JaqkGpUAbh9/DF3eFHICFGF1R/KdEh+/e9o/IP7O3wtx/Eqh1rVvYF+?=
 =?us-ascii?Q?NHvLA19bJ4X1ZigyI/dq5Q/l1HHyaaqevPZPtxL1C1CEMoX9YUU0xjYcsxIR?=
 =?us-ascii?Q?e+Vmz6dDVbMPF3ClgRnHfzjjiy+KwmO7DBOQtfzrDHH9JRTxiwoSCNbKWeqv?=
 =?us-ascii?Q?9RKQL8zKAy8UrkazdN/NpXqKUwMOOdNqMwVXj+Q2LPt4Df0hxA6sVTWOfe6G?=
 =?us-ascii?Q?W2XVaJ8ifAmrFcc6+Y3qsXSCNzV/wP/+lMucQg7F06/8bi709lIMkDTYwyBJ?=
 =?us-ascii?Q?viKYNshu1e02fgX3WtOeLLC6aUbxF9SLdtmb6QW6UHhzP7osKL8bsyFMEzUg?=
 =?us-ascii?Q?/PzgwNmqYPCE7RpXPOZA6X2D+3sT8/UlogPdczbuxvB3LDjywxM+Op681n+a?=
 =?us-ascii?Q?MSfRK27cdOi2/1ne/SbHTdliQBiX5ANWX9m/XzUPqySXB+Mz+XOYfkboIwZY?=
 =?us-ascii?Q?hX5pQPtexzKkbEt9y8As33hrRjq+Pm0KIYhErqWAV3ey4AK85lbIdCx00KJw?=
 =?us-ascii?Q?CVgu986LF5LkNlYV8GovtVAOMxDd4rlG0OoX/ncrBNBO2WC9Yq9LrsV/ooLA?=
 =?us-ascii?Q?eqBwD7kVzNDOpJwh1xbgCqiNHJEqil23M/MwdiY1c3db0m1QagfsQSOrLSF2?=
 =?us-ascii?Q?C1bBQTw1WQ/W4fc3kK3ASHrwmLnEPlJQCshDYKF/9BkqKF2uYzAjYaryqUTd?=
 =?us-ascii?Q?Y627mhheduZVG2uobfrrZ8tCYNBd2TGAsGAH3lpGkyNsq7VYsqUX6tRx3JJY?=
 =?us-ascii?Q?8pcGY8vyv94x6DXqmc4zN+hWpRhJ5yM9AKVRUzzYxwMZiYYkIR2y/FcODtGe?=
 =?us-ascii?Q?gAMkhD9cZDS3yI3DD6wSYDlnlQjWC/m5STvHSLy7lZKXOByRFWTfwsTee3Yl?=
 =?us-ascii?Q?8fYoLgVReUUnjnzN/F6j6R310J2KPfSj0pnJwFLsjPu67pCsvUrZ7eopPtvj?=
 =?us-ascii?Q?kYE6cga1cbD3fta5djiOpr41xy+d5yblM3r46rZt3XKCZvaAkOSsi98yAAAt?=
 =?us-ascii?Q?z60i6aDiy0oWUTo0zmR4OEaaowiFxS2efrypdQNc0jO9x7p1gkjcb/FNM5A1?=
 =?us-ascii?Q?WNusGkURqx8V3Jit4qbgC0dee+FXKw68nL8CDrj5E5QgxVLUrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:04:23.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d157b39-d5ff-4134-356f-08dceecdbfd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651


Note about subjects: all your patches should have an appropriate subject
prefix. It looks like it could just be "net: neighbour:" for every patch.

Also giving this patch a subject "define neigh_for_each" is odd, that
function already is defined. Below I argue that reusing the name
neigh_for_each for the new helper is inappropriate. If you accept that,
you can add the helper in a separate patch and convert the open-coded
sites right away, which would be in 2/6. Then 3/6 would be the patch
that moves neigh_for_each to mlxsw and renames. (Though below I also
argue that perhaps it would be better to keep it where it is now.)

Gilad Naaman <gnaaman@drivenets.com> writes:

> Define neigh_for_each in neighbour.h and move old definition
> to its only point of usage within the mlxsw driver.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  .../ethernet/mellanox/mlxsw/spectrum_router.c | 24 +++++++++++++++++--
>  include/net/neighbour.h                       |  4 ++--
>  net/core/neighbour.c                          | 22 -----------------
>  3 files changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> index 800dfb64ec83..de62587c5a63 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> @@ -3006,6 +3006,26 @@ static void mlxsw_sp_neigh_rif_made_sync_each(struct neighbour *n, void *data)
>  		rms->err = -ENOMEM;
>  }
>  
> +static void mlxsw_sp_neigh_for_each(struct neigh_table *tbl,
> +				    void *cookie)

This is still named as if it were a generic walker, but actually it's
hardcoding the mlxsw_sp_neigh_rif_made_sync_each callback. The name
should reflect that.

E.g. mlxsw_sp_neigh_rif_made_sync_neighs.

Then it would also be good to rename mlxsw_sp_neigh_rif_made_sync_each
to mlxsw_sp_neigh_rif_made_sync_neigh as well.

> +{
> +	struct neigh_hash_table *nht;
> +	int chain;
> +
> +	rcu_read_lock();
> +	nht = rcu_dereference(tbl->nht);
> +
> +	read_lock_bh(&tbl->lock); /* avoid resizes */
> +	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
> +		struct neighbour *n;
> +
> +		neigh_for_each(n, &nht->hash_heads[chain])
> +			mlxsw_sp_neigh_rif_made_sync_each(n, cookie);
> +	}
> +	read_unlock_bh(&tbl->lock);
> +	rcu_read_unlock();
> +}
> +

All this stuff looks like it's involved in private details of the
neighbor table implementation that IMHO a client of that module
shouldn't (have to) touch.

I'm not really sure why the function cannot stay where it is, under the
existing name, and the new function is not added under a different name.

Reusing neigh_for_each() seems inappropriate anyway, the name says "for
each neighbor", but in fact you are supposed to wrap it in this loop
over individual heads. Wouldn't it make sense to keep the existing
neigh_for_each(), and add a new helper, neigh_chain_for_each() or
something like that? And OK, call this new helper from neigh_for_each()?

Then this patch doesn't even need to exist.

>  static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
>  					struct mlxsw_sp_rif *rif)
>  {
> @@ -3014,12 +3034,12 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
>  		.rif = rif,
>  	};
>  
> -	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
> +	mlxsw_sp_neigh_for_each(&arp_tbl, &rms);
>  	if (rms.err)
>  		goto err_arp;
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
> +	mlxsw_sp_neigh_for_each(&nd_tbl, &rms);
>  #endif
>  	if (rms.err)
>  		goto err_nd;
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 0402447854c7..37303656ab65 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -277,6 +277,8 @@ static inline void *neighbour_priv(const struct neighbour *n)
>  
>  extern const struct nla_policy nda_policy[];
>  
> +#define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
> +
>  static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
>  {
>  	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
> @@ -390,8 +392,6 @@ static inline struct net *pneigh_net(const struct pneigh_entry *pneigh)
>  }
>  
>  void neigh_app_ns(struct neighbour *n);
> -void neigh_for_each(struct neigh_table *tbl,
> -		    void (*cb)(struct neighbour *, void *), void *cookie);
>  void __neigh_for_each_release(struct neigh_table *tbl,
>  			      int (*cb)(struct neighbour *));
>  int neigh_xmit(int fam, struct net_device *, const void *, struct sk_buff *);
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 45c8df801dfb..d9c458e6f627 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3120,28 +3120,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  	return err;
>  }
>  
> -void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void *), void *cookie)
> -{
> -	int chain;
> -	struct neigh_hash_table *nht;
> -
> -	rcu_read_lock();
> -	nht = rcu_dereference(tbl->nht);
> -
> -	read_lock_bh(&tbl->lock); /* avoid resizes */
> -	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
> -		struct neighbour *n;
> -
> -		for (n = rcu_dereference(nht->hash_buckets[chain]);
> -		     n != NULL;
> -		     n = rcu_dereference(n->next))
> -			cb(n, cookie);
> -	}
> -	read_unlock_bh(&tbl->lock);
> -	rcu_read_unlock();
> -}
> -EXPORT_SYMBOL(neigh_for_each);
> -
>  /* The tbl->lock must be held as a writer and BH disabled. */
>  void __neigh_for_each_release(struct neigh_table *tbl,
>  			      int (*cb)(struct neighbour *))


