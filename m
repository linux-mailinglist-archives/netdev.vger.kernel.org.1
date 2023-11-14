Return-Path: <netdev+bounces-47547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D87EA74C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A9E1F235FE
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB01FA2;
	Tue, 14 Nov 2023 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8IZc3R7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2C1C2B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30341B2
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920812; x=1731456812;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQJYxnZlKA9Ij9yfK/H/PhuxInauA2ns5cAWdqbeYZ0=;
  b=d8IZc3R750a7kZRHALgIoWtAqw+3Ff1HVWOTAKUYYZ4PFC8LQzB+fsZm
   1zj5IfM2GmLHkqxbAlszuNgKra0JR58/HkwKl8AuXeze2O+HT7GIC71nM
   B+xvS1DpFVClS/ky+AdknVAZRdQ3O8g7uVxRQiE5KRE6Dy4uNVnUEbUb9
   UVTD2oHP6OeYK5RYSG8V+X3k3UuxNVEh0YnmdSxksMyDV3MKaGmumzelu
   LX9btZTT2223VQwdsiW+SzEjk7xAbgvzdHCMJvvJ4gyu5d0cs3haOZyKx
   AC/ccPCEs267UY9nldmgY1neYWCA4gO2uVrl9Twm0XObMmQIe5V32KY/i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393397405"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393397405"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095891245"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095891245"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 16:13:31 -0800
Subject: [net-next PATCH v7 03/10] ice: Add support in the driver for
 associating queue with napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:29:47 -0800
Message-ID: <169992178722.3867.18394610591669794437.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
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
 drivers/net/ethernet/intel/ice/ice_lib.c  |   62 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
 drivers/net/ethernet/intel/ice/ice_main.c |    4 +-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4b1e56396293..e2c24853376f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2447,6 +2447,10 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 			goto unroll_vector_base;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+
+		/* Associate q_vector rings to napi */
+		ice_vsi_set_napi_queues(vsi, true);
+
 		vsi->stat_offsets_loaded = false;
 
 		if (ice_is_xdp_ena_vsi(vsi)) {
@@ -2926,6 +2930,64 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
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
+static void
+ice_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
+		   struct napi_struct *napi, bool locked)
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
index 6607fa6fe556..126da447e168 100644
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


