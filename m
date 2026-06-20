Return-Path: <netdev+bounces-300820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O8gwBEGsNmpWCwcAu9opvQ
	(envelope-from <netdev+bounces-300820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 194186A90C1
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:05:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XCykXMzy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300820-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63FB93001F8C
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874733E36A;
	Sat, 20 Jun 2026 15:05:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B86389E02
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:05:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967925; cv=none; b=hZ8+vWMDz7iugNDzRlo/k5qoafmJHtp+zpco5X/uwaJr43/l1m7kmDDPQuUoe2LpTv+h/6thHoNe6aAqhLxm1TnyV/TfmGCMzANX5xf/Dqwfb8KkAn2aVdZoKe/vJipvcsuAI9HWar3p6tLPFsDtgoe/mmtTE3B8Ak0nna8nYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967925; c=relaxed/simple;
	bh=DXQrFp6bfroDIW1DVeQO6OpMOjF41f0RlkULQcU9jws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LQmcUTq4ATxbKdbb5jPWDiG50qWvRtYzrZZyrCjCEp0GfZiPFUqTgBucOOHe13jpbv4VzDeunWaDYe39hQ5Mww693TaLCFz5EavZfcVteXsjKui9qAHMMgXGmI4YnzffUlluuRAdPygq4wyklzVCZlkTonni4eLFhgG/5w7UlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCykXMzy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218A51F000E9;
	Sat, 20 Jun 2026 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781967923;
	bh=0+v0S3VAixbj85Um6T+8w27l56aehHDzSBJJHYlTa6o=;
	h=From:Date:Subject:To:Cc;
	b=XCykXMzyeWQY/0CxjsF1p8Tn0jzAPqo0KQZsqLeiHXRqB3fTJJXf/f2DHw+Bxpeya
	 6olOkYd6f5n55IVVWkh5SyjicY18+KSzaVmtXW0XOmUz83YhHRdgNvy+eR891AedHj
	 wK01dMDv5wSJ0HuRJaa65T2Bc9oIQQDMeElzutsAnjR61N9B+ISo8Ma7RW7bdxE4RW
	 4HfulJ7rUIafANEukAHH6vrg6ImoGH1PcHnbMq+2Q5KbKJjSNLLy/idPb7PTI32KNF
	 kNYm2UTbONGFAoWYoPTkiNmT10SV06fEe57EnWWYVzWKRGOavNgKY5L5vLjLuvi4bz
	 UOSFJD+TONi0w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Jun 2026 17:04:51 +0200
Subject: [PATCH net v3] net: airoha: fix BQL underflow in shared QDMA TX
 ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-airoha-bql-fixes-v3-1-76b95374e63e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBAF0Ks0rMXAFFrqynsYF7QMLbEpCg3RN
 L27hJUmuvzz899sJGJwGMmp2kjA5KLzSw71oSLDpJcRqTM5E2DQsIYrql3wk6b9Y6bWPTFSK9s
 eDGdKtjXJs3vAUuTVhSy4kms+Ti6uPrzKm8RL9V9MnHJqrYEBmOokV+cbhgXnow9j0RJ8Ct0PA
 bIgaslNo0EIJb6Efd/fwhqp+PgAAAA=
X-Change-ID: 20260618-airoha-bql-fixes-f57b2d108573
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 194186A90C1

When multiple netdevs share a QDMA TX ring and one device is stopped,
netdev_tx_reset_subqueue() zeroes that device's BQL counters while its
pending skbs remain in the shared HW TX ring. When NAPI later completes
those skbs via netdev_tx_completed_queue(), the already-zeroed
dql->num_queued counter underflows.

Fix the issue:
- Remove netdev_tx_reset_subqueue() from airoha_dev_stop() so pending
  skbs are completed naturally by NAPI with proper BQL accounting.
- Rework airoha_qdma_tx_cleanup() to disable TX DMA, flush BQL
  counters, DMA-unmap and free all pending skbs while skb->dev
  references are still valid. Use a per-queue flushing flag checked
  under q->lock in airoha_dev_xmit() to prevent races between teardown
  and transmit. Call airoha_qdma_stop_napi() before
  airoha_qdma_tx_cleanup() at the call sites.
- Move DMA engine start into probe. Split DMA teardown so TX DMA is
  disabled in airoha_qdma_tx_cleanup() and RX DMA in
  airoha_qdma_cleanup().
- Remove qdma->users counter since DMA lifetime is now tied to
  probe/cleanup rather than per-netdev open/stop.

Fixes: a9c2ca61fec7 ("net: airoha: Support multiple net_devices for a single FE GDM port")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- Remove airoha_qdma users counter.
- Drop DEV_STATE_FLUSH bit and add per-queue flushing bool to avoid any
  race between airoha_qdma_tx_flush() and airoha_dev_xmit().
- Refactor airoha_qdma_cleanup_tx_queue().
- Rename airoha_qdma_cleanup_tx_queue() in airoha_qdma_tx_cleanup().
- Link to v2: https://lore.kernel.org/r/20260619-airoha-bql-fixes-v2-1-4351d6a24484@kernel.org

Changes in v2:
- Introduce airoha_qdma_tx_flush() to account BQL in airoha_remove() or
  airoha_probe() error path.
- Fix possible NULL pointer dereference in airoha_qdma_cleanup().
- Introduce DEV_STATE_FLUSH().
- Move back airoha_hw_cleanup().
- Set proper Fixes tag.
- Link to v1: https://lore.kernel.org/r/20260618-airoha-bql-fixes-v1-1-ffd2c2089518@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 166 +++++++++++++++++--------------
 drivers/net/ethernet/airoha/airoha_eth.h |   3 +-
 2 files changed, 93 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..8b81e932d535 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1004,6 +1004,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 		e = &q->entry[index];
 		skb = e->skb;
+		e->skb = NULL;
 
 		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
@@ -1147,55 +1148,76 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 	return 0;
 }
 
