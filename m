Return-Path: <netdev+bounces-100382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECF8FA491
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D2B1C23742
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB313C9C8;
	Mon,  3 Jun 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikBsIs2D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4713C8FE
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451490; cv=none; b=laL2WFN4v+873Z/p0NK+s1ugK8RvFt9hoUsq10lmQ+imoppDZdfn9a15Mzgsyc0U/foBs0zMif6P9M7LqI9H7CLNyaMY4bQ/QQCZPNVMTvxEA4yBIRC1nUpVjgwMemC+WtYAVLU2iLYYGVsoZrp6H3+yaa3aTBV3sDjeqMndRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451490; c=relaxed/simple;
	bh=e083ApOrLzzSmLBCsnElmk7fqOhr3DuilrAQKzI91II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWJ7sLO1KQZcj5dpCjFmg6tG+poeXsVP67siZXQF3wIjDeKBDc0OKtCKcmsNUyg9XvPLviL+qCEBZH1+MNe3qsWvOdsAeutCb/PSWKw+qdw1YwadvGWJXkdDTBPYq8Ifr8QRpzy+1JF/Vi/nT7ho8iMMdtBwOaJRg41tmeMJThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikBsIs2D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451489; x=1748987489;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e083ApOrLzzSmLBCsnElmk7fqOhr3DuilrAQKzI91II=;
  b=ikBsIs2DslUmrNAyfO+6RzBlTgh37CS8u05woBgNX6iyFubYr1X1cTOc
   73Ur+IS0nj37aqWlhhnsSD1arSNOuSBFJlJEEY8SHyGiykAbjYH69PXod
   aw3SBsxyBZcEluRL4JedRRkkK0THT+rUCqVUjlbLsOvz45wiZMt/S8qmu
   WHyxBqjoQcneteNlyZU0PwOmlotmXr95kZE+S8fnCtknyRzov/0E6yp1i
   GJ/slKdbm8JomX5grNOU7hzd+oZyNnY15aHS9zP5QDNwvPg93r3SP8uD1
   uPjQ0tXvTK8HaKnwOJc6/cxqmQ1LZwUYfLOO/YQXeQoP0STxjcWGYFp64
   Q==;
X-CSE-ConnectionGUID: MnpDHeawQb6TliguhW+W5Q==
X-CSE-MsgGUID: /+vzqGlZTv+sW5/cPh/ceg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547590"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547590"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
X-CSE-ConnectionGUID: FpviwrBZTMeskTqMxvSOLw==
X-CSE-MsgGUID: SBhfLbhfRHirds1SNg4pEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608244"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 14:42:32 -0700
Subject: [PATCH net v2 3/6] ice: remove af_xdp_zc_qps bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-3-e3563aa89b0c@intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>
X-Mailer: b4 0.13.0

From: Larysa Zaremba <larysa.zaremba@intel.com>

Referenced commit has introduced a bitmap to distinguish between ZC and
copy-mode AF_XDP queues, because xsk_get_pool_from_qid() does not do this
for us.

The bitmap would be especially useful when restoring previous state after
rebuild, if only it was not reallocated in the process. This leads to e.g.
xdpsock dying after changing number of queues.

Instead of preserving the bitmap during the rebuild, remove it completely
and distinguish between ZC and copy-mode queues based on the presence of
a device associated with the pool.

Fixes: e102db780e1c ("ice: track AF_XDP ZC enabled queues in bitmap")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Fix formatting of return description for ice_get_xp_from_qid
---
 drivers/net/ethernet/intel/ice/ice.h     | 32 +++++++++++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_lib.c |  8 --------
 drivers/net/ethernet/intel/ice/ice_xsk.c | 13 ++++++-------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6ad8002b22e1..5e51cb84b600 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -409,7 +409,6 @@ struct ice_vsi {
 	struct ice_tc_cfg tc_cfg;
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
-	unsigned long *af_xdp_zc_qps;	 /* tracks AF_XDP ZC enabled qps */
 	u16 num_xdp_txq;		 /* Used XDP queues */
 	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
 
@@ -746,6 +745,25 @@ static inline void ice_set_ring_xdp(struct ice_tx_ring *ring)
 	ring->flags |= ICE_TX_FLAGS_RING_XDP;
 }
 
