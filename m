Return-Path: <netdev+bounces-282258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMw5Lzev8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:11:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51418490444
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECD79303CD16
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307043A452E;
	Wed, 29 Apr 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="WVAnQ6wS"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58193A2568;
	Wed, 29 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446506; cv=none; b=k4eT9HaIUDG7HRFBIx2tblHwDEd9EqEJLDPcDlt2KcUUncU1gl+FyuqNAz844uY3tRsBGIIi0tFM3UQRHZcQkzJh+ORnwqj+xD0k0+ex5U7A77QEe1mbNYV9THUn24c7kDn7cO70VWGSFk9PHC3aS45QCmCfzGvrUob0mvQIk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446506; c=relaxed/simple;
	bh=vb9cnfdXvIuM6bPBXKVZZklRRxpMAw8vuhPPzaq4N1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUOt2sUPDb5pCr0J+5w4NdIjTcDifEoartuW9luFLp2ZWYPKTpoAMednVPzvAMGecKBoqCwOHgOzCWTZuRaKHhAnJqTjCcruTasNR0heGQbp0nGX/aiPZJLAzgEeYdj/osHHfg/A/+LCPn05gJRhxznqHT4NWFzO9uxIZUjDjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WVAnQ6wS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77rvcE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446473;
	bh=fWRlSXVBEx7mjYsXTkQsjkopc/hDJVZXxQVBbfybqRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WVAnQ6wSr6SBUYlZSVwm0Vfo+FSnlZHVRxigRfrEx6VVtcTrXNxOOXfbIj474XJnv
	 MJGfnq38ej7lPzrchSgld1956vugNfGsFc2y6lqRm8hkBgmhZvEszLUzWQsfrAt5+v
	 9AUIwecQd1+mnB66Axv71qSh1yrsybVHb8YcIpZIbiLZr0Dx8oS7WL3XcrZ0R4Rclw
	 hsugOUaBdqFndar+IAzJAb1Cp8u5H+s6YGAsh7zZlF6S64OynkWm04c6fF68PH/GMN
	 /B+Cm6vXILkLO4lnafKrBAgFh6LUVlSRfZ2i4Wupw4dYAwPjDoYE2xieHs0Cr6DoEK
	 MqkK/SlwXrozw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77rvcE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:53 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:53 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:53 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2 3/8] r8169: add support for multi rx queues
Date: Wed, 29 Apr 2026 15:07:45 +0800
Message-ID: <20260429070750.1477-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260429070750.1477-1-javen_xu@realsil.com.cn>
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 51418490444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-282258-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for multi rx queues. RSS requires multi rx
queues to receive packets. So we need struct rtl8169_rx_ring for each
queue.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
changes in v2:
 - add explaination on recheck_desc_ownbit, this is a workaround for
   hardware issues.
---
 drivers/net/ethernet/realtek/r8169_main.c | 308 +++++++++++++++++-----
 1 file changed, 241 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 31d85aa75943..5fd695ebe6bb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -74,7 +74,6 @@
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
 #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
