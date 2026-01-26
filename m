Return-Path: <netdev+bounces-253614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHkwExjud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:43:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AED8E018
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3EF30304B7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606230AAD4;
	Mon, 26 Jan 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFcBx8aA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27230AD00
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467404; cv=none; b=pOb9myk/P7ALdD+Wr7Vze1g/n/+QQlwb9PrwnAcGCWPhdp56hdWlh8P6BFVV0qtfvCQgNh2NLXprh/9em0tmNkXX0MYAsUrvasd21tVchqu1gW8l7jpmdA97T4vkfoyqcxn7CtqPNbqFUKp6FDbUWA8Sd1CSXfFp5TG1hUsWhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467404; c=relaxed/simple;
	bh=6/tlFi1Atcij6BK2jy+rlwzroVC2nMYG1OEZODQdyAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDMQfvlUIFHDH/3EYl+HRXEf04fJM383x/XUlnL5DKtxcYr5qOw+gyiFTEAQlWMneGDrz4kaPf+mwZKhCy2ZCEhLY/a8HwBRPS8VkurkN9GTu59Oo/9vh7rVPK2G43zjmi7UkmVNnri6kReqXiiffWgFV6D3lT5hWSX0NeogY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFcBx8aA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467403; x=1801003403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/tlFi1Atcij6BK2jy+rlwzroVC2nMYG1OEZODQdyAA=;
  b=CFcBx8aAiSaa+dhSblgb/94NtD2RLdT/rbintaMpaAqmNy9HDeysN2t0
   XsVkMXM859/xzbi74pW9uwbDq4ZvmQkpVHiWaBR9agu0Fkhw2MTg5jZ3Z
   BeYmyT6Z48loMMi/GuW1FzUNsxfPErGq/AnplrEA3/Ztfm9bA5AWeeTuv
   Kj7XAJNOSYQLt+IRK35N1hKUaknefd4TJUj5o8qQa8GWbz8HgK954eI0i
   Qy4fM847hsH3zZL+yE7kUbZqujhePwVqIbRVEqMLxUMCJkXVIm+z3leC7
   ZY+7mHYF+gGKXQyCgL3iDhQvc5Q85pxWhfe5+3pTalF1GQ1I7whQc9OSq
   g==;
X-CSE-ConnectionGUID: dMsndxsHRM+u5Fe2JFXb2w==
X-CSE-MsgGUID: hhynniA/Q+KmMNAuXCu0rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369396"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369396"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:22 -0800
X-CSE-ConnectionGUID: s2Ml9F91Rt2+s7oRTYRwMw==
X-CSE-MsgGUID: fTzMhCrqQ9yuqGN8pmbfQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754291"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:21 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 4/7] ice: shorten ring stat names and add accessors
Date: Mon, 26 Jan 2026 14:43:08 -0800
Message-ID: <20260126224313.3847849-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
References: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253614-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9AED8E018
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

The ice Tx/Rx hotpath has a few statistics counters for tracking unexpected
events. These values are stored as u64 but are not accumulated using the
u64_stats API. This could result in load/tear stores on some architectures.
Even some 64-bit architectures could have issues since the fields are not
read or written using ACCESS_ONCE or READ_ONCE.

A following change is going to refactor the stats accumulator code to use
the u64_stats API for all of these stats, and to use u64_stats_read and
u64_stats_inc properly to prevent load/store tears on all architectures.

Using u64_stats_inc and the syncp pointer is slightly verbose and would be
duplicated in a number of places in the Tx and Rx hot path. Add accessor
macros for the cases where only a single stat value is touched at once. To
keep lines short, also shorten the stats names and convert ice_txq_stats
and ice_rxq_stats to struct_group.

This will ease the transition to properly using the u64_stats API in the
following change.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 16 +++---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 16 +++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 55 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
 6 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6dc22e811ae5..ced6ad86c8b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -159,8 +159,8 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * prev_pkt would be negative if there was no
 			 * pending work.
 			 */
