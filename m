Return-Path: <netdev+bounces-246021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3202CDCD71
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38BD430213C9
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A8D32938C;
	Wed, 24 Dec 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OLb57ekG"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFE328B4C
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766593142; cv=fail; b=TPsPQnJQ3YEqMz/ratzpwVcyl++ZzAkiWM0Pwo7ngtrHpHMBE2GboLwezuizxbqkHxxzUMe4OfyXVm/VSxpV10NA2tfOnONh/peCGn3NnCSEFKhA8t2lsjb30tnGOnfgbC4YTgfvlEfILUGWQrZuQwFVgQtIBDwyb7jMnrcN+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766593142; c=relaxed/simple;
	bh=m9zdF07ApWFa+gIqMyjdsLXKFmecE+UEytKAs96JvuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDmwhqp8XOUv9rM5FPPCBvngz6CUO6BNWKxB0Hqs4+Eu5HADhaQYL+Tt2EoRQp93Xr0ys40jyW/Zpq/P8yJ5R8DT253vqGJtF/jkJORXBGacfr36O0lHWO59vVxPSHh4U34yGXvh/SxDaa+rwZu0U0kvyhDIj2ADSYdmBdDcDYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OLb57ekG; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiW9mk5iTGK8wsdbXgClae1khJqsHoufdGuvak9OFZOOk0sNJPlnkoJm2wXFrZkpnq7QV97UjNxpHou3uGSbRv3MvOncOIldP1quxXoNprorKTV1alExRDENYBZTAifQ9Bz0pescn6rNNazMHsteawYPZWdwnI9OSrqnC1ksny1K2Yhjj0Fu9cR1hQD1rY32kyOLS0gO9mayKSgHME6cExkMC61JulBgR0MY7nI23jyleDU0JjlEuCu08giqexBPxIsuuqTVa42umoTbBtEHW1opY+ovevmcNu/GudvF8/WiIC7ukg7u/a5OXUsqsH6FCnK/2uIvDvOff8N7FfkkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+JxW7FsUJft3N8Td1WI+vRSJbIZnX8OpyoOp9GNOxA=;
 b=E0zMKDjRlQCf7XU6gsK30x5bAKr4L1IGudxxw9/k9b8eT+fFHlMOmqbq8qgK+7ESVKwBrdoICznfnFxK+jg8AozkZAmlLvhDrmnocCD3DPklAhoH/2o3bWdCZUbWSBBUK0EEyb4wlpd+tVYSsgXqBCKaxgyXWIFtXUIES0x4cIT6nmf+7+iKVMXTxjuyml1Oo+trvDW70wpNh37oCe7qjhu4PyjpFy9Od9IrA8QCa85f84cyiE++2YNQgBGbR8rPpyC2/th4z6gLO5RZoKdrhjNQgYF/4qhcxXfvygjm/OVeLyeH1CPfF8OuX+I2mE5hu51VzOVuAktp0P/ArYg51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+JxW7FsUJft3N8Td1WI+vRSJbIZnX8OpyoOp9GNOxA=;
 b=OLb57ekGZpQPGZZlLa6NaKjpBD5P1S9fgeVVySw+tstlVWzTsJsTLHWFFEi4XKYLBnxvX/GirU9ZCC5SNEEERdnB3dpyM1JxOkMoRT/89iFX6iVlncXZtaFS8AI5pEpCynZScMkQXjIcj8S6CD4ALRczuwzVyDpOJN+OL99uxNlnAqFZDDBLYqxuscwHP31lTdz1c6cMQfrcgV8ETPBu22QG+0iW1wfSdlsCa0JNilPhuteUKqbEk6HRt3FK3B0sz9QY0Cu/x0oSRbZ8VaJ4i8p4h39cw5arE7M1lh88gCDA++WM184zwZXCu0dZ4gpnF3W32dxt4lk/tKkNrsGR9A==
