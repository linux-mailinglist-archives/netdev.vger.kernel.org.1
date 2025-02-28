Return-Path: <netdev+bounces-170630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6DA4966F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A0F7AA513
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C21267389;
	Fri, 28 Feb 2025 10:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B5267387;
	Fri, 28 Feb 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736890; cv=none; b=hWpKBeY5lQeRwBKAi9zhUtUD5VMdBBZ/lllumEBMat7GKwKesHmruwMWyrKHM7YStjtS9pVDgLZDvTzbQ9PIN99b7DlEh3BaWMtzd/IWpRPlbL1BC0nzPAVHeUtZBT9cXbiL/oVnL6ei0nwIbAi4iPhi4WLLlIhyDmTkZegjrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736890; c=relaxed/simple;
	bh=i8oy1nl2lI4VEOafYDHC5zGh6osQGB0cnoBSrfv9BHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qsggiShuYB/3IwdDrhF8W6/+I3XA7j5GKG3eQLPpPkowv7bUGuYwrVAK8BbTlsS3VPNht86VULiKdNqiEeeX3OA/HMDFYAmWh04pPBE+N4yBTt5Jy67NPvSk77luYGmkmt5Zr5sITKYXFjgydmtQOMzGrC0BpD3mYZT46+rk2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Kn_1740736839 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:40 +0800
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
Subject: [PATCH net-next v3 11/14] motorcomm:yt6801: Implement some net_device_ops function
Date: Fri, 28 Feb 2025 18:01:20 +0800
Message-Id: <20250228100020.3944-12-Frank.Sae@motor-comm.com>
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

Implement following callback function
.ndo_stop
.ndo_start_xmit
.ndo_tx_timeout
.ndo_validate_addr
.ndo_poll_controller

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 74af6bcd4..d6c1c0fd4 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -1475,6 +1475,68 @@ static int fxgmac_open(struct net_device *netdev)
 	return ret;
 }
 
+static int fxgmac_close(struct net_device *netdev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(netdev);
+
+	mutex_lock(&priv->mutex);
+	fxgmac_stop(priv); /* Stop the device */
+	priv->dev_state = FXGMAC_DEV_CLOSE;
+	fxgmac_channels_rings_free(priv); /* Free the channels and rings */
+	fxgmac_phy_reset(priv);
+	phy_disconnect(priv->phydev);
+	mutex_unlock(&priv->mutex);
+	return 0;
+}
+
+static void fxgmac_dump_state(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct fxgmac_ring *ring = &channel->tx_ring[0];
+
+	yt_err(priv, "Tx descriptor info:\n");
+	yt_err(priv, "Tx cur = 0x%x\n", ring->cur);
+	yt_err(priv, "Tx dirty = 0x%x\n", ring->dirty);
+	yt_err(priv, "Tx dma_desc_head = %pad\n", &ring->dma_desc_head);
+	yt_err(priv, "Tx desc_data_head = %pad\n", &ring->desc_data_head);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ring = &channel->rx_ring[0];
+		yt_err(priv, "Rx[%d] descriptor info:\n", i);
+		yt_err(priv, "Rx cur = 0x%x\n", ring->cur);
+		yt_err(priv, "Rx dirty = 0x%x\n", ring->dirty);
+		yt_err(priv, "Rx dma_desc_head = %pad\n", &ring->dma_desc_head);
+		yt_err(priv, "Rx desc_data_head = %pad\n",
+		       &ring->desc_data_head);
+	}
+
+	yt_err(priv, "Device Registers:\n");
+	yt_err(priv, "MAC_ISR = %08x\n", FXGMAC_MAC_IO_RD(priv, MAC_ISR));
+	yt_err(priv, "MAC_IER = %08x\n", FXGMAC_MAC_IO_RD(priv, MAC_IER));
+	yt_err(priv, "MMC_RISR = %08x\n", FXGMAC_MAC_IO_RD(priv, MMC_RISR));
+	yt_err(priv, "MMC_RIER = %08x\n", FXGMAC_MAC_IO_RD(priv, MMC_RIER));
+	yt_err(priv, "MMC_TISR = %08x\n", FXGMAC_MAC_IO_RD(priv, MMC_TISR));
+	yt_err(priv, "MMC_TIER = %08x\n", FXGMAC_MAC_IO_RD(priv, MMC_TIER));
+
+	yt_err(priv, "EPHY_CTRL = %04x\n", FXGMAC_IO_RD(priv, EPHY_CTRL));
+	yt_err(priv, "MGMT_INT_CTRL0 = %04x\n",
+	       FXGMAC_IO_RD(priv, MGMT_INT_CTRL0));
+	yt_err(priv, "MSIX_TBL_MASK = %04x\n",
+	       FXGMAC_IO_RD(priv, MSIX_TBL_MASK));
+
+	yt_err(priv, "Dump nonstick regs:\n");
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		yt_err(priv, "[%d] = %04x\n", i / 4, FXGMAC_IO_RD(priv, i));
+}
+
+static void fxgmac_tx_timeout(struct net_device *netdev, unsigned int unused)
+{
+	struct fxgmac_pdata *priv = netdev_priv(netdev);
+
+	fxgmac_dump_state(priv);
+	schedule_work(&priv->restart_work);
+}
+
 #define EFUSE_FISRT_UPDATE_ADDR				255
 #define EFUSE_SECOND_UPDATE_ADDR			209
 #define EFUSE_MAX_ENTRY					39
