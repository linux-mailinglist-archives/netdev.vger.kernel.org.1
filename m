Return-Path: <netdev+bounces-180144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B342A7FBAA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F87C3B671B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDCC2686BD;
	Tue,  8 Apr 2025 10:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E6266B7A;
	Tue,  8 Apr 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107302; cv=none; b=SNLry3e4r74fO1jSamgBjjC/ZXYjaaIkFM+M94JHrKcKmYX7+VFMTxQ1ANSdTuyx/gEyBK4vg40wIvNX627rKqNVZIIgJYMPLe/xdDzVc6pjpANpjUm+MMisZvmO4pQRRP6JkfpJtXq1KcvcOrQkMhW6sgMX5JEkUmBM9+DGOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107302; c=relaxed/simple;
	bh=q84VNs04UjsotkVFZBu4Ao5ebq+6b4PjM4qEIPxVrrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vhyn1y3gAgFXYpHB1boh0XkQkg+GtgIUj9/djPQJsyqqLpihEp0bclvcpZ76ebtKuNUkEWXUcrea6z0WUBql75ObvBWlK1E/BH5KOoZV71epTtnw04nQw4V+uxYJ1rmqXjtSDd0AaG0NtEpaoDTHgu3BCw6y9LiXAkJsuWplXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Nd_1744104534 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:54 +0800
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
Subject: [PATCH net-next v4 05/14] yt6801: Implement the .ndo_open function
Date: Tue, 08 Apr 2025 18:14:39 +0800
Message-Id: <20250408092835.3952-6-Frank.Sae@motor-comm.com>
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

Implement the .ndo_open function to Calculate the Rx buffer size, allocate
 the channels and rings.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   | 219 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |   2 +
 .../ethernet/motorcomm/yt6801/yt6801_main.c   |  84 +++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   |  19 +-
 4 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
index a83ebb478..0891c4fef 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -48,3 +48,222 @@ void fxgmac_desc_data_unmap(struct fxgmac_pdata *priv,
 
 	desc_data->mapped_as_page = 0;
 }
