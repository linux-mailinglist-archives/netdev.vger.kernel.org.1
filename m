Return-Path: <netdev+bounces-98594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C399E8D1D7C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F79E1F23853
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599A170840;
	Tue, 28 May 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3/9OC9r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FB17082E;
	Tue, 28 May 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904180; cv=none; b=XAi5ZkM2m4A6UAI37TxsrlHjWYju+tONwl4FXHG0IiY24io3A5vf+1UYLEMFTYjyyMHcDxxC3EZNG+8serGWlMaUds35oV05HTa9xnQF2GowNahoD2KaBp9pdcQku0zPOj6Rzu6wfOZtt1kMMxsxVOd1a2VJTz84sasYfycyE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904180; c=relaxed/simple;
	bh=gZnqF0XHabYYe4ZKOW6AhiGeFoBHQS1SezjFcpmduKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twn/pK0NI6S7SSaAO4r+Q5yqavFgu1+oekhLy9OM1NO5ycG82RrIKcnEsGY4+SvjmCYKnH8BblpEHZI6JK+EuzOUsvpnTFftiRXgaFIcCHAk7d9+rzp4dSjLWUph30JcY2hijSkwvfpb5TIpWeklT9jGdaqMfazQfsCaD0K/Daw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3/9OC9r; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904179; x=1748440179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZnqF0XHabYYe4ZKOW6AhiGeFoBHQS1SezjFcpmduKI=;
  b=m3/9OC9rc8QZV7LpPZtg8HUBs0bKKdPBMIaju0JcfWJrCwriS5VsUF1H
   h9lPOTt7p9B91S7M1AXGPyBBbvUi+Tvss5vlkY5eGD54MuzQvjzloyXnN
   xvHi4np88mTGpf5tfXePJfNGzA9/WVnsmf7Rl1OUswSOap0hqUHELz26G
   Klr9eyTC+M+BKuQL5LBzIsNFYrELAyiMGpzGUdwR8bi5+8U5ezofN9hkb
   qRQl4JGNDD+15gTSKH+ttBKgEYYzT0HMttgLG45ZpFui5aBrg4+sXGjpP
   Kq0AhPwVjF/idb37nHsqJVA/PWH+L9u11369aeji2VCBrgpe6Aci+Y2lr
   w==;
X-CSE-ConnectionGUID: VcYBNgcVS+K+dC04+fF2gw==
X-CSE-MsgGUID: 1a5pKV4QT4GYCgDqWXUa8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13437028"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13437028"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:49:38 -0700
X-CSE-ConnectionGUID: DWC8rK24QkGdZT9Tfx4wTQ==
X-CSE-MsgGUID: AgeWtTT3RyCpxR6SgqCWEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35577437"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 06:49:35 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 06/12] idpf: merge singleq and splitq &net_device_ops
Date: Tue, 28 May 2024 15:48:40 +0200
Message-ID: <20240528134846.148890-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528134846.148890-1-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It makes no sense to have a second &net_device_ops struct (800 bytes of
rodata) with only one difference in .ndo_start_xmit, which can easily
be just one `if`. This `if` is a drop in the ocean and you won't see
any difference.
Define unified idpf_xmit_start(). The preparation for sending is the
same, just call either idpf_tx_splitq_frame() or idpf_tx_singleq_frame()
depending on the active model to actually map and send the skb.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  9 ++----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 26 +++-------------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 31 ++-----------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 17 ++++++----
 4 files changed, 20 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 731e2a73def5..e8a71da62d80 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1204,14 +1204,11 @@ void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
 			   struct idpf_tx_buf *first, u16 ring_idx);
 unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 					 struct sk_buff *skb);
-bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
-			unsigned int count);
 int idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q, unsigned int size);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
-netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
-				 struct net_device *netdev);
-netdev_tx_t idpf_tx_singleq_start(struct sk_buff *skb,
-				  struct net_device *netdev);
+netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
+				  struct idpf_tx_queue *tx_q);
+netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a8be09a89943..fe91475c7b4c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -4,8 +4,7 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 
-static const struct net_device_ops idpf_netdev_ops_splitq;
-static const struct net_device_ops idpf_netdev_ops_singleq;
+static const struct net_device_ops idpf_netdev_ops;
 
 /**
  * idpf_init_vector_stack - Fill the MSIX vector stack with vector index
@@ -764,10 +763,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	}
 
 	/* assign netdev_ops */
