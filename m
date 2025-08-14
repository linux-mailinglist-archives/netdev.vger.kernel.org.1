Return-Path: <netdev+bounces-213700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599AEB266A2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A715E22BA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733D303CA7;
	Thu, 14 Aug 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KZ8I7miw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520D303C8C
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176907; cv=fail; b=id9n+RPNNwVCrbjFV2RvVA7WolaZWprLhu3Odb7tbOS2l6U+YetOf6Nh70nZ2DpcIXas2+vS2/xnoqlhpwgnS55N4EDxoRlv4xaUfL4Z6YyThha90UgeMLRylNh4o7T5EYRsJyDcyelURy/53+ysFdqwBQH9zL+Uury9xiYJLUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176907; c=relaxed/simple;
	bh=71aIZOEX8HKYmRxVW16jcOnSqRJzg4zxV7qHQ58Kkdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/2azSb8evmaOGg5w9oR2E8o34UpT7pOkPJxbxsn7ZF3W8W4KGmXFn3oWDY02B3zdbvd2pXEYI82qAxCy6xTZiR+TpRgNaIz+ECM3oa8oqcNhU7NCZJkhV7qQCwdbcKNHuIqs6MezexveKKUPoR55S1IMt4MHhkPNBTs5BqOozc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KZ8I7miw; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB++RKOtKsQGJ0JCiplrjzZUkQW+Vi/MJQNGFNeou+Rur+t0palGcDO/aXRoHXGHGUgoY6lcWI2PvRT56o/NwoN38Y9ua3rT12lJHsgTWlr7n7qjOr/dwYbyz13QVglMRqNkHhc1zUwBdGm9FBCv4k08otNfXeL93LWb3bkJrIyy+45JcRooPtiRgViwCaol6C5t0udDAZAgD63ukgEGq2BWsX6WpNN8UBSYgnwA4YQQY89olhqiOvKubf+I4s8VdwqhPQ+yvcE1zRsaRcespdd0fOEu+Phzdwy5hNmCTxoMc1Sq7s/JpVEhZ28hhFHxJjQnkS11ZkzwI5gi/0ICkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RpR3J/bON/DP851dAtAwUDl5khivQis9t5DPEZownQ=;
 b=JTLnnNz3iF1MN8X7FmDHsXUQ5mgLivrD57ioaoiIH4QqO8lghaPmELeTB66w1pFLxuOnixKK2z/FsOc/HqOHAl7i5YN5E6bBPIcDAS21t6kTQ3D3FJUyYPYy4GToIahcH/+oR0WuL5eDunx5asOo/ZEAbBjvBAfoLBHvFo/QD5kdEuFR22WjkBgh3ipjB9VdgfDwjGBPn82uMpQnrLIrPHdQPSaW0Pl+WC4xSYd2Pqhon6/sP+RjV8IvYNNiwj79aqg7KZMeBxVmpwSPmQgFu2KLuoZlUCz5YCP1ys21qCBdKx9pTf4heYyzfZXs1amXs9m0Vp9Ae1XQHtWhCmViJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RpR3J/bON/DP851dAtAwUDl5khivQis9t5DPEZownQ=;
 b=KZ8I7miw27F5dNl24MqvvL7gzN11YEV3YYsKu/jk13DK1TvR1KpKKnqybILtr90gUzPjdgH3QXtczxzfJj948pw+42PlnRDkTR2UKlbADO1CvvySfq13LaUXmtva7W499Bq+yhvYoao2RJfhE8Y/QwAg9nF1ZhNR6GzNsx8i04G5ZRwMvzPFf6yiBW00wr7HQTGVXNNy6FueSEdR3w4HQOiPAyqTl5dO5JeWS81Q1F4E9IbOw2K8I3uNuUCJjmfRQzYizqJXUYrNmh2Uf8hy72Iq9vGF9t9SFY4xi5b8tVi+piutkdj0FHQrdcP2yZ5RX/2VszJrqzctVG030kgWcQ==
