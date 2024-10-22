Return-Path: <netdev+bounces-137761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC69A9A86
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A005428245E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4961474BF;
	Tue, 22 Oct 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1otBGEh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7911487C1
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581047; cv=fail; b=LvTpT32M7CDVzthDjrqHNohCgCEO2cYgX1wNQrL5YYGPJ8B1YV4oEvzDXhiJjA+FrNr3PGY3jj5lhOjdvGHHBEZheB7V7FoAMRrezLbzT4ZzHNiB1EHFpWaJO5yY6vGjr2Bdpgw0d5Rk8sccx6OMYHuifEAhCSwfwBL+yoK++8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581047; c=relaxed/simple;
	bh=qCYAW2691VGT/4zdqkheUG7idA97nKpACOxm3dLnSQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QGWHtn6OAXMQZG+2b2lYGOmCOkK0mc5KRXzjlqutXh5ctfxcSh+6MJQG0l3Eef6xCR7nQZYG8TpasrEHCGX4vxR5Xv6inTmOAf/gAPucsQUGg0k83ubQCSt19SJHur2+gvGHlhrV9bZC6tZrz9fJuzkaiBl4RkoIRfR3zFxFTZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1otBGEh; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ihfau+F57S1JFLAcBgdh4MZ5UpeUCMwBFfVh5CfKz1Pg8YAwaaTxMGsIWe7xWr+zukAP5wdJg1OokLeBDmiYOpo08t/GB/zTY0E4MqquFkEvN980Vn6Mr1SBUgPb79HPgrrsL8/t89pJYfhbs3oHB1I72G9nENyt61JZMI5sP20tMdW3DkeWnxA8jMDTtVzmz6wMtsVerfINjdEYPmOoGUhxOIrg6IRl+ib8dAe1+Z8rsiNsQGGVXcnxsP37W/qBz9YtTmF7FOrLpgDQsBcZv5zIBYHiRo1dYPC+1R6JWxKb5rziqhZQKhotn7C8LkbqHbkNQs0EijGcFp85L31vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnARCZy/5/Kqnn2y1XBYkLAB5wbdfvzjjkn1aZSCwmE=;
 b=Nhebe+R4I3hvPYAsSetFhcwQUezINDmjfbw5mUjJYc7Qt97NaXIvFdatCdaN4acXy5FggqABU4XzEurPRGWJ8C9Cr09oissyJUfNDMAbE9yKTXTDYteehBxWt3p8rBssE7Z33BadOadk+neAr8zU2PFkPk6BkJprxsFGlVkP0O1UMv1Bq0IRFy4YQ8lcxpSzAVWWRidH597s2ADgHKJuQ0aDWyjaPAUTv8300fvoLtMwxgWEQKvFgX9neqJCrqmca4boJyxRL4nHmna/pA409v/huyQ+1nBTNc4V83lrHmGfF2KWTL7EYRhygHDsuztXKbSje8aLV+Q9NCbfnHTxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnARCZy/5/Kqnn2y1XBYkLAB5wbdfvzjjkn1aZSCwmE=;
 b=p1otBGEhUrttNluwT0PW6vUuN5xZABNEuFqA7KbE4mxiD/NKUSuUgIclKzaa5k3FmZOgpfu2ELIDMqhzuiCFttRhTcO/u9pJt0sOEwz3BFxEbobIQc25h/7n8YopmwW4j2ZTneEZ8xYcQcPezehxZ/p2rlJA4Hi+68NbRZS2R8dk2ez1JLc4SXpPbdk9GFgU69W47hCjLJDgsS5rA8XObA1MpEjWWCZ7iLbejWYj57HhUYoD1HxsotFbEaVGas6IiSt2RlC51UTAi7+lEJM0ZJBmTJEk95nq6SoHyM0GAGwdo2RnvnZowfW7CSB7Vm5BHzG5R0G63v+s5BZ3gidmnQ==
