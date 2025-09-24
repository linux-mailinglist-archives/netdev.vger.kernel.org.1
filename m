Return-Path: <netdev+bounces-225960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6986B99E68
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192D4178A65
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01F30B515;
	Wed, 24 Sep 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CmX5dQIc"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4885308F2C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717659; cv=none; b=ZLaQ4EkRxdHiphk0r/FN3TsJfPBKdKPrAvxHtCTskUS6tOqB1ZCM2ICBiDXL6avpGlFdC3aWP5UL2ORDt9J2rmw+uMGRz6emJm7W8SgjsqtbnVqbDHF7iH7cZEma0CmYOV2yK30VLCHe1/wITxm7q0APAilAy4GFTuJs36+wQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717659; c=relaxed/simple;
	bh=x2ktrk9Blb5CaYmJSq0g28UDxtL/xjg186cO3NVxItE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEOEoq/wWeDwM8H9qGX0prY59kkFadytcgGBD35F6jySxhFNtwWxNljSXXwAfonHrdwOQl+AohifhS9UIhHG/nBVLk4prOOr2mYQfZbeUGNXCXhxHIVIyZmZiuKCky7wPeO6GsMjhwavPfk6KSCoDY4H77yVC8EPNW4pvJHRT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CmX5dQIc; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758717656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2maSu0fB4r86QUnkTxhnuzDvMq/FBK1y4AEhmA6GmM=;
	b=CmX5dQIcDmD5E/XS0iaFzRiA5FInw1J/6YFqcfxc5kjFJ5b10Y6UDBUHD6fpa2y1HjBlFq
	wh75TKb2VymdbswYx9MkXlIomiSvDSqYIP2goMslMosrq/KqY2Pc+hFkOMV21oaHr2od6z
	ZyS2Sk6TTQCVvhKhM2hX4Vl8APVfW9A=
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
Subject: [PATCH net-next v6 4/5] net/mlx5e: Report RS-FEC histogram statistics via ethtool
Date: Wed, 24 Sep 2025 12:40:36 +0000
Message-ID: <20250924124037.1508846-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20250924124037.1508846-1-vadim.fedorenko@linux.dev>
References: <20250924124037.1508846-1-vadim.fedorenko@linux.dev>
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
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index c0bf0d49d7d5..7a25666ab6d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1554,15 +1554,47 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
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
+	for (int i = 0; i < num_of_bins; i++)
+		hist->values[i].sum = MLX5_GET64(rs_histogram_cntrs,
+						 rs_histogram_cntrs,
+						 hist[i]);
+}
+
 static void fec_set_histograms_stats(struct mlx5e_priv *priv, int mode,
 				     struct ethtool_fec_hist *hist)
 {
+	u8 num_of_bins;
+
 	switch (mode) {
 	case MLX5E_FEC_RS_528_514:
 	case MLX5E_FEC_RS_544_514:
 	case MLX5E_FEC_LLRS_272_257_1:
 	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
-		fec_rs_histogram_fill_ranges(priv, mode, &hist->ranges);
+		num_of_bins =
+			fec_rs_histogram_fill_ranges(priv, mode, &hist->ranges);
+		if (num_of_bins)
+			return fec_rs_histogram_fill_stats(priv, num_of_bins,
+							   hist);
 		break;
 	default:
 		return;
-- 
2.47.3