@@ -2323,9 +2385,33 @@ static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
 	return NETDEV_TX_OK;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fxgmac_poll_controller(struct net_device *netdev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(netdev);
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
@@ -2479,6 +2565,93 @@ static int fxgmac_one_poll_tx(struct napi_struct *napi, int budget)
 	return ret;
 }
 
+static int fxgmac_dev_read(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = priv->netdev;
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
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, OWN))
+		return 1;
+
+	/* Make sure descriptor fields are read after reading the OWN bit */
+	dma_rmb();
+
+	if (netif_msg_rx_status(priv))
+		fxgmac_dump_rx_desc(priv, ring, ring->cur);
+
+	/* Normal Descriptor, be sure Context Descriptor bit is off */
+	FXGMAC_SET_BITS(pkt_info->attr, ATTR_RX, CONTEXT, 0);
+
+	/* Indicate if a Context Descriptor is next */
+	/* Get the header length */
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, FD)) {
+		desc_data->rx.hdr_len = FXGMAC_GET_BITS_LE(dma_desc->desc2,
+							   RX_NORMAL_DESC2, HL);
+	}
+
+	/* Get the pkt_info length */
+	desc_data->rx.len =
+		FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, PL);
+
+	if (!FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, LD)) {
+		/* Not all the data has been transferred for this pkt_info */
+		FXGMAC_SET_BITS(pkt_info->attr, ATTR_RX, INCOMPLETE, 1);
+		cnt_incomplete++;
+		return 0;
+	}
+
+	if ((cnt_incomplete) && netif_msg_rx_status(priv))
+		yt_dbg(priv, "%s, rx back to normal and incomplete cnt=%u\n",
+		       __func__, cnt_incomplete);
+	cnt_incomplete = 0;
+
+	/* This is the last of the data for this pkt_info */
+	FXGMAC_SET_BITS(pkt_info->attr, ATTR_RX, INCOMPLETE, 0);
+
+	/* Set checksum done indicator as appropriate */
+	if (netdev->features & NETIF_F_RXCSUM) {
+		ipce = FXGMAC_GET_BITS_LE(dma_desc->desc1, RX_NORMAL_DESC1_WB,
+					  IPCE);
+		iphe = FXGMAC_GET_BITS_LE(dma_desc->desc1, RX_NORMAL_DESC1_WB,
+					  IPHE);
+		if (!ipce && !iphe)
+			FXGMAC_SET_BITS(pkt_info->attr, ATTR_RX, CSUM_DONE, 1);
+		else
+			return 0;
+	}
+
+	/* Check for errors (only valid in last descriptor) */
+	err = FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, ES);
+	rxparser = FXGMAC_GET_BITS_LE(dma_desc->desc2, RX_NORMAL_DESC2_WB,
+				      RAPARSER);
+	/* Error or incomplete parsing due to ECC error */
+	if (err || rxparser == 0x7) {
+		FXGMAC_SET_BITS(pkt_info->errors, ERRORS_RX, FRAME, 1);
+		return 0;
+	}
+
+	etlt = FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, ETLT);
+	if (etlt == 0x4 && (netdev->features & NETIF_F_HW_VLAN_CTAG_RX)) {
+		FXGMAC_SET_BITS(pkt_info->attr, ATTR_RX, VLAN_CTAG, 1);
+		pkt_info->vlan_ctag = FXGMAC_GET_BITS_LE(dma_desc->desc0,
+							 RX_NORMAL_DESC0, OVT);
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


