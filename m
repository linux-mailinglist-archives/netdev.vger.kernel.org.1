Return-Path: <netdev+bounces-180148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6913AA7FBC3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A380E189497A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55015267B89;
	Tue,  8 Apr 2025 10:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D40266B7A;
	Tue,  8 Apr 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107613; cv=none; b=smfz3WpdVvEJ9gFkmH4zkDKhx6p0FVdXHI4BFADLoMAZZ0bSeX5k3KoCaO27K/LH4AaRDTOkhb37rrabVCJiCQN3IretBJwUquGCQ6IxDSPq5dnkHFsXyP/kdg3iWfF5MfLkKkqIrZ7FKfXOeXn25fHlo6+Jqo55zRDus5JAwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107613; c=relaxed/simple;
	bh=HXtPLGm8pWzll/dwhlOIBgtFkBCTXZRBoj3shIH9ZZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fj1fnWclAvYtsTAeTuUerXkS8NF6cjnD2MMAoNb9qcLR8O/YlS4Tw+DuvnuJy0sY35iuI54d9ObGkfsCtShYLRVrsAIfkwTypy7VGeaHNHhdlMdqYHvxDnuRtuQu/k73rjrCkkCfNlp1v567kpnEKdFlcxnmGn+nBidgYJtWHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Om_1744104535 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:55 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 06/14] yt6801: Implement the fxgmac_start function
Date: Tue, 08 Apr 2025 18:14:46 +0800
Message-Id: <20250408092835.3952-7-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the fxgmac_start function to connect phy, enable napi,
 phy and msix irq.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 339 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   |  72 ++++
 2 files changed, 411 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index dce712306..34ccefdf9 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -22,6 +22,7 @@
 #include "yt6801_desc.h"
 
 const struct net_device_ops *fxgmac_get_netdev_ops(void);
+static void fxgmac_napi_enable(struct fxgmac_pdata *priv);
 
 #define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
 static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
@@ -109,6 +110,11 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static void fxgmac_enable_msix_one_irq(struct fxgmac_pdata *priv, u32 int_id)
+{
+	fxgmac_io_wr(priv, MSIX_TBL_MASK + int_id * 16, 0);
+}
+
 static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *priv)
 {
 	fxgmac_io_wr_bits(priv, MGMT_INT_CTRL0, MGMT_INT_CTRL0_INT_MASK,
@@ -173,6 +179,75 @@ static void fxgmac_free_irqs(struct fxgmac_pdata *priv)
 		}
 }
 
+static int fxgmac_request_irqs(struct fxgmac_pdata *priv)
+{
+	u32 rx_irq[] = {INT_FLAG_RX0_IRQ, INT_FLAG_RX1_IRQ,
+			INT_FLAG_RX2_IRQ, INT_FLAG_RX3_IRQ};
+	u32 i = 0, msi = FIELD_GET(INT_FLAG_MSI, priv->int_flag);
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct net_device *ndev = priv->ndev;
+	int ret;
+
+	if (!FIELD_GET(INT_FLAG_MSIX, priv->int_flag) &&
+	    !FIELD_GET(INT_FLAG_LEGACY_IRQ, priv->int_flag)) {
+		priv->int_flag |= INT_FLAG_LEGACY_IRQ;
+		ret = devm_request_irq(priv->dev, priv->dev_irq, fxgmac_isr,
+				       msi ? 0 : IRQF_SHARED, ndev->name,
+				       priv);
+		if (ret) {
+			dev_err(priv->dev, "Requesting irq:%d, failed:%d\n",
+				priv->dev_irq, ret);
+			return ret;
+		}
+	}
+
+	if (!priv->per_channel_irq)
+		return 0;
+
+	if (!FIELD_GET(INT_FLAG_TX_IRQ, priv->int_flag)) {
+		snprintf(channel->dma_irq_tx_name,
+			 sizeof(channel->dma_irq_tx_name) - 1,
+			 "%s-ch%d-Tx-%u", netdev_name(ndev), 0,
+			 channel->queue_index);
+		priv->int_flag |= INT_FLAG_TX_IRQ;
+		ret = devm_request_irq(priv->dev, channel->dma_irq_tx,
+				       fxgmac_dma_isr, 0,
+				       channel->dma_irq_tx_name, channel);
+		if (ret) {
+			dev_err(priv->dev, "dev:%p, channel:%p\n",
+				priv->dev, channel);
+
+			dev_err(priv->dev, "Requesting tx irq:%d, failed:%d\n",
+				channel->dma_irq_tx, ret);
+			goto err_irq;
+		}
+	}
+
+	for (i = 0; i < priv->channel_count; i++, channel++) {
+		snprintf(channel->dma_irq_rx_name,
+			 sizeof(channel->dma_irq_rx_name) - 1, "%s-ch%d-Rx-%u",
+			 netdev_name(ndev), i, channel->queue_index);
+
+		if ((priv->int_flag & rx_irq[i]) != rx_irq[i]) {
+			priv->int_flag |= rx_irq[i];
+			ret = devm_request_irq(priv->dev, channel->dma_irq_rx,
+					       fxgmac_dma_isr, 0,
+					       channel->dma_irq_rx_name,
+					       channel);
+			if (ret) {
+				dev_err(priv->dev, "Requesting rx irq:%d, failed:%d\n",
+					channel->dma_irq_rx, ret);
+				goto err_irq;
+			}
+		}
+	}
+
+	return 0;
+
+err_irq:
+	fxgmac_free_irqs(priv);
+	return ret;
+}
 static void fxgmac_free_tx_data(struct fxgmac_pdata *priv)
 {
 	struct fxgmac_channel *channel = priv->channel_head;
@@ -205,6 +280,20 @@ static void fxgmac_free_rx_data(struct fxgmac_pdata *priv)
 	}
 }
 
