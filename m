Return-Path: <netdev+bounces-201970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B522EAEBA5F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CD07AA3C2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08D202F67;
	Fri, 27 Jun 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cb9+82/j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FD2E54D5
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035853; cv=fail; b=MxVA8QM5ftnZ43BdBbSZYxuk7WbyyWKyVmC+0JuRIMatmLSwg5UvheN/y6KpQrCZHM72hh+16N3lYVc6y0zUZifToPJFO6jEbIGGKW41YFvk/IyENqvFckpWkNklIDu2YC3qEWzVk/OspJhCFI6SgMMQQxmZ4ohRLn897vQOKM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035853; c=relaxed/simple;
	bh=VlnaeGrPPNVebyxWmc7LVj5bvN2TJXm3HWVSX0iu2+E=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ADx7sdoB/+2t7opdtc2P/NYlBM9gbzSDwLyTRoTnB3bYNJaeJz1oXEhBzJuOaXEAy1PAsZSwHbFldcX/TdECp/7uPUEafbCnPvslbdv0x4UlOYTWubDM13EmJNncSrNtUj8ZyQqU8ZgUhFgK9OowsZ6p7aHjGhRjRycEPwDutbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cb9+82/j; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcopGn6TFh8odDh+VbeMvp+OGLTcKLFx4o+bSueB3u/qvbY2ouVIpGCO6F3YJoulTHAkqdmAWYFNkT3toNBdWjOB9wKak1ZK9ojULl1HZp7yqBEmNmx9OUErzD54UlNm7b3KXOwLILDCIyfPo5ZzjryGkqNhflzEIAZfZXhYJzjjnqJZnLYS2N8CMNUcB72LqFunIepb2i7q1mU6oBzwCv5lo3Mjj2NrLJ4F7Kba22QkcsmpYRHc9bjoG2Er5J16RPvoRE4UvHY43SySNV06ul0fidWVqmZ6YfAuSRw5otl5KzEYbnjjFbrD3Mk9AEBEaWbDQxfNa65YiwxKLnnG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/G8s0WIEj7aXBmh0kvR9Ed058LZpFB04TNdC8WsKcs=;
 b=sLOh/RTBafXIDjyCcDY3pCav7IZDB9N43O7FyyU0MnMXkmEX08rdzxshbn4E2pOvFDdD2HPn42wqFIxO67dI7mr7pUlyOUqjvuZc5G5M1fO3wphOOV2FkTI9yfLIkgRxJBra9I4XmEjWI+t5bgxJfAhynBrYANgc2/HXv1PqeNtu61V0Uj39z2/fCUTxYNbdWy0GTbsVhkwAQu2fdO93OwahUneoEuAASvdkl75UwO7QcV9ym3g6PkVDciJ8Gh8XZLKcuVntAOqSeRK43QFlwHOW/gPAcYauWCZv+RKHJeOhY9q7zG9Gx2qkqDMCd621eHX4dHZk8Uddsnfo+tkaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/G8s0WIEj7aXBmh0kvR9Ed058LZpFB04TNdC8WsKcs=;
 b=Cb9+82/jwt9Rc6IDx10ZYeNA5BhmXn0BAAtSB5BDZ9D9OspjBC2wSDsWt4VA0a0SnTxz/sDUdtYhdvVIymgY6FRCLETkr33nfqBvshi4I1oiX3up6TU01/6LedGLCvuJunechijwXrbAGzxHCUTXcfoD+Ox7eOQwLfwzVs7azKgs4rmd3bgSL726/dVXNelxIflAINBjys/YtIcKjWTP9wytwpu3C2Rw1bglBvbIKEzLJsdYsaldcMNuZSOfCX2OD2i1qNmgY2lVIzKmxKiFm+s92lo4+0FNzG9MEj7AqLAOEpeRax6MZDoDzdZYDMtsu3w+Y+7axtf50OM0SoNYdg==
