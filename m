Return-Path: <netdev+bounces-279630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGllEhmO5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A242638F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E1D0304CEA8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E62379EDC;
	Mon, 20 Apr 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="kmFKTkdU"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B1377578;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651659; cv=none; b=G6LGYXwlOZ29gmW7QRu/YGQoYfLYPfR9ISqEFioelQs/XM8bwzWBBOPiClA55BoxG4RdzrgZWG8YMJn06ooRtO7zK3RjzW8vJ03TPmvS2SWV9T/lfFMNe0CFwJscemayjG4mnpP7z48RWNIGnvfrqqjmczsj/+TigKvLpJUlYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651659; c=relaxed/simple;
	bh=vn6hjpycZXNuSGq4lvrMeKXhiAvathN5/3PhYZ529Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBPmtTV8kXiSMNWUbxQiZ0B49bhDrD1v7yz6PTCyY9vBR4KL9ddpKIShy9ETaT9KZrj2TJY16C+DcU2MWXy84NVW4bn9xYOLSBg9jHB5ssA3Z4xwsH/QvS31oAD4Q2j3U0IjPryx7jVrwQE4NgF2XxOT4SxqVqTszliVL6x0QmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=kmFKTkdU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KDBl8277433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651614;
	bh=h2GX1lW2lel+asORDWiJeK0QZqoe1ReFeJMfHQnb3zo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kmFKTkdUu6EXa1YIhUvW/OxEGNqOyjoZqk4+yMhTRyEZi9R99toovFiMtdXR3FBUy
	 5g1aCnbYYkJYYUUAzW3Qfst/228P6V0xaLLVVs2WD9XNzciZxaebcJcyv55dN/QJ6S
	 qTy1zOlvZtIfyTW+DNLBlouB2AVHSCQQW3qkkU3cv2Mr6mbDWSuZGSPsvlHDCamd8M
	 r/OtXtK2AH66FZRxwRLP9DGdy1YoWaqgty+53H06adYYjIjAP1VtzsgoCovrpkuCtw
	 8php3R3XtVWgl/Lo4Oxj5CUe788tJuNr9NU91n04DiCzs+IoNBOWHdnr5cFE7d5uXh
	 hz4IPMtqrp+EQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KDBl8277433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:14 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 10:20:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 3/9] r8169: add support for multi tx queues
Date: Mon, 20 Apr 2026 10:19:51 +0800
Message-ID: <20260420021957.1756-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279630-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Queue-Id: 9B3A242638F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch support for multi tx queues. But we still use one tx queue
here. More support will be available in rss support patch.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 278 ++++++++++++++++------
 1 file changed, 199 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d1f3a208bd1b..05f0cb532a31 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -73,7 +73,6 @@
 #define R8169_RX_BUF_SIZE	(SZ_16K - 1)
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
-#define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
 #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
