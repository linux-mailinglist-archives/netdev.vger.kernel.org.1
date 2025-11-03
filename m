Return-Path: <netdev+bounces-235000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63855C2B0E0
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6293B807D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEE02FD7D9;
	Mon,  3 Nov 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN2H1vTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E92E6CD7
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165700; cv=none; b=D26bmw4Oy69dMMp2xp0ZqjnxFvTcuXZF5LkNfM4zxM6SRM3qRoaHj8PK/qOYEnUUyU/X2ZDshEZNzrNbNL+zNLFUyoqjYWILXDUoiy19PYsQpicjPvYFenIN97QaI1gVszJ8dOz7wEMgNU77c/DKM1CA8Mzfny45Mbz/JcTMxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165700; c=relaxed/simple;
	bh=qDICcggEYwpzeew0V9EpWauGDNTFAtZObRveRemaIaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFbbVZWqRKpsvHeUZFOKuYqr7s8Xp1o+Z+pc3lNZRxSZKoNXtzWMkO1ZvnHoPUcnH9sZehfP5jFb01WkrBbt4Ty25ipVucA1Adg/5gfWjo3sxlo++OWmABmFap0QX/9t2SVryF6DCMq9k2KTeVRyOWLgwjOy28kjcg0sdnNKX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN2H1vTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ADEC4CEE7;
	Mon,  3 Nov 2025 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762165699;
	bh=qDICcggEYwpzeew0V9EpWauGDNTFAtZObRveRemaIaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NN2H1vTEDXfpykRNkuD4/dJNDrJzwOt5j4FNHmHXO/Mbu9PxgrJrUlsNbA9u56GA5
	 +4xQVgItyMar3jprrqq4qhAtBITGCgM5uCvTmsv0zHSrXEjlR49jGfFocQ9JC6vY3i
	 OWwIYpH4yybW+1ARayyLbTyZ1IcpMH0HkCAlIUJ0peP65VRS2vbolXZ6Ut6iFXC0kC
	 mUMpN/nm80RwHuVHQ4s0TMrlsatH2rh7SkPdTCber5bjGHMthYXxqXIjioLWbUtVFB
	 cGB0Kyu8li4OpcryKHqJYd0HkEz3dMfFmH4olXl70hnepnNxYSK9c5xyO97q6mjuhC
	 tPTVGyLCuXbwA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 03 Nov 2025 11:27:55 +0100
Subject: [PATCH net-next 1/2] net: airoha: Add the capability to consume
 out-of-order DMA tx descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-airoha-tx-linked-list-v1-1-baa07982cc30@kernel.org>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
In-Reply-To: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2

EN7581 and AN7583 SoCs are capable of DMA mapping non-linear tx skbs on
non-consecutive DMA descriptors. This feature is useful when multiple
flows are queued on the same hw tx queue since it allows to fully utilize
the available tx DMA descriptors and to avoid the starvation of
high-priority flow we have in the current codebase due to head-of-line
blocking introduced by low-priority flows.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 87 +++++++++++++++-----------------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 ++-
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 688faf999e4c0a30d53a25877b4a81a33ec7fca2..b717e3efe53cc9c86be8a39e7f9b03cc592e7281 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -892,19 +892,13 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
-		memset(e, 0, sizeof(*e));
+		e->dma_addr = 0;
+		list_add_tail(&e->list, &q->tx_list);
+
 		WRITE_ONCE(desc->msg0, 0);
 		WRITE_ONCE(desc->msg1, 0);
 		q->queued--;
 
-		/* completion ring can report out-of-order indexes if hw QoS
-		 * is enabled and packets with different priority are queued
-		 * to same DMA ring. Take into account possible out-of-order
-		 * reports incrementing DMA ring tail pointer
-		 */
-		while (q->tail != q->head && !q->entry[q->tail].dma_addr)
-			q->tail = (q->tail + 1) % q->ndesc;
-
 		if (skb) {
 			u16 queue = skb_get_queue_mapping(skb);
 			struct netdev_queue *txq;
@@ -949,6 +943,7 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 	q->ndesc = size;
 	q->qdma = qdma;
 	q->free_thr = 1 + MAX_SKB_FRAGS;
+	INIT_LIST_HEAD(&q->tx_list);
 
 	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -961,9 +956,9 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 		return -ENOMEM;
 
 	for (i = 0; i < q->ndesc; i++) {
-		u32 val;
+		u32 val = FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
 
-		val = FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
+		list_add_tail(&q->entry[i].list, &q->tx_list);
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
 
@@ -973,9 +968,9 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 
 	airoha_qdma_wr(qdma, REG_TX_RING_BASE(qid), dma_addr);
 	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
-			FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
-			FIELD_PREP(TX_RING_DMA_IDX_MASK, q->head));
+			FIELD_PREP(TX_RING_DMA_IDX_MASK, 0));
 
 	return 0;
 }
@@ -1031,17 +1026,21 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
 	struct airoha_eth *eth = q->qdma->eth;
