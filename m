Return-Path: <netdev+bounces-218621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D4AB3DA4B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B233BA704
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36524DCF7;
	Mon,  1 Sep 2025 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJ7AAG4p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E57259CA0
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 06:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709565; cv=fail; b=UvK4OS/LeyjD4SGsUyZlCxSY0RemNtxE7XUroX3tm7mH4k4a+YoqYqAIyrYcm0ODExZPk3wsMR0mEJfhGT2+I3HYbq/NWPzwa9AuYJS4astpw0UodJXcPr6VE2OAzed8gAkUTX+ixfPawFxqNeVwChpdaY1MFnn9pUdWVKxM0Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709565; c=relaxed/simple;
	bh=DaARqtQZJt9WF/Uv7GKCbD5fs6jIo/TMKn6zr6yQdwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLKE7sHTWF6Y5pF8CvC2xqnA/dyBB3JNlNKXcPxCS5MK5rrSIkHMMO4Q2VVh/+7b40rWwUnXCHZiwQPgYJ2H9qfGb4k0qx0INTEMZgIpjLduaVMAOfSULwJwxKYZ+vVzYsJAxXvt2WtD47NW1RjaTRSKqabWsWn/erGbPOVarsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJ7AAG4p; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBHizvgEo3RRETMZO56uluDomfwYjygOPHDDze7abjbuKR4k3J101tzw2p7SDBeQR3fAoK2uLXrwXsC6mPjW4Apr1NJK4MLSnxj4WxzzAnBg8pXREWyGXjpzPUkNnsYJ/XpOXEs2UlyWxD2jPbit/MD8xBNDv0G+QG/AJncwOFg7+JjckhlehJYeOBTVUvNG2IADGp6W9R3lLhddBgJ5iSEatmIspYEXzwyks0biHM/6br+jjmoQYLtPypsf37NcnjKgA++De2E2BmRtznDtl4LEMfWoLSJ28N5RxsrEStSS3KDITjm3X8P8i4REHOy53/wHYWi/Fqy89ckhQSEEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSkPKDcdVPmGv6S6e8R0Sp2iv9AMgHg5Sqgvo9pjea4=;
 b=wkhqBIRgWXHBqwlte1Rzj64L7hO/WQoSZqu8u4BH+lXsSyiuou/GiS7lIVEc3oMtQqkhhDGHfCJSotPE7loGA6D0ptiz8JGs0wzWGSN+HPoFy/5sD0yTowN62KyLA8UcYD+fS9dQXIhHc4U1gV/cnODNpxgRwp5OrjwEEvUjxpmpb1eZUezisBu6EfLcJbOMseFU9JXFunG/5T1P2HcDG4NgrwuWeUhIIGfoeJnvNto70P5h5sPa7v709p3jZpuA8VALesriVH7c2AsjgRg6XCcww6ws+r7aujSrQximXq6qQIIgkYwq7aeMw35Jewt02uI3H7tnxkqEce/Lml09oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSkPKDcdVPmGv6S6e8R0Sp2iv9AMgHg5Sqgvo9pjea4=;
 b=tJ7AAG4pBcppXY9s6ZHZ4rRNOrDbAJyJ8h+fW9AV5bM/zWvsgwPZINl12qs6ofR62+ossZWz7YljD/7j58+S5AM34KLVYtXaaFwaaD+IuBcWarB2PokHeEJcOawi+ydxp2JMzcS44pC0VWJ9zWIugoHu6k3vbsSFC1cgFinUB3Ec+YivN9mrpZO6Ulg4MP+FswKTR9cvqbtw8PPzbCuE2r/YskgFBPwTu9HQe4uPyEBSESkZBt8anAytjyFnXah9Hiw4eodV1KdFru/qFgwlQNdJzA53EWf8tp4fEvjYZKOqhKMe1Nz482sjvzG0Rw2yodLlhiQtl7NqX+9H8VPLug==
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 06:52:38 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::b7) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 06:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 06:52:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:20 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:17 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<razor@blackwall.org>, <petrm@nvidia.com>, <mcremers@cloudbear.nl>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net 2/3] vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects
Date: Mon, 1 Sep 2025 09:50:34 +0300
Message-ID: <20250901065035.159644-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901065035.159644-1-idosch@nvidia.com>
References: <20250901065035.159644-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3f6b58-beb8-49ea-c85f-08dde92423c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Ybh4UXojL2xYE025E2bAQMUr1r7RfcwdgaJM5ZKurvGmiEjH4Q89Um6WT1n?=
 =?us-ascii?Q?liquDINPiA5Df1LB81/JcZsoVOZ+21kYxwF01+f49yh+E78qobLhI5G/xY3L?=
 =?us-ascii?Q?wecHhMKCDntV4hTINJnfHn0NNZADIBLLNiR4lL8bK3G4Aonhxj4HyHyewjEj?=
 =?us-ascii?Q?/u3TzdGfUfl7FZB4/QDZg+XRiH6iY5kyrqeC22Mo0gPVxlZ4KZDhhpw1qM2B?=
 =?us-ascii?Q?kqu8oVl7ilE+Ajj0+v6PhcVqm4c33/LcLy32W8FJYHNcEFINN9UnJNfo8t8+?=
 =?us-ascii?Q?YUqRAY2E+sFLkMk63EoobgpautMHRns4a82w9p7jUGm7y+xAL2h4zwIG2Up4?=
 =?us-ascii?Q?efKGS8y4r4ncVl+0z4BEM8P1mlvf+HzAy3ul1X077yR83C9z5NR33fMPNMD4?=
 =?us-ascii?Q?p/JTQnOMxAnZZffb6Bz3FuGEJzDDZrOKoo6viwF6kepFCJFiP+6IAMUoqITS?=
 =?us-ascii?Q?pqFCxa0vo+WTYTI7CpbJ5JyYXiHc12dNT5h4K+0BkLjQvchMncXrdccubbvW?=
 =?us-ascii?Q?7+semr0oW00kfTM7eL/3/xiubCeflU/nafvYF4WfkgTdxzWXarh5jeh6xB/e?=
 =?us-ascii?Q?XxcQ5q8gfQgky/101+bti7jCkUOjw/vwaNgTBUXZ4dYBqYves9b8MYdVGQv5?=
 =?us-ascii?Q?oQCnLdgeKEWQl78zdm9hZ+50xzR5kJODZsqUMKRolx674Z9d9lP1rKqYTBnJ?=
 =?us-ascii?Q?cZ/dBNCSEKvtEaB/yhORlHMYhMzBf9NRBU4B124/PKWR+LUVdG4ahvamfjG2?=
 =?us-ascii?Q?Tu5pvGaIeU27pLFMnGlaRG0MVvdbLsxZxfNCnDFbQY5B5Hdu8o85CxP8ir54?=
 =?us-ascii?Q?Xi/Gf0zzCAY8o4Ysf9Epe5Ulcf8kCTBeQXOoF/51WvSQKU3GRjpQWYW8rmGe?=
 =?us-ascii?Q?gwcIsXNW/cyW5GQTekFuue8HfDXZygGuW2dFBcfxE4QdxWYJ4dpLSwWpetJl?=
 =?us-ascii?Q?iDhx2yxNA6BMYEVY7GDLpPnFoiXghdokLwi+N1TeGaffIDM6hFKIuUymhwCq?=
 =?us-ascii?Q?kSCWb8rAl7bzp2F7DP9aQ2cJ+jkhPMb6QiB9tfWVAufS7pBNzmiy9VcVMc0J?=
 =?us-ascii?Q?jjAsZwTGGBEiCeiT07kR7uTR/Zir0LunoUskRYqv1fdZsm9LXsogLMajJcb2?=
 =?us-ascii?Q?NLvoPwck6zTM0sZXkV6sDYa3d2J+FIP6ytIZkwAHb3FdKu6HKNyrmJnhjyac?=
 =?us-ascii?Q?u2rr8Z3VPD0//0/gk+Rr5P1RmJ8oNfPSYWeiEXNkZXFguHjB1ELsHgGzyc0b?=
 =?us-ascii?Q?rAj57E3//q0bhFfkyFoQzxOu6bPjzpbZf6AF5+BDbLsUTgBmbrE6qilPhSZD?=
 =?us-ascii?Q?VZrlEJzil3Rg2mw6mEZQ3DyAFnU7u4zsjrH2zuU3tMr2TCH84sJZMkxMM4pq?=
 =?us-ascii?Q?cP9vjjM/ncLhWxsPT9hL17/0Sfw0PZyEvduQKtyDhEaZT4Z4LGZLaGuN3u89?=
 =?us-ascii?Q?Dwnrd/oAaZ7E48bkIz0OqO26FYOHSmbC/Z2tkki4QVTy5jI4xxz/NOaY63IO?=
 =?us-ascii?Q?JAXiW5NBghGCEylHmRPsGjTyr8xnLJ/vApDg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:52:38.3163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3f6b58-beb8-49ea-c85f-08dde92423c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

