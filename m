Return-Path: <netdev+bounces-187020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E89AA47D5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A72B5A8728
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6222259B;
	Wed, 30 Apr 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M68ARbv8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFD237194
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007414; cv=fail; b=bZ9sOQJ4pjCuarB/d5NnhnlViHrtU2NhyOD0JbMIkTIu4GFTpa/hqRa2EtxXtxp+xLc9BTiWa4gp/eX3jWX3aFt9yYvDvump/PzG5+qYxsTjggh4p795zW6kq2EWsPyhPldyw4fSgwbCc6ia9518iP5x9W5m+bhGhvZC616G9y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007414; c=relaxed/simple;
	bh=3JTvl88MoW/+jHq/Vr+k1Wyppq6/Y52QlbfZFfXpX40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CfqSf5hyux9fFhTlA2UYfd/bs+0Q1s8AmpnhI8iStdBtv6fHmHz7u2Egg48ibaoaWmpS5yKl1w+pczmMXKqrS10USxUOELcLZKqjacnimZGmfgEKWwSZy9g/Rz1moXtG8Ci1Ps5OShqhltCZFQ8ML1AyTBtERHyQMp0Oo62jlJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M68ARbv8; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUFOoFn8FZGc9cImgfJth6SG6w/Y2zLi0mKmAv+UlJ3YVGP+DZ8H8KWAQO8/r8DdNKuNWIBJR45kEntvNjCeZMHLhegNe2b8EKLmPifYAjPq2xMd2nq8zTTAwNHg4TVvR6FcAudmmUKsxn2voE2dYnALejSPuhsSCWph19gPDJG2j7E1Ptx1tmCtifnDXy4sxI8luUOppNMJR6OHziOXUlS8BrNnbyQN4vkaO7NjsIRU5GDm7Ulqph/mGhjQE/eQomyYcAI7qW/b0+hq3fKL8Ioobvn1XjNkIKRiWyhsIJol2nEVtAzYEKiLQg30B5ZRhGKFJcY4SPyS7pLw7uJa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFz1v5TIyQQWdEw2SlJZh/2IPUaGuOESpJxOBCyvEvg=;
 b=UWWwN5AAXSnjIVG0FxwAzY2pBC/vqaJo2Z6Qx8ZXRe6aTe9tLLZaik2KLIjiPYmO7EvsO/NluayJZUIvDagsYP/++PD/IIBx/Y7TVCcd5CxTZoHRFl90vp63FulC0i9fUCidOnmgZ5Ab1gr1fm3wJbr2zeHy4Ri1JMegnXTatfnj0f4e/QFbWtV+/V8TOWcKwxKniB+DDadlK4YMFftUOndSACBKw0MEfKeoOpzBL5CJvg79ok10Tsal2F9lN9QGO8B1y3+9ulvTkmVWCW9ycJuWaR73YDnBKOcCWfPMipwDIGfjWSLNUj4L1/3HcNwPvVydQlGHpsiBcrppIyPdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFz1v5TIyQQWdEw2SlJZh/2IPUaGuOESpJxOBCyvEvg=;
 b=M68ARbv8XiQdeEr6d+I8phrJHFWPnHJatWFOLElS4kB48wox6PAizH2oVmt5Ucq5L8TbSzM6Qa7KLBwO4vG0/az6D6zZIhUXiY2w3B1o07r0mEI9NXmqSu9GXAY5kf13d1jbeDpKeqhNrytulCp3UJvYOHVdwa8B+9NJThhZ6kOFIjRhGs+36C1SgLiEoI7JGYsob0alBq+HActZKn/aRAZUwbSG3DjP7eC2JuDkz6wceJmWQnk3hKQy3qpDsr2k/3dufjvtSAcW2vmPp+EAXphaRsmZ+a2gzvkSnZUnUgSiFLXMOgkkteKpKQf8kliKaRGzsz4rU9XDScBpC6AnKQ==
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 10:03:28 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::ea) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 10:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 10:03:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Apr
 2025 03:03:16 -0700
Received: from shredder.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Apr
 2025 03:03:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<willemb@google.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipv4: Honor "ignore_routes_with_linkdown" sysctl in nexthop selection