+	int i;
 
 	spin_lock_bh(&q->lock);
-	while (q->queued) {
-		struct airoha_queue_entry *e = &q->entry[q->tail];
+	for (i = 0; i < q->ndesc; i++) {
+		struct airoha_queue_entry *e = &q->entry[i];
+
+		if (!e->dma_addr)
+			continue;
 
 		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
 		dev_kfree_skb_any(e->skb);
+		e->dma_addr = 0;
 		e->skb = NULL;
-
-		q->tail = (q->tail + 1) % q->ndesc;
+		list_add_tail(&e->list, &q->tx_list);
 		q->queued--;
 	}
 	spin_unlock_bh(&q->lock);
@@ -1883,20 +1882,6 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
-static bool airoha_dev_tx_queue_busy(struct airoha_queue *q, u32 nr_frags)
-{
-	u32 tail = q->tail <= q->head ? q->tail + q->ndesc : q->tail;
-	u32 index = q->head + nr_frags;
-
-	/* completion napi can free out-of-order tx descriptors if hw QoS is
-	 * enabled and packets with different priorities are queued to the same
-	 * DMA ring. Take into account possible out-of-order reports checking
-	 * if the tx queue is full using circular buffer head/tail pointers
-	 * instead of the number of queued packets.
-	 */
-	return index >= tail;
-}
-
 static int airoha_get_fe_port(struct airoha_gdm_port *port)
 {
 	struct airoha_qdma *qdma = port->qdma;
@@ -1919,8 +1904,10 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 	u32 nr_frags, tag, msg0, msg1, len;
+	struct airoha_queue_entry *e;
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
+	LIST_HEAD(tx_list);
 	void *data;
 	int i, qid;
 	u16 index;
@@ -1966,7 +1953,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	txq = netdev_get_tx_queue(dev, qid);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
-	if (airoha_dev_tx_queue_busy(q, nr_frags)) {
+	if (q->queued + nr_frags >= q->ndesc) {
 		/* not enough space in the queue */
 		netif_tx_stop_queue(txq);
 		spin_unlock_bh(&q->lock);
@@ -1975,11 +1962,13 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	len = skb_headlen(skb);
 	data = skb->data;
-	index = q->head;
+
+	e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+			     list);
+	index = e - q->entry;
 
 	for (i = 0; i < nr_frags; i++) {
 		struct airoha_qdma_desc *desc = &q->desc[index];
-		struct airoha_queue_entry *e = &q->entry[index];
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		dma_addr_t addr;
 		u32 val;
@@ -1989,7 +1978,15 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
 			goto error_unmap;
 
-		index = (index + 1) % q->ndesc;
+		__list_del_entry(&e->list);
+		list_add_tail(&e->list, &tx_list);
+		e->skb = i ? NULL : skb;
+		e->dma_addr = addr;
+		e->dma_len = len;
+
+		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+				     list);
+		index = e - q->entry;
 
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, len);
 		if (i < nr_frags - 1)
@@ -2002,15 +1999,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
 		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
 
-		e->skb = i ? NULL : skb;
-		e->dma_addr = addr;
-		e->dma_len = len;
-
 		data = skb_frag_address(frag);
 		len = skb_frag_size(frag);
 	}
-
-	q->head = index;
 	q->queued += i;
 
 	skb_tx_timestamp(skb);
@@ -2019,7 +2010,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
 		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
 				TX_RING_CPU_IDX_MASK,
-				FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
+				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
 	if (q->ndesc - q->queued < q->free_thr)
 		netif_tx_stop_queue(txq);
@@ -2029,10 +2020,14 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	for (i--; i >= 0; i--) {
-		index = (q->head + i) % q->ndesc;
-		dma_unmap_single(dev->dev.parent, q->entry[index].dma_addr,
-				 q->entry[index].dma_len, DMA_TO_DEVICE);
+	while (!list_empty(&tx_list)) {
+		e = list_first_entry(&tx_list, struct airoha_queue_entry,
+				     list);
+		__list_del_entry(&e->list);
+		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
+				 DMA_TO_DEVICE);
+		e->dma_addr = 0;
+		list_add_tail(&e->list, &q->tx_list);
 	}
 
 	spin_unlock_bh(&q->lock);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index eb27a4ff51984ef376c6e94607ee2dc1a806488b..fbbc58133364baefafed30299ca0626c686b668e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -169,7 +169,10 @@ enum trtcm_param {
 struct airoha_queue_entry {
 	union {
 		void *buf;
-		struct sk_buff *skb;
+		struct {
+			struct list_head list;
+			struct sk_buff *skb;
+		};
 	};
 	dma_addr_t dma_addr;
 	u16 dma_len;
@@ -193,6 +196,8 @@ struct airoha_queue {
 	struct napi_struct napi;
 	struct page_pool *page_pool;
 	struct sk_buff *skb;
+
+	struct list_head tx_list;
 };
 
 struct airoha_tx_irq_queue {

-- 
2.51.1


