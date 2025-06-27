Return-Path: <netdev+bounces-201971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0162AEBA68
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132E617E99D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641B2E719E;
	Fri, 27 Jun 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCUiLNQg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A642E1C78
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035910; cv=fail; b=hzL1vciypKBFrc+qV0ynhYdiieZJyTftdm3W8OpPOt5bURq7vvwwCPqhse4bvva+xTaoVsl5AjVtIQamfzaxRG5A2tfrCTuV1b+NCduq7gyOHjwlrR5GCdoFmIXW08HV7l6NV9yqaVAKs1qyBkNFtayUUtC7YLdLbA+7+/b38C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035910; c=relaxed/simple;
	bh=WQx1UfbKgd61Fael7VNr4CaEN2rqFU/I3CQNWJzyXDo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kcDoXOL9JzCDQxzclv6Gqix2ccOJwZ5XRZNw6fiHrbeAqUwHh/XLdA2Kg27yGJXorH9ZD/FfN26ltPQ/WxOwkgL0twG/QxfRdSCN3KfdpSK+gtub3Yw8o3ok8dr/bAyJLAcicpvF5zWtGPv2/DPsTikZZYAVC4TroT1HDQ3TLHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QCUiLNQg; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vesa1LFPLIuOEQxx3ySFMJzBwCrsKA0CBXOCYLlUPD38IO5AIzmo75B8s3xzOQMog6GibHwQ2A3lACrJqUABHzEYrc4mIU6anO/Cri2/qaaCo6mSmIwLfOWEEGIl/qXq6JSLPe1sW7Od+ECdAXpui9EwatIo17UDMHaekPppGKKfv6ikNMUYiS0VyUg1DgChc8FZNGcmUps6l9j6up9UzXE1ncTGOE7dwfD6YMN0E9CP/N+JAy2rgs922gxkagKXWCi9YnNI1ocf7WO+CfLDRUktZ/FeyoFZu2zI38Y5XiGgUVBLtP+97CK5p/MDfnvrKz3pmZNMpsROSrLjujeklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry92vz6UkoVXLnT7UULZGllZ3PsiRs3mGMVRAWiRmPY=;
 b=m0nuwPDteAJhAwnsgTXHlKQ3Z9wm65JsQRPmIWgqzeyBARbHbwte0+kVjvEu9OXjD9YaW/kx0DILkFYeP9v78jR8rYlF1l4XYMFNjwuZhkQk5/prbYVmc3R4+BJPoKJjUGjUTx1mu4fCQEv+S8LAVfa9yae10URfHmajtiVq6Jrcvl3KAP05aI3zAIwioc8siYzyQPQ3wwSgJrmwseY7kMELJfPJIFNbn01Hq4eBbFzhq/4wq8M4CbAFClJXDMx/U7npkRV9ARK/JCH/0i/W1ElZ2tsQ2SDr0P6IbOEBGNAIsv1NX2mYTmY7B/EfwcxJZKwuXNphif834WrziygvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry92vz6UkoVXLnT7UULZGllZ3PsiRs3mGMVRAWiRmPY=;
 b=QCUiLNQgZ6v1r9beBMHFgYndShQ7jhVc8axlHnrSoAvUUHLm253q4LzBJAnab7p/R1YRmaMPDaRqHP3u+5aM9nAhGiy0R/SnusTU1X1lOCII4mUpJdKjAUxrzSIqPIebF+81uZ+juRoaatTms2u5JGpPmPXOWY58nin7RCapmJfigYNgPOUOnWHaJt6Q4PDfkgG8aSG0YA7PENckDq4PDArB9zAdkQIiblQ89h2Hiv/ZETqJXIRuvydG8oQsNjnUdxeZrYctvSpGMvlEU0fvVpKm9jSZiOOxWSUr1GAWPCC13V9IhoiN6dmUzPw3QaXvKtvJ2fPrXJsh/idk7B109A==
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Fri, 27 Jun
 2025 14:51:45 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::49) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.10 via Frontend Transport; Fri,
 27 Jun 2025 14:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 07:51:26 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 07:51:19 -0700
References: <20250627115822.3741390-1-edumazet@google.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+0141c834e47059395621@syzkaller.appspotmail.com>, Petr Machata
	<petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Benjamin Poirier <bpoirier@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: guard ip6_mr_output() with rcu
