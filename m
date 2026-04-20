Return-Path: <netdev+bounces-279626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPZ/JPaN5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C642636C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9C13040749
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A43793A2;
	Mon, 20 Apr 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="uFzav8Ud"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD2377034;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651658; cv=none; b=PB8P7ot6kOfYIliqHZywSqrxQUvBurAv8dqbNTS9N20WesoBk7XkxHefuMAOgZVj606f72xAexDOMDw8gT7310swu7pvV4zv62ndFrBpTlqOIYd+diOaWnMt7S/Ci+DD6Va/5gRqkFAM6nnmR76u8w95WQ2FLEstW7JWyFS+LoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651658; c=relaxed/simple;
	bh=671bt8nxwLW6ipSgCW3y2pQ5kvoYvqyOkwecJoSwST8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIljwCinoLXx7Vj897EaRSH5znbjIw2zFEcaZkMUtM9ahZ4KqWHLWIyHObUKbqJv+BF1hw4cOyP1mplxSR0HMsMJIfEOOqp9L+B0rjJTmbtDkGy5nKWfvJxUFXCO1kQPXdMN3sGRtpG1/jZQty5uRzHMcvq+9fx6HQz3/wccnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=uFzav8Ud; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KE540277428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651614;
	bh=xcjah/iG3bssidlwXwaB0tyfED5Vk30TSK9W2S0+Cz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uFzav8UdRaSfVffsv96+fQ0JCnAoYHLZOhWUIPHj32P9BjtVxOoS9XMZRN723E32U
	 6WTlXl9PND3GP4RL4ZYF525LLO1YQRAkk5Y1BXZaD5AnUT7+xFddlzCx3uDoCWhDnm
	 TfhqftJ4aKx3RZX34aHFnfYq8Gq3a0MqTgKIfPHo9zTe73xTvDGJateeuAO3UCOija
	 ejMBvdtmUuOJAoIGX25dpfFdm75migufNXhHuqNR78i+BnSeAuik8SwJnlyFmpGEIz
	 /VJ3R9eBK4iZqGO3NRd2LmzBLEVNPiQIYIO2qJtupW5RZD/2DUnLIboe+nSysRdatM
	 3FgWqKAawbvgA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KE540277428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:14 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 20 Apr 2026 10:20:13 +0800
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
Subject: [RFC Patch net-next v1 2/9] r8169: add napi and irq support
Date: Mon, 20 Apr 2026 10:19:50 +0800
Message-ID: <20260420021957.1756-3-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279626-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: E94C642636C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

Multi tx queues and rx queues require multi irq support. Each irq pairs
with one napi.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 205 ++++++++++++++++++++--
 1 file changed, 187 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0fbec27e4a0d..d1f3a208bd1b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -794,6 +794,19 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_napi {
+	struct napi_struct napi;
+	void *priv;
+	int index;
+};
+
+struct rtl8169_irq {
+	irq_handler_t	handler;
+	unsigned int	vector;
+	u8		requested;
+	char		name[IFNAMSIZ + 10];
+};
+
 enum rx_desc_ring_type {
 	RX_DESC_RING_TYPE_UNKNOWN = 0,
 	RX_DESC_RING_TYPE_DEAFULT,
@@ -818,9 +831,20 @@ struct rtl8169_private {
 	dma_addr_t RxPhyAddr;
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
+	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
+	u16 isr_reg[R8169_MAX_MSIX_VEC];
+	u16 imr_reg[R8169_MAX_MSIX_VEC];
+	unsigned int num_tx_rings;
+	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u8 min_irq_nvecs;
+	u8 max_irq_nvecs;
+	u8 HwSuppIsrVer;
+	u8 HwCurrIsrVer;
+	u8 irq_nvecs;
 	int irq;
 	struct clk *clk;
 
@@ -2755,6 +2779,45 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
+{
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
+		tp->isr_reg[0] = IntrStatus;
+		tp->imr_reg[0] = IntrMask;
+	} else {
+		tp->isr_reg[0] = IntrStatus_8125;
+		tp->imr_reg[0] = IntrMask_8125;
+	}
+
+	for (int i = 1; i < tp->max_irq_nvecs; i++)
+		tp->isr_reg[i] = (u16)(IntrStatus1_8125 + (i - 1) * 4);
+
+	for (int i = 1; i < tp->max_irq_nvecs; i++)
+		tp->imr_reg[i] = (u16)(IntrMask1_8125 + (i - 1) * 4);
+}
+
+static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
+{
+	tp->num_rx_rings = 1;
+	tp->num_tx_rings = 1;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_80:
+		tp->min_irq_nvecs = R8127_MIN_IRQ;
+		tp->max_irq_nvecs = R8127_MAX_IRQ;
+		tp->HwSuppIsrVer = 6;
+		break;
+	default:
+		tp->min_irq_nvecs = 1;
+		tp->max_irq_nvecs = 1;
+		tp->HwSuppIsrVer = 1;
+		break;
+	}
+	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
+
+	rtl_setup_mqs_reg(tp);
+}
+
 static void rtl_request_firmware(struct rtl8169_private *tp)
 {
 	struct rtl_fw *rtl_fw;
@@ -4294,6 +4357,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
 	return 0;
 }
 
