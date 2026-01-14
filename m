Return-Path: <netdev+bounces-249777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B03D1DBEE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEC103000B55
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53837F730;
	Wed, 14 Jan 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIrNIqME"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD935E54F
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384569; cv=fail; b=i0j4z8qocWRsNZD64sG6qLS9zijPS0lZrjOvCvLMovjJfD4SXBcIgSdDyOyoN8zZpybBXhoujkAeMViDl7yG9/oTjDS6KGNWojy6KwlpZh+FjQsuelqwZ+Wr8AMM2Q5vb84ODGYD16Xs4i/Gq8qqqHGdpaZRebogddZ3FThfjFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384569; c=relaxed/simple;
	bh=9HxtiisXAzNKzi69P3SzxfB+c4wL5O0rJXX89BLO2cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZTQp72NckFZt7iEvtxHcoT8100cdDbsgoFmMMNt+GNWDyqUuJL+QSfCjx4t+/FDJVbM8F7ymq1uPj4YYHn44OlSkpC6YSsUCD3/A9TctOD/uktLFId7IsVHESNxBzHfiOsI3xP/yKXy1eQvq/y9tkqQmxix99ksGCvMbBC/f4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIrNIqME; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6uy4uYk/md6hKOMlMr4OgRxlEEe3cp9A4YbsiK1dYGJS1BioT5x0Rwt93GBSp1tcKExee6sYNZ5KfyHMyp5RQWNcEOmBgRHXIlcdEReHNHU123EdTzDAg9MFwKrJ1f+FMz2ZgXCFYLaMzZcYZcx3a/0A5xQWOveHDH+eSJQbqPz6JqXw7sGqUa4ovCvmn8y7m9aZd74JkRmdWirnxyU5waAfy1ItzGVATsUF4RSJNwPOHdA9a+s6oaYG9AfAqfZQoIOW0+dRzSy86aXHOArfsbv5qpFneeLhLoUX93O+2BMrHgv70BCF92BWqo3DD0YuHlVJ2BqmgA9OfcCKtVg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx0jMxVXoCyNOgCwb1WluGemG+j8ch86WG6874E+j2s=;
 b=BvfUfHF28X7jjALTHJ4nOlRaZ6/HymEWRywF6OXmYDmkJ/EheqghvqTNx3hiYtokjQd3kF/9LQmL7B5DsTZurZrwe1IVleoxMy9x+IIqM3nGDjp1AoA4gHEiH0qrM3WOT1XN+rlijlZXGMRn3VS2H+epxxfWiiXTlIHCXC0gytcPpP1luO49Jp5uial2K4enUJZ1m7YBlwdm/qEiff947DDr8PnvoNafnVC1dQn077wStAujwrXQrnezYE1h5Gi1BJOsqFxApG1gV9xRv7Hw4vXli5NXgDyhHGlAmUT+FDjhD8bFRsolRCrSXL9680RZVT3fSQh+cZtRbQnbFN/HFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx0jMxVXoCyNOgCwb1WluGemG+j8ch86WG6874E+j2s=;
 b=nIrNIqMEbryUk+p366nhNY364FRSYgz58oK1JgWEvBJJ0G17m3e2ID0yg2Ai5mi6sra+CjN/jpB5DrWZzJWFsnYImVvpxHvOyRB8TiwuvYTjpmSiy8Pkl9cGXBRzh1EJo4/HgiLfVI7dhg1zQsd4fBlvBCy87QANQ5OrCig4rOi+rq2ZzohM65GGvzCDEAxppq0ZuG6x/dVI5RJHAcDBKINoGD2GXqgzBSFjtBryessQdXH5OEfMmuOuCjUBtnvHjO+QQO/RWthEPtcQYhZMJ1+R5PBqzFBDhg9sDdga2arRDSJgoaJmTSAmEZw6Kprxs8BAybIXIaFbfY7uBxBRHA==
Received: from PH8PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:2cf::23)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 09:56:03 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::25) by PH8PR07CA0028.outlook.office365.com
 (2603:10b6:510:2cf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:55:44 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:55:38 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 2/8] net: core: neighbour: Call __neigh_notify() under a lock