Date: Fri, 27 Jun 2025 16:50:59 +0200
In-Reply-To: <20250627115822.3741390-1-edumazet@google.com>
Message-ID: <87ecv5kzks.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 83752db5-047c-448a-5991-08ddb58a232d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7TJUkEb5Rbf9LfSm8s2VFTzeq5rLvJnbGKMXQlT+X/Hke76VhRCw/pTn0SX?=
 =?us-ascii?Q?p450z/GkqnzjRY/nqtLzx2UC4OXO1U392DQFErPJ7CUj0rsPSBGMkQ0lLe2B?=
 =?us-ascii?Q?uPCX9iTQWD59x1hjq0iBorHdGcl+tmsW0ZnFavGWaVAUhvEdg8+NPketBmPh?=
 =?us-ascii?Q?beBcB0ZAiUcmuMYX4U96DegIByLAaVRJgD/GVm+josvFl3ncM7OnWvAINUjr?=
 =?us-ascii?Q?5VV3Qack8EmYnBJN3xQF19IQkfazVKapNiloOvC5kdFF25t1fiZxekj7AcaB?=
 =?us-ascii?Q?fwacXJXFaLQ/DM8DcZtdse7oQ2H5+uVWGyHiZ1ijs6mbRpcvVIM3UL7U/nny?=
 =?us-ascii?Q?yRtIJCyvyB+ev612BlYVGj5F8L+CPvyEWp/hPJImB29veUatlB1n3Z9J2XdD?=
 =?us-ascii?Q?4hbq7FxwFsmlRPscySMfTYDpm3aLGKuFHw70cjmkp+fjeLjWvjmfMqO3EdDH?=
 =?us-ascii?Q?opP6j5titUWHEe5jXipCyeNOXNUYdLG0y5uTwW9OGGGT5M3qOPLRPHytaXgn?=
 =?us-ascii?Q?IH55C4FQjfpNl6r1tp7Y7xsR455IcYfDVwPfcgIs6KjHgphl84Ct+Jby7RIQ?=
 =?us-ascii?Q?5K2s6de3Mq1yXSkdu382hb6cvlX2ZNPtnN04BnFIwn7hfmkRDNQfn/6CwEsW?=
 =?us-ascii?Q?gCaIpktjQUrkKgrHLFTzn/qGrZEDGSvoPozvdNuAIKFBLW3dvE1Sng57bSeU?=
 =?us-ascii?Q?UychKtZbpK+PbIND+HXS6DWemkIXEKF9ld7wJdPTlfUiX7yiQAdGxXCipLjP?=
 =?us-ascii?Q?Yuerwyou/YvAGJ5Ty/5DZ90RmqgL+BhsTy4BQ6/zPBFfWxBCTNvkuDNFAQ76?=
 =?us-ascii?Q?ReQKn1X7JdfuuVFWP1tq5Cyhk+ELL8461l0ti1ok/CiPnRUV0Uhc//TNnfp5?=
 =?us-ascii?Q?ER6MMT8QKpur7ckCxpbKOdme3rbSAWTnp7Qvc7ggI+0ABWcFczip4EurVBw3?=
 =?us-ascii?Q?LskFsMplQJC+7VhyqHxGC0V0XyfsDoy84C7U8V7SMAHqH2O53FFXHEIaPc9v?=
 =?us-ascii?Q?hOm+UItzkh9/y98TmLtIy/uW9THhKymeaEBui2j3pL5yYgBpG/TlB+447WsE?=
 =?us-ascii?Q?9D2tBUPc+OhXlTvsVeijq/cIzlvUB93Q/cqy2e3oGCzIjY+2NRNXRynKESSU?=
 =?us-ascii?Q?CYuYRKu5Np5jvZ7zgpGXFhChpFvRVGdYiyT0wZQQMQAUmJ47+q+dnk0GvsHk?=
 =?us-ascii?Q?ovFWSVXa5gU3rbfnzBh+RNy6DzmKsg9BafCuzo/IfkYo9bzpMqBxBHz0j7TY?=
 =?us-ascii?Q?5sgdqFS8QLEaHonTkXDma0wz1DGDVYcaae4hXZb+TeWdfE5s64Xnd50wV+3r?=
 =?us-ascii?Q?tZIloQtjFooFCO9FZO1FENniYCizU+278HKBHnrPMX0vseEkHgEMmyarFxSh?=
 =?us-ascii?Q?Owy1PInRQnmY+vnwP14M3bueQ6KadTwOKm2YaKutjk0zsCAgx02h3zlX2I59?=
 =?us-ascii?Q?2qYiLIrysRiY0MpfOLXgtN/bmFNfzvPvG35WDZ2xfaGW1ZbhRrQVuZDEhu5H?=
 =?us-ascii?Q?RVPECwtPdqwSpgVjjmi8Fk3+b+5euadNjhIE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:51:45.5852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83752db5-047c-448a-5991-08ddb58a232d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880


Eric Dumazet <edumazet@google.com> writes:

> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
>
> Add guard(rcu)() to fix this in a concise way.
>
> WARNING: net/ipv6/ip6mr.c:2376 at ip6_mr_output+0xe0b/0x1040 net/ipv6/ip6mr.c:2376, CPU#1: kworker/1:2/121
> Call Trace:
>  <TASK>
>   ip6tunnel_xmit include/net/ip6_tunnel.h:162 [inline]
>   udp_tunnel6_xmit_skb+0x640/0xad0 net/ipv6/ip6_udp_tunnel.c:112
>   send6+0x5ac/0x8d0 drivers/net/wireguard/socket.c:152
>   wg_socket_send_skb_to_peer+0x111/0x1d0 drivers/net/wireguard/socket.c:178
>   wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>   wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
>   process_one_work kernel/workqueue.c:3239 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
>   kthread+0x70e/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> Fixes: 96e8f5a9fe2d ("net: ipv6: Add ip6_mr_output()")
> Reported-by: syzbot+0141c834e47059395621@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/685e86b3.a00a0220.129264.0003.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Benjamin Poirier <bpoirier@nvidia.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/ip6mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index a35f4f1c658960e4b087848461f3ea7af653d070..eb6a00262510f1cd6a9d48fab80bdd0d496bb7ee 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -2373,7 +2373,7 @@ int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	int err;
>  	int vif;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> +	guard(rcu)();
>  
>  	if (IP6CB(skb)->flags & IP6SKB_FORWARDED)
>  		goto ip6_output;

Thanks for the fix!

Reviewed-by: Petr Machata <petrm@nvidia.com>

