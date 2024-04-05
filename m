Return-Path: <netdev+bounces-85342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4189A53F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF19C283F03
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91C174EC2;
	Fri,  5 Apr 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nD+SwHK4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA3171E77
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346698; cv=none; b=AR83bbIB587yxJtbMrRSUOSU+wpmL61K4ayufvj58FczzQWe6yUGDJIFLZGorCYLOV8zhspg1wRm2xOEo3FFDmutzdPvmTv78ML0nOd68zriHmwoKOc4ab4nfaYOBYrLzVznytiqnR9+El8Atgu71zAQRByp1dGmkWnykk8uVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346698; c=relaxed/simple;
	bh=cPvR+LOCg7nkDtMxz6zo1hLHWYmlUtjZhNMjWo27GU0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzNPMLTtd35xm0kROjZqVrohZuTWFuOrEyxBcSGv5JHjc1fVGU3N4cOepjdul9sY6CR0S/YQe+293yYo7oUWTwBYXHUJdL3diaB+v49awIlKPD5k0eNYdnuUvrFFaljTZoVchJRnjpqbye4lNKM4vaz2ybISbczU/0j1Nj+t/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nD+SwHK4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346697; x=1743882697;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPvR+LOCg7nkDtMxz6zo1hLHWYmlUtjZhNMjWo27GU0=;
  b=nD+SwHK4UUQtCArOc32uOWI2CN0v/qjM/pubi8KT1uV3vy75WkNAk9nT
   PLb1w3Ez22mVAg5G4N+VFk4Jud6Vl16Gv49BOGoqxaX/1Zb8n9NxC/Elh
   9aGfQ25z5hN4UNAFjqegJWsViBhUF4WuY/FnI6uW/JMb1FmVtAWcbRDjV
   oWGWVX1zpHLQ+OsE4BcrR8JZVwgm/UUArO6MDYncANmc1xPMF/96nxOQz
   23WzMji3rSaXXUpFHd3prh66vqoPND01HNVAREyW7VB05ulqlS4evKKSO
   0G7TdEsPeWwHlQkxeH+wNK14QpWqfCqUIBbPApPufE7/zvZLx1TXPr7fY
   Q==;
X-CSE-ConnectionGUID: +uMCPDFHS4S4YsgL8PuffQ==
X-CSE-MsgGUID: bbvZj0/ISouRAyf2ALaOmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7817654"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7817654"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:51:37 -0700
X-CSE-ConnectionGUID: rkwzNaR1SKaXWVVWtTWKwQ==
X-CSE-MsgGUID: MBcH5K2zRCK092ZZ0jAY0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19700669"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa006.jf.intel.com with ESMTP; 05 Apr 2024 12:51:37 -0700
Subject: [net-next,
 RFC PATCH 3/5] ice: Add support to enable/disable a vector
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 05 Apr 2024 13:09:44 -0700
Message-ID: <171234778396.5075.3968986750172203483.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

While configuring a queue from the userspace, the queue will have to
be reset for the configuration to take effect in hardware. Resetting
a queue has the dependency of resetting the vector it is on.
Add the framework functions to enable/disable a single queue and hence
the vector also. The existing support in the driver allows either
enabling/disabling a single queue-pair or an entire VSI but not any random
Tx or Rx queue.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |    1 
 drivers/net/ethernet/intel/ice/ice_lib.c  |  247 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 
 drivers/net/ethernet/intel/ice/ice_main.c |    2 
 drivers/net/ethernet/intel/ice/ice_xsk.c  |   34 ----
 5 files changed, 253 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a7e88d797d4c..a2c91fa88e14 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1009,4 +1009,5 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 }
 
 extern const struct xdp_metadata_ops ice_xdp_md_ops;
+void ice_init_moderation(struct ice_q_vector *q_vector);
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d06e7c82c433..35389189af1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4001,3 +4001,250 @@ ice_vsi_update_local_lb(struct ice_vsi *vsi, bool set)
 	vsi->info = ctx.info;
 	return 0;
 }
