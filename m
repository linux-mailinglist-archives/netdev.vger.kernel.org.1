Return-Path: <netdev+bounces-191189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF1ABA5DA
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4596189F093
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D121FF4A;
	Fri, 16 May 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wpz7NBl+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAA1A76BC
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747433968; cv=none; b=jNcpRW3vDpe+PsiHAUr8IUeOONW6sfzV/yx7n5FvbTqVhEA01r2OJa+n95sBoJQbuR6JiCsp0p5smhGh42qwQuRCWFYMFZx2KpMllYnRaPeI6NwdHPsU1lx/OqdtBwougo7of5qQj64NLEjdHrWIc90vcYcb8WN0M2TPsU8RoMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747433968; c=relaxed/simple;
	bh=UjsYggrPjf3ZVYJq6UGM0RiwYEa7YqodO2N4T1T7RDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPdx+hw2Ct+5/iDTzkpUdfAj4rMGJt09iAEhQ6Hpx5fpjDcybsnP6P+ABrvaenCdKAgYPbzDgGyWHnR24IXY1Dne/1isRsJzf0TxPsB21S13nT7x9y/GaA+9hdlNJIWJr7ApCRKBu7gqCH6MVRfUIC+2HtnfUPTBkeMDiW4yECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wpz7NBl+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747433966; x=1778969966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UjsYggrPjf3ZVYJq6UGM0RiwYEa7YqodO2N4T1T7RDs=;
  b=Wpz7NBl+uzXmHbxG6vM5AWpXfOTUT1V7ehDz+wLgNpExFIv0/3CorfhQ
   N2QeH2kD9z9cV4fyBcVkceQvZcPg5Qz1aNk5Q8pwOU3unYaED802r8cSl
   ALTcOMrlZmKnmOJQyMwiv8yjiX0RiSeJuMOH4pUWce0u3GVtpUsRnS5ii
   Z5pJNiSz9BFjj21D957lnUgiHbca7rLnmm8A2BwmmYXqpzBi5i2uuUJB1
   Zf+H3EPkALkCZWarxBzjztnlfb8CCQBYDkYLWbHErIwDpGNu4A/jtw9WG
   GlycVMDkz3SxR1Au0NrCGWmzMIShl+xxSpNtnQFkUTspiFIB5pc1onJcF
   g==;
X-CSE-ConnectionGUID: ncEA2QR5Qmeqic5tC9ksuA==
X-CSE-MsgGUID: S2A1q0uxS3OTTibfv4Tehw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49573955"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49573955"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 15:19:25 -0700
X-CSE-ConnectionGUID: eNoAAW8IQ8WDwK110GyKPA==
X-CSE-MsgGUID: 081DfcKcSvOrDbG9DWyXQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="139335290"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.245.236])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 15:19:22 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next] iavf: convert to NAPI IRQ affinity API
Date: Fri, 16 May 2025 16:19:09 -0600
Message-ID: <20250516221909.187879-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bd7c00605ee0 ("net: move aRFS rmap management and CPU affinity
to core") allows the drivers to delegate the IRQ affinity to the NAPI
instance. However, the driver needs to use a persistent NAPI config
and explicitly set/unset the NAPI<->IRQ association.

Convert to the new IRQ affinity API.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  2 -
 drivers/net/ethernet/intel/iavf/iavf_main.c | 58 ++++-----------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c |  3 +-
 3 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index eb86cca38be2..a87e0c6d4017 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -114,8 +114,6 @@ struct iavf_q_vector {
 	u16 reg_idx;		/* register index of the interrupt */
 	char name[IFNAMSIZ + 15];
 	bool arm_wb_state;
-	cpumask_t affinity_mask;
-	struct irq_affinity_notify affinity_notify;
 };
 
 /* Helper macros to switch between ints/sec and what the register uses.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index e4c28c1545a0..69054af4689a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -528,33 +528,6 @@ static void iavf_map_rings_to_vectors(struct iavf_adapter *adapter)
 	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 }
 
-/**
- * iavf_irq_affinity_notify - Callback for affinity changes
- * @notify: context as to what irq was changed
- * @mask: the new affinity mask
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * so that we may register to receive changes to the irq affinity masks.
- **/
-static void iavf_irq_affinity_notify(struct irq_affinity_notify *notify,
-				     const cpumask_t *mask)
-{
-	struct iavf_q_vector *q_vector =
-		container_of(notify, struct iavf_q_vector, affinity_notify);
-
-	cpumask_copy(&q_vector->affinity_mask, mask);
-}
-
-/**
- * iavf_irq_affinity_release - Callback for affinity notifier release
- * @ref: internal core kernel usage
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * to inform the current notification subscriber that they will no longer
- * receive notifications.
- **/
-static void iavf_irq_affinity_release(struct kref *ref) {}
-
 /**
  * iavf_request_traffic_irqs - Initialize MSI-X interrupts
  * @adapter: board private structure
@@ -569,7 +542,6 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 	unsigned int vector, q_vectors;
 	unsigned int rx_int_idx = 0, tx_int_idx = 0;
 	int irq_num, err;
-	int cpu;
 
 	iavf_irq_disable(adapter);
 	/* Decrement for Other and TCP Timer vectors */
@@ -604,17 +576,6 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 				 "Request_irq failed, error: %d\n", err);
 			goto free_queue_irqs;
 		}