+static void fxgmac_enable_tx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	/* Enable Tx DMA channel */
+	fxgmac_dma_wr_bits(channel, DMA_CH_TCR, DMA_CH_TCR_ST, 1);
+
+	/* Enable Tx queue */
+	fxgmac_mtl_wr_bits(priv, 0, MTL_Q_TQOMR, MTL_Q_TQOMR_TXQEN,
+			   MTL_Q_ENABLED);
+	/* Enable MAC Tx */
+	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_TE, 1);
+}
+
 static void fxgmac_prepare_tx_stop(struct fxgmac_pdata *priv,
 				   struct fxgmac_channel *channel)
 {
@@ -248,6 +337,27 @@ static void fxgmac_disable_tx(struct fxgmac_pdata *priv)
 	fxgmac_dma_wr_bits(channel, DMA_CH_TCR, DMA_CH_TCR_ST, 0);
 }
 
+static void fxgmac_enable_rx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 val = 0, i;
+
+	/* Enable each Rx DMA channel */
+	for (i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_wr_bits(channel, DMA_CH_RCR, DMA_CH_RCR_SR, 1);
+
+	/* Enable each Rx queue */
+	for (i = 0; i < priv->rx_q_count; i++)
+		val |= (0x02 << (i << 1));
+
+	fxgmac_io_wr(priv, MAC_RQC0R, val);
+
+	/* Enable MAC Rx */
+	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_CST, 1);
+	fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_ACS, 1);
+	fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_RE, 1);
+}
+
 static void fxgmac_prepare_rx_stop(struct fxgmac_pdata *priv,
 				   unsigned int queue)
 {
@@ -301,6 +411,144 @@ static void fxgmac_default_speed_duplex_config(struct fxgmac_pdata *priv)
 	priv->mac_speed = SPEED_1000;
 }
 
