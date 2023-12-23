Return-Path: <netdev+bounces-60062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5FB81D2E7
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 08:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D642284313
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CEC6FB0;
	Sat, 23 Dec 2023 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uqs/8ypS"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47C6ABF
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9szOKQ6i+JFJi3oEPiuGG7aoH7Kssgh60d1yS3GEzMA=; b=Uqs/8ypSyi17Nf+f1vMSmx76oT
	Cy5GimZrtiDcaFousaoHpflufGpUe3kYcGiOsvKrLWmd33/VCuvfxK1Ii1JIOEEAGaMgHaNK0tPpS
	8zHO7YSANo5xCNGFk5Sk5NynCLoWfKFDPJxAOLcanuHpoZMPCBBfmExIXsvmbeDihYx4npLaVSe1s
	GK9qMDX1ddoKTlWNC7ngo9kCe+dhy8+1Q1Nk0+/u+xUHuIAq44tNin6wAw6mTb2aUzwAekicvERMK
	0V7JuImRXO4lgKyB/BSR7Jyw+/O30N3TqtlEaJFV0yXBiQcn54EAXRL8RjAscoYIrQFdxNmfttZKj
	I2UqyhvQ==;
Received: from om126166238204.28.openmobile.ne.jp ([126.166.238.204] helo=[192.168.43.165])
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGwQw-00AARu-5v; Sat, 23 Dec 2023 07:28:32 +0000
Message-ID: <2e4bd247-e217-47a6-a7e3-20375d05ff25@infradead.org>
Date: Sat, 23 Dec 2023 16:28:20 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v1] net/ps3_gelic_net: Add gelic_descr structures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In an effort to make the PS3 gelic driver easier to maintain, create two
new structures, struct gelic_hw_regs and struct gelic_chain_link, and
replace the corresponding members of struct gelic_descr with the new
structures.

The new struct gelic_hw_regs holds the register variables used by the
gelic hardware device.  The new struct gelic_chain_link holds variables
used to manage the driver's linked list of gelic descr structures.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 177 ++++++++++---------
 drivers/net/ethernet/toshiba/ps3_gelic_net.h |  24 ++-
 2 files changed, 109 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 9d535ae59626..d5b75af163d3 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -93,12 +93,13 @@ static void gelic_card_get_ether_port_status(struct gelic_card *card,
  * gelic_descr_get_status -- returns the status of a descriptor
  * @descr: descriptor to look at
  *
- * returns the status as in the dmac_cmd_status field of the descriptor
+ * returns the status as in the hw_regs.dmac_cmd_status field of the descriptor
  */
 static enum gelic_descr_dma_status
 gelic_descr_get_status(struct gelic_descr *descr)
 {
-	return be32_to_cpu(descr->dmac_cmd_status) & GELIC_DESCR_DMA_STAT_MASK;
+	return be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
+		GELIC_DESCR_DMA_STAT_MASK;
 }
 
 static int gelic_card_set_link_mode(struct gelic_card *card, int mode)
@@ -152,15 +153,15 @@ static void gelic_card_enable_rxdmac(struct gelic_card *card)
 	if (gelic_descr_get_status(card->rx_chain.head) !=
 	    GELIC_DESCR_DMA_CARDOWNED) {
 		printk(KERN_ERR "%s: status=%x\n", __func__,
-		       be32_to_cpu(card->rx_chain.head->dmac_cmd_status));
+		       be32_to_cpu(card->rx_chain.head->hw_regs.dmac_cmd_status));
 		printk(KERN_ERR "%s: nextphy=%x\n", __func__,
-		       be32_to_cpu(card->rx_chain.head->next_descr_addr));
+		       be32_to_cpu(card->rx_chain.head->hw_regs.next_descr_addr));
 		printk(KERN_ERR "%s: head=%p\n", __func__,
 		       card->rx_chain.head);
 	}
 #endif
 	status = lv1_net_start_rx_dma(bus_id(card), dev_id(card),
-				card->rx_chain.head->bus_addr, 0);
+				card->rx_chain.head->link.cpu_addr, 0);
 	if (status)
 		dev_info(ctodev(card),
 			 "lv1_net_start_rx_dma failed, status=%d\n", status);
