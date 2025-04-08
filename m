Return-Path: <netdev+bounces-180149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DAA7FBDC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D3B19E1673
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB492266B7C;
	Tue,  8 Apr 2025 10:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADB267388;
	Tue,  8 Apr 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107639; cv=none; b=cEHhjs2uvzbZaUREDkwcK3zrXD68utx7Sle8z0XW6d2Nf/YeeCX2MQ8rnTTAPg3njG7cAXOq2jF8xF2L49ZyEcCVHxNMIrxAyHGAXP0SKO3Wng/Ehg3IYwBQHoyr//7RVt44r7ulg6kZVaM6LhbXFYHZTTBqSsbUoOxYzSZpuPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107639; c=relaxed/simple;
	bh=ETvGkhEBkI2dq0/fF8RL0MiY7Px/CLzcrGkzbkTxT2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aP9yCUWPKKHtIA3V6qmWLZTTz/CTOrbB3xaAMax77geRyTDARhovt77yNmWgxjsLr3N7iMEPriguYU8dErbw7J+rSnVXf2LAfREOy+fn3d2ElF1gNG0ZWsK7ZchDJYDFrEoFBQj5AqJiAqPvzzV7JaxYn9V9wGWLygHQqE9Ex10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Ud_1744104539 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:29:00 +0800
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
Subject: [PATCH net-next v4 11/14] yt6801: Implement some net_device_ops function
Date: Tue, 08 Apr 2025 18:15:01 +0800
Message-Id: <20250408092835.3952-12-Frank.Sae@motor-comm.com>
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

Implement following callback function
.ndo_stop
.ndo_start_xmit
.ndo_tx_timeout
.ndo_validate_addr
.ndo_poll_controller

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index e1c4153cf..6523fe4de 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -1474,6 +1474,68 @@ static int fxgmac_open(struct net_device *ndev)
 	return ret;
 }
 
+static int fxgmac_close(struct net_device *ndev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(ndev);
+
+	fxgmac_stop(priv); /* Stop the device */
+	priv->dev_state = FXGMAC_DEV_CLOSE;
+	fxgmac_channels_rings_free(priv); /* Free the channels and rings */
+	fxgmac_phy_reset(priv);
+	phy_disconnect(priv->phydev);
+
+	return 0;
+}
+
+static void fxgmac_dump_state(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct fxgmac_ring *ring = &channel->tx_ring[0];
+	struct device *pdev = priv->dev;
+
+	dev_err(pdev, "Tx descriptor info:\n");
+	dev_err(pdev, " cur = 0x%x\n", ring->cur);
+	dev_err(pdev, " dirty = 0x%x\n", ring->dirty);
+	dev_err(pdev, " dma_desc_head = %pad\n", &ring->dma_desc_head);
+	dev_err(pdev, " desc_data_head = %pad\n", &ring->desc_data_head);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ring = &channel->rx_ring[0];
+		dev_err(pdev, "Rx[%d] descriptor info:\n", i);
+		dev_err(pdev, " cur = 0x%x\n", ring->cur);
+		dev_err(pdev, " dirty = 0x%x\n", ring->dirty);
+		dev_err(pdev, " dma_desc_head = %pad\n", &ring->dma_desc_head);
+		dev_err(pdev, " desc_data_head = %pad\n",
+			&ring->desc_data_head);
+	}
+
+	dev_err(pdev, "Device Registers:\n");
+	dev_err(pdev, "MAC_ISR = %08x\n", fxgmac_io_rd(priv, MAC_ISR));
+	dev_err(pdev, "MAC_IER = %08x\n", fxgmac_io_rd(priv, MAC_IER));
+	dev_err(pdev, "MMC_RISR = %08x\n", fxgmac_io_rd(priv, MMC_RISR));
+	dev_err(pdev, "MMC_RIER = %08x\n", fxgmac_io_rd(priv, MMC_RIER));
+	dev_err(pdev, "MMC_TISR = %08x\n", fxgmac_io_rd(priv, MMC_TISR));
+	dev_err(pdev, "MMC_TIER = %08x\n", fxgmac_io_rd(priv, MMC_TIER));
+
+	dev_err(pdev, "EPHY_CTRL = %04x\n", fxgmac_io_rd(priv, EPHY_CTRL));
+	dev_err(pdev,  "MGMT_INT_CTRL0 = %04x\n",
+		fxgmac_io_rd(priv, MGMT_INT_CTRL0));
+	dev_err(pdev, "MSIX_TBL_MASK = %04x\n",
+		fxgmac_io_rd(priv, MSIX_TBL_MASK));
+
+	dev_err(pdev, "Dump nonstick regs:\n");
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		dev_err(pdev, "[%d] = %04x\n", i / 4, fxgmac_io_rd(priv, i));
+}
+
+static void fxgmac_tx_timeout(struct net_device *ndev, unsigned int unused)
+{
+	struct fxgmac_pdata *priv = netdev_priv(ndev);
+
+	fxgmac_dump_state(priv);
+	schedule_work(&priv->restart_work);
+}
+
 #define EFUSE_FISRT_UPDATE_ADDR				255
 #define EFUSE_SECOND_UPDATE_ADDR			209
 #define EFUSE_MAX_ENTRY					39