+static void fxgmac_config_mac_speed(struct fxgmac_pdata *priv)
+{
+	if (priv->mac_duplex == DUPLEX_UNKNOWN &&
+	    priv->mac_speed == SPEED_UNKNOWN)
+		fxgmac_default_speed_duplex_config(priv);
+
+	fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_DM, priv->mac_duplex);
+
+	switch (priv->mac_speed) {
+	case SPEED_1000:
+		fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_PS, 0);
+		fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_FES, 0);
+		break;
+	case SPEED_100:
+		fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_PS, 1);
+		fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_FES, 1);
+		break;
+	case SPEED_10:
+		fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_PS, 1);
+		fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_FES, 0);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+static void fxgmac_phylink_handler(struct net_device *ndev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(ndev);
+
+	priv->mac_speed = priv->phydev->speed;
+	priv->mac_duplex = priv->phydev->duplex;
+
+	if (priv->phydev->link) {
+		fxgmac_config_mac_speed(priv);
+		fxgmac_enable_rx(priv);
+		fxgmac_enable_tx(priv);
+		if (netif_running(priv->ndev))
+			netif_tx_wake_all_queues(priv->ndev);
+	} else {
+		netif_tx_stop_all_queues(priv->ndev);
+		fxgmac_disable_rx(priv);
+		fxgmac_disable_tx(priv);
+	}
+
+	phy_print_status(priv->phydev);
+}
+
+static int fxgmac_phy_connect(struct fxgmac_pdata *priv)
+{
+	struct phy_device *phydev = priv->phydev;
+	int ret;
+
+	priv->phydev->irq = PHY_POLL;
+	ret = phy_connect_direct(priv->ndev, phydev, fxgmac_phylink_handler,
+				 PHY_INTERFACE_MODE_INTERNAL);
+	if (ret)
+		return ret;
+
+	phy_support_asym_pause(phydev);
+	priv->phydev->mac_managed_pm = 1;
+	phy_attached_info(phydev);
+
+	return 0;
+}
+
+static void fxgmac_enable_msix_irqs(struct fxgmac_pdata *priv)
+{
+	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
+		fxgmac_enable_msix_one_irq(priv, intid);
+}
+
+static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 ch_sr;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		/* Clear all the interrupts which are set */
+		ch_sr = fxgmac_dma_io_rd(channel, DMA_CH_SR);
+		fxgmac_dma_io_wr(channel, DMA_CH_SR, ch_sr);
+
+		ch_sr = 0;
+		/* Enable Normal Interrupt Summary Enable and Fatal Bus Error
+		 * Enable interrupts.
+		 */
+		ch_sr |= (DMA_CH_IER_NIE | DMA_CH_IER_FBEE);
+
+		/* only one tx, enable Transmit Interrupt Enable interrupts */
+		if (i == 0 && channel->tx_ring)
+			ch_sr |= DMA_CH_IER_TIE;
+
+		/* Enable Receive Buffer Unavailable Enable and Receive
+		 * Interrupt Enable interrupts.
+		 */
+		if (channel->rx_ring)
+			ch_sr |= (DMA_CH_IER_RBUE | DMA_CH_IER_RIE);
+
+		fxgmac_dma_io_wr(channel, DMA_CH_IER, ch_sr);
+	}
+}
+
+static void fxgmac_dismiss_all_int(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 i;
+
+	/* Clear all the interrupts which are set */
+	for (i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_io_wr(channel, DMA_CH_SR,
+				 fxgmac_dma_io_rd(channel, DMA_CH_SR));
+
+	for (i = 0; i < priv->hw_feat.rx_q_cnt; i++)
+		fxgmac_mtl_io_wr(priv, i, MTL_Q_IR,
+				 fxgmac_mtl_io_rd(priv, i, MTL_Q_IR));
+
+	fxgmac_io_rd(priv, MAC_ISR);      /* Clear all MAC interrupts */
+	fxgmac_io_rd(priv, MAC_TX_RX_STA);/* Clear tx/rx error interrupts */
+	fxgmac_io_rd(priv, MAC_PMT_STA);
+	fxgmac_io_rd(priv, MAC_LPI_STA);
+
+	fxgmac_io_wr(priv, MAC_DBG_STA, fxgmac_io_rd(priv, MAC_DBG_STA));
+}
+
+static void fxgmac_set_interrupt_moderation(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, INT_MOD, INT_MOD_TX, priv->tx_usecs);
+	fxgmac_io_wr_bits(priv, INT_MOD, INT_MOD_RX, priv->rx_usecs);
+}
+
+static void fxgmac_enable_mgm_irq(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, MGMT_INT_CTRL0, MGMT_INT_CTRL0_INT_STATUS, 0);
+	fxgmac_io_wr_bits(priv, MGMT_INT_CTRL0, MGMT_INT_CTRL0_INT_MASK,
+			  MGMT_INT_CTRL0_INT_MASK_MISC);
+}
+
 /**
  * fxgmac_set_oob_wol - disable or enable oob wol crtl function
  * @priv: driver private struct
@@ -378,6 +626,63 @@ static void fxgmac_phy_reset(struct fxgmac_pdata *priv)
 	fsleep(1500);
 }
 
+static int fxgmac_start(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	if (priv->dev_state != FXGMAC_DEV_OPEN &&
+	    priv->dev_state != FXGMAC_DEV_STOP &&
+	    priv->dev_state != FXGMAC_DEV_RESUME) {
+		return 0;
+	}
+
+	if (priv->dev_state != FXGMAC_DEV_STOP) {
+		fxgmac_phy_reset(priv);
+		fxgmac_phy_release(priv);
+	}
+
+	if (priv->dev_state == FXGMAC_DEV_OPEN) {
+		ret = fxgmac_phy_connect(priv);
+		if (ret < 0)
+			return ret;
+	}
+
+	fxgmac_pcie_init(priv);
+	if (test_bit(FXGMAC_POWER_STATE_DOWN, &priv->power_state)) {
+		dev_err(priv->dev, "fxgmac powerstate is %lu when config power up.\n",
+			priv->power_state);
+	}
+
+	fxgmac_config_powerup(priv);
+	fxgmac_dismiss_all_int(priv);
+	ret = fxgmac_hw_init(priv);
+	if (ret < 0) {
+		dev_err(priv->dev, "fxgmac hw init failed.\n");
+		return ret;
+	}
+
+	fxgmac_napi_enable(priv);
+	ret = fxgmac_request_irqs(priv);
+	if (ret < 0)
+		return ret;
+
+	/* Config interrupt to level signal */
+	fxgmac_io_wr_bits(priv, DMA_MR, DMA_MR_INTM, 2);
+	fxgmac_io_wr_bits(priv, DMA_MR, DMA_MR_QUREAD, 1);
+
+	fxgmac_enable_mgm_irq(priv);
+	fxgmac_set_interrupt_moderation(priv);
+
+	if (priv->per_channel_irq)
+		fxgmac_enable_msix_irqs(priv);
+
+	fxgmac_enable_dma_interrupts(priv);
+	priv->dev_state = FXGMAC_DEV_START;
+	phy_start(priv->phydev);
+
+	return 0;
+}
+
 static void fxgmac_disable_msix_irqs(struct fxgmac_pdata *priv)
 {
 	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
@@ -1033,6 +1338,40 @@ const struct net_device_ops *fxgmac_get_netdev_ops(void)
 	return &fxgmac_netdev_ops;
 }
 
