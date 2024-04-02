Return-Path: <netdev+bounces-84031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30634895572
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9832283A8F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5384FB0;
	Tue,  2 Apr 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s7MXfyz6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB560DE9
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064749; cv=fail; b=cpN5dh/uexcVE5MVBWPNkmWZXL/VKSXexcfpyk4O5iMtWFuFjbzgKAVcXgZRZunQJs4Ioeed4oH2EIgctaU2w2SBMPyr40PYrGZp7r0iAANClih//cXqgreuFToipLYhzj/tKvzlsyKa3IZcKPGxV/d5eM9meZpRrqrGvM+g05U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064749; c=relaxed/simple;
	bh=cGS9cCZumgmkGF5dEECdsXXKu2oHjGGSvGNDf4Offd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjywsPUaxB+Kyd5ywYus6EKngXASUvOJtibTqBgOBT1ZPkAHhRDVKC+XgMFNPnd3DhzZqscG9gK7Hkqyi+VY6X8sOSebLmp/EhHTK1+J+ikHXO1cXoCjq76VruUzts37rdELrdtp2ZyY7OGPWjj9N/7SnNfcIDB3rfQqPgepPiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s7MXfyz6; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4cZQlK9MW+OBI3DQvuN3ItWJzsu7RxZcJLBbvW50dRKvkQlI/b5nUMiJGpLAPQRfwTMWf03cdXS/6W/V07K5W24BhdC9Lu/GFyezxQmHMG2kJ4vxhQD6jX8kXLA7RSg/C6IMOzfZS4t68bMQBvnHGGurbtwlUWxJdj1F3oRZJOR1m7jiuwx0bPNnH3u5T7wymastmbOb+6gCRhweCmGu67JxxmZZgMrcEfWwRqeyj4bo43x/M7ywhHl5hpAZ5gGW1o9FF9dLV+c59E060t8tRIdC/5gceS8f6bpL/fLjiWH6MZ+SmjPk+eF0bBLcXy1ETIzuBcOap4V9Lj+MtOmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+1yJ0acKB6HukH9yx+QiqXoNWp/WReecI5zzoTAjwc=;
 b=WT8UroJxf5zJmtPG9Ft/oFcIqOVwlgNXZVjCnD64GsLyYMVYaQQyEQjKF8TSxn/E/3+C/OkkfZhVBHjjZawjn09+OAC0i3WYV3/NgREuFqSXQx0uCjBSP+iVd56DbdZ6hkvctSQyZiD3gJ9g+dGvn/VED28027crCutdr8a70r614RhP3VxgP4a1JRbjtK1erPlEalFh+WA2EJUQZ/t2X8dyJH/OFMi3hcp7KCaLQsjI+4sgaChqZXUR0ifci06Mjr2oC5yaFATIydR7lH0GOQapfuMH7j5EXHYsRPzlEZGOMVy1gtKmxoC2dx0oXGRExw+GWdo2xfy0QBfQqWnVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+1yJ0acKB6HukH9yx+QiqXoNWp/WReecI5zzoTAjwc=;
 b=s7MXfyz6o7Czahh/7xMlqymZz43AM/MjxgSDMy1rUfsn2cptfC/dBwLQPsk9CPnqfDyHKjLGJpoLWhRW4q9G/SyALAgA2YAeRD2wc8kn9fHoR4tWC9t1LXPF7Ewlkhwzp/cCfDu8moEQ7FEwFO+1Kxewa2DdtCJglWCbOXeNmRYd8oYGHimyPn7cJ3wjKm9SCkahRLd85Nmi/s1h3ncirWdWWcs+3iqCypwVRFetOLbFXz9kXC5SSado/JKEpuXJZgIrJcIsiwyLdsc+NjIsHg+hSHBfm0WQnDACIiXAITv1PqDGlcYdSYBDzWfnsW6n6MdkqU1wlbJXUbTgg4k8rg==
Received: from DS0PR17CA0008.namprd17.prod.outlook.com (2603:10b6:8:191::15)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:23 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::35) by DS0PR17CA0008.outlook.office365.com
 (2603:10b6:8:191::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 07/11] net/mlx5: Convert uintX_t to uX
