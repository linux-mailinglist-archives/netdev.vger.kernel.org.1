Return-Path: <netdev+bounces-289739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF05KDApDWo8twUAu9opvQ
	(envelope-from <netdev+bounces-289739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F28587318
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F20C30BC3B6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A533A711;
	Wed, 20 May 2026 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="PqlqXVDZ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F379212554;
	Wed, 20 May 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247002; cv=none; b=S+8ChG8w+8j11kji7BejkG6SMwStro1iwoF6vvJrSEG//HgeRWFh7ObcRfy8uFgahguN760E/ljzhjUYbk55aI0NGK0RDrhVHi5NAmCGrd3Aeo3VtLXQDOtnqJRtql79pUDDeYV4cuTIgUGbwLiDk5nx8IpzOWMxQuUL3TyRqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247002; c=relaxed/simple;
	bh=LhYpPjdydcWALN90KvKyk5Yv85a5spC/ozBgAl2VIgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiPCRms3W8moqkxRMao9Ex7KP0rLL4Jr+6WKtolZT0yCbYLSwP+nH+xAfpkas3Ha5TzVGAFEjNbQjIFC/MTq/f6428fRt8n2+/JvLD89us7Ww1cQtTo9th4zzx4CuiRLvpc22Ge1ABBJUKtXQcp37ByCrVNh4QYMpkf/zl2EL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=PqlqXVDZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64K3G6mkC3896058, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779246966;
	bh=d9hML5fusAr16T5RHg6rOrQbG2PFbgWVHjmY/NRpQtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PqlqXVDZIrlCfiI+Q6zCwNweXP0JyIx4y0JEzmW792lcVBOlcBDwO2X7azbdgNcLA
	 sYobIIp+fcOjhGJl58/6/V/bT5I5wcJBgJqDsYRbdBMRNjxDlc+u4Dfc0SN8zslQaH
	 MiLT6S/2ySPx6+mJ4bOItAfV+S98x0159q1qO5w/UBRFkgPrx0UQaMzFmMO9uRcsJt
	 y+BgbgWtbHwF7ocnc2H/EP69qcPAIIID4nYzNe+ke+ZVA+7G/iqChf9zXDZDLqc/qB
	 ezpILTTUTYUlB5uq9q7GYxEVuMVd3uLcMYCI5STt2rwi//EKWLU3/jbdX4AHva1xs8
	 NrU0Lj3McFk0g==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64K3G6mkC3896058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 May 2026 11:16:06 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 11:16:06 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 11:16:06 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v5 1/7] r8169: add support for multi irqs
Date: Wed, 20 May 2026 11:15:57 +0800
Message-ID: <20260520031603.700-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260520031603.700-1-javen_xu@realsil.com.cn>
References: <20260520031603.700-1-javen_xu@realsil.com.cn>
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
	TAGGED_FROM(0.00)[bounces-289739-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 47F28587318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

RSS uses multi rx queues to receive packets, and each rx queue needs one
irq and napi. So this patch adds support for multi irqs and napi here.
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - remove some unused definitions, such as index, name in rtl8169_irq
 - remove array imr and isr
 - remove min_irq_nvecs and max_irq_nvecs, replaced with help function
   get_min_irq_nvecs and get_max_irq_nvecs
 - alloc irq by flags, instead of PCI_IRQ_ALL_TYPES

Changes in v3:
 - add enum rtl_isr_version to replace macro definition
 - remove struct rtl8169_napi, use napi_struct array instead and alloc
   memory for this array dynamically
 - remove struct rtl8169_irq

Changes in v4:
 - change retval to ret in rtl8169_set_real_num_queue()
 - reverse xmas tree in rtl8169_poll() and rtl8169_interrupt()
 - remove tp->hw_supp_isr_ver

Changes in v5:
 - rtl8169_request_irq(), when failed, only free irqs which are
   allocated
 - remove rss_support, simplied napi init, call r8169_init_napi()
   directly
 - remove rtl_isr_version, INTR_VEC_MAP_MASK, INTR_VEC_MAP_STATUS,
   R8169_MAX_MSIX_VEC, rss_enable, recheck_desc_ownbit
 - rtl_software_parameter_initialize() this function will be expanded in
   next patch, so i want to remain it here.
---
 drivers/net/ethernet/realtek/r8169_main.c | 126 ++++++++++++++++++----
 1 file changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..fd79c492005f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -733,7 +733,6 @@ struct rtl8169_private {
 	struct pci_dev *pci_dev;
 	struct net_device *dev;
 	struct phy_device *phydev;
-	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
@@ -745,9 +744,12 @@ struct rtl8169_private {
 	dma_addr_t RxPhyAddr;
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	struct napi_struct *rtl8169_napi;
+	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	unsigned int irq_nvecs;
 	int irq;
 	struct clk *clk;
 
@@ -2680,6 +2682,11 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
+{
+	tp->num_rx_rings = 1;
+}
+
 static void rtl_request_firmware(struct rtl8169_private *tp)
 {
 	struct rtl_fw *rtl_fw;
@@ -4266,9 +4273,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
 	netdev_reset_queue(tp->dev);
 }
 
+static void rtl8169_napi_disable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_disable(&tp->rtl8169_napi[i]);
+}
+
+static void rtl8169_napi_enable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_enable(&tp->rtl8169_napi[i]);
+}
+
 static void rtl8169_cleanup(struct rtl8169_private *tp)
 {
-	napi_disable(&tp->napi);
+	rtl8169_napi_disable(tp);
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
 	synchronize_net();
@@ -4314,7 +4333,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
 	for (i = 0; i < NUM_RX_DESC; i++)
 		rtl8169_mark_to_asic(tp->RxDescArray + i);
 
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
 	rtl_hw_start(tp);
 }
 
@@ -4820,7 +4839,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
+		skb = napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
 			goto release_descriptor;
@@ -4844,7 +4863,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->napi, skb);
+		napi_gro_receive(&tp->rtl8169_napi[0], skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
@@ -4856,8 +4875,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 
 static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
-	struct rtl8169_private *tp = dev_instance;
-	u32 status = rtl_get_events(tp);
+	struct napi_struct *napi = dev_instance;
+	struct rtl8169_private *tp;
+	u32 status;
+
+	tp = netdev_priv(napi->dev);
+	status = rtl_get_events(tp);
 
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
@@ -4873,13 +4896,43 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule(napi);
 out:
 	rtl_ack_events(tp, status);
 
 	return IRQ_HANDLED;
 }
 