When the "proxy" option is enabled on a VXLAN device, the device will
suppress ARP requests and IPv6 Neighbor Solicitation messages if it is
able to reply on behalf of the remote host. That is, if a matching and
valid neighbor entry is configured on the VXLAN device whose MAC address
is not behind the "any" remote (0.0.0.0 / ::).

The code currently assumes that the FDB entry for the neighbor's MAC
address points to a valid remote destination, but this is incorrect if
the entry is associated with an FDB nexthop group. This can result in a
NPD [1][3] which can be reproduced using [2][4].

Fix by checking that the remote destination exists before dereferencing
it.

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
CPU: 4 UID: 0 PID: 365 Comm: arping Not tainted 6.17.0-rc2-virtme-g2a89cb21162c #2 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
RIP: 0010:vxlan_xmit+0xb58/0x15f0
[...]
Call Trace:
 <TASK>
 dev_hard_start_xmit+0x5d/0x1c0
 __dev_queue_xmit+0x246/0xfd0
 packet_sendmsg+0x113a/0x1850
 __sock_sendmsg+0x38/0x70
 __sys_sendto+0x126/0x180
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
 #!/bin/bash

 ip address add 192.0.2.1/32 dev lo

 ip nexthop add id 1 via 192.0.2.2 fdb
 ip nexthop add id 10 group 1 fdb

 ip link add name vx0 up type vxlan id 10010 local 192.0.2.1 dstport 4789 proxy

 ip neigh add 192.0.2.3 lladdr 00:11:22:33:44:55 nud perm dev vx0

 bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 10

 arping -b -c 1 -s 192.0.2.1 -I vx0 192.0.2.3