@@ -794,6 +793,18 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_tx_ring {
+	u32 index;				/* Tx queue index */
+	u32 cur_tx;				/* Index into the Tx descriptor buffer of next Tx pkt. */
+	u32 dirty_tx;				/* Index into the Tx descriptor buffer for recycling. */
+	u32 num_tx_desc;			/* num of Tx desc */
+	struct TxDesc *TxDescArray;		/* array of Rx Desc*/
+	u32 TxDescAllocSize;			/* memory size per descs of ring */
+	dma_addr_t TxPhyAddr;			/* Tx desc physical address */
+	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	u16 tdsar_reg;				/* Transmit Descriptor Start Address */
+};
+
 struct rtl8169_napi {
 	struct napi_struct napi;
 	void *priv;
@@ -823,16 +834,12 @@ struct rtl8169_private {
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
-	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
-	u32 dirty_tx;
-	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
 	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
-	dma_addr_t TxPhyAddr;
 	dma_addr_t RxPhyAddr;
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
-	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
 	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
 	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
+	struct rtl8169_tx_ring tx_ring[R8169_MAX_TX_QUEUES];
 	u16 isr_reg[R8169_MAX_MSIX_VEC];
 	u16 imr_reg[R8169_MAX_MSIX_VEC];
 	unsigned int num_tx_rings;
@@ -840,11 +847,14 @@ struct rtl8169_private {
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u16 HwSuppNumTxQueues;
 	u8 min_irq_nvecs;
 	u8 max_irq_nvecs;
 	u8 HwSuppIsrVer;
 	u8 HwCurrIsrVer;
 	u8 irq_nvecs;
+	u8 recheck_desc_ownbit;
+	unsigned int features;
 	int irq;
 	struct clk *clk;
 
@@ -2718,9 +2728,28 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_tx_desc_init(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->num_tx_rings; i++) {
+		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
+
+		memset(ring->TxDescArray, 0x0, ring->TxDescAllocSize);
+		ring->TxDescArray[ring->num_tx_desc - 1].opts1 = cpu_to_le32(RingEnd);
+	}
+}
+
 static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 {
-	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
+	struct net_device *dev = tp->dev;
+
+	for (int i = 0; i < tp->HwSuppNumTxQueues; i++) {
+		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
+
+		ring->dirty_tx = 0;
+		ring->cur_tx = 0;
+		ring->index = i;
+		netdev_tx_reset_queue(netdev_get_tx_queue(dev, i));
+	}
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -2779,8 +2808,18 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_set_ring_size(struct rtl8169_private *tp, u32 rx_num, u32 tx_num)
+{
+	for (int i = 0; i < tp->HwSuppNumTxQueues; i++)
+		tp->tx_ring[i].num_tx_desc = tx_num;
+}
+
 static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
 {
+	tp->tx_ring[0].tdsar_reg = TxDescStartAddrLow;
+	for (int i = 1; i < tp->HwSuppNumTxQueues; i++)
+		tp->tx_ring[i].tdsar_reg = (u16)(TNPDS_Q1_LOW + (i - 1) * 8);
+
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
 		tp->isr_reg[0] = IntrStatus;
 		tp->imr_reg[0] = IntrMask;
@@ -2805,17 +2844,20 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_80:
 		tp->min_irq_nvecs = R8127_MIN_IRQ;
 		tp->max_irq_nvecs = R8127_MAX_IRQ;
+		tp->HwSuppNumTxQueues = R8127_MAX_TX_QUEUES;
 		tp->HwSuppIsrVer = 6;
 		break;
 	default:
 		tp->min_irq_nvecs = 1;
 		tp->max_irq_nvecs = 1;
+		tp->HwSuppNumTxQueues = 1;
 		tp->HwSuppIsrVer = 1;
 		break;
 	}
 	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
 
 	rtl_setup_mqs_reg(tp);
+	rtl_set_ring_size(tp, NUM_RX_DESC, NUM_TX_DESC);
 }
 
 static void rtl_request_firmware(struct rtl8169_private *tp)
@@ -2947,10 +2989,14 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 	 * register to be written before TxDescAddrLow to work.
 	 * Switching from MMIO to I/O access fixes the issue as well.
 	 */
-	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
-	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
 	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
 	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
+	for (int i = 0; i < tp->num_tx_rings; i++) {
+		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
+
+		RTL_W32(tp, ring->tdsar_reg, ((u64)ring->TxPhyAddr & DMA_BIT_MASK(32)));
+		RTL_W32(tp, ring->tdsar_reg + 4, ((u64)ring->TxPhyAddr >> 32));
+	}
 }
 
 static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
@@ -4357,43 +4403,85 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
 	return 0;
 }
 