+/**
+ * ice_get_xp_from_qid - get ZC XSK buffer pool bound to a queue ID
+ * @vsi: pointer to VSI
+ * @qid: index of a queue to look at XSK buff pool presence
+ *
+ * Return: A pointer to xsk_buff_pool structure if there is a buffer pool
+ * attached and configured as zero-copy, NULL otherwise.
+ */
+static inline struct xsk_buff_pool *ice_get_xp_from_qid(struct ice_vsi *vsi,
+							u16 qid)
+{
+	struct xsk_buff_pool *pool = xsk_get_pool_from_qid(vsi->netdev, qid);
+
+	if (!ice_is_xdp_ena_vsi(vsi))
+		return NULL;
+
+	return (pool && pool->dev) ? pool : NULL;
+}
+
 /**
  * ice_xsk_pool - get XSK buffer pool bound to a ring
  * @ring: Rx ring to use
@@ -758,10 +776,7 @@ static inline struct xsk_buff_pool *ice_xsk_pool(struct ice_rx_ring *ring)
 	struct ice_vsi *vsi = ring->vsi;
 	u16 qid = ring->q_index;
 
-	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps))
-		return NULL;
-
-	return xsk_get_pool_from_qid(vsi->netdev, qid);
+	return ice_get_xp_from_qid(vsi, qid);
 }
 
 /**
@@ -786,12 +801,7 @@ static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
 	if (!ring)
 		return;
 
-	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps)) {
-		ring->xsk_pool = NULL;
-		return;
-	}
-
-	ring->xsk_pool = xsk_get_pool_from_qid(vsi->netdev, qid);
+	ring->xsk_pool = ice_get_xp_from_qid(vsi, qid);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5371e91f6bbb..c0a7ff6c7e87 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -114,14 +114,8 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->q_vectors)
 		goto err_vectors;
 
-	vsi->af_xdp_zc_qps = bitmap_zalloc(max_t(int, vsi->alloc_txq, vsi->alloc_rxq), GFP_KERNEL);
-	if (!vsi->af_xdp_zc_qps)
-		goto err_zc_qps;
-
 	return 0;
 
-err_zc_qps:
-	devm_kfree(dev, vsi->q_vectors);
 err_vectors:
 	devm_kfree(dev, vsi->rxq_map);
 err_rxq_map:
@@ -309,8 +303,6 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
 
 	dev = ice_pf_to_dev(pf);
 
-	bitmap_free(vsi->af_xdp_zc_qps);
-	vsi->af_xdp_zc_qps = NULL;
 	/* free the ring and vector containers */
 	devm_kfree(dev, vsi->q_vectors);
 	vsi->q_vectors = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 7541f223bf4f..a65955eb23c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -269,7 +269,6 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
 	if (!pool)
 		return -EINVAL;
 
-	clear_bit(qid, vsi->af_xdp_zc_qps);
 	xsk_pool_dma_unmap(pool, ICE_RX_DMA_ATTR);
 
 	return 0;
@@ -300,8 +299,6 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 	if (err)
 		return err;
 
-	set_bit(qid, vsi->af_xdp_zc_qps);
-
 	return 0;
 }
 
@@ -349,11 +346,13 @@ ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring, bool pool_present)
 int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc)
 {
 	struct ice_rx_ring *rx_ring;
-	unsigned long q;
+	uint i;
+
+	ice_for_each_rxq(vsi, i) {
+		rx_ring = vsi->rx_rings[i];
+		if (!rx_ring->xsk_pool)
+			continue;
 
-	for_each_set_bit(q, vsi->af_xdp_zc_qps,
-			 max_t(int, vsi->alloc_txq, vsi->alloc_rxq)) {
-		rx_ring = vsi->rx_rings[q];
 		if (ice_realloc_rx_xdp_bufs(rx_ring, zc))
 			return -ENOMEM;
 	}

-- 
2.44.0.53.g0f9d4d28b7e6


