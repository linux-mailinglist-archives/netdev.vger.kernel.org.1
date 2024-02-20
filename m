Return-Path: <netdev+bounces-73447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F085CA2D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C36B1F2291E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578941534EA;
	Tue, 20 Feb 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npPtyoVq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312A152E02
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465500; cv=none; b=XeNfT/nmYfIo3XGWxEtd1DII9qnh/IO5sb48IXM6dYjtMkzXNRzy8bjsCW0pnp55k3glZA9IN6q9BEmItKegXcQUrOyXU3O4TJyzNVgQfWY4UHalGEjh+yQP1llbQLII++RHWEGLrh4JGxy1RavubmFwYtc8rsvmC8JjzR/PKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465500; c=relaxed/simple;
	bh=X4/R+QWkX6Tvx4dKZNr4uvtReZ6mqR7J9A6HrHErfEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWdol9CtlyWmsWE8w1Vad99jpemFIUq1W3dFpql2V25hLAzVQKobyDFdidNUwWI1/29S4F1lOr5IBA4dahc8zH2ny5z5Sy/bV67pyBJS4lx3Y2JKm1+1XSGAHD+hAQZ3RCYCzb2d0qzLvqtdtrzSVwXpW44hRKY4aGa50A8aDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npPtyoVq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465499; x=1740001499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4/R+QWkX6Tvx4dKZNr4uvtReZ6mqR7J9A6HrHErfEQ=;
  b=npPtyoVqkUmkbFICJCJBiwmU0ZLMfa0ZRvA3Ma0rwt4n0FHJH2VB5BtE
   OlqHRwRKyEu9EfLTYAgUACJuBbHLx4ppeX1AOCovgjVib4UmVd+gThjxR
   tjJXpBSUyX7nfgArYfkF21JE2HItDb10oZOM1WGyVMlfnbuHt6qqxUBfY
   xSNNiuUbCYe/ebim9dICeVRiJLBxMuLp0DodA/wqEpAlXJajeLCiBfi0E
   E3Vf3Sz0qvbRdy/Ylu1XEwupReYbfucl0lVS2g/TJvqAy/dRb5mCvXE2F
   dJKlyN9ZcBqmTayO4G8ASRQFH8c2A7+XqH4niD7ZGQ9kb1YV2VuVsX+wq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472749"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614949"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Amritha Nambiar <amritha.nambiar@intel.com>,
	anthony.l.nguyen@intel.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 6/6] ice: Fix ASSERT_RTNL() warning during certain scenarios
Date: Tue, 20 Feb 2024 13:44:42 -0800
Message-ID: <20240220214444.1039759-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amritha Nambiar <amritha.nambiar@intel.com>

Commit 91fdbce7e8d6 ("ice: Add support in the driver for associating
queue with napi") invoked the netif_queue_set_napi() call. This
kernel function requires to be called with rtnl_lock taken,
otherwise ASSERT_RTNL() warning will be triggered. ice_vsi_rebuild()
initiating this call is under rtnl_lock when the rebuild is in
response to configuration changes from external interfaces (such as
tc, ethtool etc. which holds the lock). But, the VSI rebuild
generated from service tasks and resets (PFR/CORER/GLOBR) is not
under rtnl lock protection. Handle these cases as well to hold lock
before the kernel call (by setting the 'locked' boolean to false).

netif_queue_set_napi() is also used to clear previously set napi
in the q_vector unroll flow. Handle this for locked/lockless execution
paths.

Fixes: 91fdbce7e8d6 ("ice: Add support in the driver for associating queue with napi")
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 10 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 86 ++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lib.h  | 10 ++-
 drivers/net/ethernet/intel/ice/ice_main.c |  3 +-
 4 files changed, 83 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7ac847718882..c979192e44d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -190,15 +190,13 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
 	q_vector = vsi->q_vectors[v_idx];
 
 	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
-		if (vsi->netdev)
-			netif_queue_set_napi(vsi->netdev, tx_ring->q_index,
-					     NETDEV_QUEUE_TYPE_TX, NULL);
+		ice_queue_set_napi(vsi, tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
+				   NULL);
 		tx_ring->q_vector = NULL;
 	}
 	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
-		if (vsi->netdev)
-			netif_queue_set_napi(vsi->netdev, rx_ring->q_index,
-					     NETDEV_QUEUE_TYPE_RX, NULL);
+		ice_queue_set_napi(vsi, rx_ring->q_index, NETDEV_QUEUE_TYPE_RX,
+				   NULL);
 		rx_ring->q_vector = NULL;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be724291ef8..097bf8fd6bf0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2426,7 +2426,7 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 		ice_vsi_map_rings_to_vectors(vsi);
 
 		/* Associate q_vector rings to napi */
-		ice_vsi_set_napi_queues(vsi, true);
+		ice_vsi_set_napi_queues(vsi);
 
 		vsi->stat_offsets_loaded = false;
 
