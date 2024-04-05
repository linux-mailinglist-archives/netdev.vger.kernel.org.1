Return-Path: <netdev+bounces-85343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3989A540
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0CB28401C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF6174ED4;
	Fri,  5 Apr 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+FyqyWl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F96174ED2
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346703; cv=none; b=m58s2igc4zVksqFCUmBCG+a+zOCPa3PL06sy96Jlr0uJiDWzcOf7ciHPFFAklIWvlI+276NLcmrZrVpbi8hong2VIVyrGEFlH+uruUdepIuYgeE5eqosdgIqJyCP1nMN9m1LyKWxVq7aQa2clOzVYNWsI0PiLUKmOUD0V8eB3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346703; c=relaxed/simple;
	bh=TkmkeGAQLEB9Q6qrcaPILvk+NfnfHgKnY+XpVptAV1I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGWhueu1Dp70bG6BK7ps4RE0jnrM7+r9MfARlhE+9qI6pekSr+PY/j5onZrTpb1wS5kgbIsLT2LTXSwzUIBgcE6qpQ/fjU7cx0qmThcf0MXlkZMlDy/h651zh0H6LzqG5kmYTZkajdmFt49sRAELIXxWQ2CWMfzBIY/bnWPKDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+FyqyWl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346702; x=1743882702;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TkmkeGAQLEB9Q6qrcaPILvk+NfnfHgKnY+XpVptAV1I=;
  b=g+FyqyWlmeticYBAETUQJWdhV0B4xYU2R5RcG84FRhdKzJXd8DuwXicI
   TuPeQmPsZ6j3fGwF4ooRzS2fKTSd0+WwB9N/Ttda0Ef8HPbDQtm7M6Bsb
   20/J9KrWThVsWHLXFVs8zDalJX3tOCqftnrloKuk814flC6hZ6R4xCLj+
   +HXfMtwusEPnP+xMGFAaqlsO2n6pp3+70YXrkygN8XFtNGdQQ2k00CtKG
   ob3gy0Oi6qdFNcfbAPpMXKrMmxtYrUausjxSb3VqnOu4PXZGMlC6ZGVsz
   0H2rUSgBaoLL2JZK7bmjdyRa8JI6eB0kFa3V8C4xh7DW3r25+YO8I82Pu
   A==;
X-CSE-ConnectionGUID: msu2mHDxTGSHXNze352Jiw==
X-CSE-MsgGUID: 3hZ5t3VcTACK9Gw98Lf7Mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7817666"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7817666"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:51:42 -0700
X-CSE-ConnectionGUID: MKShCV0sQ3qIMXRmFRIPOg==
X-CSE-MsgGUID: ygCa8Q4FRdaa/q9IKzANcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19700694"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa006.jf.intel.com with ESMTP; 05 Apr 2024 12:51:42 -0700
Subject: [net-next,RFC PATCH 4/5] ice: Handle unused vectors dynamically
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 05 Apr 2024 13:09:49 -0700
Message-ID: <171234778911.5075.12956603794662346879.stgit@anambiarhost.jf.intel.com>
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

When queues are moved between vectors, some vector[s] may get
unused. The unused vector[s] need to be freed. When queue[s]
gets assigned to previously unused and freed vector, this vector
will need to be requested and setup. Add the framework functions
for this.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |   12 +++
 drivers/net/ethernet/intel/ice/ice_lib.c  |  117 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    6 +
 drivers/net/ethernet/intel/ice/ice_main.c |   12 ---
 4 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a2c91fa88e14..d7b67821dc21 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1010,4 +1010,16 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 
 extern const struct xdp_metadata_ops ice_xdp_md_ops;
 void ice_init_moderation(struct ice_q_vector *q_vector);
+void
+ice_irq_affinity_notify(struct irq_affinity_notify *notify,
+			const cpumask_t *mask);
+/**
+ * ice_irq_affinity_release - Callback for affinity notifier release
+ * @ref: internal core kernel usage
+ *
+ * This is a callback function used by the irq_set_affinity_notifier function
+ * to inform the current notification subscriber that they will no longer
+ * receive notifications.
+ */
+static inline void ice_irq_affinity_release(struct kref __always_unused *ref) {}
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 35389189af1b..419d9561bc2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4248,3 +4248,120 @@ ice_q_vector_ena(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 
 	return 0;
 }
