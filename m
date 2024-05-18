Return-Path: <netdev+bounces-97091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86F8C9108
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD011C20859
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D447F5F;
	Sat, 18 May 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fzmKhZD8"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66847F41;
	Sat, 18 May 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036249; cv=none; b=eAd6rGPku3OqG6HnFadRZMhFVbXqDwQ8302NMYHV/c1oySFYPlQqYRFkmeicMBv11ymrL2KVrWUcjiajIcgeaz3QWZmyVB9s7SSfc428CmOBBjx8eabCBKkM/7ggwXNts4ImaYpmm2nrhylQL3MoFUrJRua420AJ0EUDVEeovJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036249; c=relaxed/simple;
	bh=xdwj5vF7j12BQeU6xoxU2CMmSC1eDsIBw2vHSiP6cpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV15rNsWOBNJVuDvy/1+1RxalfJs7KJYx3aMPIHESD1O8YYOWaQxpDhoTvMU940R3lDzM9+ZTFpZM1wC6uaHLtn8l2aBj+JHdxn0hBBzMPlfAMvpyJsX32v0OtVXVM/KV+l2sSfzoPfNNbuzxlcZeKeCevyA1kmIirhlcHd57xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fzmKhZD8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChrOQ055013;
	Sat, 18 May 2024 07:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036233;
	bh=qil1v3zl/pPDcdHjVC1LhrqtUF1vIpFvRXXcumK5U6Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fzmKhZD82TIDbTU+w8b1mZ5xX/OfeEfwkvCK9bbJaj8ksLiZJAKeMsO/9yy7OIfQa
	 4DyiduW09fmR0cooEERY6ZJFthwtPDCvyKYrI04qgiGxzSztly8qCwBrDb5+vjjs7X
	 HLnR7cxD7BnRpWUf9JGfGtU6xCuQnuvyyytQgZyY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChrtP129623
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:53 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:52 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9W041511;
	Sat, 18 May 2024 07:43:48 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 16/28] net: ethernet: ti: cpsw-proxy-client: implement and register ndo_open
Date: Sat, 18 May 2024 18:12:22 +0530
Message-ID: <20240518124234.2671651-17-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the function "vport_ndo_open()" and register it as the driver's
.ndo_open callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 161 ++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 7af4a89a1847..e643ffb9455a 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -131,6 +131,11 @@ struct cpsw_proxy_priv {
 	u32				num_active_rx_chans;
 };
 
+#define vport_netdev_to_priv(ndev) \
+	((struct vport_netdev_priv *)netdev_priv(ndev))
+#define vport_ndev_to_vport(ndev) \
+	(vport_netdev_to_priv(ndev)->vport)
+
 static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
 				int len, void *priv, u32 src)
 {
@@ -1229,7 +1234,163 @@ static int deregister_mac(struct virtual_port *vport)
 	return ret;
 }
 