Date: Wed, 14 Jan 2026 10:54:45 +0100
Message-ID: <d440f35aab4aadb49dabc086e45f865cf0eeaa5e.1768225160.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768225160.git.petrm@nvidia.com>
References: <cover.1768225160.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: e7963d0c-332f-412b-0ed5-08de5353209f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbxYRn3mR/kx2i13QK410q92+hJ9P/j01QrrOvhsVUew5tw4L3bMhqdm10Q7?=
 =?us-ascii?Q?a+j5EQZEv0nW/KP7KzFiXC316LD6ZgdRYGT01gFlZhywqjfR0cwf2ZvL4Izs?=
 =?us-ascii?Q?bdnRK1axLjtIUWJDxvCxbvVrBQGa684gACQV+KdLs+EBE0S7rpcaL4zNh+2h?=
 =?us-ascii?Q?/wQnSUvTVD056Xi6cXAjLdBwjnMzbE8icX/vl1gHtxHGR/AZa/6LXEYCRIDq?=
 =?us-ascii?Q?XDPvFX88j+8r0heOIkTMWGPhvsY2mHZZCEtgVnughMk0sdqw9ZnbokdfRBTd?=
 =?us-ascii?Q?tdij4zorOsdjUl9t5/pd0Qr2XLK6BoBZzUgpxm1ZHUYvp0I+IVrjssox32DR?=
 =?us-ascii?Q?bkrie2o3icHfnIXiRiJomUb8q6Qox1KNENR7O+AIy6C4d3B7DFrkm3C7id53?=
 =?us-ascii?Q?jFJEOoriULRLDFL1Ki/Sf81froZfmjjK4bMROih1JoLkptckfdxqW3vNXizt?=
 =?us-ascii?Q?iLK1xSd9vq0HfgD4fDy3GUYL0dwNeZonn9NaoaMBth1GvAX4+3uEfvUqNRYg?=
 =?us-ascii?Q?Fym49J8SDqq81QUmoQZbXfCLf46Xz79edeZYtGxmC5mcgqDh9oaLhohzdjgs?=
 =?us-ascii?Q?fwmLrTfMrq8enV2M42JdvT0tk/3A5ab2MvfdWPl2Axb/A5msmEY8IU3Typ0l?=
 =?us-ascii?Q?Dw/atwFB8TE0k1rCv+LHwrxZfu+Ic+jLQZyZwnCi+2DmXA4w5q2mBQFgksPO?=
 =?us-ascii?Q?O7Obw5O9pbBDubYSdADwYim8/clsWnjkDhLc4+ngUIUeEjoN+TvNRVWwaO0r?=
 =?us-ascii?Q?hTEdUwPFmBGRRokQCEONqPg8/riJeqMpEHhJe5hx/GyCsreEvxKRgRsU2R2R?=
 =?us-ascii?Q?JoIZoyeHpO5aXNht4zFyw+dBzDHG9xhLuHVUjbPBFckw/xPvG0oaP68bryLM?=
 =?us-ascii?Q?PFEmbm3px9aGUAefZON3PfXbtOrPtuVNJCLgbbL2fXTe36VYCgQqyxecF/sn?=
 =?us-ascii?Q?VrVy0REtEsvtWXUF4Q8pdP1fcCLwTYSeMns5mhu5GCkmWEEvP81cu6JveqiT?=
 =?us-ascii?Q?Ty2c8RjNzAfhAYPUz25KKPQ+LDIqIYBcY9tfDgizsF5DevzRAOMsEjUF95XX?=
 =?us-ascii?Q?hNlsXq7vQ+V1Ckfh3Y66qr7YhrmFHz3M84hhtvBdzRrgvO37XIoYkELKvhc+?=
 =?us-ascii?Q?1eVnc7HBbdIRjTS0dM++QKvRdQNIC7ZkORGt7NcLNVi1QvqDUtAf2c2JbNsh?=
 =?us-ascii?Q?4hdV7Ay+Vz6fBdUenl2p+et6DxTLIW2rRqyTZH//Ch0lVTHrCD/sdsUApcNm?=
 =?us-ascii?Q?fu/ozuuhYdJosPSkzQcMWcf9YVkUg5qpemEbTgpRkWGuR7Y8go5eM6EBaTk3?=
 =?us-ascii?Q?3ZssGYlo6krzt/mL0URxRUHQ/oM86fsfSSpaKOjs7xEQ0YC4OpS3tK35wgIR?=
 =?us-ascii?Q?p15kN+VQJ6ob718e5a3Qwc0S7TniENV9zlwIWaYAtoWjfDRFyovjF0Rrj/XG?=
 =?us-ascii?Q?wJi39T9UXf0Er4tKlqXAcbuZn+v/LsFRTRKr2mwsUR75C52EWUqI3GwNzyBA?=
 =?us-ascii?Q?4a+8Er2QafHmsVw4OR1xYk6mznwDPXrc0pHbVCTsMPLGgx9MiHrya2pS//hQ?=
 =?us-ascii?Q?bFg96eHWWKbT2mrmY2U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:02.6306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7963d0c-332f-412b-0ed5-08de5353209f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

