Return-Path: <netdev+bounces-155721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F2A037AD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572643A52A9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E011DA0E0;
	Tue,  7 Jan 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgKixNya"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59F1DED66
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230128; cv=fail; b=UkDuqU3nYfcwgZku6fYvhhyMK5jGgZF2GrfdCQ8pR4AsOy0EjJDVuZ8Pxb0MTDXFivovlTVsslZ7IPadz9eqdwIvgzOI2km9+NNFCBWeyNI9CvTbYw0p5XuZ3Uezopv65dCpKr4Xac59UBPnBAPZLxqnYX/ZXp+8I+1pvXPGlaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230128; c=relaxed/simple;
	bh=VjOWemfbuCn6cJ6+qKBcwDr9iAHDVeFDa8aSfl6MEZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXrklpK/U8+YWgVue15y8pIvZc8D6C7WQn6ABi02WyudnSLtku2zhcI71uzmaCYXf4aC9sIjWOuBGLYU/huwSOQ6VM/XQ8v1svEBRrUsOYsJEuP8OT66kKFaMleN6DF696fekWG+ZDZfiVEZE651K5sF2m/JhUL7RtUZaiUJ2GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgKixNya; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf5qxEmuGJKBs0fwI3TvkfJ7tbAVfzF0+Ty0DrhVHpIpaJQIivzEHbyxWG6FE6NmnzhO5FemNMBSgvXehFDI6JTj8/HBKvDH7xkJND0nyjQgeVGkGMbwZJ/xRZr2CGbmV4O4x8uOOdfwApdigUVqINgD2iXrZ+VOPLYMZmrlfjlVmzwZGLLTK4o1DL9TSYY3S5bEy0oDpUWUOBQqSawVmP3C5frND+8OCoHxNG23ohGVPWkm4vBeO/dP6ptCyF0+VR+qlqkUT5woe9V5f7dsKxBcl9TUQftg2+/d7bwgFLuYwbjXCqI/7dvoBa9FAJyxZ0a5CbyG7T8yrrO1hAofPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc6wtSJ5nMqqFa3qM4dNgyaCDQjHgFNwd2+p1EqMjwc=;
 b=BFwTKaX9qVNwwFS3cIqfI5j/u77wTKsxDiuX0DkqDbKoHGxyItFagbEjSagToMy6vXfRSYAp7Q+OGTRpH6VhjnPHnRyDlfMkQ5VOE6y2Ksx4SmwNJgA8yYRQ1NeWNGDG4A9ug1OscQB/4bmXrhFeL2RcSmNMUxElxOvdm1oLwqNIeBCNGEKOAmu9VKjbdN2PvYU0btGFrG78bEf74v7K9mc/PTsUvIqXae7fRbBKtw1VSUZKWXw5LbWA11qUr/uKw0fbCbvrRhdzBZnqpncuo1ecJUXC/MXJhhwTCoN5MurwQCPlONpsA1s52ifEDwuaxLCEshlw9ajs/7GUN28rWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc6wtSJ5nMqqFa3qM4dNgyaCDQjHgFNwd2+p1EqMjwc=;
 b=JgKixNyaWCmP+a4tA6ntXAhXK4xJedubOtnxD8HJG278pQCJfajILLC0UxQatBpCOzXFDtGDlJ2DuHwo+WlSE/wkOd1vSgMWqr4XzPFwEpwr6e2FOFOfQQdvHy7mRQh+Ie4G5ATbBQ25c8YnQZDtjDbTGCHWPJRnCnq7X2ewzQs2bhdRP0w24hDLcu7IrjYpkGNZkpwJ4nRC3VEACJX+RyIQXFXiKUjq6c7krmRQqZ67c/ipdKDGqOEkSz4iyBgbGaG0DdHM+qsgoALU4cd2I4RfYH6kzCUzDUw1SXDcT69NHuUF/7WSvKWD3stdAmoxbdj3wMJLUCKcDRbBZ5TqZA==
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:08:35 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::bf) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:19 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 01/13] net/mlx5: fs, add HWS root namespace functions
Date: Tue, 7 Jan 2025 08:06:56 +0200
Message-ID: <20250107060708.1610882-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cedafd-cf6a-4bfb-8584-08dd2ee1b80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZfmuyPhbf3Y8sGgn8MncB/a64kTQj42VFuDU7A1vdzrclEBqaeM/XVPgxzr?=
 =?us-ascii?Q?V4707F/hG+EOiB1j0ac5XcZ4ajFJDkGEX9hDTUns86FrnbAvEyBPS0QTfUzF?=
 =?us-ascii?Q?urgagQNSjvQEFfnOo/PPXqs48P1J7E9CGXe/gjQC8wJhOgteY00BwQJjDhMM?=
 =?us-ascii?Q?E6/t6zMFtnekMhIARkAMPs3Zd6lcNdg0nXTu6oUATpBCXgD9BAnoQYwRYRBh?=
 =?us-ascii?Q?uFj0rkHyWQMeavrAIkO6y0TLdA50oTR6lDtIyjgljSCF/DMrLZl5/Oxp5tju?=
 =?us-ascii?Q?gWAQKNvkhk0B+EMcazp8pPyTBENht6HDjfkheDHTetGRwdIIBEZrjdK2l0uy?=
 =?us-ascii?Q?kAxkSCyigJb5GvfCxIVrSEDGHiDPovnqSP8388+Rr3sdMQw8IcWMCpJNWCtW?=
 =?us-ascii?Q?wLB8RG5iH3GZbyqA/OyyS/9p7HcnPbLF27ZaZ3dQjgkpOHC/rs4G2Vb6tm2H?=
 =?us-ascii?Q?9VN8ZdAL+fT6dXh1r7SjWr6UiTvZc8N+lWQZINaBugbEs86ZV/3GUBthPszy?=
 =?us-ascii?Q?d1AcF3084r2/5glcmvM3Vo00PjNAELY8dz5XfpBChNJMqXGobEakhQRzV00X?=
 =?us-ascii?Q?xwn8uecTRLvdGqq9NJb6wbXeFqKVuPf1sgnDB2U/h4/4g5GQI6ma6aXYVTda?=
 =?us-ascii?Q?L2y7oiw+z8ACz3dyOz4cP7O61kH1XW3S/mea9F3AMz4f0PGUyYJKFs3R1fef?=
 =?us-ascii?Q?xvtfOc88yN/t8oHzr46MimagqEKdYHqiRGfc1ulHXbyeBvi1brCWTapA2Ttg?=
 =?us-ascii?Q?d9GbZP/K0rlbyMoER5IBf5BKwOtyA99ZOicXX7DCdjtwJ3QOWAv48hTFmx6f?=
 =?us-ascii?Q?3BkWYAExPsW1BP6KWNHwwFa/M5ZIHsbwL4Bf67BrKuZpZS0PZ5gyTJFqmzOR?=
 =?us-ascii?Q?LFaIAPaA5XyeNU/D95YU/qDdLMuSxThzUT4G3RMxBLcVpn9iPJNoLbjHcZHx?=
 =?us-ascii?Q?R5uOejh+L0jmHsM+4eziMxJ/pcePeqlR2W8Cnd1gY8q0c5ez96jViV5S4RPE?=
 =?us-ascii?Q?HeXHEB+gAAkzE3JmiNgG3L1I/tiMejBaO6bCkr7oCqUDtqgCjHqEqyV30qX8?=
 =?us-ascii?Q?JbUZqXS002l067dXxCYXIRGovsWqvTei6OKKu9ZGSXTOc1DNaWJBm8R+Iier?=
 =?us-ascii?Q?NaRuan/MfOYwuH7sL20z2orpBcefLpOAPDUs6CmWeuxxibpY8bzi076auKs9?=
 =?us-ascii?Q?oMXWILxu81ayW+TWRjg/buMflaRFn1r6AtWHXMe2zp5h5pgUEBeskSCg7XCb?=
 =?us-ascii?Q?0Udh07pYOO6+gWYDr9Q75yhGGW+YiLEZjJnpVJsS5z1cesP1mZclt5K8ULCr?=
 =?us-ascii?Q?UXBZGKwGT+d1Huuxuk4Z5vZpF73i3GBPE6TgMM9u5jfJZPb/g+frAzS0zlWT?=
 =?us-ascii?Q?A1+z3EyYkww4GWbddypKB6Ah/PirXczFjZO2poFQi8C5o6hCblwpKM7VOH4j?=
 =?us-ascii?Q?KNJgbHqyZsMZlr4ussh60Gtp8GsohzQTob2L9mloU9dMjLjxjHe/5LnNGxBk?=
 =?us-ascii?Q?0cSOfbC0MvhAxiI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:34.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cedafd-cf6a-4bfb-8584-08dd2ee1b80f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

