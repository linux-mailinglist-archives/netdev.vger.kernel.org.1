Return-Path: <netdev+bounces-221376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06188B5058E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C102F5602FC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E3302CD0;
	Tue,  9 Sep 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xf0VTaJc"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35B3019AF
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443807; cv=none; b=rMj+aLWAc7ZD8jcmMn1OCMo60dijl8Pk0MvIcIXLm00UognU4JzADEGDS1ef2ep7nttVCXnvD51tZqyTzYc0BEPeiSNT06yMhszfxB6v3ov4ijQKagQ0PUcIywWkeAW8c4pGniOwhZ7604aQybJnDbKn6qOl3rxcykkulPuOYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443807; c=relaxed/simple;
	bh=WpNkvHMRQxNg4kiyEHyTdasKQtZqOZr2UiSQNKkqdho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4tfk1nOuofbJlfmRsxyMIOjNY6pz3bEOz3V4UE/Bfc9wonNn5WrzxOxC21gQwDpSJctCatJH3f8cmIEt3+zQy55EFqea+KuNwVtvF+a1hCkOk8DQtl7jNKmwOVYvFikMAO4bY1q98ppfWXmIVZLbYyYFjMEn/DqNw1YTjW9AbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xf0VTaJc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757443803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow1N5ZbVwWyIftvNl/GTIXRoXSZ4HXSrkbkvkKaQ4wE=;
	b=Xf0VTaJc/Z+O/CCdjlk0ktKMb7mKvJqomSDSHq4Lf8TzikzpmPZAsP2ZS2OcgPQd0CJCmv
	Z5EWE21bf1YJT//LJBlTcXQEUAfC80YrqAZ7pzMHFTok9peEeFACK40tN14iq3UcXEM0i4
	3CA+c7QJXzF8TeKkIVyj2VlafjjW8Bg=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Yael Chemla <ychemla@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/4] net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
Date: Tue,  9 Sep 2025 18:42:15 +0000
Message-ID: <20250909184216.1524669-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20250909184216.1524669-1-vadim.fedorenko@linux.dev>
References: <20250909184216.1524669-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for querying the Ports Phy Histogram Configuration
Register (PPHCR) to retrieve RS-FEC histogram bin ranges. The ranges
are stored in a static array and will be used to map histogram counters
to error levels.

The actual RS-FEC histogram statistics are not yet reported in this
commit and will be handled in a downstream patch.

Co-developed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 10 ++++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 58 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 +-
 5 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0dd3bc0f4caa..8b2e81170e6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -950,6 +950,7 @@ struct mlx5e_priv {
 	struct mlx5e_mqprio_rl    *mqprio_rl;
 	struct dentry             *dfs_root;
 	struct mlx5_devcom_comp_dev *devcom;
+	struct ethtool_fec_hist_range *fec_ranges;
 };
 
 struct mlx5e_dev {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index bcc3bbb78cc9..fd45384a855b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1932,7 +1932,7 @@ static void mlx5e_get_fec_stats(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
-	mlx5e_stats_fec_get(priv, fec_stats);
+	mlx5e_stats_fec_get(priv, fec_stats, hist);
 }
 
 static int mlx5e_get_fecparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 714cce595692..1e516b354485 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6246,8 +6246,17 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 	if (!priv->channel_stats)
 		goto err_free_tx_rates;
 
+	priv->fec_ranges = kcalloc_node(ETHTOOL_FEC_HIST_MAX,
+					sizeof(*priv->fec_ranges),
+					GFP_KERNEL,
+					node);
+	if (!priv->fec_ranges)
+		goto err_free_channel_stats;
+
 	return 0;
 
+err_free_channel_stats:
+	kfree(priv->channel_stats);
 err_free_tx_rates:
 	kfree(priv->tx_rates);
 err_free_txq2sq_stats:
@@ -6271,6 +6280,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	if (!priv->mdev)
 		return;
 
+	kfree(priv->fec_ranges);
 	for (i = 0; i < priv->stats_nch; i++)
 		kvfree(priv->channel_stats[i]);
 	kfree(priv->channel_stats);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index aae0022e8736..f64cae6dd367 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1490,8 +1490,62 @@ static void fec_set_corrected_bits_total(struct mlx5e_priv *priv,
 				      phy_corrected_bits);
 }
 
+#define MLX5E_FEC_RS_HIST_MAX 16
+
+static u8
+fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv,
+			     const struct ethtool_fec_hist_range **ranges)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	u32 out[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
+	int sz = MLX5_ST_SZ_BYTES(pphcr_reg);
+	u8 active_hist_type, num_of_bins;
+
+	memset(priv->fec_ranges, 0, sizeof(priv->fec_ranges));
+	MLX5_SET(pphcr_reg, in, local_port, 1);
+	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPHCR, 0, 0))
+		return 0;
+
+	active_hist_type = MLX5_GET(pphcr_reg, out, active_hist_type);
+	if (!active_hist_type)
+		return 0;
+
+	num_of_bins = MLX5_GET(pphcr_reg, out, num_of_bins);
+	if (WARN_ON_ONCE(num_of_bins > MLX5E_FEC_RS_HIST_MAX))
+		return 0;
+
+	for (u8 i = 0; i < num_of_bins; i++) {
+		void *bin_range = MLX5_ADDR_OF(pphcr_reg, out, bin_range[i]);
+
+		priv->fec_ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
+						    high_val);
+		priv->fec_ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
+						   low_val);
+	}
+	*ranges = priv->fec_ranges;
+
+	return num_of_bins;
+}
+
+static void fec_set_histograms_stats(struct mlx5e_priv *priv, int mode,
+				     struct ethtool_fec_hist *hist)
+{
+	switch (mode) {
+	case MLX5E_FEC_RS_528_514:
+	case MLX5E_FEC_RS_544_514:
+	case MLX5E_FEC_LLRS_272_257_1:
+	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
+		fec_rs_histogram_fill_ranges(priv, &hist->ranges);
+		break;
+	default:
+		return;
+	}
+}
+
 void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
-			 struct ethtool_fec_stats *fec_stats)
+			 struct ethtool_fec_stats *fec_stats,
+			 struct ethtool_fec_hist *hist)
 {
 	int mode = fec_active_mode(priv->mdev);
 
@@ -1501,6 +1555,7 @@ void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
 
 	fec_set_corrected_bits_total(priv, fec_stats);
 	fec_set_block_stats(priv, mode, fec_stats);
+	fec_set_histograms_stats(priv, mode, hist);
 }
 
 #define PPORT_ETH_EXT_OFF(c) \
@@ -2619,3 +2674,4 @@ unsigned int mlx5e_nic_stats_grps_num(struct mlx5e_priv *priv)
 {
 	return ARRAY_SIZE(mlx5e_nic_stats_grps);
 }
+
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 72dbcc1928ef..6019f47308fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -117,8 +117,8 @@ void mlx5e_stats_update_ndo_stats(struct mlx5e_priv *priv);
 void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 			   struct ethtool_pause_stats *pause_stats);
 void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
-			 struct ethtool_fec_stats *fec_stats);
-
+			 struct ethtool_fec_stats *fec_stats,
+			 struct ethtool_fec_hist *hist);
 void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,
 			     struct ethtool_eth_phy_stats *phy_stats);
 void mlx5e_stats_eth_mac_get(struct mlx5e_priv *priv,
-- 
2.47.3


