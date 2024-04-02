Return-Path: <netdev+bounces-84030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E204895571
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA23B284164
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8284FA5;
	Tue,  2 Apr 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WoT9ZfDZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65A84A48
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064747; cv=fail; b=AcFh5R5No9Zn7Ynrtv088a1IGdQDyt8H6Er8FOjUccChDFItIQAgV6oD+m6kueDH7zMQ6O9IwKv2/FDu82t/7gqVCNxYe39+z3yz6fUcm5G1XFIsOdKE4hj7BGxu7CtWGG2DtdfnlD1l7IjJb4jc/BMHBnUQo14NrZ1QUWr3NkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064747; c=relaxed/simple;
	bh=XOF8IuBcVip9fQ0Q8l4xODJUf39a/fKedXuNBWtC2ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzS2aRlePXjtKfCDYah9H0btsasEeq2lN5IvmkhXV+IWbaUWxH2w0wreSuqQOQyOCLcUONNKSvbg7kQ/ZGeu+2Leh+cdyZBndGHaNtLVE+yB6SsKJ7AG8n+3gAMelMC2lytni+CsA29i6GgxIekDBR+Np3N6kGoZkh+/kSL2+Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WoT9ZfDZ; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn4RN3Qjcpu9a+6+J8Ihn4dgj9M7UmYJOvD/KPCDgJnuYtn5XBqqfb6zxToeHoEfuaYnPWc0LQm5s8KPsvb8vlUBZaRbM6AZKZ40dzrrtBr9U7OMyoL1jEL7hdVbjAI1vxS3Xr/T+w5sYEI506ZxPFw9VSDeUT1LeqxEpX3H+ugys1gkFu2sAvlxZSjdCzRCBpcg2xnrHB6gIF7jPDSTPaTwp52h6CS3fYfaq8AWusTVnOlgFqr5TrFStLCIKbTerjRp27OcIkpbtlnRZi9Cpm9+mGn5JRc4EsumU5AP7Hu6X32LgNX9o+lvf0eClgkmq32Pkes0iXWFfBtWTVrUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51nYvLIRmH09cI+ovwUfoQEErSv4RJIBW6fYb5rKIqk=;
 b=E/AUQ1PQ6dw3pMHxbQZ5TvF8vYk4R+kTytKbY4OQbSKam6V/r/FlrgZBEsOQ1qK7CfI9gHD0pHfZiNzrtjUWyY8fonQYj8brykLA4ewYQ0dSV47X63CWFK17WI/K4JSLgk9lCGH6uTNeqnsIEM4d+QXpVakc1hygHrRv2QBjT6GKEIhf5CZo9qrmdnLvXLuUdUDpbUm+Bide0QHl8cjoc83trH6m74SV4tWL15vQsUzokDJ2y71zm+a7GNT4V9NEgd9LQLVOwR7W/fN36Ksz4CUA1huvv9urA25T3HxF3OzW99dRKdpMRN6pLl0bcryZKf5ssCddLU4y6M+QKhb0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51nYvLIRmH09cI+ovwUfoQEErSv4RJIBW6fYb5rKIqk=;
 b=WoT9ZfDZ7Yer5PLmIAuZdebm3s0kfpr2ntu7N9BA0eEdK+ZEcKbC5WMbC98YqNSpW3W5ZjzKNeU6dRo/U+Ga2mmhhfpOKsrxoDuGz1ua5LrqOc9RMfbBrLWpovhWvZru7f6H5ORtYNu71Bq3n1+hqqJcbGVN3Ue8eKFG5koW27dSqq0jt63jj5SFhTTzp56UyxNz56JFh6jGtSde+vNXZyMv0hp9ZBJRCnh9agqOAPv8K3IMSK6NVa0Adl0TYWzNyo85Rc6m9jGyQgrQ3Hs/7I+4nsh1K8qkvIl1R6axb9//hGxKLJ/orjPDxSagKVnThpYf1GLXdD215ZjRhY0yDQ==
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:14 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::4e) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 04/11] net/mlx5e: Make stats group fill_stats callbacks consistent with the API
Date: Tue, 2 Apr 2024 16:30:36 +0300
Message-ID: <20240402133043.56322-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: bc94ab40-3dae-4daa-b574-08dc53194ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuX5TSglba4u1G0ICmQJCPs29FIBqgBj01lbslGbjaKBIkSMZg9zNeMaWVWLF5NGpUwcs/mvIwZm1JrBVJXHGUHWJUmrZcQchkrZhD86MBDZCaGv7f+9n2QLSC41/qPOpUuiQ6T6KbU3ZboYGpg+CRuY0VEkET+6pl+VdI8k9q7I89tYZbfyao1TRwLh2YwF0v8ASzLsg9RLrm3bFDpWgunjpSgn3PLRDO3xuO36Y18gIVSS0iS+C5t5agODADAE2Q9B0WvzzJFkkz0PIRcA/E54j9gUPLvgnN9Rsuhitb8LbXjMWpZ4hUwgNTRbQ8i8JqZPbCkuTUiRTgCEwBs8Kl7VV/gYhi1RwvuVDk+FUH5faE0gqOibTVXkjpZvYgTin1YpIxQzPHQaLvUPtm54mg+FbB1XO3yD0Hr+acziESX24vPDXqE7GwtE4c1XkVSvTVQ7NMzMW1TAzq1Cf0seXwcKBdk5L4cMB+4T05QRJe2clTBilNDvitWOI4GfUe2YxGj7TokCg2z7ZClfCkThcvTsYGsonIIgncKv+OHt+MO+2qnRdZn7NK/QAOdn8NDXyGSokCNA7VOd28ZMZsmcF1h2erHzbp6xB9kYCCx1Go+HN61svlSWY70KnyXQJ13T8FPSZOLtz5iAInbq1ZPdk3c1jyHIySXWh5bNxjQL/xKUbP3IgRxUzRudruKLZJsFRzOTVoan2iRUpaeGUfPYnu2C09YmbtZ2zgLcpwf/OypO6Aw6+qAeCLEEqtPQOCSi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:13.8941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc94ab40-3dae-4daa-b574-08dc53194ec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

