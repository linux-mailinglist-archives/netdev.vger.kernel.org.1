Return-Path: <netdev+bounces-170637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4FEA4969C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2411884119
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DA25FA05;
	Fri, 28 Feb 2025 10:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1D25F99A;
	Fri, 28 Feb 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737159; cv=none; b=pppgRMXyWcc1Eg33FWjt2VFovKnnH5SpEUzRHQ0p6w56dnIQzMkRC8AKPyMOtG5HaelQGXMDootSdHiFzIYfCi/nzVrSs3/d8DLIUQ6ZXtBmJZ6uOIxsOK5Pe4tsPsnkCWPBATyB/miHJohuvcBptZHuleIQA2NIjJTBYmetL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737159; c=relaxed/simple;
	bh=uY17bPlH0/Br3SDQNFVPnJYVDubD3OnqYJaIenrxPis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmVhn3HZQ+iHECKlGVq7h1mZwHtI1Se/sdCaGSjrckLMqIenSXOCvntAUkUcDqsIQO6FhbPYSjHLaUk321VMhzoAsowVOlSh+fF+EIue02vHKME288j0q3t67cQECR688W15z9gRmyVbfF0IVHlCVoh945tdmbVTAjKf0MnuTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1EG_1740736835 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:35 +0800
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
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 06/14] motorcomm:yt6801: Implement the fxgmac_start function
Date: Fri, 28 Feb 2025 18:00:12 +0800
Message-Id: <20250228100020.3944-7-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
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
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 363 ++++++++++++++++++
 1 file changed, 363 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index c5e02c497..1918cb550 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -12,6 +12,7 @@
 #include "yt6801_desc.h"
 
 const struct net_device_ops *fxgmac_get_netdev_ops(void);
+static void fxgmac_napi_enable(struct fxgmac_pdata *priv);
 
 #define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
 static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
@@ -101,6 +102,11 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static void fxgmac_enable_msix_one_irq(struct fxgmac_pdata *priv, u32 int_id)
+{
+	FXGMAC_IO_WR(priv, MSIX_TBL_MASK + int_id * 16, 0);
+}
+
 static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *priv)
 {
 	FXGMAC_IO_WR_BITS(priv, MGMT_INT_CTRL0, INT_MASK,
@@ -167,6 +173,73 @@ static void fxgmac_free_irqs(struct fxgmac_pdata *priv)
 	}
 }
 
+static int fxgmac_request_irqs(struct fxgmac_pdata *priv)
+{
+	u32 rx, i = 0, msi = FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, MSI);
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct net_device *netdev = priv->netdev;
+	int ret;
+
+	if (!FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, MSIX) &&
+	    !FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, LEGACY_IRQ)) {
+		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, LEGACY_IRQ, 1);
+		ret = devm_request_irq(priv->dev, priv->dev_irq, fxgmac_isr,
+				       msi ? 0 : IRQF_SHARED, netdev->name,
+				       priv);
+		if (ret) {
+			yt_err(priv, "requesting irq:%d ,err:%d\n",
+			       priv->dev_irq, ret);
+			return ret;
+		}
+	}
+
+	if (!priv->per_channel_irq)
+		return 0;
+
+	if (!FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, TX_IRQ)) {
+		snprintf(channel->dma_irq_tx_name,
+			 sizeof(channel->dma_irq_tx_name) - 1,
+			 "%s-ch%d-Tx-%u", netdev_name(netdev), 0,
+			 channel->queue_index);
+		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, TX_IRQ, 1);
+		ret = devm_request_irq(priv->dev, channel->dma_irq_tx,
+				       fxgmac_dma_isr, 0,
+				       channel->dma_irq_tx_name, channel);
+		if (ret) {
+			yt_err(priv, "requesting tx irq:%d ,err:%d\n",
+			       channel->dma_irq_tx, ret);
+			goto err_irq;
+		}
+	}
+
+	rx = FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, RX_IRQ);
+	for (i = 0; i < priv->channel_count; i++, channel++) {
+		snprintf(channel->dma_irq_rx_name,
+			 sizeof(channel->dma_irq_rx_name) - 1, "%s-ch%d-Rx-%u",
+			 netdev_name(netdev), i, channel->queue_index);
+
+		if (!GET_BITS(rx, i, INT_FLAG_PER_RX_IRQ_LEN)) {
+			SET_BITS(priv->int_flag, INT_FLAG_RX_IRQ_POS + i,
+				 INT_FLAG_PER_RX_IRQ_LEN, 1);
+			ret = devm_request_irq(priv->dev, channel->dma_irq_rx,
+					       fxgmac_dma_isr, 0,
+					       channel->dma_irq_rx_name,
+					       channel);
+			if (ret) {
+				yt_err(priv, "requesting rx irq:%d ,err:%d\n",
+				       channel->dma_irq_rx, ret);
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
+
 static void fxgmac_free_tx_data(struct fxgmac_pdata *priv)
 {
 	struct fxgmac_channel *channel = priv->channel_head;
@@ -199,6 +272,19 @@ static void fxgmac_free_rx_data(struct fxgmac_pdata *priv)
 	}
 }
 
+static void fxgmac_enable_tx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	/* Enable Tx DMA channel */
+	FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_TCR, ST, 1);
+
+	/* Enable Tx queue */
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_Q_TQOMR, TXQEN, MTL_Q_ENABLED);
+	/* Enable MAC Tx */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, TE, 1);
+}
+
 static void fxgmac_prepare_tx_stop(struct fxgmac_pdata *priv,
 				   struct fxgmac_channel *channel)
 {
@@ -257,6 +343,27 @@ static void fxgmac_disable_tx(struct fxgmac_pdata *priv)
 	FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_TCR, ST, 0);
 }
 