@@ -2904,19 +2904,19 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
 }
 
 /**
- * ice_queue_set_napi - Set the napi instance for the queue
+ * __ice_queue_set_napi - Set the napi instance for the queue
  * @dev: device to which NAPI and queue belong
  * @queue_index: Index of queue
  * @type: queue type as RX or TX
  * @napi: NAPI context
  * @locked: is the rtnl_lock already held
  *
- * Set the napi instance for the queue
+ * Set the napi instance for the queue. Caller indicates the lock status.
  */
 static void
-ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
-		   enum netdev_queue_type type, struct napi_struct *napi,
-		   bool locked)
+__ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+		     enum netdev_queue_type type, struct napi_struct *napi,
+		     bool locked)
 {
 	if (!locked)
 		rtnl_lock();
@@ -2926,26 +2926,79 @@ ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 
 /**
- * ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
+ * ice_queue_set_napi - Set the napi instance for the queue
+ * @vsi: VSI being configured
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context
+ *
+ * Set the napi instance for the queue. The rtnl lock state is derived from the
+ * execution path.
+ */
+void
+ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
+		   enum netdev_queue_type type, struct napi_struct *napi)
+{
+	struct ice_pf *pf = vsi->back;
+
+	if (!vsi->netdev)
+		return;
+
+	if (current_work() == &pf->serv_task ||
+	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
+	    test_bit(ICE_DOWN, pf->state) ||
+	    test_bit(ICE_SUSPENDED, pf->state))
+		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
+				     false);
+	else
+		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
+				     true);
+}
+
+/**
+ * __ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
  * @q_vector: q_vector pointer
  * @locked: is the rtnl_lock already held
  *
+ * Associate the q_vector napi with all the queue[s] on the vector.
+ * Caller indicates the lock status.
+ */
+void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
+{
+	struct ice_rx_ring *rx_ring;
+	struct ice_tx_ring *tx_ring;
+
+	ice_for_each_rx_ring(rx_ring, q_vector->rx)
+		__ice_queue_set_napi(q_vector->vsi->netdev, rx_ring->q_index,
+				     NETDEV_QUEUE_TYPE_RX, &q_vector->napi,
+				     locked);
+
+	ice_for_each_tx_ring(tx_ring, q_vector->tx)
+		__ice_queue_set_napi(q_vector->vsi->netdev, tx_ring->q_index,
+				     NETDEV_QUEUE_TYPE_TX, &q_vector->napi,
+				     locked);
+	/* Also set the interrupt number for the NAPI */
+	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+}
+
+/**
+ * ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
+ * @q_vector: q_vector pointer
+ *
  * Associate the q_vector napi with all the queue[s] on the vector
  */
-void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
+void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector)
 {
 	struct ice_rx_ring *rx_ring;
 	struct ice_tx_ring *tx_ring;
 
 	ice_for_each_rx_ring(rx_ring, q_vector->rx)
-		ice_queue_set_napi(q_vector->vsi->netdev, rx_ring->q_index,
-				   NETDEV_QUEUE_TYPE_RX, &q_vector->napi,
-				   locked);
+		ice_queue_set_napi(q_vector->vsi, rx_ring->q_index,
+				   NETDEV_QUEUE_TYPE_RX, &q_vector->napi);
 
 	ice_for_each_tx_ring(tx_ring, q_vector->tx)
-		ice_queue_set_napi(q_vector->vsi->netdev, tx_ring->q_index,
-				   NETDEV_QUEUE_TYPE_TX, &q_vector->napi,
-				   locked);
+		ice_queue_set_napi(q_vector->vsi, tx_ring->q_index,
+				   NETDEV_QUEUE_TYPE_TX, &q_vector->napi);
 	/* Also set the interrupt number for the NAPI */
 	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
 }
@@ -2953,11 +3006,10 @@ void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
 /**
  * ice_vsi_set_napi_queues
  * @vsi: VSI pointer
- * @locked: is the rtnl_lock already held
  *
  * Associate queue[s] with napi for all vectors
  */
-void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked)
+void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 {
 	int i;
 
@@ -2965,7 +3017,7 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked)
 		return;
 
 	ice_for_each_q_vector(vsi, i)
-		ice_q_vector_set_napi_queues(vsi->q_vectors[i], locked);
+		ice_q_vector_set_napi_queues(vsi->q_vectors[i]);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 71bd27244941..bfcfc582a4c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -91,9 +91,15 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
-void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
+void
+ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
+		   enum netdev_queue_type type, struct napi_struct *napi);
+
+void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
+
+void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector);
 
-void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked);
+void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
 
 int ice_vsi_release(struct ice_vsi *vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dd4a9bc0dfdc..59c7e37f175f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3495,7 +3495,7 @@ static void ice_napi_add(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, v_idx) {
 		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
 			       ice_napi_poll);
-		ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
+		__ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
 	}
 }
 
@@ -5447,6 +5447,7 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 		if (ret)
 			goto err_reinit;
 		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
+		ice_vsi_set_napi_queues(pf->vsi[v]);
 	}
 
 	ret = ice_req_irq_msix_misc(pf);
-- 
2.41.0