@@ -777,6 +776,19 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_rx_ring {
+	u32 index;					/* Rx queue index */
+	u32 cur_rx;					/* Index of next Rx pkt. */
+	u32 dirty_rx;					/* Index for recycling. */
+	u32 num_rx_desc;				/* num of Rx desc */
+	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
+	u32 rx_desc_alloc_size;				/* memory size per descs of ring */
+	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
+	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
+	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
+	u16 rdsar_reg;					/* Receive Descriptor Start Address */
+};
+
 struct rtl8169_napi {
 	struct napi_struct napi;
 	void *priv;
@@ -805,28 +817,28 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
-	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
 	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
-	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
 	dma_addr_t TxPhyAddr;
-	dma_addr_t RxPhyAddr;
-	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
 	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
 	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
+	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
 	u16 isr_reg[R8169_MAX_MSIX_VEC];
 	u16 imr_reg[R8169_MAX_MSIX_VEC];
 	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u16 hw_supp_num_rx_queues;
 	u8 min_irq_nvecs;
 	u8 max_irq_nvecs;
 	u8 hw_supp_isr_ver;
 	u8 hw_curr_isr_ver;
 	u8 irq_nvecs;
+	u8 init_rx_desc_type;
+	u8 recheck_desc_ownbit;
 	int irq;
 	struct clk *clk;
 
@@ -2700,9 +2712,27 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_desc_array, 0x0, ring->rx_desc_alloc_size);
+	}
+}
+
 static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 {
-	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
+	tp->dirty_tx = 0;
+	tp->cur_tx = 0;
+
+	for (int i = 0; i < tp->hw_supp_num_rx_queues; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		ring->dirty_rx = 0;
+		ring->cur_rx = 0;
+		ring->index = i;
+	}
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -2761,8 +2791,18 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_set_ring_size(struct rtl8169_private *tp, u32 rx_num)
+{
+	for (int i = 0; i < tp->hw_supp_num_rx_queues; i++)
+		tp->rx_ring[i].num_rx_desc = rx_num;
+}
+
 static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
 {
+	tp->rx_ring[0].rdsar_reg = RxDescAddrLow;
+	for (int i = 1; i < tp->hw_supp_num_rx_queues; i++)
+		tp->rx_ring[i].rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
+
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
 		tp->isr_reg[0] = IntrStatus;
 		tp->imr_reg[0] = IntrMask;
@@ -2786,17 +2826,21 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_80:
 		tp->min_irq_nvecs = R8127_MIN_IRQ;
 		tp->max_irq_nvecs = R8127_MAX_IRQ;
+		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
 		tp->hw_supp_isr_ver = 6;
 		break;
 	default:
 		tp->min_irq_nvecs = 1;
 		tp->max_irq_nvecs = 1;
+		tp->hw_supp_num_rx_queues = 1;
 		tp->hw_supp_isr_ver = 1;
 		break;
 	}
+	tp->init_rx_desc_type = RX_DESC_RING_TYPE_DEFAULT;
 	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
 
 	rtl_setup_mqs_reg(tp);
+	rtl_set_ring_size(tp, NUM_RX_DESC);
 }
 
 static void rtl_request_firmware(struct rtl8169_private *tp)
@@ -2930,8 +2974,13 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 	 */
 	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
 	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
-	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
-	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		RTL_W32(tp, ring->rdsar_reg, ((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
+		RTL_W32(tp, ring->rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
+	}
 }
 
 static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
@@ -4267,7 +4316,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void rtl8169_mark_to_asic(struct RxDesc *desc)
+static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 {
 	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
 
@@ -4277,13 +4326,19 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
 	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
 }
 
+static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	rtl8169_mark_to_asic_default(desc);
+}
+
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
-					  struct RxDesc *desc)
+					  struct rtl8169_rx_ring *ring, unsigned int index)
 {
 	struct device *d = tp_to_dev(tp);
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
 	struct page *data;
+	struct RxDesc *desc = ring->rx_desc_array + index;
 
 	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
 	if (!data)
@@ -4297,55 +4352,111 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	desc->addr = cpu_to_le64(mapping);
-	rtl8169_mark_to_asic(desc);
+	ring->rx_desc_phy_addr[index] = mapping;
+	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
 }
 
-static void rtl8169_rx_clear(struct rtl8169_private *tp)
+static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
 
-	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
+	for (i = 0; i < NUM_RX_DESC && ring->rx_databuff[i]; i++) {
 		dma_unmap_page(tp_to_dev(tp),
-			       le64_to_cpu(tp->RxDescArray[i].addr),
+			       ring->rx_desc_phy_addr[i],
 			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
-		tp->Rx_databuff[i] = NULL;
-		tp->RxDescArray[i].addr = 0;
-		tp->RxDescArray[i].opts1 = 0;
+		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
+		ring->rx_databuff[i] = NULL;
+		ring->rx_desc_phy_addr[i] = 0;
+		ring->rx_desc_array[i].addr = 0;
+		ring->rx_desc_array[i].opts1 = 0;
 	}
 }
 
-static int rtl8169_rx_fill(struct rtl8169_private *tp)
+static void rtl8169_mark_as_last_descriptor_default(struct RxDesc *desc)
+{
+	desc->opts1 |= cpu_to_le32(RingEnd);
+}
+
+static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	rtl8169_mark_as_last_descriptor_default(desc);
+}
+
+static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
 
 	for (i = 0; i < NUM_RX_DESC; i++) {
 		struct page *data;
 
-		data = rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
+		data = rtl8169_alloc_rx_data(tp, ring, i);
 		if (!data) {
-			rtl8169_rx_clear(tp);
+			rtl8169_rx_clear(tp, ring);
 			return -ENOMEM;
 		}
-		tp->Rx_databuff[i] = data;
+		ring->rx_databuff[i] = data;
 	}
 
 	/* mark as last descriptor in the ring */
