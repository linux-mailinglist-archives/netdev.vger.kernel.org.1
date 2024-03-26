Return-Path: <netdev+bounces-82279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4988D0AE
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4750D2E29D2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49CB13DBB6;
	Tue, 26 Mar 2024 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A3Xm+OPn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601813D8B8
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491691; cv=fail; b=CEnUvV3/xxogT/q4WogPVX86upzb6GDwxsrM1kQEhNkd88trG1UPyCRJLoP01HCeXJ/r3mmrJlrs84lTmc7EIn/sON77UnHFGXsc3fNGVj7dxlHotxuIFVz3DCuVsunQnl8In0rmi7VQ0QofL6y+lqoVC8cFeSp4S/GTd05Hua0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491691; c=relaxed/simple;
	bh=WC0IojdK7QLyhDxRXfOHLc+gNHRcMl5J7M9TmS+ZwDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJai6I8MvS2LtOxxZnefHA9xjkYKy+0XhVAgD7/HdsGrCSw4sjy7sT+kzlm83X60kuD8LM7mtq2VN+QWVvhz82Ns1qcB9eFYE8wgCE/SwttvEyFHvmV2ZY5xAUE7JzbwMse/9HjpCVv4DdVivdTaJvhIP9DiQarsXPBM6jttRAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A3Xm+OPn; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnoRRq1GYJh5gPk+oMDrupvnkHmIZENj8W4pm+CTQDMYpsmqL9bS6YwhbnYJc34VUXnf9sCQAguAqCGGHLLwO5NAaiu13PzgPkKUAn584NvYAaaIRAAJ24tYtZ0KAxX/HptsZ++Yv8wLBLCnKLSU/sQ0oPyjJofMzDf8aH2lz6JVFUIFlMQLOSUWQH5zXZT4DQhaBJY8J3yhKrV/PZQ8YCJ23HiEJ1krtJAyHH/cercphRD6AQRgKHSjRYcaEEkMyjjQr3tnz9QFLSURABGKS2jIgn/hia/nusxrHA2GKMLygyXV9PbZyHLSaCXa+XNZ7nCus/iL205KKvgydCbAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5PqIBGEP+oFfv0l0ENzebNecmT3oVoMTRpsf9vf2tc=;
 b=kH8XIbIsI5Chfs7bgY22Cq7TpPfp9mIVPVK9WeiSN3ra7OXF1tL2Nj+AtJrniHrCehqk2McclFeS9CqvGrnR91GlkXjdXxVmMgjOLAgvx14yXUDujU1KBir7p/hxozDTN0uvrNLpBwbtcPFBT1pgxrtgmRpafBv/tFcLJxJTvabhYJ1Gsawkhf9yobV69vDYMcHvgpZ7hlj5uA7cnWojVf7PX13+/UUQ1/v2Bl127yPfrdAmgeEYXjnZeCDGXcovos/YLIIShbtWnvjMdrq4KBCNUX1DJ87DXBPEDk4WqlqPogy9KenelfpcpoL30rQV7b5peD0Imv+pk+Wd3y2pGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5PqIBGEP+oFfv0l0ENzebNecmT3oVoMTRpsf9vf2tc=;
 b=A3Xm+OPn8OR5I7bos5fAtygZy/56ZCh3EaYrO02tXONeghAJ/Pd+IYTuY2F8xaFXRaMPvUUut052lzXCZisKnnSMLYxMURyuPgozI21d/X4iUXBoJb9WKVOqD/2eduwV+rdoRJG+5CUQu4wvpvfkYoXyKw/CKCr+bFN48Ay/ASY3lm5GlTPMKAuaizfQfnVP8d2ggdBKMEAZiU6e39+eAvDfWxoKDZg5U0M+Lnr4H/k5dy3ighxecMjvWdANZblvYJzKUajY3vdvV5MTGnzpozqE2wtZE6G9s9C3iYv+rDXAbJ/CHIWs818gjKm/6Y5nPjJNhlNtRE21HWLS30cvEQ==
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 22:21:22 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::b) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.0 via Frontend Transport; Tue, 26 Mar 2024 22:21:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 3/8] net/mlx5e: Use ethtool_sprintf/puts() to fill stats strings
Date: Wed, 27 Mar 2024 00:20:17 +0200
Message-ID: <20240326222022.27926-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1a9819-1414-4523-c016-08dc4de31139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EHCdgCDkHpiwFxtYjGVn4KNIInao7/b2SVa4MRC3ZLxtdy/Bc3yHY/kfZ4RgCGGnizFkci00b3wilwDjGgEBMLgkkGyuOgSAQU7m9zoseYj8sKzBBAwft60Nfwlis2jmuEZNMr0hhDWRJr6AZGeRtnYTKrnum11eeeSKD86+271qUyxF45QSdqM5cv2U3OzQnNRpgFGHnuU6pxfSt6SlRTW8cgwWPSerWHLrS9Dk3A4lobai9hpyUS/YK6gzz8uV7J0CmlDo1qAtPk2+cUK7hIVxS6pnM+SkOZ89tAqGy0zTEYks9nlAiLzqOeOvnBgw3+iADJgsl3R3taguni7pmiA/OBWMug44HDzYq239mNLD7DvDZcZMi2448Ps1kATvWtXBAmOlJ6IZktQqjS9INBKHxAALwin/T29bBK95rnm+Bs2p+B/syVKelqePCgXA2q123HBoWO0iuG8aSrmFwUWNwBpOkImnkAhdVt6uw7Q1d3ofFfQNV93GSOrzo5i4A8PQ9xh6QNW77K7Ya2s406WxbYOtsp44ArAPJEDYHPMZXrPvaEMRCpSooiDgC3pwBKbYT3nWiw1fKF+pkQmeuqFg+3SOs3q0cY6KHY3h9mLLoTwL1B5EiQApE6sPXUmzWWe1xCTSbM82bPkbLhrHa69aHo+KFpog9wjlUvTWgOWEAyEW09X5fXVsLL3NT34rCoM3jbtainGQFmL2bffTZNFhbLHaFfbBy6RHHQDcfHQEiM7rloggJ/L59ZJaX7ag
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:22.0273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1a9819-1414-4523-c016-08dc4de31139
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

