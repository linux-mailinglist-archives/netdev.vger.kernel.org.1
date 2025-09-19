Return-Path: <netdev+bounces-224824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC57B8AD4A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C608E18954DC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58F322A26;
	Fri, 19 Sep 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbUHuNgc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64E31E0F2
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304463; cv=none; b=Mx7IHJXQSZorUomqNYF7VF29ooXyAzsB7lCqdas84MdCWkiscgMwUW3mg69gn5leKBSZV85xn+8RqRUioKd/lcL2va1u786YVrZgFHELuSPar1/b+PT5Hoq01tvPzzaiOO/2r1YDUjnFZrbs56JsyXBbrgysTPPe/ob1Ypn7iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304463; c=relaxed/simple;
	bh=ZucYRdXlTrsifnacVDX5SZ7hCG1guHkdgTBRrD6lzp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+PnYAoNjpARZaqxV5MX18M8942alWf4wRR6QS6d8Gv4Kli1FblwD/ird7xdoy1IWTWm7H87Cm9kuCuDb4qL0Jk58fKsA6CL35MGN5uba/wFDXZ2z/BXzAI8bwIPKjgRzbQ5r99nvctZkg6DSXos3gzkKNzndNmnZQvQ5T/TAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbUHuNgc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304462; x=1789840462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZucYRdXlTrsifnacVDX5SZ7hCG1guHkdgTBRrD6lzp8=;
  b=EbUHuNgc/WQWFOdh8sZdsIuhVQLztmKDcmA+2box64R04B34LqEUA50N
   qTqfTV1GW1DyGB4NHKaUNxjDnW7hLgpyhJTfZ7LZfLdqAOpDoWLY7r74H
   61nBC/82AuuogkkrlSe37YBQB7DAPAlgvhimasp7jBu7/1c/xkXWnQx/9
   g5PBQQf7kWzfCNTOXax5Jj8wSFieBpfGRAcCiQFLgJUmW6jCHeDKgC3aq
   Lm0qjvrrBdH/06syAatwmBwOk8B+xIJk7jTHojZkmFGH4xSfgPzN0HCx4
   j5x//rJ+2xcTSf05XQE+gVRZz4DPgFn5RwNWzu9kcRDZxOA8FH0fwGSlb
   A==;
X-CSE-ConnectionGUID: eGgCzDgHS7uvc8cKDF8hag==
X-CSE-MsgGUID: Riy9SSEzQqGgvEOrliBJpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097068"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:19 -0700
X-CSE-ConnectionGUID: k6X29KaMShC6xNd76iXQHQ==
X-CSE-MsgGUID: eOiPaicTSD++uszoYF7sHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709476"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 1/7] ice: move ice_qp_[ena|dis] for reuse
Date: Fri, 19 Sep 2025 10:54:04 -0700
Message-ID: <20250919175412.653707-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Move ice_qp_[ena|dis] and related helper functions to ice_base.c to
allow reuse of these function currently only used by ice_xsk.c.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 145 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_base.h |   2 +
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 153 +---------------------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |  22 ++++
 4 files changed, 173 insertions(+), 149 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index c5da8e9cc0a0..dc4beac04086 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -1206,3 +1206,148 @@ ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
 		txq_meta->tc = tc;
 	}
 }
