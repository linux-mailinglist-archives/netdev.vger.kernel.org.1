Return-Path: <netdev+bounces-47792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414E7EB63B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7801C20BE2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985D2FC47;
	Tue, 14 Nov 2023 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blgf5JBf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ADC26AF0
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F9135
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985726; x=1731521726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6F1S3k4EI/dNI6HMNFMtbA+Db8HM2gMMoXqQqyhT1zg=;
  b=blgf5JBfHODfk4UgdiiEgbcOUVaNS7gV4Mgx2KEc7hPJuPybpi2gXd2X
   CB001xpsh7wSnMHEVQDLdbwhXPeINlmd8L2ET/ly85GAKk44HpGQqxt1J
   s2g1m49iYCtlEuxx+VfkJGVfMRUGggQWoZmZeFxua8ozw5gikNh31eldT
   iIy41lijGOR4gguRtSUR/X0G3tVhPcH+83Q10qcPP40DCph3uJxlYkQDU
   DXW4UnvBZID/kVl31WVT1hltzu56abdhKL/lSdTZIESOwvPYwPE/R8p/u
   kyK+9CKXVipjnH8n2/WojI6ZtbZulpRS0vgC/j6QcsuPWRap5xBdaksKQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514527"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514527"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160965"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160965"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 12/15] ice: realloc VSI stats arrays
Date: Tue, 14 Nov 2023 10:14:32 -0800
Message-ID: <20231114181449.1290117-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Previously only case when queues amount is lower was covered. Implement
realloc for case when queues amount is higher than previous one. Use
krealloc() function and zero new allocated elements.

It has to be done before ice_vsi_def_cfg(), because stats element for
ring is set there.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