+static void napi_add_enable(struct fxgmac_pdata *priv, struct napi_struct *napi,
+			    int (*poll)(struct napi_struct *, int),
+			    u32 flag)
+{
+	netif_napi_add(priv->ndev, napi, poll);
+	napi_enable(napi);
+	priv->int_flag |= flag;
+}
+
+static void fxgmac_napi_enable(struct fxgmac_pdata *priv)
+{
+	u32 rx_napi[] = {INT_FLAG_RX0_NAPI, INT_FLAG_RX1_NAPI,
+			 INT_FLAG_RX2_NAPI, INT_FLAG_RX3_NAPI};
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	if (!priv->per_channel_irq) {
+		if (FIELD_GET(INT_FLAG_LEGACY_NAPI, priv->int_flag))
+			return;
+
+		napi_add_enable(priv, &priv->napi, fxgmac_all_poll,
+				INT_FLAG_LEGACY_NAPI);
+		return;
+	}
+
+	if (!FIELD_GET(INT_FLAG_TX_NAPI, priv->int_flag))
+		napi_add_enable(priv, &channel->napi_tx, fxgmac_one_poll_tx,
+				INT_FLAG_TX_NAPI);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		if (!(priv->int_flag & rx_napi[i]))
+			napi_add_enable(priv, &channel->napi_rx,
+					fxgmac_one_poll_rx, rx_napi[i]);
+}
+
 static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 {
 	struct fxgmac_resources res;
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
index d52de4482..4afc6d4cd 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -55,6 +55,12 @@
 #define  MGMT_INT_CTRL0_INT_MASK_DISABLE	0xf000
 #define  MGMT_INT_CTRL0_INT_MASK_MASK		0xffff
 
+/* Interrupt Moderation */
+#define INT_MOD					0x1108
+#define INT_MOD_RX				GENMASK(11, 0)
+#define  INT_MOD_200_US				200
+#define INT_MOD_TX				GENMASK(27, 16)
+
 /* LTR_CTRL3, LTR latency message, only for System IDLE Start. */
 #define LTR_IDLE_ENTER				0x113c
 #define LTR_IDLE_ENTER_ENTER			GENMASK(9, 0)
@@ -74,6 +80,9 @@
 #define  LTR_IDLE_EXIT_171_US			171
 #define LTR_IDLE_EXIT_SCALE			GENMASK(14, 10)
 #define LTR_IDLE_EXIT_REQUIRE			BIT(15)
+
+#define MSIX_TBL_MASK				0x120c
+
 /* msi table */
 #define MSI_ID_RXQ0				0
 #define MSI_ID_RXQ1				1
@@ -131,6 +140,24 @@
 #define MAC_RQC2_INC			4
 #define MAC_RQC2_Q_PER_REG		4
 
+#define MAC_ISR				0x20b0
+#define MAC_ISR_PHYIF_STA		BIT(0)
+#define MAC_ISR_AN_SR			GENMASK(3, 1)
+#define MAC_ISR_PMT_STA			BIT(4)
+#define MAC_ISR_LPI_STA			BIT(5)
+#define MAC_ISR_MMC_STA			BIT(8)
+#define MAC_ISR_RX_MMC_STA		BIT(9)
+#define MAC_ISR_TX_MMC_STA		BIT(10)
+#define MAC_ISR_IPC_RXINT		BIT(11)
+#define MAC_ISR_TSIS			BIT(12)
+#define MAC_ISR_TX_RX_STA		GENMASK(14, 13)
+#define MAC_ISR_GPIO_SR			GENMASK(25, 15)
+
+#define MAC_IER				0x20b4
+#define MAC_IER_TSIE			BIT(12)
+
+#define MAC_TX_RX_STA			0x20b8
+
 #define MAC_PMT_STA			0x20c0
 #define MAC_PMT_STA_PWRDWN		BIT(0)
 #define MAC_PMT_STA_MGKPKTEN		BIT(1)
@@ -141,6 +168,20 @@
 #define MAC_PMT_STA_RWKPTR		GENMASK(27, 24)
 #define MAC_PMT_STA_RWKFILTERST		BIT(31)
 
+#define MAC_RWK_PAC			0x20c4
+#define MAC_LPI_STA			0x20d0
+#define MAC_LPI_CONTROL			0x20d4
+#define MAC_LPI_TIMER			0x20d8
+#define MAC_MS_TIC_COUNTER		0x20dc
+#define MAC_AN_CR			0x20e0
+#define MAC_AN_SR			0x20e4
+#define MAC_AN_ADV			0x20e8
+#define MAC_AN_LPA			0x20ec
+#define MAC_AN_EXP			0x20f0
+#define MAC_PHYIF_STA			0x20f8
+#define MAC_VR				0x2110
+#define MAC_DBG_STA			0x2114
+
 #define MAC_HWF0R			0x211c
 #define MAC_HWF0R_VLHASH		BIT(4)
 #define MAC_HWF0R_SMASEL		BIT(5)
@@ -180,6 +221,7 @@
 #define MAC_HWF2R_AUXSNAPNUM		GENMASK(30, 28)
 
 #define MAC_HWF3R			0x2128
+
 #define MAC_MDIO_ADDR			0x2200
 #define MAC_MDIO_ADDR_BUSY		BIT(0)
 #define MAC_MDIO_ADDR_GOC		GENMASK(3, 2)
@@ -200,10 +242,20 @@
 #define MTL_Q_EN_IF_AV			0x01
 #define MTL_Q_ENABLED			0x02
 
+#define MTL_Q_IR			0x2c /* Interrupt control status */
 #define MTL_Q_RQDR			0x38
 #define MTL_Q_RQDR_RXQSTS		GENMASK(5, 4)
 #define MTL_Q_RQDR_PRXQ			GENMASK(29, 16)
 
+/* DMA registers */
+#define DMA_MR					0x3000
+#define DMA_MR_SWR				BIT(0)
+#define DMA_MR_TXPR				BIT(11)
+#define DMA_MR_INTM				GENMASK(17, 16)
+#define DMA_MR_QUREAD				BIT(19)
+#define DMA_MR_TNDF				GENMASK(21, 20)
+#define DMA_MR_RNDF				GENMASK(23, 22)
+
 #define DMA_DSRX_INC				4
 #define DMA_DSR0				0x300c
 #define DMA_DSR0_TPS				GENMASK(15, 12)
@@ -234,6 +286,26 @@
 #define DMA_CH_RCR_RBSZ			GENMASK(14, 1)
 #define DMA_CH_RCR_PBL			GENMASK(21, 16)
 
+#define DMA_CH_IER			0x34
+#define DMA_CH_IER_TIE			BIT(0)
+#define DMA_CH_IER_TXSE			BIT(1)
+#define DMA_CH_IER_TBUE			BIT(2)
+#define DMA_CH_IER_RIE			BIT(6)
+#define DMA_CH_IER_RBUE			BIT(7)
+#define DMA_CH_IER_RSE			BIT(8)
+#define DMA_CH_IER_FBEE			BIT(12)
+#define DMA_CH_IER_AIE			BIT(14)
+#define DMA_CH_IER_NIE			BIT(15)
+
+#define DMA_CH_SR			0x60
+#define DMA_CH_SR_TI			BIT(0)
+#define DMA_CH_SR_TPS			BIT(1)
+#define DMA_CH_SR_TBU			BIT(2)
+#define DMA_CH_SR_RI			BIT(6)
+#define DMA_CH_SR_RBU			BIT(7)
+#define DMA_CH_SR_RPS			BIT(8)
+#define DMA_CH_SR_FBE			BIT(12)
+
 struct fxgmac_ring_buf {
 	struct sk_buff *skb;
 	dma_addr_t skb_dma;
-- 
2.34.1