From: Gal Pressman <gal@nvidia.com>

The fill_strings() callbacks were changed to accept a **data pointer,
and not rely on propagating the index value.
Make a similar change to fill_stats() callbacks to keep the API
consistent.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |  17 +-
 .../mellanox/mlx5/core/en_accel/ktls.h        |   7 +-
 .../mellanox/mlx5/core/en_accel/ktls_stats.c  |  15 +-
 .../mlx5/core/en_accel/macsec_stats.c         |  13 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  18 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 312 ++++++++++--------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   6 +-
 7 files changed, 215 insertions(+), 173 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
index ecf87383ecb8..92bf3fa44a3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
@@ -89,14 +89,14 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(ipsec_hw)
 	int i;
 
 	if (!priv->ipsec)
-		return idx;
+		return;
 
 	mlx5e_accel_ipsec_fs_read_stats(priv, &priv->ipsec->hw_stats);
 	for (i = 0; i < NUM_IPSEC_HW_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR_ATOMIC64(&priv->ipsec->hw_stats,
-						      mlx5e_ipsec_hw_stats_desc, i);
-
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR_ATOMIC64(&priv->ipsec->hw_stats,
+						mlx5e_ipsec_hw_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(ipsec_sw)
@@ -121,9 +121,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(ipsec_sw)
 
 	if (priv->ipsec)
 		for (i = 0; i < NUM_IPSEC_SW_COUNTERS; i++)
-			data[idx++] = MLX5E_READ_CTR_ATOMIC64(&priv->ipsec->sw_stats,
-							      mlx5e_ipsec_sw_stats_desc, i);
-	return idx;
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR_ATOMIC64(
+					      &priv->ipsec->sw_stats,
+					      mlx5e_ipsec_sw_stats_desc, i));
 }
 
 MLX5E_DEFINE_STATS_GRP(ipsec_hw, 0);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index 9b96bee194ef..c1844128effa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -96,7 +96,7 @@ void mlx5e_ktls_cleanup(struct mlx5e_priv *priv);
 
 int mlx5e_ktls_get_count(struct mlx5e_priv *priv);
 void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data);
