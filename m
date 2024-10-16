Return-Path: <netdev+bounces-136222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D8C9A10D4
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F72809D9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A9212F13;
	Wed, 16 Oct 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RS6KYfxo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE858187342
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100302; cv=fail; b=Qgc8p7eOSGEARUwWpPUUmxZoe+BYkHqXMYqlkD++ji8lWcq5xCTCNGlPlgdgtwmz1NoMX985ZaL29Q0IsMzt6kiqVg2/bl2fJms+F93r5QVqrDUKio4c1N3Ud7E6wxh9vGZze1fOl4SWSEwbtRL4jUeUQtAh8ZHLv8aqiK3UoP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100302; c=relaxed/simple;
	bh=XWoF5XaVejxIkEO45xtz3w48T0S5rypCOKStgFdtwlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv6cQXGfFgIgADGT/2buJgtftCG8itf3FcEe+n59iZk3EcndbE2vXqBdGGg3at3NyoWAkUsq6t5TLLQM2BRsR98C1bK5VO+DvqV7HAqXSP0SVnN3AGWdNZDHcyvb2wnGfCuH4X9TSBcU6xkp19p76zeO7RadInh3vsGB67pVywo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RS6KYfxo; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keA2X9OyOreEbVRY31/yGHehOETvd8EgwpIpU52qPFzEAtmlZWdEeEJ32z+QRZavFh5afTVUGAfLADg477ree3jmSoFOWr+OR48aWQgIJcQwziGFqoeEABBeDZyc6TuGNj1HIgO90JqyuZ2iti2Jt4a688+I+3jiCzReqssLrOA2RnNQey/L1CBcAKpUAkr3s5SZ9PWRssUvQgIi1BO1URjaIKgiuffe7JQhq/oyHNcv3DlrBCSDrDxJL+ttzxZke/JBQwCxes8/UYsgLhWpXt+G9R98qGBhYIYIKWFuxtD8nv7aYuqDSnFIuJPFPY7el8NajBH5dh9KFLt5A3O5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXmAcoLyOzxRrnd1ljArjHduOwLqEnTp9kIggX8ZN4w=;
 b=CU5gf6p+lHo7gUBi2VtrVuGi2c51U1B3KvcBbWwxsX2J3r33GYdSmGaWTSlltkQs6ZDScgEImSH/4LQXqfH2FCDg/NGEfnzibeYPY4JvAS3FBq3QD3zD6lrb/FV4Jo6W/COwQPu05+3zaVRa5AHmQF7W/5O9fitRI8K77klTYeMVB0/NrxxgLui9SOTlVUf0kt2DSuNoGCv6ta3PgYhO0XgEjdUJMekyv67SEVgv3kOiefOps5n5+uGrxVvV2s9qBJHWGYt7wOhtuS5XkO75/JbTAXr3h2W1FyaidOoYowUsqT6tEzT78+bT1I/lYgc8OsEkOg2ZYwyBt3i3bdwXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXmAcoLyOzxRrnd1ljArjHduOwLqEnTp9kIggX8ZN4w=;
 b=RS6KYfxoJDN8fAU2JDf/n6kxggAl8+HHoOw+tKN+NxJ+9CCFI1eqMuJ5pmN8pbzzNP7cMxc7lwE2P6sGn5BlCveGKAEU6WHHnsIAaA1bLDXiMeq9e/A0uI5e2RkyUUOsMrCjV5f4vWZuvIatASSiZD8Caoes8NCW2QznX2yiL4lFk+4JqZwQmXLmY9qDJPQr5Z+l9e2b9o/ZwOlTcXEAy3xaaG0tYU3mfXLj4izEcHtkujq0jamQzWJkqxBdYqbze8ILV09sWXXG0dpoZpnGKtD8JdEK/gvdJwbiAfJfHTYJztTjTWrhc+8yMdQ7quzjGqbgzK8zeZbuZ0nXGqwMOg==
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 17:38:14 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::81) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 17:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:38:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Moshe Shemesh <moshe@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 15/15] net/mlx5: fs, rename modify header struct member action
Date: Wed, 16 Oct 2024 20:36:17 +0300
Message-ID: <20241016173617.217736-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c96d0f-01e3-41e0-5fa3-08dcee095005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?10PkB/xw5HRr8OOMRTpR7Lc0uCBiLYSOmao0Wk1/m2H/1RYdBoBx7RsBgenl?=
 =?us-ascii?Q?ISuTrdzpIWvuvG6e2FhtHEwOnlI4E/29s2KrZCdO8YDBoSNDFkMRXlE6FQQk?=
 =?us-ascii?Q?usyA4OlPS67YWi8ATakttc1Q6ymdy2qOzB+5/gMf2lsfPYxpCYSLTqVn4aP+?=
 =?us-ascii?Q?O8Zk/kzXFFow6uXRReTc8wMJBiJ0YF4DnRXuq2lx6C58NmomD358Qq9XmJE+?=
 =?us-ascii?Q?z1h1yUfKUBlmTnnDAIbP2mi/umem6TWDWYeSPkbASMmYwYDE6j2sScl9h21A?=
 =?us-ascii?Q?L/vLvcLtMW0Z3XHJc/pY4+RzzYrjmSoqZq4FMnIIOLW46rDd1lYPw9MiCPy5?=
 =?us-ascii?Q?0q3dubXTB1ukGwDDIJZIYYkeFXXZ4gtvxeOIgKToYvLhLkqmw5R5/+IYDwZF?=
 =?us-ascii?Q?UvUmvuMxZ4eBvYpeV6p/QuvsUaPDhoeEfjgEht+51ZxYgc4/9aomlPaZQfA8?=
 =?us-ascii?Q?Xs0DrdmeUEh3R/uWqCPqIh+H6mms+cwyX4dtmVJrDtzYB5hOSN4eohOIt5RR?=
 =?us-ascii?Q?gzUWH7SNDVR7xs/qEW2QpHs4J3vW6Kpjtda3otFVIfvVk5Gqt8N/0o9rdjrV?=
 =?us-ascii?Q?nzCPeavHGF9ySbpAHnr3TNhEC/CiANtVTwgXZIWV1jld51b6tKOB2XvzrjCw?=
 =?us-ascii?Q?TKUf8me2PebZEtZpRdz3RrM5BJ4BOVzRLjtQtJDuw5MeWVWcDnO4QFu7yNo5?=
 =?us-ascii?Q?idmmlIu+SjbDlku49CQDclUjYJbd0EIR4ARFxYq5ZODwuhdzCT0hQtF2ejqW?=
 =?us-ascii?Q?oAs32XVMMwgi+2Dt7igX4vLdiqq79MPRj1OQCgsYn9Kic/sOyiTrsJvtGC+s?=
 =?us-ascii?Q?bfpxM9wr15BhJlgei8zMKpIj/S7sKdDUtQSeIx87vry4pyoNwaVpGOlrIJhw?=
 =?us-ascii?Q?epfF9G16OVNAikia9FkHGtrkFcBJq5AnAiVHW+8JjI7AtpJ0P+tabG6A/mE0?=
 =?us-ascii?Q?R33lrZ/aGdVYKGTqPh/QDreV4PJ3i9furNjSX48mk+V3tM169iph4csw/o85?=
 =?us-ascii?Q?1qdMmBfbJR8tIpFSP1JTg18TldoEk20Frq7w3G4eMLFJ5iC0rFkEM0kZMsux?=
 =?us-ascii?Q?Alp1Bvb255S+Am8Z8IJ5ThMJTSSLn3HrVkYXqVPC11PyLYsNZbm0R4QTAuvM?=
 =?us-ascii?Q?Kdpc2d4vnXQLKRYllaCKG9y/qPdCfL7fkMr4tCncUz3vKBXzViJSASChTgkN?=
 =?us-ascii?Q?NBsYEFfnUxLVic/xvGWwdF4jUMqv26PizgDkEjn9s3l699l2w9ftbolRezzQ?=
 =?us-ascii?Q?gzGmCb0+kZQtqEFblAIpniNixv1emSYjIor/6WZ5AJjpNlR8RiDKZ9aTwHnX?=
 =?us-ascii?Q?edxYS8QqAfyKkHlK1Zw0/DW9OAszgkuc3mpKgX17KXzltM2Ywrqw03fl0DdV?=
 =?us-ascii?Q?9QrxH0ryzItTJ4So2G2uRAzaTaaO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:38:14.2382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c96d0f-01e3-41e0-5fa3-08dcee095005
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