Date: Wed, 30 Apr 2025 13:02:40 +0300
Message-ID: <20250430100240.484636-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: a424c28d-691d-4fb6-0103-08dd87ce40da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?egfdUTYttgsbj7XQqDHSuFtEas90g/T+kUotuSnZ0WnJMTUOqh3iYnCLFym6?=
 =?us-ascii?Q?Z0lm2wRxusYcO3QGrwg18OVggNnQW4RhJSVZsrcikAEFDH0av5Ft4lcGKqp0?=
 =?us-ascii?Q?z1QOn/zcjNdbZPTTSfCY+MEg9cnkSYrNkxKy38eXIAqhGJsvzs80oBZguU6y?=
 =?us-ascii?Q?Pf+03qNfhVSHfPv61OInEjjv64/ZfgqGTBstDjSquGwEYyPRbdECnTb5IEEm?=
 =?us-ascii?Q?3yqfjVWrjuWh0LDKhHpC54moxeiwC4Wp+LO4Uyaqf/DmyCKVnkRAUyV7b3X4?=
 =?us-ascii?Q?2K/OPs+dHFcb5I3q7k41SbNsQDSOyMfsbojRHFExh9RGmNqJ92MDRAZkX1Dy?=
 =?us-ascii?Q?xRpAdSUWDKC9RROq5mRd3BR22z6H1mX0ENZHdmO+Psf29tIs9jgWPFLI+JMM?=
 =?us-ascii?Q?T51Fp9Rtw4d2c70LRRlbs6KA1qYItim278sahjSrMpt92cqi+ZqlZr6/pT0O?=
 =?us-ascii?Q?7m0J39n+LV3bNBOuZNy7e/rh/1ig/ejrLif9NOGMIqojYyuBflown+JrTrNQ?=
 =?us-ascii?Q?pB6YWFPjLm3AEaMAYxAudilr/IaGV8eNKBFgdjz0Ng7e0+1xCWIxw6k6+uOS?=
 =?us-ascii?Q?TJrKpOZuGoNBB6Zpurj7QfC/8wTUyG9xCYDo6YqxrurbS53myGxj54iqlyJS?=
 =?us-ascii?Q?Iq4VS2FZQ170o8lnXstfbTV5m8dwwrQpuAVPNduRjEe7/UbRUJPwojlCRzTy?=
 =?us-ascii?Q?5E3FLW9y/d+Z8dAN/F5l51dkM8dkRHYzqls5Ynvry6mglwL6+FCIbZNqEpQS?=
 =?us-ascii?Q?xBBCVt4W+zBWPoHoVlOVd2seyjq53skHyVzVm9eW6bxzP0RByQKmSa3uk/z+?=
 =?us-ascii?Q?EhCkKrYAW/l9oAAtZpm+lRdh0SeeW6WG/oHcmjgjLGO1zuuj9SPOoLFQ+zBb?=
 =?us-ascii?Q?L94OxDmh/tAnXjsYvtWuSyuRkp4pv2d0Fty94E8Y/KHyDAksEvIkMQkM0PsD?=
 =?us-ascii?Q?l3TjI8XO1LAIFI7s0dAGa8+uo3gR/RH4oxVkhaByf91yc06XBGrAsLzZDPNN?=
 =?us-ascii?Q?VoMAGJ55tqXth8HF+bB7TTOOV7tZgacM6rg851YyQ5hqhdAneRcQR3nd9u5e?=
 =?us-ascii?Q?Hpi9jft020IGg+8vtXmwD2d9qSX+UxCETBHLFSLbpmmDYztlmxS7Y8by5nOc?=
 =?us-ascii?Q?6kz4+ltknlI1mwZq+QshBlkvKhXjAkfFvXLQITt556yMd7nKFISPYy75qVGC?=
 =?us-ascii?Q?BIWbTd8TlC7yNNu+oX6X+LR/vzeNr42mYxOQHONfostUIPcX4nKJ8nSJOxgV?=
 =?us-ascii?Q?Y9p6anRfDGrB2LSQKwMvJiIZk00nb8UUYXX4araJJaa5hskZ4L0QlR+Kfi7S?=
 =?us-ascii?Q?DmOO7fg5CPxgGNKmAhROxV4XHheFjWqc8bIMTIu5LjeHL8/4qEOOz9excnfQ?=
 =?us-ascii?Q?9QkX6caqcOgLhq+mew36a1eVe/F0b8raw5ON7BoHBrrdrKIIp0YI4p8VHQwH?=
 =?us-ascii?Q?3l6v6SzRbCeDYypk82N/SpH/XxGwre53PyTikNhXGQaxWIkF02XVHbXqCCLB?=
 =?us-ascii?Q?0q0c8+cpGjwvuTyK/VX0Yi6yX+l00/7LBj/E?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:03:27.5985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a424c28d-691d-4fb6-0103-08dd87ce40da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639

Commit 32607a332cfe ("ipv4: prefer multipath nexthop that matches source
address") changed IPv4 nexthop selection to prefer a nexthop whose
nexthop device is assigned the specified source address for locally
generated traffic.

While the selection honors the "fib_multipath_use_neigh" sysctl and will
not choose a nexthop with an invalid neighbour, it does not honor the
"ignore_routes_with_linkdown" sysctl and can choose a nexthop without a
carrier:

 $ sysctl net.ipv4.conf.all.ignore_routes_with_linkdown
 net.ipv4.conf.all.ignore_routes_with_linkdown = 1
 $ ip route show 198.51.100.0/24
 198.51.100.0/24
         nexthop via 192.0.2.2 dev dummy1 weight 1
         nexthop via 192.0.2.18 dev dummy2 weight 1 dead linkdown
 $ ip route get 198.51.100.1 from 192.0.2.17
 198.51.100.1 from 192.0.2.17 via 192.0.2.18 dev dummy2 uid 0

Solve this by skipping over nexthops whose assigned hash upper bound is
minus one, which is the value assigned to nexthops that do not have a
carrier when the "ignore_routes_with_linkdown" sysctl is set.

In practice, this probably does not matter a lot as the initial route
lookup for the source address would not choose a nexthop that does not
have a carrier in the first place, but the change does make the code
clearer.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_semantics.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 03959c60d128..dabe2b7044ab 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2188,7 +2188,14 @@ void fib_select_multipath(struct fib_result *res, int hash,
 	saddr = fl4 ? fl4->saddr : 0;
 
 	change_nexthops(fi) {
-		if (use_neigh && !fib_good_nh(nexthop_nh))
+		int nh_upper_bound;
+
+		/* Nexthops without a carrier are assigned an upper bound of
+		 * minus one when "ignore_routes_with_linkdown" is set.
+		 */
+		nh_upper_bound = atomic_read(&nexthop_nh->fib_nh_upper_bound);
+		if (nh_upper_bound == -1 ||
+		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
 		if (!found) {
@@ -2197,7 +2204,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 			found = !saddr || nexthop_nh->nh_saddr == saddr;
 		}
 
-		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
+		if (hash > nh_upper_bound)
 			continue;
 
 		if (!saddr || nexthop_nh->nh_saddr == saddr) {
-- 
2.49.0


