Return-Path: <netdev+bounces-135333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8363099D8A2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427CC282767
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DF1D279D;
	Mon, 14 Oct 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNyqNcDe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921521D89F1
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939303; cv=fail; b=Ve8FzQZ1SW0Gk3LAKDjzTSrU1Nb6ULbpr6Z+tCqufIhhTQEwxL9LLRSXwR3MhioVWMf9r8/hqjiXEz1wnCjhNEK002TmZk/K9wX3tipfi3/IxD/Pg+PF4MyFZBUVWRqXij2loqs1ZDxdERVsZuVcwxPjNy5ZjBM/9KZViMrFs5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939303; c=relaxed/simple;
	bh=3ndkomccHSzoxvPlj+dYmHnV35jwci+om0km4oZnWzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JazHqu/JIYECmsUs3ypL4+ZRrl4bjFTe7N3ZLurseeujTzT+DT9EuqPd+yhx/Ca2sSjfrypiGlcqkRINU/qNtditnNUdVhNr2GKdXmrJ8VEIMaWXt5NXstVN9SyoAfO+qqufTimgEBArAgNkNtjgly0mcq+saCChveGowpIVblc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNyqNcDe; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAj7Mt8XfEj1ymLgRRex4PCQ0Uj/Ioq2kH3rfG6R05riaZ5nrzq7Lenqb+dkkfI7Z3xUJ8u0VvXg+C1wbinvONQ+7I4BnCnOa+E5fRErR+SK9ODqyJP3qb9q7weScAE0oftIz6Swtyz03H+Sn/8K4zx8hhCol10C9sUd0tILGg+REnIlz70zZUPv/h7ccSvUOwgXFIyQODJxzMdE0/QdG4DbO2QWFE3g5oF76pqbBgLGJRv4r5Aay5hAXTA450G3a0Zd3iy3cLLqygfEgRxzJhe6yIxsGRITFsuVvSICWTAVj72PkxfHmvaU7rKJsldowx5Wn8rLhhcf9uW7qCmSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeYzfla2qMqlpadDr3MJ2Bc6hnipuwXYDrlL3CnlCo8=;
 b=DPxUCt547hT0F1dYqXRv2fsOV5ZCWgAlyLDkQnp5bLmE0fyHqGMX5Fag3kBNhBAg7V5bQR+Iha0OqlARI7jsTbCK2/oOHWiX2q+jqQt/XyhuOwiolmPPc/HbfvNNFbhcwclVc95s+QG9EO43iFMH1W83Y+yEGkJkPa1OeISPpi+5lXG1yqjS4yhU3jf3lsn0mXnkhzKw51eXccZuSzbOvfz5jqkZunDkYAOEzoiuIYz04CvtpmAmlJhQNxSwNuBHneebj6uD/P3IMToLko6MZd3cxA2Gm40DnxhpxbGNWQDClTAIkjBgfRG8mh5BdMwqfLfEX3cjSgWd0w9F/6bZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeYzfla2qMqlpadDr3MJ2Bc6hnipuwXYDrlL3CnlCo8=;
 b=hNyqNcDe0U4rhva1IIlJnGcQr+RelOOivhbJeaZvgoM1/dNYncfckmZit/urKcQfVpE9Lb5Bodbyw3knEeDRD5ovIBRpU1Hr1GXJnecd0An4FD5bne27EslvohtA+wjzAUpsRZGEqQrRY6IIFx90aWVnSL5ejp7T4BqkMM+H4HXmsR9ed1BnmY/VyWKQ9J6oQMvVNob3DFV+CmxfAtNrf5SZgHWWFOams9BdalIjXEh8sq+gDKWFmWbylj4kDBP7Qp+8dTqG2iKD+lkixFJnXW28B+tuvvRDvyAYDA801N0car43HWiW6kSFGWLqR04alAKlon5/u/NHjJaOmOYXUg==