@@ -2319,9 +2381,33 @@ static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fxgmac_poll_controller(struct net_device *ndev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(ndev);
+	struct fxgmac_channel *channel;
+
+	if (priv->per_channel_irq) {
+		channel = priv->channel_head;
+		for (u32 i = 0; i < priv->channel_count; i++, channel++)
+			fxgmac_dma_isr(channel->dma_irq_rx, channel);
+	} else {
+		disable_irq(priv->dev_irq);
+		fxgmac_isr(priv->dev_irq, priv);
+		enable_irq(priv->dev_irq);
+	}
+}
+#endif /* CONFIG_NET_POLL_CONTROLLER */
+
 static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
+	.ndo_stop		= fxgmac_close,
 	.ndo_start_xmit		= fxgmac_xmit,
+	.ndo_tx_timeout		= fxgmac_tx_timeout,
+	.ndo_validate_addr	= eth_validate_addr,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= fxgmac_poll_controller,
+#endif
 };
 
 const struct net_device_ops *fxgmac_get_netdev_ops(void)
@@ -2476,6 +2562,90 @@ static int fxgmac_one_poll_tx(struct napi_struct *napi, int budget)
 	return ret;
 }
 
+static int fxgmac_dev_read(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *ndev = priv->ndev;
+	static unsigned int cnt_incomplete;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_pkt_info *pkt_info;
+	u32 ipce, iphe, rxparser;
+	unsigned int err, etlt;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+	dma_desc = desc_data->dma_desc;
+	pkt_info = &ring->pkt_info;
+
+	/* Check for data availability */
+	if (fxgmac_desc_rd_bits(dma_desc->desc3, RX_DESC3_OWN))
+		return 1;
+
+	/* Make sure descriptor fields are read after reading the OWN bit */
+	dma_rmb();
+
+	if (netif_msg_rx_status(priv))
+		fxgmac_dump_rx_desc(priv, ring, ring->cur);
+
+	/* Normal Descriptor, be sure Context Descriptor bit is off */
+	pkt_info->attr &= ~ATTR_RX_CONTEXT;
+
+	/* Indicate if a Context Descriptor is next */
+	/* Get the header length */
+	if (fxgmac_desc_rd_bits(dma_desc->desc3, RX_DESC3_FD)) {
+		desc_data->rx.hdr_len = fxgmac_desc_rd_bits(dma_desc->desc2,
+							    RX_DESC2_HL);
+	}
+
+	/* Get the pkt_info length */
+	desc_data->rx.len =
+		fxgmac_desc_rd_bits(dma_desc->desc3, RX_DESC3_PL);
+
+	if (!fxgmac_desc_rd_bits(dma_desc->desc3, RX_DESC3_LD)) {
+		/* Not all the data has been transferred for this pkt_info */
+		pkt_info->attr |= ATTR_RX_INCOMPLETE;
+		cnt_incomplete++;
+		return 0;
+	}
+
+	if ((cnt_incomplete) && netif_msg_rx_status(priv))
+		netdev_dbg(priv->ndev, "%s, rx back to normal and incomplete cnt=%u\n",
+			   __func__, cnt_incomplete);
+	cnt_incomplete = 0;
+
+	/* This is the last of the data for this pkt_info */
+	pkt_info->attr &= ~ATTR_RX_INCOMPLETE;
+
+	/* Set checksum done indicator as appropriate */
+	if (ndev->features & NETIF_F_RXCSUM) {
+		ipce = fxgmac_desc_rd_bits(dma_desc->desc1, RX_DESC1_WB_IPCE);
+		iphe = fxgmac_desc_rd_bits(dma_desc->desc1, RX_DESC1_WB_IPHE);
+		if (!ipce && !iphe)
+			pkt_info->attr |= ATTR_RX_CSUM_DONE;
+		else
+			return 0;
+	}
+
+	/* Check for errors (only valid in last descriptor) */
+	err = fxgmac_desc_rd_bits(dma_desc->desc3, RX_DESC3_ES);
+	rxparser = fxgmac_desc_rd_bits(dma_desc->desc2, RX_DESC2_WB_RAPARSER);
+	/* Error or incomplete parsing due to ECC error */
+	if (err || rxparser == 0x7) {
+		pkt_info->errors |= ERRORS_RX_FRAME;
+		return 0;
+	}
+
+	etlt = fxgmac_desc_rd_bits(dma_desc->desc3, RX_DESC3_ETLT);
+	if (etlt == 0x4 && (ndev->features & NETIF_F_HW_VLAN_CTAG_RX)) {
+		pkt_info->attr |= ATTR_RX_VLAN_CTAG;
+		pkt_info->vlan_ctag = fxgmac_desc_rd_bits(dma_desc->desc0,
+							  RX_DESC0_OVT);
+	}
+
+	return 0;
+}
+
 static unsigned int fxgmac_desc_rx_dirty(struct fxgmac_ring *ring)
 {
 	unsigned int dirty;
-- 
2.34.1


