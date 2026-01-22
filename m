Return-Path: <netdev+bounces-252246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNKLEcbmcWkONAAAu9opvQ
	(envelope-from <netdev+bounces-252246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:58:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2E63A69
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8057B7E3D31
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE9B37F739;
	Thu, 22 Jan 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUPqwl/O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705D333725
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071846; cv=none; b=NLlxRrdXT3COaELb0MAtgIrZXXi0cEPoTZGGiE8tT58D9cEQbn0+7ZdoTWNm8TXpJodu+clWyepJ1qt2g7H/aFVjSmuRK8GBz4J/lt17n5NBeOBoQKXogDsD7C1s8QNQwnztAhmVijDAh1PMFKFRYpyEny/ihJfVcwwu+oqPPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071846; c=relaxed/simple;
	bh=9l8iEd8bG/xM1ir56TTdn/JzoLQ68vI5QDl6oebT1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPtiFTAiCgt6J3f7BzCCUuAldC64I52Bh0OJEc9rqgL/vdkmYIGWP5RNMVlvWrjf6c9tn5vcbM1N5f44t30+ZnZmgNv8OUvcksy9HGKvpN+NfgTiUqxjIxGC8uHzDQ1ouqcXLvb8G/XUibDAL9yB9EhFTZYLgTZKtEqy8zlhDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUPqwl/O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769071844; x=1800607844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9l8iEd8bG/xM1ir56TTdn/JzoLQ68vI5QDl6oebT1fg=;
  b=EUPqwl/OZfMgCcJS0tZYtwK2D3Vu66C1GYdjQ5SeyLXwJ6ouOjyMgy3H
   urdhdDaUwmJgLEUpyP4JP5L4FoHMVXwV0Ml1coMU48dBWygisEp/ak4wR
   E9+14nxCCgDK2oVKKIrGNFuj6fFL3V1EgQIYuT3UePp2nw7/D1uTRrPl9
   kG4/0Vpxv4OGkXBvkZtBAcw+3npsQbeTGyhJ5a0OROQR4IlitrwoupGHC
   EV8dciAUqZSxh1ahrfaFYymBLSgSKs0UzlKtaqpGHS4fK5aZQ7t4VA6U8
   7t4HClY/5ER/DKll4lFCcj3yRc+oxpD4QGBd6vGY/2jo+2T2pY3y16Ykb
   A==;
X-CSE-ConnectionGUID: RdUSyz0QTWqOnmC3aMaJhA==
X-CSE-MsgGUID: MUD6nSTNQmmnGYuJQ1T5Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="72900697"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="72900697"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:50:42 -0800
X-CSE-ConnectionGUID: 7ZZlwGf+RDC0oXhZ2QWdDQ==
X-CSE-MsgGUID: NVIyCBkmSZCNHPB93vYxaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206288995"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 22 Jan 2026 00:50:40 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v1] ixgbe: refactor: use DECLARE_BITMAP for ring state field
Date: Thu, 22 Jan 2026 09:50:39 +0100
Message-ID: <20260122085039.1117442-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252246-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: ABC2E63A69
X-Rspamd-Action: no action

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
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 27 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 +++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 4 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dce4936..59a1cee4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -322,49 +322,50 @@ enum ixgbe_ring_state_t {
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
 	struct net_device *netdev;
 	unsigned int tx_base_queue;
 	unsigned int rx_base_queue;
 	int pool;
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
 	struct net_device *netdev;	/* netdev ring belongs to */
 	struct bpf_prog *xdp_prog;
 	struct device *dev;		/* device for DMA mapping */
 	void *desc;			/* descriptor ring memory */
 	union {
 		struct ixgbe_tx_buffer *tx_buffer_info;
 		struct ixgbe_rx_buffer *rx_buffer_info;
 	};
-	unsigned long state;
+	DECLARE_BITMAP(state, __IXGBE_RING_STATE_NBITS);
 	u8 __iomem *tail;
 	dma_addr_t dma;			/* phys. address of descriptor ring */
 	unsigned int size;		/* length in bytes */
@@ -453,19 +454,19 @@ struct ixgbe_ring_feature {
  */
 static inline unsigned int ixgbe_rx_bufsz(struct ixgbe_ring *ring)
 {
-	if (test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
+	if (test_bit(__IXGBE_RX_3K_BUFFER, ring->state))
 		return IXGBE_RXBUFFER_3K;
 #if (PAGE_SIZE < 8192)
 	if (ring_uses_build_skb(ring))
 		return IXGBE_MAX_2K_FRAME_BUILD_SKB;
 #endif
 	return IXGBE_RXBUFFER_2K;
 }
 
 static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
-	if (test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
+	if (test_bit(__IXGBE_RX_3K_BUFFER, ring->state))
 		return 1;
 #endif
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index a1d0491..b5c85c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -979,15 +979,15 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 		 * can be marked as checksum errors.
 		 */
 		if (adapter->hw.mac.type == ixgbe_mac_82599EB)
-			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, &ring->state);
+			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, ring->state);
 
 #ifdef IXGBE_FCOE
 		if (adapter->netdev->fcoe_mtu) {
 			struct ixgbe_ring_feature *f;
 			f = &adapter->ring_feature[RING_F_FCOE];
 			if ((rxr_idx >= f->offset) &&
 			    (rxr_idx < f->offset + f->indices))
-				set_bit(__IXGBE_RX_FCOE, &ring->state);
+				set_bit(__IXGBE_RX_FCOE, ring->state);
 		}
 
 #endif /* IXGBE_FCOE */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 034618e..95cd8d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -968,7 +968,7 @@ static void ixgbe_update_xoff_rx_lfc(struct ixgbe_adapter *adapter)
 
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		clear_bit(__IXGBE_HANG_CHECK_ARMED,
-			  &adapter->tx_ring[i]->state);
+			  adapter->tx_ring[i]->state);
 }
 
 static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
@@ -1011,15 +1011,15 @@ static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
 
 		tc = tx_ring->dcb_tc;
 		if (xoff[tc])
-			clear_bit(__IXGBE_HANG_CHECK_ARMED, &tx_ring->state);
+			clear_bit(__IXGBE_HANG_CHECK_ARMED, tx_ring->state);
 	}
 
 	for (i = 0; i < adapter->num_xdp_queues; i++) {
 		struct ixgbe_ring *xdp_ring = adapter->xdp_ring[i];
 
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
@@ -3952,22 +3952,22 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
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
 			netif_set_xps_queue(ring->netdev,
 					    &q_vector->affinity_mask,
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
index 7b94150..89f96c4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -524,7 +524,7 @@ int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 
 	ring = adapter->xdp_ring[qid];
 
-	if (test_bit(__IXGBE_TX_DISABLED, &ring->state))
+	if (test_bit(__IXGBE_TX_DISABLED, ring->state))
 		return -ENETDOWN;
 
 	if (!ring->xsk_pool)
-- 
2.52.0


