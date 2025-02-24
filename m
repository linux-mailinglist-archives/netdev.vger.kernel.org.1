Return-Path: <netdev+bounces-169239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B5A430C4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CA217D066
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D520E001;
	Mon, 24 Feb 2025 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJ9OiVsv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3020D518
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439386; cv=none; b=sg/xOeK4tZGuN3il3Edul74xlcK2aSGpUKjb8O45KYSA96kozR+hETxSh4lDjaVp+x2FhzcZ8CX1Beyrz7JEiLRKmCGF3Xg/xZ+TFZuL6sBTnTHi/igV2S55o/riHqyuW75j5czOOBtBb9EWLR3/aXBh50/mGjoBmqwqbrGoioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439386; c=relaxed/simple;
	bh=DbgLIWuVriNHpUm0jxe3kkqJsf8jxK8c9wRDW18kmiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTlmkBYKs2h0DMzrcM1oPqx3egojDQ9VYFIGHyH6uERy/EgaRNe1JjRzUMb43gXlfSY+QkZYBmnVn4A10AECiKSuhvAQ/LIKAyDEQFefIn2ieuHJ9mDpsmQ/4CnIz/GmiFE92iTncHNn5uwc2k0M2JXd1BpyHc75aZjyCTEurmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJ9OiVsv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740439384; x=1771975384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DbgLIWuVriNHpUm0jxe3kkqJsf8jxK8c9wRDW18kmiQ=;
  b=dJ9OiVsvaIvyx1MXnlLE8JFGXbgaE7oIwybClLeW9qhEwSPdJBGvV9xM
   p6ZdT13fJW3T61ZLQe4cPZtgt4ySRL6vYMy45k965mBd74zJssqm8iBiM
   T6wniBECpN23obrCntd02PfhJyma+fm6cktbImRmqnr7smCNbY9/lhphv
   a9reJkf3cOaKTkDGp1dv71fOozugKVSxYkSJ+VsnyphHXd26WTY7ZTGOT
   sntUZZarM7PxVmJFtFH6BEUQ23dyvmVsZth6vj8krve3ll0Rb6EsUo5U+
   zirGI1guzVdSz2G3WahniBfStauqSmSsmqAJ+fqbyzPbp6f5+mFzOdEkx
   A==;
X-CSE-ConnectionGUID: dqDk32SFTf6e9xLxbR7HkA==
X-CSE-MsgGUID: Lu5uSHmyQSC3pQtPav6zJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40406684"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40406684"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:23:04 -0800
X-CSE-ConnectionGUID: +AK919EmROee1Mu0p2Mz7Q==
X-CSE-MsgGUID: mWwXrESDRne56DeaD1efuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115997835"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.244.43])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:58 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v9 4/6] ice: use napi's irq affinity and rmap IRQ notifiers
Date: Mon, 24 Feb 2025 16:22:25 -0700
Message-ID: <20250224232228.990783-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224232228.990783-1-ahmed.zaki@intel.com>
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the driver CPU affinity and aRFS rmap info, use the core's
API instead.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  3 --
 drivers/net/ethernet/intel/ice/ice_arfs.c | 33 +---------------
 drivers/net/ethernet/intel/ice/ice_arfs.h |  2 -
 drivers/net/ethernet/intel/ice/ice_base.c |  7 +---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  7 ----
 drivers/net/ethernet/intel/ice/ice_main.c | 47 ++---------------------
 6 files changed, 6 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index c9104b13e1d2..5ceeae664598 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -475,9 +475,6 @@ struct ice_q_vector {
 	struct ice_ring_container rx;
 	struct ice_ring_container tx;
 
-	cpumask_t affinity_mask;
-	struct irq_affinity_notify affinity_notify;
-
 	struct ice_channel *ch;
 
 	char name[ICE_INT_NAME_STR_LEN];
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 7cee365cc7d1..171cdec741c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -570,25 +570,6 @@ void ice_clear_arfs(struct ice_vsi *vsi)
 	vsi->arfs_fltr_cntrs = NULL;
 }
 
