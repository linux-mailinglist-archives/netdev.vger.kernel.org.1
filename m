Return-Path: <netdev+bounces-235326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA847C2EB36
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D582E3BA03E
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D62036ED;
	Tue,  4 Nov 2025 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2RmGFl2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619292192EA
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218446; cv=none; b=d571x3gP14foZFVg7NRmMd4rshue4Lg54Pw/E8pdMJfO1OVZs+f3ogXX6qal/XWfkGW7AutrjgQAEtijhqRILTRxzC/w3Anyzss/GnDyv5SzO+mDapt7ci1tmV8oh27OGjpuNRf7VuZx9vPu2gvQU65mXi/cRuA4zXLuK8jQ2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218446; c=relaxed/simple;
	bh=ADMo9Qqo1+mGJUs7OYACRtvA0GchXlHUsWj5/HrWtnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLxyfHVVEQulMPuFlv2ugqVhkvYjmElYl5uaiG1f3I0ChYkzj6vTANiQZOGji0YKUGBOZjZFXouSRGb6YRqRthqu/7KFrqDgBRFmTkQ0a90ltZlKxgcIEXTRhZZ08icusg780mhHnOy4jWjjbdiN55UbR6UEukFSyo449dRBLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2RmGFl2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218445; x=1793754445;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ADMo9Qqo1+mGJUs7OYACRtvA0GchXlHUsWj5/HrWtnQ=;
  b=J2RmGFl2mCG0ob3zJpXs/c5w18dYsICYS1CMrPZZkvkWLG8PeEaxLXv1
   NErqSZP4awoq1Ca2Jv3oU6bPvJkzYDFlxhU4rUfgoqKsF62+yqP2MnbY4
   k25toSO3eTZ7W0ZB61ZG7vL5fDTNvIYnOgUKHkK7TmVmSyM25Vpun1MhN
   lZLOYkeOCwFXTNFXT2ycaQ5Im1FxGHDIw/NFOko/06lrZubDgWMYxu7W7
   nQPZWpsuznfsa3/xAXm0/EiZ+vcmqqkSRT6Nt6j57taetf1ZeqS07VVZ0
   nnCOx3Nn7q8Au+uV5Mrwnhv3H3i/2y9Otno2Fd1IOOdrivCGmZoHFtciM
   w==;
X-CSE-ConnectionGUID: lXb9mYcWR0Sjgy2GLZ87RA==
X-CSE-MsgGUID: FSCgGG7aQWq3LLEGDxtv0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75656563"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75656563"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:18 -0800
X-CSE-ConnectionGUID: rPSFeoxLRSmbVz86gZoHuw==
X-CSE-MsgGUID: czLgITI+TfGQLpaEwNZTsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="217828768"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:16 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Nov 2025 17:06:51 -0800
Subject: [PATCH iwl-next 6/9] ice: remove ice_q_stats struct and use
 struct_group
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-jk-refactor-queue-stats-v1-6-164d2ed859b6@intel.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=5182;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ADMo9Qqo1+mGJUs7OYACRtvA0GchXlHUsWj5/HrWtnQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzOwIOPpHhYOyOOK/yxyXJly/wltvvhtstrt0zbdG3mp
 L+xEQ5yHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExk/VZGhmnVsbqSV1qu3BZe
 nmn567/p5YaZbzynT5qecI39Wl/yLT2Gf3Yn3j+NP9P07+iuO/qzS7pVSzuvBZg9m8pg/6XH9IX
 AekYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice_qp_reset_stats function resets the stats for all rings on a VSI. It
currently behaves differently for Tx and Rx rings. For Rx rings, it only
clears the rx_stats which do not include the pkt and byte counts. For Tx
rings and XDP rings, it clears only the pkt and byte counts.

We could add extra memset calls to cover both the stats and relevant
tx/rx stats fields. Instead, lets convert stats into a struct_group which
contains both the pkts and bytes fields as well as the Tx or Rx stats, and
remove the ice_q_stats structure entirely.

