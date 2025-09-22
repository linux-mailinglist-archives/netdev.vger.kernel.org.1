Return-Path: <netdev+bounces-225211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01C6B8FF51
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA62A162F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4D2FF175;
	Mon, 22 Sep 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FdPq+csg"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765672FE577
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536165; cv=none; b=HXm/p/CZeQ9exx+JPdyS0aAJRq/8o9TbH4xMdYr7Y0TD46Xm1LEfpDAnpu4bUdJHmdIWMerJHbzIP5jueTuVJaiO8frNGUczpZtE5ctmZ9zeOLVEnhKDuIz6i1vlLK1EbYw6aQfkogx053CYaGj1jCYX1pzhS2uHvanI5uBT7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536165; c=relaxed/simple;
	bh=qGI/wJzTU84dgNFPey7EYsefWqCVvZl7xxNQRJlXEcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1ywNwUpifeo2zSpCIhyZzqqafBLGGMzXdmIhME4KNyPtX3G6OVaBESc2iXCBFRvgxGcCxonc4W7XFrTnmWTTwbaBhIWpNL8FaFzuzJpWhzn5HJhf9/CfQ386z/BJ8PVkH0AaxLT61vhptFnagYQaepJqutPPUbOApWPrS0yaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FdPq+csg; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758536161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CKNQEwvTo9N0xolpoDmKgPImVgvl1TyABWINDjAqBY=;
	b=FdPq+csgSjr0zyC8Ffo4AxksdIqXNCgfdiof7QZiQLCPi1+4qwfVMRaGykhkGrWKf9hRp7
	6m7eQeiOHZ15e6f8pMYBJsVpFGGTfzIi7TpHQ8FKj/jHsRBM8MVff7KxNzn/l7zcMY8/ga
	AH+PCx93+JJQkP+obCkMvkY+oshaEDo=
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
Subject: [PATCH net-next v5 4/5] net/mlx5e: Report RS-FEC histogram statistics via ethtool
Date: Mon, 22 Sep 2025 10:07:40 +0000
Message-ID: <20250922100741.2167024-5-vadim.fedorenko@linux.dev>
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
index e6613672b8f5..ffc4f9b4f284 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1552,15 +1552,47 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
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


