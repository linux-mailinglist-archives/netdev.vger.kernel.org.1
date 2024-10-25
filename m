Return-Path: <netdev+bounces-139137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1649B05CA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC1C284D1C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515D1FB8A2;
	Fri, 25 Oct 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y+O2/Imk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC01FB8AD
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866463; cv=fail; b=Zo+UZ6r+Zi3bKurfXrJhak7GhpENwS4ScJOr9Ac7nJLDO89wy/9TwkLx7vhSFlfkMYtks/q/xNaJ+otlBles+x8IYOrtU8CwPqOE/uhtEs3XbsHJrtxMVniWgtddb1YnG7Ba3oszw63Sge9m3K/LV8E8JmEw8rSf4UMocSOZutE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866463; c=relaxed/simple;
	bh=VZDAVX6h2mzb/hiTeXJhWDumNzggrysGVKzH/miyLiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z//x6dCNB8JoH0sCW3p5nFs+EnxdwaCxnBBOtJgBEzeIZafpo2BWuR+e5C05NuQ3kro6Ts1JPoST7vX7lErtX2888O9DHlmCWFoOxGF8dADaLk5WOVaCqgDDEEY4s+pRwbV5r39Lh/xCk855lS40F/UHjAxCbJpVE5NjPQ8/j2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y+O2/Imk; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzbTDgqA26rf5i5ho7K5oDnYFEcryA8cCSSFIVkNh/+IFxBcUejuVE98Myzuxdxg/dQJxCLCnLl4e2SDl/QrdPESfgHBmLxq2yHeGP1UxFUSQ+5fL9xoOwdeIX4OujL2DTAbXfSeAa39FYukO4oXT/9AL3jdcroLtQbjsVeX8TtprgUHhorKPAHPoZYKK/q4uktqdcp0DWIcVvnjSiBLlvz3fuNZ8agGhRyihKrpjEWrX6WjsL8XYaenE/6bTWk43BxFz3v5RxbORBMYyNqnHK4ebwlZqviZVV73ORUxt+JeG1HQ4JiTXBaa6B3WhHSDUOpUR1dBCfsjJfw41oArfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F8KK/ZZnhgRDviFO02ahH5x9I4FlIn+eHXj/TjLeGE=;
 b=cfYeMFepxKRVyNb0nuqbxklR3oMBxt3PJnAKnOzJkgtz2cyHMW9Ekk8UAMegQHcJNWPWy1prFKOK6FcsyvRPFN2RZshWMPZb1rqVQlwm6HZbyErfZaeo2aJ6V+GL7PW5Ua5r8P0Lx0u/fQbcmvI4lH3/jNnHLQoSPFnGkoD7l2ZKkGMnkyExXryNFBftU81FQCiOtELJYjCr2yPOKiX01lSPS2vk81ZeDCMP0C2Pe1XpcomFfUcFJvrw9jf213NQE1rV399+qS7xa8UeVnyDYxRvfS/v3I+i0G5FP1qZYxJakia0w86zebM2fJ1MV6LXnTRS1Ju8xT/RwqbXOfTjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F8KK/ZZnhgRDviFO02ahH5x9I4FlIn+eHXj/TjLeGE=;
 b=Y+O2/ImkeL2jf+Oh8U48a9w7c3ZNnvCVlMVyj45hu7//2UjqA4ASAHE21DaR5dQU+9iwvLvwukg1eHj0SoSRpUjHR91/Hu3B6vkI4Tvjq+/4ynMI33AZ9TlnjPFTITF+iDUc2jhGvSqugrJlijCjYGn1EV9F59nGwThQEsfo8IEDs/0fgkvbFbGUYpP/6bYCiufsXkfOUyKz5cheQ2cZ+Npq6qHE7gSNz1sD72q52ZGjqi9IK7PhrodKPP5fqwAr5atRtMGvEKRjwBa4Esxm+Lz9Uk9fOXdeOe5cpvMCkHT188CLzUaQRl/0VQHuxjJMISNYn6Npt6G392c9BiXxVg==