-	tp->RxDescArray[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
+	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
 
 	return 0;
 }
 
+static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_rx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		ring->rx_desc_alloc_size = (ring->num_rx_desc + 1) * sizeof(struct RxDesc);
+		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
+							 ring->rx_desc_alloc_size,
+							 &ring->rx_phy_addr,
+							 GFP_KERNEL);
+		if (!ring->rx_desc_array)
+			return -1;
+	}
+	return 0;
+}
+
+static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_rx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		if (ring->rx_desc_array) {
+			dma_free_coherent(&pdev->dev,
+					  ring->rx_desc_alloc_size,
+					  ring->rx_desc_array,
+					  ring->rx_phy_addr);
+			ring->rx_desc_array = NULL;
+		}
+	}
+}
+
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	int retval = 0;
+
 	rtl8169_init_ring_indexes(tp);
+	rtl8169_rx_desc_init(tp);
 
 	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
-	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
-	return rtl8169_rx_fill(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
+		retval = rtl8169_rx_fill(tp, ring);
+	}
+
+	return retval;
 }
 
 static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
@@ -4434,16 +4545,24 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 	rtl8169_init_ring_indexes(tp);
 }
 
-static void rtl_reset_work(struct rtl8169_private *tp)
+static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 {
-	int i;
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		for (int j = 0; j < ring->num_rx_desc; j++)
+			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
+	}
+}
 
+static void rtl_reset_work(struct rtl8169_private *tp)
+{
 	netif_stop_queue(tp->dev);
 
 	rtl8169_cleanup(tp);
 
-	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
+	rtl8169_rx_desc_reset(tp);
+
 	rtl8169_napi_enable(tp);
 
 	rtl_hw_start(tp);
@@ -4837,6 +4956,11 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 }
 
+static void rtl8169_desc_quirk(struct rtl8169_private *tp)
+{
+	RTL_R8(tp, tp->imr_reg[0]);
+}
+
 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		   int budget)
 {
@@ -4889,9 +5013,11 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
-static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
+static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
+					   struct sk_buff *skb,
+					   struct RxDesc *desc)
 {
-	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
+	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
 
 	if (status == RxProtoTCP || status == RxProtoUDP)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -4899,22 +5025,71 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
 		skb_checksum_none_assert(skb);
 }
 
