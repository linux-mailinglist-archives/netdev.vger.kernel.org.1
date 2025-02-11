Return-Path: <netdev+bounces-165288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A08A31747
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C00618890E4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DC264FA7;
	Tue, 11 Feb 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKdAiqUm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2E264F98
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308077; cv=none; b=LO1Hg8HUUXI3FzQgwqwwKjXD57pd59pD29xN8OzsiZpEP6AtbMKizIWSWIfHQA46akmrMf/4jobehZQ8lhFGc3WbMm3CuP6yPCBuwwX9rDos3FDblzhSCSqoBZzZZDZ+M54voQ7XjTT3QFA5HO2npNhXdsDqCqNpP57EEERqcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308077; c=relaxed/simple;
	bh=xkHjvnq2G1HTvjE5eBvyAyhXwGeJyVlE8z/pVyRxQPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcW3x/1XtKZ35jgkDeHd8+LzxhMEc0VWc4IugkgOX3ja8k3h9RvfaSK1PCbTWRV5t32oLgQaaMeNRi3G8JnoRWL11mGQY54tNd20kO7YpRMmfgswitoBNf7PLKmLLgujC5ECy4KfZHK+tVFv4CPFcG18bqCRblpi/mAndgJEGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKdAiqUm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308076; x=1770844076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkHjvnq2G1HTvjE5eBvyAyhXwGeJyVlE8z/pVyRxQPg=;
  b=hKdAiqUmHbRvXqA/zMkXizxYJZq68G8b2xNKscRNGdSbsaQlRDCRKW1g
   VyMJAMXSa0HscX6xjUnWdVnFl27F+GZ60lB7evzD8V3K3cIUx+jYb1jVW
   W+157nLwdv+SnYkskBaP/PeM9tnlqYFJdxnWH5GO8vHYuSn5dZU8E2ng3
   mNbvVVNZ1Mq6+G/YQwiZd6ibxZr5Da+yHTMcF0r5WVbDruHmCutkcqn5z
   5MaTYV+ItC/FsS2QhD3o2DWzelHO2pS13WDw/xRMhRv/ovy9j2iLBrJqc
   QVmGOAvO4x+7c/nU2VgY4cD1S7khS0VSY6qVWk+EN15WSX/E8TYC9eBpV
   w==;
X-CSE-ConnectionGUID: QXKSwySJQnqkuLEMju4Rag==
X-CSE-MsgGUID: z7UTms9/TsmIc7SKY1Cr+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51339682"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51339682"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:55 -0800
X-CSE-ConnectionGUID: ZnhV87XCTDG4dC6O+4/XWQ==
X-CSE-MsgGUID: T6ngDiIQSpK9Fsv41YKCQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116713274"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.7])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:47 -0800
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
	kalesh-anakkur.purayil@broadcom.com,
	pavan.chebbi@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v8 5/6] ice: use napi's irq affinity
Date: Tue, 11 Feb 2025 14:06:56 -0700
Message-ID: <20250211210657.428439-6-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211210657.428439-1-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the driver CPU affinity info and use the core's napi config
instead.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  3 --
 drivers/net/ethernet/intel/ice/ice_base.c |  7 +---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  6 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 47 ++---------------------
 4 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2a6de2115193..9a5f8919d1a4 100644
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
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 0e862f20427a..5901795f3b62 100644
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
index 916b072ab718..46a2762dd083 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2605,12 +2605,6 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
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
index d7037de29545..094403f2bf55 100644
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
@@ -3689,6 +3645,9 @@ void ice_set_netdev_features(struct net_device *netdev)
 	 */
 	netdev->hw_features |= NETIF_F_RXFCS;
 
+	/* Allow core to manage IRQs affinity */
+	netif_set_affinity_auto(netdev);
+
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
-- 
2.43.0


