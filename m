Return-Path: <netdev+bounces-171659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200FA4E0BB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1B16FAA6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0425205503;
	Tue,  4 Mar 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeQ1PgBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A21FF1C1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098096; cv=none; b=kR68ausBdi1zbWysgbtftDZWb06nNmiuv5ohy52WUiYgKG1SR5SHCgHarLqlgrQLfuN+1cwGGxD4O7taXxJiertvRpLr9KG1znWvlaCbxh/IBV+D07dhzw9tWRNYV1Cp/z4olgpGl9rWjernkPHHilIkfpmads2J9H7Q0AwYeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098096; c=relaxed/simple;
	bh=u7HmFuC3l1TWxIoD2Bd4ha3xLceZC9S30IdbjbSx0Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I84jrk4D4Iz1ymmeklPzVgc6phu1bIB/iXlZbagS/iQyq9pRK+oJtmxxUE5BWDV/qeH0/pgGead5K/v3b5B4D0/Jg7QiahgncqBcItExF08uHUyLkLDXIypDcH7ZEjOA2T5o+9312UJHx1gnW72p863zXAAmk11p8+MwHzZ8VWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeQ1PgBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0386C4CEE5;
	Tue,  4 Mar 2025 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098096;
	bh=u7HmFuC3l1TWxIoD2Bd4ha3xLceZC9S30IdbjbSx0Ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LeQ1PgBE4DOvSQzt6oXdBLR7+RHUw0IOf1jXs8vs/cDTRJiNSIvl0I/bgfHSl9iT2
	 J2hcOivzVtuballDWp2NNr6el8aychMEml2/D6NhijRa+QqL4XFiyUzu5W/ISgBGiF
	 stW+TBcruDSwvT9zOvUMjuArBi7e9TIyQFFEbonEVUk5pJT7CWXbdUe2z8Z2aW+u/9
	 3AeCB3VlZk19Cz/Yc7l6U7Hf9SaSIYWTl1SYNJQvyYs+lNhcu82K7TmHGFZeByhAPK
	 WH2dVby/nL1yZ3eXg2/r+3+UiGjkbnmLbzJKeE+VzHmY56Su57NaUX+OyuPB/29fDy
	 hLQkcSa3xXoiw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 15:21:09 +0100
Subject: [PATCH net-next 2/4] net: airoha: Enable Rx Scatter-Gather
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-airoha-eth-rx-sg-v1-2-283ebc61120e@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 SoC can receive 9k frames. Enable the reception of Scatter-Gather
(SG) frames.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 68 +++++++++++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_regs.h |  5 +++
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a9ed3fc2b5195f6b1868e65e1b8c0e5ef99e920f..54a239ab10aaac4a7bfc52977589415936207962 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -615,10 +615,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
 		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
 		dma_addr_t dma_addr = le32_to_cpu(desc->addr);
+		struct page *page = virt_to_head_page(e->buf);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
 		struct airoha_gdm_port *port;
-		struct sk_buff *skb;
-		int len, p;
+		int data_len, len, p;
 
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
@@ -636,30 +636,41 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		dma_sync_single_for_cpu(eth->dev, dma_addr,
 					SKB_WITH_OVERHEAD(q->buf_size), dir);
 
+		data_len = q->skb ? q->buf_size
+				  : SKB_WITH_OVERHEAD(q->buf_size);
+		if (data_len < len)
+			goto free_frag;
+
 		p = airoha_qdma_get_gdm_port(eth, desc);
-		if (p < 0 || !eth->ports[p]) {
-			page_pool_put_full_page(q->page_pool,
-						virt_to_head_page(e->buf),
-						true);
-			continue;
-		}
+		if (p < 0 || !eth->ports[p])
+			goto free_frag;
 
 		port = eth->ports[p];