Date: Tue, 2 Apr 2024 16:30:39 +0300
Message-ID: <20240402133043.56322-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: e15fc4ac-1b95-4dac-861d-08dc53195461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MQpcEbm9efj8k3YSL5jJsnvighe9U4TopWd705Q7e2ttP7NhxfgWAnRkzjga0jRLfsm39DSvAXm018sS/1w9dMmjkU/hAc7HsE/mdzRJowLDpvyHRXjfoNA1G3zotlwAVCvMtItG3ffT6zmEs6dBkUmvfCSL1v38P71yie5q4venBY2d/nHkYSnR5S/+/ELy8AAq7p/mVhthW59gwu+PXuZFLwj1dJzs9VBoMe7p/5SkiDNFyj0pXCE1hULl3ZRdHn04Ttr0vW6H2WVDxcXjkhntXoXSFKMsy3nZRHpT+zVq2PtInd/OZM37BMVr5JjxmTzJeZwpbTk7r5PYwhv0jsKyQQQDkKAoKlA2kas0WnUe0QyJkLFErhCNaiAy0AAdHdwxlbR9Tx/2RjzKmdv9llQr/IwqRhHGV6JQoG3EDXT51zgvhLWNcPO31M7WSye+2b0eXxfJVppvCJB0eMS/fnT8DkrEo2Yd+E6U+KuBvwZii474eFkRFGm6FP3OfYqdjKhDV6wzAeXVqyRBtUb2BONWm8WgoJ/s0L7sazLq/kf2OYWQaIAuo3xRQt0Cze2353pSLxOmb8+RgchOArHkGt/jGEuXaxYffejydKbHbwB92mFexKm/FhZ7pSs/XrNiIFoPbQqR+XXIVoG/0mu0mKh/bozPaFFwSi74EGBOe84ktdWhkIXW7pajWFEx5oB8eu+gdx6HlUmWZpD0LQZJImOmesxzskdMXcUBUd9u/z6OfkrFnXVOJlX3pcgIMz3q
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:23.3170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15fc4ac-1b95-4dac-861d-08dc53195461
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

From: Gal Pressman <gal@nvidia.com>

In the kernel, the preferred types are uX.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c     | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h     | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h       | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c              | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h           | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c  | 4 ++--
 include/linux/mlx5/device.h                                   | 2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 84db05fb9389..f5a3ac40f6e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1160,7 +1160,7 @@ void mlx5e_vxlan_set_netdev_info(struct mlx5e_priv *priv);
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo);
 void mlx5e_ethtool_get_strings(struct mlx5e_priv *priv,
-			       uint32_t stringset, uint8_t *data);
+			       u32 stringset, u8 *data);
 int mlx5e_ethtool_get_sset_count(struct mlx5e_priv *priv, int sset);
 void mlx5e_ethtool_get_ethtool_stats(struct mlx5e_priv *priv,
 				     struct ethtool_stats *stats, u64 *data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index c7d191f66ad1..4f83e3172767 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -73,7 +73,7 @@ void mlx5e_accel_fs_del_sk(struct mlx5_flow_handle *rule)
 
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 					       struct sock *sk, u32 tirn,
-					       uint32_t flow_tag)
+					       u32 flow_tag)
 {
 	struct mlx5e_accel_fs_tcp *fs_tcp = mlx5e_fs_get_accel_tcp(fs);
 	struct mlx5_flow_destination dest = {};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index a032bff482a6..7e899c716267 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -11,14 +11,14 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 					       struct sock *sk, u32 tirn,
-					       uint32_t flow_tag);
+					       u32 flow_tag);
 void mlx5e_accel_fs_del_sk(struct mlx5_flow_handle *rule);
 #else
 static inline int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs) { return 0; }
 static inline void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs) {}
 static inline struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 							     struct sock *sk, u32 tirn,
-							     uint32_t flow_tag)
+							     u32 flow_tag)
 { return ERR_PTR(-EOPNOTSUPP); }
 static inline void mlx5e_accel_fs_del_sk(struct mlx5_flow_handle *rule) {}
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index c1844128effa..07a04a142a2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -95,7 +95,7 @@ int mlx5e_ktls_init(struct mlx5e_priv *priv);
 void mlx5e_ktls_cleanup(struct mlx5e_priv *priv);
 
 int mlx5e_ktls_get_count(struct mlx5e_priv *priv);