Received: from PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::15)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 16:18:47 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::7c) by PH7P221CA0061.outlook.office365.com
 (2603:10b6:510:328::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Wed,
 24 Dec 2025 16:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Wed, 24 Dec 2025 16:18:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Dec
 2025 08:18:39 -0800
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Dec
 2025 08:18:36 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [RFC PATCH net-next 1/2] ipv6: Honor oif when choosing nexthop for locally generated traffic
Date: Wed, 24 Dec 2025 18:18:00 +0200
Message-ID: <20251224161801.824589-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d95d6e1-2824-49d5-a364-08de43081e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t6BMrpaz8xN6qcTyBxic+uJzmLmO073GW12Kz6XILwT5bBORrj+SLGIL0tWm?=
 =?us-ascii?Q?s1m3NHDIOnbBLhk9L/E3FVDlbeLfnCkrm1kLSJPMmlUHJdFffbLHDapKqjyq?=
 =?us-ascii?Q?mU3tHwqABevBnXRsowV5JMBMrylPUhze90ho0VfkftmVQyR9aQvOGPegFwCs?=
 =?us-ascii?Q?Va8iVOLyZpvemkGTaNx+uyLWs0CYNkvznkdxyPcl4rwiezLhnJPWxAxHH8gS?=
 =?us-ascii?Q?KSOO1Jzu545eyspYVKU4KAO6+P9Wxejl0/pFflFr1P1M8D8k4sGE8I9uHPxR?=
 =?us-ascii?Q?BvZ2RI77rAYjlXKRQI1qVKLZ07oYszsKu1ig5gfmt60weBfnWaI2SeIsG4cE?=
 =?us-ascii?Q?hryNAm6M1MMvzOw9W2I6tMmf86xrN8ECiuKek0ZElfyLxJozrFwqUtyiJOvx?=
 =?us-ascii?Q?3+IwBCNskI5k2BUFEvbGi6LGE+AL37kBKlE55Z7Dw02ZyyNYTe1gOd1Vu+pX?=
 =?us-ascii?Q?42dfjY/Pp5wasq0v8sfVdV3Rlcu4Q20wXxrjWa5rzO+JvMRUWe3MqdkRvFVg?=
 =?us-ascii?Q?U7vK9TBKAUKbySfVQoheDQwyVK6NgjM2lHH51I86VneVv4qSTn7eCA4iPv64?=
 =?us-ascii?Q?PrLFfbX9pDlh1NVsb783r2UcRnuC5WThXNXN/4T7FEjbwpbqtFonpuups6Q4?=
 =?us-ascii?Q?3v1dWh5bIErdPn0vQi/jCTa52sK7OU5GFKbWZGGL4kRlgLP4tpNLqWgObpiE?=
 =?us-ascii?Q?qcuESkb1oLa753yr/1ol5qFDd/8vos0OPxUPgEbk1ylnEqq9i6QcQvBIyDKG?=
 =?us-ascii?Q?CUUduaRYFb7uxCQGjNzR4A7YlBwxXehJi4bmcJmgSb529dlEdrZV28NYZKz3?=
 =?us-ascii?Q?/4lNF3xDmetscjGKwjC7zjotHrvzo7z0dK2owkTc3p68W0gsV8GfFCTpzvvC?=
 =?us-ascii?Q?1ECUrKUyy0pYlUaH6P5Qep0jJISxJs/SgkJ6ZDlxzu8rPTDGB7ochmsIIq0L?=
 =?us-ascii?Q?1N5wHsP2BNa73d8YEyCbk+qHYC3sfJ3+EMBorqtxBvFVbfpdy/n4bmfqh6B3?=
 =?us-ascii?Q?uImfGZdIoTq3hEKz35SUtaKN0mh+sKPW6IeT2cIzdTO/fcSpPneLsRg76Wo7?=
 =?us-ascii?Q?vZJb1HQz1+E6fwVgKpCWImHNITIr+Jvb8oPf9zfUSJUacJEfKsr+7AAJRj0X?=
 =?us-ascii?Q?kQMuac96oR+OP2zMOEhrLeQm4QOaBJjeJEgGJO5MUTnmm/AS3spBchnU4CE9?=
 =?us-ascii?Q?cZArYoORLKwx2z2OdFZfC0yooCt9xrUIRotddjLfZtIbPCkhRGQ4Us/UvXvE?=
 =?us-ascii?Q?tRXtu4rEp/sCehjK7Tp9V5mTTfe4MR6vj3TWjHF5rLwS2K98PItpjUBOYEmf?=
 =?us-ascii?Q?31+wYHyUsMcYUXB4LGF/tbt92ImhSqsT3xQSBR/uUHJG3ikbHrwRslN4HG0j?=
 =?us-ascii?Q?VuAUa65BvD33mGufncSmcVqaDJXzXUtCl4aOM1OpsmpUfS1+C6tbUMsxW8Zs?=
 =?us-ascii?Q?sD8W+RUcb00iteJi3RmF5DjIY7t3I+DDS60hRVQS6u4NrK7/qEmFTIljKuVc?=
 =?us-ascii?Q?9q/kXakKAciVbYmgRSo7udusFkY+N2QiJCgCMxtUYLHRmre0Wy0wpKDSwAYS?=
 =?us-ascii?Q?ybR1upeIH+VABYYLbcs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 16:18:47.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d95d6e1-2824-49d5-a364-08de43081e03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

Commit 741a11d9e410 ("net: ipv6: Add RT6_LOOKUP_F_IFACE flag if oif is
set") made the kernel honor the oif parameter when specified as part of
output route lookup:

 # ip route add 2001:db8:1::/64 dev dummy1
 # ip route add ::/0 dev dummy2
 # ip route get 2001:db8:1::1 oif dummy2 fibmatch
 default dev dummy2 metric 1024 pref medium

Due to regression reports, the behavior was partially reverted in commit
d46a9d678e4c ("net: ipv6: Dont add RT6_LOOKUP_F_IFACE flag if saddr
set") to only honor the oif if source address is not specified:

 # ip route get 2001:db8:1::1 from 2001:db8:2::1 oif dummy2 fibmatch
 2001:db8:1::/64 dev dummy1 metric 1024 pref medium

That is, when source address is specified, the kernel will choose the
most specific route even if its nexthop device does not match the
specified oif.

This creates a problem for multipath routes. After looking up a route,
when source address is not specified, the kernel will choose a nexthop
whose nexthop device matches the specified oif:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 2001:db8:10::${i} oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      100 dummy2

But will disregard the oif when source address is specified despite the
fact that a matching nexthop exists:

 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      53 dummy1
      47 dummy2

This behavior differs from IPv4:

 # ip address add 192.0.2.1/32 dev lo
 # ip route add 198.51.100.0/24 nexthop via inet6 fe80::1 dev dummy1 nexthop via inet6 fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 198.51.100.${i} from 192.0.2.1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

What happens is that fib6_table_lookup() returns a route with a matching
nexthop device (assuming it exists):

 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
      100 dummy2

But it is later overwritten during path selection in fib6_select_path()
which instead chooses a nexthop according to the calculated hash.

Solve this by telling fib6_select_path() to skip path selection if we
have an oif match during output route lookup (iif being
LOOPBACK_IFINDEX).

Behavior after the change:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

Note that enabling forwarding is only needed because we did not add
neighbor entries for the gateway addresses. When forwarding is disabled
and CONFIG_IPV6_ROUTER_PREF is not enabled in kernel config, the kernel
will treat non-existing neighbor entries as errors and perform
round-robin between the nexthops:

 # sysctl -wq net.ipv6.conf.all.forwarding=0
 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      50 dummy1
      50 dummy2

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..0795473ecd9b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2254,6 +2254,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 {
 	struct fib6_result res = {};
 	struct rt6_info *rt = NULL;
+	bool have_oif_match;
 	int strict = 0;
 
 	WARN_ON_ONCE((flags & RT6_LOOKUP_F_DST_NOREF) &&
@@ -2270,7 +2271,9 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 	if (res.f6i == net->ipv6.fib6_null_entry)
 		goto out;
 
-	fib6_select_path(net, &res, fl6, oif, false, skb, strict);
+	have_oif_match = fl6->flowi6_iif == LOOPBACK_IFINDEX &&
+			 oif == res.nh->fib_nh_dev->ifindex;
+	fib6_select_path(net, &res, fl6, oif, have_oif_match, skb, strict);
 
 	/*Search through exception table */
 	rt = rt6_find_cached_rt(&res, &fl6->daddr, &fl6->saddr);
-- 
2.52.0