-int mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 *data);
+void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data);
 
 #else
 static inline void mlx5e_ktls_build_netdev(struct mlx5e_priv *priv)
@@ -146,10 +146,7 @@ static inline void mlx5e_ktls_cleanup(struct mlx5e_priv *priv) { }
 static inline int mlx5e_ktls_get_count(struct mlx5e_priv *priv) { return 0; }
 static inline void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data) { }
 
-static inline int mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 *data)
-{
-	return 0;
-}
+static inline void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data) { }
 #endif
 
 #endif /* __MLX5E_TLS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
index 06363f2653e0..7bf79973128b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
@@ -71,19 +71,18 @@ void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data)
 		ethtool_puts(data, mlx5e_ktls_sw_stats_desc[i].format);
 }
 
-int mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 *data)
+void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data)
 {
-	unsigned int i, n, idx = 0;
+	unsigned int i, n;
 
 	if (!priv->tls)
-		return 0;
+		return;
 
 	n = mlx5e_ktls_get_count(priv);
 
 	for (i = 0; i < n; i++)
-		data[idx++] = MLX5E_READ_CTR_ATOMIC64(&priv->tls->sw_stats,
-						      mlx5e_ktls_sw_stats_desc,
-						      i);
-
-	return n;
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR_ATOMIC64(&priv->tls->sw_stats,
+						mlx5e_ktls_sw_stats_desc, i));
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
index a79e2786be56..4bb47d48061d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
@@ -53,19 +53,18 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(macsec_hw)
 	int i;
 
 	if (!priv->macsec)
-		return idx;
+		return;
 
 	if (!mlx5e_is_macsec_device(priv->mdev))
-		return idx;
+		return;
 
 	macsec_fs = priv->mdev->macsec_fs;
 	mlx5_macsec_fs_get_stats_fill(macsec_fs, mlx5_macsec_fs_get_stats(macsec_fs));
 	for (i = 0; i < NUM_MACSEC_HW_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(mlx5_macsec_fs_get_stats(macsec_fs),
-						   mlx5e_macsec_hw_stats_desc,
-						   i);
-
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(
+				      mlx5_macsec_fs_get_stats(macsec_fs),
+				      mlx5e_macsec_hw_stats_desc, i));
 }
 
 MLX5E_DEFINE_STATS_GRP(macsec_hw, 0);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index e41fbf377ae8..55b7efe21624 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -143,9 +143,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw_rep)
 	int i;
 
 	for (i = 0; i < NUM_VPORT_REP_SW_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(&priv->stats.sw,
-						   sw_rep_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(&priv->stats.sw,
+						   sw_rep_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw_rep)
@@ -184,12 +184,14 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vport_rep)
 	int i;
 
 	for (i = 0; i < NUM_VPORT_REP_HW_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
-						   vport_rep_stats_desc, i);
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
+						   vport_rep_stats_desc, i));
 	for (i = 0; i < NUM_VPORT_REP_LOOPBACK_COUNTERS(priv->mdev); i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
-						   vport_rep_loopback_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
+					     vport_rep_loopback_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_rep)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 6be0bcc9a3f4..4f372cb2fc9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -41,6 +41,11 @@
 #include <net/page_pool/helpers.h>
 #endif
 