@@ -195,8 +196,8 @@ static void gelic_card_disable_rxdmac(struct gelic_card *card)
 static void gelic_descr_set_status(struct gelic_descr *descr,
 				   enum gelic_descr_dma_status status)
 {
-	descr->dmac_cmd_status = cpu_to_be32(status |
-			(be32_to_cpu(descr->dmac_cmd_status) &
+	descr->hw_regs.dmac_cmd_status = cpu_to_be32(status |
+			(be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
 			 ~GELIC_DESCR_DMA_STAT_MASK));
 	/*
 	 * dma_cmd_status field is used to indicate whether the descriptor
@@ -224,13 +225,14 @@ static void gelic_card_reset_chain(struct gelic_card *card,
 
 	for (descr = start_descr; start_descr != descr->next; descr++) {
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_CARDOWNED);
-		descr->next_descr_addr = cpu_to_be32(descr->next->bus_addr);
+		descr->hw_regs.next_descr_addr
+			= cpu_to_be32(descr->next->link.cpu_addr);
 	}
 
 	chain->head = start_descr;
 	chain->tail = (descr - 1);
 
-	(descr - 1)->next_descr_addr = 0;
+	(descr - 1)->hw_regs.next_descr_addr = 0;
 }
 
 void gelic_card_up(struct gelic_card *card)
@@ -286,10 +288,12 @@ static void gelic_card_free_chain(struct gelic_card *card,
 {
 	struct gelic_descr *descr;
 
-	for (descr = descr_in; descr && descr->bus_addr; descr = descr->next) {
-		dma_unmap_single(ctodev(card), descr->bus_addr,
-				 GELIC_DESCR_SIZE, DMA_BIDIRECTIONAL);
-		descr->bus_addr = 0;
+	for (descr = descr_in; descr && descr->link.cpu_addr;
+		descr = descr->next) {
+		dma_unmap_single(ctodev(card), descr->link.cpu_addr,
+				 descr->link.size, DMA_BIDIRECTIONAL);
+		descr->link.cpu_addr = 0;
+		descr->link.size = 0;
 	}
 }
 
@@ -317,17 +321,21 @@ static int gelic_card_init_chain(struct gelic_card *card,
 
 	/* set up the hardware pointers in each descriptor */
 	for (i = 0; i < no; i++, descr++) {
-		dma_addr_t cpu_addr;
-
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 
-		cpu_addr = dma_map_single(ctodev(card), descr,
-					  GELIC_DESCR_SIZE, DMA_BIDIRECTIONAL);
+		descr->link.size = sizeof(struct gelic_hw_regs);
+		descr->link.cpu_addr = dma_map_single(ctodev(card), descr,
+					  descr->link.size, DMA_BIDIRECTIONAL);
 
-		if (dma_mapping_error(ctodev(card), cpu_addr))
-			goto iommu_error;
+		if (dma_mapping_error(ctodev(card), descr->link.cpu_addr)) {
+			for (i--, descr--; 0 <= i; i--, descr--) {
+				dma_unmap_single(ctodev(card),
+					descr->link.cpu_addr, descr->link.size,
+					DMA_BIDIRECTIONAL);
+			}
+			return -ENOMEM;
+		}
 
-		descr->bus_addr = cpu_to_be32(cpu_addr);
 		descr->next = descr + 1;
 		descr->prev = descr - 1;
 	}
@@ -338,24 +346,17 @@ static int gelic_card_init_chain(struct gelic_card *card,
 	/* chain bus addr of hw descriptor */
 	descr = start_descr;
 	for (i = 0; i < no; i++, descr++) {
-		descr->next_descr_addr = cpu_to_be32(descr->next->bus_addr);
+		descr->hw_regs.next_descr_addr =
+			cpu_to_be32(descr->next->link.cpu_addr);
 	}
 
 	chain->head = start_descr;
 	chain->tail = start_descr;
 
 	/* do not chain last hw descriptor */
-	(descr - 1)->next_descr_addr = 0;
+	(descr - 1)->hw_regs.next_descr_addr = 0;
 
 	return 0;
-
-iommu_error:
-	for (i--, descr--; 0 <= i; i--, descr--)
-		if (descr->bus_addr)
-			dma_unmap_single(ctodev(card), descr->bus_addr,
-					 GELIC_DESCR_SIZE,
-					 DMA_BIDIRECTIONAL);
-	return -ENOMEM;
 }
 
 /**
@@ -385,14 +386,16 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 
 	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
 	if (!descr->skb) {
-		descr->buf_addr = 0; /* tell DMAC don't touch memory */
+		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
 		return -ENOMEM;
 	}
-	descr->buf_size = cpu_to_be32(rx_skb_size);
-	descr->dmac_cmd_status = 0;
-	descr->result_size = 0;
-	descr->valid_size = 0;
-	descr->data_error = 0;
+	descr->hw_regs.dmac_cmd_status = 0;
+	descr->hw_regs.result_size = 0;
+	descr->hw_regs.valid_size = 0;
+	descr->hw_regs.data_error = 0;
+	descr->hw_regs.payload.dev_addr = 0;
+	descr->hw_regs.payload.size = 0;
+	descr->skb = NULL;
 
 	offset = ((unsigned long)descr->skb->data) &
 		(GELIC_NET_RXBUF_ALIGN - 1);
@@ -401,7 +404,7 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	/* io-mmu-map the skb */
 	cpu_addr = dma_map_single(ctodev(card), descr->skb->data,
 				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
-	descr->buf_addr = cpu_to_be32(cpu_addr);
+	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
 	if (dma_mapping_error(ctodev(card), cpu_addr)) {
 		dev_kfree_skb_any(descr->skb);
 		descr->skb = NULL;
@@ -409,10 +412,14 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 			 "%s:Could not iommu-map rx buffer\n", __func__);
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 		return -ENOMEM;
-	} else {
-		gelic_descr_set_status(descr, GELIC_DESCR_DMA_CARDOWNED);
-		return 0;
 	}
+
+	descr->hw_regs.payload.size = cpu_to_be32(GELIC_NET_MAX_FRAME);
+	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
+
+	gelic_descr_set_status(descr, GELIC_DESCR_DMA_CARDOWNED);
+
+	return 0;
 }
 
 /**
@@ -427,14 +434,15 @@ static void gelic_card_release_rx_chain(struct gelic_card *card)
 	do {
 		if (descr->skb) {
 			dma_unmap_single(ctodev(card),
-					 be32_to_cpu(descr->buf_addr),
-					 descr->skb->len,
-					 DMA_FROM_DEVICE);
-			descr->buf_addr = 0;
+				be32_to_cpu(descr->hw_regs.payload.dev_addr),
+				descr->skb->len,
+				DMA_FROM_DEVICE);
+			descr->hw_regs.payload.dev_addr = 0;
+			descr->hw_regs.payload.size = 0;
 			dev_kfree_skb_any(descr->skb);
 			descr->skb = NULL;
 			gelic_descr_set_status(descr,
-					       GELIC_DESCR_DMA_NOT_IN_USE);
+				GELIC_DESCR_DMA_NOT_IN_USE);
 		}
 		descr = descr->next;
 	} while (descr != card->rx_chain.head);
@@ -496,19 +504,20 @@ static void gelic_descr_release_tx(struct gelic_card *card,
 {
 	struct sk_buff *skb = descr->skb;
 
-	BUG_ON(!(be32_to_cpu(descr->data_status) & GELIC_DESCR_TX_TAIL));
+	BUG_ON(!(be32_to_cpu(descr->hw_regs.data_status) & GELIC_DESCR_TX_TAIL));
 
-	dma_unmap_single(ctodev(card), be32_to_cpu(descr->buf_addr), skb->len,
-			 DMA_TO_DEVICE);
+	dma_unmap_single(ctodev(card),
+		be32_to_cpu(descr->hw_regs.payload.dev_addr), skb->len,
+		DMA_TO_DEVICE);
 	dev_kfree_skb_any(skb);
 
-	descr->buf_addr = 0;
-	descr->buf_size = 0;
-	descr->next_descr_addr = 0;
-	descr->result_size = 0;
-	descr->valid_size = 0;
-	descr->data_status = 0;
-	descr->data_error = 0;
+	descr->hw_regs.payload.dev_addr = 0;
+	descr->hw_regs.payload.size = 0;
+	descr->hw_regs.next_descr_addr = 0;
+	descr->hw_regs.result_size = 0;
+	descr->hw_regs.valid_size = 0;
+	descr->hw_regs.data_status = 0;
+	descr->hw_regs.data_error = 0;
 	descr->skb = NULL;
 
 	/* set descr status */
@@ -701,7 +710,7 @@ static void gelic_descr_set_tx_cmdstat(struct gelic_descr *descr,
 				       struct sk_buff *skb)
 {
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
-		descr->dmac_cmd_status =
+		descr->hw_regs.dmac_cmd_status =
 			cpu_to_be32(GELIC_DESCR_DMA_CMD_NO_CHKSUM |
 				    GELIC_DESCR_TX_DMA_FRAME_TAIL);
 	else {
@@ -709,19 +718,19 @@ static void gelic_descr_set_tx_cmdstat(struct gelic_descr *descr,
 		 * if yes: tcp? udp? */
 		if (skb->protocol == htons(ETH_P_IP)) {
 			if (ip_hdr(skb)->protocol == IPPROTO_TCP)
-				descr->dmac_cmd_status =
+				descr->hw_regs.dmac_cmd_status =
 				cpu_to_be32(GELIC_DESCR_DMA_CMD_TCP_CHKSUM |
 					    GELIC_DESCR_TX_DMA_FRAME_TAIL);
 
 			else if (ip_hdr(skb)->protocol == IPPROTO_UDP)
-				descr->dmac_cmd_status =
+				descr->hw_regs.dmac_cmd_status =
 				cpu_to_be32(GELIC_DESCR_DMA_CMD_UDP_CHKSUM |
 					    GELIC_DESCR_TX_DMA_FRAME_TAIL);
 			else	/*
 				 * the stack should checksum non-tcp and non-udp
 				 * packets on his own: NETIF_F_IP_CSUM
 				 */
-				descr->dmac_cmd_status =
+				descr->hw_regs.dmac_cmd_status =
 				cpu_to_be32(GELIC_DESCR_DMA_CMD_NO_CHKSUM |
 					    GELIC_DESCR_TX_DMA_FRAME_TAIL);
 		}
@@ -789,11 +798,11 @@ static int gelic_descr_prepare_tx(struct gelic_card *card,
 		return -ENOMEM;
 	}
 
-	descr->buf_addr = cpu_to_be32(buf);
-	descr->buf_size = cpu_to_be32(skb->len);
+	descr->hw_regs.payload.dev_addr = cpu_to_be32(buf);
+	descr->hw_regs.payload.size = cpu_to_be32(skb->len);
 	descr->skb = skb;
-	descr->data_status = 0;
-	descr->next_descr_addr = 0; /* terminate hw descr */
+	descr->hw_regs.data_status = 0;
+	descr->hw_regs.next_descr_addr = 0; /* terminate hw descr */
 	gelic_descr_set_tx_cmdstat(descr, skb);
 
 	/* bump free descriptor pointer */
@@ -818,7 +827,7 @@ static int gelic_card_kick_txdma(struct gelic_card *card,
 	if (gelic_descr_get_status(descr) == GELIC_DESCR_DMA_CARDOWNED) {
 		card->tx_dma_progress = 1;
 		status = lv1_net_start_tx_dma(bus_id(card), dev_id(card),
-					      descr->bus_addr, 0);
+			descr->link.cpu_addr, 0);
 		if (status) {
 			card->tx_dma_progress = 0;
 			dev_info(ctodev(card), "lv1_net_start_txdma failed," \
@@ -871,7 +880,8 @@ netdev_tx_t gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 	 * link this prepared descriptor to previous one
 	 * to achieve high performance
 	 */
-	descr->prev->next_descr_addr = cpu_to_be32(descr->bus_addr);
+	descr->prev->hw_regs.next_descr_addr =
+		cpu_to_be32(descr->link.cpu_addr);
 	/*
 	 * as hardware descriptor is modified in the above lines,
 	 * ensure that the hardware sees it
@@ -884,12 +894,12 @@ netdev_tx_t gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 		 */
 		netdev->stats.tx_dropped++;
 		/* don't trigger BUG_ON() in gelic_descr_release_tx */
-		descr->data_status = cpu_to_be32(GELIC_DESCR_TX_TAIL);
+		descr->hw_regs.data_status = cpu_to_be32(GELIC_DESCR_TX_TAIL);
 		gelic_descr_release_tx(card, descr);
 		/* reset head */
 		card->tx_chain.head = descr;
 		/* reset hw termination */
-		descr->prev->next_descr_addr = 0;
+		descr->prev->hw_regs.next_descr_addr = 0;
 		dev_info(ctodev(card), "%s: kick failure\n", __func__);
 	}
 
@@ -914,21 +924,21 @@ static void gelic_net_pass_skb_up(struct gelic_descr *descr,
 	struct sk_buff *skb = descr->skb;
 	u32 data_status, data_error;
 
-	data_status = be32_to_cpu(descr->data_status);
-	data_error = be32_to_cpu(descr->data_error);
+	data_status = be32_to_cpu(descr->hw_regs.data_status);
+	data_error = be32_to_cpu(descr->hw_regs.data_error);
 	/* unmap skb buffer */
-	dma_unmap_single(ctodev(card), be32_to_cpu(descr->buf_addr),
-			 GELIC_NET_MAX_FRAME,
-			 DMA_FROM_DEVICE);
-
-	skb_put(skb, be32_to_cpu(descr->valid_size)?
-		be32_to_cpu(descr->valid_size) :
-		be32_to_cpu(descr->result_size));
-	if (!descr->valid_size)
+	dma_unmap_single(ctodev(card),
+		be32_to_cpu(descr->hw_regs.payload.dev_addr),
+		be32_to_cpu(descr->hw_regs.payload.size), DMA_FROM_DEVICE);
+
+	skb_put(skb, be32_to_cpu(descr->hw_regs.valid_size)?
+		be32_to_cpu(descr->hw_regs.valid_size) :
+		be32_to_cpu(descr->hw_regs.result_size));
+	if (!descr->hw_regs.valid_size)
 		dev_info(ctodev(card), "buffer full %x %x %x\n",
-			 be32_to_cpu(descr->result_size),
-			 be32_to_cpu(descr->buf_size),
-			 be32_to_cpu(descr->dmac_cmd_status));
+			 be32_to_cpu(descr->hw_regs.result_size),
+			 be32_to_cpu(descr->hw_regs.payload.size),
+			 be32_to_cpu(descr->hw_regs.dmac_cmd_status));
 
 	descr->skb = NULL;
 	/*
@@ -1039,14 +1049,14 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 
 	/* is the current descriptor terminated with next_descr == NULL? */
 	dmac_chain_ended =
-		be32_to_cpu(descr->dmac_cmd_status) &
+		be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
 		GELIC_DESCR_RX_DMA_CHAIN_END;
 	/*
 	 * So that always DMAC can see the end
 	 * of the descriptor chain to avoid
 	 * from unwanted DMAC overrun.
 	 */
-	descr->next_descr_addr = 0;
+	descr->hw_regs.next_descr_addr = 0;
 
 	/* change the descriptor state: */
 	gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
@@ -1063,7 +1073,8 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	/*
 	 * Set this descriptor the end of the chain.
 	 */
-	descr->prev->next_descr_addr = cpu_to_be32(descr->bus_addr);
+	descr->prev->hw_regs.next_descr_addr =
+		cpu_to_be32(descr->link.cpu_addr);
 
 	/*
 	 * If dmac chain was met, DMAC stopped.
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
index 0d98defb011e..f1f78de7705d 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
@@ -221,29 +221,35 @@ enum gelic_lv1_phy {
 	GELIC_LV1_PHY_ETHERNET_0	= 0x0000000000000002L,
 };
 
-/* size of hardware part of gelic descriptor */
-#define GELIC_DESCR_SIZE	(32)
-
 enum gelic_port_type {
 	GELIC_PORT_ETHERNET_0	= 0,
 	GELIC_PORT_WIRELESS	= 1,
 	GELIC_PORT_MAX
 };
 
-struct gelic_descr {
-	/* as defined by the hardware */
-	__be32 buf_addr;
-	__be32 buf_size;
+/* As defined by the gelic hardware device. */
+struct gelic_hw_regs {
+	struct  {
+		__be32 dev_addr;
+		__be32 size;
+	} __packed payload;
 	__be32 next_descr_addr;
 	__be32 dmac_cmd_status;
 	__be32 result_size;
 	__be32 valid_size;	/* all zeroes for tx */
 	__be32 data_status;
 	__be32 data_error;	/* all zeroes for tx */
+} __packed;
 
-	/* used in the driver */
+struct gelic_chain_link {
+	dma_addr_t cpu_addr;
+	unsigned int size;
+};
+
+struct gelic_descr {
+	struct gelic_hw_regs hw_regs;
+	struct gelic_chain_link link;
 	struct sk_buff *skb;
-	dma_addr_t bus_addr;
 	struct gelic_descr *next;
 	struct gelic_descr *prev;
 } __attribute__((aligned(32)));
-- 
2.34.1


