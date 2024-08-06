Return-Path: <netdev+bounces-116116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86D94929E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A78FB29F87
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCDF1D47AA;
	Tue,  6 Aug 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8hY7q0z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8431D2F40
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952237; cv=fail; b=OHToW2dYxCZUOKpXm57Rmcd3g2Huz6aUoQVjMUsXoeVEnct1X6g78iS77vxiMvOz//DkxNX+/6sin5Yc1KW5esgnW7BBUfaQYBP1VvfNTlVL0GyU3hbx8+mvGr3mFSvS+COkEErdQVxeBtYuHzAGa0teSPpzusOVAD94I+5lRsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952237; c=relaxed/simple;
	bh=c9h+6FJEscB/ML3LkFBXmMfhOP8kKISlhzFp0B3HRxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij+wkHGxWyHAkOHBfR0OBjV3WA92xWYXFDc68UZXNZX9dvCAmPzYm+e3msVB3lzeynlE9ZqFnaL0Dy8ej8W/GP+Ir5wou2wz7s0/WUL00VyIjAiWYrDJGQi/hUuDBKJeLUo+jh38HepgXgkznzlnE7ZBMl6UrrT3ASx/1S40Jjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8hY7q0z; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nakbutrax0Q3WOtzTfyUa8iQrHxwsSwQBHu0of/0sWgNMm2/oRaudke7ZoWbnxuHogGly0joGLv6TudToT4+kZkQtCQLotj6gSDFbjoWKGBjzducPHAmfi6lV3W58S76NwcMv+CNzgu5dpWwaAmAt1mTaH82S8JuDsUk11zUiI6ik+obKyJ4MTZn6hRj/ZDjZnLv7lHsQkOCJO22PRH4TArdPgQ+e+r/sKQbWed7dAvgI+w2ClVF0bO/mk664A6LYmqTLhfNz2020HlNkoL0NrfjeJ1fM3rrFnDpicvtwnGbaiNiw4QtR9hAmWRvEmntKO4Ryu3GuOYwd1qc4a8zJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc+NfKbempEhirBrw72S6u2UdPoCV/ENErobmU0Ri88=;
 b=FG5ubfw+eg0WocDCDoHJYP3DgNwogZ7g1MMkxCqmV2dZ5aKgtImK96qS0WpRh4g7eiVlXuae59c5ZJnaJjIurj9EFvlkb4Ytu4iyc/sA9ySFkKm+SnDSRkNjX6MEtXah+xMNHk3gBL6uTFmOq6XRm0gc71oaMYLhaIulC3QfrAinF1a2aXGWgWnzyOXGkEFNadmiYGeLiC7IYbXbFUv63Sr6+YJxAvvyCPKEgC/XbTvROjHeexHlCy00HgQhawVQC6lgBgcGajdypnnYJEJem3Un/LY/N7gF40cUZVJzSJpmQzBc/tgAl6FplKFI9NcSDZZGSXRB8ZrRlVYbT8gSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc+NfKbempEhirBrw72S6u2UdPoCV/ENErobmU0Ri88=;
 b=p8hY7q0zg157QCVertYZlKMT6if7ELO4EbOKuzMul0E/HHIAy7cSPDxipEvLrmW7GagYNRqJ6ddCcBDF6Qf0i6dGaZu2/fp6WGQVQn54662Npo+ka6/3uVL0/S4aZyMXNlzJq0WJxuJ4IUW0x6wNgqnKj8XYYoAvZW2YU/hH9qp9KqTBbMpRgwTKsDa7LQyWAMBWw3rURYNs1LV20GUnpkFJymgLFSkHnAAyioptKK2ou/yoPmrOxQxvThnPsZigSikWiTThV0VPvtVsd20z8fXs8FqpyA2iSrDeQitaoAku35kxJmJSIwyY5syDSQnbiGD+n/B2UaImiDDkGX79Rw==