+static void vport_tx_cleanup(void *data, dma_addr_t desc_dma)
+{
+	struct tx_dma_chan *tx_chn = data;
+	struct cppi5_host_desc_t *desc_tx;
+	struct sk_buff *skb;
+	void **swdata;
+
+	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
+	swdata = cppi5_hdesc_get_swdata(desc_tx);
+	skb = *(swdata);
+	vport_xmit_free(tx_chn, tx_chn->dev, desc_tx);
+
+	dev_kfree_skb_any(skb);
+}
+
+static void vport_rx_cleanup(void *data, dma_addr_t desc_dma)
+{
+	struct rx_dma_chan *rx_chn = data;
+	struct cppi5_host_desc_t *desc_rx;
+	struct sk_buff *skb;
+	dma_addr_t buf_dma;
+	u32 buf_dma_len;
+	void **swdata;
+
+	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
+	swdata = cppi5_hdesc_get_swdata(desc_rx);
+	skb = *swdata;
+	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
+
+	dma_unmap_single(rx_chn->dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
+	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+
+	dev_kfree_skb_any(skb);
+}
+
+static void vport_stop(struct virtual_port *vport)
+{
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	int i;
+
+	/* shutdown tx channels */
+	atomic_set(&vport->tdown_cnt, vport->num_tx_chan);
+	/* ensure new tdown_cnt value is visible */
+	smp_mb__after_atomic();
+	reinit_completion(&vport->tdown_complete);
+
+	for (i = 0; i < vport->num_tx_chan; i++)
+		k3_udma_glue_tdown_tx_chn(vport->tx_chans[i].tx_chan, false);
+
+	i = wait_for_completion_timeout(&vport->tdown_complete, msecs_to_jiffies(1000));
+	if (!i)
+		dev_err(proxy_priv->dev, "tx teardown timeout\n");
+
+	for (i = 0; i < vport->num_tx_chan; i++) {
+		tx_chn = &vport->tx_chans[i];
+		k3_udma_glue_reset_tx_chn(tx_chn->tx_chan, tx_chn, vport_tx_cleanup);
+		k3_udma_glue_disable_tx_chn(tx_chn->tx_chan);
+		napi_disable(&tx_chn->napi_tx);
+	}
+
+	for (i = 0; i < vport->num_rx_chan; i++) {
+		rx_chn = &vport->rx_chans[i];
+		k3_udma_glue_rx_flow_disable(rx_chn->rx_chan, 0);
+		/* Need some delay to process RX ring before reset */
+		msleep(100);
+		k3_udma_glue_reset_rx_chn(rx_chn->rx_chan, 0, rx_chn, vport_rx_cleanup,
+					  false);
+		napi_disable(&rx_chn->napi_rx);
+	}
+}
+
+static int vport_open(struct virtual_port *vport, netdev_features_t features)
+{
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	struct sk_buff *skb;
+	u32 i, j;
+	int ret;
+
+	for (i = 0; i < vport->num_rx_chan; i++) {
+		rx_chn = &vport->rx_chans[i];
+
+		for (j = 0; j < rx_chn->num_descs; j++) {
+			skb = __netdev_alloc_skb_ip_align(NULL, MAX_PACKET_SIZE, GFP_KERNEL);
+			if (!skb)
+				return -ENOMEM;
+
+			ret = vport_rx_push(vport, skb, i);
+			if (ret < 0) {
+				netdev_err(vport->ndev,
+					   "cannot submit skb to rx channel\n");
+				kfree_skb(skb);
+				return ret;
+			}
+			kmemleak_not_leak(skb);
+		}
+
+		ret = k3_udma_glue_rx_flow_enable(rx_chn->rx_chan, 0);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < vport->num_tx_chan; i++) {
+		tx_chn = &vport->tx_chans[i];
+		ret = k3_udma_glue_enable_tx_chn(tx_chn->tx_chan);
+		if (ret)
+			return ret;
+		napi_enable(&tx_chn->napi_tx);
+	}
+
+	for (i = 0; i < vport->num_rx_chan; i++) {
+		rx_chn = &vport->rx_chans[i];
+		napi_enable(&rx_chn->napi_rx);
+	}
+
+	return 0;
+}
+
+static int vport_ndo_open(struct net_device *ndev)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	int ret;
+	u32 i;
+
+	ret = netif_set_real_num_tx_queues(ndev, vport->num_tx_chan);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < vport->num_tx_chan; i++)
+		netdev_tx_reset_queue(netdev_get_tx_queue(ndev, i));
+
+	ret = vport_open(vport, ndev->features);
+	if (ret)
+		return ret;
+
+	ret = register_mac(vport);
+	if (ret) {
+		netdev_err(ndev, "failed to register MAC for port: %u\n",
+			   vport->port_id);
+		vport_stop(vport);
+		return -EIO;
+	}
+
+	netif_tx_wake_all_queues(ndev);
+	netif_carrier_on(ndev);
+
+	dev_info(proxy_priv->dev, "started port %u on interface %s\n",
+		 vport->port_id, ndev->name);
+
+	return 0;
+}
+
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
+	.ndo_open		= vport_ndo_open,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
-- 
2.40.1