+
+/**
+ * ice_tx_queue_dis - Disable a Tx ring
+ * @vsi: VSI being configured
+ * @q_idx: Tx ring index
+ *
+ */
+static int ice_tx_queue_dis(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_txq_meta txq_meta = { };
+	struct ice_tx_ring *tx_ring;
+	int err;
+
+	if (q_idx >= vsi->num_txq)
+		return -EINVAL;
+
+	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
+	tx_ring = vsi->tx_rings[q_idx];
+	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
+	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
+	if (err)
+		return err;
+
+	ice_clean_tx_ring(tx_ring);
+
+	return 0;
+}
+
+/**
+ * ice_tx_queue_ena - Enable a Tx ring
+ * @vsi: VSI being configured
+ * @q_idx: Tx ring index
+ *
+ */
+static int ice_tx_queue_ena(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_q_vector *q_vector;
+	struct ice_tx_ring *tx_ring;
+	int err;
+
+	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
+	if (err)
+		return err;
+
+	tx_ring = vsi->tx_rings[q_idx];
+	q_vector = tx_ring->q_vector;
+	ice_cfg_txq_interrupt(vsi, tx_ring->reg_idx, q_vector->reg_idx,
+			      q_vector->tx.itr_idx);
+
+	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
+	return 0;
+}
+
+/**
+ * ice_rx_ring_dis_irq - clear the queue to interrupt mapping in HW
+ * @vsi: VSI being configured
+ * @rx_ring: Rx ring that will have its IRQ disabled
+ *
+ */
+static void ice_rx_ring_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u16 reg;
+	u32 val;
+
+	/* Clear QINT_RQCTL to clear the queue to interrupt mapping in HW */
+	reg = rx_ring->reg_idx;
+	val = rd32(hw, QINT_RQCTL(reg));
+	val &= ~QINT_RQCTL_CAUSE_ENA_M;
+	wr32(hw, QINT_RQCTL(reg), val);
+
+	ice_flush(hw);
+}
+
+/**
+ * ice_rx_queue_dis - Disable a Rx ring
+ * @vsi: VSI being configured
+ * @q_idx: Rx ring index
+ *
+ */
+static int ice_rx_queue_dis(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_rx_ring *rx_ring;
+	int err;
+
+	if (q_idx >= vsi->num_rxq)
+		return -EINVAL;
+
+	rx_ring = vsi->rx_rings[q_idx];
+	ice_rx_ring_dis_irq(vsi, rx_ring);
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
+	if (err)
+		return err;
+
+	ice_clean_rx_ring(rx_ring);
+
+	return 0;
+}
+
+/**
+ * ice_rx_queue_ena - Enable a Rx ring
+ * @vsi: VSI being configured
+ * @q_idx: Tx ring index
+ *
+ */
+static int ice_rx_queue_ena(struct ice_vsi *vsi, u16 q_idx)
+{
+	struct ice_q_vector *q_vector;
+	struct ice_rx_ring *rx_ring;
+	int err;
+
+	if (q_idx >= vsi->num_rxq)
+		return -EINVAL;
+
+	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
+	if (err)
+		return err;
+
+	rx_ring = vsi->rx_rings[q_idx];
+	q_vector = rx_ring->q_vector;
+	ice_cfg_rxq_interrupt(vsi, rx_ring->reg_idx, q_vector->reg_idx,
+			      q_vector->rx.itr_idx);
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * ice_qvec_toggle_napi - Enables/disables NAPI for a given q_vector
+ * @vsi: VSI that has netdev
+ * @q_vector: q_vector that has NAPI context
+ * @enable: true for enable, false for disable
+ */
+void
+ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
+		     bool enable)
+{
+	if (!vsi->netdev || !q_vector)
+		return;
+
+	if (enable)
+		napi_enable(&q_vector->napi);
+	else
+		napi_disable(&q_vector->napi);
+}
+
+/**
+ * ice_qvec_ena_irq - Enable IRQ for given queue vector
+ * @vsi: the VSI that contains queue vector
+ * @q_vector: queue vector
+ */
+void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+
+	ice_irq_dynamic_ena(hw, vsi, q_vector);
+
+	ice_flush(hw);
+}
+
+/**
+ * ice_qvec_configure - Setup initial interrupt configuration
+ * @vsi: the VSI that contains queue vector
+ * @q_vector: queue vector
+ */
+static void ice_qvec_configure(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+
+	ice_cfg_itr(hw, q_vector);
+	ice_init_moderation(q_vector);
+}
+
+/**
+ * ice_q_vector_dis - Disable a vector and all queues on it
+ * @vsi: the VSI that contains queue vector
+ * @q_vector: queue vector
+ */
+static int __maybe_unused
+ice_q_vector_dis(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	struct ice_rx_ring *rx_ring;
+	struct ice_tx_ring *tx_ring;
+	int err;
+
+	/* Disable the vector */
+	wr32(hw, GLINT_DYN_CTL(q_vector->reg_idx), 0);
+	ice_flush(hw);
+	synchronize_irq(q_vector->irq.virq);
+
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
+	/* Disable all rings on this vector */
+	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		err = ice_rx_queue_dis(vsi, rx_ring->q_index);
+		if (err)
+			return err;
+	}
+
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		err = ice_tx_queue_dis(vsi, tx_ring->q_index);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * ice_q_vector_ena - Enable a vector and all queues on it
+ * @vsi: the VSI that contains queue vector
+ * @q_vector: queue vector
+ */
+static int __maybe_unused
+ice_q_vector_ena(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	struct ice_rx_ring *rx_ring;
+	struct ice_tx_ring *tx_ring;
+	int err;
+
+	ice_qvec_configure(vsi, q_vector);
+
+	/* enable all rings on this vector */
+	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		err = ice_rx_queue_ena(vsi, rx_ring->q_index);
+		if (err)
+			return err;
+	}
+
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		err = ice_tx_queue_ena(vsi, tx_ring->q_index);
+		if (err)
+			return err;
+	}
+
+	ice_qvec_toggle_napi(vsi, q_vector, true);
+	ice_qvec_ena_irq(vsi, q_vector);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 9cd23afe5f15..00239c2efa92 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -160,4 +160,8 @@ void ice_set_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
+void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector);
+void
+ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
+		     bool enable);
 #endif /* !_ICE_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9d751954782c..cd2f467fe3a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6508,7 +6508,7 @@ static void ice_rx_dim_work(struct work_struct *work)
  * dynamic moderation mode or not in order to make sure hardware is in a known
  * state.
  */
