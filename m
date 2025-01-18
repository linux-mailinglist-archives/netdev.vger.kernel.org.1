Return-Path: <netdev+bounces-159499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463AA15A4F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CFE168747
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19C747F;
	Sat, 18 Jan 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baKszIDT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F91523A
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737160452; cv=none; b=ZH52eC6nN0/0CH1qylaOno2igWv9jgw7tJyxuCJTodi3B6MW7MmGf1OofswLO1ahl4b46sS3Wqll4BpyjRX5U34zWoEVB9I03B2XwOiGHARFghOsYRxbM1/O5KMeM7xSymd8FpmByS8QejyBbLTL6QRLhs4TwTrTOjsJjvvDK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737160452; c=relaxed/simple;
	bh=bintgr3KjcEsVJNWFQe48vnlvi/JEQ2zCji/mxZDUyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4HPkRnKnBl8IF/7FJjzA/QHtlxC5oY7grF39kK66X/oadMw+zEFs5xW6gaLjR0ArW5TVhUNmV7wWz/4UhFEHU86iF3Na7m8PgcO87RWuXXN819wR2mfOxb9jvQPOcun3lFDH6QqmP4ToxdR0RK3/kLWRR+u34EXHvptMLUM0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baKszIDT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737160451; x=1768696451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bintgr3KjcEsVJNWFQe48vnlvi/JEQ2zCji/mxZDUyE=;
  b=baKszIDTH/1Tkm3idjFtRvb4Bot9qQ9SiQB+ZhN/kfScMMzto3+hoZe0
   64ja1C/QZMETkgiEAShKtKhZmw5gwL2+QXc/TBc0iGqcPIkvReUqvRTKC
   yReVQ9G7RtxECO/ro+RwAwDE48A7JuNdzQ9NoNiGmy/47WYweO3s1HL4Q
   36DpXqvwOOO3AmDFgE9oSd0Qx4aHeQZEfVZocqR1JYPdUyjiZhGwLIiq3
   N7osNK3hg1L6fGkuFLr6Lr9XlrywDQLUVdWjDIYd3/ooYCWmDcrzM/swP
   mBopzL+M2PS7C6L07W2kPZuDPG3GUHSCQem9+IrFkc+Q4I+FwQBPMFmIM
   g==;
X-CSE-ConnectionGUID: i1mu1U9/QVekj0gqncN87g==
X-CSE-MsgGUID: SpW/fFkURkKtk75tVF6pTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37762783"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37762783"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 16:34:11 -0800
X-CSE-ConnectionGUID: W2FadkWjT/i6g5tE0LJYyA==
X-CSE-MsgGUID: 7U3ZnFAjRIyYpkFXStilsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106411036"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.109.139])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 16:34:06 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v6 4/5] ice: use napi's irq affinity
Date: Fri, 17 Jan 2025 17:33:34 -0700
Message-ID: <20250118003335.155379-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250118003335.155379-1-ahmed.zaki@intel.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
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
index 71e05d30f0fd..a6e6c9e1edc1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -478,9 +478,6 @@ struct ice_q_vector {
 	struct ice_ring_container rx;
 	struct ice_ring_container tx;
 
-	cpumask_t affinity_mask;
-	struct irq_affinity_notify affinity_notify;
-
 	struct ice_channel *ch;
 
 	char name[ICE_INT_NAME_STR_LEN];
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b2af8e3586f7..86cf715de00f 100644
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
index a7d45a8ce7ac..b5b93a426933 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2589,12 +2589,6 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
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
index 8fd522093dfe..4be6155855ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2515,34 +2515,6 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset)
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
@@ -2606,19 +2578,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
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
@@ -2634,9 +2593,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 free_q_irqs:
 	while (vector--) {
 		irq_num = vsi->q_vectors[vector]->irq.virq;
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
-			irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
@@ -3677,6 +3633,9 @@ void ice_set_netdev_features(struct net_device *netdev)
 	 */
 	netdev->hw_features |= NETIF_F_RXFCS;
 
+	/* Allow core to manage IRQs affinity */
+	netif_enable_irq_affinity(netdev);
+
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
-- 
2.43.0