-static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
+static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
+				   struct sk_buff *skb,
+				   struct RxDesc *desc)
+{
+	rtl8169_rx_csum_default(tp, skb, desc);
+}
+
+static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	return READ_ONCE(desc->opts1);
+}
+
+static bool rtl8169_check_rx_desc_error(struct net_device *dev,
+					struct rtl8169_private *tp,
+					u32 status)
+{
+	if (unlikely(status & RxRES)) {
+		if (status & (RxRWT | RxRUNT))
+			dev->stats.rx_length_errors++;
+		if (status & RxCRC)
+			dev->stats.rx_crc_errors++;
+		return true;
+	}
+	return false;
+}
+
+static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
+					     struct RxDesc *desc,
+					     dma_addr_t mapping)
+{
+	desc->addr = cpu_to_le64(mapping);
+}
+
+static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
+		  struct rtl8169_rx_ring *ring, int budget)
 {
 	struct device *d = tp_to_dev(tp);
 	int count;
 
-	for (count = 0; count < budget; count++, tp->cur_rx++) {
-		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
-		struct RxDesc *desc = tp->RxDescArray + entry;
+	for (count = 0; count < budget; count++, ring->cur_rx++) {
+		unsigned int pkt_size, entry = ring->cur_rx % ring->num_rx_desc;
+		struct RxDesc *desc = ring->rx_desc_array + entry;
 		struct sk_buff *skb;
 		const void *rx_buf;
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(READ_ONCE(desc->opts1));
-		if (status & DescOwn)
-			break;
+		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
+
+		if (status & DescOwn) {
+			if (!tp->recheck_desc_ownbit)
+				break;
+
+			/* Workaround for a hardware issue:
+			 * Hardware might trigger RX interrupt before the DMA
+			 * engine fully updates RX desc ownbit in host memory.
+			 * So we do a quirk and re-read to avoid missing RX
+			 * packets.
+			 */
+			tp->recheck_desc_ownbit = false;
+			rtl8169_desc_quirk(tp);
+			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
+			if (status & DescOwn)
+				break;
+		}
 
 		/* This barrier is needed to keep us from reading
 		 * any other fields out of the Rx descriptor until
@@ -4922,20 +5097,15 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		 */
 		dma_rmb();
 
-		if (unlikely(status & RxRES)) {
+		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
 			if (net_ratelimit())
 				netdev_warn(dev, "Rx ERROR. status = %08x\n",
 					    status);
+
 			dev->stats.rx_errors++;
-			if (status & (RxRWT | RxRUNT))
-				dev->stats.rx_length_errors++;
-			if (status & RxCRC)
-				dev->stats.rx_crc_errors++;
 
 			if (!(dev->features & NETIF_F_RXALL))
 				goto release_descriptor;
-			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
-				goto release_descriptor;
 		}
 
 		pkt_size = status & GENMASK(13, 0);
@@ -4951,14 +5121,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
+		skb = napi_alloc_skb(&tp->r8169napi[ring->index].napi, pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
 			goto release_descriptor;
 		}
 
-		addr = le64_to_cpu(desc->addr);
-		rx_buf = page_address(tp->Rx_databuff[entry]);
+		addr = ring->rx_desc_phy_addr[entry];
+		rx_buf = page_address(ring->rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
 		prefetch(rx_buf);
@@ -4967,7 +5137,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
-		rtl8169_rx_csum(skb, status);
+		rtl8169_rx_csum(tp, skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
 		rtl8169_rx_vlan_tag(desc, skb);
@@ -4975,11 +5145,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->r8169napi[0].napi, skb);
+		napi_gro_receive(&tp->r8169napi[ring->index].napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		rtl8169_mark_to_asic(desc);
+		rtl8169_set_desc_dma_addr(tp, desc, ring->rx_desc_phy_addr[entry]);
+		rtl8169_mark_to_asic(tp, desc);
 	}
 
 	return count;
@@ -5005,6 +5176,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
+	tp->recheck_desc_ownbit = true;
 	napi_schedule(&napi->napi);
 out:
 	rtl_ack_events(tp, status);
@@ -5092,7 +5264,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	rtl_tx(dev, tp, budget);
 
-	work_done = rtl_rx(dev, tp, budget);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5220,21 +5393,21 @@ static int rtl8169_close(struct net_device *dev)
 	struct pci_dev *pdev = tp->pci_dev;
 
 	pm_runtime_get_sync(&pdev->dev);
-
 	netif_stop_queue(dev);
+
 	rtl8169_down(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 
 	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
 	tp->TxDescArray = NULL;
-	tp->RxDescArray = NULL;
+
+	rtl8169_free_rx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
 
@@ -5263,16 +5436,15 @@ static int rtl_open(struct net_device *dev)
 	 * Rx and Tx descriptors needs 256 bytes alignment.
 	 * dma_alloc_coherent provides more.
 	 */
+
 	tp->TxDescArray = dma_alloc_coherent(&pdev->dev, R8169_TX_RING_BYTES,
 					     &tp->TxPhyAddr, GFP_KERNEL);
 	if (!tp->TxDescArray)
-		goto out;
-
-	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
-					     &tp->RxPhyAddr, GFP_KERNEL);
-	if (!tp->RxDescArray)
 		goto err_free_tx_0;
 
+	if (rtl8169_alloc_rx_desc(tp) < 0)
+		goto err_free_rx_1;
+
 	retval = rtl8169_init_ring(tp);
 	if (retval < 0)
 		goto err_free_rx_1;
@@ -5301,11 +5473,10 @@ static int rtl_open(struct net_device *dev)
 	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 err_free_rx_1:
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
-	tp->RxDescArray = NULL;
+	rtl8169_free_rx_desc(tp);
 err_free_tx_0:
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
@@ -5817,7 +5988,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 txconfig;
 	u32 xid;
 
-	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
+				      1,
+				      R8169_MAX_RX_QUEUES);
+
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.43.0