+
+static void
+ice_qvec_release_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	struct ice_rx_ring *rx_ring;
+	struct ice_tx_ring *tx_ring;
+
+	ice_write_intrl(q_vector, 0);
+
+	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		ice_write_itr(&q_vector->rx, 0);
+		wr32(hw, QINT_RQCTL(vsi->rxq_map[rx_ring->q_index]), 0);
+	}
+
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		ice_write_itr(&q_vector->tx, 0);
+		wr32(hw, QINT_TQCTL(vsi->txq_map[tx_ring->q_index]), 0);
+	}
+
+	/* Disable the interrupt by writing to the register */
+	wr32(hw, GLINT_DYN_CTL(q_vector->reg_idx), 0);
+	ice_flush(hw);
+}
+
+/**
+ * ice_qvec_free - Free the MSI_X vector
+ * @vsi: the VSI that contains queue vector
+ * @q_vector: queue vector
+ */
+static void __maybe_unused
+ice_qvec_free(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	int irq_num = q_vector->irq.virq;
+	struct ice_pf *pf = vsi->back;
+
+	ice_qvec_release_msix(vsi, q_vector);
+
+#ifdef CONFIG_RFS_ACCEL
+	struct net_device *netdev = vsi->netdev;
+
+	if (netdev && netdev->rx_cpu_rmap)
+		irq_cpu_rmap_remove(netdev->rx_cpu_rmap, irq_num);
+#endif
+
+	/* clear the affinity notifier in the IRQ descriptor */
+	if (!IS_ENABLED(CONFIG_RFS_ACCEL))
+		irq_set_affinity_notifier(irq_num, NULL);
+
+	/* clear the affinity_mask in the IRQ descriptor */
+	irq_set_affinity_hint(irq_num, NULL);
+
+	synchronize_irq(irq_num);
+	devm_free_irq(ice_pf_to_dev(pf), irq_num, q_vector);
+}
+
+/**
+ * ice_qvec_prep - Request and prepare a new MSI_X vector
+ * @vsi: the VSI that contains queue vector
+ * @q_vector: queue vector
+ */
+static int __maybe_unused
+ice_qvec_prep(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	struct ice_pf *pf = vsi->back;
+	struct device *dev;
+	int err, irq_num;
+
+	dev = ice_pf_to_dev(pf);
+	irq_num = q_vector->irq.virq;
+
+	err = devm_request_irq(dev, irq_num, vsi->irq_handler, 0,
+			       q_vector->name, q_vector);
+	if (err) {
+		netdev_err(vsi->netdev, "MSIX request_irq failed, error: %d\n",
+			   err);
+		goto free_q_irqs;
+	}
+
+	/* register for affinity change notifications */
+	if (!IS_ENABLED(CONFIG_RFS_ACCEL)) {
+		struct irq_affinity_notify *affinity_notify;
+
+		affinity_notify = &q_vector->affinity_notify;
+		affinity_notify->notify = ice_irq_affinity_notify;
+		affinity_notify->release = ice_irq_affinity_release;
+		irq_set_affinity_notifier(irq_num, affinity_notify);
+	}
+
+	/* assign the mask for this irq */
+	irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
+
+#ifdef CONFIG_RFS_ACCEL
+	struct net_device *netdev = vsi->netdev;
+
+	if (!netdev) {
+		err = -EINVAL;
+		goto free_q_irqs;
+	}
+
+	if (irq_cpu_rmap_add(netdev->rx_cpu_rmap, irq_num)) {
+		err = -EINVAL;
+		netdev_err(vsi->netdev, "Failed to setup CPU RMAP on irq %u: %pe\n",
+			   irq_num, ERR_PTR(err));
+		goto free_q_irqs;
+	}
+#endif
+	return 0;
+
+free_q_irqs:
+	if (!IS_ENABLED(CONFIG_RFS_ACCEL))
+		irq_set_affinity_notifier(irq_num, NULL);
+	irq_set_affinity_hint(irq_num, NULL);
+	devm_free_irq(dev, irq_num, &q_vector);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 00239c2efa92..66a9709ff612 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -164,4 +164,10 @@ void ice_qvec_ena_irq(struct ice_vsi *vsi, struct ice_q_vector *q_vector);
 void
 ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
 		     bool enable);
+static inline bool
+ice_is_q_vector_unused(struct ice_q_vector *q_vector)
+{
+	return (!q_vector->num_ring_tx && !q_vector->num_ring_rx);
+}
+
 #endif /* !_ICE_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cd2f467fe3a0..0884b53a0b01 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2476,7 +2476,7 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset)
  * This is a callback function used by the irq_set_affinity_notifier function
  * so that we may register to receive changes to the irq affinity masks.
  */
-static void
+void
 ice_irq_affinity_notify(struct irq_affinity_notify *notify,
 			const cpumask_t *mask)
 {
@@ -2486,16 +2486,6 @@ ice_irq_affinity_notify(struct irq_affinity_notify *notify,
 	cpumask_copy(&q_vector->affinity_mask, mask);
 }
 
-/**
- * ice_irq_affinity_release - Callback for affinity notifier release
- * @ref: internal core kernel usage
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * to inform the current notification subscriber that they will no longer
- * receive notifications.
- */
-static void ice_irq_affinity_release(struct kref __always_unused *ref) {}
-
 /**
  * ice_vsi_ena_irq - Enable IRQ for the given VSI
  * @vsi: the VSI being configured