Received: from DM6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:5:80::30) by
 SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 14:50:43 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::c0) by DM6PR08CA0017.outlook.office365.com
 (2603:10b6:5:80::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 14:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:50:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 07:50:23 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 07:50:16 -0700
References: <20250627114641.3734397-1-edumazet@google.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com>, Petr Machata
	<petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Benjamin Poirier <bpoirier@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: Re: [PATCH net-next] net: ipv4: guard ip_mr_output() with rcu
Date: Fri, 27 Jun 2025 16:48:19 +0200
In-Reply-To: <20250627114641.3734397-1-edumazet@google.com>
Message-ID: <87ikkhkzmp.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 489ea926-e24f-400a-f11c-08ddb589fdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQELhLXMjWxZu9+dh03ydyoOJYrbWCeBNVUhYn14+b7QOyBwAyLObMBLmLQs?=
 =?us-ascii?Q?XQsRB2duqkRaQIAi2fcjUBkxOUWzrL+VH2zlB36k0tk6UFRjm2WRCKlQYq7j?=
 =?us-ascii?Q?z5TYOQfLvZ2OqmEceOBbjwXX2+6CzgR2bKTa1+IzvNjeeGEwSOJWHJvqihuA?=
 =?us-ascii?Q?6lA+bJkgPzdO+ckq7uQw7WnfArVVqK94OmgQdM9D6VFUJ8eR+H72lOW16Okx?=
 =?us-ascii?Q?xBIEE1Zpk09oFi8dfnKchtKRoYBczYXjj71/mJ1jMGNVQoJKdZREOs4Ps9mT?=
 =?us-ascii?Q?Dh5ovaYPMdHDqrVnoP0Wbd4WgZ8qzniU0Ik7a5JsQ00YLuMG1hHD1VrxdYDv?=
 =?us-ascii?Q?IxuGl/SVD55Yiwl3q1800IjROzsyBLc6XPndLcb9xe/JNWV4W+8vlWZ4R8Il?=
 =?us-ascii?Q?WxPdL6O1rK+OnAiuDZMkgIYcnbxFN7dHM3pF90knAk/nabioQC16EMX7rXBu?=
 =?us-ascii?Q?ip5OZDigHEmlkpesVaBBwamli/ptNpi4jQfba+WMc+wltOSES8wb0pcTRWeE?=
 =?us-ascii?Q?UtHcDWyr9njlQku6QCADZF0BngoOse97Aj3AiiEA8LGCStGTE0eRDz477H6L?=
 =?us-ascii?Q?eL4vIAOZ4vyUjS+E2X+ZzwcjVTAWY9CeIz66hOv1yQ69RZFP5Qy6EkrAqfTQ?=
 =?us-ascii?Q?Bkwu3zPeMkmDbWQwn5HgK+JD87UaZmJ0LYV8Q5o7UM/bM6PtZ6lFjeb32rFF?=
 =?us-ascii?Q?D/o3fB0xNHMgps+42m8rTQlSFAlZkBlNIVE4Q0PpKK/Z4Cd7yuHgtT5qZb/w?=
 =?us-ascii?Q?0qbEfket4o9VSxfHEwXBr+Nknz5uhFfAe4EWHHri9HxNx+O9gt4MwYBxBSPQ?=
 =?us-ascii?Q?fA9NhQwrNOOgxY07pNJRVlrMXOXpEIYaOJ+hMcqzyn0oc3KO5swwy7SGTvBf?=
 =?us-ascii?Q?5UmnbVs+qWyBIHR8p8Ca+E3wKQamhGeN7m2AEOiwVk2v46Wdaz/TqwHTorgl?=
 =?us-ascii?Q?DRJh3AQSh147AZZe1Xw8d/m8F0kDOOFxt+WoZPFcL8FxWD316g0oMWhfV0mC?=
 =?us-ascii?Q?6cVfWxmkEToqNAwsYxFdDbKxYNxteJkSq5GT2u5fe34lAdKqIt1eCR/6M2WP?=
 =?us-ascii?Q?PUqk6xwiKDHvk4/MplpPx7H8bKjO2u/QR6YT9TiL6BEEnqGY2zYJOG1yJap5?=
 =?us-ascii?Q?XJEtDi6sGNX7i1WZ0zCfvq0hcpbS4Mcz/4r58CTv7bncHc0u2bUNq2hSQ7Ty?=
 =?us-ascii?Q?7yN+4j8qpY5Xkol96mxwtDqStDoDqPeDP4TJNyocNupw5h4CZJbD+JZgkkgr?=
 =?us-ascii?Q?MbWVvEoia913yaN9n2EhbehPhMQ+2a/K5YcsAFB7zmBDVe0FB6X4uENcUdgY?=
 =?us-ascii?Q?yY5QtBgDk41LQGVQLyTR8sybMi8dnIkDRonZu5cpQZKEfOxZ1dupRevArML2?=
 =?us-ascii?Q?Nv722zzaHaI1GuUbLfJuVTGiYE8RRrUyaLyyr2bety1rXhq25kZ1+hIE1+sY?=
 =?us-ascii?Q?ceCCaP6F1hA2nErwagC3oWHdTPcRSG3s5HDktlondgC3bWGpEutlc+/xC8VC?=
 =?us-ascii?Q?3FzGaAWfykR22HUTG+aM7y7zrhIJ0lxEGIiudA1Je+ImvtLYJ8O3P6NfZQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:50:42.6076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 489ea926-e24f-400a-f11c-08ddb589fdac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061


Eric Dumazet <edumazet@google.com> writes:

> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
>
> Add guard(rcu)() to fix this in a concise way.
>
> WARNING: CPU: 0 PID: 0 at net/ipv4/ipmr.c:2302 ip_mr_output+0xbb1/0xe70 net/ipv4/ipmr.c:2302
> Call Trace:
>  <IRQ>
>   igmp_send_report+0x89e/0xdb0 net/ipv4/igmp.c:799
>  igmp_timer_expire+0x204/0x510 net/ipv4/igmp.c:-1
>   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>   expire_timers kernel/time/timer.c:1798 [inline]
>   __run_timers kernel/time/timer.c:2372 [inline]
>   __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>   run_timer_base kernel/time/timer.c:2393 [inline]
>   run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
>   handle_softirqs+0x286/0x870 kernel/softirq.c:579
>   __do_softirq kernel/softirq.c:613 [inline]
>   invoke_softirq kernel/softirq.c:453 [inline]
>   __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
>
> Fixes: 35bec72a24ac ("net: ipv4: Add ip_mr_output()")
> Reported-by: syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/685e841a.a00a0220.129264.0002.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Benjamin Poirier <bpoirier@nvidia.com>
> Cc: Ido Schimmel <idosch@nvidia.com>

Hmm, reading the cleanup.h doco it calls out mixing goto and guards, but
I think it should work in this case, the guard is function scope, and
the gotos are back to this function scope.

Thanks for the fix!

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  net/ipv4/ipmr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index f78c4e53dc8c161e334781970bbff6069c084ebb..3a2044e6033d5683bda678489f6eaf72ea0b8890 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2299,7 +2299,8 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	struct mr_table *mrt;
>  	int vif;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> +	guard(rcu)();
> +
>  	dev = rt->dst.dev;
>  
>  	if (IPCB(skb)->flags & IPSKB_FORWARDED)
> @@ -2313,7 +2314,6 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	if (IS_ERR(mrt))
>  		goto mc_output;
>  
> -	/* already under rcu_read_lock() */
>  	cache = ipmr_cache_find(mrt, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
>  	if (!cache) {
>  		vif = ipmr_find_vif(mrt, dev);