Andy Roulin has described an issue with the current neighbor notification
scheme as follows. This was also presented publicly at the link below.

    neigh_update sends a rtnl notification if an update, e.g.,
    nud_state change, was done but there is no guarantee of
    ordering of the rtnl notifications. Consider the following
    scenario:

    userspace thread                   kernel thread
    ================                   =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
       neigh_notify
         neigh_fill_info
           read_lock_bh(n->lock)
           ndm->nud_state = STALE
           read_unlock_bh(n->lock)
         -------------------------->
                                      neigh:update
                                      write_lock_bh(n->lock)
                                      n->nud_state = REACHABLE
                                      write_unlock_bh(n->lock)
                                      neigh_notify
                                        neigh_fill_info
                                           read_lock_bh(n->lock)
                                           ndm->nud_state = REACHABLE
                                           read_unlock_bh(n->lock)
                                        rtnl_nofify
                                      RTNL REACHABLE sent
                            <--------
        rtnl_notify
        RTNL STALE sent

    In this scenario, the kernel neigh is updated first to STALE and
    then REACHABLE but the netlink notifications are sent out of order,
    first REACHABLE and then STALE.

The solution is to send the netlink message inside the same critical
section that formats the message. That way both the contents and ordering
of the message reflect the same state, and we cannot see the abovementioned
out-of-order delivery.

Even with this patch, an issue remains that the contents of the message may
not reflect the changes made to the neighbor. A kernel thread might still
interrupt a userspace thread after the change is done, but before
formatting and sending the message. Then what we would see is two messages
with the same contents. The following patches will attempt to address that
issue.

To support those future patches, convert __neigh_notify() to a helper that
assumes that the neighbor lock is already taken by having it call
__neigh_fill_info() instead of neigh_fill_info(). Add a new helper,
neigh_notify(), which takes the lock before calling __neigh_notify().
Migrate all callers to use the latter.

Link: https://lore.kernel.org/netdev/ed6768c1-80b8-aee2-e545-b51661d49336@nvidia.com/
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6cdd93dfa3ea..5a56b787b5ec 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -51,8 +51,7 @@ do {						\
 #define PNEIGH_HASHMASK		0xF
 
 static void neigh_timer_handler(struct timer_list *t);
-static void __neigh_notify(struct neighbour *n, int type, int flags,
-			   u32 pid);
+static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
@@ -117,7 +116,7 @@ static int neigh_blackhole(struct neighbour *neigh, struct sk_buff *skb)
 static void neigh_cleanup_and_release(struct neighbour *neigh)
 {
 	trace_neigh_cleanup_and_release(neigh, 0);
-	__neigh_notify(neigh, RTM_DELNEIGH, 0, 0);
+	neigh_notify(neigh, RTM_DELNEIGH, 0, 0);
 	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 	neigh_release(neigh);
 }
@@ -2740,7 +2739,7 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid)
 {
 	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	__neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+	neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
 }
 
 static bool neigh_master_filtered(struct net_device *dev, int master_idx)
@@ -3555,7 +3554,7 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	if (skb == NULL)
 		goto errout;
 
-	err = neigh_fill_info(skb, n, pid, 0, type, flags);
+	err = __neigh_fill_info(skb, n, pid, 0, type, flags);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in neigh_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -3570,9 +3569,18 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	rcu_read_unlock();
 }
 
+static void neigh_notify(struct neighbour *neigh, int type, int flags, u32 pid)
+	__releases(neigh->lock)
+	__acquires(neigh->lock)
+{
+	read_lock_bh(&neigh->lock);
+	__neigh_notify(neigh, type, flags, pid);
+	read_unlock_bh(&neigh->lock);
+}
+
 void neigh_app_ns(struct neighbour *n)
 {
-	__neigh_notify(n, RTM_GETNEIGH, NLM_F_REQUEST, 0);
+	neigh_notify(n, RTM_GETNEIGH, NLM_F_REQUEST, 0);
 }
 EXPORT_SYMBOL(neigh_app_ns);
 
-- 
2.51.1