-static void ice_init_moderation(struct ice_q_vector *q_vector)
+void ice_init_moderation(struct ice_q_vector *q_vector)
 {
 	struct ice_ring_container *rc;
 	bool tx_dynamic, rx_dynamic;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index aa81d1162b81..f7708bbb769b 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -59,25 +59,6 @@ static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
 
-/**
- * ice_qvec_toggle_napi - Enables/disables NAPI for a given q_vector
- * @vsi: VSI that has netdev
- * @q_vector: q_vector that has NAPI context
- * @enable: true for enable, false for disable
- */
-static void
-ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
-		     bool enable)
-{
-	if (!vsi->netdev || !q_vector)
-		return;
-
-	if (enable)
-		napi_enable(&q_vector->napi);
-	else
-		napi_disable(&q_vector->napi);
-}
-
 /**
  * ice_qvec_dis_irq - Mask off queue interrupt generation on given ring
  * @vsi: the VSI that contains queue vector being un-configured
@@ -135,21 +116,6 @@ ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 	ice_flush(hw);
 }
 
-/**
- * ice_qvec_ena_irq - Enable IRQ for given queue vector
- * @vsi: the VSI that contains queue vector
- * @q_vector: queue vector
- */
-static void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
-{
-	struct ice_pf *pf = vsi->back;
-	struct ice_hw *hw = &pf->hw;
-
-	ice_irq_dynamic_ena(hw, vsi, q_vector);
-
-	ice_flush(hw);
-}
-
 /**
  * ice_qp_dis - Disables a queue pair
  * @vsi: VSI of interest