Received: from CH0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:610:e5::19)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:50:29 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::92) by CH0PR03CA0254.outlook.office365.com
 (2603:10b6:610:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/11] net/mlx5e: Use extack in set ringparams callback
Date: Tue, 6 Aug 2024 15:57:59 +0300
Message-ID: <20240806125804.2048753-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 87eb0e38-ce81-4a7c-8997-08dcb61ebb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOVbdAAC7R0G8AqnVklK+8iIlUCGKWLxhPq6nAaBj0MNcq6dBTiaGZRiFN76?=
 =?us-ascii?Q?j7ksp2o4HqlEr1HF98l4AMF4k0P3qyPVGDxPPjIcsIMh95LDefP+9JMk7GkY?=
 =?us-ascii?Q?VqyCZyofu/0b9Z3JLe0vJs3NikswUgsW66BlmT6vyuybt4J55Rx/a4TW0osa?=
 =?us-ascii?Q?1jy5mwlSWGCmCXKzrbKXuO5S4KBIUIo34VgPnaSifSDaY5HHg30zX+H1L+eR?=
 =?us-ascii?Q?gL9Z6YwfnG69/hNtZt4If3xsqSpROyfz/L+PtdgvDoq7k4aLO/1aHt+HFyy1?=
 =?us-ascii?Q?FZtZbCxL3ZtidwdWK0cdVjY6pxtDuKO2miuaImyRzrMKlT5Rkl61B2AiB+jt?=
 =?us-ascii?Q?mJdsAwsFhH7Bc6A0+pwKSXvcuxLxdLkSZ17uMwhZfuOTOSJa1NYDfnh6Ucj6?=
 =?us-ascii?Q?Tto1/4o90Z1mvI57/D+qrlys6Eurd55TYbTax38/S+jxKFdBXg4lnklCENEd?=
 =?us-ascii?Q?1GixDh1sYLWZAMsPXWoh2PNL5DSzQS/My7n4ux/peCrQdwejsNwtG+Rer44W?=
 =?us-ascii?Q?CVqRgXED82yXCsSor7BPo9zZPtG3FCiembuLbvKaCz33w7aeD/mgsANOrMfi?=
 =?us-ascii?Q?yx2jeWd+QnZ4LBaBqRiStCenwr7+gFXldZ/jk8rPqySzhd66Lnwe/E4W01j0?=
 =?us-ascii?Q?AIcK9+aqDGU8Q9A7JLVEnWf7Qe17v6NBEq8nXx/8aRTnah6Ui8kzf2lI/Cib?=
 =?us-ascii?Q?s/tyTP3fQMPbSqHxr13P1OEarpGrcqnJmQX7h7gLqIXMcwvQkGbXs5E28/m8?=
 =?us-ascii?Q?zzUgSUR7ME0DHAzzlzPpKURtH4Mg8s0uLZibHelEAw2MRSvdsbgqplV/0vpO?=
 =?us-ascii?Q?78ybskDzysi0s/qDpNspP0zEOOssaaVZKgwntbVOnZGbx4RHGAUEP50UfF4w?=
 =?us-ascii?Q?H5bs8pDCUptnkSYzGOXWXd3wky+F96HyGvNWjt7MhzdoQRVUH0wQa+fsReVh?=
 =?us-ascii?Q?6li4TPvg1C4ov8/dCvlhR1YhcCZRIj6KAtjWcePYGzEEEWQduNmmHozfjWJh?=
 =?us-ascii?Q?bQ751ztgFqj7Z21f/yMLRNIPs3mOCZfYz98KlocCUu/J6ZeigalR+YeQYx6M?=
 =?us-ascii?Q?COrxcEpcMbNSH8RjXZjf5vqJ5ZrUoEwkcVfadZl/tzgcTSnH7KUmTovcf5fz?=
 =?us-ascii?Q?gjRhTN1blUi7ZDsUVMrGb/O6J36Nz3RojJJYGdJYKM27cLk+NSj00ysa9xkG?=
 =?us-ascii?Q?/uq15VjLxPH57uscD+CMwU4otWjv444T2UptQSsy3mXXnzJ21J76+EREJ5Zy?=
 =?us-ascii?Q?/jMGd6wo2qoDPFYdQimK7GiIYT8f7FHGeNMHCIgGvBJwIqQ4xTbY+CuraRZm?=
 =?us-ascii?Q?kaueVH/9so1fjr2w/cAcqfMcw58+5aiWySMKrl5bU6QsEezSFpU4D/fErKQn?=
 =?us-ascii?Q?83ymYK9kzMAwOUYeQ/Jq+NBcsJLpj3KDfnqC3B9f0LkCtZbaxfHJPsnC7ivu?=
 =?us-ascii?Q?NpAmOhJb0DyVe+i8sfFj2B+dQXrLWtRJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:28.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eb0e38-ce81-4a7c-8997-08dcb61ebb46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

