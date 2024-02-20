Return-Path: <netdev+bounces-73449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281385CA3C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706FA1C21E66
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E190152DF6;
	Tue, 20 Feb 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jc4dZF2I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6A151CFD
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465593; cv=none; b=RoizqsfFkxWTLon9Vmg4czL4VKI9e0s+Pkkn1BYmA2iT9Z11U9dbcWzDiRV0Twzknsy5/xwCd7oelPQo+Hh/IGtsvs0miFHCdQeI6aYSXN+TduXTVlyJA/Ai4T6qYQWYyT3rS09wDJXgRadL/2rbAq/9unvvkzeldOOUqnqNoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465593; c=relaxed/simple;
	bh=bdiBwq/F7jbABNBxnAM282nmUEUuo1pitgZsUL1JYec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIbhDZ+Q0VnWQeXE3hsn1QwW2rc2At/97E6Af19yj8JpJWIJGDL+z/Xpm/eflVPlw15mGkkkYB81xhJxiqcx9MgVes4la8VVzmsZ1n+f/3XneTC+n30GZ+BUxSP8Ne0Ame2Ii1MdPMDOHM1IMB9WfdE7bxJdNJCpcdpArFAIv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jc4dZF2I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465592; x=1740001592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bdiBwq/F7jbABNBxnAM282nmUEUuo1pitgZsUL1JYec=;
  b=jc4dZF2Ii+QGeRLwOQaZXIaw20yXH0lfririWoo9+JF2TIp8myrHaKp/
   eM1JypXw7Ip/DwXDlcfXR4DJVo1HO2ZV8gBbsrOzv4BK8f2tgsx9aHf1L
   nM2C6HHXqV/ahid2LLQ77Pcg3jV8yJ5MK0ePQnk02gTVQX5EA6bJKMxh0
   YXwIzVzBmqhYov4WInjpbvpIiuI4QhZYS7s/RTnuiV7EGeLrsdAmraIxe
   0wSdb/0C+6d6Le5TFrF2ez5kmoATloM8KajBP4tDlajboP/hXn/a9lp6b
   7c7s7KOdSND1IiMQjS2/NWsb9QlDlNDDRb+nQw/DOAHity5AxoM0nXw5h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2462664"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2462664"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:46:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35681884"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2024 13:46:30 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Vazharov <pavel@x3me.net>
Subject: [PATCH iwl-net 1/3] ixgbe: {dis,en}able irqs in ixgbe_txrx_ring_{dis,en}able
Date: Tue, 20 Feb 2024 22:45:51 +0100
Message-Id: <20240220214553.714243-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
References: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently routines that are supposed to toggle state of ring pair do not
take care of associated interrupt with queue vector that these rings
belong to. This causes funky issues such as dead interface due to irq
misconfiguration, as per Pavel's report from Closes: tag.

Add a function responsible for disabling single IRQ in EIMC register and
call this as a very first thing when disabling ring pair during xsk_pool
setup. For enable let's reuse ixgbe_irq_enable_queues(). Besides this,
disable/enable NAPI as first/last thing when dealing with closing or
opening ring pair that xsk_pool is being configured on.

Reported-by: Pavel Vazharov <pavel@x3me.net>
Closes: https://lore.kernel.org/netdev/CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com/
Fixes: 024aa5800f32 ("ixgbe: added Rx/Tx ring disable/enable functions")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c7..99876b765b08 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2939,8 +2939,8 @@ static void ixgbe_check_lsc(struct ixgbe_adapter *adapter)
 static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 					   u64 qmask)
 {
-	u32 mask;
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mask;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -10524,6 +10524,44 @@ static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
 }
 
+/**
+ * ixgbe_irq_disable_single - Disable single IRQ vector
+ * @adapter: adapter structure
+ * @ring: ring index
+ **/
+static void ixgbe_irq_disable_single(struct ixgbe_adapter *adapter, u32 ring)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u64 qmask = BIT_ULL(ring);
+	u32 mask;
+
+	switch (adapter->hw.mac.type) {
+	case ixgbe_mac_82598EB:
+		mask = qmask & IXGBE_EIMC_RTX_QUEUE;
+		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC, mask);
+		break;
+	case ixgbe_mac_82599EB:
+	case ixgbe_mac_X540:
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+		mask = (qmask & 0xFFFFFFFF);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(0), mask);
+		mask = (qmask >> 32);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(1), mask);
+		break;
+	default:
+		break;
+	}
+	IXGBE_WRITE_FLUSH(&adapter->hw);
+	if (adapter->flags & IXGBE_FLAG_MSIX_ENABLED)
+		synchronize_irq(adapter->msix_entries[ring].vector);
+	else
+		synchronize_irq(adapter->pdev->irq);
+}
+
 /**
  * ixgbe_txrx_ring_disable - Disable Rx/Tx/XDP Tx rings
  * @adapter: adapter structure
@@ -10540,6 +10578,11 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
+	ixgbe_irq_disable_single(adapter, ring);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
 	ixgbe_disable_txr(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_disable_txr(adapter, xdp_ring);
@@ -10548,9 +10591,6 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	if (xdp_ring)
 		synchronize_rcu();
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_disable(&rx_ring->q_vector->napi);
-
 	ixgbe_clean_tx_ring(tx_ring);
 	if (xdp_ring)
 		ixgbe_clean_tx_ring(xdp_ring);
@@ -10578,9 +10618,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_enable(&rx_ring->q_vector->napi);
-
 	ixgbe_configure_tx_ring(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
@@ -10589,6 +10626,11 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
 	if (xdp_ring)
 		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+	ixgbe_irq_enable_queues(adapter, BIT_ULL(ring));
+	IXGBE_WRITE_FLUSH(&adapter->hw);
 }
 
 /**
-- 
2.34.1