+static int rtl8169_alloc_tx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_tx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_tx_rings; i++) {
+		ring = &tp->tx_ring[i];
+		ring->TxDescAllocSize = (ring->num_tx_desc + 1) * sizeof(struct TxDesc);
+		ring->TxDescArray = dma_alloc_coherent(&pdev->dev,
+						       ring->TxDescAllocSize,
+						       &ring->TxPhyAddr,
+						       GFP_KERNEL);
+		if (!ring->TxDescArray)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static void rtl8169_free_tx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_tx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_tx_rings; i++) {
+		ring = &tp->tx_ring[i];
+		if (ring->TxDescArray) {
+			dma_free_coherent(&pdev->dev,
+					  ring->TxDescAllocSize,
+					  ring->TxDescArray,
+					  ring->TxPhyAddr);
+			ring->TxDescArray = NULL;
+		}
+	}
+}
+
 
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	int retval = 0;
+
 	rtl8169_init_ring_indexes(tp);
+	rtl8169_tx_desc_init(tp);
+
+	for (int i = 0; i < tp->num_tx_rings; i++) {
+		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
+
+		memset(ring->tx_skb, 0x0, sizeof(ring->tx_skb));
+	}
+
 
-	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
-	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
 	return rtl8169_rx_fill(tp);
 }
 
-static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
+static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp,
+				 struct ring_info *tx_skb,
+				 struct TxDesc *desc)
 {
-	struct ring_info *tx_skb = tp->tx_skb + entry;
-	struct TxDesc *desc = tp->TxDescArray + entry;
+	dma_unmap_single(tp_to_dev(tp), le64_to_cpu(desc->addr), tx_skb->len, DMA_TO_DEVICE);
 
-	dma_unmap_single(tp_to_dev(tp), le64_to_cpu(desc->addr), tx_skb->len,
-			 DMA_TO_DEVICE);
 	memset(desc, 0, sizeof(*desc));
 	memset(tx_skb, 0, sizeof(*tx_skb));
 
 }
 