-			packets = ring_stats->stats.pkts & INT_MAX;
-			if (ring_stats->tx_stats.prev_pkt == packets) {
+			packets = ice_stats_read(ring_stats, pkts) & INT_MAX;
+			if (ring_stats->tx.prev_pkt == packets) {
 				/* Trigger sw interrupt to revive the queue */
 				ice_trigger_sw_intr(hw, tx_ring->q_vector);
 				continue;
@@ -170,7 +170,7 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * to ice_get_tx_pending()
 			 */
 			smp_rmb();
-			ring_stats->tx_stats.prev_pkt =
+			ring_stats->tx.prev_pkt =
 			    ice_get_tx_pending(tx_ring) ? packets : -1;
 		}
 	}
@@ -6867,9 +6867,9 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
 		ice_fetch_u64_stats_per_ring(ring->ring_stats, &pkts, &bytes);
 		vsi_stats->tx_packets += pkts;
 		vsi_stats->tx_bytes += bytes;
-		vsi->tx_restart += ring->ring_stats->tx_stats.restart_q;
-		vsi->tx_busy += ring->ring_stats->tx_stats.tx_busy;
-		vsi->tx_linearize += ring->ring_stats->tx_stats.tx_linearize;
+		vsi->tx_restart += ring->ring_stats->tx_restart_q;
+		vsi->tx_busy += ring->ring_stats->tx_busy;
+		vsi->tx_linearize += ring->ring_stats->tx_linearize;
 	}
 }
 
@@ -6911,8 +6911,8 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		ice_fetch_u64_stats_per_ring(ring_stats, &pkts, &bytes);
 		vsi_stats->rx_packets += pkts;
 		vsi_stats->rx_bytes += bytes;
-		vsi->rx_buf_failed += ring_stats->rx_stats.alloc_buf_failed;
-		vsi->rx_page_failed += ring_stats->rx_stats.alloc_page_failed;
+		vsi->rx_buf_failed += ring_stats->rx_buf_failed;
+		vsi->rx_page_failed += ring_stats->rx_page_failed;
 	}
 
 	/* update XDP Tx rings counters */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f4196347b23a..eea83b26b094 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -379,7 +379,7 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 		if (netif_tx_queue_stopped(txring_txq(tx_ring)) &&
 		    !test_bit(ICE_VSI_DOWN, vsi->state)) {
 			netif_tx_wake_queue(txring_txq(tx_ring));
-			++tx_ring->ring_stats->tx_stats.restart_q;
+			ice_stats_inc(tx_ring->ring_stats, tx_restart_q);
 		}
 	}
 
@@ -499,7 +499,7 @@ int ice_setup_tx_ring(struct ice_tx_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
-	tx_ring->ring_stats->tx_stats.prev_pkt = -1;
+	tx_ring->ring_stats->tx.prev_pkt = -1;
 	return 0;
 
 err:
@@ -849,7 +849,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 
 		addr = libeth_rx_alloc(&fq, ntu);
 		if (addr == DMA_MAPPING_ERROR) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_page_failed);
 			break;
 		}
 
@@ -863,7 +863,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 
 		addr = libeth_rx_alloc(&hdr_fq, ntu);
 		if (addr == DMA_MAPPING_ERROR) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_page_failed);
 
 			libeth_rx_recycle_slow(fq.fqes[ntu].netmem);
 			break;
@@ -1045,7 +1045,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			libeth_xdp_return_buff_slow(xdp);
-			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_buf_failed);
 			continue;
 		}
 
@@ -1363,7 +1363,7 @@ static int __ice_maybe_stop_tx(struct ice_tx_ring *tx_ring, unsigned int size)
 
 	/* A reprieve! - use start_queue because it doesn't call schedule */
 	netif_tx_start_queue(txring_txq(tx_ring));
-	++tx_ring->ring_stats->tx_stats.restart_q;
+	ice_stats_inc(tx_ring->ring_stats, tx_restart_q);
 	return 0;
 }
 
@@ -2165,7 +2165,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		if (__skb_linearize(skb))
 			goto out_drop;
 		count = ice_txd_use_count(skb->len);
