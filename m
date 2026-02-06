Return-Path: <netdev+bounces-257646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHdbFtIqhmnMKAQAu9opvQ
	(envelope-from <netdev+bounces-257646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CFD101836
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4C93097BE0
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB0426D07;
	Fri,  6 Feb 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpi55QHW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA742669B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400162; cv=none; b=Yzu1VQ/1n32uitAsaIYyzAM4AyUtVL86SHKw9Wflt4JYDegdGgFc/1AOtFM+qu1Cpk3ouLV26VaUKUESL0wYNddTytIEopaaE6GspQ6hazYYeH0yXIGVy3d9XvPWZfff91bNVBU1XO/O3Pvknc+1uwhID7R5IUCG8Yfpjz3wDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400162; c=relaxed/simple;
	bh=SLL6KVFneCLbUP4ZjpSQRxvfqXsRHvTkmyHblHEzWFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXHqllGt5lmYWi6TjgPB9tDxZIfew7qC2ViIVZCWvj7y3YGLzNbY0A384jD0Uw/1oYOjuJxVa9118UqKv3YSgQWPop9IICqI5is4lPvn47xNEFAKBRUjzh/YSFRJQkEiQAY3L1+EiQLrYOHZ2Ua2xAk4X2etio4+XSxLCVs20wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpi55QHW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770400162; x=1801936162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLL6KVFneCLbUP4ZjpSQRxvfqXsRHvTkmyHblHEzWFU=;
  b=jpi55QHWP9sbLnTOh0zTUdnT6rqm8LgjUZe3/+3Fxibk4JGjmiDn9Crc
   iQsU08pUqTLM/cG9uTtlMwEMTf829tMDor9xr3fXPWtMYaKKshh/5mdU9
   /ifBI+fvn4zx2WTg81z7GUda53B3oZmTgjBUQJmQ2NPYBWQVPpwADGnLs
   KdO+CkYurCxDdzjX6mCoA6AZSrlAFLrd72D/bT2ErWAwMnpWBuH0drOV0
   l85wMsiAUh2Qly143rPWOvWmzvIiLkArLKzfmpbOrGID3cUISVvFopLgJ
   LY1ANEL/uMPET8QXHZMrDWeYU7ZcmHfhG9YopExloWLGRouinDGMa+nnp
   g==;
X-CSE-ConnectionGUID: rOwaFl1YSZSDwI5GMVJa/w==
X-CSE-MsgGUID: hx3PBjDrTUqm8BgqwCfk9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71793164"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71793164"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:49:21 -0800
X-CSE-ConnectionGUID: GuCxFQUMT1+whfLo5ueVuA==
X-CSE-MsgGUID: dgLvpYr9S1CZwOj1i1rP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215495424"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2026 09:49:20 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 9/9] ixgbe: refactor: use DECLARE_BITMAP for ring state field
Date: Fri,  6 Feb 2026 09:49:06 -0800
Message-ID: <20260206174910.4066255-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
References: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257646-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A2CFD101836
X-Rspamd-Action: no action

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Convert the ring state field from 'unsigned long' to a proper bitmap
using DECLARE_BITMAP macro, aligning with the implementation pattern
already used in the i40e driver.

This change:
- Adds __IXGBE_RING_STATE_NBITS as the bitmap size sentinel to enum
  ixgbe_ring_state_t (consistent with i40e's __I40E_RING_STATE_NBITS)
- Changes 'unsigned long state' to 'DECLARE_BITMAP(state,
  __IXGBE_RING_STATE_NBITS)' in struct ixgbe_ring
- Removes the address-of operator (&) when passing ring->state to bit
  manipulation functions, as bitmap arrays naturally decay to pointers

The change maintains functional equivalence while using the
more appropriate kernel bitmap API, consistent with other Intel Ethernet
drivers.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 27 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 +++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 4 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dce4936708eb..59a1cee40b43 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -322,10 +322,11 @@ enum ixgbe_ring_state_t {
 	__IXGBE_HANG_CHECK_ARMED,
 	__IXGBE_TX_XDP_RING,
 	__IXGBE_TX_DISABLED,
+	__IXGBE_RING_STATE_NBITS, /* must be last */
 };
 
 #define ring_uses_build_skb(ring) \
-	test_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &(ring)->state)
+	test_bit(__IXGBE_RX_BUILD_SKB_ENABLED, (ring)->state)
 
 struct ixgbe_fwd_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
@@ -336,23 +337,23 @@ struct ixgbe_fwd_adapter {
 };
 
 #define check_for_tx_hang(ring) \
-	test_bit(__IXGBE_TX_DETECT_HANG, &(ring)->state)
+	test_bit(__IXGBE_TX_DETECT_HANG, (ring)->state)
 #define set_check_for_tx_hang(ring) \
