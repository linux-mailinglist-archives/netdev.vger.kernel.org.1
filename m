Return-Path: <netdev+bounces-51544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840067FB06F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDD11C20B53
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF15749B;
	Tue, 28 Nov 2023 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE8UL+IT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB11A7
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 19:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701142396; x=1732678396;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ElEUOE4XLEzekpl4LV2dyxoqhNR+bp9lxMC11Ioil8=;
  b=jE8UL+ITdSXET/+mAiORWN3t/JKUu45hN4QN5ks1a/gPiRVYFyfFjzIt
   ZE/auWgc5E1e+7KmtknTqDpVdCO5GLrfMjcogifjmTfodcnyq1L66rky5
   c1lgo9otMvPcSsTwgjb5yM2/3YCerj4QFB8tOvumqqjisK4HrA2pYLjh8
   L7ua92q23NMekCzp8mGawcF7Qvw7S2YG4m55qJhnV4IRaW42HKOlfmi2d
   dyuR3I2A3+NZemmdl/IEmlQd2FbqvkcWVwFihJ3Zu+fbnztouwoIsDlVf
   SBQ26oKv9xyNmzn7Wn5i2J0biCT8InlZkh0DYOtUWcCgd7kZvGbjdr4nv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389997262"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="389997262"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761820902"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="761820902"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2023 19:33:15 -0800
Subject: [net-next PATCH v9 03/11] ice: Add support in the driver for
 associating queue with napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 27 Nov 2023 19:49:42 -0800
Message-ID: <170114338223.10303.3266332033565241969.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

After the napi context is initialized, map the napi instance
with the queue/queue-set on the corresponding irq line.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c |   12 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c  |   67 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
 drivers/net/ethernet/intel/ice/ice_main.c |    4 +-
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7fa43827a3f0..edad5f9ab16c 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -189,10 +189,18 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
 	}
 	q_vector = vsi->q_vectors[v_idx];
 
-	ice_for_each_tx_ring(tx_ring, q_vector->tx)
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		if (vsi->netdev)
+			netif_queue_set_napi(vsi->netdev, tx_ring->q_index,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
 		tx_ring->q_vector = NULL;
-	ice_for_each_rx_ring(rx_ring, q_vector->rx)
+	}
+	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		if (vsi->netdev)
+			netif_queue_set_napi(vsi->netdev, rx_ring->q_index,
+					     NETDEV_QUEUE_TYPE_RX, NULL);
 		rx_ring->q_vector = NULL;
+	}
 
 	/* only VSI with an associated netdev is set up with NAPI */
 	if (vsi->netdev)
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d826b5afa143..83f6977fad22 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2452,6 +2452,10 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 			goto unroll_vector_base;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+
+		/* Associate q_vector rings to napi */
+		ice_vsi_set_napi_queues(vsi, true);
+
 		vsi->stat_offsets_loaded = false;
 
 		if (ice_is_xdp_ena_vsi(vsi)) {
@@ -2931,6 +2935,69 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
 		synchronize_irq(vsi->q_vectors[i]->irq.virq);
 }
 
+/**
+ * ice_queue_set_napi - Set the napi instance for the queue
+ * @dev: device to which NAPI and queue belong
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context
+ * @locked: is the rtnl_lock already held
+ *
+ * Set the napi instance for the queue
+ */
+static void
+ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+		   enum netdev_queue_type type, struct napi_struct *napi,
+		   bool locked)
+{
+	if (!locked)
+		rtnl_lock();
+	netif_queue_set_napi(dev, queue_index, type, napi);
+	if (!locked)
+		rtnl_unlock();
+}
+
+/**
+ * ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
+ * @q_vector: q_vector pointer
+ * @locked: is the rtnl_lock already held
+ *
+ * Associate the q_vector napi with all the queue[s] on the vector
+ */
+void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
+{
+	struct ice_rx_ring *rx_ring;
+	struct ice_tx_ring *tx_ring;
+
+	ice_for_each_rx_ring(rx_ring, q_vector->rx)
+		ice_queue_set_napi(q_vector->vsi->netdev, rx_ring->q_index,
+				   NETDEV_QUEUE_TYPE_RX, &q_vector->napi,
+				   locked);
+
+	ice_for_each_tx_ring(tx_ring, q_vector->tx)
+		ice_queue_set_napi(q_vector->vsi->netdev, tx_ring->q_index,
+				   NETDEV_QUEUE_TYPE_TX, &q_vector->napi,
+				   locked);
+}
+
+/**
+ * ice_vsi_set_napi_queues
+ * @vsi: VSI pointer
+ * @locked: is the rtnl_lock already held
+ *
+ * Associate queue[s] with napi for all vectors
+ */
+void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked)
+{
+	int i;
+
+	if (!vsi->netdev)
+		return;
+
+	ice_for_each_q_vector(vsi, i)
+		ice_q_vector_set_napi_queues(vsi->q_vectors[i], locked);
+}
+
 /**
  * ice_vsi_release - Delete a VSI and free its resources
  * @vsi: the VSI being removed
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index f24f5d1e6f9c..71bd27244941 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -91,6 +91,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
+void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
+
+void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked);
+
 int ice_vsi_release(struct ice_vsi *vsi);
 
 void ice_vsi_close(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 43ba3e55b8c1..9e3d3919307b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3375,9 +3375,11 @@ static void ice_napi_add(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	ice_for_each_q_vector(vsi, v_idx)
+	ice_for_each_q_vector(vsi, v_idx) {
 		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
 			       ice_napi_poll);
+		ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
+	}
 }
 
 /**


