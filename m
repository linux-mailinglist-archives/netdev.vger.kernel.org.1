Return-Path: <netdev+bounces-74045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BA85FB9A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1181F25AC5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89DC14A094;
	Thu, 22 Feb 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b01UIBtj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB91474D4
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613439; cv=none; b=YnMmnVNXwyddPmJy2gJ2LYpeg40zQy3NGpJ6KAtaevFrOtBQy+PWbu7zELHjbOlE8YzclGqhV9ZmdQYQJtY+/6xcbnrD/rdR7/WzBrDxdxQnp8tpskQgOpIvPjF4EfRoJKdtHYz0YKSbz2AE13Zq7MdEISjuX7rXNoSpnh+a7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613439; c=relaxed/simple;
	bh=9ltIlHFtQ/B9aDC7Wb4gqDk5rk8GxOMve1JyJc0Ftgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6cflWGY3pq0XXA3WaJILOtrYllO8kOEDJelMv3JxDKCmugtEZIgXHB57eHvA2Lvis/MK5YhetliJMNGfUrwzJ3xp4ha13ped5gquu+LlAjwwxEJPUVG/I9r/V37SIbA+8pQFncr+JXslbSAHebqnbL7JZMPogcdu4L1QJOad64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b01UIBtj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708613438; x=1740149438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ltIlHFtQ/B9aDC7Wb4gqDk5rk8GxOMve1JyJc0Ftgo=;
  b=b01UIBtjOUR7bijvd5TEfK7dKXLoq2e2mgT4XsoFMcQZ1E0R44lYIM5y
   F+AuAFpAguEAVY81iPO/8vuwjLUjx5SGE2rt1ppK1220mi6HoB42xlE8t
   8acm0VupPE/oW5txP33G6ohglbHnoA+8jAjcL48CBZFcMxvA0SJWp9E1g
   NKh3t2cL2gdZ9Sdbzur7dfXPkAcU1YyrT/6hoJtxfqOcFVEnR39n9X/7d
   ZmJtU0C78+U8+xzq+i/sWf3CHCfrpxihWFzqFKwYXFhGLeO2SsDUwr86U
   Ln8tp6I/TIT+2Uhz57C4ZKQMbCJndEWoE3j6GEZPDGweZaWO8icclGigM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2949313"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2949313"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5670967"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 22 Feb 2024 06:50:36 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-next 3/3] ixgbe: pull out stats update to common routines
Date: Thu, 22 Feb 2024 15:50:25 +0100
Message-Id: <20240222145025.722515-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
References: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ixgbe_update_{r,t}x_ring_stats() that will be used by both
standard and ZC datapath.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 54 ++++++++++++++-----
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  7 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 17 ++----
 3 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c7..ee0321db61f8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1105,6 +1105,44 @@ static int ixgbe_tx_maxrate(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ixgbe_update_tx_ring_stats - Update Tx ring specific counters
+ * @tx_ring: ring to update
+ * @q_vector: queue vector ring belongs to
+ * @pkts: number of processed packets
+ * @bytes: number of processed bytes
+ */
+void ixgbe_update_tx_ring_stats(struct ixgbe_ring *tx_ring,
+				struct ixgbe_q_vector *q_vector, u64 pkts,
+				u64 bytes)
+{
+	u64_stats_update_begin(&tx_ring->syncp);
+	tx_ring->stats.bytes += bytes;
+	tx_ring->stats.packets += pkts;
+	u64_stats_update_end(&tx_ring->syncp);
+	q_vector->tx.total_bytes += bytes;
+	q_vector->tx.total_packets += pkts;
+}
+
+/**
+ * ixgbe_update_rx_ring_stats - Update Rx ring specific counters
+ * @rx_ring: ring to update
+ * @q_vector: queue vector ring belongs to
+ * @pkts: number of processed packets
+ * @bytes: number of processed bytes
+ */
+void ixgbe_update_rx_ring_stats(struct ixgbe_ring *rx_ring,
+				struct ixgbe_q_vector *q_vector, u64 pkts,
+				u64 bytes)
+{
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.bytes += bytes;
+	rx_ring->stats.packets += pkts;
+	u64_stats_update_end(&rx_ring->syncp);
+	q_vector->rx.total_bytes += bytes;
+	q_vector->rx.total_packets += pkts;
+}
+
 /**
  * ixgbe_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: structure containing interrupt and ring information
@@ -1207,12 +1245,8 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 
 	i += tx_ring->count;
 	tx_ring->next_to_clean = i;
-	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->stats.bytes += total_bytes;
-	tx_ring->stats.packets += total_packets;
-	u64_stats_update_end(&tx_ring->syncp);
-	q_vector->tx.total_bytes += total_bytes;
-	q_vector->tx.total_packets += total_packets;
+	ixgbe_update_tx_ring_stats(tx_ring, q_vector, total_packets,
+				   total_bytes);
 	adapter->tx_ipsec += total_ipsec;
 
 	if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
@@ -2429,12 +2463,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		ixgbe_xdp_ring_update_tail_locked(ring);
 	}
 
-	u64_stats_update_begin(&rx_ring->syncp);
-	rx_ring->stats.packets += total_rx_packets;
-	rx_ring->stats.bytes += total_rx_bytes;
-	u64_stats_update_end(&rx_ring->syncp);
-	q_vector->rx.total_packets += total_rx_packets;
-	q_vector->rx.total_bytes += total_rx_bytes;
+	ixgbe_update_rx_ring_stats(rx_ring, q_vector, total_rx_packets,
+				   total_rx_bytes);
 
 	return total_rx_packets;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index f1f69ce67420..78deea5ec536 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -46,4 +46,11 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 int ixgbe_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
 void ixgbe_xsk_clean_tx_ring(struct ixgbe_ring *tx_ring);
 
+void ixgbe_update_tx_ring_stats(struct ixgbe_ring *tx_ring,
+				struct ixgbe_q_vector *q_vector, u64 pkts,
+				u64 bytes);
+void ixgbe_update_rx_ring_stats(struct ixgbe_ring *rx_ring,
+				struct ixgbe_q_vector *q_vector, u64 pkts,
+				u64 bytes);
+
 #endif /* #define _IXGBE_TXRX_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 59798bc33298..d34d715c59eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -359,12 +359,8 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		ixgbe_xdp_ring_update_tail_locked(ring);
 	}
 
-	u64_stats_update_begin(&rx_ring->syncp);
-	rx_ring->stats.packets += total_rx_packets;
-	rx_ring->stats.bytes += total_rx_bytes;
-	u64_stats_update_end(&rx_ring->syncp);
-	q_vector->rx.total_packets += total_rx_packets;
-	q_vector->rx.total_bytes += total_rx_bytes;
+	ixgbe_update_rx_ring_stats(rx_ring, q_vector, total_rx_packets,
+				   total_rx_bytes);
 
 	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
 		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
@@ -499,13 +495,8 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 	}
 
 	tx_ring->next_to_clean = ntc;
-
-	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->stats.bytes += total_bytes;
-	tx_ring->stats.packets += total_packets;
-	u64_stats_update_end(&tx_ring->syncp);
-	q_vector->tx.total_bytes += total_bytes;
-	q_vector->tx.total_packets += total_packets;
+	ixgbe_update_tx_ring_stats(tx_ring, q_vector, total_packets,
+				   total_bytes);
 
 	if (xsk_frames)
 		xsk_tx_completed(pool, xsk_frames);
-- 
2.34.1