-	set_bit(__IXGBE_TX_DETECT_HANG, &(ring)->state)
+	set_bit(__IXGBE_TX_DETECT_HANG, (ring)->state)
 #define clear_check_for_tx_hang(ring) \
-	clear_bit(__IXGBE_TX_DETECT_HANG, &(ring)->state)
+	clear_bit(__IXGBE_TX_DETECT_HANG, (ring)->state)
 #define ring_is_rsc_enabled(ring) \
-	test_bit(__IXGBE_RX_RSC_ENABLED, &(ring)->state)
+	test_bit(__IXGBE_RX_RSC_ENABLED, (ring)->state)
 #define set_ring_rsc_enabled(ring) \
-	set_bit(__IXGBE_RX_RSC_ENABLED, &(ring)->state)
+	set_bit(__IXGBE_RX_RSC_ENABLED, (ring)->state)
 #define clear_ring_rsc_enabled(ring) \
-	clear_bit(__IXGBE_RX_RSC_ENABLED, &(ring)->state)
+	clear_bit(__IXGBE_RX_RSC_ENABLED, (ring)->state)
 #define ring_is_xdp(ring) \
-	test_bit(__IXGBE_TX_XDP_RING, &(ring)->state)
+	test_bit(__IXGBE_TX_XDP_RING, (ring)->state)
 #define set_ring_xdp(ring) \
-	set_bit(__IXGBE_TX_XDP_RING, &(ring)->state)
+	set_bit(__IXGBE_TX_XDP_RING, (ring)->state)
 #define clear_ring_xdp(ring) \
-	clear_bit(__IXGBE_TX_XDP_RING, &(ring)->state)
+	clear_bit(__IXGBE_TX_XDP_RING, (ring)->state)
 struct ixgbe_ring {
 	struct ixgbe_ring *next;	/* pointer to next ring in q_vector */
 	struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
@@ -364,7 +365,7 @@ struct ixgbe_ring {
 		struct ixgbe_tx_buffer *tx_buffer_info;
 		struct ixgbe_rx_buffer *rx_buffer_info;
 	};
-	unsigned long state;
+	DECLARE_BITMAP(state, __IXGBE_RING_STATE_NBITS);
 	u8 __iomem *tail;
 	dma_addr_t dma;			/* phys. address of descriptor ring */
 	unsigned int size;		/* length in bytes */
@@ -453,7 +454,7 @@ struct ixgbe_ring_feature {
  */
 static inline unsigned int ixgbe_rx_bufsz(struct ixgbe_ring *ring)
 {
-	if (test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
+	if (test_bit(__IXGBE_RX_3K_BUFFER, ring->state))
 		return IXGBE_RXBUFFER_3K;
 #if (PAGE_SIZE < 8192)
 	if (ring_uses_build_skb(ring))
@@ -465,7 +466,7 @@ static inline unsigned int ixgbe_rx_bufsz(struct ixgbe_ring *ring)
 static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
-	if (test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
+	if (test_bit(__IXGBE_RX_3K_BUFFER, ring->state))
 		return 1;
 #endif
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index a1d04914fbbc..b5c85c567212 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -979,7 +979,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 		 * can be marked as checksum errors.
 		 */
 		if (adapter->hw.mac.type == ixgbe_mac_82599EB)
-			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, &ring->state);
+			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, ring->state);
 
 #ifdef IXGBE_FCOE
 		if (adapter->netdev->fcoe_mtu) {
@@ -987,7 +987,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 			f = &adapter->ring_feature[RING_F_FCOE];
 			if ((rxr_idx >= f->offset) &&
 			    (rxr_idx < f->offset + f->indices))
-				set_bit(__IXGBE_RX_FCOE, &ring->state);
+				set_bit(__IXGBE_RX_FCOE, ring->state);
 		}
 
 #endif /* IXGBE_FCOE */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c58051e4350b..d50f8558803a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -968,7 +968,7 @@ static void ixgbe_update_xoff_rx_lfc(struct ixgbe_adapter *adapter)
 
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		clear_bit(__IXGBE_HANG_CHECK_ARMED,
-			  &adapter->tx_ring[i]->state);
+			  adapter->tx_ring[i]->state);
 }
 
 static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
@@ -1011,7 +1011,7 @@ static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
 
 		tc = tx_ring->dcb_tc;
 		if (xoff[tc])
-			clear_bit(__IXGBE_HANG_CHECK_ARMED, &tx_ring->state);
+			clear_bit(__IXGBE_HANG_CHECK_ARMED, tx_ring->state);
 	}
 
 	for (i = 0; i < adapter->num_xdp_queues; i++) {
@@ -1019,7 +1019,7 @@ static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
 
 		tc = xdp_ring->dcb_tc;
 		if (xoff[tc])
-			clear_bit(__IXGBE_HANG_CHECK_ARMED, &xdp_ring->state);
+			clear_bit(__IXGBE_HANG_CHECK_ARMED, xdp_ring->state);
 	}
 }
 