+
+static int fxgmac_ring_init(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			    unsigned int dma_desc_count)
+{
+	/* Descriptors */
+	ring->dma_desc_count = dma_desc_count;
+	ring->dma_desc_head =
+		dma_alloc_coherent(priv->dev, (sizeof(struct fxgmac_dma_desc) *
+				   dma_desc_count),
+				   &ring->dma_desc_head_addr, GFP_KERNEL);
+	if (!ring->dma_desc_head)
+		return -ENOMEM;
+
+	/* Array of descriptor data */
+	ring->desc_data_head = kcalloc(dma_desc_count,
+				       sizeof(struct fxgmac_desc_data),
+				       GFP_KERNEL);
+	if (!ring->desc_data_head)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void fxgmac_ring_free(struct fxgmac_pdata *priv,
+			     struct fxgmac_ring *ring)
+{
+	if (!ring)
+		return;
+
+	if (ring->desc_data_head) {
+		for (u32 i = 0; i < ring->dma_desc_count; i++)
+			fxgmac_desc_data_unmap(priv,
+					       FXGMAC_GET_DESC_DATA(ring, i));
+
+		kfree(ring->desc_data_head);
+		ring->desc_data_head = NULL;
+	}
+
+	if (ring->rx_hdr_pa.pages) {
+		dma_unmap_page(priv->dev, ring->rx_hdr_pa.pages_dma,
+			       ring->rx_hdr_pa.pages_len, DMA_FROM_DEVICE);
+		put_page(ring->rx_hdr_pa.pages);
+
+		ring->rx_hdr_pa.pages = NULL;
+		ring->rx_hdr_pa.pages_len = 0;
+		ring->rx_hdr_pa.pages_offset = 0;
+		ring->rx_hdr_pa.pages_dma = 0;
+	}
+
+	if (ring->rx_buf_pa.pages) {
+		dma_unmap_page(priv->dev, ring->rx_buf_pa.pages_dma,
+			       ring->rx_buf_pa.pages_len, DMA_FROM_DEVICE);
+		put_page(ring->rx_buf_pa.pages);
+
+		ring->rx_buf_pa.pages = NULL;
+		ring->rx_buf_pa.pages_len = 0;
+		ring->rx_buf_pa.pages_offset = 0;
+		ring->rx_buf_pa.pages_dma = 0;
+	}
+	if (ring->dma_desc_head) {
+		dma_free_coherent(priv->dev, (sizeof(struct fxgmac_dma_desc) *
+				  ring->dma_desc_count), ring->dma_desc_head,
+				  ring->dma_desc_head_addr);
+		ring->dma_desc_head = NULL;
+	}
+}
+
+static void fxgmac_rings_free(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	fxgmac_ring_free(priv, channel->tx_ring);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_ring_free(priv, channel->rx_ring);
+}
+
+static int fxgmac_rings_alloc(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	int ret;
+
+	ret = fxgmac_ring_init(priv, channel->tx_ring, priv->tx_desc_count);
+	if (ret < 0) {
+		dev_err(priv->dev, "Initializing Tx ring failed");
+		goto err_init_ring;
+	}
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ret = fxgmac_ring_init(priv, channel->rx_ring,
+				       priv->rx_desc_count);
+		if (ret < 0) {
+			dev_err(priv->dev, "Initializing Rx ring failed\n");
+			goto err_init_ring;
+		}
+	}
+	return 0;
+
+err_init_ring:
+	fxgmac_rings_free(priv);
+	return ret;
+}
+
+static void fxgmac_channels_free(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	kfree(channel->tx_ring);
+	channel->tx_ring = NULL;
+
+	kfree(channel->rx_ring);
+	channel->rx_ring = NULL;
+
+	kfree(channel);
+	priv->channel_head = NULL;
+}
+
+void fxgmac_channels_rings_free(struct fxgmac_pdata *priv)
+{
+	fxgmac_rings_free(priv);
+	fxgmac_channels_free(priv);
+}
+
+static void fxgmac_set_msix_tx_irq(struct fxgmac_pdata *priv,
+				   struct fxgmac_channel *channel)
+{
+	priv->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS] =
+		priv->msix_entries[FXGMAC_MAX_DMA_RX_CHANNELS].vector;
+	channel->dma_irq_tx = priv->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS];
+}
+
+static int fxgmac_channels_alloc(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel_head, *channel;
+	struct fxgmac_ring *tx_ring, *rx_ring;
+	int ret = -ENOMEM;
+
+	channel_head = kcalloc(priv->channel_count,
+			       sizeof(struct fxgmac_channel), GFP_KERNEL);
+
+	if (!channel_head)
+		return ret;
+
+	tx_ring = kcalloc(FXGMAC_TX_1_RING, sizeof(struct fxgmac_ring),
+			  GFP_KERNEL);
+	if (!tx_ring)
+		goto err_tx_ring;
+
+	rx_ring = kcalloc(priv->rx_ring_count, sizeof(struct fxgmac_ring),
+			  GFP_KERNEL);
+	if (!rx_ring)
+		goto err_rx_ring;
+
+	channel = channel_head;
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
+		channel->priv = priv;
+		channel->queue_index = i;
+		channel->dma_regs = (priv)->hw_addr + DMA_CH_BASE +
+				    (DMA_CH_INC * i);
+
+		if (priv->per_channel_irq) {
+			priv->channel_irq[i] = priv->msix_entries[i].vector;
+
+			if (IS_ENABLED(CONFIG_PCI_MSI) &&  i < FXGMAC_TX_1_RING)
+				fxgmac_set_msix_tx_irq(priv, channel);
+
+			/* Get the per DMA rx interrupt */
+			ret = priv->channel_irq[i];
+			if (ret < 0) {
+				dev_err(priv->dev, "channel irq[%u] failed\n",
+					i + 1);
+				goto err_irq;
+			}
+
+			channel->dma_irq_rx = ret;
+		}
+
+		if (i < FXGMAC_TX_1_RING)
+			channel->tx_ring = tx_ring++;
+
+		if (i < priv->rx_ring_count)
+			channel->rx_ring = rx_ring++;
+	}
+
+	priv->channel_head = channel_head;
+	return 0;
+
+err_irq:
+	kfree(rx_ring);
+
+err_rx_ring:
+	kfree(tx_ring);
+
+err_tx_ring:
+	kfree(channel_head);
+
+	dev_err(priv->dev, "%s failed:%d\n", __func__, ret);
+	return ret;
+}
+
+int fxgmac_channels_rings_alloc(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	ret = fxgmac_channels_alloc(priv);
+	if (ret < 0)
+		goto err_alloc;
+
+	ret = fxgmac_rings_alloc(priv);
+	if (ret < 0)
+		goto err_alloc;
+
+	return 0;
+
+err_alloc:
+	fxgmac_channels_rings_free(priv);
+	return ret;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
index a4c7a8af2..dfe783004 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
@@ -16,4 +16,6 @@
 void fxgmac_desc_data_unmap(struct fxgmac_pdata *priv,
 			    struct fxgmac_desc_data *desc_data);
 
+int fxgmac_channels_rings_alloc(struct fxgmac_pdata *priv);
+void fxgmac_channels_rings_free(struct fxgmac_pdata *priv);
 #endif /* YT6801_DESC_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 5294ca638..dce712306 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -21,6 +21,8 @@
 #include "yt6801_type.h"
 #include "yt6801_desc.h"
 
+const struct net_device_ops *fxgmac_get_netdev_ops(void);
+
 #define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
 static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
 {
@@ -409,6 +411,28 @@ static void fxgmac_stop(struct fxgmac_pdata *priv)
 	netdev_tx_reset_queue(txq);
 }
 
+static void fxgmac_restart(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	/* If not running, "restart" will happen on open */
+	if (!netif_running(priv->ndev) && priv->dev_state != FXGMAC_DEV_START)
+		return;
+
+	fxgmac_stop(priv);
+	fxgmac_free_tx_data(priv);
+	fxgmac_free_rx_data(priv);
+	ret = fxgmac_start(priv);
+	if (ret < 0)
+		dev_err(priv->dev, "fxgmac start failed:%d.\n", ret);
+}
+
+static void fxgmac_restart_work(struct work_struct *work)
+{
+	rtnl_lock();
+	fxgmac_restart(container_of(work, struct fxgmac_pdata, restart_work));
+	rtnl_unlock();
+}
 static void fxgmac_config_powerdown(struct fxgmac_pdata *priv)
 {
 	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_RE, 1); /* Enable MAC Rx */
@@ -452,6 +476,57 @@ static int fxgmac_net_powerdown(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *priv, unsigned int mtu)
+{
+	u32 rx_buf_size, max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
+
+	if (mtu > max_mtu) {
+		dev_err(priv->dev, "MTU exceeds maximum supported value\n");
+		return -EINVAL;
+	}
+
+	rx_buf_size = mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	rx_buf_size =
+		clamp_val(rx_buf_size, FXGMAC_RX_MIN_BUF_SIZE, PAGE_SIZE * 4);
+
+	rx_buf_size = (rx_buf_size + FXGMAC_RX_BUF_ALIGN - 1) &
+		      ~(FXGMAC_RX_BUF_ALIGN - 1);
+
+	return rx_buf_size;
+}
+
+static int fxgmac_open(struct net_device *ndev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(ndev);
+	int ret;
+
+	priv->dev_state = FXGMAC_DEV_OPEN;
+
+	/* Calculate the Rx buffer size before allocating rings */
+	ret = fxgmac_calc_rx_buf_size(priv, ndev->mtu);
+	if (ret < 0)
+		goto unlock;
+
+	priv->rx_buf_size = ret;
+	ret = fxgmac_channels_rings_alloc(priv);
+	if (ret < 0)
+		goto unlock;
+
+	INIT_WORK(&priv->restart_work, fxgmac_restart_work);
+	ret = fxgmac_start(priv);
+	if (ret < 0)
+		goto err_channels_and_rings;
+
+	return 0;
+
+err_channels_and_rings:
+	fxgmac_channels_rings_free(priv);
+	dev_err(priv->dev, "%s, channel alloc failed\n", __func__);
+unlock:
+	rtnl_unlock();
+	return ret;
+}
+
 #define EFUSE_FISRT_UPDATE_ADDR				255
 #define EFUSE_SECOND_UPDATE_ADDR			209
 #define EFUSE_MAX_ENTRY					39
@@ -949,6 +1024,15 @@ static int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
 	return ret;
 }
 
