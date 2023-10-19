Return-Path: <netdev+bounces-42449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549497CEC4F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0B62812D1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D1646663;
	Wed, 18 Oct 2023 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CApLBd6P"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AC46661
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:50:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A485113
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697673026; x=1729209026;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8HZYDgx6IDDsbxGTG61a7dzwTvgXZCE/xcl5jTj8fI=;
  b=CApLBd6PDfsEmL5TI0ev1JhAQ4MbC/wPcqtm3Xt6f2FpoXx1NSvOyyfh
   U4UptfPLsgG/GkRx9X0RI8LJ1hngBQ5I+52Td/8cL9uOd+TeawrHNhySk
   th/Qx5ARpeQcVi58LCahjI6o5T9THgv6l4wutOr1j/qMLFXKy3eFiviwx
   ipXvBicAyxilwqsknfwBDEAoQNMKZoEOkg8Ic0CTq4e7G1AmHJY+BYTE7
   2h8HGri1AuPNtTOEw4Yc6iRdNfUmAtvJWXMKkRoq9jMmzihIURUvjHosG
   KmXhQm87QV5QVU0EEZ3XQ8iD6WIBHhpDvTWvuWBkhalSPgLeE94fNAyWC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="4733138"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4733138"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:50:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4739504"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 16:50:27 -0700
Subject: [net-next PATCH v5 03/10] ice: Add support in the driver for
 associating queue with napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Wed, 18 Oct 2023 17:06:17 -0700
Message-ID: <169767397753.6692.15797121214738496388.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
References: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
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
 drivers/net/ethernet/intel/ice/ice_lib.c  |   61 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
 drivers/net/ethernet/intel/ice/ice_main.c |    4 +-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1f45f0c3963d..97ca8f9f77a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2448,6 +2448,10 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 			goto unroll_vector_base;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+
+		/* Associate q_vector rings to napi */
+		ice_vsi_set_napi_queues(vsi, true);
+
 		vsi->stat_offsets_loaded = false;
 
 		if (ice_is_xdp_ena_vsi(vsi)) {
@@ -2927,6 +2931,63 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
 		synchronize_irq(vsi->q_vectors[i]->irq.virq);
 }
 
+/**
+ * ice_queue_set_napi - Set the napi instance for the queue
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context
+ * @locked: is the rtnl_lock already held
+ *
+ * Set the napi instance for the queue
+ */
+void ice_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
+			struct napi_struct *napi, bool locked)
+{
+	if (locked)
+		__netif_queue_set_napi(queue_index, type, napi);
+	else
+		netif_queue_set_napi(queue_index, type, napi);
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
+		ice_queue_set_napi(rx_ring->q_index, NETDEV_QUEUE_TYPE_RX,
+				   &q_vector->napi, locked);
+
+	ice_for_each_tx_ring(tx_ring, q_vector->tx)
+		ice_queue_set_napi(tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
+				   &q_vector->napi, locked);
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
index 0dd7f23395b0..ae40550ba35c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3374,9 +3374,11 @@ static void ice_napi_add(struct ice_vsi *vsi)
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


