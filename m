Return-Path: <netdev+bounces-155727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D415A037B4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F063A53D3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239661DED6E;
	Tue,  7 Jan 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/ihwTQl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F81D619D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230152; cv=fail; b=mg7O+530fWnuh4RaVEAiKVr4lLnlYPXULXVHk08bhM/xUrPAtZHYQLd4YAVU2g7RXiKrsJxSW4vnixEdnIVU+mF82vlcwNz9EELwGg5vzLI5M54JWTFiRo2Tabglol8N60cE8IxNbXxq0kxY4ubRT2ASSA4XYovBRCohqB+GR5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230152; c=relaxed/simple;
	bh=y3r0+mSkE117w8/dj70UTB5Vo5ObPWexy1kMuHJe20Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rL1nq5ytElad85YqmkZXJmzjouAxAjRmC+ic07Jh7w5DIeAVvFHgt8p4J7K/mMPt82BUA2fQfzEzMCjSWfJtI0i6Yfa6iiMX/Nzx208evTgzdrmFok49ErHrf+s2lEGTNXbqRPcZlAqBgLJsME+QjFLMRedFxzSVTstMoPuA0yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T/ihwTQl; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIcX/s0f75x2D/hSVcpVUcTGzQDFh0yXPuCgkPf0s9YlkIcJBiSM7fxWXpGfD2K8VArmlQM/o6vJlpGQXDDK8xmM/XgAxt0zcNLijPh8K5H8YO36nbhUHOHdPC1jVVEDCedWv9likqRT2Q76NaQGQbUGFgC5kUcwccuit1E4zQ0Va9ysPMxC6f9mzxjwGJYI0eATqtW868eXLEG3Dec+GN+7wJSjMvscvb82cjBKuFXnme5VpEdK7t+1gFHNnlw4PK4Zztl8roRRP89IWYAbiFdHq/FEJfFaXsoKi1nPaGm2vRLaCW6w6NT4yHPViK79MOAWfMTVn/Ee/vaaeDpwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH4cfsAUqLNN0R4iZ2w8NbsRaeZVdAUJKqtsDclcKFg=;
 b=apln5Yrz1h2U7X5VSbK9oge+n5981vKgNTHQtLLR8JgrpgyHViyVX6RnKVMvcAyYszIcndxX8jo6zXIXKXjNUt1duTkh1NsrbCWpUbHd5fXRE3b7401+2vBsYBahRHOAgKjSJvDBTmIFrMBcSBpoSh1x07uSLpKljDm82IqxdbPmB6Pf7MQtOzi04k/vYVn1fFqAPrfg6UxIlObdb6DuQazwOB2Fbhw7+7tx4uh+9/dTqyM2ujhxarDMi725QwfTQp6lAj/rqmr4NAuw2c4EOFgIzy3NZN9TZDXcZZjoyi/7CB60rKAJ01E8+G3uhxn5RluZoZoBuZu8Qdw4V7J3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH4cfsAUqLNN0R4iZ2w8NbsRaeZVdAUJKqtsDclcKFg=;
 b=T/ihwTQljKjMYgXJvj7G45Hb6n5Xw8AC83bi3q7Pf8lVP1rnSp/dQ9dIY4N1m9Mc6gZKBXTFWVmuxfhmscIx1vwwFnaP7w6qP9Vd61eKRzg8sslG4omNQI0nJWgEfso20sAQAN4PENxkH4PCKzulCPTwrPWBiX3d1SVM21Qn6qWjhOHxAYGdcwGyt1nu9foTmSZv4iIq1f1wJrqkxsTRgcswCIL5JyhX9ajkVJzsC72DLu0b5CNPME63QkLhkR7KBDJMwxF0DVnCOCITJ5IsWE/3PXcP3YA1cTRT9P/5TVRFVWrN3p4yMMy85y9owTRYcudYFnnwR+2uvk6eq3BBRg==
Received: from CH5P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::28)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Tue, 7 Jan
 2025 06:09:02 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::a2) by CH5P223CA0023.outlook.office365.com
 (2603:10b6:610:1f3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 06:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:09:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:49 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/13] net/mlx5: fs, add dest table cache