Received: from MN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:52f::6)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:27:35 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::7) by MN0PR03CA0007.outlook.office365.com
 (2603:10b6:208:52f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 14:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:27:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:21 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:15 -0700
From: Petr Machata <petrm@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net 5/5] selftests: forwarding: Add IPv6 GRE remote change tests
Date: Fri, 25 Oct 2024 16:26:29 +0200
Message-ID: <02b05246d2cdada0cf2fccffc0faa8a424d0f51b.1729866134.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729866134.git.petrm@nvidia.com>
References: <cover.1729866134.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c596ec-9036-4adb-3b20-08dcf5012bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xMV81tiTWYTss9lVxobiEgCGCmqV6XPdw/s2YH2UPPgoxFn8FHrlvQ2LtKzt?=
 =?us-ascii?Q?KSyLY6q17UT+Fr49G+sB6XoL1w7x+/79Apbtk5HOwtSRrHj+8hjuvMdTVkbS?=
 =?us-ascii?Q?feD1SpOaMx4hxdVCcFqmKslD9fjw8Vf2jyimcpq/hHkZvY/lKgKPOoQBjjw2?=
 =?us-ascii?Q?wqk7uFu/fHAJQS/w3PqJ1eTRwndgX/AEIbjQ7pDpFXU3WFl/qcxs665pK00G?=
 =?us-ascii?Q?2ReIsHqZbLUgrAYotH1j5QsvON2X1d3xTFRpB+s2lRqAmYVN4vZAYShwG9Qp?=
 =?us-ascii?Q?d69Oj/psYDERvxq34MndwY0KxZT416CZKlB+Y3zf46nmeQ4rGpb10ml81RiF?=
 =?us-ascii?Q?14uSf2iv1xXnZFj8EQaHKcLVf46aEdgqcGMk/VQImxxd4SRw9PWVwDfELQBw?=
 =?us-ascii?Q?IJcdpOI/9OZf6s/+0Qqj1CqcaRE6W1EWKwhydCnQ+oRiPJSj512cPnejyAuZ?=
 =?us-ascii?Q?y1PKVU/P8QrYdxgtzAfZMPasaKeXzTQUsOidNizrdObRiC61cdylqGmmfxeS?=
 =?us-ascii?Q?Xjbvsk1UZ4/uc3o+i3KKxgSplzIW8l1/lzJaouawNVK96rZ3uxH17wcg/9Xg?=
 =?us-ascii?Q?zeus5EEU1kymLznZBAdHs9sHMo3KEe6scrTbUhi/opP/DpdKZXFcMGEpfJMP?=
 =?us-ascii?Q?PiLmqvOIR8LlEexCHTt4JUlj0jqu3t9G0PcGmaoJ/2UKD90rl+jJS6QUr2qs?=
 =?us-ascii?Q?np1xzphO+nsBJBrKNK2/vh84To/DnS+taL/lXvjzVBbgQQCY16wU7Gp8S+JN?=
 =?us-ascii?Q?sewW79TMoXEBZqFxYi/mvhomUqvtowFe1nv4ZELDrolN1D3hAqTurvIBsgCL?=
 =?us-ascii?Q?w6ojinXVesAxiFWwSF+63kImaasmJ7CSG+qQRBPoq+My0U0t7GMkIk0NLswV?=
 =?us-ascii?Q?bPrqZq7G2fsxURDnFV6q8FiRb7Be/ut1LE8TtchdFBvF0hzvTsQj+B7RSGN7?=
 =?us-ascii?Q?LguxRgJC3vV/YmPqgBYAURnSJMNS1XzJBgBZB4FNhVhQp7nYTM333KQSej81?=
 =?us-ascii?Q?e7jXssYvkbOeVLGLOxelHLowPHFtrQe790tUUAQ5nB/qX6d2ZIOzymuO5uFf?=
 =?us-ascii?Q?QRLAN9VsWHa47CN+37XXjBZke8CYqdYqU7j04W+VPdxbMcO2wYnacuu4se6B?=
 =?us-ascii?Q?dJksghO0zS/vbGXwcLB9xbAB9ci1PCOTn6F7z9LVdu0Rt8K1Wz2/9Vt1HXzP?=
 =?us-ascii?Q?wskTbjYdWphYlJ0TTwQY/w6/FmM8qLbdbSFJYI9sI2kQjlcuy/lk1Ud/wAwO?=
 =?us-ascii?Q?InVenj/YKbKqa1wJLFwwkHT2MugdLq0UUBylJuPHeUcGvPhXXAr9U7eKTCA9?=
 =?us-ascii?Q?kVw1LhFjMbliNnIFrTNfFuJV66AElap3cwXbs3euSyhRvCtaB97Bj1ayqLRh?=
 =?us-ascii?Q?ePeFNukVSmzfnuQm0X9WobTHTaueP/Q00J+guJLASyXDd7raTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:27:35.5315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c596ec-9036-4adb-3b20-08dcf5012bb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

From: Ido Schimmel <idosch@nvidia.com>

Test that after changing the remote address of an ip6gre net device
traffic is forwarded as expected. Test with both flat and hierarchical
topologies and with and without an input / output keys.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/ip6gre_flat.sh   | 14 ++++
 .../net/forwarding/ip6gre_flat_key.sh         | 14 ++++
 .../net/forwarding/ip6gre_flat_keys.sh        | 14 ++++
 .../selftests/net/forwarding/ip6gre_hier.sh   | 14 ++++
 .../net/forwarding/ip6gre_hier_key.sh         | 14 ++++
 .../net/forwarding/ip6gre_hier_keys.sh        | 14 ++++
 .../selftests/net/forwarding/ip6gre_lib.sh    | 80 +++++++++++++++++++
 7 files changed, 164 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ip6gre_flat.sh b/tools/testing/selftests/net/forwarding/ip6gre_flat.sh
