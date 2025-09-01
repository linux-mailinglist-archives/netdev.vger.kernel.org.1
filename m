Return-Path: <netdev+bounces-218911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B8B3F051
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33784E01F6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7E258CC1;
	Mon,  1 Sep 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQS3n2sl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8E246348
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760902; cv=none; b=q2E/EVXryRPy1RjnTc7TZUuQgQNUMio0qmbjCv+UUuh3hV9vXXRIIOfZgZREDDkOwE5SDehbNjtnun2c5vilNswt4IfUu7kICYQDYtfMRhdDCd+fe2d8fo61rJCofPbWw8pv6kAn4fkSdW1eWit562i16UoZKyqb7aPfIYbWi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760902; c=relaxed/simple;
	bh=XbCy4rdE2BhuUujGuDARHVhk3c1K/UNKfC4sA0Oo2KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSt7JhKN+3XLDHhFPJgV6UXkvOLVzO2RnduFnkMmFZKtPjHiF4RrKW1pj44ejZ0Tc6ijCRmv3Gkt0BzOwWA3mLoqOVobBNS8kZV9pLSc6WYlRnJVgozsVeysT0XF+wpu7E2VoSjwd41AgjavnGfZhna4ILwoWovNp7cGT0QAu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQS3n2sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2CC4CEF5;
	Mon,  1 Sep 2025 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760901;
	bh=XbCy4rdE2BhuUujGuDARHVhk3c1K/UNKfC4sA0Oo2KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQS3n2sl8I6egI+I6GNY3K0zB1ATE3h5g2jx/nwlr70wwjwT8gCDfSR/OWchqhftY
	 v15CRUHaCaaNPyX42GV697fVlmTKfgzwToLLnmkVKUshYpyXRTn1YwWrE6vmDp104j
	 lSC9u9kWeK+mNIQj780qzzVdjcUcWA2itV22UbUa6JwalElJrCuq76HVaekS71ZSva
	 UyQOwJNNJqh/YkNS9ums9JPu/cV2iO+4kp7s4XzdPHrcpCgt1a58igOda2HrBmc7yK
	 N1VyciNnG4mjK4iAOYwUpWZDO+gE681lGjAEbrHs50tUbx2p/9eni036e4+l3eMKxo
	 TXiCMk760cX1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] eth: sundance: fix endian issues
Date: Mon,  1 Sep 2025 14:08:18 -0700
Message-ID: <20250901210818.1025316-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901210818.1025316-1-kuba@kernel.org>
References: <20250901210818.1025316-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix sparse warnings about endianness. Store DMA addr to a variable
of correct type and then only convert it when writing to the descriptor.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/dlink/sundance.c | 35 +++++++++++++++------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index 29d59c42dfa3..277c50ef773f 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -1033,21 +1033,22 @@ static void init_ring(struct net_device *dev)
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
+		dma_addr_t addr;
+
 		struct sk_buff *skb =
 			netdev_alloc_skb(dev, np->rx_buf_sz + 2);
 		np->rx_skbuff[i] = skb;
 		if (skb == NULL)
 			break;
 		skb_reserve(skb, 2);	/* 16 byte align the IP header. */
-		np->rx_ring[i].frag.addr = cpu_to_le32(
-			dma_map_single(&np->pci_dev->dev, skb->data,
-				np->rx_buf_sz, DMA_FROM_DEVICE));
-		if (dma_mapping_error(&np->pci_dev->dev,
-					np->rx_ring[i].frag.addr)) {
+		addr = dma_map_single(&np->pci_dev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pci_dev->dev, addr)) {
 			dev_kfree_skb(skb);
 			np->rx_skbuff[i] = NULL;
 			break;
 		}
+		np->rx_ring[i].frag.addr = cpu_to_le32(addr);
 		np->rx_ring[i].frag.length = cpu_to_le32(np->rx_buf_sz | LastFrag);
 	}
 	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
@@ -1088,6 +1089,7 @@ start_tx (struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	struct netdev_desc *txdesc;
+	dma_addr_t addr;
 	unsigned entry;
 
 	/* Calculate the next Tx descriptor entry. */
@@ -1095,13 +1097,14 @@ start_tx (struct sk_buff *skb, struct net_device *dev)
 	np->tx_skbuff[entry] = skb;
 	txdesc = &np->tx_ring[entry];
 
+	addr = dma_map_single(&np->pci_dev->dev, skb->data, skb->len,
+			      DMA_TO_DEVICE);
+	if (dma_mapping_error(&np->pci_dev->dev, addr))
+		goto drop_frame;
+
 	txdesc->next_desc = 0;
 	txdesc->status = cpu_to_le32 ((entry << 2) | DisableAlign);
-	txdesc->frag.addr = cpu_to_le32(dma_map_single(&np->pci_dev->dev,
-				skb->data, skb->len, DMA_TO_DEVICE));
-	if (dma_mapping_error(&np->pci_dev->dev,
-				txdesc->frag.addr))
-			goto drop_frame;
+	txdesc->frag.addr = cpu_to_le32(addr);
 	txdesc->frag.length = cpu_to_le32 (skb->len | LastFrag);
 
 	/* Increment cur_tx before tasklet_schedule() */
@@ -1419,6 +1422,8 @@ static void refill_rx (struct net_device *dev)
 	for (;(np->cur_rx - np->dirty_rx + RX_RING_SIZE) % RX_RING_SIZE > 0;
 		np->dirty_rx = (np->dirty_rx + 1) % RX_RING_SIZE) {
 		struct sk_buff *skb;
+		dma_addr_t addr;
+
 		entry = np->dirty_rx % RX_RING_SIZE;
 		if (np->rx_skbuff[entry] == NULL) {
 			skb = netdev_alloc_skb(dev, np->rx_buf_sz + 2);
@@ -1426,15 +1431,15 @@ static void refill_rx (struct net_device *dev)
 			if (skb == NULL)
 				break;		/* Better luck next round. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			np->rx_ring[entry].frag.addr = cpu_to_le32(
-				dma_map_single(&np->pci_dev->dev, skb->data,
-					np->rx_buf_sz, DMA_FROM_DEVICE));
-			if (dma_mapping_error(&np->pci_dev->dev,
-				    np->rx_ring[entry].frag.addr)) {
+			addr = dma_map_single(&np->pci_dev->dev, skb->data,
+					      np->rx_buf_sz, DMA_FROM_DEVICE);
+			if (dma_mapping_error(&np->pci_dev->dev, addr)) {
 			    dev_kfree_skb_irq(skb);
 			    np->rx_skbuff[entry] = NULL;
 			    break;
 			}
+
+			np->rx_ring[entry].frag.addr = cpu_to_le32(addr);
 		}
 		/* Perhaps we need not reset this field. */
 		np->rx_ring[entry].frag.length =
-- 
2.51.0