+
+/**
+ * ice_qp_reset_stats - Resets all stats for rings of given index
+ * @vsi: VSI that contains rings of interest
+ * @q_idx: ring index in array
+ */
+static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_vsi_stats *vsi_stat;
+	struct ice_pf *pf;
+
+	pf = vsi->back;
+	if (!pf->vsi_stats)
+		return;
+
+	vsi_stat = pf->vsi_stats[vsi->idx];
+	if (!vsi_stat)
+		return;
+
+	memset(&vsi_stat->rx_ring_stats[q_idx]->rx_stats, 0,
+	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
+	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
+	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
+	if (vsi->xdp_rings)
+		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
+		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
+}
+
+/**
+ * ice_qp_clean_rings - Cleans all the rings of a given index
+ * @vsi: VSI that contains rings of interest
+ * @q_idx: ring index in array
+ */
+static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
+{
+	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
+	if (vsi->xdp_rings)
+		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
+	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
+}
+
+/**
+ * ice_qp_dis - Disables a queue pair
+ * @vsi: VSI of interest
+ * @q_idx: ring index in array
+ *
+ * Returns 0 on success, negative on failure.
+ */
+int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_txq_meta txq_meta = { };
+	struct ice_q_vector *q_vector;
+	struct ice_tx_ring *tx_ring;
+	struct ice_rx_ring *rx_ring;
+	int fail = 0;
+	int err;
+
+	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
+		return -EINVAL;
+
+	tx_ring = vsi->tx_rings[q_idx];
+	rx_ring = vsi->rx_rings[q_idx];
+	q_vector = rx_ring->q_vector;
+
+	synchronize_net();
+	netif_carrier_off(vsi->netdev);
+	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
+	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
+	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
+	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
+	if (!fail)
+		fail = err;
+	if (vsi->xdp_rings) {
+		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
+
+		memset(&txq_meta, 0, sizeof(txq_meta));
+		ice_fill_txq_meta(vsi, xdp_ring, &txq_meta);
+		err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, xdp_ring,
+					   &txq_meta);
+		if (!fail)
+			fail = err;
+	}
+
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
+	ice_qp_clean_rings(vsi, q_idx);
+	ice_qp_reset_stats(vsi, q_idx);
+
+	return fail;
+}
+
+/**
+ * ice_qp_ena - Enables a queue pair
+ * @vsi: VSI of interest
+ * @q_idx: ring index in array
+ *
+ * Returns 0 on success, negative on failure.
+ */
+int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_q_vector *q_vector;
+	int fail = 0;
+	bool link_up;
+	int err;
+
+	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
+	if (!fail)
+		fail = err;
+
+	if (ice_is_xdp_ena_vsi(vsi)) {
+		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
+
+		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
+		if (!fail)
+			fail = err;
+		ice_set_ring_xdp(xdp_ring);
+		ice_tx_xsk_pool(vsi, q_idx);
+	}
+
+	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
+	if (!fail)
+		fail = err;
+
+	q_vector = vsi->rx_rings[q_idx]->q_vector;
+	ice_qvec_cfg_msix(vsi, q_vector, q_idx);
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
+	if (!fail)
+		fail = err;
+
+	ice_qvec_toggle_napi(vsi, q_vector, true);
+	ice_qvec_ena_irq(vsi, q_vector);
+
+	/* make sure NAPI sees updated ice_{t,x}_ring::xsk_pool */
+	synchronize_net();
+	ice_get_link_status(vsi->port_info, &link_up);
+	if (link_up) {
+		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+		netif_carrier_on(vsi->netdev);
+	}
+
+	return fail;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index b711bc921928..632b5be61a98 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -32,4 +32,6 @@ ice_vsi_stop_tx_ring(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 void
 ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
 		  struct ice_txq_meta *txq_meta);
+int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx);
+int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx);
 #endif /* _ICE_BASE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a3a4eaa17739..575fd48f485f 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -18,53 +18,13 @@ static struct xdp_buff **ice_xdp_buf(struct ice_rx_ring *rx_ring, u32 idx)
 	return &rx_ring->xdp_buf[idx];
 }
 
-/**
- * ice_qp_reset_stats - Resets all stats for rings of given index
- * @vsi: VSI that contains rings of interest
- * @q_idx: ring index in array
- */
-static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
-{
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf;
-
-	pf = vsi->back;
-	if (!pf->vsi_stats)
-		return;
-
-	vsi_stat = pf->vsi_stats[vsi->idx];
-	if (!vsi_stat)
-		return;
-
-	memset(&vsi_stat->rx_ring_stats[q_idx]->rx_stats, 0,
-	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
-	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
-	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
-	if (vsi->xdp_rings)
-		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
-		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
-}
-
-/**
- * ice_qp_clean_rings - Cleans all the rings of a given index
- * @vsi: VSI that contains rings of interest
- * @q_idx: ring index in array
- */
-static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
-{
-	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (vsi->xdp_rings)
-		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
-	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
-}
-
 /**
  * ice_qvec_toggle_napi - Enables/disables NAPI for a given q_vector
  * @vsi: VSI that has netdev
  * @q_vector: q_vector that has NAPI context
  * @enable: true for enable, false for disable
  */
-static void
+void
 ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
 		     bool enable)
 {
@@ -83,7 +43,7 @@ ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
  * @rx_ring: Rx ring that will have its IRQ disabled
  * @q_vector: queue vector
  */
-static void
+void
 ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
 		 struct ice_q_vector *q_vector)
 {
@@ -113,7 +73,7 @@ ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
  * @q_vector: queue vector
  * @qid: queue index
  */
-static void
+void
 ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector, u16 qid)
 {
 	u16 reg_idx = q_vector->reg_idx;
@@ -143,7 +103,7 @@ ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector, u16 qid)
  * @vsi: the VSI that contains queue vector
  * @q_vector: queue vector
  */