From: Gal Pressman <gal@nvidia.com>

Use ethtool_sprintf/puts() helper functions which handle the common
pattern of printing a string into the ethtool strings interface and
incrementing the string pointer by ETH_GSTRING_LEN.

Change the fill_strings callback to accept a **data pointer, and remove
the index and return value.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |  11 +-
 .../mellanox/mlx5/core/en_accel/ktls.h        |   7 +-
 .../mellanox/mlx5/core/en_accel/ktls_stats.c  |  11 +-
 .../mlx5/core/en_accel/macsec_stats.c         |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  10 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 179 +++++++-----------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   4 +-
 7 files changed, 85 insertions(+), 146 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
index dd36b04e30a0..ecf87383ecb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_stats.c
@@ -78,13 +78,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(ipsec_hw)
 	unsigned int i;
 
 	if (!priv->ipsec)
-		return idx;
+		return;
 
 	for (i = 0; i < NUM_IPSEC_HW_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       mlx5e_ipsec_hw_stats_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, mlx5e_ipsec_hw_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(ipsec_hw)
@@ -115,9 +112,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(ipsec_sw)
 
 	if (priv->ipsec)
 		for (i = 0; i < NUM_IPSEC_SW_COUNTERS; i++)
-			strcpy(data + (idx++) * ETH_GSTRING_LEN,
-			       mlx5e_ipsec_sw_stats_desc[i].format);
-	return idx;
+			ethtool_puts(data, mlx5e_ipsec_sw_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(ipsec_sw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index adc6d8ea0960..9b96bee194ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -95,7 +95,7 @@ int mlx5e_ktls_init(struct mlx5e_priv *priv);
 void mlx5e_ktls_cleanup(struct mlx5e_priv *priv);
 
 int mlx5e_ktls_get_count(struct mlx5e_priv *priv);
-int mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t *data);
+void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data);
 int mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 *data);
 
 #else
@@ -144,10 +144,7 @@ static inline bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 static inline int mlx5e_ktls_init(struct mlx5e_priv *priv) { return 0; }
 static inline void mlx5e_ktls_cleanup(struct mlx5e_priv *priv) { }
 static inline int mlx5e_ktls_get_count(struct mlx5e_priv *priv) { return 0; }
-static inline int mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t *data)
-{
-	return 0;
-}
+static inline void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data) { }
 
 static inline int mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 *data)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
index 7c1c0eb16787..06363f2653e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
@@ -58,20 +58,17 @@ int mlx5e_ktls_get_count(struct mlx5e_priv *priv)
 	return ARRAY_SIZE(mlx5e_ktls_sw_stats_desc);
 }
 
