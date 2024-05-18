Return-Path: <netdev+bounces-97086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9E8C90FA
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DCFB20A53
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619AD6E61A;
	Sat, 18 May 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tLVR9OHX"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDF6E5E8;
	Sat, 18 May 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036227; cv=none; b=KgsT3q28jioqUKxZi68TC138cehqSHWK/vZbbx7wjp00MaZYyL6HW5uJ3Dbxbbs+nOeyhYFx5VLbrTNFpmP8Ml9VcIVkHznn70CJbTBAegVR+dXJWR1z5HJGuCWjF285vfVGttTzYHaNZW8WlyKgQ+mXPhfFoIH1R0J4KZ4Q3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036227; c=relaxed/simple;
	bh=7jnXzgN1DYVWeRy7s3XSSsPtDdBRVBcKsoIA0Bx5U5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGfdnFh6qiUjyJ41I009JU9qgilSQpySLzWU3YynCHtfiSDLV0NSNh5q57vJzl2EhiLYaylmd9cva3wizSxgOHjzMhHJ3z/NOh5OVRLoqvrNOjT2tyxVwVEoxOegNYfOmlebQh0mZFCsqbZdaKXouP1fIGRvm4vcmmzAB7x+3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tLVR9OHX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChUrw110100;
	Sat, 18 May 2024 07:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036210;
	bh=MsofboICpT4F+D2umTdZQcxmXGgAuWnH2iVGw4gZnhQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tLVR9OHXuhS7L3Ct+TQNsfrSXKN0rRnW6cy3Q16jZ1wPb6t5LwJY4xbyHT+Qqqqnd
	 sB4dg5qB8PoRUYV3R4B6OAucHv40FjdDqs51PC1pcMX8OM8/a0nIYnEaAn9RK+16Do
	 EVQK+Ui4rz53Q0Jv2XQ2PQFNNL+yA4LqXfatgfXA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChUPm051425
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:29 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9R041511;
	Sat, 18 May 2024 07:43:25 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 11/28] net: ethernet: ti: cpsw-proxy-client: add NAPI TX polling function
Date: Sat, 18 May 2024 18:12:17 +0530
Message-ID: <20240518124234.2671651-12-s-vadapalli@ti.com>
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