index 96c97064f2d3..becc7c3fc809 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_flat.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_flat.sh
@@ -8,6 +8,7 @@
 ALL_TESTS="
 	gre_flat
 	gre_mtu_change
+	gre_flat_remote_change
 "
 
 NUM_NETIFS=6
@@ -44,6 +45,19 @@ gre_mtu_change()
 	test_mtu_change
 }
 
+gre_flat_remote_change()
+{
+	flat_remote_change
+
+	test_traffic_ip4ip6 "GRE flat IPv4-in-IPv6 (new remote)"
+	test_traffic_ip6ip6 "GRE flat IPv6-in-IPv6 (new remote)"
+
+	flat_remote_restore
+
+	test_traffic_ip4ip6 "GRE flat IPv4-in-IPv6 (old remote)"
+	test_traffic_ip6ip6 "GRE flat IPv6-in-IPv6 (old remote)"
+}
+
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_flat_key.sh b/tools/testing/selftests/net/forwarding/ip6gre_flat_key.sh
index ff9fb0db9bd1..e5335116a2fd 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_flat_key.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_flat_key.sh
@@ -8,6 +8,7 @@
 ALL_TESTS="
 	gre_flat
 	gre_mtu_change
+	gre_flat_remote_change
 "
 
 NUM_NETIFS=6
@@ -44,6 +45,19 @@ gre_mtu_change()
 	test_mtu_change
 }
 
+gre_flat_remote_change()
+{
+	flat_remote_change
+
+	test_traffic_ip4ip6 "GRE flat IPv4-in-IPv6 with key (new remote)"
+	test_traffic_ip6ip6 "GRE flat IPv6-in-IPv6 with key (new remote)"
+
+	flat_remote_restore
+
+	test_traffic_ip4ip6 "GRE flat IPv4-in-IPv6 with key (old remote)"
+	test_traffic_ip6ip6 "GRE flat IPv6-in-IPv6 with key (old remote)"
+}
+
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_flat_keys.sh b/tools/testing/selftests/net/forwarding/ip6gre_flat_keys.sh
index 12c138785242..7e0cbfdefab0 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_flat_keys.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_flat_keys.sh
@@ -8,6 +8,7 @@
 ALL_TESTS="
 	gre_flat
 	gre_mtu_change
+	gre_flat_remote_change
 "
 
 NUM_NETIFS=6
@@ -44,6 +45,19 @@ gre_mtu_change()
 	test_mtu_change	gre
 }
 
+gre_flat_remote_change()
+{
+	flat_remote_change
+
+	test_traffic_ip4ip6 "GRE flat IPv4-in-IPv6 with ikey/okey (new remote)"
+	test_traffic_ip6ip6 "GRE flat IPv6-in-IPv6 with ikey/okey (new remote)"
+
+	flat_remote_restore
+
+	test_traffic_ip4ip6 "GRE flat IPv4-in-IPv6 with ikey/okey (old remote)"
+	test_traffic_ip6ip6 "GRE flat IPv6-in-IPv6 with ikey/okey (old remote)"
+}
+
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_hier.sh b/tools/testing/selftests/net/forwarding/ip6gre_hier.sh
index 83b55c30a5c3..e0844495f3d1 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_hier.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_hier.sh
@@ -8,6 +8,7 @@
 ALL_TESTS="
 	gre_hier
 	gre_mtu_change
+	gre_hier_remote_change
 "
 
 NUM_NETIFS=6
@@ -44,6 +45,19 @@ gre_mtu_change()
 	test_mtu_change gre
 }
 
+gre_hier_remote_change()
+{
+	hier_remote_change
+
+	test_traffic_ip4ip6 "GRE hierarchical IPv4-in-IPv6 (new remote)"
+	test_traffic_ip6ip6 "GRE hierarchical IPv6-in-IPv6 (new remote)"
+
+	hier_remote_restore
+
+	test_traffic_ip4ip6 "GRE hierarchical IPv4-in-IPv6 (old remote)"
+	test_traffic_ip6ip6 "GRE hierarchical IPv6-in-IPv6 (old remote)"
+}
+
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_hier_key.sh b/tools/testing/selftests/net/forwarding/ip6gre_hier_key.sh
index 256607916d92..741bc9c928eb 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_hier_key.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_hier_key.sh
@@ -8,6 +8,7 @@
 ALL_TESTS="
 	gre_hier
 	gre_mtu_change
+	gre_hier_remote_change
 "
 
 NUM_NETIFS=6
@@ -44,6 +45,19 @@ gre_mtu_change()
 	test_mtu_change gre
 }
 