-		/* register for affinity change notifications */
-		q_vector->affinity_notify.notify = iavf_irq_affinity_notify;
-		q_vector->affinity_notify.release =
-						   iavf_irq_affinity_release;
-		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
-		/* Spread the IRQ affinity hints across online CPUs. Note that
-		 * get_cpu_mask returns a mask with a permanent lifetime so
-		 * it's safe to use as a hint for irq_update_affinity_hint.
-		 */
-		cpu = cpumask_local_spread(q_vector->v_idx, -1);
-		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
 
 	return 0;
@@ -623,8 +584,6 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 	while (vector) {
 		vector--;
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
-		irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &adapter->q_vectors[vector]);
 	}
 	return err;
@@ -666,6 +625,7 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
  **/
 static void iavf_free_traffic_irqs(struct iavf_adapter *adapter)
 {
+	struct iavf_q_vector *q_vector;
 	int vector, irq_num, q_vectors;
 
 	if (!adapter->msix_entries)
@@ -674,10 +634,10 @@ static void iavf_free_traffic_irqs(struct iavf_adapter *adapter)
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
 	for (vector = 0; vector < q_vectors; vector++) {
+		q_vector = &adapter->q_vectors[vector];
+		netif_napi_set_irq_locked(&q_vector->napi, -1);
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
-		irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &adapter->q_vectors[vector]);
+		free_irq(irq_num, q_vector);
 	}
 }
 
@@ -1848,7 +1808,7 @@ static int iavf_init_rss(struct iavf_adapter *adapter)
  **/
 static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 {
-	int q_idx = 0, num_q_vectors;
+	int q_idx = 0, num_q_vectors, irq_num;
 	struct iavf_q_vector *q_vector;
 
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
@@ -1858,14 +1818,15 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 		return -ENOMEM;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
+		irq_num = adapter->msix_entries[q_idx + NONQ_VECS].vector;
 		q_vector = &adapter->q_vectors[q_idx];
 		q_vector->adapter = adapter;
 		q_vector->vsi = &adapter->vsi;
 		q_vector->v_idx = q_idx;
 		q_vector->reg_idx = q_idx;
-		cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
-		netif_napi_add_locked(adapter->netdev, &q_vector->napi,
-				      iavf_napi_poll);
+		netif_napi_add_config_locked(adapter->netdev, &q_vector->napi,
+					     iavf_napi_poll, q_idx);
+		netif_napi_set_irq_locked(&q_vector->napi, irq_num);
 	}
 
 	return 0;
@@ -5389,6 +5350,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_alloc_etherdev;
 	}
 
+	netif_set_affinity_auto(netdev);
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
 	pci_set_drvdata(pdev, netdev);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 35d353d38129..aaf70c625655 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1650,7 +1650,8 @@ int iavf_napi_poll(struct napi_struct *napi, int budget)
 		 * continue to poll, otherwise we must stop polling so the
 		 * interrupt can move to the correct cpu.
 		 */
-		if (!cpumask_test_cpu(cpu_id, &q_vector->affinity_mask)) {
+		if (!cpumask_test_cpu(cpu_id,
+				      &q_vector->napi.config->affinity_mask)) {
 			/* Tell napi that we are done polling */
 			napi_complete_done(napi, work_done);
 
-- 
2.43.0