-static void rtl8169_tx_clear_range(struct rtl8169_private *tp, u32 start,
-				   unsigned int n)
+static void rtl8169_tx_clear_range(struct rtl8169_private *tp, struct rtl8169_tx_ring *ring,
+				   u32 start, unsigned int n)
 {
 	unsigned int i;
 
 	for (i = 0; i < n; i++) {
-		unsigned int entry = (start + i) % NUM_TX_DESC;
-		struct ring_info *tx_skb = tp->tx_skb + entry;
+		unsigned int entry = (start + i) % ring->num_tx_desc;
+		struct ring_info *tx_skb = ring->tx_skb + entry;
 		unsigned int len = tx_skb->len;
 
 		if (len) {
 			struct sk_buff *skb = tx_skb->skb;
 
-			rtl8169_unmap_tx_skb(tp, entry);
+			rtl8169_unmap_tx_skb(tp, tx_skb, ring->TxDescArray + entry);
 			if (skb)
 				dev_consume_skb_any(skb);
 		}
@@ -4402,7 +4490,13 @@ static void rtl8169_tx_clear_range(struct rtl8169_private *tp, u32 start,
 
 static void rtl8169_tx_clear(struct rtl8169_private *tp)
 {
-	rtl8169_tx_clear_range(tp, tp->dirty_tx, NUM_TX_DESC);
+	for (int i = 0; i < tp->num_tx_rings; i++) {
+		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
+
+		rtl8169_tx_clear_range(tp, ring, ring->dirty_tx, ring->num_tx_desc);
+		ring->cur_tx = 0;
+		ring->dirty_tx = 0;
+	}
 	netdev_reset_queue(tp->dev);
 }
 
@@ -4478,10 +4572,15 @@ static void rtl8169_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	rtl_schedule_task(tp, RTL_FLAG_TASK_TX_TIMEOUT);
 }
 
-static int rtl8169_tx_map(struct rtl8169_private *tp, const u32 *opts, u32 len,
-			  void *addr, unsigned int entry, bool desc_own)
+static int rtl8169_tx_map(struct rtl8169_private *tp,
+			  struct rtl8169_tx_ring *ring,
+			  const u32 *opts,
+			  u32 len,
+			  void *addr,
+			  unsigned int entry,
+			  bool desc_own)
 {
-	struct TxDesc *txd = tp->TxDescArray + entry;
+	struct TxDesc *txd = ring->TxDescArray + entry;
 	struct device *d = tp_to_dev(tp);
 	dma_addr_t mapping;
 	u32 opts1;
@@ -4505,13 +4604,16 @@ static int rtl8169_tx_map(struct rtl8169_private *tp, const u32 *opts, u32 len,
 		opts1 |= DescOwn;
 	txd->opts1 = cpu_to_le32(opts1);
 
-	tp->tx_skb[entry].len = len;
+	ring->tx_skb[entry].len = len;
 
 	return 0;
 }
 
-static int rtl8169_xmit_frags(struct rtl8169_private *tp, struct sk_buff *skb,
-			      const u32 *opts, unsigned int entry)
+static int rtl8169_xmit_frags(struct rtl8169_private *tp,
+			      struct rtl8169_tx_ring *ring,
+			      struct sk_buff *skb,
+			      const u32 *opts,
+			      unsigned int entry)
 {
 	struct skb_shared_info *info = skb_shinfo(skb);
 	unsigned int cur_frag;
@@ -4523,14 +4625,14 @@ static int rtl8169_xmit_frags(struct rtl8169_private *tp, struct sk_buff *skb,
 
 		entry = (entry + 1) % NUM_TX_DESC;
 
-		if (unlikely(rtl8169_tx_map(tp, opts, len, addr, entry, true)))
+		if (unlikely(rtl8169_tx_map(tp, ring, opts, len, addr, entry, true)))
 			goto err_out;
 	}
 
 	return 0;
 
 err_out:
-	rtl8169_tx_clear_range(tp, tp->cur_tx + 1, cur_frag);
+	rtl8169_tx_clear_range(tp, ring, ring->cur_tx + 1, cur_frag);
 	return -EIO;
 }
 
@@ -4684,9 +4786,9 @@ static bool rtl8169_tso_csum_v2(struct rtl8169_private *tp,
 	return true;
 }
 
-static unsigned int rtl_tx_slots_avail(struct rtl8169_private *tp)
+static unsigned int rtl_tx_slots_avail(struct rtl8169_tx_ring *ring)
 {
-	return READ_ONCE(tp->dirty_tx) + NUM_TX_DESC - READ_ONCE(tp->cur_tx);
+	return READ_ONCE(ring->dirty_tx) + NUM_TX_DESC - READ_ONCE(ring->cur_tx);
 }
 
 /* Versions RTL8102e and from RTL8168c onwards support csum_v2 */
@@ -4701,10 +4803,10 @@ static bool rtl_chip_supports_csum_v2(struct rtl8169_private *tp)
 	}
 }
 
-static void rtl8169_doorbell(struct rtl8169_private *tp)
+static void rtl8169_doorbell(struct rtl8169_private *tp, struct rtl8169_tx_ring *ring)
 {
 	if (rtl_is_8125(tp))
-		RTL_W16(tp, TxPoll_8125, BIT(0));
+		RTL_W16(tp, TxPoll_8125, BIT(ring->index));
 	else
 		RTL_W8(tp, TxPoll, NPQ);
 }
@@ -4713,16 +4815,18 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
-	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
 	unsigned int frags;
 	u32 opts[2];
+	const u16 queue_mapping = skb_get_queue_mapping(skb);
+	struct rtl8169_tx_ring *ring = &tp->tx_ring[queue_mapping];
+	unsigned int entry = ring->cur_tx % ring->num_tx_desc;
 
-	if (unlikely(!rtl_tx_slots_avail(tp))) {
+	if (unlikely(!rtl_tx_slots_avail(ring))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
-		netif_stop_queue(dev);
+		netif_stop_subqueue(dev, queue_mapping);
 		return NETDEV_TX_BUSY;
 	}
 
@@ -4734,47 +4838,49 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	else if (!rtl8169_tso_csum_v2(tp, skb, opts))
 		goto err_dma_0;
 
-	if (unlikely(rtl8169_tx_map(tp, opts, skb_headlen(skb), skb->data,
+	if (unlikely(rtl8169_tx_map(tp, ring, opts, skb_headlen(skb), skb->data,
 				    entry, false)))
 		goto err_dma_0;
 
-	txd_first = tp->TxDescArray + entry;
+	txd_first = ring->TxDescArray + entry;
 
 	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
-		if (rtl8169_xmit_frags(tp, skb, opts, entry))
+		if (rtl8169_xmit_frags(tp, ring, skb, opts, entry))
 			goto err_dma_1;
 		entry = (entry + frags) % NUM_TX_DESC;
 	}
 
-	txd_last = tp->TxDescArray + entry;
+	txd_last = ring->TxDescArray + entry;
 	txd_last->opts1 |= cpu_to_le32(LastFrag);
-	tp->tx_skb[entry].skb = skb;
+	ring->tx_skb[entry].skb = skb;
 
 	skb_tx_timestamp(skb);
 
 	/* Force memory writes to complete before releasing descriptor */
 	dma_wmb();
 
-	door_bell = __netdev_sent_queue(dev, skb->len, netdev_xmit_more());
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_mapping);
+
+	door_bell = __netdev_tx_sent_queue(txq, skb->len, netdev_xmit_more());
 
 	txd_first->opts1 |= cpu_to_le32(DescOwn | FirstFrag);
 
 	/* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
 	smp_wmb();
 
-	WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
+	WRITE_ONCE(ring->cur_tx, ring->cur_tx + frags + 1);
 
-	stop_queue = !netif_subqueue_maybe_stop(dev, 0, rtl_tx_slots_avail(tp),
+	stop_queue = !netif_subqueue_maybe_stop(dev, 0, rtl_tx_slots_avail(ring),
 						R8169_TX_STOP_THRS,
 						R8169_TX_START_THRS);
 	if (door_bell || stop_queue)
-		rtl8169_doorbell(tp);
+		rtl8169_doorbell(tp, ring);
 
 	return NETDEV_TX_OK;
 
 err_dma_1:
-	rtl8169_unmap_tx_skb(tp, entry);
+	rtl8169_unmap_tx_skb(tp, ring->tx_skb + entry, txd_first);
 err_dma_0:
 	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
@@ -4859,24 +4965,38 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 }
 
-static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
-		   int budget)
+static void rtl8169_desc_quirk(struct rtl8169_private *tp)
+{
+	RTL_R8(tp, tp->imr_reg[0]);
+}
+
+static int rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
+		  struct rtl8169_tx_ring *ring, int budget)
 {
 	unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
 	struct sk_buff *skb;
+	u32 status;
+	unsigned int count = 0;
+
+	dirty_tx = ring->dirty_tx;
+
+	while (READ_ONCE(ring->cur_tx) != dirty_tx) {
+		unsigned int entry = dirty_tx % ring->num_tx_desc;
+		struct ring_info *tx_skb = ring->tx_skb + entry;
+
+		status = le32_to_cpu(READ_ONCE(ring->TxDescArray[entry].opts1));
+		if (status & DescOwn) {
+			if (!tp->recheck_desc_ownbit)
+				break;
+			tp->recheck_desc_ownbit = false;
+			rtl8169_desc_quirk(tp);
+			status = le32_to_cpu(READ_ONCE(ring->TxDescArray[entry].opts1));
+			if (status & DescOwn)
+				break;
+		}
 
-	dirty_tx = tp->dirty_tx;
-
-	while (READ_ONCE(tp->cur_tx) != dirty_tx) {
-		unsigned int entry = dirty_tx % NUM_TX_DESC;
-		u32 status;
-
-		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
-		if (status & DescOwn)
-			break;
-
-		skb = tp->tx_skb[entry].skb;
-		rtl8169_unmap_tx_skb(tp, entry);
+		skb = tx_skb->skb;
+		rtl8169_unmap_tx_skb(tp, tx_skb, ring->TxDescArray + entry);
 
 		if (skb) {
 			pkts_compl++;
@@ -4886,12 +5006,13 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		dirty_tx++;
 	}
 
-	if (tp->dirty_tx != dirty_tx) {
+	if (ring->dirty_tx != dirty_tx) {
+		count = dirty_tx - ring->dirty_tx;
 		dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
-		WRITE_ONCE(tp->dirty_tx, dirty_tx);
+		WRITE_ONCE(ring->dirty_tx, dirty_tx);
 
 		netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
-					      rtl_tx_slots_avail(tp),
+					      rtl_tx_slots_avail(ring),
 					      R8169_TX_START_THRS);
 		/*
 		 * 8168 hack: TxPoll requests are lost when the Tx packets are
@@ -4901,9 +5022,10 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		 * If skb is NULL then we come here again once a tx irq is
 		 * triggered after the last fragment is marked transmitted.
 		 */
-		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
-			rtl8169_doorbell(tp);
+		if (READ_ONCE(ring->cur_tx) != dirty_tx && skb)
+			rtl8169_doorbell(tp, ring);
 	}
+	return count;
 }
 
 static inline int rtl8169_fragmented_frame(u32 status)
@@ -5027,6 +5149,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
+	tp->recheck_desc_ownbit = true;
 	napi_schedule(&napi->napi);
 out:
 	rtl_ack_events(tp, status);
@@ -5113,7 +5236,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	struct net_device *dev = tp->dev;
 	int work_done = 0;
 
-	rtl_tx(dev, tp, budget);
+	for (int i = 0; i < tp->num_tx_rings; i++)
+		rtl_tx(dev, tp, &tp->tx_ring[i], budget);
 
 	work_done = rtl_rx(dev, tp, budget);
 
@@ -5256,10 +5380,8 @@ static int rtl8169_close(struct net_device *dev)
 
 	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
 			  tp->RxPhyAddr);