From: Gal Pressman <gal@nvidia.com>

In case of errors in set ringparams, reflect it through extack instead
of a dmesg print.
While at it, make the messages more human friendly.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 ++-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 23 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 +-
 .../mellanox/mlx5/core/ipoib/ethtool.c        |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5fd82c67b6ab..01781b70434c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1172,7 +1172,8 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 				 struct ethtool_ringparam *param,
 				 struct kernel_ethtool_ringparam *kernel_param);
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
-				struct ethtool_ringparam *param);
+				struct ethtool_ringparam *param,
+				struct netlink_ext_ack *extack);
 void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
 				struct ethtool_channels *ch);
 int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 5fd81253d6b9..f162fd0355ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -352,7 +352,8 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 }
 
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
-				struct ethtool_ringparam *param)
+				struct ethtool_ringparam *param,
+				struct netlink_ext_ack *extack)
 {
 	struct mlx5e_params new_params;
 	u8 log_rq_size;
@@ -360,27 +361,25 @@ int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 	int err = 0;
 
 	if (param->rx_jumbo_pending) {
-		netdev_info(priv->netdev, "%s: rx_jumbo_pending not supported\n",
-			    __func__);
+		NL_SET_ERR_MSG_MOD(extack, "rx-jumbo not supported");
 		return -EINVAL;
 	}
 	if (param->rx_mini_pending) {
-		netdev_info(priv->netdev, "%s: rx_mini_pending not supported\n",
-			    __func__);
+		NL_SET_ERR_MSG_MOD(extack, "rx-mini not supported");
 		return -EINVAL;
 	}
 
 	if (param->rx_pending < (1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE)) {
-		netdev_info(priv->netdev, "%s: rx_pending (%d) < min (%d)\n",
-			    __func__, param->rx_pending,
-			    1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "rx (%d) < min (%d)",
+				       param->rx_pending,
+				       1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE);
 		return -EINVAL;
 	}
 
 	if (param->tx_pending < (1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)) {
-		netdev_info(priv->netdev, "%s: tx_pending (%d) < min (%d)\n",
-			    __func__, param->tx_pending,
-			    1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "tx (%d) < min (%d)",
+				       param->tx_pending,
+				       1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE);
 		return -EINVAL;
 	}
 
@@ -416,7 +415,7 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	return mlx5e_ethtool_set_ringparam(priv, param);
+	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
 void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 8790d57dc6db..916ba0db29f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -360,7 +360,7 @@ mlx5e_rep_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	return mlx5e_ethtool_set_ringparam(priv, param);
+	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
 static void mlx5e_rep_get_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 26f8a11b8906..424ff39db28d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -74,7 +74,7 @@ static int mlx5i_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);
 
-	return mlx5e_ethtool_set_ringparam(priv, param);
+	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
 static void mlx5i_get_ringparam(struct net_device *dev,
-- 
2.44.0