Received: from SA9PR13CA0047.namprd13.prod.outlook.com (2603:10b6:806:22::22)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 13:08:19 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::c3) by SA9PR13CA0047.outlook.office365.com
 (2603:10b6:806:22::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.4 via Frontend Transport; Thu,
 14 Aug 2025 13:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:08:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:08:10 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:08:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<mlxsw@nvidia.com>, Zoey Mertes <zoey@cloudflare.com>
Subject: [PATCH net v2 1/2] mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
Date: Thu, 14 Aug 2025 15:06:40 +0200
Message-ID: <6721e6b2c96feb80269e72ce8d0b426e2f32d99c.1755174341.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755174341.git.petrm@nvidia.com>
References: <cover.1755174341.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaca269-9e5b-4735-f825-08dddb33a384
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?z8jwmrplZ3DWjUlwQxnCL243vNKUKc40eddGyWgrmUyB6yUw4FHKoYyYAyq0?=
 =?us-ascii?Q?xnH/nAVWtHxMRl1lovM/99D3x4uW5EI64PdHDQwcnwGWT5aOaHvyj4Mm07pU?=
 =?us-ascii?Q?EwIaCFqF9dMlKr0wWzDSsyzW9OTu6SMy4nPYDkN+xBmHC4hvzrhd6G++A5iH?=
 =?us-ascii?Q?PJfwNFUt5HZ9d8RVb4A+TS3dCjCjyFzJRAJ47aP1QVWDrt1gUUxw4EguiQAv?=
 =?us-ascii?Q?33ukrYSj0czEHBmB9Ie2qi7aK1YMN70edYZtQgSqFPu9BFMWjYI5Ka31Hnc6?=
 =?us-ascii?Q?HMn85iwgQh4s+xs0KClbJGPjzcPLmH7Ie6VVw/itp7vaxEgPLIv/9jbEYvO/?=
 =?us-ascii?Q?DIaA+8UW45oC+jDbD0djV7lm7u6K+4g24pZ8HAOTxXjq+AZu4J/y9YQmvzoZ?=
 =?us-ascii?Q?PDnUYCVONMJT21V3png0b/lqzRMF+sk0y2sxUfFg2+6+8GLAkx5g0njbRCPJ?=
 =?us-ascii?Q?/QPN/EjPCL7tL6NXYEZNuUWbk1e8204gfXUv8ANDCeIL0okt6OAx85reMGJI?=
 =?us-ascii?Q?AEssg7e3Gj2VwSzcwNrXL3u1L+QY2oAWfGjU9fKM17UCf/BBn6m+jTTNsWdO?=
 =?us-ascii?Q?ztLQKMtR/Aup7FjzFV4FzJ11HKeWt5VXH8WEV+7snBiFuWtRJ1HnXiMnSuKw?=
 =?us-ascii?Q?ut1Vb0Lnb7GePLIAOEWCaibhn1073RmYmIwgjj0WYi9udg37mu4+lrIvRFFd?=
 =?us-ascii?Q?UqOkG5qnK8Uyf60vOYKQlt4zkNr1ZV4eOe0w/2/ANZU68E30rfG3LslCGIMq?=
 =?us-ascii?Q?TN8JEnCABbCqWfiqmih0z7i8Hb83jrg1F01fcftduW5kaGhjPKdBPiP0A39b?=
 =?us-ascii?Q?qAV4jaI9fEF4P/Ze1/r9HUQ3gyZh+P3KV+kuGGC+LC2D4Q9CBGq1T4As0/Qd?=
 =?us-ascii?Q?ziQYDzTcCKPu/bFa2i574zPUZO2g/z2hJZQm++TRs9e4kSTUD5XqhiKcBQsT?=
 =?us-ascii?Q?GvqzLdF2DkJgw+7iprV9BtDPQ/4NeK4acw1Y/Yd1UnkATdRshrEr1b4QkMY4?=
 =?us-ascii?Q?9mYyEJx9TXsGspz/reDLTbBCDjhfR6EdmZAEmjJ69/zfWpYhWKBg/q3u0pb6?=
 =?us-ascii?Q?qKbgOVMH/lV92Jx3r1hXKP5/pfojqV+jx/GklEQkNo4O1QNMGqjDS9LLmhDl?=
 =?us-ascii?Q?S8otINFLcLGN28yu1IOuvRPQ1JQx21yR/H0BCnxFLzpQJtShMOOkUchuw7DO?=
 =?us-ascii?Q?i30PaZV+KUYGaK0DNWpUF/UPnvOvL4h2nBOLPPtEKyvpWH+kr/A0rH7vxEGw?=
 =?us-ascii?Q?Og7cuk95L7HEgIG+dbL+Y7KytHtdrC4KbJ4au04MuXZBCTH2OLKGEtaV+b6S?=
 =?us-ascii?Q?M3VOXME1q5xB0AxjY3zpJedswlS7BhZUHqOrQ01MSQ5CF22cJXrV8vywn+2Y?=
 =?us-ascii?Q?E1g0O4N/oon5M9htMNr8I5ckmQgM74/LBxZ9c58evS5GVrNIUB1kV2OjPKf0?=
 =?us-ascii?Q?/eznJLCMhrxlu5+dYNDIxddOUFxG6fkTtbYybWYZjgREM0CCRvj7TlPzhDm9?=
 =?us-ascii?Q?Cuc4U1NyE7QB4dOT7bF2cpRnUtxpYwf9Frzs?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:08:18.8642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaca269-9e5b-4735-f825-08dddb33a384
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

From: Ido Schimmel <idosch@nvidia.com>

By default, the device does not forward IPv4 packets with a link-local
source IP (i.e., 169.254.0.0/16). This behavior does not align with the
kernel which does forward them.

Fix by instructing the device to forward such packets instead of
dropping them.

Fixes: ca360db4b825 ("mlxsw: spectrum: Disable DIP_LINK_LOCAL check in hardware pipeline")
Reported-by: Zoey Mertes <zoey@cloudflare.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 ++
 drivers/net/ethernet/mellanox/mlxsw/trap.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 618957d65663..9a2d64a0a858 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2375,6 +2375,8 @@ static const struct mlxsw_listener mlxsw_sp_listener[] = {
 			     ROUTER_EXP, false),
 	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_DIP_LINK_LOCAL, FORWARD,
 			     ROUTER_EXP, false),
+	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_SIP_LINK_LOCAL, FORWARD,
+			     ROUTER_EXP, false),
 	/* Multicast Router Traps */
 	MLXSW_SP_RXL_MARK(ACL1, TRAP_TO_CPU, MULTICAST, false),
 	MLXSW_SP_RXL_L3_MARK(ACL2, TRAP_TO_CPU, MULTICAST, false),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/trap.h b/drivers/net/ethernet/mellanox/mlxsw/trap.h
index 80ee5c4825dc..9962dc157901 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/trap.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/trap.h
@@ -94,6 +94,7 @@ enum {
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_SIP_BC = 0x16A,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_DIP_LOCAL_NET = 0x16B,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_DIP_LINK_LOCAL = 0x16C,
+	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_SIP_LINK_LOCAL = 0x16D,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_IRIF_EN = 0x178,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_ERIF_EN = 0x179,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_LPM4 = 0x17B,
-- 
2.49.0