Date: Tue, 7 Jan 2025 08:07:03 +0200
Message-ID: <20250107060708.1610882-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 602aaaae-bf55-482b-9377-08dd2ee1c8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzKczP3Km08dFhM0BWRFsMXwASo5wYZzFCDBKYmEcb6k2DGupzD8aWpRRZNg?=
 =?us-ascii?Q?SV+P0cTIn5APTY005yZeyNvj9gT9kZaFzVBt/Xc3ySrpF+MWA1GkceG7eN4a?=
 =?us-ascii?Q?D5jUw0IivAfspcsq3xr/qF9p1DF97jt71yL+1veUm+4byqjYgqzkWBQiSc/0?=
 =?us-ascii?Q?HC5dI1nOZKJHjacvr4SqcwakiqUdEZg+msD+DXfMBeG8Ili+H+FT6VC4hR4j?=
 =?us-ascii?Q?2gycDBwmANqY/7AF0F6X5jYwptUMMazDPUsk5e/wFR7se041LSH1AhJ9dJpw?=
 =?us-ascii?Q?jNSJCjTKcDwLGMDQtBWImImD6xGj3Xk8A8czXDTGLuk5UJ/JYPjpSAGN9OLs?=
 =?us-ascii?Q?IdaP3kfjJFYwJp/WJxMU16q6UxcabqQsPSPJr0TSiqYzLUXtDwaI/vslbYt9?=
 =?us-ascii?Q?wkKoVBmzGtDfuBBRpiop5MHE9V5j7cNz103SX5lbjuhKwG7R2lZ4TW49sEFb?=
 =?us-ascii?Q?D5lWeIq9FCjWmnB/utRB7i0mts8gCsfhA8dyNykwxVRyoj9D+A/1ntbrzVZA?=
 =?us-ascii?Q?rslVjN7A2pw7lvwrCqHm91M8w/K/v8LnIdcvd0o+wd+ZNoIsnb62j5EOLfHC?=
 =?us-ascii?Q?/QxoZj4czE0+kuR5mj1v/b3pp3SLTTvl3Uxsdw0tv6oSfQxW9YupEzNbIBfJ?=
 =?us-ascii?Q?JSZyzZ/+6UjF1tR4pLhMoRSCnWPWt4NWbo1qBvgBbxGtmsY51aDKsFRvFKjH?=
 =?us-ascii?Q?aTR0nfXcWNKd0FysijqDe9A1dfPNCpcip+ca7ZR3a7L4qAwpjc1FArGcns6E?=
 =?us-ascii?Q?FNelQF4S3xAOoMqTS8oEKkVTMJvEe6PDSzti3o+VMdW8rDZ5UJEvxRtP7oKv?=
 =?us-ascii?Q?1+72soAd8gsjohWmWJKmtZyJB2V9mx+kP49+HTpOEnanDBo/cTJhXraui4Ui?=
 =?us-ascii?Q?NsxpSzjOnQg3XZt1paJKg43kasKQgQXuzmYBocsdl7JiYBOJRn6tAov1I4N2?=
 =?us-ascii?Q?TReokLu0oljDmS7esKubK0wbgLeowCh7IoSJ+/CFMaXmsV8Gg3ExGZSSht3z?=
 =?us-ascii?Q?EtAO9yxl5Esh2O354GCEOrzQv5m7EC0IcYc77q8JFy/bQ9j06sd5cybiBfcO?=
 =?us-ascii?Q?yg2mvCwJ2GmmdIk1LNB3AROdrKvSug0dOFdWvaAhc5A+r0dMoZ5Msegqam1J?=
 =?us-ascii?Q?c289pl5VgPahQNO9dJY9LSRFgJUHV7U27W5gYzRvxqJD+WzijoLD+d9CNiWd?=
 =?us-ascii?Q?KBFlpixD8R8trp8oh24I0LInKgD14soYe47K2L6np6QCtKdu4WSHJfbXBO/0?=
 =?us-ascii?Q?WL7xwfVk1BKlguZAPSiLsZuoeBVT3KrZ84BLGXNstxs43sMno6RPaNyNkURE?=
 =?us-ascii?Q?RwqboXUmanIxLbV5Jh7hKlI/UC5Zv5L9SYhz9WAd8Fovj3g7qVoDtb2eKIBd?=
 =?us-ascii?Q?d+mcv6ifMd/ozlkG5TvPADPbQDua5ubyH833Zl9c1A382hbKr1FQffCb8V3O?=
 =?us-ascii?Q?TS9ku2mOnoLXoCDp2RsvQapBKcV3jvtKxee+tnDVMkFo04o3Zs3Ujw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:09:02.4319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602aaaae-bf55-482b-9377-08dd2ee1c8ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

From: Moshe Shemesh <moshe@nvidia.com>

