Return-Path: <netdev+bounces-139913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FC9B4979
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24680282E87
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DE205AD7;
	Tue, 29 Oct 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce2LSR3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BC1DF960
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204262; cv=none; b=mWNysuwlIwZorpyQveQtol6CDjseTM+U7ooG25vP9jfyojj6CrCXC3pPdq4IUGvohFyI82GQg+NzF8fU36YCx5mzv0D/yj0TzBIzHo9v2+AZlSDKtBMfqxp0QnnauSr7EHnq0G07/w3IaoQdDzFk4jqHIatQ/srcX2B1Xlpsbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204262; c=relaxed/simple;
	bh=tDkCaSGHNwLmvBZ1sIOYlpYZET0YJNWlUhpzReHjttw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4eKOJuoIAUVo83ZJ7Y+Q0sMagCeOQY1v4MRXUTOd/m9lYXfdgkVlFcSfXaoH7N3BLOYbAsr4OGPN87PmGd2WJyZAAfkq1r0X6N613UVurBroSNOcSLYnr60mKPr8DPUK4StpIS44TpJ2blvUoeeAoBj+iC7mjcKlqHn73I55LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce2LSR3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA1DC4CECD;
	Tue, 29 Oct 2024 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730204262;
	bh=tDkCaSGHNwLmvBZ1sIOYlpYZET0YJNWlUhpzReHjttw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ce2LSR3SW+LRk8THt1OeL4bpr+mNwqDl0mPzdmsISqGfIPtUBe83bur1Ygs9dJ35w
	 gx7NWDaEaKeESZzZkQ6ceNbW8LH4F7CM8EVuuvqXEg8mYx56v7TyktNXWbNA+RNJD+
	 UCbD7hvACBiZs/27X7JKPOnKPmlK4Fo4HWGoMmV88DbK0vkfGhLU6XmMIjh9ugU1Y2
	 UOjHMRMTrHnj0cK8pmjYH+jO2UK+iSQRor3dhhpeG7TRcLCwIeXsSUEL2bcHOZlIMB
	 JidWfF7VevZwn89oYrl0wFKIeuWx740m7iSZOUlq0c7Bjyd3SSfuMUc3dgqfkCUIWH
	 CcjSTnP6TlpWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 29 Oct 2024 13:17:10 +0100
Subject: [PATCH net-next 2/2] net: airoha: Simplify Tx napi logic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-airoha-en7581-tx-napi-work-v1-2-96ad1686b946@kernel.org>
References: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
In-Reply-To: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Simplify Tx napi logic relying just on the packet index provided by
completion queue indicating the completed packet that can be removed
from the Tx DMA ring.
This is a preliminary patch to add Qdisc offload for airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 73 +++++++++++++++++-------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 6cd8901ed38f0640a8a8f72174c120668b364045..6c683a12d5aa52dd9d966df123509075a989c0b3 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1670,8 +1670,12 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 	irq_queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
 
 	while (irq_queued > 0 && done < budget) {
-		u32 qid, last, val = irq_q->q[head];
+		u32 qid, val = irq_q->q[head];
+		struct airoha_qdma_desc *desc;
+		struct airoha_queue_entry *e;
 		struct airoha_queue *q;
+		u32 index, desc_ctrl;
+		struct sk_buff *skb;
 
 		if (val == 0xff)
 			break;
@@ -1681,9 +1685,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		irq_queued--;
 		done++;
 
-		last = FIELD_GET(IRQ_DESC_IDX_MASK, val);
 		qid = FIELD_GET(IRQ_RING_IDX_MASK, val);
-
 		if (qid >= ARRAY_SIZE(qdma->q_tx))
 			continue;
 
@@ -1691,46 +1693,53 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		if (!q->ndesc)
 			continue;
 
+		index = FIELD_GET(IRQ_DESC_IDX_MASK, val);
+		if (index >= q->ndesc)
+			continue;
+
 		spin_lock_bh(&q->lock);
 
-		while (q->queued > 0) {
-			struct airoha_qdma_desc *desc = &q->desc[q->tail];
-			struct airoha_queue_entry *e = &q->entry[q->tail];
-			u32 desc_ctrl = le32_to_cpu(desc->ctrl);
-			struct sk_buff *skb = e->skb;
-			u16 index = q->tail;
+		if (!q->queued)
+			goto unlock;
 
-			if (!(desc_ctrl & QDMA_DESC_DONE_MASK) &&
-			    !(desc_ctrl & QDMA_DESC_DROP_MASK))
-				break;
+		desc = &q->desc[index];
+		desc_ctrl = le32_to_cpu(desc->ctrl);
 
-			q->tail = (q->tail + 1) % q->ndesc;
-			q->queued--;
+		if (!(desc_ctrl & QDMA_DESC_DONE_MASK) &&
+		    !(desc_ctrl & QDMA_DESC_DROP_MASK))
+			goto unlock;
 
-			dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
-					 DMA_TO_DEVICE);
+		e = &q->entry[index];
+		skb = e->skb;
 
-			WRITE_ONCE(desc->msg0, 0);
-			WRITE_ONCE(desc->msg1, 0);
+		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
+				 DMA_TO_DEVICE);
+		memset(e, 0, sizeof(*e));
+		WRITE_ONCE(desc->msg0, 0);
+		WRITE_ONCE(desc->msg1, 0);
+		q->queued--;
 
-			if (skb) {
-				u16 queue = skb_get_queue_mapping(skb);
-				struct netdev_queue *txq;
+		/* completion ring can report out-of-order indexes if hw QoS
+		 * is enabled and packets with different priority are queued
+		 * to same DMA ring. Take into account possible out-of-order
+		 * reports incrementing DMA ring tail pointer
+		 */
+		while (q->tail != q->head && !q->entry[q->tail].dma_addr)
+			q->tail = (q->tail + 1) % q->ndesc;
 
-				txq = netdev_get_tx_queue(skb->dev, queue);
-				netdev_tx_completed_queue(txq, 1, skb->len);
-				if (netif_tx_queue_stopped(txq) &&
-				    q->ndesc - q->queued >= q->free_thr)
-					netif_tx_wake_queue(txq);
+		if (skb) {
+			u16 queue = skb_get_queue_mapping(skb);
+			struct netdev_queue *txq;
 
-				dev_kfree_skb_any(skb);
-				e->skb = NULL;
-			}
+			txq = netdev_get_tx_queue(skb->dev, queue);
+			netdev_tx_completed_queue(txq, 1, skb->len);
+			if (netif_tx_queue_stopped(txq) &&
+			    q->ndesc - q->queued >= q->free_thr)
+				netif_tx_wake_queue(txq);
 
-			if (index == last)
-				break;
+			dev_kfree_skb_any(skb);
 		}
-
+unlock:
 		spin_unlock_bh(&q->lock);
 	}
 

-- 
2.47.0


