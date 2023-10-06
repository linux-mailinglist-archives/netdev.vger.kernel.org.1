Return-Path: <netdev+bounces-38495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8B37BB3A7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C4928207A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD33DF78;
	Fri,  6 Oct 2023 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjPSAJBx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325A4C94
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:59:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CA3A6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696582762; x=1728118762;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prgz0NWF3GjOj7SjC0aGQXw73//z9vwfcJ5H6ZuQrEQ=;
  b=MjPSAJBxjYnSuMZzmCCZxGfxVhsNhF3lnIpcq/5u4n9hxYv3bE158P58
   ir6VcXIeK/5znuOJ5rwJiJYDnF5yAEXImWefk8hGkCRSRAkqpq5g7bCgP
   ieE4nF3Y0BjzQgra25P+MW7TQaD5U+FVHbnNgDcRG77dq2AezNfeW7zrP
   2T/wKj4zR3JGHMsOj5JoMi8qD1MzghXJXXr/gFit8cE/MRpDze9IrR95v
   EwBcxs7+++o7y4FChLdwkUj9mp90VYPum72FvbJiXKT+zAANxcTbkQLIe
   2Bp3QWZuygp/vkv+4pQHHFcDpRs+2J7atf0b29sc/CcxOLCs/EykwcyX8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447897877"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447897877"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895813101"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895813101"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 01:57:40 -0700
Subject: [net-next PATCH v4 03/10] ice: Add support in the driver for
 associating queue with napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 06 Oct 2023 02:14:54 -0700
Message-ID: <169658369415.3683.8283431592834529906.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After the napi context is initialized, map the napi instance
with the queue/queue-set on the corresponding irq line.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |   59 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
 drivers/net/ethernet/intel/ice/ice_main.c |    4 +-
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index acc3ffc940e7..f2554ecdd2bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2448,6 +2448,12 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
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
@@ -2927,6 +2933,59 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
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
+		ret = netif_queue_set_napi(rx_ring->q_index,
+					   NETDEV_QUEUE_TYPE_RX,
+					   &q_vector->napi);
+		if (ret)
+			return ret;
+	}
+	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
+		ret = netif_queue_set_napi(tx_ring->q_index,
+					   NETDEV_QUEUE_TYPE_TX,
+					   &q_vector->napi);
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
index c726913bc635..059397d07e69 100644
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


