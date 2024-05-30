Return-Path: <netdev+bounces-99503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3108D5123
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CD21F23070
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FF481BD;
	Thu, 30 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6D7VRRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930446BA0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090807; cv=none; b=sHB9uxLuGasrbEO5rd8/3Qf1zVVbr0tYJ2vEr7MZNRFzjhj6a4vBoezqDSaUeeWRkk7vpSMA3OTmYB88LuT2E3/3QMeTFja36pXefZrdLVyITC7P4yaZlzNeIItp6B3SdaQxg6sXfjFqC0IIhd+B9xLw3xxEU6cpB5PNzZJp5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090807; c=relaxed/simple;
	bh=YunoSBmfF4xBYtM2W8VHvFhwJS4LXoiaUkq6/oNkDBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPBfAhgJ9w9sMekSvdYQ/5BPQy9vuveYnJAgM1CEjszFPfyaPanp9ajD+i1jbAOVKOT90ILWzMI8ZoDNynw1N4VBXwyMPe77jsMetfzSP1JVoFoD01yeBBYyXZD8fnKbgyZlZQdoRPe9vWaR74YFckout5yUOR7dMrWHFLn5Yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6D7VRRQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717090806; x=1748626806;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YunoSBmfF4xBYtM2W8VHvFhwJS4LXoiaUkq6/oNkDBY=;
  b=K6D7VRRQNYE+/5QiU5zmIaPgaNPrXspxp2NkMJP8Apw4+Bj6jDKBmdF6
   7aWQoj2RxupooBHSyOP4qfML0TkBoaa9Tm2RBUVLttaZHvMeNA4QrfCJ4
   c6plsCAeNkqyiKB3xQPKmNlIghMYmb9unEJxCLLhR0CPteOEqo1joCapk
   p+uY9y8LGBc+aEC5nvcosonZen+yk/QQOM7sUpPtgJVEa6cCmES0boVcd
   motmKYBanq3NIYw6DDpyd8GcivLuyWZanjpKUEj1pinb4rN1A4vqwHTpm
   DpyBXNVDTvFrQq8S6nAxFJ3aaSiepFTB9gHSfE4lCDGbmL8jsEraggxME
   w==;
X-CSE-ConnectionGUID: iHfL7H7/TNOOLLW5n/vBdg==
X-CSE-MsgGUID: S1QHyzB7TtiHP4HxCyB7xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31119260"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31119260"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
X-CSE-ConnectionGUID: B9QQ3gQST7KNvTl97fX31Q==
X-CSE-MsgGUID: Dvf23ER4Rq2zgdm6ZBiNNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66766677"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 May 2024 10:39:30 -0700
Subject: [PATCH net 3/6] ice: remove af_xdp_zc_qps bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-net-2024-05-30-intel-net-fixes-v1-3-8b11c8c9bff8@intel.com>
References: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
In-Reply-To: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
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
 drivers/net/ethernet/intel/ice/ice.h     | 32 +++++++++++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_lib.c |  8 --------
 drivers/net/ethernet/intel/ice/ice_xsk.c | 13 ++++++-------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6ad8002b22e1..d4d840729bda 100644
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
+ * Returns a pointer to xsk_buff_pool structure if there is a buffer pool
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