Received: from BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 20:54:57 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:117::4) by BYAPR08CA0053.outlook.office365.com
 (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 13/15] net/mlx5: Only create VEPA flow table when in VEPA mode
Date: Mon, 14 Oct 2024 23:52:58 +0300
Message-ID: <20241014205300.193519-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: c8111aef-b18c-4c9a-1a1a-08dcec927646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o45/p4bhUlCTN/mS/kwZ3pk51ouz8BTaXsThIPc6zdDWbkmHPFhyj3+12oLo?=
 =?us-ascii?Q?BEWyU4mNMxe6UU3gyBqA0zVATTde89FL3B7MBfBwTX+CO9qmkn54VTOTQC8i?=
 =?us-ascii?Q?RsXYElHgLsCO8m6yIy2i4OMhx6le2eQThnSuHKOYFcdH2xGMLOphuN8UZwF7?=
 =?us-ascii?Q?FH0CG7BFbCJe9fI0ntd6+q4Z1+TRjnuxDHWa6UMsJ4/rYM1l9EfvL69yx/9j?=
 =?us-ascii?Q?3Il+uhZjtaQIsMvtzhSDoW/OZ6UYfi62F0jc8K2KcuXYOzBufHZv5wMNxjkR?=
 =?us-ascii?Q?jqp0n3gl8Zmg0q33HruHeMMy4pdp8ZJ9Wqr92A+rTuaRL9mCXHPUx4Ylewpk?=
 =?us-ascii?Q?7vC/aVJrcNDlCP7/O2VJjwYAir60Seb26UdoSoEfzNMJwme9PdjpcOEvOxHG?=
 =?us-ascii?Q?7QFygtk0axlcafyoSzLy7tmFjZWE4d/FOC9NSHHWv+ZUPSR2qKAzihPaVZDZ?=
 =?us-ascii?Q?C6MpAX18p15SmSi5Sxsp9eqgv+omlzE09hRyQRBFf1LhclYf9LbwJb3LPcHY?=
 =?us-ascii?Q?K3y6nzkwPnArsTZ/q/MqAZg5Esn9jm97HaSn5w0E8bZfpxWI8up/DInyQ1E5?=
 =?us-ascii?Q?v3RnLEIgZ83WCNtPyeq+7Is9gx8tsJILxLKSb0qoEBFi+SaSgnDGtBADSg06?=
 =?us-ascii?Q?UGOJtMuakfdHsBBa1ZvlUw9KtkQc7gAmm1L4Z5wpuW22qk1kfx6z5xwUa4ZO?=
 =?us-ascii?Q?X9RLx/VZG1MWOD49z0cZ1+nXFavdx+IFH2Mq3aj36t9f1FMEEVq8DRngHcSg?=
 =?us-ascii?Q?wW+n7+qM76Kq9f99m0NxkX5HAdKTg80CEZd2mrfrvtaiGsiC0AmAxK+iXVvj?=
 =?us-ascii?Q?W9bf3SVkY+1fPsVVJYKrWoF1fvaGICw69CDi9JKZnC6l4RuZIYVOO9XWkA+J?=
 =?us-ascii?Q?dtZRe6EgbOYLdtD3UR6p3CM4PgjkZaR1m4sxRv9mGcueqJvm9ROF3zgVsyNt?=
 =?us-ascii?Q?w3N09YmhG87ELWGJ/14LhqNfzJLdAAXvg9ieg0LbiRUUQfLla4J4087OEK65?=
 =?us-ascii?Q?8m+kgVZFx9rUQaYKYuAxtfRzHkT1m9ltMLNeT6ic12JCLbv3sKTKXYp6EtaZ?=
 =?us-ascii?Q?yJJ4/wHENUTgvGRpLFCnNDJHNx5V3SEBRZyPkt393oWAzKcu8y5sgQiAU9J7?=
 =?us-ascii?Q?AUli9qc71cZNYluy29HOkTUPyWcGFyYOtahMEP9z1SgVISoKMRy/6j0EiyfH?=
 =?us-ascii?Q?ciNA1ci25FzV41XTt7NxkHwCZvUdJrVeES2ferR9BkeAwMBXRIp4YWTBEYAN?=
 =?us-ascii?Q?cN3Rmul0sozCozBBADyr5pGCAvh9UawS7UmcJ3htBjbWcFOaZ3M30qxlKvBx?=
 =?us-ascii?Q?2eNmXzLLreqqnz4bILqyg2Ye7mT8KON32VT/p3cBXE9ZN6Hlbkg/EByePw7S?=
 =?us-ascii?Q?VB14yYoEWPdMbYOfXx3D2+ixM9I6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:57.2047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8111aef-b18c-4c9a-1a1a-08dcec927646
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074