From: Moshe Shemesh <moshe@nvidia.com>

Add flow steering commands structure for HW steering. Implement create,
destroy and set peer HW steering root namespace functions.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  9 ++-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 56 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  | 25 +++++++++
 4 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 10a763e668ed..0008b22417c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -151,8 +151,8 @@ mlx5_core-$(CONFIG_MLX5_HW_STEERING) += steering/hws/cmd.o \
 					steering/hws/bwc.o \
 					steering/hws/debug.o \
 					steering/hws/vport.o \
-					steering/hws/bwc_complex.o
-
+					steering/hws/bwc_complex.o \
+					steering/hws/fs_hws.o
 
 #
 # SF device
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index bad2df0715ec..545fdfce7b52 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -38,6 +38,7 @@
 #include <linux/rhashtable.h>
 #include <linux/llist.h>
 #include <steering/sws/fs_dr.h>
+#include <steering/hws/fs_hws.h>
 
 #define FDB_TC_MAX_CHAIN 3
 #define FDB_FT_CHAIN (FDB_TC_MAX_CHAIN + 1)
@@ -126,7 +127,8 @@ enum fs_fte_status {
 
 enum mlx5_flow_steering_mode {
 	MLX5_FLOW_STEERING_MODE_DMFS,
-	MLX5_FLOW_STEERING_MODE_SMFS
+	MLX5_FLOW_STEERING_MODE_SMFS,
+	MLX5_FLOW_STEERING_MODE_HMFS
 };
 
 enum mlx5_flow_steering_capabilty {
@@ -293,7 +295,10 @@ struct mlx5_flow_group {
 struct mlx5_flow_root_namespace {
 	struct mlx5_flow_namespace	ns;
 	enum   mlx5_flow_steering_mode	mode;
-	struct mlx5_fs_dr_domain	fs_dr_domain;
+	union {
+		struct mlx5_fs_dr_domain	fs_dr_domain;
+		struct mlx5_fs_hws_context	fs_hws_context;
+	};
 	enum   fs_flow_table_type	table_type;
 	struct mlx5_core_dev		*dev;
 	struct mlx5_flow_table		*root_ft;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
new file mode 100644
index 000000000000..7a3c84b18d1e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#include <mlx5_core.h>
+#include <fs_core.h>
+#include <fs_cmd.h>
+#include "mlx5hws.h"
+
+#define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
+#define MLX5HWS_CTX_QUEUE_SIZE 256
+
+static int mlx5_cmd_hws_create_ns(struct mlx5_flow_root_namespace *ns)
+{
+	struct mlx5hws_context_attr hws_ctx_attr = {};
+
+	hws_ctx_attr.queues = min_t(int, num_online_cpus(),
+				    MLX5HWS_CTX_MAX_NUM_OF_QUEUES);
+	hws_ctx_attr.queue_size = MLX5HWS_CTX_QUEUE_SIZE;
+
+	ns->fs_hws_context.hws_ctx =
+		mlx5hws_context_open(ns->dev, &hws_ctx_attr);
+	if (!ns->fs_hws_context.hws_ctx) {
+		mlx5_core_err(ns->dev, "Failed to create hws flow namespace\n");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int mlx5_cmd_hws_destroy_ns(struct mlx5_flow_root_namespace *ns)
+{
+	return mlx5hws_context_close(ns->fs_hws_context.hws_ctx);
+}
+
+static int mlx5_cmd_hws_set_peer(struct mlx5_flow_root_namespace *ns,
+				 struct mlx5_flow_root_namespace *peer_ns,
+				 u16 peer_vhca_id)
+{
+	struct mlx5hws_context *peer_ctx = NULL;
+
+	if (peer_ns)
+		peer_ctx = peer_ns->fs_hws_context.hws_ctx;
+	mlx5hws_context_set_peer(ns->fs_hws_context.hws_ctx, peer_ctx,
+				 peer_vhca_id);
+	return 0;
+}
+
+static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
+	.create_ns = mlx5_cmd_hws_create_ns,
+	.destroy_ns = mlx5_cmd_hws_destroy_ns,
+	.set_peer = mlx5_cmd_hws_set_peer,
+};
+
+const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void)
+{
+	return &mlx5_flow_cmds_hws;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
new file mode 100644
index 000000000000..a2e2935d7367
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#ifndef _MLX5_FS_HWS_
+#define _MLX5_FS_HWS_
+
+#include "mlx5hws.h"
+
+struct mlx5_fs_hws_context {
+	struct mlx5hws_context	*hws_ctx;
+};
+
+#ifdef CONFIG_MLX5_HW_STEERING
+
+const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
+
+#else
+
+static inline const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MLX5_HWS_STEERING */
+#endif
-- 
2.45.0