+void mlx5e_ethtool_put_stat(u64 **data, u64 val)
+{
+	*(*data)++ = val;
+}
+
 static unsigned int stats_grps_num(struct mlx5e_priv *priv)
 {
 	return !priv->profile->stats_grps_num ? 0 :
@@ -90,7 +95,7 @@ void mlx5e_stats_fill(struct mlx5e_priv *priv, u64 *data, int idx)
 	int i;
 
 	for (i = 0; i < num_stats_grps; i++)
-		idx = stats_grps[i]->fill_stats(priv, data, idx);
+		stats_grps[i]->fill_stats(priv, &data);
 }
 
 void mlx5e_stats_fill_strings(struct mlx5e_priv *priv, u8 *data)
@@ -265,8 +270,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
 	int i;
 
 	for (i = 0; i < NUM_SW_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(&priv->stats.sw, sw_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(data,
+				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
+							    sw_stats_desc, i));
 }
 
 static void mlx5e_stats_grp_sw_update_stats_xdp_red(struct mlx5e_sw_stats *s,
@@ -601,12 +607,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(qcnt)
 	int i;
 
 	for (i = 0; i < NUM_Q_COUNTERS && q_counter_any(priv); i++)
-		data[idx++] = MLX5E_READ_CTR32_CPU(&priv->stats.qcnt,
-						   q_stats_desc, i);
+		mlx5e_ethtool_put_stat(data,
+				       MLX5E_READ_CTR32_CPU(&priv->stats.qcnt,
+							    q_stats_desc, i));
 	for (i = 0; i < NUM_DROP_RQ_COUNTERS && priv->drop_rq_q_counter; i++)
-		data[idx++] = MLX5E_READ_CTR32_CPU(&priv->stats.qcnt,
-						   drop_rq_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR32_CPU(&priv->stats.qcnt,
+						   drop_rq_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(qcnt)
@@ -694,18 +701,22 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vnic_env)
 	int i;
 
 	for (i = 0; i < NUM_VNIC_ENV_STEER_COUNTERS(priv->mdev); i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(priv->stats.vnic.query_vnic_env_out,
-						  vnic_env_stats_steer_desc, i);
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(priv->stats.vnic.query_vnic_env_out,
+					    vnic_env_stats_steer_desc, i));
 
 	for (i = 0; i < NUM_VNIC_ENV_DEV_OOB_COUNTERS(priv->mdev); i++)
-		data[idx++] = MLX5E_READ_CTR32_BE(priv->stats.vnic.query_vnic_env_out,
-						  vnic_env_stats_dev_oob_desc, i);
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR32_BE(priv->stats.vnic.query_vnic_env_out,
+					    vnic_env_stats_dev_oob_desc, i));
 
 	for (i = 0; i < NUM_VNIC_ENV_DROP_COUNTERS(priv->mdev); i++)
-		data[idx++] = MLX5E_READ_CTR32_BE(priv->stats.vnic.query_vnic_env_out,
-						  vnic_env_stats_drop_desc, i);
-
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR32_BE(priv->stats.vnic.query_vnic_env_out,
+					    vnic_env_stats_drop_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vnic_env)
@@ -799,14 +810,16 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vport)
 	int i;
 
 	for (i = 0; i < NUM_VPORT_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(priv->stats.vport.query_vport_out,
-						  vport_stats_desc, i);
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(priv->stats.vport.query_vport_out,
+					    vport_stats_desc, i));
 
 	for (i = 0; i < NUM_VPORT_LOOPBACK_COUNTERS(priv->mdev); i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(priv->stats.vport.query_vport_out,
-						  vport_loopback_stats_desc, i);
-
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(priv->stats.vport.query_vport_out,
+					    vport_loopback_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport)
@@ -863,9 +876,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(802_3)
 	int i;
 
 	for (i = 0; i < NUM_PPORT_802_3_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(&priv->stats.pport.IEEE_802_3_counters,
-						  pport_802_3_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_BE(
+				      &priv->stats.pport.IEEE_802_3_counters,
+				      pport_802_3_stats_desc, i));
 }
 
 #define MLX5_BASIC_PPCNT_SUPPORTED(mdev) \
@@ -1023,9 +1037,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(2863)
 	int i;
 
 	for (i = 0; i < NUM_PPORT_2863_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(&priv->stats.pport.RFC_2863_counters,
-						  pport_2863_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_BE(
+				      &priv->stats.pport.RFC_2863_counters,
+				      pport_2863_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(2863)
@@ -1081,9 +1096,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(2819)
 	int i;
 
 	for (i = 0; i < NUM_PPORT_2819_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(&priv->stats.pport.RFC_2819_counters,
-						  pport_2819_stats_desc, i);
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_BE(
+				      &priv->stats.pport.RFC_2819_counters,
+				      pport_2819_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(2819)
@@ -1219,24 +1235,29 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 	int i;
 
 	/* link_down_events_phy has special handling since it is not stored in __be64 format */
-	data[idx++] = MLX5_GET(ppcnt_reg, priv->stats.pport.phy_counters,
-			       counter_set.phys_layer_cntrs.link_down_events);
+	mlx5e_ethtool_put_stat(
+		data, MLX5_GET(ppcnt_reg, priv->stats.pport.phy_counters,
+			       counter_set.phys_layer_cntrs.link_down_events));
 
 	if (!MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		return idx;
+		return;
 
 	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-		data[idx++] =
-			MLX5E_READ_CTR64_BE(&priv->stats.pport.phy_statistical_counters,
-					    pport_phy_statistical_stats_desc, i);
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(
+				&priv->stats.pport.phy_statistical_counters,
+				pport_phy_statistical_stats_desc, i));
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&priv->stats.pport.phy_statistical_counters,
-						    pport_phy_statistical_err_lanes_stats_desc,
-						    i);
-	return idx;
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pport
+						 .phy_statistical_counters,
+					pport_phy_statistical_err_lanes_stats_desc,
+					i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
@@ -1426,10 +1447,11 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(eth_ext)
 
 	if (MLX5_CAP_PCAM_FEATURE((priv)->mdev, rx_buffer_fullness_counters))
 		for (i = 0; i < NUM_PPORT_ETH_EXT_COUNTERS; i++)
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&priv->stats.pport.eth_ext_counters,
-						    pport_eth_ext_stats_desc, i);
-	return idx;
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pport.eth_ext_counters,
+					pport_eth_ext_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(eth_ext)
@@ -1513,22 +1535,27 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(pcie)
 
 	if (MLX5_CAP_MCAM_FEATURE((priv)->mdev, pcie_performance_group))
 		for (i = 0; i < NUM_PCIE_PERF_COUNTERS; i++)
-			data[idx++] =
-				MLX5E_READ_CTR32_BE(&priv->stats.pcie.pcie_perf_counters,
-						    pcie_perf_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR32_BE(
+					&priv->stats.pcie.pcie_perf_counters,
+					pcie_perf_stats_desc, i));
 
 	if (MLX5_CAP_MCAM_FEATURE((priv)->mdev, tx_overflow_buffer_pkt))
 		for (i = 0; i < NUM_PCIE_PERF_COUNTERS64; i++)
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&priv->stats.pcie.pcie_perf_counters,
-						    pcie_perf_stats_desc64, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pcie.pcie_perf_counters,
+					pcie_perf_stats_desc64, i));
 
 	if (MLX5_CAP_MCAM_FEATURE((priv)->mdev, pcie_outbound_stalled))
 		for (i = 0; i < NUM_PCIE_PERF_STALL_COUNTERS; i++)
-			data[idx++] =
-				MLX5E_READ_CTR32_BE(&priv->stats.pcie.pcie_perf_counters,
-						    pcie_perf_stall_stats_desc, i);
-	return idx;
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR32_BE(
+					&priv->stats.pcie.pcie_perf_counters,
+					pcie_perf_stall_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(pcie)
@@ -1606,20 +1633,24 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(per_port_buff_congest)
 	int i, prio;
 
 	if (!MLX5_CAP_GEN(mdev, sbcam_reg))
-		return idx;
+		return;
 
 	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
 		for (i = 0; i < NUM_PPORT_PER_TC_PRIO_COUNTERS; i++)
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&pport->per_tc_prio_counters[prio],
-						    pport_per_tc_prio_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&pport->per_tc_prio_counters[prio],
+					pport_per_tc_prio_stats_desc, i));
 		for (i = 0; i < NUM_PPORT_PER_TC_CONGEST_PRIO_COUNTERS ; i++)
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&pport->per_tc_congest_prio_counters[prio],
-						    pport_per_tc_congest_prio_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&pport->per_tc_congest_prio_counters
+						 [prio],
+					pport_per_tc_congest_prio_stats_desc,
+					i));
 	}
