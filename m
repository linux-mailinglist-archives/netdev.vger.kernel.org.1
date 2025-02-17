Return-Path: <netdev+bounces-166958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FDA381C5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499EA3B36F9
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92779219E82;
	Mon, 17 Feb 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ne+ONELG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2FN9Toi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25D219A80
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791895; cv=none; b=BfY8luw8bYyjaD9hvoI8EmtfQSM5QSlxcgK41rPVuwM2GNt4LP7P/7+VJaQ+mpdfeNN0n6ImhBHwE9nH2+OSxgudJB0aPy/1J8sThroeDATemqAu306E6j9FyGDMg1AGSTF3H1c2a0hrKFiokfFe0R2wBvxyzSo+gvG+e72xFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791895; c=relaxed/simple;
	bh=xUo+bNs3yPOXLQ4lPhzno9lz0kcYuAN4Vp+LwT0fQVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCuXqruWP+8vPwhOCIy4RM89/CgBrgWemWMZp4D7kCP0RKUs8eRM5pAPJ3rtkvoy6a10UbicEALj35WdFL0I4ZPRVzP5yrK9i359237SuayeixWXVxlnMCGxLLQctblvD2nPXqBK5UM15A8qxxmJKP/Lh4J00z6+vLyjNYkjVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ne+ONELG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2FN9Toi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739791892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnIQsRCD/grX1S3QwLY6W0EqtBUu1o4T+F7Ge/iTeZU=;
	b=Ne+ONELGdzqyxedfUoN7FFV9Yrn3rzpvP32yEF6flYF3RJqVQT9yrl9n26QFrZLdqKtlI8
	z2NbalBHB0qejyOX9xqxh5uI81xFLHbHjj+IshdO/kjxerLfoqOobg1fjW04GZLTeY1DR4
	/goIm8OWCdOeN88oOqmnBSMHxvAqX5v6sLQ1wsOW9AMzZ97XlkTb97swp/doB+Z6CLu0Zu
	xD8o+NnsX3wkXzsmgrPvyLROysUrSJhTjvG6iU3zKeWT2GFCDlznZKUqIe3ZcNKkfeT3+p
	aH1cuIpEZZH22tCFBp5msrwbNETo2C7t7nxduEZA//Xsxcy+n1xEXbAXCvANGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739791892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnIQsRCD/grX1S3QwLY6W0EqtBUu1o4T+F7Ge/iTeZU=;
	b=L2FN9Toi6+eds+jTFD8YCWu5snc3Wpj6+kJtBu/mxwfxPGhT4TU3b7RnVexPl9nw/UsCkn
	IHioMUpGZN2PFwBg==
Date: Mon, 17 Feb 2025 12:31:24 +0100
Subject: [PATCH iwl-next v2 4/4] igb: Get rid of spurious interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-igb_irq-v2-4-4cb502049ac2@linutronix.de>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
In-Reply-To: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=xUo+bNs3yPOXLQ4lPhzno9lz0kcYuAN4Vp+LwT0fQVo=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnsx4Qf1ejhIpc8yTt+iP/sxt6u/CRFVMJZuNnU
 Q/r4YI9hSOJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ7MeEAAKCRDBk9HyqkZz
 gizAD/9z5pJRH/7A91yZJnrkPfUzj0n1YES2lk+59DgvyFdSmRTyuVRY1TTxl/qBgk/eWUiFRiR
 eiElyo8/Bw+dWCRviFuy8B2tYjux2bqH/3X1whpszxzZ2UHERjjKJ8g/j/+38Z1akXYo5SzJ1Zf
 k3r+oo7h7VjKnANzLjLTTGWwAKhdrerIVmJOLLWsMtNoWtwrEbyXoag+/00EXgT/hELDfiZNacF
 pX6PJjziylUMhur4h/17xdvLs5fBSaG/o7YsuOoAN8elQd2mMfhJIqDJHYoCWZ2Va4lZrFM5u6D
 226uJ4ppx/tpHrnNSAFkjfUNfli91ALGdnRWirI0CeDJ0lonzMMBvXkHsNgufqlNeSu+oso2gim
 4r+ybLs91QRp1NH75I47Wd/DLiX0/hJOrzCvQfFJkChacJqGFJ5NX6n0rw0L1C4QrTmsNwfp23E
 FGLBDZ3yhG1sWfWkWuP40QTZ+Ita1ZcFUXHmDV07ftCvw+KMNNXOYXk9MTQ24T2naBd7iolP68o
 qtSy/ZVSej3Anftn2JwgXpR+jd7AKnNuIFDjAqIh7cZG7fVroC3a/GRy1nFp5sfjoobQ9cvLaxS
 FoAskvWkp0AMb0l+Qa7y1ppjea+q/Ha/9EvwAF0/CciWFlOeLnmIiEG2qV230r2c/wRMCuuNaE4
 ZxPCPXYn+W5xhCA==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

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
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |  3 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 29 +++++++++++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  1 +
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 79eca385a751bfdafdf384928b6cc1b350b22560..f34ead8243e9f0176a068299138c5c16f7faab2e 100644
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
index 054376d648da883f35d1dee5f879487b8adfd540..25abe7d8ab400f63ca9b4e87c9b5f2c15316485a 100644
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
index a5ad090dfe94b6afc8194fe39d28cdd51c7067b0..47344ee1ed7f29bd68055485702a87df3b8922e8 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -417,6 +417,7 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_failed++;
+			set_bit(IGB_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 			break;
 		}
 

-- 
2.39.5


