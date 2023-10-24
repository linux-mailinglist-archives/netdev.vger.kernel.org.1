Return-Path: <netdev+bounces-43831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBFA7D4EF2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA464281769
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE4266CB;
	Tue, 24 Oct 2023 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1VAN4L/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A9266A4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:35:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F4D7A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147309; x=1729683309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUcJvgJWXQWcfwHNkkMbqspEbu1ht2Z3DPxFpq8iD7c=;
  b=T1VAN4L/DMAHlBAfmbMQcsZ3Rf6CnV1vEwZGK8ZUeTg9ET5Efx2gRZH6
   bZER1bWgfIB5czuyZxMSo181zBzhcaXaoumZTbJa/UmwH9BGrEk4XnFKt
   rfa2z7MsJ0IsTIQWSaiYyNKQ2/ZWJQWkmmg/VOoG+8VIjVVZsmRelrlKu
   dR/kSMfzUx9/GZlceJgCvjCVYRoq3leD1Hff6iN/Rdo9v4uZDyKjZWrkC
   iEqeprOBuc+lMLI/SOjZ0/gbo7Z7zTOJZ0HX+Oj+EOhMfy2JJaFDyRtJr
   mc80kqJ1xHcDSZ2XRAml4CiIGb0/6gZ11axq8jqItqiRi+4m/lB4c2nDj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660564"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660564"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146223"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:49 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 12/15] ice: realloc VSI stats arrays
Date: Tue, 24 Oct 2023 13:09:26 +0200
Message-ID: <20231024110929.19423-13-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously only case when queues amount is lower was covered. Implement
realloc for case when queues amount is higher than previous one. Use
krealloc() function and zero new allocated elements.

It has to be done before ice_vsi_def_cfg(), because stats element for
ring is set there.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 58 ++++++++++++++++--------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 85a8cb28a489..d826b5afa143 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3076,27 +3076,26 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 }
 
 /**
- * ice_vsi_realloc_stat_arrays - Frees unused stat structures
+ * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
  * @vsi: VSI pointer
- * @prev_txq: Number of Tx rings before ring reallocation
- * @prev_rxq: Number of Rx rings before ring reallocation
  */
-static void
-ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi, int prev_txq, int prev_rxq)
+static int
+ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 {
+	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
+	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
+	u16 prev_txq = vsi->alloc_txq;
+	u16 prev_rxq = vsi->alloc_rxq;
 	int i;
 
-	if (!prev_txq || !prev_rxq)
-		return;
-	if (vsi->type == ICE_VSI_CHNL)
-		return;
-
 	vsi_stat = pf->vsi_stats[vsi->idx];
 
-	if (vsi->num_txq < prev_txq) {
-		for (i = vsi->num_txq; i < prev_txq; i++) {
+	if (req_txq < prev_txq) {
+		for (i = req_txq; i < prev_txq; i++) {
 			if (vsi_stat->tx_ring_stats[i]) {
 				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
 				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
@@ -3104,14 +3103,36 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi, int prev_txq, int prev_rxq)
 		}
 	}
 
-	if (vsi->num_rxq < prev_rxq) {
-		for (i = vsi->num_rxq; i < prev_rxq; i++) {
+	tx_ring_stats = vsi_stat->rx_ring_stats;
+	vsi_stat->tx_ring_stats =
+		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
+			       sizeof(*vsi_stat->tx_ring_stats),
+			       GFP_KERNEL | __GFP_ZERO);
+	if (!vsi_stat->tx_ring_stats) {
+		vsi_stat->tx_ring_stats = tx_ring_stats;
+		return -ENOMEM;
+	}
+
+	if (req_rxq < prev_rxq) {
+		for (i = req_rxq; i < prev_rxq; i++) {
 			if (vsi_stat->rx_ring_stats[i]) {
 				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
 				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
 			}
 		}
 	}
+
+	rx_ring_stats = vsi_stat->rx_ring_stats;
+	vsi_stat->rx_ring_stats =
+		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
+			       sizeof(*vsi_stat->rx_ring_stats),
+			       GFP_KERNEL | __GFP_ZERO);
+	if (!vsi_stat->rx_ring_stats) {
+		vsi_stat->rx_ring_stats = rx_ring_stats;
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /**
@@ -3128,9 +3149,9 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 {
 	struct ice_vsi_cfg_params params = {};
 	struct ice_coalesce_stored *coalesce;
-	int ret, prev_txq, prev_rxq;
 	int prev_num_q_vectors = 0;
 	struct ice_pf *pf;
+	int ret;
 
 	if (!vsi)
 		return -EINVAL;
@@ -3149,8 +3170,9 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
 
-	prev_txq = vsi->num_txq;
-	prev_rxq = vsi->num_rxq;
+	ret = ice_vsi_realloc_stat_arrays(vsi);
+	if (ret)
+		goto err_vsi_cfg;
 
 	ice_vsi_decfg(vsi);
 	ret = ice_vsi_cfg_def(vsi, &params);
@@ -3168,8 +3190,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 		return ice_schedule_reset(pf, ICE_RESET_PFR);
 	}
 
-	ice_vsi_realloc_stat_arrays(vsi, prev_txq, prev_rxq);
-
 	ice_vsi_rebuild_set_coalesce(vsi, coalesce, prev_num_q_vectors);
 	kfree(coalesce);
 
-- 
2.41.0