-
-	return idx;
 }
 
 static void mlx5e_grp_per_tc_prio_update_stats(struct mlx5e_priv *priv)
@@ -1717,20 +1748,20 @@ static void mlx5e_grp_per_prio_traffic_fill_strings(struct mlx5e_priv *priv,
 	}
 }
 
-static int mlx5e_grp_per_prio_traffic_fill_stats(struct mlx5e_priv *priv,
-						 u64 *data,
-						 int idx)
+static void mlx5e_grp_per_prio_traffic_fill_stats(struct mlx5e_priv *priv,
+						  u64 **data)
 {
 	int i, prio;
 
 	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
 		for (i = 0; i < NUM_PPORT_PER_PRIO_TRAFFIC_COUNTERS; i++)
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&priv->stats.pport.per_prio_counters[prio],
-						    pport_per_prio_traffic_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pport
+						 .per_prio_counters[prio],
+					pport_per_prio_traffic_stats_desc, i));
 	}
-
-	return idx;
 }
 
 static const struct counter_desc pport_per_prio_pfc_stats_desc[] = {
@@ -1820,9 +1851,8 @@ static void mlx5e_grp_per_prio_pfc_fill_strings(struct mlx5e_priv *priv,
 		ethtool_puts(data, pport_pfc_stall_stats_desc[i].format);
 }
 
-static int mlx5e_grp_per_prio_pfc_fill_stats(struct mlx5e_priv *priv,
-					     u64 *data,
-					     int idx)
+static void mlx5e_grp_per_prio_pfc_fill_stats(struct mlx5e_priv *priv,
+					      u64 **data)
 {
 	unsigned long pfc_combined;
 	int i, prio;
@@ -1830,25 +1860,30 @@ static int mlx5e_grp_per_prio_pfc_fill_stats(struct mlx5e_priv *priv,
 	pfc_combined = mlx5e_query_pfc_combined(priv);
 	for_each_set_bit(prio, &pfc_combined, NUM_PPORT_PRIO) {
 		for (i = 0; i < NUM_PPORT_PER_PRIO_PFC_COUNTERS; i++) {
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&priv->stats.pport.per_prio_counters[prio],
-						    pport_per_prio_pfc_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pport
+						 .per_prio_counters[prio],
+					pport_per_prio_pfc_stats_desc, i));
 		}
 	}
 
 	if (mlx5e_query_global_pause_combined(priv)) {
 		for (i = 0; i < NUM_PPORT_PER_PRIO_PFC_COUNTERS; i++) {
-			data[idx++] =
-				MLX5E_READ_CTR64_BE(&priv->stats.pport.per_prio_counters[0],
-						    pport_per_prio_pfc_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pport.per_prio_counters[0],
+					pport_per_prio_pfc_stats_desc, i));
 		}
 	}
 
 	for (i = 0; i < NUM_PPORT_PFC_STALL_COUNTERS(priv); i++)
