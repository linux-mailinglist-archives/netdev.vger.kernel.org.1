Return-Path: <netdev+bounces-156759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E25A07CDD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B532F188A2A4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA9220686;
	Thu,  9 Jan 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebihol0i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE321E091
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438836; cv=fail; b=mNxsXNTXJIN/xv2BbKPa8xfmmNO2CpOCwJupiX7JKiJT3K0zlnFyK3aNWZD2TPEdKqv0RpH7WDDPAs0G5YWXhDoSsDl1pqqQz3bp406wamULXx5kQCNFeZIkgPy9mOPebB72BSkGh1pGgD4cQAPO4ONkFKID/8+O4/I5FYgdoHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438836; c=relaxed/simple;
	bh=yzIhOaDSygVcxmkonIbUEZsOwsEkBz6N0xdKBINNxoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDR+u39pUFvJawPkJXD3vKcmPU7Oyj803ZdbhYsqdU/j3lyRbDUxgPVB7+9fOwgRQCe62dotZ1c1iBYqaMfAkvqynUCHw+WWBFaAh2YeR4D3Ov4x+mL3DMnr/KMzDBAFkpdmlMScY4zJnw458PXpnmVVunQTmWewk0H5CJJ8y8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebihol0i; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC+MdIJDHmIW1/GK/hihRc4LnyuRuozDUgKcSZn6V2276cBWS1dknhDrha1P03f5mkMb2hiEjkQEwwH37UINNxsXcYgT7Ue34IY3BQD37tAJi4LrWarES0Pc/UCTnVflvKICSUy3pzI6tFhdR5ktbffC/ligeDIK05k/zcrUUEuV/lwbLVPmDnfiubIvWGKpg42PBaup5x7HJOgKv881Zd5Dj0HEIoP+o1byqNcfajQvzVKL5XHRteCk4BRs/wBMSe5BMOZLvg+fJ4j/NCHK8XRMRTQtSUcGboIPkXuMfTmQFQddLNl9vnoCe9ZGU5dHKDh4Ybd36ArsRDBBteJbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfP8YkeMbLTD7XxTvLWTXhce3wApAGSwPZo9jLwDK0s=;
 b=cWp9fQDVJLun/0nQ6MklXDPIXPeisThp57F+6fsmVFrsy2t6+YwOdac9jlpXlN323Q0Y2ZjTI98f3a3azHYSmJVbxAtrEyhlJCJSRl2HmYN2+/rASB0CACSVPGTG7THTOdPIeMg3mZlLkZ/w0a5MsL6s+PA8Xr6vcwOW0l+vMK/Esh5lSlSQshoxQtSsZymEaOtKi8B1BlYPF5cr0Cl2/dUe/Q1nG0qOBM/8EEciFpu9v9hBj+KFDS5Br62TUrIbo4LMLduug2J/qKSf91JKmZOqIBtLm1XZKJcpTxFtTSOEjaX2jHxRC1Amn0TtB+ETPoeqzFLvs0UlgEPCw0OH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfP8YkeMbLTD7XxTvLWTXhce3wApAGSwPZo9jLwDK0s=;
 b=ebihol0iKvoswaFF/VS3vbpDIr00WOTU3/Ili4QrHZXzIKvP2z7V/C+txfHEduBCeMQHBpAQmQaZVwmTXqlL5xnlp/RHtmQx7KYZ4FxM5ozHWWyy7Nwm4PORq1MwHIltJ4WMZxtn5KwzgGtBO5bi/SSRrVMUskoy+km+b4SP0MLGT4qMvmJo7aHmSp20I7mzbZlnMWeyVl8loYLFBF4+8F/vttazndgXowQU9mO5ErIL8c2cBjdHNsmfaoAzC3uzl8pLJ5+7VfTdHHY6VlE+WmZ01QgAtJTq93VjnyzLZGGpZCcF3MDCk3qTzqxoELbimwi/CNR6lj6KsySOOL7H9g==
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Thu, 9 Jan 2025 16:07:10 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::20) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend Transport; Thu,
 9 Jan 2025 16:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:06:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:06:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:06:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 01/15] net/mlx5: fs, add HWS root namespace functions
