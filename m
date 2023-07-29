Return-Path: <netdev+bounces-22479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6050767995
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147AC1C2197F
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CD17FC;
	Sat, 29 Jul 2023 00:32:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A114AA2
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:16 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1EE48
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590734; x=1722126734;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kI7o37m91co1mhwYMHt1BPyvqDEKIJ13aWaOHWFgjzc=;
  b=SWPWziH2Zormt9VXDPEcPLGIhcQ7bov7K+J9FBbXlpL/aJKZfmhBM85y
   grgCUJ+6kS1Mcd8uWxCRZQkZccJRnDbluDGpE0U6JM5pbrRUf+Xj9GVEm
   r1szFi8YerZycInWwvnmotyzU59Pw06xOaJG+NF1xM+enKs4hINxarxjX
   dsJHuhHL7+wk7urwmQuEZxbAZnei9Pec0DfEXFXSMnZvUSIRoAYiayAVR
   cn9idUQMQCrUfH36o436pfsbJtFU3NuBIttWLvI5OxSGDxU0hfuYccR09
   x9Jo4sDVreGd8uijHm5ms6QqKX1imdz637ZpF8yLKMUzcFG6CDwhQ/Y+p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="455069307"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="455069307"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="757358741"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="757358741"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 17:32:14 -0700
Subject: [net-next PATCH v1 2/9] ice: Add support in the driver for
 associating napi with queue[s]
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:02 -0700
Message-ID: <169059162246.3736.8238877297708667866.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After the napi context is initialized, map the napi instance
with the queue/queue-set on the corresponding irq line.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |   57 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
 drivers/net/ethernet/intel/ice/ice_main.c |    4 ++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 077f2e91ae1a..171177db8fb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2464,6 +2464,12 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 			goto unroll_vector_base;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+
+		/* Associate q_vector rings to napi */
+		ret = ice_vsi_add_napi_queues(vsi);
+		if (ret)
+			goto unroll_vector_base;
+
 		vsi->stat_offsets_loaded = false;
 
 		if (ice_is_xdp_ena_vsi(vsi)) {
@@ -2943,6 +2949,57 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
 		synchronize_irq(vsi->q_vectors[i]->irq.virq);
 }
 
+/**
+ * ice_q_vector_add_napi_queues - Add queue[s] associated with the napi
+ * @q_vector: q_vector pointer
+ *
+ * Associate the q_vector napi with all the queue[s] on the vector
+ * Returns 0 on success or < 0 on error
+ */
+int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
+{
+	struct ice_rx_ring *rx_ring;
+	struct ice_tx_ring *tx_ring;
+	int ret;
+
+	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		ret = netif_napi_add_queue(&q_vector->napi, rx_ring->q_index,
+					   NAPI_QUEUE_RX);
+		if (ret)
+			return ret;
+	}
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		ret = netif_napi_add_queue(&q_vector->napi, tx_ring->q_index,
+					   NAPI_QUEUE_TX);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * ice_vsi_add_napi_queues
+ * @vsi: VSI pointer
+ *
+ * Associate queue[s] with napi for all vectors
+ * Returns 0 on success or < 0 on error
+ */
+int ice_vsi_add_napi_queues(struct ice_vsi *vsi)
+{
+	int i, ret = 0;
+
+	if (!vsi->netdev)
+		return ret;
+
+	ice_for_each_q_vector(vsi, i) {
+		ret = ice_q_vector_add_napi_queues(vsi->q_vectors[i]);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
 /**
  * ice_napi_del - Remove NAPI handler for the VSI
  * @vsi: VSI for which NAPI handler is to be removed
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index dd53fe968ad8..26c427cddf63 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -93,6 +93,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
+int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector);
+
+int ice_vsi_add_napi_queues(struct ice_vsi *vsi);
+
 void ice_napi_del(struct ice_vsi *vsi);
 
 int ice_vsi_release(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 20d5ed572a8c..d3a2fc20157c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3373,9 +3373,11 @@ static void ice_napi_add(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	ice_for_each_q_vector(vsi, v_idx)
+	ice_for_each_q_vector(vsi, v_idx) {
 		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
 			       ice_napi_poll);
+		ice_q_vector_add_napi_queues(vsi->q_vectors[v_idx]);
+	}
 }
 
 /**


