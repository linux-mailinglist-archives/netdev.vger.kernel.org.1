Return-Path: <netdev+bounces-170624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181AA4965C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCC71896D3D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD932260386;
	Fri, 28 Feb 2025 10:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271E25FA06;
	Fri, 28 Feb 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736848; cv=none; b=Y5f2iHAQHT4b5p5BDq1UpzvNmYhvGflEpcyA1riBaMGRAde5p+/T0usCSOjhWluOXbG+86/vR0KSlngH5MDVTnJON+GY7ddl4bv3buMKt/DvnnB4Y37Z08vAWaITtR4qllb0YkTQboEpC9MyLae+NP55rS43alwwoL8714CWXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736848; c=relaxed/simple;
	bh=m6WuCiV/RYA+a5NP+PJkwLidaergF+ppnvVg4Hw89LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7RDIVO8C+y6RxTBUQehez2HWuvWQ57moY3MoBAm8cu3RMVqOVPsHnYxSD2nJ0H0WJfjnca+UowFUiIwIGwY9WV+M9SV6doR6c9TwwRJcexiP2WzkfBxrTTrqBYZqTz+3o98++4NY+W3jOAlUtIN1sdNZIA9YoNc6j1FL57zzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1DD_1740736834 cluster:ay29)
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
Subject: [PATCH net-next v3 05/14] motorcomm:yt6801: Implement the .ndo_open function
Date: Fri, 28 Feb 2025 18:00:11 +0800
Message-Id: <20250228100020.3944-6-Frank.Sae@motor-comm.com>
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

Implement the .ndo_open function to Calculate the Rx buffer size, allocate
 the channels and rings.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   | 223 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    |  90 +++++++
 2 files changed, 313 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
index 3ff5eff11..74a0bec45 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -48,3 +48,226 @@ void fxgmac_desc_data_unmap(struct fxgmac_pdata *priv,
 
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
+		yt_err(priv, "error initializing Tx ring");
+		goto err_init_ring;
+	}
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ret = fxgmac_ring_init(priv, channel->rx_ring,
+				       priv->rx_desc_count);
+		if (ret < 0) {
+			yt_err(priv, "error initializing Rx ring\n");
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
+#ifdef CONFIG_PCI_MSI
+static void fxgmac_set_msix_tx_irq(struct fxgmac_pdata *priv,
+				   struct fxgmac_channel *channel, u32 i)
+{
+	if (i != 0) /*only one tx*/
+		return;
+
+	priv->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS] =
+		priv->msix_entries[FXGMAC_MAX_DMA_RX_CHANNELS].vector;
+	channel->dma_irq_tx = priv->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS];
+}
+#endif
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
+		channel->dma_regs = (priv)->hw_addr + MAC_OFFSET + DMA_CH_BASE +
+				    (DMA_CH_INC * i);
+
+		if (priv->per_channel_irq) {
+			priv->channel_irq[i] = priv->msix_entries[i].vector;
+
+			if (IS_ENABLED(CONFIG_PCI_MSI))
+				fxgmac_set_msix_tx_irq(priv, channel, i);
+
+			/* Get the per DMA rx interrupt */
+			ret = priv->channel_irq[i];
+			if (ret < 0) {
+				yt_err(priv, "get_irq %u err\n", i + 1);
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
+	yt_err(priv, "%s err:%d\n", __func__, ret);
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
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 350510174..c5e02c497 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -11,6 +11,8 @@
 #include "yt6801.h"
 #include "yt6801_desc.h"
 
+const struct net_device_ops *fxgmac_get_netdev_ops(void);
+
 #define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
 static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
 {
@@ -391,6 +393,32 @@ static void fxgmac_stop(struct fxgmac_pdata *priv)
 	netdev_tx_reset_queue(txq);
 }
 
+static void fxgmac_restart(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	/* If not running, "restart" will happen on open */
+	if (!netif_running(priv->netdev) && priv->dev_state != FXGMAC_DEV_START)
+		return;
+
+	mutex_lock(&priv->mutex);
+	fxgmac_stop(priv);
+	fxgmac_free_tx_data(priv);
+	fxgmac_free_rx_data(priv);
+	ret = fxgmac_start(priv);
+	if (ret < 0)
+		yt_err(priv, "%s err, ret = %d.\n", __func__, ret);
+
+	mutex_unlock(&priv->mutex);
+}
+
+static void fxgmac_restart_work(struct work_struct *work)
+{
+	rtnl_lock();
+	fxgmac_restart(container_of(work, struct fxgmac_pdata, restart_work));
+	rtnl_unlock();
+}
+
 static void fxgmac_config_powerdown(struct fxgmac_pdata *priv)
 {
 	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, RE, 1); /* Enable MAC Rx */
@@ -435,6 +463,59 @@ int fxgmac_net_powerdown(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *priv, unsigned int mtu)
+{
+	u32 rx_buf_size, max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
+
+	if (mtu > max_mtu) {
+		yt_err(priv, "MTU exceeds maximum supported value\n");
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
+static int fxgmac_open(struct net_device *netdev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(netdev);
+	int ret;
+
+	mutex_lock(&priv->mutex);
+	priv->dev_state = FXGMAC_DEV_OPEN;
+
+	/* Calculate the Rx buffer size before allocating rings */
+	ret = fxgmac_calc_rx_buf_size(priv, netdev->mtu);
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
+	mutex_unlock(&priv->mutex);
+	return 0;
+
+err_channels_and_rings:
+	fxgmac_channels_rings_free(priv);
+	yt_err(priv, "%s, channel alloc err\n", __func__);
+unlock:
+	mutex_unlock(&priv->mutex);
+	return ret;
+}
+
 #define EFUSE_FISRT_UPDATE_ADDR				255
 #define EFUSE_SECOND_UPDATE_ADDR			209
 #define EFUSE_MAX_ENTRY					39
@@ -932,3 +1013,12 @@ int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
 	free_netdev(netdev);
 	return ret;
 }
+
+static const struct net_device_ops fxgmac_netdev_ops = {
+	.ndo_open		= fxgmac_open,
+};
+
+const struct net_device_ops *fxgmac_get_netdev_ops(void)
+{
+	return &fxgmac_netdev_ops;
+}
-- 
2.34.1