-		skb = napi_build_skb(e->buf, q->buf_size);
-		if (!skb) {
-			page_pool_put_full_page(q->page_pool,
-						virt_to_head_page(e->buf),
-						true);
-			break;
+		if (!q->skb) { /* first buffer */
+			q->skb = napi_build_skb(e->buf, q->buf_size);
+			if (!q->skb)
+				goto free_frag;
+
+			__skb_put(q->skb, len);
+			skb_mark_for_recycle(q->skb);
+			q->skb->dev = port->dev;
+			q->skb->protocol = eth_type_trans(q->skb, port->dev);
+			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
+			skb_record_rx_queue(q->skb, qid);
+		} else { /* scattered frame */
+			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
+			int nr_frags = shinfo->nr_frags;
+
+			if (nr_frags >= ARRAY_SIZE(shinfo->frags))
+				goto free_frag;
+
+			skb_add_rx_frag(q->skb, nr_frags, page,
+					e->buf - page_address(page), len,
+					q->buf_size);
 		}
 
-		skb_reserve(skb, 2);
-		__skb_put(skb, len);
-		skb_mark_for_recycle(skb);
-		skb->dev = port->dev;
-		skb->protocol = eth_type_trans(skb, skb->dev);
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		skb_record_rx_queue(skb, qid);
+		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
+			continue;
 
 		if (netdev_uses_dsa(port->dev)) {
 			/* PPE module requires untagged packets to work
@@ -672,22 +683,27 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
 			    port->dsa_meta[sptag])
-				skb_dst_set_noref(skb,
+				skb_dst_set_noref(q->skb,
 						  &port->dsa_meta[sptag]->dst);
 		}
 
 		hash = FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
 		if (hash != AIROHA_RXD4_FOE_ENTRY)
-			skb_set_hash(skb, jhash_1word(hash, 0),
+			skb_set_hash(q->skb, jhash_1word(hash, 0),
 				     PKT_HASH_TYPE_L4);
 
 		reason = FIELD_GET(AIROHA_RXD4_PPE_CPU_REASON, msg1);
 		if (reason == PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
 			airoha_ppe_check_skb(eth->ppe, hash);
 
-		napi_gro_receive(&q->napi, skb);
-
 		done++;
+		napi_gro_receive(&q->napi, q->skb);
+		q->skb = NULL;
+		continue;
+free_frag:
+		page_pool_put_full_page(q->page_pool, page, true);
+		dev_kfree_skb(q->skb);
+		q->skb = NULL;
 	}
 	airoha_qdma_fill_rx_queue(q);
 
@@ -762,6 +778,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
+	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
 
 	airoha_qdma_fill_rx_queue(q);
 
@@ -1161,7 +1178,6 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 	}
 
 	airoha_qdma_wr(qdma, REG_QDMA_GLOBAL_CFG,
-		       GLOBAL_CFG_RX_2B_OFFSET_MASK |
 		       FIELD_PREP(GLOBAL_CFG_DMA_PREFERENCE_MASK, 3) |
 		       GLOBAL_CFG_CPU_TXR_RR_MASK |
 		       GLOBAL_CFG_PAYLOAD_BYTE_SWAP_MASK |
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index b7a3bd7a76b7be3125a2f244582e5bceab48bd47..dca96f1df67ee971e5442b0acfac211554accc89 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -176,6 +176,7 @@ struct airoha_queue {
 
 	struct napi_struct napi;
 	struct page_pool *page_pool;
+	struct sk_buff *skb;
 };
 
 struct airoha_tx_irq_queue {
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 1aa06cdffe2320375e8710d58f2bbb056a330dfd..8146cde4e8ba370e79b9b1bd87bb66a2caf7649a 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -626,10 +626,15 @@
 #define REG_RX_DELAY_INT_IDX(_n)	\
 	(((_n) < 16) ? 0x0210 + ((_n) << 5) : 0x0e10 + (((_n) - 16) << 5))
 
+#define REG_RX_SCATTER_CFG(_n)	\
+	(((_n) < 16) ? 0x0214 + ((_n) << 5) : 0x0e14 + (((_n) - 16) << 5))
+
 #define RX_DELAY_INT_MASK		GENMASK(15, 0)
 
 #define RX_RING_DMA_IDX_MASK		GENMASK(15, 0)
 
+#define RX_RING_SG_EN_MASK		BIT(0)
+
 #define REG_INGRESS_TRTCM_CFG		0x0070
 #define INGRESS_TRTCM_EN_MASK		BIT(31)
 #define INGRESS_TRTCM_MODE_MASK		BIT(30)

-- 
2.48.1