+static void fxgmac_enable_rx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 val = 0, i;
+
+	/* Enable each Rx DMA channel */
+	for (i = 0; i < priv->channel_count; i++, channel++)
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_RCR, SR, 1);
+
+	/* Enable each Rx queue */
+	for (i = 0; i < priv->rx_q_count; i++)
+		val |= (0x02 << (i << 1));
+
+	FXGMAC_MAC_IO_WR(priv, MAC_RQC0R, val);
+
+	/* Enable MAC Rx */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, CST, 1);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, ACS, 1);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, RE, 1);
+}
+
 static void fxgmac_prepare_rx_stop(struct fxgmac_pdata *priv,
 				   unsigned int queue)
 {
@@ -310,6 +417,147 @@ static void fxgmac_default_speed_duplex_config(struct fxgmac_pdata *priv)
 	priv->mac_speed = SPEED_1000;
 }
 
+static void fxgmac_config_mac_speed(struct fxgmac_pdata *priv)
+{
+	if (priv->mac_duplex == DUPLEX_UNKNOWN &&
+	    priv->mac_speed == SPEED_UNKNOWN)
+		fxgmac_default_speed_duplex_config(priv);
+
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, DM, priv->mac_duplex);
+
+	switch (priv->mac_speed) {
+	case SPEED_1000:
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, PS, 0);
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, FES, 0);
+		break;
+	case SPEED_100:
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, PS, 1);
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, FES, 1);
+		break;
+	case SPEED_10:
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, PS, 1);
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, FES, 0);
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
+		if (netif_running(priv->netdev))
+			netif_tx_wake_all_queues(priv->netdev);
+	} else {
+		netif_tx_stop_all_queues(priv->netdev);
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
+	ret = phy_connect_direct(priv->netdev, phydev, fxgmac_phylink_handler,
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
+		ch_sr = FXGMAC_DMA_IO_RD(channel, DMA_CH_SR);
+		FXGMAC_DMA_IO_WR(channel, DMA_CH_SR, ch_sr);
+
+		ch_sr = 0;
+		/* Enable Normal Interrupt Summary Enable and Fatal Bus Error
+		 * Enable interrupts.
+		 */
+		FXGMAC_SET_BITS(ch_sr, DMA_CH_IER, NIE, 1);
+		FXGMAC_SET_BITS(ch_sr, DMA_CH_IER, FBEE, 1);
+
+		/* only one tx, enable Transmit Interrupt Enable interrupts */
+		if (i == 0 && channel->tx_ring)
+			FXGMAC_SET_BITS(ch_sr, DMA_CH_IER, TIE, 1);
+
+		if (channel->rx_ring) {
+			/* Enable Receive Buffer Unavailable Enable and Receive
+			 * Interrupt Enable interrupts.
+			 */
+			FXGMAC_SET_BITS(ch_sr, DMA_CH_IER, RBUE, 1);
+			FXGMAC_SET_BITS(ch_sr, DMA_CH_IER, RIE, 1);
+		}
+
+		FXGMAC_DMA_IO_WR(channel, DMA_CH_IER, ch_sr);
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
+		FXGMAC_DMA_IO_WR(channel, DMA_CH_SR,
+				 FXGMAC_DMA_IO_RD(channel, DMA_CH_SR));
+
+	for (i = 0; i < priv->hw_feat.rx_q_cnt; i++)
+		FXGMAC_MTL_IO_WR(priv, i, MTL_Q_ISR,
+				 FXGMAC_MTL_IO_RD(priv, i, MTL_Q_ISR));
+
+	FXGMAC_MAC_IO_RD(priv, MAC_ISR);      /* Clear all MAC interrupts */
+	FXGMAC_MAC_IO_RD(priv, MAC_TX_RX_STA);/* Clear tx/rx error interrupts */
+	FXGMAC_MAC_IO_RD(priv, MAC_PMT_STA);
+	FXGMAC_MAC_IO_RD(priv, MAC_LPI_STA);
+
+	FXGMAC_MAC_IO_WR(priv, MAC_DBG_STA,
+			 FXGMAC_MAC_IO_RD(priv, MAC_DBG_STA));
+}
+
+static void fxgmac_set_interrupt_moderation(struct fxgmac_pdata *priv)
+{
+	FXGMAC_IO_WR_BITS(priv, INT_MOD, TX, priv->tx_usecs);
+	FXGMAC_IO_WR_BITS(priv, INT_MOD, RX, priv->rx_usecs);
+}
+
+static void fxgmac_enable_mgm_irq(struct fxgmac_pdata *priv)
+{
+	FXGMAC_IO_WR_BITS(priv, MGMT_INT_CTRL0, INT_MASK,
+			  MGMT_INT_CTRL0_INT_MASK_DISABLE);
+}
+
 /**
  * fxgmac_set_oob_wol - disable or enable oob wol crtl function
  * @priv: driver private struct
@@ -324,6 +572,12 @@ static void fxgmac_set_oob_wol(struct fxgmac_pdata *priv, unsigned int en)
 	FXGMAC_IO_WR_BITS(priv, OOB_WOL_CTRL, DIS, !en);/* en = 1 is disable */
 }
 