-	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
-			  tp->TxPhyAddr);
-	tp->TxDescArray = NULL;
 	tp->RxDescArray = NULL;
+	rtl8169_free_tx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
 
@@ -5288,20 +5410,17 @@ static int rtl_open(struct net_device *dev)
 	 * Rx and Tx descriptors needs 256 bytes alignment.
 	 * dma_alloc_coherent provides more.
 	 */
-	tp->TxDescArray = dma_alloc_coherent(&pdev->dev, R8169_TX_RING_BYTES,
-					     &tp->TxPhyAddr, GFP_KERNEL);
-	if (!tp->TxDescArray)
-		goto out;
 
 	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
 					     &tp->RxPhyAddr, GFP_KERNEL);
-	if (!tp->RxDescArray)
+	if (rtl8169_alloc_tx_desc(tp) < 0)
 		goto err_free_tx_0;
 
 	retval = rtl8169_init_ring(tp);
 	if (retval < 0)
 		goto err_free_rx_1;
 
+
 	rtl_request_firmware(tp);
 
 	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
@@ -5331,9 +5450,7 @@ static int rtl_open(struct net_device *dev)
 			  tp->RxPhyAddr);
 	tp->RxDescArray = NULL;
 err_free_tx_0:
-	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
-			  tp->TxPhyAddr);
-	tp->TxDescArray = NULL;
+	rtl8169_free_tx_desc(tp);
 	goto out;
 }
 
@@ -5842,7 +5959,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 txconfig;
 	u32 xid;
 
-	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
+				      R8169_MAX_TX_QUEUES,
+				      R8169_MAX_RX_QUEUES);
+
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.43.0