-int mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t *data)
+void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data)
 {
-	unsigned int i, n, idx = 0;
+	unsigned int i, n;
 
 	if (!priv->tls)
-		return 0;
+		return;
 
 	n = mlx5e_ktls_get_count(priv);
 
 	for (i = 0; i < n; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       mlx5e_ktls_sw_stats_desc[i].format);
-
-	return n;
+		ethtool_puts(data, mlx5e_ktls_sw_stats_desc[i].format);
 }
 
 int mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 *data)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
index 4559ee16a11a..a79e2786be56 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
@@ -38,16 +38,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(macsec_hw)
 	unsigned int i;
 
 	if (!priv->macsec)
-		return idx;
+		return;
 
 	if (!mlx5e_is_macsec_device(priv->mdev))
-		return idx;
+		return;
 
 	for (i = 0; i < NUM_MACSEC_HW_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       mlx5e_macsec_hw_stats_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, mlx5e_macsec_hw_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(macsec_hw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 05527418fa64..e41fbf377ae8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -135,9 +135,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw_rep)
 	int i;
 
 	for (i = 0; i < NUM_VPORT_REP_SW_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       sw_rep_stats_desc[i].format);
-	return idx;
+		ethtool_puts(data, sw_rep_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw_rep)
@@ -176,11 +174,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(vport_rep)
 	int i;
 
 	for (i = 0; i < NUM_VPORT_REP_HW_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, vport_rep_stats_desc[i].format);
+		ethtool_puts(data, vport_rep_stats_desc[i].format);
 	for (i = 0; i < NUM_VPORT_REP_LOOPBACK_COUNTERS(priv->mdev); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       vport_rep_loopback_stats_desc[i].format);
-	return idx;
+		ethtool_puts(data, vport_rep_loopback_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vport_rep)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index f3d0898bdbc6..6be0bcc9a3f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -97,10 +97,10 @@ void mlx5e_stats_fill_strings(struct mlx5e_priv *priv, u8 *data)
 {
 	mlx5e_stats_grp_t *stats_grps = priv->profile->stats_grps;
 	const unsigned int num_stats_grps = stats_grps_num(priv);
-	int i, idx = 0;
+	int i;
 
 	for (i = 0; i < num_stats_grps; i++)
-		idx = stats_grps[i]->fill_strings(priv, data, idx);
+		stats_grps[i]->fill_strings(priv, &data);
 }
 
 /* Concrete NIC Stats */
@@ -257,8 +257,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
 	int i;
 
 	for (i = 0; i < NUM_SW_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, sw_stats_desc[i].format);
-	return idx;
+		ethtool_puts(data, sw_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
@@ -591,14 +590,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(qcnt)
 	int i;
 
 	for (i = 0; i < NUM_Q_COUNTERS && q_counter_any(priv); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       q_stats_desc[i].format);
+		ethtool_puts(data, q_stats_desc[i].format);
 
 	for (i = 0; i < NUM_DROP_RQ_COUNTERS && priv->drop_rq_q_counter; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       drop_rq_stats_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, drop_rq_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(qcnt)
@@ -685,18 +680,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(vnic_env)
 	int i;
 
 	for (i = 0; i < NUM_VNIC_ENV_STEER_COUNTERS(priv->mdev); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       vnic_env_stats_steer_desc[i].format);
+		ethtool_puts(data, vnic_env_stats_steer_desc[i].format);
 
 	for (i = 0; i < NUM_VNIC_ENV_DEV_OOB_COUNTERS(priv->mdev); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       vnic_env_stats_dev_oob_desc[i].format);
+		ethtool_puts(data, vnic_env_stats_dev_oob_desc[i].format);
 
 	for (i = 0; i < NUM_VNIC_ENV_DROP_COUNTERS(priv->mdev); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       vnic_env_stats_drop_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, vnic_env_stats_drop_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vnic_env)
@@ -798,13 +788,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(vport)
 	int i;
 
 	for (i = 0; i < NUM_VPORT_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, vport_stats_desc[i].format);
+		ethtool_puts(data, vport_stats_desc[i].format);
 
 	for (i = 0; i < NUM_VPORT_LOOPBACK_COUNTERS(priv->mdev); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       vport_loopback_stats_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, vport_loopback_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vport)
@@ -868,8 +855,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(802_3)
 	int i;
 
 	for (i = 0; i < NUM_PPORT_802_3_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, pport_802_3_stats_desc[i].format);
-	return idx;
+		ethtool_puts(data, pport_802_3_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(802_3)
@@ -1029,8 +1015,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(2863)
 	int i;
 
 	for (i = 0; i < NUM_PPORT_2863_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, pport_2863_stats_desc[i].format);
-	return idx;
+		ethtool_puts(data, pport_2863_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(2863)
@@ -1088,8 +1073,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(2819)
 	int i;
 
 	for (i = 0; i < NUM_PPORT_2819_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, pport_2819_stats_desc[i].format);
-	return idx;
+		ethtool_puts(data, pport_2819_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(2819)
@@ -1215,21 +1199,18 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
-	strcpy(data + (idx++) * ETH_GSTRING_LEN, "link_down_events_phy");
+	ethtool_puts(data, "link_down_events_phy");
 
 	if (!MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		return idx;
+		return;
 
 	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       pport_phy_statistical_stats_desc[i].format);
+		ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-			strcpy(data + (idx++) * ETH_GSTRING_LEN,
-			       pport_phy_statistical_err_lanes_stats_desc[i].format);
-
-	return idx;
+			ethtool_puts(data,
+				     pport_phy_statistical_err_lanes_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
@@ -1436,9 +1417,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(eth_ext)
 
 	if (MLX5_CAP_PCAM_FEATURE((priv)->mdev, rx_buffer_fullness_counters))
 		for (i = 0; i < NUM_PPORT_ETH_EXT_COUNTERS; i++)
-			strcpy(data + (idx++) * ETH_GSTRING_LEN,
-			       pport_eth_ext_stats_desc[i].format);
-	return idx;
+			ethtool_puts(data, pport_eth_ext_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(eth_ext)
@@ -1516,19 +1495,16 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(pcie)
 
 	if (MLX5_CAP_MCAM_FEATURE((priv)->mdev, pcie_performance_group))
 		for (i = 0; i < NUM_PCIE_PERF_COUNTERS; i++)
-			strcpy(data + (idx++) * ETH_GSTRING_LEN,
-			       pcie_perf_stats_desc[i].format);
+			ethtool_puts(data, pcie_perf_stats_desc[i].format);
 
 	if (MLX5_CAP_MCAM_FEATURE((priv)->mdev, tx_overflow_buffer_pkt))
 		for (i = 0; i < NUM_PCIE_PERF_COUNTERS64; i++)
-			strcpy(data + (idx++) * ETH_GSTRING_LEN,
-			       pcie_perf_stats_desc64[i].format);
+			ethtool_puts(data, pcie_perf_stats_desc64[i].format);
 
 	if (MLX5_CAP_MCAM_FEATURE((priv)->mdev, pcie_outbound_stalled))
 		for (i = 0; i < NUM_PCIE_PERF_STALL_COUNTERS; i++)
-			strcpy(data + (idx++) * ETH_GSTRING_LEN,
-			       pcie_perf_stall_stats_desc[i].format);
-	return idx;
+			ethtool_puts(data,
+				     pcie_perf_stall_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(pcie)
@@ -1609,18 +1585,18 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(per_port_buff_congest)
 	int i, prio;
 
 	if (!MLX5_CAP_GEN(mdev, sbcam_reg))
-		return idx;
+		return;
 
 	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
 		for (i = 0; i < NUM_PPORT_PER_TC_PRIO_COUNTERS; i++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				pport_per_tc_prio_stats_desc[i].format, prio);
+			ethtool_sprintf(data,
+					pport_per_tc_prio_stats_desc[i].format,
+					prio);
 		for (i = 0; i < NUM_PPORT_PER_TC_CONGEST_PRIO_COUNTERS; i++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				pport_per_tc_congest_prio_stats_desc[i].format, prio);
+			ethtool_sprintf(data,
+					pport_per_tc_congest_prio_stats_desc[i].format,
+					prio);
 	}
-
-	return idx;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(per_port_buff_congest)
@@ -1728,19 +1704,17 @@ static int mlx5e_grp_per_prio_traffic_get_num_stats(void)
 	return NUM_PPORT_PER_PRIO_TRAFFIC_COUNTERS * NUM_PPORT_PRIO;
 }
 
-static int mlx5e_grp_per_prio_traffic_fill_strings(struct mlx5e_priv *priv,
-						   u8 *data,
-						   int idx)
+static void mlx5e_grp_per_prio_traffic_fill_strings(struct mlx5e_priv *priv,
+						    u8 **data)
 {
 	int i, prio;
 
 	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
 		for (i = 0; i < NUM_PPORT_PER_PRIO_TRAFFIC_COUNTERS; i++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				pport_per_prio_traffic_stats_desc[i].format, prio);
+			ethtool_sprintf(data,
+					pport_per_prio_traffic_stats_desc[i].format,
+					prio);
 	}
-
-	return idx;
 }
 
 static int mlx5e_grp_per_prio_traffic_fill_stats(struct mlx5e_priv *priv,
@@ -1816,9 +1790,8 @@ static int mlx5e_grp_per_prio_pfc_get_num_stats(struct mlx5e_priv *priv)
 		NUM_PPORT_PFC_STALL_COUNTERS(priv);
 }
 
-static int mlx5e_grp_per_prio_pfc_fill_strings(struct mlx5e_priv *priv,
-					       u8 *data,
-					       int idx)
+static void mlx5e_grp_per_prio_pfc_fill_strings(struct mlx5e_priv *priv,
+						u8 **data)
 {
 	unsigned long pfc_combined;
 	int i, prio;
@@ -1829,23 +1802,22 @@ static int mlx5e_grp_per_prio_pfc_fill_strings(struct mlx5e_priv *priv,
 			char pfc_string[ETH_GSTRING_LEN];
 
 			snprintf(pfc_string, sizeof(pfc_string), "prio%d", prio);
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				pport_per_prio_pfc_stats_desc[i].format, pfc_string);
+			ethtool_sprintf(data,
+					pport_per_prio_pfc_stats_desc[i].format,
+					pfc_string);
 		}
 	}
 
 	if (mlx5e_query_global_pause_combined(priv)) {
 		for (i = 0; i < NUM_PPORT_PER_PRIO_PFC_COUNTERS; i++) {
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				pport_per_prio_pfc_stats_desc[i].format, "global");
+			ethtool_sprintf(data,
+					pport_per_prio_pfc_stats_desc[i].format,
+					"global");
 		}
 	}
 
 	for (i = 0; i < NUM_PPORT_PFC_STALL_COUNTERS(priv); i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN,
-		       pport_pfc_stall_stats_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, pport_pfc_stall_stats_desc[i].format);
 }
 
 static int mlx5e_grp_per_prio_pfc_fill_stats(struct mlx5e_priv *priv,
@@ -1887,9 +1859,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(per_prio)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(per_prio)
 {
-	idx = mlx5e_grp_per_prio_traffic_fill_strings(priv, data, idx);
-	idx = mlx5e_grp_per_prio_pfc_fill_strings(priv, data, idx);
-	return idx;
+	mlx5e_grp_per_prio_traffic_fill_strings(priv, data);
+	mlx5e_grp_per_prio_pfc_fill_strings(priv, data);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(per_prio)
@@ -1944,12 +1915,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(pme)
 	int i;
 
 	for (i = 0; i < NUM_PME_STATUS_STATS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, mlx5e_pme_status_desc[i].format);
+		ethtool_puts(data, mlx5e_pme_status_desc[i].format);
 
 	for (i = 0; i < NUM_PME_ERR_STATS; i++)
-		strcpy(data + (idx++) * ETH_GSTRING_LEN, mlx5e_pme_error_desc[i].format);
-
-	return idx;
+		ethtool_puts(data, mlx5e_pme_error_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(pme)
@@ -1979,7 +1948,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(tls)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(tls)
 {
-	return idx + mlx5e_ktls_get_strings(priv, data + idx * ETH_GSTRING_LEN);
+	mlx5e_ktls_get_strings(priv, data);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(tls)
@@ -2264,10 +2233,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(qos)
 
 	for (qid = 0; qid < max_qos_sqs; qid++)
 		for (i = 0; i < NUM_QOS_SQ_STATS; i++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				qos_sq_stats_desc[i].format, qid);
-
-	return idx;
+			ethtool_sprintf(data, qos_sq_stats_desc[i].format, qid);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(qos)
@@ -2312,29 +2278,29 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(ptp)
 	int i, tc;
 
 	if (!priv->tx_ptp_opened && !priv->rx_ptp_opened)
-		return idx;
+		return;
 
 	for (i = 0; i < NUM_PTP_CH_STATS; i++)
-		sprintf(data + (idx++) * ETH_GSTRING_LEN,
-			"%s", ptp_ch_stats_desc[i].format);
+		ethtool_puts(data, ptp_ch_stats_desc[i].format);
 
 	if (priv->tx_ptp_opened) {
 		for (tc = 0; tc < priv->max_opened_tc; tc++)
 			for (i = 0; i < NUM_PTP_SQ_STATS; i++)
-				sprintf(data + (idx++) * ETH_GSTRING_LEN,
-					ptp_sq_stats_desc[i].format, tc);
+				ethtool_sprintf(data,
+						ptp_sq_stats_desc[i].format,
+						tc);
 
 		for (tc = 0; tc < priv->max_opened_tc; tc++)
 			for (i = 0; i < NUM_PTP_CQ_STATS; i++)
-				sprintf(data + (idx++) * ETH_GSTRING_LEN,
-					ptp_cq_stats_desc[i].format, tc);
+				ethtool_sprintf(data,
+						ptp_cq_stats_desc[i].format,
+						tc);
 	}
 	if (priv->rx_ptp_opened) {
 		for (i = 0; i < NUM_PTP_RQ_STATS; i++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				ptp_rq_stats_desc[i].format, MLX5E_PTP_CHANNEL_IX);
+			ethtool_sprintf(data, ptp_rq_stats_desc[i].format,
+					MLX5E_PTP_CHANNEL_IX);
 	}
-	return idx;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(ptp)
@@ -2394,38 +2360,29 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 
 	for (i = 0; i < max_nch; i++)
 		for (j = 0; j < NUM_CH_STATS; j++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				ch_stats_desc[j].format, i);
+			ethtool_sprintf(data, ch_stats_desc[j].format, i);
 
 	for (i = 0; i < max_nch; i++) {
 		for (j = 0; j < NUM_RQ_STATS; j++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				rq_stats_desc[j].format, i);
+			ethtool_sprintf(data, rq_stats_desc[j].format, i);
 		for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				xskrq_stats_desc[j].format, i);
+			ethtool_sprintf(data, xskrq_stats_desc[j].format, i);
 		for (j = 0; j < NUM_RQ_XDPSQ_STATS; j++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				rq_xdpsq_stats_desc[j].format, i);
+			ethtool_sprintf(data, rq_xdpsq_stats_desc[j].format, i);
 	}
 
 	for (tc = 0; tc < priv->max_opened_tc; tc++)
 		for (i = 0; i < max_nch; i++)
 			for (j = 0; j < NUM_SQ_STATS; j++)
-				sprintf(data + (idx++) * ETH_GSTRING_LEN,
-					sq_stats_desc[j].format,
-					i + tc * max_nch);
+				ethtool_sprintf(data, sq_stats_desc[j].format,
+						i + tc * max_nch);
 
 	for (i = 0; i < max_nch; i++) {
 		for (j = 0; j < NUM_XSKSQ_STATS * is_xsk; j++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				xsksq_stats_desc[j].format, i);
+			ethtool_sprintf(data, xsksq_stats_desc[j].format, i);
 		for (j = 0; j < NUM_XDPSQ_STATS; j++)
-			sprintf(data + (idx++) * ETH_GSTRING_LEN,
-				xdpsq_stats_desc[j].format, i);
+			ethtool_sprintf(data, xdpsq_stats_desc[j].format, i);
 	}
-
-	return idx;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channels)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 12b3607afecd..0552b56ae4f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -71,7 +71,7 @@ struct mlx5e_priv;
 struct mlx5e_stats_grp {
 	u16 update_stats_mask;
 	int (*get_num_stats)(struct mlx5e_priv *priv);
-	int (*fill_strings)(struct mlx5e_priv *priv, u8 *data, int idx);
+	void (*fill_strings)(struct mlx5e_priv *priv, u8 **data);
 	int (*fill_stats)(struct mlx5e_priv *priv, u64 *data, int idx);
 	void (*update_stats)(struct mlx5e_priv *priv);
 };
@@ -87,7 +87,7 @@ typedef const struct mlx5e_stats_grp *const mlx5e_stats_grp_t;
 	void MLX5E_STATS_GRP_OP(grp, update_stats)(struct mlx5e_priv *priv)
 
 #define MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(grp) \
-	int MLX5E_STATS_GRP_OP(grp, fill_strings)(struct mlx5e_priv *priv, u8 *data, int idx)
+	void MLX5E_STATS_GRP_OP(grp, fill_strings)(struct mlx5e_priv *priv, u8 **data)
 
 #define MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(grp) \
 	int MLX5E_STATS_GRP_OP(grp, fill_stats)(struct mlx5e_priv *priv, u64 *data, int idx)
-- 
2.31.1