+static void rtl8169_free_irq(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		struct napi_struct *napi = &tp->rtl8169_napi[i];
+
+		pci_free_irq(tp->pci_dev, i, napi);
+	}
+}
+
+static int rtl8169_request_irq(struct rtl8169_private *tp)
+{
+	struct net_device *dev = tp->dev;
+	struct napi_struct *napi;
+	int i, rc;
+
+	for (i = 0; i < tp->irq_nvecs; i++) {
+		napi = &tp->rtl8169_napi[i];
+		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
+				     NULL, napi, "%s-%d", dev->name, i);
+		if (rc)
+			goto err_unwind;
+	}
+	return 0;
+
+err_unwind:
+	while (--i >= 0)
+		pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
+	return rc;
+}
+
 static void rtl_task(struct work_struct *work)
 {
 	struct rtl8169_private *tp =
@@ -4914,9 +4967,9 @@ static void rtl_task(struct work_struct *work)
 
 static int rtl8169_poll(struct napi_struct *napi, int budget)
 {
-	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
-	struct net_device *dev = tp->dev;
-	int work_done;
+	struct rtl8169_private *tp = netdev_priv(napi->dev);
+	struct net_device *dev = napi->dev;
+	int work_done = 0;
 
 	rtl_tx(dev, tp, budget);
 
@@ -5035,7 +5088,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
@@ -5053,7 +5106,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
@@ -5082,7 +5135,6 @@ static int rtl_open(struct net_device *dev)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 	struct pci_dev *pdev = tp->pci_dev;
-	unsigned long irqflags;
 	int retval = -ENOMEM;
 
 	pm_runtime_get_sync(&pdev->dev);
@@ -5107,8 +5159,7 @@ static int rtl_open(struct net_device *dev)
 
 	rtl_request_firmware(tp);
 
-	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
-	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
+	retval = rtl8169_request_irq(tp);
 	if (retval < 0)
 		goto err_release_fw_2;
 
@@ -5125,7 +5176,7 @@ static int rtl_open(struct net_device *dev)
 	return retval;
 
 err_free_irq:
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
 	rtl8169_rx_clear(tp);
@@ -5328,7 +5379,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
+	struct pci_dev *pdev = tp->pci_dev;
 	unsigned int flags;
+	int nvecs;
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
@@ -5344,7 +5397,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
+	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
+
+	if (nvecs < 0)
+		return nvecs;
+
+	tp->irq_nvecs = nvecs;
+
+	return 0;
 }
 
 static void rtl_read_mac_address(struct rtl8169_private *tp,
@@ -5539,6 +5599,17 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	}
 }
 
+static int rtl8169_set_real_num_queues(struct rtl8169_private *tp)
+{
+	int ret;
+
+	ret = netif_set_real_num_tx_queues(tp->dev, 1);
+	if (ret < 0)
+		return ret;
+
+	return netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
+}
+
 static int rtl_jumbo_max(struct rtl8169_private *tp)
 {
 	/* Non-GBit versions don't support jumbo frames */
@@ -5599,6 +5670,12 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static void r8169_init_napi(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
@@ -5703,11 +5780,16 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rtl_hw_reset(tp);
 
+	rtl_software_parameter_initialize(tp);
+
 	rc = rtl_alloc_irq(tp);
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
-	tp->irq = pci_irq_vector(pdev, 0);
+	tp->rtl8169_napi = devm_kcalloc(&pdev->dev, tp->irq_nvecs,
+					sizeof(struct napi_struct), GFP_KERNEL);
+	if (!tp->rtl8169_napi)
+		return -ENOMEM;
 
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
@@ -5716,7 +5798,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->ethtool_ops = &rtl8169_ethtool_ops;
 
-	netif_napi_add(dev, &tp->napi, rtl8169_poll);
+	r8169_init_napi(tp);
 
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
@@ -5778,6 +5860,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (jumbo_max)
 		dev->max_mtu = jumbo_max;
 
+	rc = rtl8169_set_real_num_queues(tp);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
+
 	rtl_set_irq_mask(tp);
 
 	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
-- 
2.43.0