+
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
 	rtl8169_init_ring_indexes(tp);
@@ -4313,6 +4377,7 @@ static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
 			 DMA_TO_DEVICE);
 	memset(desc, 0, sizeof(*desc));
 	memset(tx_skb, 0, sizeof(*tx_skb));
+
 }
 
 static void rtl8169_tx_clear_range(struct rtl8169_private *tp, u32 start,
@@ -4341,9 +4406,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
 	netdev_reset_queue(tp->dev);
 }
 
+static void rtl8169_napi_disable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_disable(&tp->r8169napi[i].napi);
+}
+
+static void rtl8169_napi_enable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_enable(&tp->r8169napi[i].napi);
+}
+
 static void rtl8169_cleanup(struct rtl8169_private *tp)
 {
-	napi_disable(&tp->napi);
+	rtl8169_napi_disable(tp);
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
 	synchronize_net();
@@ -4389,7 +4466,8 @@ static void rtl_reset_work(struct rtl8169_private *tp)
 	for (i = 0; i < NUM_RX_DESC; i++)
 		rtl8169_mark_to_asic(tp->RxDescArray + i);
 
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
+
 	rtl_hw_start(tp);
 }
 
@@ -4895,7 +4973,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
+		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
 			goto release_descriptor;
@@ -4919,7 +4997,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->napi, skb);
+		napi_gro_receive(&tp->r8169napi[0].napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
@@ -4931,7 +5009,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 
 static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
-	struct rtl8169_private *tp = dev_instance;
+	struct rtl8169_napi *napi = dev_instance;
+	struct rtl8169_private *tp = napi->priv;
 	u32 status = rtl_get_events(tp);
 
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
@@ -4948,13 +5027,53 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule(&napi->napi);
 out:
 	rtl_ack_events(tp, status);
 
 	return IRQ_HANDLED;
 }
 