From: Benjamin Poirier <bpoirier@nvidia.com>

Currently, when VFs are created, two flow tables are added for the eswitch:
the "fdb" table, which contains rules for each VF and the "vepa_fdb" table.
In the default VEB mode, the vepa_fdb table is empty. When switching to
VEPA mode, flow steering rules are added to vepa_fdb. Even though the
vepa_fdb table is empty in VEB mode, its presence adds some cost to packet
processing. In some workloads, this leads to drops which are reported by
the rx_discards_phy ethtool counter.

In order to improve performance, only create vepa_fdb when in VEPA mode.

Tests were done on a ConnectX-6 Lx adapter forwarding 64B packets between
both ports using dpdk-testpmd. Numbers are Rx-pps for each port, as
reported by testpmd.

Without changes:
traffic to unknown mac
	testpmd on PF
		numvfs=0,0
			35257998,35264499
		numvfs=1,1
			24590124,24590888
	testpmd on VF with numvfs=1,1
		20434338,20434887
traffic to VF mac
	testpmd on VF with numvfs=1,1
		30341014,30340749

With changes:
traffic to unknown mac
	testpmd on PF
		numvfs=0,0
			35404361,35383378
		numvfs=1,1
			29801247,29790757
	testpmd on VF with numvfs=1,1
		24310435,24309084
traffic to VF mac
	testpmd on VF with numvfs=1,1
		34811436,34781706

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 288c797e4a78..45183de424f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -176,20 +176,10 @@ static void esw_destroy_legacy_vepa_table(struct mlx5_eswitch *esw)
 
 static int esw_create_legacy_table(struct mlx5_eswitch *esw)
 {
-	int err;
-
 	memset(&esw->fdb_table.legacy, 0, sizeof(struct legacy_fdb));
 	atomic64_set(&esw->user_count, 0);
 
-	err = esw_create_legacy_vepa_table(esw);
-	if (err)
-		return err;
-
-	err = esw_create_legacy_fdb_table(esw);
-	if (err)
-		esw_destroy_legacy_vepa_table(esw);
-
-	return err;
+	return esw_create_legacy_fdb_table(esw);
 }
 
 static void esw_cleanup_vepa_rules(struct mlx5_eswitch *esw)
@@ -259,15 +249,22 @@ static int _mlx5_eswitch_set_vepa_locked(struct mlx5_eswitch *esw,
 
 	if (!setting) {
 		esw_cleanup_vepa_rules(esw);
+		esw_destroy_legacy_vepa_table(esw);
 		return 0;
 	}
 
 	if (esw->fdb_table.legacy.vepa_uplink_rule)
 		return 0;
 
+	err = esw_create_legacy_vepa_table(esw);
+	if (err)
+		return err;
+
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
+	if (!spec) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	/* Uplink rule forward uplink traffic to FDB */
 	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters);
@@ -303,8 +300,10 @@ static int _mlx5_eswitch_set_vepa_locked(struct mlx5_eswitch *esw,
 
 out:
 	kvfree(spec);
-	if (err)
+	if (err) {
 		esw_cleanup_vepa_rules(esw);
+		esw_destroy_legacy_vepa_table(esw);
+	}
 	return err;
 }
 
-- 
2.44.0


