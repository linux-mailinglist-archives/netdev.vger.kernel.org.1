Return-Path: <netdev+bounces-146465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CFC9D38D6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411DF2837C6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8F19F41D;
	Wed, 20 Nov 2024 10:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6318EFC1;
	Wed, 20 Nov 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100210; cv=none; b=gxw/YeNO2nwyzoW2FhgKwUdpQEj9fbsrjobKCW/ORhiVay2GaGR4bJbNzZL8jVEqH7uEyNishcNGYPB16t5JruxZ6uAuXUtLm+hktz9uNaCvqGR1A5HXcD73I6w8bapaE4zly1JmuUn+3uZywzI8zvxspb7z/z2EfaGePuKoPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100210; c=relaxed/simple;
	bh=+g9JcUa75QccAzbQpBW0hbPrJPIMhd5zf4zHpW55fEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKPBxvbBTfkvXrk2tgOSIG4OMWDXBguXvXChzbtqoSAzl4tPRFP9xci+7GMpo5KrT9UosJDlUqsJY+Jqyidp603NLGLTaXFBHRw9ueCvclthD+TIa+B2l/Aidf6s3SrxaYasEr1dULm8FyVoMVDrf3PpNGTU6oH3eqJU/Ux8at0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppW0_1732100200 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:41 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 04/21] motorcomm:yt6801: Implement the .ndo_open function
Date: Wed, 20 Nov 2024 18:56:08 +0800
Message-Id: <20241120105625.22508-5-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement the .ndo_open function to Calculate the Rx buffer size， allocate the
channels and rings.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   | 273 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    |  99 +++++++
 2 files changed, 372 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
index 476cf6633..2edf53d9b 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -47,3 +47,276 @@ void fxgmac_desc_data_unmap(struct fxgmac_pdata *pdata,
 
 	desc_data->mapped_as_page = 0;
 }