+gre_hier_remote_change()
+{
+	hier_remote_change
+
+	test_traffic_ip4ip6 "GRE hierarchical IPv4-in-IPv6 with key (new remote)"
+	test_traffic_ip6ip6 "GRE hierarchical IPv6-in-IPv6 with key (new remote)"
+
+	hier_remote_restore
+
+	test_traffic_ip4ip6 "GRE hierarchical IPv4-in-IPv6 with key (old remote)"
+	test_traffic_ip6ip6 "GRE hierarchical IPv6-in-IPv6 with key (old remote)"
+}
+
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_hier_keys.sh b/tools/testing/selftests/net/forwarding/ip6gre_hier_keys.sh
index ad1bcd6334a8..ad9eab4b1367 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_hier_keys.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_hier_keys.sh
@@ -8,6 +8,7 @@
 ALL_TESTS="
 	gre_hier
 	gre_mtu_change
+	gre_hier_remote_change
 "
 
 NUM_NETIFS=6
@@ -44,6 +45,19 @@ gre_mtu_change()
 	test_mtu_change gre
 }
 
+gre_hier_remote_change()
+{
+	hier_remote_change
+
+	test_traffic_ip4ip6 "GRE hierarchical IPv4-in-IPv6 with ikey/okey (new remote)"
+	test_traffic_ip6ip6 "GRE hierarchical IPv6-in-IPv6 with ikey/okey (new remote)"
+
+	hier_remote_restore
+
+	test_traffic_ip4ip6 "GRE hierarchical IPv4-in-IPv6 with ikey/okey (old remote)"
+	test_traffic_ip6ip6 "GRE hierarchical IPv6-in-IPv6 with ikey/okey (old remote)"
+}
+
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_lib.sh b/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
index 24f4ab328bd2..2d91281dc5b7 100644
--- a/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
@@ -436,3 +436,83 @@ test_mtu_change()
 	check_err $?
 	log_test "ping GRE IPv6, packet size 1800 after MTU change"
 }
+
+topo_flat_remote_change()
+{
+	local old1=$1; shift
+	local new1=$1; shift
+	local old2=$1; shift
+	local new2=$1; shift
+
+	ip link set dev g1a type ip6gre local $new1 remote $new2
+        __addr_add_del g1a add "$new1/128"
+        __addr_add_del g1a del "$old1/128"
+	ip -6 route add $new2/128 via 2001:db8:10::2
+	ip -6 route del $old2/128
+
+	ip link set dev g2a type ip6gre local $new2 remote $new1
+        __addr_add_del g2a add "$new2/128"
+        __addr_add_del g2a del "$old2/128"
+	ip -6 route add vrf v$ol2 $new1/128 via 2001:db8:10::1
+	ip -6 route del vrf v$ol2 $old1/128
+}
+
+flat_remote_change()
+{
+	local old1=2001:db8:3::1
+	local new1=2001:db8:3::10
+	local old2=2001:db8:3::2
+	local new2=2001:db8:3::20
+
+	topo_flat_remote_change $old1 $new1 $old2 $new2
+}
+
+flat_remote_restore()
+{
+	local old1=2001:db8:3::10
+	local new1=2001:db8:3::1
+	local old2=2001:db8:3::20
+	local new2=2001:db8:3::2
+
+	topo_flat_remote_change $old1 $new1 $old2 $new2
+}
+
+topo_hier_remote_change()
+{
+	local old1=$1; shift
+	local new1=$1; shift
+	local old2=$1; shift
+	local new2=$1; shift
+
+        __addr_add_del dummy1 del "$old1/64"
+        __addr_add_del dummy1 add "$new1/64"
+	ip link set dev g1a type ip6gre local $new1 remote $new2
+	ip -6 route add vrf v$ul1 $new2/128 via 2001:db8:10::2
+	ip -6 route del vrf v$ul1 $old2/128
+
+        __addr_add_del dummy2 del "$old2/64"
+        __addr_add_del dummy2 add "$new2/64"
+	ip link set dev g2a type ip6gre local $new2 remote $new1
+	ip -6 route add vrf v$ul2 $new1/128 via 2001:db8:10::1
+	ip -6 route del vrf v$ul2 $old1/128
+}
+
+hier_remote_change()
+{
+	local old1=2001:db8:3::1
+	local new1=2001:db8:3::10
+	local old2=2001:db8:3::2
+	local new2=2001:db8:3::20
+
+	topo_hier_remote_change $old1 $new1 $old2 $new2
+}
+
+hier_remote_restore()
+{
+	local old1=2001:db8:3::10
+	local new1=2001:db8:3::1
+	local old2=2001:db8:3::20
+	local new2=2001:db8:3::2
+
+	topo_hier_remote_change $old1 $new1 $old2 $new2
+}
-- 
2.45.0