@@ -1103,11 +1103,11 @@ static bool ixgbe_check_tx_hang(struct ixgbe_ring *tx_ring)
 	if (tx_done_old == tx_done && tx_pending)
 		/* make sure it is true for two checks in a row */
 		return test_and_set_bit(__IXGBE_HANG_CHECK_ARMED,
-					&tx_ring->state);
+					tx_ring->state);
 	/* update completed stats and continue */
 	tx_ring->tx_stats.tx_done_old = tx_done;
 	/* reset the countdown */
-	clear_bit(__IXGBE_HANG_CHECK_ARMED, &tx_ring->state);
+	clear_bit(__IXGBE_HANG_CHECK_ARMED, tx_ring->state);
 
 	return false;
 }
@@ -1660,7 +1660,7 @@ static inline bool ixgbe_rx_is_fcoe(struct ixgbe_ring *ring,
 {
 	__le16 pkt_info = rx_desc->wb.lower.lo_dword.hs_rss.pkt_info;
 
-	return test_bit(__IXGBE_RX_FCOE, &ring->state) &&
+	return test_bit(__IXGBE_RX_FCOE, ring->state) &&
 	       ((pkt_info & cpu_to_le16(IXGBE_RXDADV_PKTTYPE_ETQF_MASK)) ==
 		(cpu_to_le16(IXGBE_ETQF_FILTER_FCOE <<
 			     IXGBE_RXDADV_PKTTYPE_ETQF_SHIFT)));
@@ -1708,7 +1708,7 @@ static inline void ixgbe_rx_checksum(struct ixgbe_ring *ring,
 		 * checksum errors.
 		 */
 		if ((pkt_info & cpu_to_le16(IXGBE_RXDADV_PKTTYPE_UDP)) &&
-		    test_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, &ring->state))
+		    test_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, ring->state))
 			return;
 
 		ring->rx_stats.csum_err++;
@@ -3526,7 +3526,7 @@ static irqreturn_t ixgbe_msix_other(int irq, void *data)
 			for (i = 0; i < adapter->num_tx_queues; i++) {
 				struct ixgbe_ring *ring = adapter->tx_ring[i];
 				if (test_and_clear_bit(__IXGBE_TX_FDIR_INIT_DONE,
-						       &ring->state))
+						       ring->state))
 					reinit_count++;
 			}
 			if (reinit_count) {
@@ -3952,13 +3952,13 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
 	if (adapter->flags & IXGBE_FLAG_FDIR_HASH_CAPABLE) {
 		ring->atr_sample_rate = adapter->atr_sample_rate;
 		ring->atr_count = 0;
-		set_bit(__IXGBE_TX_FDIR_INIT_DONE, &ring->state);
+		set_bit(__IXGBE_TX_FDIR_INIT_DONE, ring->state);
 	} else {
 		ring->atr_sample_rate = 0;
 	}
 
 	/* initialize XPS */
-	if (!test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, &ring->state)) {
+	if (!test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, ring->state)) {
 		struct ixgbe_q_vector *q_vector = ring->q_vector;
 
 		if (q_vector)
@@ -3967,7 +3967,7 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
 					    ring->queue_index);
 	}
 
-	clear_bit(__IXGBE_HANG_CHECK_ARMED, &ring->state);
+	clear_bit(__IXGBE_HANG_CHECK_ARMED, ring->state);
 
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
@@ -4173,7 +4173,7 @@ static void ixgbe_configure_srrctl(struct ixgbe_adapter *adapter,
 			srrctl |= PAGE_SIZE >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
 		else
 			srrctl |= xsk_buf_len >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
-	} else if (test_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state)) {
+	} else if (test_bit(__IXGBE_RX_3K_BUFFER, rx_ring->state)) {
 		srrctl |= IXGBE_RXBUFFER_3K >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
 	} else {
 		srrctl |= IXGBE_RXBUFFER_2K >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
@@ -4558,7 +4558,7 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 		 * higher than the MTU of the PF.
 		 */
 		if (ring_uses_build_skb(ring) &&
-		    !test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
+		    !test_bit(__IXGBE_RX_3K_BUFFER, ring->state))
 			rxdctl |= IXGBE_MAX_2K_FRAME_BUILD_SKB |
 				  IXGBE_RXDCTL_RLPML_EN;
 #endif
@@ -4733,27 +4733,27 @@ static void ixgbe_set_rx_buffer_len(struct ixgbe_adapter *adapter)
 		rx_ring = adapter->rx_ring[i];
 
 		clear_ring_rsc_enabled(rx_ring);
-		clear_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
-		clear_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &rx_ring->state);
+		clear_bit(__IXGBE_RX_3K_BUFFER, rx_ring->state);
+		clear_bit(__IXGBE_RX_BUILD_SKB_ENABLED, rx_ring->state);
 
 		if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
 			set_ring_rsc_enabled(rx_ring);
 