From: Moshe Shemesh <moshe@nvidia.com>

As preparation for HW Steering support, rename modify header struct
member action to fs_dr_action, to distinguish from fs_hws_action which
will be added. Add a pointer where needed to keep code line shorter and
more readable.

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c   |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/steering/fs_dr.c | 12 +++++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 1c062a2e8996..45737d039252 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -318,7 +318,7 @@ mlx5_ct_fs_smfs_ct_rule_add(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 	}
 
 	actions[num_actions++] = smfs_rule->count_action;
-	actions[num_actions++] = attr->modify_hdr->action.dr_action;
+	actions[num_actions++] = attr->modify_hdr->fs_dr_action.dr_action;
 	actions[num_actions++] = fs_smfs->fwd_action;
 
 	nat = (attr->ft == fs_smfs->ct_nat);
@@ -379,7 +379,7 @@ static int mlx5_ct_fs_smfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_
 	struct mlx5dr_rule *rule;
 
 	actions[0] = smfs_rule->count_action;
-	actions[1] = attr->modify_hdr->action.dr_action;
+	actions[1] = attr->modify_hdr->fs_dr_action.dr_action;
 	actions[2] = fs_smfs->fwd_action;
 
 	rule = mlx5_smfs_rule_create(smfs_rule->smfs_matcher->dr_matcher, spec,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 195f1cbd0a34..b30976627c6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -63,7 +63,7 @@ struct mlx5_modify_hdr {
 	enum mlx5_flow_namespace_type ns_type;
 	enum mlx5_flow_resource_owner owner;
 	union {
-		struct mlx5_fs_dr_action action;
+		struct mlx5_fs_dr_action fs_dr_action;
 		u32 id;
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 8dd412454c97..4b349d4005e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -372,9 +372,11 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
-		actions[num_actions++] =
-			fte->act_dests.action.modify_hdr->action.dr_action;
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
+		struct mlx5_modify_hdr *modify_hdr = fte->act_dests.action.modify_hdr;
+
+		actions[num_actions++] = modify_hdr->fs_dr_action.dr_action;
+	}
 
 	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH) {
 		tmp_action = create_action_push_vlan(domain, &fte->act_dests.action.vlan[0]);
@@ -705,7 +707,7 @@ static int mlx5_cmd_dr_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 	}
 
 	modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
-	modify_hdr->action.dr_action = action;
+	modify_hdr->fs_dr_action.dr_action = action;
 
 	return 0;
 }
@@ -713,7 +715,7 @@ static int mlx5_cmd_dr_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 static void mlx5_cmd_dr_modify_header_dealloc(struct mlx5_flow_root_namespace *ns,
 					      struct mlx5_modify_hdr *modify_hdr)
 {
-	mlx5dr_action_destroy(modify_hdr->action.dr_action);
+	mlx5dr_action_destroy(modify_hdr->fs_dr_action.dr_action);
 }
 
 static int
-- 
2.44.0


