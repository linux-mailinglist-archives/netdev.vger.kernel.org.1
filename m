Return-Path: <netdev+bounces-82280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB16488D0AF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB842E1F17
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81613DDA9;
	Tue, 26 Mar 2024 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P4V7Isws"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF351CAAE
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491693; cv=fail; b=NIWMKMaTB5snBNg1elDMt7/Fk2U34Nkn8wJzbIVZPXq7Q81suHnxbmAfVyjALPA5tGCKsVIXbKFp6wZopOC8ooLpUhGfYixKi4yHDAcc3Wl0ARPjARBqCzVCg/vJuHBNgL/o33lnMLxAN8StfR632tCHpyIRHTD2Ln7bEo1mxlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491693; c=relaxed/simple;
	bh=fbvn2bmbjJWW84QdPmT5moK5DqdaZ+XYE2BdHjmPQSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPgesdGoonOt0C6BG3SEzhGMrWtjO7l6vJQZhb0l13M/5yqV7z6hJpUU5o07t/JaqnRNo+oBiGhc4EKJ4M3+oczHWKzFzQpWuJN15C9yEKUY/SmYc1YZnzW6Ff9ciVwsijIJW9j3k2oBIxnTUofV0eb4jYidgKsJ1vo07ir02l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P4V7Isws; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTvCwulOyT1t+VGxKYOJRTpbVA1fOX6YOstzFvWxHEcCn6a/QDZdmtwzuVq7r8Ro4yWcEHI7AeEXNL9KhCNtjD7mJheJJsj9Y+gHfyOP/+bfZB0XLkfmbqrOWBQ5KgKqB3/lNlCdcoCqjy5RF1SwbhEZ94wkzvNN5UKbYQ5FsEQ2cHLgeDrRdBFNzYmks6nT61dXgnnYQPHSl7L/lURnSv8apvUoqtlBzhW5H2O0unxIv3kaggXGVDc9xEq84HZ5ODKmfAN/TKqszrtw3T4KShy7rk5huTY5FiCJsslr6dUGsBJYtlNgOheZPD/KHt0u/RQ+dwttWgcVMXciK0/6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt70w2OzJkL4a6C82MV45hK0B5iNMeuP8akHOem/6lo=;
 b=HD4WajgUhqnoljj0u81fqiqlN7GMvg9VlxXzhkufL0OkYm6zYLvxBv+TugWiQr8lhoFuo7ffEBjm8iwxXcB8OsYpWZUb1hGxa3buzEVmK56TwqdI+S/1Rszkd8fpKICGzdIGUX/Zsqkh/QtBtRizJFMU9/ty8HWsK2T+4Pa0l05JEIr3PJfgG7vT7PXNzHr12WV5so0w0k1XXtJeK6RC6pVTzdSDAsotOHubx9AUSNLK8j/I9XdRbL3EJIAZUMhPT8K4ejIUflqt6o7ny2cgSJ9UV0YoIqrXUSGaOcB82pN9Q3oWssg51a2AhZeF/KpEyEcdKTY4mUOAD+RZm2tGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt70w2OzJkL4a6C82MV45hK0B5iNMeuP8akHOem/6lo=;
 b=P4V7IswsM78FBlPbujI8HsdXVqzfSlxOOJ682Bu0W2AxXTEmq52vF8umiRBdHOfVrp6vtoDQXDKAUP5iJof+z88AlsHaV6RdEtoJAnp71E9PNyXNLVNmCkOnfx3a82nYKo78saRXmbB52xieZhXb5wj8Yh7NaXcw13xqQ5BjQd9qxz/gmSZb3apEkInJ3NiKr0hI0d2ZJGhJCjDPYrj/yc8yQui2ATHRAuXqhsBBt6GF5UDWnNai3W5enzC7th5Gmasf3eFcaatvAgx/9hJ3WjJEF2x/eQSHd6BreYfanIJ4wECqx/jOUvEY4LTGysPr3n/A6gs3cPBTGIYu20u5Ig==
Received: from CH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:32::25)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 22:21:27 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::ef) by CH0PR07CA0020.outlook.office365.com
 (2603:10b6:610:32::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 22:21:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 4/8] net/mlx5e: Make stats group fill_stats callbacks consistent with the API
Date: Wed, 27 Mar 2024 00:20:18 +0200
Message-ID: <20240326222022.27926-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 9347586b-6ad4-44ab-01ba-08dc4de313e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sxVbl/Ui0uc+0TzzuHxl5KV/9JQwmkrgHOz8PgijTOL8L9F+XPGG6v0NEovI5vMWA2pnjEmuJw1erIWzXSCyd4/ZkyDo1LS20UgxpmVOUlYVjMkPG2oF+n9JZfnrH5cQoP2J/8gWInzeXvEM71e6dSP6J1ppdjhpNTZ6ZVvua8YTMyeAHaz7MP2KIScMb7CiGu4DMOMJXTVYao4W/WRpu5w+bqr3K4e0gGWJLX+PC2Q630cs5kIf3NOObeP5ENKy3qQbf5RU6YcQmSDSi4OVV920tyZYKpQRuG+Bj0erJNsXseLIhqg9VMK/gYmw/GGqQM5ZuUuvwepQn6R0wxsxp1CFd7C9dO3S8blR2WAsxX5ZlmmhFH59Zsc/nCYIMnh2h/IL/jpMN+xrMft9IUZe0NQgZbcuIc1gBOr6HUucvqrxu+yF1RAis6mn7351u+6p605JWXWALOAzuosNnFuGQQXTEutT/3UUt4IKcHmzqhd4x5bYG52FqvUOa/Vd4HQPARWvQi/kOJ1Casb+D8VzjLN4UtFWoJW2KPytvVPkKKWW+/HHZZ3JLYL5MMphimcSQwQS78Qe6rsjPBqR6kqtiC85K5T4jIr3IVf/kYnC/ZNopPdKSNcf3rwZg+NTIHBYK4/CbTMm2n5ojgjKAmUGoG598vhlCtKgEpr3e7IGyva376C8uN/XW5VFRlOxaT8xFhHlaHxgKXrK/p1/U2TOY8TcRLZswdjfigZdPlDyDpdqVxbYZm5LQo3EeII5Jlxb
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:26.4895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9347586b-6ad4-44ab-01ba-08dc4de313e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

From: Gal Pressman <gal@nvidia.com>

The fill_strings() callbacks were changed to accept a **data pointer,
and not rely on propagating the index value.
Make a similar change to fill_stats() callbacks to keep the API
consistent.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
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