[3]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
CPU: 13 UID: 0 PID: 372 Comm: ndisc6 Not tainted 6.17.0-rc2-virtmne-g6ee90cb26014 #3 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1v996), BIOS 1.17.0-4.fc41 04/01/2x014
RIP: 0010:vxlan_xmit+0x803/0x1600
[...]
Call Trace:
 <TASK>
 dev_hard_start_xmit+0x5d/0x1c0
 __dev_queue_xmit+0x246/0xfd0
 ip6_finish_output2+0x210/0x6c0
 ip6_finish_output+0x1af/0x2b0
 ip6_mr_output+0x92/0x3e0
 ip6_send_skb+0x30/0x90
 rawv6_sendmsg+0xe6e/0x12e0
 __sock_sendmsg+0x38/0x70
 __sys_sendto+0x126/0x180
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f383422ec77

[4]
 #!/bin/bash

 ip address add 2001:db8:1::1/128 dev lo

 ip nexthop add id 1 via 2001:db8:1::1 fdb
 ip nexthop add id 10 group 1 fdb

 ip link add name vx0 up type vxlan id 10010 local 2001:db8:1::1 dstport 4789 proxy

 ip neigh add 2001:db8:1::3 lladdr 00:11:22:33:44:55 nud perm dev vx0

 bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 10

 ndisc6 -r 1 -s 2001:db8:1::1 -w 1 2001:db8:1::3 vx0

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0f6a7c89a669..dab864bc733c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1877,6 +1877,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	n = neigh_lookup(&arp_tbl, &tip, dev);
 
 	if (n) {
+		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
 
@@ -1887,7 +1888,9 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 		rcu_read_lock();
 		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+		if (f)
+			rdst = first_remote_rcu(f);
+		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
 			/* bridge-local neighbor */
 			neigh_release(n);
 			rcu_read_unlock();
@@ -2044,6 +2047,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
 
 	if (n) {
+		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
 
@@ -2053,7 +2057,9 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		}
 
 		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+		if (f)
+			rdst = first_remote_rcu(f);
+		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
 			/* bridge-local neighbor */
 			neigh_release(n);
 			goto out;
-- 
2.51.0