Add cache of destination flow table HWS action per HWS table. For each
flow table created cache a destination action towards this table. The
cached action will be used on the downstream patch whenever a rule
requires such action.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 68 ++++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  1 +
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index a75e5ce168c7..6ee902999a01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -59,6 +59,7 @@ static int init_hws_actions_pool(struct mlx5_core_dev *dev,
 	xa_init(&hws_pool->el2tol3tnl_pools);
 	xa_init(&hws_pool->el2tol2tnl_pools);
 	xa_init(&hws_pool->mh_pools);
+	xa_init(&hws_pool->table_dests);
 	return 0;
 
 cleanup_insert_hdr:
@@ -84,6 +85,7 @@ static void cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_destroy(&hws_pool->table_dests);
 	xa_for_each(&hws_pool->mh_pools, i, pool)
 		destroy_mh_pool(pool, &hws_pool->mh_pools, i);
 	xa_destroy(&hws_pool->mh_pools);
@@ -170,6 +172,50 @@ static int set_ft_default_miss(struct mlx5_flow_root_namespace *ns,
 	return 0;
 }
 
+static int add_flow_table_dest_action(struct mlx5_flow_root_namespace *ns,
+				      struct mlx5_flow_table *ft)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+	struct mlx5hws_action *dest_ft_action;
+	struct xarray *dests_xa;
+	int err;
+
+	dest_ft_action = mlx5hws_action_create_dest_table_num(fs_ctx->hws_ctx,
+							      ft->id, flags);
+	if (!dest_ft_action) {
+		mlx5_core_err(ns->dev, "Failed creating dest table action\n");
+		return -ENOMEM;
+	}
+
+	dests_xa = &fs_ctx->hws_pool.table_dests;
+	err = xa_insert(dests_xa, ft->id, dest_ft_action, GFP_KERNEL);
+	if (err)
+		mlx5hws_action_destroy(dest_ft_action);
+	return err;
+}
+
+static int del_flow_table_dest_action(struct mlx5_flow_root_namespace *ns,
+				      struct mlx5_flow_table *ft)
+{
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+	struct mlx5hws_action *dest_ft_action;
+	struct xarray *dests_xa;
+	int err;
+
+	dests_xa = &fs_ctx->hws_pool.table_dests;
+	dest_ft_action = xa_erase(dests_xa, ft->id);
+	if (!dest_ft_action) {
+		mlx5_core_err(ns->dev, "Failed to erase dest ft action\n");
+		return -ENOENT;
+	}
+
+	err = mlx5hws_action_destroy(dest_ft_action);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to destroy dest ft action\n");
+	return err;
+}
+
 static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 					  struct mlx5_flow_table *ft,
 					  struct mlx5_flow_table_attr *ft_attr,
@@ -180,9 +226,16 @@ static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 	struct mlx5hws_table *tbl;
 	int err;
 
-	if (mlx5_fs_cmd_is_fw_term_table(ft))
-		return mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft, ft_attr,
-								    next_ft);
+	if (mlx5_fs_cmd_is_fw_term_table(ft)) {
+		err = mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft, ft_attr,
+								   next_ft);
+		if (err)
+			return err;
+		err = add_flow_table_dest_action(ns, ft);
+		if (err)
+			mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
+		return err;
+	}
 
 	if (ns->table_type != FS_FT_FDB) {
 		mlx5_core_err(ns->dev, "Table type %d not supported for HWS\n",
@@ -209,8 +262,13 @@ static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 
 	ft->max_fte = INT_MAX;
 
+	err = add_flow_table_dest_action(ns, ft);
+	if (err)
+		goto clear_ft_miss;
 	return 0;
 
+clear_ft_miss:
+	set_ft_default_miss(ns, ft, NULL);
 destroy_table:
 	mlx5hws_table_destroy(tbl);
 	ft->fs_hws_table.hws_table = NULL;
@@ -222,6 +280,10 @@ static int mlx5_cmd_hws_destroy_flow_table(struct mlx5_flow_root_namespace *ns,
 {
 	int err;
 
+	err = del_flow_table_dest_action(ns, ft);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to remove dest action (%d)\n", err);
+
 	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index db2d53fbf9d0..c9807abd6c25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -19,6 +19,7 @@ struct mlx5_fs_hws_actions_pool {
 	struct xarray el2tol3tnl_pools;
 	struct xarray el2tol2tnl_pools;
 	struct xarray mh_pools;
+	struct xarray table_dests;
 };
 
 struct mlx5_fs_hws_context {
-- 
2.45.0