-void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data);
+void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, u8 **data);
 void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data);
 
 #else
@@ -144,7 +144,7 @@ static inline bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 static inline int mlx5e_ktls_init(struct mlx5e_priv *priv) { return 0; }
 static inline void mlx5e_ktls_cleanup(struct mlx5e_priv *priv) { }
 static inline int mlx5e_ktls_get_count(struct mlx5e_priv *priv) { return 0; }
-static inline void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data) { }
+static inline void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, u8 **data) { }
 
 static inline void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data) { }
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
index 7bf79973128b..60be2d72eb9e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
@@ -58,7 +58,7 @@ int mlx5e_ktls_get_count(struct mlx5e_priv *priv)
 	return ARRAY_SIZE(mlx5e_ktls_sw_stats_desc);
 }
 
-void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data)
+void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, u8 **data)
 {
 	unsigned int i, n;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 55b7efe21624..a74ee698671c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -274,7 +274,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_rep)
 }
 
 static void mlx5e_rep_get_strings(struct net_device *dev,
-				  u32 stringset, uint8_t *data)
+				  u32 stringset, u8 *data)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index e7faf7e73ca4..2d95a9b7b44e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -283,7 +283,7 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	return 0;
 }
 
-int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, uint32_t *sw_owner_id)
+int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, u32 *sw_owner_id)
 {
 	u32 in[MLX5_ST_SZ_DW(init_hca_in)] = {};
 	int i;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 58732f44940f..c38342b9f320 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -205,7 +205,7 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev);
 void mlx5_cmd_disable(struct mlx5_core_dev *dev);
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
 			enum mlx5_cmdif_state cmdif_state);
-int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, uint32_t *sw_owner_id);
+int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, u32 *sw_owner_id);
 int mlx5_cmd_teardown_hca(struct mlx5_core_dev *dev);
 int mlx5_cmd_force_teardown_hca(struct mlx5_core_dev *dev);
 int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
index f708b029425a..e9f6c7ed7a7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
@@ -1883,7 +1883,7 @@ dr_ste_v0_build_tnl_gtpu_flex_parser_1_init(struct mlx5dr_ste_build *sb,
 
 static int dr_ste_v0_build_tnl_header_0_1_tag(struct mlx5dr_match_param *value,
 					      struct mlx5dr_ste_build *sb,
-					      uint8_t *tag)
+					      u8 *tag)
 {
 	struct mlx5dr_match_misc5 *misc5 = &value->misc5;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
index dd856cde188d..1d49704b9542 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
@@ -1897,7 +1897,7 @@ void dr_ste_v1_build_flex_parser_tnl_geneve_init(struct mlx5dr_ste_build *sb,
 
 static int dr_ste_v1_build_tnl_header_0_1_tag(struct mlx5dr_match_param *value,
 					      struct mlx5dr_ste_build *sb,
-					      uint8_t *tag)
+					      u8 *tag)
 {
 	struct mlx5dr_match_misc5 *misc5 = &value->misc5;
 
@@ -2129,7 +2129,7 @@ dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_init(struct mlx5dr_ste_build *sb,
 static int
 dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_exist_tag(struct mlx5dr_match_param *value,
 							 struct mlx5dr_ste_build *sb,
-							 uint8_t *tag)
+							 u8 *tag)
 {
 	u8 parser_id = sb->caps->flex_parser_id_geneve_tlv_option_0;
 	struct mlx5dr_match_misc *misc = &value->misc;
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 01275c6e8468..da61be87a12e 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -68,7 +68,7 @@
 #define MLX5_UN_SZ_BYTES(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 8)
 #define MLX5_UN_SZ_DW(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 32)
 #define MLX5_BYTE_OFF(typ, fld) (__mlx5_bit_off(typ, fld) / 8)
-#define MLX5_ADDR_OF(typ, p, fld) ((void *)((uint8_t *)(p) + MLX5_BYTE_OFF(typ, fld)))
+#define MLX5_ADDR_OF(typ, p, fld) ((void *)((u8 *)(p) + MLX5_BYTE_OFF(typ, fld)))
 
 /* insert a value to a struct */
 #define MLX5_SET(typ, p, fld, v) do { \
-- 
2.31.1


