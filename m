Return-Path: <netdev+bounces-176072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B1A6898D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A783D3B795F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F56254841;
	Wed, 19 Mar 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlIhqByU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17Pykt4j"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838D253F31
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380015; cv=none; b=HDBMsiFOmGzIqrp+TZKm7eqYjP/ZQpfb+X8Rd5mIkgSOKo38JYxsIRBjO1yny215kBtCOMGata+run279rhuhAdDtrszDo604BBGbffiBGkuDsD9O1F6yC2LssXO9BMVbI9Az48vVxql2OBu3BoIwOQuOmD3yOqjybctIO2irVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380015; c=relaxed/simple;
	bh=btqMP/w6rrXtckllt55OLyagkPFpdPpWJVbl27jlvjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5KtE2Ggb7u/L7mwoLspeNHSEDEc56EVT3nM63BTnIQzByLM65W1SEy6y9rekLRJRb4BZptnYO71BiUU7PcpbIVfg+mkE7eAF1//O0K6ULKznzPwoYMs2TJ1v6+igGAlODIW4uyuQttBar+CqWZkc1Q9QrCdaPSEudUdNB32xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QlIhqByU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17Pykt4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742380010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHaRYejTDZcBr7viVmaCzXmrP3wnRXjux54mdUtJris=;
	b=QlIhqByUkmQU62mmW6WNottA82i6WeV3oYbxWs62UsO0uHRCuKRKpX/jtJhAKQHmNaktN0
	702k8oatRYOdGMM0ZtL3x/LlCU5BcfBfGPs3S6Ox5VOYBrxsghQNZy2LBDwRv0cBy3HX6T
	UPF11aF6IVf6+p446kNNxWuXSXpFSdLPcPgf9Hfxf59vhczOb+UuYulUZowyg4J1ss07CW
	SlbsOhot9gZHvSTm5kjwi6yr+oM2mU0wqX8kXOfUYGW+mEt8DOrSh13wtcFxGQI7wzLGwT
	a6mTKzux+Aub4MvY7dwqq4aUQOPaSH4TgEIejCm2swEwy2uLew2lbgj6UNTTDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742380010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHaRYejTDZcBr7viVmaCzXmrP3wnRXjux54mdUtJris=;
	b=17Pykt4j5f3NI33KDXFbuOzv0yvjeK5yQOSfZnHLFBH1jLXPlWoIczePI+GG/add4bqYiF
	sqhkVQKmcJwO4zDQ==
Date: Wed, 19 Mar 2025 11:26:42 +0100
Subject: [PATCH iwl-next v3 4/4] igb: Get rid of spurious interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-igb_irq-v3-4-b9ee902143dd@linutronix.de>
References: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
In-Reply-To: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Sweta Kumari <sweta.kumari@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4897; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=btqMP/w6rrXtckllt55OLyagkPFpdPpWJVbl27jlvjg=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn2pvmQkDdiIsgVelIcAwvtj8KMtb2LQhhQeB2P
 17agSWDhgaJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ9qb5gAKCRDBk9HyqkZz
 ggcxEACrMy/jtY3Yq52mqapxFPKuj0QTCQThoftB0xHiSV4qX9HrvDuZYZGu+KxoKatiAZODMFI
 VSoRwhv3cUnwFV6E/OGYfSr5pn2FxShm2U8kpbadesIUtIzBdl3Gf6EG9I9NzttUs/CCJZGNTO4
 /D77USfiz7Ykf+QSalT61BmYnasCQYmooc/qs30NVnrqfHj8ODai17Ss8WU0lYe0ZhJp5uAuZSd
 xOY9Pfb2iAOQP0K54l0sMVzZG7xnY5rEDSP/Ph9obPz67hDhbDwI5qEM4GwFkLR2Ujj2LlZJorX
 tyawf+G/nRUYRGUIa67FQmQ0cBAKT7Axcc5CQcC1ptMoUh/Fmf4zcrgCUAVfV1mz//DlKRQsnWJ
 taKvOICE7C11nYwJmEyNimfispdbhyRrjUWJPwyV3qun3neOD9xBEB8LLHGOqXM/5lSyJOMyj0E
 0g5/1oDErVk7fI4fLNRsdlV5x9ziZ0u3Jpdfh8HK+YLQYJaL8Ie0/D1J/Kq2svGnLwW8NmkbNzN
 yTr8yy4dROC2YEDdLnkr6uQ3REUDL/wQoltpyWp6i4ax+RJ9kbyG9myum/dm8Swhx7qlaobkDFU
 bL4+BzrBY5PtA77+m6U0uNvSMCm5yxG5V6MboWhhZhZzYfBKlFZoS+d5I8yxDygzN1jPtJN+UIZ
 7aR7+ToH7tNB+Hw==
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sweta Kumari <sweta.kumari@intel.com>
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
index 157d43787fa0b55a74714f69e9e7903b695fcf0a..5cf67ba292694f14822420a738ffb8f6b0f588cb 100644
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
2.39.5