The only remaining user of ice_q_stats is the ice_q_stats_len function in
ice_ethtool.c, which just counts the number of fields. Replace this with a
simple multiplication by 2. I find this to be simpler to reason about than
relying on knowing the layout of the ice_q_stats structure.

Now that the stats field of the ice_ring_stats covers all of the statistic
values, the ice_qp_reset_stats function will properly zero out all of the
fields.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 18 ++++++++----------
 drivers/net/ethernet/intel/ice/ice_base.c    |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++++---
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index f1fe1775baed..8586d5bebac7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -129,11 +129,6 @@ struct ice_tx_offload_params {
 	u8 header_len;
 };
 
-struct ice_q_stats {
-	u64 pkts;
-	u64 bytes;
-};
-
 struct ice_txq_stats {
 	u64 restart_q;
 	u64 tx_busy;
@@ -148,12 +143,15 @@ struct ice_rxq_stats {
 
 struct ice_ring_stats {
 	struct rcu_head rcu;	/* to avoid race on free */
-	struct ice_q_stats stats;
 	struct u64_stats_sync syncp;
-	union {
-		struct ice_txq_stats tx_stats;
-		struct ice_rxq_stats rx_stats;
-	};
+	struct_group(stats,
+		u64 pkts;
+		u64 bytes;
+		union {
+			struct ice_txq_stats tx_stats;
+			struct ice_rxq_stats rx_stats;
+		};
+	);
 };
 
 enum ice_ring_state_t {
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index eadb1e3d12b3..afbff8aa9ceb 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -1414,8 +1414,8 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 	if (!vsi_stat)
 		return;
 
-	memset(&vsi_stat->rx_ring_stats[q_idx]->rx_stats, 0,
-	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
+	memset(&vsi_stat->rx_ring_stats[q_idx]->stats, 0,
+	       sizeof(vsi_stat->rx_ring_stats[q_idx]->stats));
 	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
 	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
 	if (vsi->xdp_rings)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a1d9abee97e5..0bc6f31a2b06 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -33,8 +33,8 @@ static int ice_q_stats_len(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
-	return ((np->vsi->alloc_txq + np->vsi->alloc_rxq) *
-		(sizeof(struct ice_q_stats) / sizeof(u64)));
+	/* One packets and one bytes count per queue */
+	return ((np->vsi->alloc_txq + np->vsi->alloc_rxq) * 2);
 }
 
 #define ICE_PF_STATS_LEN	ARRAY_SIZE(ice_gstrings_pf_stats)
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e7265e877703..c6dd297582c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3437,7 +3437,8 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc)
  *
  * This function assumes that caller has acquired a u64_stats_sync lock.
  */
-static void ice_update_ring_stats(struct ice_q_stats *stats, u64 pkts, u64 bytes)
+static void ice_update_ring_stats(struct ice_ring_stats *stats,
+				  u64 pkts, u64 bytes)
 {
 	stats->bytes += bytes;
 	stats->pkts += pkts;
@@ -3452,7 +3453,7 @@ static void ice_update_ring_stats(struct ice_q_stats *stats, u64 pkts, u64 bytes
 void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&tx_ring->ring_stats->syncp);
-	ice_update_ring_stats(&tx_ring->ring_stats->stats, pkts, bytes);
+	ice_update_ring_stats(tx_ring->ring_stats, pkts, bytes);
 	u64_stats_update_end(&tx_ring->ring_stats->syncp);
 }
 
@@ -3465,7 +3466,7 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 void ice_update_rx_ring_stats(struct ice_rx_ring *rx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&rx_ring->ring_stats->syncp);
-	ice_update_ring_stats(&rx_ring->ring_stats->stats, pkts, bytes);
+	ice_update_ring_stats(rx_ring->ring_stats, pkts, bytes);
 	u64_stats_update_end(&rx_ring->ring_stats->syncp);
 }
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