+static const struct net_device_ops fxgmac_netdev_ops = {
+	.ndo_open		= fxgmac_open,
+};
+
+const struct net_device_ops *fxgmac_get_netdev_ops(void)
+{
+	return &fxgmac_netdev_ops;
+}
+
 static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 {
 	struct fxgmac_resources res;
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
index 87095f8a2..d52de4482 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -180,7 +180,6 @@
 #define MAC_HWF2R_AUXSNAPNUM		GENMASK(30, 28)
 
 #define MAC_HWF3R			0x2128
-
 #define MAC_MDIO_ADDR			0x2200
 #define MAC_MDIO_ADDR_BUSY		BIT(0)
 #define MAC_MDIO_ADDR_GOC		GENMASK(3, 2)
@@ -235,6 +234,20 @@
 #define DMA_CH_RCR_RBSZ			GENMASK(14, 1)
 #define DMA_CH_RCR_PBL			GENMASK(21, 16)
 
+struct fxgmac_ring_buf {
+	struct sk_buff *skb;
+	dma_addr_t skb_dma;
+	unsigned int skb_len;
+};
+
+/* Common Tx and Rx DMA hardware descriptor */
+struct fxgmac_dma_desc {
+	__le32 desc0;
+	__le32 desc1;
+	__le32 desc2;
+	__le32 desc3;
+};
+
 /* Page allocation related values */
 struct fxgmac_page_alloc {
 	struct page *pages;
@@ -446,6 +459,8 @@ struct fxgmac_pdata {
 	unsigned int tx_pause;
 	unsigned int rx_pause;
 
+	unsigned int rx_buf_size;	/* Current Rx buffer size */
+
 	/* Device interrupt */
 	int dev_irq;
 	unsigned int per_channel_irq;
@@ -477,6 +492,8 @@ struct fxgmac_pdata {
 
 	u32 msg_enable;
 	u32 reg_nonstick[(MSI_PBA - GLOBAL_CTRL0) >> 2];
+
+	struct work_struct restart_work;
 	enum fxgmac_dev_state dev_state;
 #define FXGMAC_POWER_STATE_DOWN			0
 #define FXGMAC_POWER_STATE_UP			1
-- 
2.34.1


