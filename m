Return-Path: <netdev+bounces-225210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900CFB8FF4E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D5B2A150A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5932FF141;
	Mon, 22 Sep 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UhTDV1or"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AA2FBE1C
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536164; cv=none; b=AE538YiDYQU6BZKyPdgNv8IpQ9kmsQ+2ikFztmG07hJnFwka617XjfXxpomQwuScua0lEXhYj6k1wwJ08le6piT5KPKQhd2mA7imN9sMHf6fv2b9IxvnH+s/Bz0bZqQs5T5LmcoBlvAZL5BUJPEJ5b5P4zgtcdXVtsVTHYE0g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536164; c=relaxed/simple;
	bh=A+Ho1n8sCkOygpnDYqItQQNMPPICy+KlMkJUO3mY7+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLAQWgUpmCazjQ01I5ZNtYPKyvpFuSbi/hLyAdbdC4S2uI0qoNSiprKATE9XKoOaXGiYeJRBoAgMzBr+oMnMTYlaWUocGVXHhfwWZ01OlXuJqkrdMdWOnpUerBdqc7AZ01SMF5/FkLEF/SjOmv7uliAdzHf/isnh7pNIYAmkR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UhTDV1or; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758536160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9W3IamzMNpplR13nn0LHb9QH78ZWs3o8qUYPSAXxLV0=;
	b=UhTDV1orhJIsancYeY65F+OypZ1Cmw3ttUDoFwWr+9gJgPHtO8QLtb9dEBamoSMBXtgJ+l
	2dxH5D0PIyRu8YqEqu9bK10pO2YYmmd2c0X3EldmRdA66uOm2MYLlEF2FNrvrURp+FHlhJ
	Xg7OAH40am2g9kNgTscNrjOAtCPQtMI=
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Yael Chemla <ychemla@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v5 3/5] net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
Date: Mon, 22 Sep 2025 10:07:39 +0000
Message-ID: <20250922100741.2167024-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922100741.2167024-1-vadim.fedorenko@linux.dev>
References: <20250922100741.2167024-1-vadim.fedorenko@linux.dev>
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
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 ++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 81 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  3 +-
 5 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 4ffbc263d60f..14e3207b14e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -956,6 +956,7 @@ struct mlx5e_priv {
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
index 5e007bb3bad1..0c79c42ae538 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6279,8 +6279,15 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 	if (!priv->channel_stats)
 		goto err_free_tx_rates;
 
+	priv->fec_ranges = kcalloc(ETHTOOL_FEC_HIST_MAX,
+				   sizeof(*priv->fec_ranges), GFP_KERNEL);
+	if (!priv->fec_ranges)
+		goto err_free_channel_stats;
+
 	return 0;
 
+err_free_channel_stats:
+	kfree(priv->channel_stats);
 err_free_tx_rates:
 	kfree(priv->tx_rates);
 err_free_txq2sq_stats:
@@ -6304,6 +6311,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	if (!priv->mdev)
 		return;
 
+	kfree(priv->fec_ranges);
 	for (i = 0; i < priv->stats_nch; i++)
 		kvfree(priv->channel_stats[i]);
 	kfree(priv->channel_stats);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index aae0022e8736..e6613672b8f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1490,8 +1490,86 @@ static void fec_set_corrected_bits_total(struct mlx5e_priv *priv,
 				      phy_corrected_bits);
 }
 
+#define MLX5E_FEC_RS_HIST_MAX 16
+
+enum {
+	MLX5E_HISTOGRAM_FEC_RS_544_514 = 1,
+	MLX5E_HISTOGRAM_FEC_LLRS = 2,
+	MLX5E_HISTOGRAM_FEC_RS_528_514 = 3,
+};
+
+static bool fec_rs_validate_hist_type(int mode, int hist_type)
+{
+	switch (mode) {
+	case MLX5E_FEC_RS_528_514:
+		return hist_type == MLX5E_HISTOGRAM_FEC_RS_528_514;
+	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
+	case MLX5E_FEC_RS_544_514:
+		return hist_type == MLX5E_HISTOGRAM_FEC_RS_544_514;
+	case MLX5E_FEC_LLRS_272_257_1:
+		return hist_type == MLX5E_HISTOGRAM_FEC_LLRS;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static u8
+fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
+			     const struct ethtool_fec_hist_range **ranges)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	u32 out[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
+	int sz = MLX5_ST_SZ_BYTES(pphcr_reg);
+	u8 hist_type, num_of_bins;
+
+	memset(priv->fec_ranges, 0,
+	       ETHTOOL_FEC_HIST_MAX * sizeof(*priv->fec_ranges));
+	MLX5_SET(pphcr_reg, in, local_port, 1);
+	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPHCR, 0, 0))
+		return 0;
+
+	hist_type = MLX5_GET(pphcr_reg, out, active_hist_type);
+	if (!fec_rs_validate_hist_type(mode, hist_type))
+		return 0;
+
+	num_of_bins = MLX5_GET(pphcr_reg, out, num_of_bins);
+	if (WARN_ON_ONCE(num_of_bins > MLX5E_FEC_RS_HIST_MAX))
+		return 0;
+
+	for (int i = 0; i < num_of_bins; i++) {
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
+		fec_rs_histogram_fill_ranges(priv, mode, &hist->ranges);
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
 
@@ -1501,6 +1579,7 @@ void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
 
 	fec_set_corrected_bits_total(priv, fec_stats);
 	fec_set_block_stats(priv, mode, fec_stats);
+	fec_set_histograms_stats(priv, mode, hist);
 }
 
 #define PPORT_ETH_EXT_OFF(c) \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 72dbcc1928ef..09f155acb461 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -117,7 +117,8 @@ void mlx5e_stats_update_ndo_stats(struct mlx5e_priv *priv);
 void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 			   struct ethtool_pause_stats *pause_stats);
 void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
-			 struct ethtool_fec_stats *fec_stats);
+			 struct ethtool_fec_stats *fec_stats,
+			 struct ethtool_fec_hist *hist);
 
 void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,
 			     struct ethtool_eth_phy_stats *phy_stats);
-- 
2.47.3


