Return-Path: <netdev+bounces-35094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30307A6E8C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36A71C20A94
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D833B285;
	Tue, 19 Sep 2023 22:15:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32243B797
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C3E5
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161733; x=1726697733;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6l+VlVuyG8bxCzRSnpu/gPQwSU+aw7PVTXnSDC6j0v0=;
  b=lllDYdWhJG1WceKWpUh4NYA/Mxc2h7siJTccaUmaEar7j0V2rw28Nnr5
   AEYuqrXWhyJPk+V/r1/zE00jWvQVwBnT3Ck8dkoxyn+4qQU6PWXEmj3i4
   L+C/q0zHacMKL10U7WTU8uY2kvPdKVue01KyrAUVWTdMevSx151Y92T9k
   TlwOXcmNbL8KLRDzm2QYtf5rbpdJVfQW2wTfxnnzIafEJCC/untVJMRid
   8bEQLImhDaePDj8lMUgZDwY6PoNDSDNIXumfhM50hlPQwxIpjXSx9Ads0
   XfYGNqyhaWlqcQsq3l4AKnn43LLBzNMWHD3fPzmOZuYniNN4HjGEYio3h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="382813044"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="382813044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="1077162472"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="1077162472"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2023 15:12:02 -0700
Subject: [net-next PATCH v3 03/10] ice: Add support in the driver for
 associating queue with napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:27:31 -0700
Message-ID: <169516245130.7377.11908359746609369002.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After the napi context is initialized, map the napi instance
with the queue/queue-set on the corresponding irq line.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |   57 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
 drivers/net/ethernet/intel/ice/ice_main.c |    4 ++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 01aa3d36b5a7..df1906566185 100644
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
+					   NETDEV_QUEUE_TYPE_RX);
+		if (ret)
+			return ret;
+	}
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		ret = netif_napi_add_queue(&q_vector->napi, tx_ring->q_index,
+					   NETDEV_QUEUE_TYPE_TX);
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
index b73d3b1e48d1..140e0e22021d 100644
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


