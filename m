Return-Path: <netdev+bounces-186894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F41AA3CE2
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695504A488F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E784246768;
	Tue, 29 Apr 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePOH9fM2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B623184C
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970424; cv=none; b=NoM3zhMjj6InQ1LDK685b7PdHwXlz85HkmvORfuoXDbuI5k26k/KyzXZvS0Px5ms+T/r8RMRnkiwE3FkwM60uph0SFrwawen5MbdzX6+3aUlFb5vGQMsylrlwHmYh2oHmd/aUuqo/UDAW9rEMswfq4IfsNdARjOaApSIp49buZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970424; c=relaxed/simple;
	bh=F7K6GngMaa0mcxdjZaGCe6oUj9j816bO/FsXgEmFQ2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+JLWOYwZW9Ocqjfamo32L8tQMPW8qnaRRmpsxzogdEGjEn67b69Vj8d3DXOEpHvzqOuyxm95meM6nSzRLMTu/Rtx2EmvtJk9s67iWCisTlQLrE6rLTdAnvYz4GAv6rtqKSK/KYXfrpvXq5ibMtaEihDc3/Eilg1bw4befCE/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePOH9fM2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970423; x=1777506423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F7K6GngMaa0mcxdjZaGCe6oUj9j816bO/FsXgEmFQ2A=;
  b=ePOH9fM2Q5vPDNSGbJxa92ACkin/uCqGJY8pXYO014tfkPNqc+4EpWa9
   8aSw7qOQTsmkcEWu0rf/xxga7d49zYhfdOvLkm5Zfbl9iftXqDXRGDFyr
   YhV1OQJk+UHYvaz1ufGP7deVZmWfhpVTDegu2yaaTQvfIsC0r1otEiXjc
   Pn6859mvUNKcyQ5hxQ473S8UDRzx7EOdM7ZFivxCbBX5oCT/8aQgOarr+
   1A+DFmDWmH+esn3PscTXH9LKEF9r/mHKoz/AXzSXtVq+p98GSaLOAY+R2
   YSujf5AtdT0IGQIjgPjJd/kuiupLRP+PHMSUFX26dWxeWu40czHBoRmu9
   A==;
X-CSE-ConnectionGUID: nCwyKVwRSdyxiD/PPyQVUw==
X-CSE-MsgGUID: ckmoq/3ATE2d7OqQi9sqdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990086"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990086"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:01 -0700
X-CSE-ConnectionGUID: epu7HH8uRcu9R2PRfp2+cQ==
X-CSE-MsgGUID: 6viufrqZTUWvqcWyvSHJYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979618"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	bigeasy@linutronix.de,
	gerhard@engleder-embedded.com,
	jdamato@fastly.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sweta Kumari <sweta.kumari@intel.com>
Subject: [PATCH net-next 04/13] igb: Get rid of spurious interrupts
Date: Tue, 29 Apr 2025 16:46:39 -0700
Message-ID: <20250429234651.3982025-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

When running the igc with XDP/ZC in busy polling mode with deferral of hard
interrupts, interrupts still happen from time to time. That is caused by
the igb task watchdog which triggers Rx interrupts periodically.

That mechanism has been introduced to overcome skb/memory allocation
failures [1]. So the Rx clean functions stop processing the Rx ring in case
of such failure. The task watchdog triggers Rx interrupts periodically in
the hope that memory became available in the mean time.

The current behavior is undesirable for real time applications, because the
driver induced Rx interrupts trigger also the softirq processing. However,
all real time packets should be processed by the application which uses the
busy polling method.

Therefore, only trigger the Rx interrupts in case of real allocation
failures. Introduce a new flag for signaling that condition.

Follow the same logic as in commit 8dcf2c212078 ("igc: Get rid of spurious
interrupts").

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sweta Kumari <sweta.kumari@intel.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  3 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 29 +++++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  1 +
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 79eca385a751..f34ead8243e9 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -391,7 +391,8 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
 	IGB_RING_FLAG_TX_DETECT_HANG,
-	IGB_RING_FLAG_TX_DISABLED
+	IGB_RING_FLAG_TX_DISABLED,
+	IGB_RING_FLAG_RX_ALLOC_FAILED,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d9205573886e..9e9a5900e6e5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5755,11 +5755,29 @@ static void igb_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IGB_FLAG_HAS_MSIX) {
 		u32 eics = 0;
 
-		for (i = 0; i < adapter->num_q_vectors; i++)
-			eics |= adapter->q_vector[i]->eims_value;
-		wr32(E1000_EICS, eics);
+		for (i = 0; i < adapter->num_q_vectors; i++) {
+			struct igb_q_vector *q_vector = adapter->q_vector[i];
+			struct igb_ring *rx_ring;
+
+			if (!q_vector->rx.ring)
+				continue;
+
+			rx_ring = adapter->rx_ring[q_vector->rx.ring->queue_index];
+
+			if (test_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
+				eics |= q_vector->eims_value;
+				clear_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
+			}
+		}
+		if (eics)
+			wr32(E1000_EICS, eics);
 	} else {
-		wr32(E1000_ICS, E1000_ICS_RXDMT0);
+		struct igb_ring *rx_ring = adapter->rx_ring[0];
+
+		if (test_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
+			clear_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
+			wr32(E1000_ICS, E1000_ICS_RXDMT0);
+		}
 	}
 
 	igb_spoof_check(adapter);
@@ -9090,6 +9108,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_failed++;
 			rx_buffer->pagecnt_bias++;
+			set_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 			break;
 		}
 
@@ -9149,6 +9168,7 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 	page = dev_alloc_pages(igb_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
 		rx_ring->rx_stats.alloc_failed++;
+		set_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 		return false;
 	}
 
@@ -9165,6 +9185,7 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 		__free_pages(page, igb_rx_pg_order(rx_ring));
 
 		rx_ring->rx_stats.alloc_failed++;
+		set_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 		return false;
 	}
 
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 157d43787fa0..5cf67ba29269 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -415,6 +415,7 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_failed++;
+			set_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 			break;
 		}
 
-- 
2.47.1