Date: Thu, 9 Jan 2025 18:05:32 +0200
Message-ID: <20250109160546.1733647-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: d19836d4-ecad-4e4c-880f-08dd30c7ac60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5DwcpLCsEA0R0kC5hBOHvIYlseBlmtL6ET28u9JIxel4g1PQeKfqAuWc1AO?=
 =?us-ascii?Q?642VQUnZCHIj27X18vrE2BU3pdB0p/k+YVMH/Dkd7soLb5j+jEf/bCgB8qgU?=
 =?us-ascii?Q?8HsnFQWUwRNSI507VltLns4b6HfIX7xH3gXkSGMYYKPyyxQkG3mNjXRgFNfc?=
 =?us-ascii?Q?pNLfYe1u2CHmqiyXs/qa0Ex4QzSrbobTHNmxFX065QXfLQxsTe/UBjeDi18o?=
 =?us-ascii?Q?oMRAcV3aBxBxxV8L48bV4fBe+JACra7LG/+SsTG5Xehlm+/10PVOiWMCdWLm?=
 =?us-ascii?Q?Yz9qJmVaiyb2IBjK8vhgmvVS+SrLi1v5WLEJzV7knEKQN8pyBKvIiSGe7/ja?=
 =?us-ascii?Q?mC3GpT9JxdZtMSqziMpfI5vSkYNJI/h+5iLfR17diHVDB8Lor7NB+DN0Cd9A?=
 =?us-ascii?Q?rn6qSqwVv68hftf9VpsUQ2OLvxeqJsUZM8XP9sLUI9ZCYzGvxF3Oxs14BOTT?=
 =?us-ascii?Q?kUg2glSvBfMMKVmty5N0TWnyfieoi2p6H/ULDy6NGN9bf0PfbPhQGc8qwXN6?=
 =?us-ascii?Q?FtKtjbUmrJIACKff8DOVqBAQxDBhS4bGimI9l4skzW0vRCQC8ixQy/c2fNqQ?=
 =?us-ascii?Q?fcZY76vnCSvhcWyKxRfSe7Dqni2TUIG1QvNhMic0pYtfs9T5z5AMJbFI5iMR?=
 =?us-ascii?Q?IQzC/ap2WlYBxZqPT/+Izmn1ZsLztw2PlYyygOb2D3YWn0VaHPvQnQ/Je583?=
 =?us-ascii?Q?9ca+Qpxk70qStSJs6ygpIMMhn3YY7fVuZpyXsRP1m1jdSmD3hs2dduRBBVwv?=
 =?us-ascii?Q?vwqZPRB6R+eDjRZ7OFOV2UAtDbDwf+gRWPTVILQdg2KJUZGp+n7s1JAZYBCp?=
 =?us-ascii?Q?2vQZOzJKXHfwnavYbaC20HTfNXk6+e9v+ksL/hwVRnSxYfOnq9Psgyps4Euj?=
 =?us-ascii?Q?y74nCJqjclZUhy9TbdofLVjRV7aSsDVqoNv/Tu3uN+FPERqdW4aa6KkUSu2T?=
 =?us-ascii?Q?5Ut6XNIuzefen0moT+no13R1yeOrOj09CO1wJ+BxSkBhsQPAx5Dmn/0z7Y+v?=
 =?us-ascii?Q?zDqwo7dcllTwkGL5Qtljt64Tu2cy18Mcg3kAIxKrsoYpkxKkqmWa9tT11uwh?=
 =?us-ascii?Q?AYFxi1lMo6iF5hHdRTyBoFxMonnIorH5tlIxQH9fnrXzZsP/sZvjictHIZI/?=
 =?us-ascii?Q?cUHXl/bDnRC+KwZM2MPN44AIZQ//6iAlb/LLB+I/23bvSNYGcnm7sMikD+ql?=
 =?us-ascii?Q?EPTyleh3/0RQnq9dEEGRVxuOVEZnqyYuGJ0GWI+EnB8hmll58co0dzM5Jz7S?=
 =?us-ascii?Q?Y+ofkaSYtedGzh+FD8aac80thjbP9hzzx+f2HhnLyF6gKzTW5kAoLILZ9Y4l?=
 =?us-ascii?Q?WRo0SK+2LyU7ZdCQM+VAagJLxHtOaX6UuKL4f0489ZT2N+TXP4h/DmaAiucV?=
 =?us-ascii?Q?qtoK+2H/Lk8eLM3+4VMAQt3HdIPOzOrn7XRjBMP7uXUCloZ/l4OMXYlpq0YD?=
 =?us-ascii?Q?+uMR1vbAen2lasRsywPvb+z/0zK/ZZfNtN7SBzMgZXNAjmsPqAxcYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:10.3704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19836d4-ecad-4e4c-880f-08dd30c7ac60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

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
index bad2df0715ec..d309906d1106 100644
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
+	MLX5_FLOW_STEERING_MODE_HMFS,
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
index 000000000000..ac61f96af1c3
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025 NVIDIA Corporation & Affiliates */
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
+		return -EINVAL;
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
index 000000000000..17ac0d150253
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025 NVIDIA Corporation & Affiliates */
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


