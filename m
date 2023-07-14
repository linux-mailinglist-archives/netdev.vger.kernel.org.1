Return-Path: <netdev+bounces-17942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D6753A2B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D21F28233E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1013705;
	Fri, 14 Jul 2023 11:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611E13700
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:50:37 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A273030C5
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689335435; x=1720871435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O1F3TFTkGCUGmeShW0f4E1sxlThzJHkxTAUFXviFs/s=;
  b=YuRCGfjRQZJ2pq+i/Nug6fxt5kUb4vFOojfp8Mw+InscyfiWck5D8DSZ
   dTBtqZgyGQPCgABwTOWhfVZmwJWtf4VEWJ9CYxHBZSruZFJxkcq1P+GO8
   fqMmWve9PklMP1onrOGF4ADP0SCnnsSwIgbgJGoWM2irwKdadGgrQDA+t
   lWv2XkQAJJZvtYraW+drf2T8B8VP4pBuJwivMiG4ngpyx/rA8gYnGjWiM
   G001DjY2m623nsURrhx1EhZWz7Vp6jZDrYkhOtCrIg159ieQBb8UbN8Tj
   4zg0aT/6bMNn+e2QBuqLsDjb8z16Y1MAup5cMf+5x7P6VoUZrcCsEL0p8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="369004076"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="369004076"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722375530"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722375530"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 04:50:32 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5764C35804;
	Fri, 14 Jul 2023 12:50:31 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Benjamin Mikailenko <benjamin.mikailenko@intel.com>
Subject: [PATCH iwl-net] ice: Reset stats on queues num change
Date: Fri, 14 Jul 2023 07:47:21 -0400
Message-Id: <20230714114721.335526-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reset VSI stats on queues number change.

Commit 288ecf491b16 ("ice: Accumulate ring statistics over reset")
implemented functionality for interface statistics to persist over reset,
but it left stats persisting over queue count reconfiguration.

Following scenario is fixed here:
 # Observe statistics for Tx/Rx queues
ethtool -S ethX
 # change number of queues
ethtool -L ethX combined 10
 # Observe statistics for Tx/Rx queues (after reset)
ethtool -S ethX

Ben has left a note where to place the VSI stats reset,
what made this fix much easier to do.

Note that newly allocated structs (case of num_txq > prev_txq) don't
need zeroing.

Fixes: 288ecf491b16 ("ice: Accumulate ring statistics over reset")
Suggested-by: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 33 ++++++++++++++++++++----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 00e3afd507a4..09942bdea25d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3130,13 +3130,15 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 }
 
 /**
- * ice_vsi_realloc_stat_arrays - Frees unused stat structures
+ * ice_vsi_adjust_stat_arrays - Adjust VSI stat structures
  * @vsi: VSI pointer
  * @prev_txq: Number of Tx rings before ring reallocation
  * @prev_rxq: Number of Rx rings before ring reallocation
+ *
+ * Zero stat structures before reuse, free redundant ones.
  */
 static void
-ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi, int prev_txq, int prev_rxq)
+ice_vsi_adjust_stat_arrays(struct ice_vsi *vsi, int prev_txq, int prev_rxq)
 {
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
@@ -3149,7 +3151,17 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi, int prev_txq, int prev_rxq)
 
 	vsi_stat = pf->vsi_stats[vsi->idx];
 
-	if (vsi->num_txq < prev_txq) {
+	if (vsi->num_txq != prev_txq) {
+		/* first, reset structs that we will reuse */
+		int reuse_q_cnt = min_t(int, vsi->num_txq, prev_txq);
+
+		for (i = 0; i < reuse_q_cnt; i++) {
+			struct ice_ring_stats *rs = vsi_stat->tx_ring_stats[i];
+
+			if (rs)
+				memset(rs, 0, sizeof(*rs));
+		}
+		/* second, free redundant ones */
 		for (i = vsi->num_txq; i < prev_txq; i++) {
 			if (vsi_stat->tx_ring_stats[i]) {
 				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
@@ -3158,7 +3170,16 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi, int prev_txq, int prev_rxq)
 		}
 	}
 
-	if (vsi->num_rxq < prev_rxq) {
+	/* apply very same logic as for tx */
+	if (vsi->num_rxq != prev_rxq) {
+		int reuse_q_cnt = min_t(int, vsi->num_rxq, prev_rxq);
+
+		for (i = 0; i < reuse_q_cnt; i++) {
+			struct ice_ring_stats *rs = vsi_stat->rx_ring_stats[i];
+
+			if (rs)
+				memset(rs, 0, sizeof(*rs));
+		}
 		for (i = vsi->num_rxq; i < prev_rxq; i++) {
 			if (vsi_stat->rx_ring_stats[i]) {
 				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
@@ -3222,7 +3243,9 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 		return ice_schedule_reset(pf, ICE_RESET_PFR);
 	}
 
-	ice_vsi_realloc_stat_arrays(vsi, prev_txq, prev_rxq);
+	ice_vsi_adjust_stat_arrays(vsi, prev_txq, prev_rxq);
+	if (vsi->num_txq != prev_txq || vsi->num_rxq != prev_rxq)
+		vsi->stat_offsets_loaded = false;
 
 	ice_vsi_rebuild_set_coalesce(vsi, coalesce, prev_num_q_vectors);
 	kfree(coalesce);

base-commit: 9d23aac8a85f69239e585c8656c6fdb21be65695
-- 
2.40.1