+static void rtl8169_free_irq(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		struct rtl8169_irq *irq = &tp->irq_tbl[i];
+		struct rtl8169_napi *napi = &tp->r8169napi[i];
+
+		if (irq->requested) {
+			irq->requested = 0;
+			pci_free_irq(tp->pci_dev, i, napi);
+		}
+	}
+}
+
+static int rtl8169_request_irq(struct rtl8169_private *tp)
+{
+	struct net_device *dev = tp->dev;
+	int rc = 0;
+	struct rtl8169_irq *irq;
+	struct rtl8169_napi *napi;
+	const int len = sizeof(tp->irq_tbl[0].name);
+
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		irq = &tp->irq_tbl[i];
+
+		napi = &tp->r8169napi[i];
+		snprintf(irq->name, len, "%s-%d", dev->name, i);
+		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt, NULL, napi, irq->name);
+
+		if (rc)
+			break;
+
+		irq->vector = pci_irq_vector(tp->pci_dev, i);
+		irq->requested = 1;
+	}
+
+	if (rc)
+		rtl8169_free_irq(tp);
+	return rc;
+}
+
 static void rtl_task(struct work_struct *work)
 {
 	struct rtl8169_private *tp =
@@ -4989,9 +5108,10 @@ static void rtl_task(struct work_struct *work)
 
 static int rtl8169_poll(struct napi_struct *napi, int budget)
 {
-	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
+	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
+	struct rtl8169_private *tp = r8169_napi->priv;
 	struct net_device *dev = tp->dev;
-	int work_done;
+	int work_done = 0;
 
 	rtl_tx(dev, tp, budget);
 
@@ -5110,7 +5230,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
@@ -5125,10 +5245,12 @@ static int rtl8169_close(struct net_device *dev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	netif_stop_queue(dev);
+
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	free_irq(tp->irq, tp);
+
+	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
@@ -5183,14 +5305,14 @@ static int rtl_open(struct net_device *dev)
 	rtl_request_firmware(tp);
 
 	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
-	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
+
+	retval = rtl8169_request_irq(tp);
 	if (retval < 0)
 		goto err_release_fw_2;
 
 	retval = r8169_phy_connect(tp);
 	if (retval)
 		goto err_free_irq;
-
 	rtl8169_up(tp);
 	rtl8169_init_counter_offsets(tp);
 	netif_start_queue(dev);
@@ -5200,7 +5322,7 @@ static int rtl_open(struct net_device *dev)
 	return retval;
 
 err_free_irq:
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
 	rtl8169_rx_clear(tp);
@@ -5265,7 +5387,7 @@ static int rtl8169_runtime_resume(struct device *dev)
 	rtl_rar_set(tp, tp->dev->dev_addr);
 	__rtl8169_set_wol(tp, tp->saved_wolopts);
 
-	if (tp->TxDescArray)
+	if (netif_running(tp->dev))
 		rtl8169_up(tp);
 
 	netif_device_attach(tp->dev);
@@ -5303,7 +5425,7 @@ static int rtl8169_runtime_suspend(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
-	if (!tp->TxDescArray) {
+	if (!netif_running(tp->dev)) {
 		netif_device_detach(tp->dev);
 		return 0;
 	}
@@ -5403,7 +5525,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
+	struct pci_dev *pdev = tp->pci_dev;
 	unsigned int flags;
+	int nvecs = 1;
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
@@ -5419,7 +5543,15 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
+	nvecs = pci_alloc_irq_vectors(pdev, tp->min_irq_nvecs, tp->max_irq_nvecs, flags);
+
+	if (nvecs < 0)
+		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+
+	tp->irq = pdev->irq;
+	tp->irq_nvecs = 1;
+
+	return nvecs;
 }
 
 static void rtl_read_mac_address(struct rtl8169_private *tp,
@@ -5614,6 +5746,18 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	}
 }
 
+static int rtl8169_set_real_num_queue(struct rtl8169_private *tp)
+{
+	int retval;
+
+	retval = netif_set_real_num_tx_queues(tp->dev, tp->num_tx_rings);
+	if (retval < 0)
+		return retval;
+
+	retval = netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
+	return retval;
+}
+
 static int rtl_jumbo_max(struct rtl8169_private *tp)
 {
 	/* Non-GBit versions don't support jumbo frames */
@@ -5674,6 +5818,20 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+
+static void r8169_init_napi(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		struct rtl8169_napi *r8169napi = &tp->r8169napi[i];
+		int (*poll)(struct napi_struct *napi, int budget);
+
+		poll = rtl8169_poll;
+		netif_napi_add(tp->dev, &r8169napi->napi, poll);
+		r8169napi->priv = tp;
+		r8169napi->index = i;
+	}
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
@@ -5778,11 +5936,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rtl_hw_reset(tp);
 
+	rtl_software_parameter_initialize(tp);
+
 	rc = rtl_alloc_irq(tp);
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
-	tp->irq = pci_irq_vector(pdev, 0);
 
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
@@ -5791,7 +5950,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->ethtool_ops = &rtl8169_ethtool_ops;
 
-	netif_napi_add(dev, &tp->napi, rtl8169_poll);
+	if (!tp->rss_support) {
+		netif_napi_add(dev, &tp->r8169napi[0].napi, rtl8169_poll);
+		tp->r8169napi[0].priv = tp;
+		tp->r8169napi[0].index = 0;
+	} else {
+		r8169_init_napi(tp);
+	}
 
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
@@ -5853,6 +6018,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (jumbo_max)
 		dev->max_mtu = jumbo_max;
 
+	rc = rtl8169_set_real_num_queue(tp);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
+
 	rtl_set_irq_mask(tp);
 
 	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
-- 
2.43.0


