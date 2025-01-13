Return-Path: <netdev+bounces-157823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B1A0BE8B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE833A7BEC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B11BD032;
	Mon, 13 Jan 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5tfP5f+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD6165EFC
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788297; cv=none; b=hy5JaaR37TKrJUdPEobhG973aGo+12QIhiCmJHNof+ZqLlg+oaSMS2pfaR71ne/spaRYMEzu0u+oeI2GKScAvEbyosivzkiZDWXhUEjrzhyI8+uU3jHZiTKXdxaSvGTIrXl3qC5Ssj/2HIirGqEFZQWqcNn8jAYtkQZSHuig71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788297; c=relaxed/simple;
	bh=jWErJz+EQDOaRYTwARq8kmAaWWmMLuEYTCWS+F+YS5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko1f5YZRF3Z6ujWCuDlZGcXg0pFYeOFgMURwHN6zAJyxpc+KkfMaOlhR4dIQ1E4W1EXnOhtEXldz6VVqKuVpxV9sJBS1BnzkbUCictswOlfvuUYg0bLan7K3g59K6JaoIjxx5WGsiOv9sEJJeplunlNDX65ZOW6zvDc9S1GeueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5tfP5f+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736788296; x=1768324296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWErJz+EQDOaRYTwARq8kmAaWWmMLuEYTCWS+F+YS5U=;
  b=T5tfP5f+EyWeov/LFkThfbhtyAnfBFgRQaxbCwUlE6pjUo7RojKme2LB
   gTuULySc1chfOCLA7krwpycHL1ldrJdUYaPYsIXOf4TY43HBqHi+3yC1l
   6yJUfOyfQRr874gX4l1An3YviftV+m1sqItI6bR7/SNn+AehUbKJWUJ89
   E7HuzcXqqcgRCWYG5kT8PoRUP87rR7et22SAcSY71lr8+k5ulozAiTUvS
   TB/JloMp3TL5mCIYQCzF5WxrpeXqkKeAcvbVwKTn25ZyecT2LJc4QZeoo
   XEMv5+ECJnec8w9EbN1i6wOCc8PcqhqtWDFxsUR4guUUB6OvdcWl0lw+4
   g==;
X-CSE-ConnectionGUID: 3hPtm6P4Te2cvHxCS7+gfA==
X-CSE-MsgGUID: /fWqfiXxTxafS9jtmUW6Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36748934"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36748934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:11:35 -0800
X-CSE-ConnectionGUID: SgAcS8wuQ2S2aSFMy7oiAg==
X-CSE-MsgGUID: ZX9aSER1QQeUC/xhFT8t4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104499782"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:11:27 -0800
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
	yury.norov@gmail.com,
	darinzon@amazon.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v5 5/6] ice: use napi's irq affinity
Date: Mon, 13 Jan 2025 10:10:41 -0700
Message-ID: <20250113171042.158123-6-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113171042.158123-1-ahmed.zaki@intel.com>
References: <20250113171042.158123-1-ahmed.zaki@intel.com>
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
index 1701f7143f24..8df7332fcbbb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2512,34 +2512,6 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset)
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
@@ -2603,19 +2575,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
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
@@ -2631,9 +2590,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 free_q_irqs:
 	while (vector--) {
 		irq_num = vsi->q_vectors[vector]->irq.virq;
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
-			irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
@@ -3674,6 +3630,9 @@ void ice_set_netdev_features(struct net_device *netdev)
 	 */
 	netdev->hw_features |= NETIF_F_RXFCS;
 
+	/* Allow core to manage IRQs affinity */
+	netif_enable_irq_affinity(netdev);
+
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
-- 
2.43.0