-	if (idpf_is_queue_model_split(vport->txq_model))
-		netdev->netdev_ops = &idpf_netdev_ops_splitq;
-	else
-		netdev->netdev_ops = &idpf_netdev_ops_singleq;
+	netdev->netdev_ops = &idpf_netdev_ops;
 
 	/* setup watchdog timeout value to be 5 second */
 	netdev->watchdog_timeo = 5 * HZ;
@@ -2353,24 +2349,10 @@ void idpf_free_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem)
 	mem->pa = 0;
 }
 
-static const struct net_device_ops idpf_netdev_ops_splitq = {
-	.ndo_open = idpf_open,
-	.ndo_stop = idpf_stop,
-	.ndo_start_xmit = idpf_tx_splitq_start,
-	.ndo_features_check = idpf_features_check,
-	.ndo_set_rx_mode = idpf_set_rx_mode,
-	.ndo_validate_addr = eth_validate_addr,
-	.ndo_set_mac_address = idpf_set_mac,
-	.ndo_change_mtu = idpf_change_mtu,
-	.ndo_get_stats64 = idpf_get_stats64,
-	.ndo_set_features = idpf_set_features,
-	.ndo_tx_timeout = idpf_tx_timeout,
-};
-
-static const struct net_device_ops idpf_netdev_ops_singleq = {
+static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_open = idpf_open,
 	.ndo_stop = idpf_stop,
-	.ndo_start_xmit = idpf_tx_singleq_start,
+	.ndo_start_xmit = idpf_tx_start,
 	.ndo_features_check = idpf_features_check,
 	.ndo_set_rx_mode = idpf_set_rx_mode,
 	.ndo_validate_addr = eth_validate_addr,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index b51f7cd6db01..a3b60a2dfcaa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -351,8 +351,8 @@ static void idpf_tx_singleq_build_ctx_desc(struct idpf_tx_queue *txq,
  *
  * Returns NETDEV_TX_OK if sent, else an error code
  */
-static netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
-					 struct idpf_tx_queue *tx_q)
+netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
+				  struct idpf_tx_queue *tx_q)
 {
 	struct idpf_tx_offload_params offload = { };
 	struct idpf_tx_buf *first;
@@ -408,33 +408,6 @@ static netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 	return idpf_tx_drop_skb(tx_q, skb);
 }
 
-/**
- * idpf_tx_singleq_start - Selects the right Tx queue to send buffer
- * @skb: send buffer
- * @netdev: network interface device structure
- *
- * Returns NETDEV_TX_OK if sent, else an error code
- */
-netdev_tx_t idpf_tx_singleq_start(struct sk_buff *skb,
-				  struct net_device *netdev)
-{
-	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
-	struct idpf_tx_queue *tx_q;
-
-	tx_q = vport->txqs[skb_get_queue_mapping(skb)];
-
-	/* hardware can't handle really short frames, hardware padding works
-	 * beyond this point
-	 */
-	if (skb_put_padto(skb, IDPF_TX_MIN_PKT_LEN)) {
-		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
-
-		return NETDEV_TX_OK;
-	}
-
-	return idpf_tx_singleq_frame(skb, tx_q);
-}
-
 /**
  * idpf_tx_singleq_clean - Reclaim resources from queue
  * @tx_q: Tx queue to clean
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f569ea389b04..5dd1b1a9e624 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4,6 +4,9 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 
+static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
+			       unsigned int count);
+
 /**
  * idpf_buf_lifo_push - push a buffer pointer onto stack
  * @stack: pointer to stack struct
@@ -2702,8 +2705,8 @@ static bool __idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs)
  * E.g.: a packet with 7 fragments can require 9 DMA transactions; 1 for TSO
  * header, 1 for segment payload, and then 7 for the fragments.
  */
-bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
-			unsigned int count)
+static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
+			       unsigned int count)
 {
 	if (likely(count < max_bufs))
 		return false;
@@ -2849,14 +2852,13 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 }
 
 /**
- * idpf_tx_splitq_start - Selects the right Tx queue to send buffer
+ * idpf_tx_start - Selects the right Tx queue to send buffer
  * @skb: send buffer
  * @netdev: network interface device structure
  *
  * Returns NETDEV_TX_OK if sent, else an error code
  */
-netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
-				 struct net_device *netdev)
+netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
 	struct idpf_tx_queue *tx_q;
@@ -2878,7 +2880,10 @@ netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	return idpf_tx_splitq_frame(skb, tx_q);
+	if (idpf_is_queue_model_split(vport->txq_model))
+		return idpf_tx_splitq_frame(skb, tx_q);
+	else
+		return idpf_tx_singleq_frame(skb, tx_q);
 }
 
 /**
-- 
2.45.1