Add the "vport_tx_poll()" function to be registered as the NAPI TX
polling function via "netif_napi_add_tx()".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 16e8e585adce..cf99d8b6c1ec 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -66,6 +66,7 @@ struct tx_dma_chan {
 	struct device			*dev;
 	struct k3_cppi_desc_pool	*desc_pool;
 	struct k3_udma_glue_tx_channel	*tx_chan;
+	struct napi_struct		napi_tx;
 	u32				rel_chan_idx;
 	u32				thread_id;
 	u32				num_descs;
@@ -74,11 +75,26 @@ struct tx_dma_chan {
 	bool				in_use;
 };
 
+struct vport_netdev_stats {
+	u64			tx_packets;
+	u64			tx_bytes;
+	u64			rx_packets;
+	u64			rx_bytes;
+	struct u64_stats_sync	syncp;
+};
+
+struct vport_netdev_priv {
+	struct vport_netdev_stats __percpu	*stats;
+	struct virtual_port			*vport;
+};
+
 struct virtual_port {
 	struct cpsw_proxy_priv		*proxy_priv;
 	struct rx_dma_chan		*rx_chans;
 	struct tx_dma_chan		*tx_chans;
+	struct completion		tdown_complete;
 	enum virtual_port_type		port_type;
+	atomic_t			tdown_cnt;
 	u32				port_id;
 	u32				port_token;
 	u32				port_features;
@@ -672,6 +688,7 @@ static int init_tx_chans(struct cpsw_proxy_priv *proxy_priv)
 
 	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
 		vport = &proxy_priv->virt_ports[i];
+		init_completion(&vport->tdown_complete);
 
 		for (j = 0; j < vport->num_tx_chan; j++) {
 			tx_chn = &vport->tx_chans[j];
@@ -848,6 +865,129 @@ static int init_rx_chans(struct cpsw_proxy_priv *proxy_priv)
 	return ret;
 }
 
+static void vport_xmit_free(struct tx_dma_chan *tx_chn, struct device *dev,
+			    struct cppi5_host_desc_t *desc)
+{
+	struct cppi5_host_desc_t *first_desc, *next_desc;
+	dma_addr_t buf_dma, next_desc_dma;
+	u32 buf_dma_len;
+
+	first_desc = desc;
+	next_desc = first_desc;
+
+	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
+
+	dma_unmap_single(dev, buf_dma, buf_dma_len,
+			 DMA_TO_DEVICE);
+
+	next_desc_dma = cppi5_hdesc_get_next_hbdesc(first_desc);
+	while (next_desc_dma) {
+		next_desc = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
+						       next_desc_dma);
+		cppi5_hdesc_get_obuf(next_desc, &buf_dma, &buf_dma_len);
+
+		dma_unmap_page(dev, buf_dma, buf_dma_len,
+			       DMA_TO_DEVICE);
+
+		next_desc_dma = cppi5_hdesc_get_next_hbdesc(next_desc);
+
+		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
+	}
+
+	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
+}
+
+static int tx_compl_packets(struct virtual_port *vport, unsigned int tx_chan_idx,
+			    unsigned int budget, bool *tdown)
+{
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct device *dev = proxy_priv->dev;
+	struct cppi5_host_desc_t *desc_tx;
+	struct netdev_queue *netif_txq;
+	unsigned int total_bytes = 0;
+	struct tx_dma_chan *tx_chn;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	dma_addr_t desc_dma;
+	int res, num_tx = 0;
+	void **swdata;
+
+	tx_chn = &vport->tx_chans[tx_chan_idx];
+
+	while (budget--) {
+		struct vport_netdev_priv *ndev_priv;
+		struct vport_netdev_stats *stats;
+
+		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chan, &desc_dma);
+		if (res == -ENODATA)
+			break;
+
+		if (desc_dma & 0x1) {
+			if (atomic_dec_and_test(&vport->tdown_cnt))
+				complete(&vport->tdown_complete);
+			*tdown = true;
+			break;
+		}
+
+		desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
+						     desc_dma);
+		swdata = cppi5_hdesc_get_swdata(desc_tx);
+		skb = *(swdata);
+		vport_xmit_free(tx_chn, dev, desc_tx);
+
+		ndev = skb->dev;
+
+		ndev_priv = netdev_priv(ndev);
+		stats = this_cpu_ptr(ndev_priv->stats);
+		u64_stats_update_begin(&stats->syncp);
+		stats->tx_packets++;
+		stats->tx_bytes += skb->len;
+		u64_stats_update_end(&stats->syncp);
+
+		total_bytes += skb->len;
+		napi_consume_skb(skb, budget);
+		num_tx++;
+	}
+
+	if (!num_tx)
+		return 0;
+
+	netif_txq = netdev_get_tx_queue(ndev, tx_chan_idx);
+	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
+
+	if (netif_tx_queue_stopped(netif_txq)) {
+		__netif_tx_lock(netif_txq, smp_processor_id());
+		if (netif_running(ndev) &&
+		    (k3_cppi_desc_pool_avail(tx_chn->desc_pool) >=
+		     MAX_SKB_FRAGS))
+			netif_tx_wake_queue(netif_txq);
+
+		__netif_tx_unlock(netif_txq);
+	}
+
+	return num_tx;
+}
+
+static int vport_tx_poll(struct napi_struct *napi_tx, int budget)
+{
+	struct tx_dma_chan *tx_chn = container_of(napi_tx, struct tx_dma_chan,
+							 napi_tx);
+	struct virtual_port *vport = tx_chn->vport;
+	bool tdown = false;
+	int num_tx;
+
+	/* process every unprocessed channel */
+	num_tx = tx_compl_packets(vport, tx_chn->rel_chan_idx, budget, &tdown);
+
+	if (num_tx >= budget)
+		return budget;
+
+	if (napi_complete_done(napi_tx, num_tx))
+		enable_irq(tx_chn->irq);
+
+	return 0;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