-		if (test_bit(__IXGBE_RX_FCOE, &rx_ring->state))
-			set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
+		if (test_bit(__IXGBE_RX_FCOE, rx_ring->state))
+			set_bit(__IXGBE_RX_3K_BUFFER, rx_ring->state);
 
 		if (adapter->flags2 & IXGBE_FLAG2_RX_LEGACY)
 			continue;
 
-		set_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &rx_ring->state);
+		set_bit(__IXGBE_RX_BUILD_SKB_ENABLED, rx_ring->state);
 
 #if (PAGE_SIZE < 8192)
 		if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
-			set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
+			set_bit(__IXGBE_RX_3K_BUFFER, rx_ring->state);
 
 		if (IXGBE_2K_TOO_SMALL_WITH_PADDING ||
 		    (max_frame > (ETH_FRAME_LEN + ETH_FCS_LEN)))
-			set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
+			set_bit(__IXGBE_RX_3K_BUFFER, rx_ring->state);
 #endif
 	}
 }
@@ -7946,10 +7946,10 @@ static void ixgbe_fdir_reinit_subtask(struct ixgbe_adapter *adapter)
 	if (ixgbe_reinit_fdir_tables_82599(hw) == 0) {
 		for (i = 0; i < adapter->num_tx_queues; i++)
 			set_bit(__IXGBE_TX_FDIR_INIT_DONE,
-				&(adapter->tx_ring[i]->state));
+				adapter->tx_ring[i]->state);
 		for (i = 0; i < adapter->num_xdp_queues; i++)
 			set_bit(__IXGBE_TX_FDIR_INIT_DONE,
-				&adapter->xdp_ring[i]->state);
+				adapter->xdp_ring[i]->state);
 		/* re-enable flow director interrupts */
 		IXGBE_WRITE_REG(hw, IXGBE_EIMS, IXGBE_EIMS_FLOW_DIR);
 	} else {
@@ -9490,7 +9490,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 		ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
 
 	/* add the ATR filter if ATR is on */
-	if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, &tx_ring->state))
+	if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, tx_ring->state))
 		ixgbe_atr(tx_ring, first);
 
 #ifdef IXGBE_FCOE
@@ -9530,7 +9530,7 @@ static netdev_tx_t __ixgbe_xmit_frame(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 
 	tx_ring = ring ? ring : adapter->tx_ring[skb_get_queue_mapping(skb)];
-	if (unlikely(test_bit(__IXGBE_TX_DISABLED, &tx_ring->state)))
+	if (unlikely(test_bit(__IXGBE_TX_DISABLED, tx_ring->state)))
 		return NETDEV_TX_BUSY;
 
 	return ixgbe_xmit_frame_ring(skb, adapter, tx_ring);
@@ -11015,7 +11015,7 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(!ring))
 		return -ENXIO;
 
-	if (unlikely(test_bit(__IXGBE_TX_DISABLED, &ring->state)))
+	if (unlikely(test_bit(__IXGBE_TX_DISABLED, ring->state)))
 		return -ENXIO;
 
 	if (static_branch_unlikely(&ixgbe_xdp_locking_key))
@@ -11121,7 +11121,7 @@ static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
 static void ixgbe_disable_txr(struct ixgbe_adapter *adapter,
 			      struct ixgbe_ring *tx_ring)
 {
-	set_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
+	set_bit(__IXGBE_TX_DISABLED, tx_ring->state);
 	ixgbe_disable_txr_hw(adapter, tx_ring);
 }
 
@@ -11275,9 +11275,9 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
 	ixgbe_configure_rx_ring(adapter, rx_ring);
 
-	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
+	clear_bit(__IXGBE_TX_DISABLED, tx_ring->state);
 	if (xdp_ring)
-		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+		clear_bit(__IXGBE_TX_DISABLED, xdp_ring->state);
 
 	/* Rx/Tx/XDP Tx share the same napi context. */
 	napi_enable(&rx_ring->q_vector->napi);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..89f96c463f02 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -524,7 +524,7 @@ int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 
 	ring = adapter->xdp_ring[qid];
 
-	if (test_bit(__IXGBE_TX_DISABLED, &ring->state))
+	if (test_bit(__IXGBE_TX_DISABLED, ring->state))
 		return -ENETDOWN;
 
 	if (!ring->xsk_pool)
-- 
2.47.1


