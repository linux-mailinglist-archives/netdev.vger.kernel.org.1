Return-Path: <netdev+bounces-116114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E3949218
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C99D1F26288
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BD200110;
	Tue,  6 Aug 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eoinzk1a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FC1C233C
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952234; cv=fail; b=Rq/lg+Y6oYAATOn1A5PSwnFV/4IgCCOV1jClBAc5xFPNQJokJkLdLZzhY4Xndwklwxo54QDV1pQEz3yJV22b40bK74qLoCn177NhAjI8/hnAj9LL48C8t7OYttO8zVkJnkyS6wTtscrpHNacIS0WL3hrEv5S2wy27g3BaOoW9rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952234; c=relaxed/simple;
	bh=r/SHGC+K4QTaoXmZb3/cMfNzPW2f+GQx7LoRaz3i5L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpK66FkH7LmxLV4HhGA2hNYkTqpVqiwoB1hUrYQPrqK/iiOmujNnxUaEe4S1KWuFtsREwIFlWpneQ2O5S8hKnDu6Ko4pCFPWi7abJ1952KsnqBTfgR5P+Qulb0MnTICdnjHZEXsnVR35kTubDJDjxDGvWBLagHNyKtwoSDUIBmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eoinzk1a; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExzQ381W8uzWKv2fS6kUSSPDZXFL1yHAETep0NGujAFlnUn1tQb50Y6KG7Sy+N/n4nF+8gX/YZ6voghwqxKJ718t19QELv3qKviwkGP5L3ubE5+NG404Rm/tKw7nFp0tgOglDJ7grxaoqxiLWUa+rsC3rW16E2p82xRyvVvhxDapqq0aTB/MTbo47XuWa6GpYGVGLR2wRerr0oGRupN4DcEOorbCvROS1FOtRfbtbH+x4QeJvavn2VGuq//uqxhn2rn8ag4kjkSwo/4bjp+GCI3t46iSeMdbeY4kdaoZN+eiNMXWqsKt/LYoEHV5YabJjPL1GQbPlR7UmPOSj3hjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vy1MHCe8ERl+RZ+V65tZkmAG/WaGvcZgx+6uGOTq2U=;
 b=DLsh2HsdgcHd7QYfBnjRpuMlbrKoDMO1lHNng6FMgrWZnoaU2ymJrNFRsL+oyPyaOOUL4vadQvEOsPavCpwd9/n1mKYWZkiY6whS0LxReNdBXAZvRAMCmtcMsKyn1XRSUOPwtaZAFJLOmR0deIxFeuDBIvCsI7Y6z9gwZOK7RLU/5cEMJZSlayLY5QnuyjSnGfTuSGu8ynH7x2XCE0VmELwcmNUw8Qjwew7ht9XAli13M11NArYM77JcxadK/X5FTIm8VxTRxS3x/eiu56qTYvOEe1gcj82wHQ2UW3UavO1O4nhGhIeQ4aUf5s3Sn4+KbxCe9cHSoEgDurXSxXjpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vy1MHCe8ERl+RZ+V65tZkmAG/WaGvcZgx+6uGOTq2U=;
 b=Eoinzk1azeCnsZe7T+JmL1oLbyXyuI9MzhfE8en1pWrGanqW3JJrhXJ9IfyG8dwoP5l/Nt4fj9rNplyN8lBjIoynv8ykyjy9adX1bqa9srKF0U38YUErvdVRZ756Gt4aGP4u4gc8BCIBzOnkolY2JarDrgiadh3DPbbCA8lQsMmpAA22wq+ovQdcTeRMg5kHzZmw04DIJmTHkbTKez/pezSgbeCllINgnNkDpReMCs8IZmzakvIKIWnzeXmCdZDSjjwEeAxHgu7Lq1irjtt1rlQZ+rr8piHcNTRol8oMFNybeFbvUH5wmky/CS3JKWBa6hjUR1y5UGbP95RZwU3B1Q==
Received: from CH2PR18CA0054.namprd18.prod.outlook.com (2603:10b6:610:55::34)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Tue, 6 Aug
 2024 13:50:29 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::76) by CH2PR18CA0054.outlook.office365.com
 (2603:10b6:610:55::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/11] net/mlx5e: Use extack in get coalesce callback