+
+static void fxgmac_ring_free(struct fxgmac_pdata *pdata,
+			     struct fxgmac_ring *ring)
+{
+	if (!ring)
+		return;
+
+	if (ring->desc_data_head) {
+		for (u32 i = 0; i < ring->dma_desc_count; i++)
+			fxgmac_desc_data_unmap(pdata,
+					       FXGMAC_GET_DESC_DATA(ring, i));
+
+		kfree(ring->desc_data_head);
+		ring->desc_data_head = NULL;
+	}
+
+	if (ring->rx_hdr_pa.pages) {
+		dma_unmap_page(pdata->dev, ring->rx_hdr_pa.pages_dma,
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
+		dma_unmap_page(pdata->dev, ring->rx_buf_pa.pages_dma,
+			       ring->rx_buf_pa.pages_len, DMA_FROM_DEVICE);
+		put_page(ring->rx_buf_pa.pages);
+
+		ring->rx_buf_pa.pages = NULL;
+		ring->rx_buf_pa.pages_len = 0;
+		ring->rx_buf_pa.pages_offset = 0;
+		ring->rx_buf_pa.pages_dma = 0;
+	}
+	if (ring->dma_desc_head) {
+		dma_free_coherent(pdata->dev, (sizeof(struct fxgmac_dma_desc) *
+				  ring->dma_desc_count), ring->dma_desc_head,
+				  ring->dma_desc_head_addr);
+		ring->dma_desc_head = NULL;
+	}
+}
+
+static int fxgmac_ring_init(struct fxgmac_pdata *pdata,
+			    struct fxgmac_ring *ring,
+			    unsigned int dma_desc_count)
+{
+	/* Descriptors */
+	ring->dma_desc_count = dma_desc_count;
+	ring->dma_desc_head =
+		dma_alloc_coherent(pdata->dev, (sizeof(struct fxgmac_dma_desc) *
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
+	yt_dbg(pdata,
+	       "dma_desc_head=%p, dma_desc_head_addr=%pad, desc_data_head=%p\n",
+	       ring->dma_desc_head, &ring->dma_desc_head_addr,
+	       ring->desc_data_head);
+	return 0;
+}
+
+static void fxgmac_rings_free(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+
+	fxgmac_ring_free(pdata, channel->tx_ring);
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++)
+		fxgmac_ring_free(pdata, channel->rx_ring);
+}
+
+static int fxgmac_rings_alloc(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	int ret;
+
+	yt_dbg(pdata, "%s - Tx ring:\n", channel->name);
+	ret = fxgmac_ring_init(pdata, channel->tx_ring,
+			       pdata->tx_desc_count);
+	if (ret < 0) {
+		yt_err(pdata, "error initializing Tx ring");
+		goto err_init_ring;
+	}
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata,
+		       "%s, ch=%u,tx_desc_cnt=%u\n",
+		       __func__, 0, pdata->tx_desc_count);
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		yt_dbg(pdata, "%s - Rx ring:\n", channel->name);
+		ret = fxgmac_ring_init(pdata, channel->rx_ring,
+				       pdata->rx_desc_count);
+		if (ret < 0) {
+			yt_err(pdata, "error initializing Rx ring\n");
+			goto err_init_ring;
+		}
+		if (netif_msg_drv(pdata))
+			yt_dbg(pdata,
+			       "%s, ch=%u,rx_desc_cnt=%u\n",
+			       __func__, i,
+			       pdata->rx_desc_count);
+	}
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return 0;
+
+err_init_ring:
+	fxgmac_rings_free(pdata);
+	return ret;
+}
+
+static void fxgmac_channels_free(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "free_channels,tx_ring=%p\n", channel->tx_ring);
+
+	kfree(channel->tx_ring);
+	channel->tx_ring = NULL;
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "free_channels,rx_ring=%p\n", channel->rx_ring);
+
+	kfree(channel->rx_ring);
+	channel->rx_ring = NULL;
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "free_channels,channel=%p\n", channel);
+
+	kfree(channel);
+	pdata->channel_head = NULL;
+}
+
+#ifdef CONFIG_PCI_MSI
+static void fxgmac_set_msix_tx_irq(struct fxgmac_pdata *pdata,
+				   struct fxgmac_channel *channel, u32 i)
+{
+	if (!FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i))
+		return;
+
+	pdata->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS] =
+		pdata->msix_entries[FXGMAC_MAX_DMA_RX_CHANNELS].vector;
+	channel->dma_irq_tx = pdata->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS];
+
+	yt_dbg(pdata, "%s, for MSIx, channel %d dma_irq_tx=%u\n", __func__, i,
+	       channel->dma_irq_tx);
+}
+#endif
+
+static int fxgmac_channels_alloc(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel_head, *channel;
+	struct fxgmac_ring *tx_ring, *rx_ring;
+	int ret = -ENOMEM;
+
+	channel_head = kcalloc(pdata->channel_count,
+			       sizeof(struct fxgmac_channel), GFP_KERNEL);
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "alloc_channels,channel_head=%p,size=%d*%ld\n",
+		       channel_head, pdata->channel_count,
+		       sizeof(struct fxgmac_channel));
+
+	if (!channel_head)
+		return ret;
+
+	tx_ring = kcalloc(FXGMAC_TX_1_RING, sizeof(struct fxgmac_ring),
+			  GFP_KERNEL);
+	if (!tx_ring)
+		goto err_tx_ring;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "alloc_channels,tx_ring=%p,size=%d*%ld\n",
+		       tx_ring, FXGMAC_TX_1_RING,
+		       sizeof(struct fxgmac_ring));
+
+	rx_ring = kcalloc(pdata->rx_ring_count, sizeof(struct fxgmac_ring),
+			  GFP_KERNEL);
+	if (!rx_ring)
+		goto err_rx_ring;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "alloc_channels,rx_ring=%p,size=%d*%ld\n",
+		       rx_ring, pdata->rx_ring_count,
+		       sizeof(struct fxgmac_ring));
+
+	channel = channel_head;
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
+		channel->pdata = pdata;
+		channel->queue_index = i;
+		channel->dma_reg_offset = DMA_CH_BASE + (DMA_CH_INC * i);
+
+		if (pdata->per_channel_irq) {
+			pdata->channel_irq[i] = pdata->msix_entries[i].vector;
+#ifdef CONFIG_PCI_MSI
+			fxgmac_set_msix_tx_irq(pdata, channel, i);
+#endif
+
+			/* Get the per DMA rx interrupt */
+			ret = pdata->channel_irq[i];
+			if (ret < 0) {
+				yt_err(pdata, "get_irq %u err\n", i + 1);
+				goto err_irq;
+			}
+
+			channel->dma_irq_rx = ret;
+			yt_dbg(pdata,
+			       "%s, for MSIx, channel %d dma_irq_rx=%u\n",
+			       __func__, i, channel->dma_irq_rx);
+		}
+
+		if (i < FXGMAC_TX_1_RING)
+			channel->tx_ring = tx_ring++;
+
+		if (i < pdata->rx_ring_count)
+			channel->rx_ring = rx_ring++;
+	}
+
+	pdata->channel_head = channel_head;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
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
+	yt_err(pdata, "%s err:%d\n", __func__, ret);
+	return ret;
+}
+
+void fxgmac_channels_rings_free(struct fxgmac_pdata *pdata)
+{
+	fxgmac_rings_free(pdata);
+	fxgmac_channels_free(pdata);
+}
+
+int fxgmac_channels_rings_alloc(struct fxgmac_pdata *pdata)
+{
+	int ret;
+
+	ret = fxgmac_channels_alloc(pdata);
+	if (ret < 0)
+		goto err_alloc;
+
+	ret = fxgmac_rings_alloc(pdata);
+	if (ret < 0)
+		goto err_alloc;
+
+	return 0;
+
+err_alloc:
+	fxgmac_channels_rings_free(pdata);
+	return ret;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 0cb2808b7..39b91cc26 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -11,6 +11,26 @@
 #include "yt6801_desc.h"
 #include "yt6801_net.h"
 
+static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *pdata, unsigned int mtu)
+{
+	u32 rx_buf_size, max_mtu;
+
+	max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
+	if (mtu > max_mtu) {
+		yt_err(pdata, "MTU exceeds maximum supported value\n");
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
 #define FXGMAC_NAPI_ENABLE			0x1
 #define FXGMAC_NAPI_DISABLE			0x0
 static void fxgmac_napi_disable(struct fxgmac_pdata *pdata)
@@ -197,6 +217,36 @@ void fxgmac_stop(struct fxgmac_pdata *pdata)
 	netdev_tx_reset_queue(txq);
 }
 
+void fxgmac_restart(struct fxgmac_pdata *pdata)
+{
+	int ret;
+
+	/* If not running, "restart" will happen on open */
+	if (!netif_running(pdata->netdev) &&
+	    pdata->dev_state != FXGMAC_DEV_START)
+		return;
+
+	mutex_lock(&pdata->mutex);
+	fxgmac_stop(pdata);
+	fxgmac_free_tx_data(pdata);
+	fxgmac_free_rx_data(pdata);
+	ret = fxgmac_start(pdata);
+	if (ret < 0)
+		yt_err(pdata, "%s err.\n", __func__);
+
+	mutex_unlock(&pdata->mutex);
+}
+
+static void fxgmac_restart_work(struct work_struct *work)
+{
+	struct fxgmac_pdata *pdata =
+		container_of(work, struct fxgmac_pdata, restart_work);
+
+	rtnl_lock();
+	fxgmac_restart(pdata);
+	rtnl_unlock();
+}
+
 int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, bool wake_en)
 {
 	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
@@ -250,6 +300,46 @@ int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, bool wake_en)
 	return 0;
 }
 
+static int fxgmac_open(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	mutex_lock(&pdata->mutex);
+	pdata->dev_state = FXGMAC_DEV_OPEN;
+
+	/* Calculate the Rx buffer size before allocating rings */
+	ret = fxgmac_calc_rx_buf_size(pdata, netdev->mtu);
+	if (ret < 0)
+		goto unlock;
+	pdata->rx_buf_size = ret;
+
+	/* Allocate the channels and rings */
+	ret = fxgmac_channels_rings_alloc(pdata);
+	if (ret < 0)
+		goto unlock;
+
+	INIT_WORK(&pdata->restart_work, fxgmac_restart_work);
+
+	ret = fxgmac_start(pdata);
+	if (ret < 0)
+		goto err_channels_and_rings;
+
+	mutex_unlock(&pdata->mutex);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return 0;
+
+err_channels_and_rings:
+	fxgmac_channels_rings_free(pdata);
+	yt_dbg(pdata, "%s, channel alloc err\n", __func__);
+unlock:
+	mutex_unlock(&pdata->mutex);
+	return ret;
+}
+
 #ifdef CONFIG_PCI_MSI
 static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *pdata)
 {
@@ -442,3 +532,12 @@ int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
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