-		data[idx++] = MLX5E_READ_CTR64_BE(&priv->stats.pport.per_prio_counters[0],
-						  pport_pfc_stall_stats_desc, i);
-
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_BE(
+				      &priv->stats.pport.per_prio_counters[0],
+				      pport_pfc_stall_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(per_prio)
@@ -1865,9 +1900,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(per_prio)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(per_prio)
 {
-	idx = mlx5e_grp_per_prio_traffic_fill_stats(priv, data, idx);
-	idx = mlx5e_grp_per_prio_pfc_fill_stats(priv, data, idx);
-	return idx;
+	mlx5e_grp_per_prio_traffic_fill_stats(priv, data);
+	mlx5e_grp_per_prio_pfc_fill_stats(priv, data);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(per_prio)
@@ -1929,14 +1963,14 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(pme)
 	mlx5_get_pme_stats(priv->mdev, &pme_stats);
 
 	for (i = 0; i < NUM_PME_STATUS_STATS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(pme_stats.status_counters,
-						   mlx5e_pme_status_desc, i);
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(pme_stats.status_counters,
+						   mlx5e_pme_status_desc, i));
 
 	for (i = 0; i < NUM_PME_ERR_STATS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(pme_stats.error_counters,
-						   mlx5e_pme_error_desc, i);
-
-	return idx;
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(pme_stats.error_counters,
+						   mlx5e_pme_error_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(pme) { return; }
@@ -1953,7 +1987,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(tls)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(tls)
 {
-	return idx + mlx5e_ktls_get_stats(priv, data + idx);
+	mlx5e_ktls_get_stats(priv, data);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(tls) { return; }
@@ -2250,10 +2284,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(qos)
 		struct mlx5e_sq_stats *s = READ_ONCE(stats[qid]);
 
 		for (i = 0; i < NUM_QOS_SQ_STATS; i++)
-			data[idx++] = MLX5E_READ_CTR64_CPU(s, qos_sq_stats_desc, i);
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_CPU(s, qos_sq_stats_desc, i));
 	}
-
-	return idx;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(qos) { return; }
@@ -2308,33 +2342,35 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(ptp)
 	int i, tc;
 
 	if (!priv->tx_ptp_opened && !priv->rx_ptp_opened)
-		return idx;
+		return;
 
 	for (i = 0; i < NUM_PTP_CH_STATS; i++)
-		data[idx++] =
-			MLX5E_READ_CTR64_CPU(&priv->ptp_stats.ch,
-					     ptp_ch_stats_desc, i);
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(&priv->ptp_stats.ch,
+						   ptp_ch_stats_desc, i));
 
 	if (priv->tx_ptp_opened) {
 		for (tc = 0; tc < priv->max_opened_tc; tc++)
 			for (i = 0; i < NUM_PTP_SQ_STATS; i++)
-				data[idx++] =
-					MLX5E_READ_CTR64_CPU(&priv->ptp_stats.sq[tc],
-							     ptp_sq_stats_desc, i);
+				mlx5e_ethtool_put_stat(
+					data, MLX5E_READ_CTR64_CPU(
+						      &priv->ptp_stats.sq[tc],
+						      ptp_sq_stats_desc, i));
 
 		for (tc = 0; tc < priv->max_opened_tc; tc++)
 			for (i = 0; i < NUM_PTP_CQ_STATS; i++)
-				data[idx++] =
-					MLX5E_READ_CTR64_CPU(&priv->ptp_stats.cq[tc],
-							     ptp_cq_stats_desc, i);
+				mlx5e_ethtool_put_stat(
+					data, MLX5E_READ_CTR64_CPU(
+						      &priv->ptp_stats.cq[tc],
+						      ptp_cq_stats_desc, i));
 	}
 	if (priv->rx_ptp_opened) {
 		for (i = 0; i < NUM_PTP_RQ_STATS; i++)
-			data[idx++] =
+			mlx5e_ethtool_put_stat(
+				data,
 				MLX5E_READ_CTR64_CPU(&priv->ptp_stats.rq,
-						     ptp_rq_stats_desc, i);
+						     ptp_rq_stats_desc, i));
 	}
-	return idx;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(ptp) { return; }
@@ -2393,44 +2429,50 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channels)
 
 	for (i = 0; i < max_nch; i++)
 		for (j = 0; j < NUM_CH_STATS; j++)