+static void fxgmac_config_powerup(struct fxgmac_pdata *priv)
+{
+	fxgmac_set_oob_wol(priv, 0);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PMT_STA, PWRDWN, 0); /* GAMC power up */
+}
+
 static void fxgmac_pre_powerdown(struct fxgmac_pdata *priv)
 {
 	fxgmac_set_oob_wol(priv, 1);
@@ -354,12 +608,87 @@ static void fxgmac_hw_exit(struct fxgmac_pdata *priv)
 	/* Reset will clear nonstick registers. */
 	fxgmac_restore_nonstick_reg(priv);
 }
+
+static void fxgmac_pcie_init(struct fxgmac_pdata *priv)
+{
+	/* snoopy + non-snoopy */
+	FXGMAC_IO_WR_BITS(priv, LTR_IDLE_ENTER, REQUIRE,
+			  LTR_IDLE_ENTER_REQUIRE);
+	FXGMAC_IO_WR_BITS(priv, LTR_IDLE_ENTER, SCALE,
+			  LTR_IDLE_ENTER_SCALE_1024_NS);
+	FXGMAC_IO_WR_BITS(priv, LTR_IDLE_ENTER, ENTER, LTR_IDLE_ENTER_900_US);
+
+	/* snoopy + non-snoopy */
+	FXGMAC_IO_WR_BITS(priv, LTR_IDLE_EXIT, REQUIRE, LTR_IDLE_EXIT_REQUIRE);
+	FXGMAC_IO_WR_BITS(priv, LTR_IDLE_EXIT, SCALE, LTR_IDLE_EXIT_SCALE);
+	FXGMAC_IO_WR_BITS(priv, LTR_IDLE_EXIT, EXIT, LTR_IDLE_EXIT_171_US);
+
+	FXGMAC_IO_WR_BITS(priv, PCIE_SERDES_PLL, AUTOOFF, 1);
+}
+
 void fxgmac_phy_reset(struct fxgmac_pdata *priv)
 {
 	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 0);
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
+	if (test_bit(FXGMAC_POWER_STATE_DOWN, &priv->powerstate)) {
+		yt_err(priv, "fxgmac powerstate is %lu when config power up.\n",
+		       priv->powerstate);
+	}
+
+	fxgmac_config_powerup(priv);
+	fxgmac_dismiss_all_int(priv);
+	ret = fxgmac_hw_init(priv);
+	if (ret < 0) {
+		yt_err(priv, "fxgmac hw init error.\n");
+		return ret;
+	}
+
+	fxgmac_napi_enable(priv);
+	ret = fxgmac_request_irqs(priv);
+	if (ret < 0)
+		return ret;
+
+	/* Config interrupt to level signal */
+	FXGMAC_MAC_IO_WR_BITS(priv, DMA_MR, INTM, 2);
+	FXGMAC_MAC_IO_WR_BITS(priv, DMA_MR, QUREAD, 1);
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
@@ -1022,3 +1351,37 @@ const struct net_device_ops *fxgmac_get_netdev_ops(void)
 {
 	return &fxgmac_netdev_ops;
 }
+
+static void napi_add_enable(struct fxgmac_pdata *priv, struct napi_struct *napi,
+			    int (*poll)(struct napi_struct *, int),
+			    u32 flag_pos)
+{
+	netif_napi_add(priv->netdev, napi, poll);
+	napi_enable(napi);
+	SET_BITS(priv->int_flag, flag_pos, 1, 1); /* set flag_pos bit to 1 */
+}
+
+static void fxgmac_napi_enable(struct fxgmac_pdata *priv)
+{
+	u32 rx = FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, RX_NAPI);
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	if (!priv->per_channel_irq) {
+		if (FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, LEGACY_NAPI))
+			return;
+
+		napi_add_enable(priv, &priv->napi, fxgmac_all_poll,
+				INT_FLAG_LEGACY_NAPI_POS);
+		return;
+	}
+
+	if (!FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, TX_NAPI))
+		napi_add_enable(priv, &channel->napi_tx, fxgmac_one_poll_tx,
+				INT_FLAG_TX_NAPI_POS);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		if (!(GET_BITS(rx, i, INT_FLAG_PER_RX_NAPI_LEN)))
+			napi_add_enable(priv, &channel->napi_rx,
+					fxgmac_one_poll_rx,
+					INT_FLAG_RX_NAPI_POS + i);
+}
-- 
2.34.1


