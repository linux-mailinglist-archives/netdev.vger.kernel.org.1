Return-Path: <netdev+bounces-221377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1AB50593
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2568560274
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF93019AA;
	Tue,  9 Sep 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NcF0y0qz"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F83009D2
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443810; cv=none; b=A1Xc5+YYVWG8y2eZRohVp4WldR4NJX6KmaQbhn4WJJw7i0ziw1gehK0Rq4FeZXlmNSx0lz4U/gwaB8V5DF/wHbXS0L0kJUr2l9xMqfnQ2jPIwDlwQdRKhLCTiPojaRZu6KNbIchsDnGB2MSi3DwtpCBEASJREi1yLwES60JnYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443810; c=relaxed/simple;
	bh=A+h1YDOqRpV4KWri32dN3hlHAdfU+RZvsfazMFTUXFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTQrfjhR66hwmddAPdxdnbz1CFg7sJgNTAImxDKURVm1CCRykiW0g6u+syzKHLhLh3NISWNt//8pC9ylLkCzwCH4HyYBj9cuE1Eya+o/HBs6pNdt6V+D0ewfGPsJeg4oB9umML5WZ5Md4CtmmCDlyxk8cU3d4z1d+4DpQjyjQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NcF0y0qz; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757443804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hdCwsUdqxbkvyqqDVE6MYjEaZTRoA0QzrkQgbyUfTQ=;
	b=NcF0y0qz3t/eqDtZztAMBfOs66T64i65Aj7keSjNFArKz6JCHN+C/ZUVpXL7okGLBbTVrS
	UxU50xBuRQTuH5geo9qei2RFSfcpoyU+gz1d7LjZVgUTN+qdjx52/1cU+2BBcbIzY7a9en
	SVCQcQ8SQFYz84j+ublnAgI3bvvJw6E=
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
Subject: [PATCH net-next 4/4] net/mlx5e: Report RS-FEC histogram statistics via ethtool
Date: Tue,  9 Sep 2025 18:42:16 +0000
Message-ID: <20250909184216.1524669-5-vadim.fedorenko@linux.dev>
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

Add support for reporting RS-FEC histogram counters by reading them
from the RS_FEC_HISTOGRAM_GROUP in the PPCNT register.

Co-developed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index f64cae6dd367..e9f2bf342f95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1519,24 +1519,55 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv,
 		void *bin_range = MLX5_ADDR_OF(pphcr_reg, out, bin_range[i]);
 
 		priv->fec_ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
-						    high_val);
+						    high_val);
 		priv->fec_ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
-						   low_val);
+						   low_val);
 	}
 	*ranges = priv->fec_ranges;
 
 	return num_of_bins;
 }
 
+static void fec_rs_histogram_fill_stats(struct mlx5e_priv *priv,
+					u8 num_of_bins,
+					struct ethtool_fec_hist *hist)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	u32 out[MLX5_ST_SZ_DW(ppcnt_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {0};
+	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
+	void *rs_histogram_cntrs;
+
+	MLX5_SET(ppcnt_reg, in, local_port, 1);
+	MLX5_SET(ppcnt_reg, in, grp, MLX5_RS_FEC_HISTOGRAM_GROUP);
+	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0, 0))
+		return;
+
+	rs_histogram_cntrs = MLX5_ADDR_OF(ppcnt_reg, out,
+					  counter_set.rs_histogram_cntrs);
+	/* Guaranteed that num_of_bins is less than MLX5E_FEC_RS_HIST_MAX
+	 * by fec_rs_histogram_fill_ranges().
+	 */
+	for (int i = 0; i < num_of_bins; i++) {
+		hist->values[i].bin_value = MLX5_GET64(rs_histogram_cntrs,
+						       rs_histogram_cntrs,
+						       hist[i]);
+	}
+}
+
 static void fec_set_histograms_stats(struct mlx5e_priv *priv, int mode,
-				     struct ethtool_fec_hist *hist)
+				     struct ethtool_fec_hist *hist)
 {
+	u8 num_of_bins;
+
 	switch (mode) {
 	case MLX5E_FEC_RS_528_514:
 	case MLX5E_FEC_RS_544_514:
 	case MLX5E_FEC_LLRS_272_257_1:
 	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
-		fec_rs_histogram_fill_ranges(priv, &hist->ranges);
+		num_of_bins = fec_rs_histogram_fill_ranges(priv, &hist->ranges);
+		if (num_of_bins)
+			fec_rs_histogram_fill_stats(priv, num_of_bins, hist);
 		break;
 	default:
 		return;
-- 
2.47.3