Date: Tue, 6 Aug 2024 15:58:00 +0300
Message-ID: <20240806125804.2048753-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6d85e1-6086-4d87-893b-08dcb61ebb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?isBpfHQwBsQDYWQv1tnCxkuw/3govSV20ecVB093NJ+kV+LeFRB/Sx0HOtQC?=
 =?us-ascii?Q?AYRGbcV2Ypnv5cnvytwobYkiIsdiy9s6y2HQeYdffd72Kk9nEnqV3GcuEAF8?=
 =?us-ascii?Q?uwC74d43BSkgkzgp/UTdB+2ohaofT1ac6g6UYNkWpodZDBgM3P2es+g2qXwa?=
 =?us-ascii?Q?6BciQ6zz1dYtE0uFrsb2UfnkpjH0ZPKzH337NeEUTi6iVoqViGOhSqtQkA0j?=
 =?us-ascii?Q?99HNyEM18zl0ZXSmeVCRu782pC2C5+5udsHtjkzyF5sALYGIAPYEdRyObdB4?=
 =?us-ascii?Q?tbaQ/VIgPkKjrNfSi/dBWwYYJ1ZPgzDsQQhm7xY1hYs0RfGOr6q9ELK+QEoo?=
 =?us-ascii?Q?A1cXdFCVdBKSTP6Y3juo4LFGcMO29XwjPsxUufsn7WpZWjr/f4yb7q0oyGsq?=
 =?us-ascii?Q?8IC29Stb1WyOEKmub9qp8BEl5U9rTr6ILuoMah2yeGDzlXGkIfUDufsjmuDV?=
 =?us-ascii?Q?Jxra7PglymRofeu17RiWyflQDUP3716e6IGxUln5Ml4+2d8YTG7iEpOVhgxK?=
 =?us-ascii?Q?TSNX/GABGHfV+pUiceAE5JSZs0b0/GyET9c/9X42/H/h7GKmaXl2PVcxL9nx?=
 =?us-ascii?Q?SV0O4H8Rps9/rTewG3zY+aNHxPHhoMwVIKshMWbAjO4/Bhv1SRuFU/INHE0+?=
 =?us-ascii?Q?V5ggkNyEmYzApKitdukVFoUi4QdjB0oHEoIniHzsaK06QT89kHiwWl5YDpVZ?=
 =?us-ascii?Q?v04/NEwwA0tbXSpdnv4jUcUyWcPN/jGdSmFh43ZYzCzGqDvAjonAf8xUnAam?=
 =?us-ascii?Q?v1i/l4qChwtOpVlnINXXWCLvwya1U7KmhXFU3SeWNRDYbCxrq+7vRSiKqULA?=
 =?us-ascii?Q?ExyD2yeTXHme0LRrH8E1hdnm/Go5+h3Bt3gLl5IB4hPwnueyyDMDQg9+Baka?=
 =?us-ascii?Q?GxdyviEscynOT8u1BLq5oTNQM222mKQ1dSeHI5ZTxKgYpW8a35vVtgvrJmgy?=
 =?us-ascii?Q?OmBsuqyTSaOvkZNVV+CbNwSoyqS71GWmJFQhgU47cPtadCiejt35GGKiiRmY?=
 =?us-ascii?Q?YmKc2UfQriRqAasDY9N+Cq9Eg29/P6+TaS/xySxJ+OqkjJxKJL79Y+swRIaq?=
 =?us-ascii?Q?JzojzaYzlyvMDWLNWreikKfYK3jPyysKcAReUl38AfkQbtLuMOwct4pX70yd?=
 =?us-ascii?Q?gpvaIYg+XVV0VZkq5hX/S6X6WzV0Z1uOaQKJerkDFo/KMbNJkMZRl54WzaQ4?=
 =?us-ascii?Q?tTix+ZnguHYv7qZfMcmkVJWZQe0qFEAK09GeXyiExkcskp8JN0PuRejPMDEL?=
 =?us-ascii?Q?qq3D8h6xM9t5HF73lhUAUBebi0f7KDiyX5dBQgLKTUzXga0mJOVUyA05QdZc?=
 =?us-ascii?Q?9MCzI4xfRBShq+LcQUvRpzwmlmrSPb6bADKRbPngrpvKNY+NkTjh1NolSTVI?=
 =?us-ascii?Q?yvlhdk8kH6U86CatAjpnogmOildEcv1q8dTQGXZJoPLlUkbnQmh7+UFrbz5C?=
 =?us-ascii?Q?2HlXSUaXYPf1FPF5lNYAmXpRV2Uwfm6l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:28.7931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6d85e1-6086-4d87-893b-08dcb61ebb6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

From: Gal Pressman <gal@nvidia.com>

In case of errors in get coalesce, reflect it through extack instead of
a dmesg print.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h            | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 9 ++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 01781b70434c..7832f6b6c8a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1180,7 +1180,8 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 			       struct ethtool_channels *ch);
 int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal);
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack);
 int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index f162fd0355ed..66fc1d12b5ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -554,12 +554,15 @@ static int mlx5e_set_channels(struct net_device *dev,
 
 int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal)
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 
-	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
+	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation)) {
+		NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
 		return -EOPNOTSUPP;
+	}
 
 	rx_moder = &priv->channels.params.rx_cq_moderation;
 	coal->rx_coalesce_usecs		= rx_moder->usec;
@@ -583,7 +586,7 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
-	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
+	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal, extack);
 }
 
 static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv, u32 queue,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 916ba0db29f2..b885042eef14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -386,7 +386,7 @@ static int mlx5e_rep_get_coalesce(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
-	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
+	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal, extack);
 }
 
 static int mlx5e_rep_set_coalesce(struct net_device *netdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 424ff39db28d..9772327d5124 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -132,7 +132,7 @@ static int mlx5i_get_coalesce(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(netdev);
 
-	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
+	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal, extack);
 }
 
 static int mlx5i_get_ts_info(struct net_device *netdev,
-- 
2.44.0