-		tx_ring->ring_stats->tx_stats.tx_linearize++;
+		ice_stats_inc(tx_ring->ring_stats, tx_linearize);
 	}
 
 	/* need: 1 descriptor per page * PAGE_SIZE/ICE_MAX_DATA_PER_TXD,
@@ -2176,7 +2176,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 	 */
 	if (ice_maybe_stop_tx(tx_ring, count + ICE_DESCS_PER_CACHE_LINE +
 			      ICE_DESCS_FOR_CTX_DESC)) {
-		tx_ring->ring_stats->tx_stats.tx_busy++;
+		ice_stats_inc(tx_ring->ring_stats, tx_busy);
 		return NETDEV_TX_BUSY;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index d5ad76b25f16..e7e4991c0934 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -129,19 +129,6 @@ struct ice_tx_offload_params {
 	u8 header_len;
 };
 
-struct ice_txq_stats {
-	u64 restart_q;
-	u64 tx_busy;
-	u64 tx_linearize;
-	int prev_pkt; /* negative if no pending Tx descriptors */
-};
-
-struct ice_rxq_stats {
-	u64 non_eop_descs;
-	u64 alloc_page_failed;
-	u64 alloc_buf_failed;
-};
-
 struct ice_ring_stats {
 	struct rcu_head rcu;	/* to avoid race on free */
 	struct u64_stats_sync syncp;
@@ -149,12 +136,50 @@ struct ice_ring_stats {
 		u64 pkts;
 		u64 bytes;
 		union {
-			struct ice_txq_stats tx_stats;
-			struct ice_rxq_stats rx_stats;
+			struct_group(tx,
+				u64 tx_restart_q;
+				u64 tx_busy;
+				u64 tx_linearize;
+				/* negative if no pending Tx descriptors */
+				int prev_pkt;
+			);
+			struct_group(rx,
+				u64 rx_non_eop_descs;
+				u64 rx_page_failed;
+				u64 rx_buf_failed;
+			);
 		};
 	);
 };
 
+/**
+ * ice_stats_read - Read a single ring stat value
+ * @stats: pointer to ring_stats structure for a queue
+ * @member: the ice_ring_stats member to read
+ *
+ * Shorthand for reading a single 64-bit stat value from struct
+ * ice_ring_stats.
+ *
+ * Return: the value of the requested stat.
+ */
+#define ice_stats_read(stats, member) ({				\
+	struct ice_ring_stats *__stats = (stats);			\
+	__stats->member;						\
+})
+
+/**
+ * ice_stats_inc - Increment a single ring stat value
+ * @stats: pointer to the ring_stats structure for a queue
+ * @member: the ice_ring_stats member to increment
+ *
+ * Shorthand for incrementing a single 64-bit stat value in struct
+ * ice_ring_stats.
+ */
+#define ice_stats_inc(stats, member) do {				\
+	struct ice_ring_stats *__stats = (stats);			\
+	__stats->member++;						\
+} while (0)
+
 enum ice_ring_state_t {
 	ICE_TX_XPS_INIT_DONE,
 	ICE_TX_NBITS,
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 956da38d63b0..e68f3e5d35b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -480,7 +480,7 @@ int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 	return ICE_XDP_CONSUMED;
 
 busy:
-	xdp_ring->ring_stats->tx_stats.tx_busy++;
+	ice_stats_inc(xdp_ring->ring_stats, tx_busy);
 
 	return ICE_XDP_CONSUMED;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 6a3f10f7a53f..f17990b68b62 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -38,7 +38,7 @@ ice_is_non_eop(const struct ice_rx_ring *rx_ring,
 	if (likely(ice_test_staterr(rx_desc->wb.status_error0, ICE_RXD_EOF)))
 		return false;
 
-	rx_ring->ring_stats->rx_stats.non_eop_descs++;
+	ice_stats_inc(rx_ring->ring_stats, rx_non_eop_descs);
 
 	return true;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 989ff1fd9110..953e68ed0f9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -497,7 +497,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
 	return ICE_XDP_TX;
 
 busy:
-	xdp_ring->ring_stats->tx_stats.tx_busy++;
+	ice_stats_inc(xdp_ring->ring_stats, tx_busy);
 
 	return ICE_XDP_CONSUMED;
 }
@@ -659,7 +659,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 			xsk_buff_free(first);
 			first = NULL;
 
-			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_buf_failed);
 			continue;
 		}
 
-- 
2.47.1