-static void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
@@ -153,111 +113,6 @@ static void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 	ice_flush(hw);
 }
 
-/**
- * ice_qp_dis - Disables a queue pair
- * @vsi: VSI of interest
- * @q_idx: ring index in array
- *
- * Returns 0 on success, negative on failure.
- */
-static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
-{
-	struct ice_txq_meta txq_meta = { };
-	struct ice_q_vector *q_vector;
-	struct ice_tx_ring *tx_ring;
-	struct ice_rx_ring *rx_ring;
-	int fail = 0;
-	int err;
-
-	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
-		return -EINVAL;
-
-	tx_ring = vsi->tx_rings[q_idx];
-	rx_ring = vsi->rx_rings[q_idx];
-	q_vector = rx_ring->q_vector;
-
-	synchronize_net();
-	netif_carrier_off(vsi->netdev);
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-
-	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
-	ice_qvec_toggle_napi(vsi, q_vector, false);
-
-	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
-	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
-	if (!fail)
-		fail = err;
-	if (vsi->xdp_rings) {
-		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
-
-		memset(&txq_meta, 0, sizeof(txq_meta));
-		ice_fill_txq_meta(vsi, xdp_ring, &txq_meta);
-		err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, xdp_ring,
-					   &txq_meta);
-		if (!fail)
-			fail = err;
-	}
-
-	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
-	ice_qp_clean_rings(vsi, q_idx);
-	ice_qp_reset_stats(vsi, q_idx);
-
-	return fail;
-}
-
-/**
- * ice_qp_ena - Enables a queue pair
- * @vsi: VSI of interest
- * @q_idx: ring index in array
- *
- * Returns 0 on success, negative on failure.
- */
-static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
-{
-	struct ice_q_vector *q_vector;
-	int fail = 0;
-	bool link_up;
-	int err;
-
-	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
-	if (!fail)
-		fail = err;
-
-	if (ice_is_xdp_ena_vsi(vsi)) {
-		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
-
-		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
-		if (!fail)
-			fail = err;
-		ice_set_ring_xdp(xdp_ring);
-		ice_tx_xsk_pool(vsi, q_idx);
-	}
-
-	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
-	if (!fail)
-		fail = err;
-
-	q_vector = vsi->rx_rings[q_idx]->q_vector;
-	ice_qvec_cfg_msix(vsi, q_vector, q_idx);
-
-	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
-	if (!fail)
-		fail = err;
-
-	ice_qvec_toggle_napi(vsi, q_vector, true);
-	ice_qvec_ena_irq(vsi, q_vector);
-
-	/* make sure NAPI sees updated ice_{t,x}_ring::xsk_pool */
-	synchronize_net();
-	ice_get_link_status(vsi->port_info, &link_up);
-	if (link_up) {
-		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-		netif_carrier_on(vsi->netdev);
-	}
-
-	return fail;
-}
-
 /**
  * ice_xsk_pool_disable - disable a buffer pool region
  * @vsi: Current VSI
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index 8dc5d55e26c5..600cbeeaa203 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -23,6 +23,13 @@ void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring);
 void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring);
 bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool);
 int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc);
+void ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
+		       u16 qid);
+void ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
+			  bool enable);
+void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector);
+void ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
+		      struct ice_q_vector *q_vector);
 #else
 static inline bool ice_xmit_zc(struct ice_tx_ring __always_unused *xdp_ring,
 			       struct xsk_buff_pool __always_unused *xsk_pool)
@@ -75,5 +82,20 @@ ice_realloc_zc_buf(struct ice_vsi __always_unused *vsi,
 {
 	return 0;
 }
+
+static inline void
+ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
+		  u16 qid) { }
+
+static inline void
+ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
+		     bool enable) { }
+
+static inline void
+ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector) { }
+
+static inline void
+ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
+		 struct ice_q_vector *q_vector) { }
 #endif /* CONFIG_XDP_SOCKETS */
 #endif /* !_ICE_XSK_H_ */
-- 
2.47.1