-			data[idx++] =
-				MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->ch,
-						     ch_stats_desc, j);
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR64_CPU(
+					      &priv->channel_stats[i]->ch,
+					      ch_stats_desc, j));
 
 	for (i = 0; i < max_nch; i++) {
 		for (j = 0; j < NUM_RQ_STATS; j++)
-			data[idx++] =
-				MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->rq,
-						     rq_stats_desc, j);
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR64_CPU(
+					      &priv->channel_stats[i]->rq,
+					      rq_stats_desc, j));
 		for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
-			data[idx++] =
-				MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->xskrq,
-						     xskrq_stats_desc, j);
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR64_CPU(
+					      &priv->channel_stats[i]->xskrq,
+					      xskrq_stats_desc, j));
 		for (j = 0; j < NUM_RQ_XDPSQ_STATS; j++)
-			data[idx++] =
-				MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->rq_xdpsq,
-						     rq_xdpsq_stats_desc, j);
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR64_CPU(
+					      &priv->channel_stats[i]->rq_xdpsq,
+					      rq_xdpsq_stats_desc, j));
 	}
 
 	for (tc = 0; tc < priv->max_opened_tc; tc++)
 		for (i = 0; i < max_nch; i++)
 			for (j = 0; j < NUM_SQ_STATS; j++)