-static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
+static void airoha_qdma_tx_cleanup(struct airoha_qdma *qdma)
 {
-	struct airoha_qdma *qdma = q->qdma;
-	struct airoha_eth *eth = qdma->eth;
-	int i, qid = q - &qdma->q_tx[0];
-	u16 index = 0;
+	u32 status;
+	int i;
 
-	spin_lock_bh(&q->lock);
-	for (i = 0; i < q->ndesc; i++) {
-		struct airoha_queue_entry *e = &q->entry[i];
-		struct airoha_qdma_desc *desc = &q->desc[i];
+	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+			  GLOBAL_CFG_TX_DMA_EN_MASK);
+	if (read_poll_timeout(airoha_qdma_rr, status,
+			      !(status & GLOBAL_CFG_TX_DMA_BUSY_MASK),
+			      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+			      qdma, REG_QDMA_GLOBAL_CFG))
+		dev_warn(qdma->eth->dev, "QDMA TX DMA busy timeout\n");
 
-		if (!e->dma_addr)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		struct airoha_queue *q = &qdma->q_tx[i];
+		u16 index = 0;
+		int j;
+
+		if (!q->ndesc)
 			continue;
 
-		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
-				 DMA_TO_DEVICE);
-		dev_kfree_skb_any(e->skb);
-		e->dma_addr = 0;
-		e->skb = NULL;
-		list_add_tail(&e->list, &q->tx_list);
+		spin_lock_bh(&q->lock);
 
-		/* Reset DMA descriptor */
-		WRITE_ONCE(desc->ctrl, 0);
-		WRITE_ONCE(desc->addr, 0);
-		WRITE_ONCE(desc->data, 0);
-		WRITE_ONCE(desc->msg0, 0);
-		WRITE_ONCE(desc->msg1, 0);
-		WRITE_ONCE(desc->msg2, 0);
+		q->flushing = true;
+		for (j = 0; j < q->ndesc; j++) {
+			struct airoha_queue_entry *e = &q->entry[j];
+			struct airoha_qdma_desc *desc = &q->desc[j];
+			struct sk_buff *skb = e->skb;
 
-		q->queued--;
-	}
+			if (!e->dma_addr)
+				continue;
 
-	if (!list_empty(&q->tx_list)) {
-		struct airoha_queue_entry *e;
+			dma_unmap_single(qdma->eth->dev, e->dma_addr,
+					 e->dma_len, DMA_TO_DEVICE);
+			e->dma_addr = 0;
+			list_add_tail(&e->list, &q->tx_list);
+
+			WRITE_ONCE(desc->ctrl, 0);
+			WRITE_ONCE(desc->addr, 0);
+			WRITE_ONCE(desc->data, 0);
+			WRITE_ONCE(desc->msg0, 0);
+			WRITE_ONCE(desc->msg1, 0);
+			WRITE_ONCE(desc->msg2, 0);
+
+			if (skb) {
+				struct netdev_queue *txq;
+
+				txq = skb_get_tx_queue(skb->dev, skb);
+				netdev_tx_completed_queue(txq, 1, skb->len);
+				dev_kfree_skb_any(skb);
+				e->skb = NULL;
+			}
 
-		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
-				     list);
-		index = e - q->entry;
-	}
-	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
-	 * empty.
-	 */
-	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
-			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
-	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
-			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
+			q->queued--;
+		}
 
-	spin_unlock_bh(&q->lock);
+		if (!list_empty(&q->tx_list)) {
+			struct airoha_queue_entry *e;
+
+			e = list_first_entry(&q->tx_list,
+					     struct airoha_queue_entry, list);
+			index = e - q->entry;
+		}
+		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(i), TX_RING_CPU_IDX_MASK,
+				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+		airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(i), TX_RING_DMA_IDX_MASK,
+				FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
+
+		spin_unlock_bh(&q->lock);
+	}
 }
 
 static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
