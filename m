Return-Path: <netdev+bounces-78129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8F874268
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55A8281991
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637D1BDD8;
	Wed,  6 Mar 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klMgy+h6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECB1BC2C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762826; cv=none; b=BngqE1rxmc7l8T8J2tA9yxeWuE1EDrUr8et4u4epV6pKsbI1IoP5GknUATDCwGJ9Z7z6Xiz89y8SaIMsZfmqfhd13sOKBXINy1t0u5XOyqvPGxguXcT9irLBlwOWVSa52z5DygHmFlIKKpbb7CfbSgUNbMXEz6Ho1YCYbYSfIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762826; c=relaxed/simple;
	bh=olhdBGhQA51rojTLB+NTNAlCwo0/WLbnmnMk/hQt4Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c811kYTtlSmwFfwueDzsAfSWom1nUiXuVA7aakNKyyvcZSR5FVF++C1sGhQ6FJbsZbb2s8ofsYdNsdw70ayF1hjwCLT3wcTclPQn7fhP1vh7R/hrWklnX/3qx/7eirnvV0sDbcHADZ7bCOBoxh++JK/PLrDq/isqJYMbzJkiyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klMgy+h6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709762825; x=1741298825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=olhdBGhQA51rojTLB+NTNAlCwo0/WLbnmnMk/hQt4Xo=;
  b=klMgy+h6Pffl78+QPU/WpWFEbOqt5baTJu4UQOARAAVxKwxVHe3iXMDb
   UzOxcEQHcpEcbo/J+yrFcHYoalurBn/2rDVK0hWeyrl2ZErvxXgPxh/Wy
   ho44PsRS/UxNHtB8G6BaTy7Hisuon31mGAn8LPWvJJVoRUDB7gDs11JK5
   I3l6q0WsqcP8pYqfC41OkQna4baP6ayZlAvL7NYfSeFHPxWdgDDSZDAJD
   hl/L4yz78TPdSyL/BkPB3CT8Thqz0jYZX3dCl85YvbtmS6G/5iqI/ZrUq
   c6/NdsDAELydSUNNyhM5DjvSu4D5GCF4vn9/KufdQp9mNR+K5Zs9n9V0e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4982633"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4982633"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9979678"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 13:56:20 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next 3/3] ixgbe: pull out stats update to common routines
Date: Wed,  6 Mar 2024 13:56:13 -0800
Message-ID: <20240306215615.970308-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
References: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Introduce ixgbe_update_{r,t}x_ring_stats() that will be used by both
standard and ZC datapath.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 54 ++++++++++++++-----
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  7 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 17 ++----
 3 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 595098a4c488..2e352bfcc401 100644
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
2.41.0


