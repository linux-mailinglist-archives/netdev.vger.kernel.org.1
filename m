Return-Path: <netdev+bounces-29472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0A783621
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B697280F69
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEC17754;
	Mon, 21 Aug 2023 23:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDE1ADF5
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA3133
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659416; x=1724195416;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Icqp0ptiYQY1altdIQOTFW55jPhSyb+cNRb1xnazPiU=;
  b=C4jaXWVDSVlL6NDuPa8BJ80E1eBpYs1+ZZ0fHM5GanZ91QzYpTnoofXe
   EbpCS/yFMsbHsT1VWxtK85/Sco1iKUKW3j9uDYFquyx/Lo/0g8BQktcqW
   HGOlGVWPhFuGTgQpJsbYjw71z9KP//l9CGgyT2sYSnMHr9NHQ2zQL4dc/
   aXd/G3kGdaAH1O6pCgCDh2+SF5jcqjVNCarjctcMpZbBF9XUryrUmx1IR
   uuaGg2dNQ95YfmaphxM9gJ7B5q9rNK2bIgg0oaD2vrlSnnPoTqN8Cueug
   ea9pOVF5aK84dapemF1pvLevqeQLyx/VuuievR9p6zTiFMHsjYDwColjf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358707650"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="358707650"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739086017"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="739086017"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 16:10:13 -0700
Subject: [net-next PATCH v2 2/9] ice: Add support in the driver for
 associating napi with queue[s]
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:20 -0700
Message-ID: <169266032008.10199.14729078556224584827.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 201570cd2e0b..c2b9a25db139 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2461,6 +2461,12 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
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
@@ -2940,6 +2946,57 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
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
+	int ret = 0;
+
+	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		ret = netif_napi_add_queue(&q_vector->napi, rx_ring->q_index,
+					   QUEUE_RX);
+		if (ret)
+			return ret;
+	}
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		ret = netif_napi_add_queue(&q_vector->napi, tx_ring->q_index,
+					   QUEUE_TX);
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
  * ice_vsi_release - Delete a VSI and free its resources
  * @vsi: the VSI being removed
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index f24f5d1e6f9c..21d164ac1eed 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -91,6 +91,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
+int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector);
+
+int ice_vsi_add_napi_queues(struct ice_vsi *vsi);
+
 int ice_vsi_release(struct ice_vsi *vsi);
 
 void ice_vsi_close(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8286adae946..bb6be2182a7f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3374,9 +3374,11 @@ static void ice_napi_add(struct ice_vsi *vsi)
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