@@ -1523,10 +1545,23 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	return airoha_qdma_hw_init(qdma);
 }
 
-static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
+static void airoha_qdma_cleanup(struct airoha_eth *eth,
+				struct airoha_qdma *qdma)
 {
 	int i;
 
+	if (test_bit(DEV_STATE_INITIALIZED, &eth->state)) {
+		u32 status;
+
+		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+				  GLOBAL_CFG_RX_DMA_EN_MASK);
+		if (read_poll_timeout(airoha_qdma_rr, status,
+				      !(status & GLOBAL_CFG_RX_DMA_BUSY_MASK),
+				      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+				      qdma, REG_QDMA_GLOBAL_CFG))
+			dev_warn(eth->dev, "QDMA RX DMA busy timeout\n");
+	}
+
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
 		if (!qdma->q_rx[i].ndesc)
 			continue;
@@ -1546,12 +1581,6 @@ static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-		if (!qdma->q_tx[i].ndesc)
-			continue;
-
-		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-	}
 }
 
 static int airoha_hw_init(struct platform_device *pdev,
@@ -1593,7 +1622,7 @@ static int airoha_hw_init(struct platform_device *pdev,
 	return 0;
 error:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_cleanup(&eth->qdma[i]);
+		airoha_qdma_cleanup(eth, &eth->qdma[i]);
 
 	return err;
 }
@@ -1603,7 +1632,7 @@ static void airoha_hw_cleanup(struct airoha_eth *eth)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_cleanup(&eth->qdma[i]);
+		airoha_qdma_cleanup(eth, &eth->qdma[i]);
 	airoha_ppe_deinit(eth);
 }
 
@@ -1837,11 +1866,6 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	port->users++;
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
-	qdma->users++;
-
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
 		pse_port = FE_PSE_PORT_PPE2;
@@ -1880,12 +1904,9 @@ static int airoha_dev_stop(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = dev->qdma;
-	int i;
 
 	netif_tx_disable(netdev);
 	airoha_set_vip_for_gdm_port(dev, false);
-	for (i = 0; i < netdev->num_tx_queues; i++)
-		netdev_tx_reset_subqueue(netdev, i);
 
 	if (--port->users)
 		airoha_set_port_mtu(dev->eth, port);
@@ -1893,20 +1914,6 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(qdma->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
-
-	if (!--qdma->users) {
-		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
-				  GLOBAL_CFG_TX_DMA_EN_MASK |
-				  GLOBAL_CFG_RX_DMA_EN_MASK);
-
-		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-			if (!qdma->q_tx[i].ndesc)
-				continue;
-
-			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-		}
-	}
-
 	return 0;
 }
 
@@ -2229,6 +2236,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	spin_lock_bh(&q->lock);
 
+	if (q->flushing)
+		goto error_unlock;
+
 	txq = skb_get_tx_queue(netdev, skb);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
@@ -2309,7 +2319,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		e->dma_addr = 0;
 	}
 	list_splice(&tx_list, &q->tx_list);
-
+error_unlock:
 	spin_unlock_bh(&q->lock);
 error:
 	dev_kfree_skb_any(skb);
@@ -3413,8 +3423,12 @@ static int airoha_probe(struct platform_device *pdev)
 	if (err)
 		goto error_netdev_free;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		airoha_qdma_start_napi(&eth->qdma[i]);
+		airoha_qdma_set(&eth->qdma[i], REG_QDMA_GLOBAL_CFG,
+				GLOBAL_CFG_TX_DMA_EN_MASK |
+				GLOBAL_CFG_RX_DMA_EN_MASK);
+	}
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
@@ -3437,8 +3451,10 @@ static int airoha_probe(struct platform_device *pdev)
 	return 0;
 
 error_napi_stop:
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		airoha_qdma_stop_napi(&eth->qdma[i]);
+		airoha_qdma_tx_cleanup(&eth->qdma[i]);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
@@ -3474,8 +3490,10 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		airoha_qdma_stop_napi(&eth->qdma[i]);
+		airoha_qdma_tx_cleanup(&eth->qdma[i]);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 41d2e7a1f9fb..d7ff8c5200e2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -197,6 +197,7 @@ struct airoha_queue {
 	int free_thr;
 	int buf_size;
 	bool txq_stopped;
+	bool flushing;
 
 	struct napi_struct napi;
 	struct page_pool *page_pool;
@@ -524,8 +525,6 @@ struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
 
-	int users;
-
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];

---
base-commit: a887f2c7da66a805a55fd8706d45faec85f646db
change-id: 20260618-airoha-bql-fixes-f57b2d108573

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