-/**
- * ice_free_cpu_rx_rmap - free setup CPU reverse map
- * @vsi: the VSI to be forwarded to
- */
-void ice_free_cpu_rx_rmap(struct ice_vsi *vsi)
-{
-	struct net_device *netdev;
-
-	if (!vsi || vsi->type != ICE_VSI_PF)
-		return;
-
-	netdev = vsi->netdev;
-	if (!netdev || !netdev->rx_cpu_rmap)
-		return;
-
-	free_irq_cpu_rmap(netdev->rx_cpu_rmap);
-	netdev->rx_cpu_rmap = NULL;
-}
-
 /**
  * ice_set_cpu_rx_rmap - setup CPU reverse map for each queue
  * @vsi: the VSI to be forwarded to
@@ -597,7 +578,6 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 {
 	struct net_device *netdev;
 	struct ice_pf *pf;
-	int i;
 
 	if (!vsi || vsi->type != ICE_VSI_PF)
 		return 0;
@@ -610,18 +590,7 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 	netdev_dbg(netdev, "Setup CPU RMAP: vsi type 0x%x, ifname %s, q_vectors %d\n",
 		   vsi->type, netdev->name, vsi->num_q_vectors);
 
-	netdev->rx_cpu_rmap = alloc_irq_cpu_rmap(vsi->num_q_vectors);
-	if (unlikely(!netdev->rx_cpu_rmap))
-		return -EINVAL;
-
-	ice_for_each_q_vector(vsi, i)
-		if (irq_cpu_rmap_add(netdev->rx_cpu_rmap,
-				     vsi->q_vectors[i]->irq.virq)) {
-			ice_free_cpu_rx_rmap(vsi);
-			return -EINVAL;
-		}
-
-	return 0;
+	return netif_enable_cpu_rmap(netdev, vsi->num_q_vectors);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.h b/drivers/net/ethernet/intel/ice/ice_arfs.h
index 9669ad9bf7b5..9706293128c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.h
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.h
@@ -45,7 +45,6 @@ int
 ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
 		  u16 rxq_idx, u32 flow_id);
 void ice_clear_arfs(struct ice_vsi *vsi);
-void ice_free_cpu_rx_rmap(struct ice_vsi *vsi);
 void ice_init_arfs(struct ice_vsi *vsi);
 void ice_sync_arfs_fltrs(struct ice_pf *pf);
 int ice_set_cpu_rx_rmap(struct ice_vsi *vsi);
@@ -56,7 +55,6 @@ ice_is_arfs_using_perfect_flow(struct ice_hw *hw,
 			       enum ice_fltr_ptype flow_type);
 #else
 static inline void ice_clear_arfs(struct ice_vsi *vsi) { }
-static inline void ice_free_cpu_rx_rmap(struct ice_vsi *vsi) { }
 static inline void ice_init_arfs(struct ice_vsi *vsi) { }
 static inline void ice_sync_arfs_fltrs(struct ice_pf *pf) { }
 static inline void ice_remove_arfs(struct ice_pf *pf) { }
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b3234a55a253..6db4ad8fc70b 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -147,10 +147,6 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	q_vector->reg_idx = q_vector->irq.index;
 	q_vector->vf_reg_idx = q_vector->irq.index;
 
-	/* only set affinity_mask if the CPU is online */
-	if (cpu_online(v_idx))
-		cpumask_set_cpu(v_idx, &q_vector->affinity_mask);
-
 	/* This will not be called in the driver load path because the netdev
 	 * will not be created yet. All other cases with register the NAPI
 	 * handler here (i.e. resume, reset/rebuild, etc.)
@@ -276,7 +272,8 @@ static void ice_cfg_xps_tx_ring(struct ice_tx_ring *ring)
 	if (test_and_set_bit(ICE_TX_XPS_INIT_DONE, ring->xps_state))
 		return;
 
-	netif_set_xps_queue(ring->netdev, &ring->q_vector->affinity_mask,
+	netif_set_xps_queue(ring->netdev,
+			    &ring->q_vector->napi.config->affinity_mask,
 			    ring->q_index);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ce30674abf8f..715efd8a359f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2592,7 +2592,6 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		return;
 
 	vsi->irqs_ready = false;
-	ice_free_cpu_rx_rmap(vsi);
 
 	ice_for_each_q_vector(vsi, i) {
 		int irq_num;
@@ -2605,12 +2604,6 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		      vsi->q_vectors[i]->num_ring_rx))
 			continue;
 
-		/* clear the affinity notifier in the IRQ descriptor */
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
-			irq_set_affinity_notifier(irq_num, NULL);
-
-		/* clear the affinity_hint in the IRQ descriptor */
-		irq_update_affinity_hint(irq_num, NULL);
 		synchronize_irq(irq_num);
 		devm_free_irq(ice_pf_to_dev(pf), irq_num, vsi->q_vectors[i]);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b084839eb811..eff4afabeef6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2527,34 +2527,6 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset)
 	return 0;
 }
 
-/**
- * ice_irq_affinity_notify - Callback for affinity changes
- * @notify: context as to what irq was changed
- * @mask: the new affinity mask
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * so that we may register to receive changes to the irq affinity masks.
- */
-static void
-ice_irq_affinity_notify(struct irq_affinity_notify *notify,
-			const cpumask_t *mask)
-{
-	struct ice_q_vector *q_vector =
-		container_of(notify, struct ice_q_vector, affinity_notify);
-
-	cpumask_copy(&q_vector->affinity_mask, mask);
-}
-
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
@@ -2618,19 +2590,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 				   err);
 			goto free_q_irqs;
 		}
-
-		/* register for affinity change notifications */
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL)) {
-			struct irq_affinity_notify *affinity_notify;
-
-			affinity_notify = &q_vector->affinity_notify;
-			affinity_notify->notify = ice_irq_affinity_notify;
-			affinity_notify->release = ice_irq_affinity_release;
-			irq_set_affinity_notifier(irq_num, affinity_notify);
-		}
-
-		/* assign the mask for this irq */
-		irq_update_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
 	err = ice_set_cpu_rx_rmap(vsi);
@@ -2646,9 +2605,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 free_q_irqs:
 	while (vector--) {
 		irq_num = vsi->q_vectors[vector]->irq.virq;
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
-			irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
@@ -3675,6 +3631,9 @@ void ice_set_netdev_features(struct net_device *netdev)
 	 */
 	netdev->hw_features |= NETIF_F_RXFCS;
 
+	/* Allow core to manage IRQs affinity */
+	netif_set_affinity_auto(netdev);
+
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
-- 
2.43.0


