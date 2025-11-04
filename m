Return-Path: <netdev+bounces-235328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359DC2EB33
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C70189A5CA
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66422222B6;
	Tue,  4 Nov 2025 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+W0KCrW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086021CC6A
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218446; cv=none; b=tqNiMvn2uQwHxSSSvk3o0p7XUIcQyuXw0Ib9I8PQhdByQLC0uhjY3Qov+tK70yoDbdC4DCDlWfCFHkKYhfuU08zvKSTV34tYo34GC+xDDFvPgsYU146K5rYqOEkC+MfSQhC/NGlteM8Xdxmc/7HEkies6nCahM5/ungVNgZAyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218446; c=relaxed/simple;
	bh=sAciYumvB+M1glL/CFtE2lxzzn9b0I6ctiSY6CZ1slM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULTA5HsPlttM2/8e72B78+T06R4ziwMc8ULzmVZxqcGw+zHRF2ZWpgNZqdCXTcT7j2QPZ0wc0/VepVMzhL/JnsREEh/al8HCu4J84+uEE/HPgtPxWnvg0yK8TuZuoMaw5omJ69n32zgCEQCtdor9gqoR+v+LQZMqKp6jYIVgJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+W0KCrW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218445; x=1793754445;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sAciYumvB+M1glL/CFtE2lxzzn9b0I6ctiSY6CZ1slM=;
  b=Z+W0KCrWPNsWNO6RqP8VzqhD2y5u5yAokbqJWE5HtCohDeSmyOjg7bbc
   k7Ke9asH4o5H6faNpldYdlhApxcmBKvKYgGqtbyr8yl2WZhz9/BL/91bZ
   iCJwcnKAsIBaDFhqWKOA29gUezMbMnyro73/a5NIBZe6FoIb6cF40ly6x
   bngtV82DL2Kyjzseafhn6h5ym3G0FcM5kA0UVP3cyW0H5ZvsLj9VYS9CK
   7es2+q/lLZ3TctNS8J8mPS7RUcFYCSMLOfL7d4cqfdViaoCnunJ2kYPWr
   beuYnX3H2ewKz/QPr41TA+9sB+iiWlhT2f/KgZJxiTPrEj+zQccohfC/w
   w==;
X-CSE-ConnectionGUID: 7lYLHtvcRLGn6J7Q0eioQA==
X-CSE-MsgGUID: LsrpcaAtQfWRxYJ+8Fxibw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75656565"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75656565"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:18 -0800
X-CSE-ConnectionGUID: lpBghXs5S12bYnIlMTTd/Q==
X-CSE-MsgGUID: AZTaFQy4RmW/v3SJDkMiyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="217828775"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:17 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Nov 2025 17:06:53 -0800
Subject: [PATCH iwl-next 8/9] ice: shorten ring stat names and add
 accessors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-jk-refactor-queue-stats-v1-8-164d2ed859b6@intel.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=9638;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sAciYumvB+M1glL/CFtE2lxzzn9b0I6ctiSY6CZ1slM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzOwENSFrlmin/q9TJfLr1ms1PP7aqkkmjEVoMnNZfPK
 yz5umhFRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNJcmT4w7vRcVXAjLX3rN/s
 dl2+Qnha2fy9Cfp3D+cLfTIKKBNbpsLI8P3lxK/ZHr9vPLuuI9UlEVw+UaHr/3Omvbzlspf0exN
 8OAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 52 +++++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 12 +++----
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +--
 6 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 8586d5bebac7..cf3656dc560c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -129,18 +129,6 @@ struct ice_tx_offload_params {
 	u8 header_len;
 };
 
-struct ice_txq_stats {
-	u64 restart_q;
-	u64 tx_busy;
-	u64 tx_linearize;
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
@@ -148,12 +136,48 @@ struct ice_ring_stats {
 		u64 pkts;
 		u64 bytes;
 		union {
-			struct ice_txq_stats tx_stats;
-			struct ice_rxq_stats rx_stats;
+			struct_group(tx,
+				u64 tx_restart_q;
+				u64 tx_busy;
+				u64 tx_linearize;
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
+ * @member: the ice_string_stats member to increment
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
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5a3bcbb5f63c..885e85f478d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -159,7 +159,7 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * prev_pkt would be negative if there was no
 			 * pending work.
 			 */
-			packets = ring_stats->stats.pkts & INT_MAX;
+			packets = ice_stats_read(ring_stats, pkts) & INT_MAX;
 			if (tx_ring->prev_pkt == packets) {
 				/* Trigger sw interrupt to revive the queue */
 				ice_trigger_sw_intr(hw, tx_ring->q_vector);
@@ -6869,9 +6869,9 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
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
 
@@ -6913,8 +6913,8 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
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
index f0f5133c389f..ddd40c87772a 100644
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
2.51.0.rc1.197.g6d975e95c9d7