Received: from SN1PR12CA0060.namprd12.prod.outlook.com (2603:10b6:802:20::31)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 07:10:42 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::33) by SN1PR12CA0060.outlook.office365.com
 (2603:10b6:802:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Tue, 22 Oct 2024 07:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 07:10:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 00:10:25 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 00:10:21 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<pshelar@nicira.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Tue, 22 Oct 2024 10:09:21 +0300
Message-ID: <20241022070921.468895-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3eb4c9-94a6-4247-939b-08dcf268a3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gbAytpI3f9RCp2LaMsOchtZZx1yeY1K22cePT0vwzrj1hEopgREYDki9eUnj?=
 =?us-ascii?Q?QJqQ3aCdYwAuSvYrwlvwelQUoh7ESI3E/a1lZo70AlsQT/ooMuUEfS/Clt34?=
 =?us-ascii?Q?mX/r6Ff1VCjV1TByrYhznrlj1cub2vMD/ZksHFjDLoa1TA6hp6zahOxx7L8B?=
 =?us-ascii?Q?SC0kW1/lLwszrfbsntmlCNOztUWwzbGaHii3+R09tqRnV6cBT7xcR+nzj17+?=
 =?us-ascii?Q?ceGy6cDRgbPGKIK+NIJiCJjfcNKpofBMCn2y6Yt7EWdZHRL85MI81Ig44u4h?=
 =?us-ascii?Q?XkXVzvx5MQOb/+e5e+epfRSrEiKjMPXn0JzEHW+GyaKUUjnvsbLngPTFP3Ry?=
 =?us-ascii?Q?eR1S49h3ONcFn0ZJx0bZpR8h1i6j3b/poh3miyueVdh9KXvV4ZqSDyt5mx5A?=
 =?us-ascii?Q?24FZNogqOHdYhEafA6NhOWv27uxsSO2FG9VbB1ZGqM71LJ4zBqvjc6eFH9Cr?=
 =?us-ascii?Q?2p1cM9zLKBr6yMkS6vqOTs1f72z3jgJVCYYfeEmZrwlvVLZDRpvJz4csifPq?=
 =?us-ascii?Q?8ATwN4VsFK/YzKSCu97uJy5ZIhkq6AGrbSQAdaH8OVzTCHzv/fj3RtNkbrO8?=
 =?us-ascii?Q?nYBkolA8dzppZA9i5RmzMSAwB/zX2yCvU949MbM5yaLaCsPBAfVyLmu+4lVK?=
 =?us-ascii?Q?ju+BDcJohVJ3Pa4DCNhfbHLcMg/CWASonvzQfBDbxdXzbQ1xq/u2WZ6eCuL5?=
 =?us-ascii?Q?NtW1pUFMi+DvMX4Ruaq0yxKtSoYWnmCVdugLOfg+mO1kmGButOsZmwdFuYdH?=
 =?us-ascii?Q?SnhBbxcRvmT5OvaqJcjOjjMRTOY9ZkNJ0+/1t2upuonm2JzBt8NKT7FtPmKK?=
 =?us-ascii?Q?LIh//lwh6i8gHLrGryX3wnjjF8m2ho08hkBs1QUzRovfbaAjh1PLsugBMMUp?=
 =?us-ascii?Q?ZJudHpkCv/naN4N3HgdyuvJTe2gueGeYMqyl41Umqq4fnU/tz8o9+7tlgxpl?=
 =?us-ascii?Q?WIcooM49Khe9NeK8B19v7K8MIflmhUZH4BT54A7p+wvCeefuHPj4VzWzSA3K?=
 =?us-ascii?Q?nloYWsDVd6DvKj7DYewO5jcTU7nmYTa4HlXvi6I++f6vAN5s8fUWUGo1QjpB?=
 =?us-ascii?Q?ZrX82Yo/zrNE463zV4MxHMRwThMgpyTCN4Q6pG6U1vzaeIBZ0O/F2885encW?=
 =?us-ascii?Q?BFSBE1xnhO4Jiczdt15rw5dKQ0tySsaXunYNn4CrECrGlVKpsAuZEWMA/Uhe?=
 =?us-ascii?Q?kPdG8ly0yydU9A7GVISvQcGO1AKFtgeI8s9aEvTof/p0iSGf6+cWNK4Cuc2e?=
 =?us-ascii?Q?3Pls34jl/pY6bKl6SgdxRPnIEOwbObACk++uSKB0zgEQhcjUivMVUczn9Nu8?=
 =?us-ascii?Q?fdxO1zyZkxnH/4jL3oy8QLfptoyuwJdAguf0vADk1ydYcJsoe18NLvO8JY2/?=
 =?us-ascii?Q?ctGnEZWQCJGO8imcO+z5DLFo/bzwVetknw/mIOhnasBNlhcHsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:10:41.6410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3eb4c9-94a6-4247-939b-08dcf268a3c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

The per-netns IP tunnel hash table is protected by the RTNL mutex and
ip_tunnel_find() is only called from the control path where the mutex is
taken.

Convert hlist_for_each_entry_rcu() in ip_tunnel_find() to
hlist_for_each_entry() to avoid the suspicious RCU usage warning [1] and
add an assertion to make sure the RTNL mutex is held when the function
is called.

[1]
WARNING: suspicious RCU usage
6.12.0-rc3-custom-gd95d9a31aceb #139 Not tainted
-----------------------------
net/ipv4/ip_tunnel.c:221 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ip/362:
 #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60

stack backtrace:
CPU: 12 UID: 0 PID: 362 Comm: ip Not tainted 6.12.0-rc3-custom-gd95d9a31aceb #139
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 lockdep_rcu_suspicious.cold+0x4f/0xd6
 ip_tunnel_find+0x435/0x4d0
 ip_tunnel_newlink+0x517/0x7a0
 ipgre_newlink+0x14c/0x170
 __rtnl_newlink+0x1173/0x19c0
 rtnl_newlink+0x6c/0xa0
 rtnetlink_rcv_msg+0x3cc/0xf60
 netlink_rcv_skb+0x171/0x450
 netlink_unicast+0x539/0x7f0
 netlink_sendmsg+0x8c1/0xd80
 ____sys_sendmsg+0x8f9/0xc20
 ___sys_sendmsg+0x197/0x1e0
 __sys_sendmsg+0x122/0x1f0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_tunnel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d591c73e2c0e..a93c402f573e 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,9 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 
 	ip_tunnel_flags_copy(flags, parms->i_flags);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	ASSERT_RTNL();
+
+	hlist_for_each_entry(t, head, hash_node) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == READ_ONCE(t->parms.link) &&
-- 
2.47.0