-				data[idx++] =
-					MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->sq[tc],
-							     sq_stats_desc, j);
+				mlx5e_ethtool_put_stat(
+					data,
+					MLX5E_READ_CTR64_CPU(
+						&priv->channel_stats[i]->sq[tc],
+						sq_stats_desc, j));
 
 	for (i = 0; i < max_nch; i++) {
 		for (j = 0; j < NUM_XSKSQ_STATS * is_xsk; j++)
-			data[idx++] =
-				MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->xsksq,
-						     xsksq_stats_desc, j);
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR64_CPU(
+					      &priv->channel_stats[i]->xsksq,
+					      xsksq_stats_desc, j));
 		for (j = 0; j < NUM_XDPSQ_STATS; j++)
-			data[idx++] =
-				MLX5E_READ_CTR64_CPU(&priv->channel_stats[i]->xdpsq,
-						     xdpsq_stats_desc, j);
+			mlx5e_ethtool_put_stat(
+				data, MLX5E_READ_CTR64_CPU(
+					      &priv->channel_stats[i]->xdpsq,
+					      xdpsq_stats_desc, j));
 	}
-
-	return idx;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(channels) { return; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 0552b56ae4f4..b71e3fdf92c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -72,10 +72,12 @@ struct mlx5e_stats_grp {
 	u16 update_stats_mask;
 	int (*get_num_stats)(struct mlx5e_priv *priv);
 	void (*fill_strings)(struct mlx5e_priv *priv, u8 **data);
-	int (*fill_stats)(struct mlx5e_priv *priv, u64 *data, int idx);
+	void (*fill_stats)(struct mlx5e_priv *priv, u64 **data);
 	void (*update_stats)(struct mlx5e_priv *priv);
 };
 
+void mlx5e_ethtool_put_stat(u64 **data, u64 val);
+
 typedef const struct mlx5e_stats_grp *const mlx5e_stats_grp_t;
 
 #define MLX5E_STATS_GRP_OP(grp, name) mlx5e_stats_grp_ ## grp ## _ ## name
@@ -90,7 +92,7 @@ typedef const struct mlx5e_stats_grp *const mlx5e_stats_grp_t;
 	void MLX5E_STATS_GRP_OP(grp, fill_strings)(struct mlx5e_priv *priv, u8 **data)
 
 #define MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(grp) \
-	int MLX5E_STATS_GRP_OP(grp, fill_stats)(struct mlx5e_priv *priv, u64 *data, int idx)
+	void MLX5E_STATS_GRP_OP(grp, fill_stats)(struct mlx5e_priv *priv, u64 **data)
 
 #define MLX5E_STATS_GRP(grp) mlx5e_stats_grp_ ## grp
 
-- 
2.31.1


