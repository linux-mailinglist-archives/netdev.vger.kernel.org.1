Return-Path: <netdev+bounces-97087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6858C90FD
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E5E1F21C06
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B366F086;
	Sat, 18 May 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qN6or/0K"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F76EB5D;
	Sat, 18 May 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036229; cv=none; b=h1i7vIx+7snP+VsaoqqOzI7VoJ878sEcN/DBPm7aLFS++BK7sYjB+6j2/zhfYmF+ExcGpJOsZl7Ncvd2jmwb7totknOwJSXxk+plyl8cf0Lz/dNlbOsqahJge95ZRD4xVExcCVsln7OTOpXqgkJ36pGGIBHY8qSfyF3R0wXbK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036229; c=relaxed/simple;
	bh=G1p3WYla4GtP7wFX84DnEU4P/oP2uoStviRxIClBfdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6xGeootPlyKy7y0G7LG/D0XFSOClKISkhOl2KAhpure7Y4vfafqQsQK+uwq/YfEEORjoHSizxhtvVdnjARVl6GNuz/nOwyQbu7X9e4uNcWq3yP2fnQP406tpzC6eZ3tguMsjeuMZTi9btxLzSjKHzjiy+z5zZqVBukLwX43f6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qN6or/0K; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChYvl054987;
	Sat, 18 May 2024 07:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036215;
	bh=VPQuJU0oxohYz+O/nfKaLrIBOkh0o0tWyD1UPoA6Aqs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qN6or/0K7l8Gfl26Q87faFDCnjGM8uwmhjMqW4LDsBEfOBeGPjugBdR7a6WerQgui
	 Tdbd3+VZ19qqCofO4e4JMQLNsJ9p0QfJoJ6JiGd48M/K1HVJyWj6XYIwTGESG+F961
	 LJ4PSdnqEVX6AmJIfd2CJj6gBaC2XgCBXsSQynWY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChYuG004213
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:34 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:34 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9S041511;
	Sat, 18 May 2024 07:43:30 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 12/28] net: ethernet: ti: cpsw-proxy-client: add NAPI RX polling function
Date: Sat, 18 May 2024 18:12:18 +0530
Message-ID: <20240518124234.2671651-13-s-vadapalli@ti.com>
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

Add the "vport_rx_poll()" function to be registered as the NAPI RX
polling function via "netif_napi_add()".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 189 ++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index cf99d8b6c1ec..6926f65a4613 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/kernel.h>
+#include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/dma/k3-udma-glue.h>
@@ -23,6 +25,8 @@
 #define MAX_RX_DESC	500
 #define MAX_RX_FLOWS	1
 
+#define MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
+
 #define CHAN_NAME_LEN	128
 
 enum virtual_port_type {
@@ -51,6 +55,7 @@ struct rx_dma_chan {
 	struct device			*dev;
 	struct k3_cppi_desc_pool	*desc_pool;
 	struct k3_udma_glue_rx_channel	*rx_chan;
+	struct napi_struct		napi_rx;
 	u32				rel_chan_idx;
 	u32				flow_base;
 	u32				flow_offset;
@@ -90,6 +95,7 @@ struct vport_netdev_priv {
 
 struct virtual_port {
 	struct cpsw_proxy_priv		*proxy_priv;
+	struct net_device		*ndev;
 	struct rx_dma_chan		*rx_chans;
 	struct tx_dma_chan		*tx_chans;
 	struct completion		tdown_complete;
@@ -988,6 +994,189 @@ static int vport_tx_poll(struct napi_struct *napi_tx, int budget)
 	return 0;
 }
 
+/* RX psdata[2] word format - checksum information */
+#define RX_PSD_CSUM_ERR		BIT(16)
+#define RX_PSD_IS_FRAGMENT	BIT(17)
+#define RX_PSD_IPV6_VALID	BIT(19)
+#define RX_PSD_IPV4_VALID	BIT(20)
+
+static void vport_rx_csum(struct sk_buff *skb, u32 csum_info)
+{
+	/* HW can verify IPv4/IPv6 TCP/UDP packets checksum
+	 * csum information provides in psdata[2] word:
+	 * RX_PSD_CSUM_ERR bit - indicates csum error
+	 * RX_PSD_IPV6_VALID and CPSW_RX_PSD_IPV4_VALID
+	 * bits - indicates IPv4/IPv6 packet
+	 * RX_PSD_IS_FRAGMENT bit - indicates fragmented packet
+	 * RX_PSD_CSUM_ADD has value 0xFFFF for non fragmented packets
+	 * or csum value for fragmented packets if !RX_PSD_CSUM_ERR
+	 */
+	skb_checksum_none_assert(skb);
+
+	if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM)))
+		return;
+
+	if ((csum_info & (RX_PSD_IPV6_VALID |
+			  RX_PSD_IPV4_VALID)) &&
+			  !(csum_info & RX_PSD_CSUM_ERR)) {
+		/* csum for fragmented packets is unsupported */
+		if (!(csum_info & RX_PSD_IS_FRAGMENT))
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+}
+
+static int vport_rx_push(struct virtual_port *vport, struct sk_buff *skb,
+			 u32 rx_chan_idx)
+{
+	struct rx_dma_chan *rx_chn = &vport->rx_chans[rx_chan_idx];
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct device *dev = proxy_priv->dev;
+	struct cppi5_host_desc_t *desc_rx;
+	u32 pkt_len = skb_tailroom(skb);
+	dma_addr_t desc_dma;
+	dma_addr_t buf_dma;
+	void *swdata;
+
+	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
+	if (!desc_rx) {
+		dev_err(dev, "Failed to allocate RXFDQ descriptor\n");
+		return -ENOMEM;
+	}
+	desc_dma = k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
+
+	buf_dma = dma_map_single(dev, skb->data, pkt_len, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(dev, buf_dma))) {
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+		dev_err(dev, "Failed to map rx skb buffer\n");
+		return -EINVAL;
+	}
+
+	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
+			 PS_DATA_SIZE);
+	cppi5_hdesc_attach_buf(desc_rx, 0, 0, buf_dma, skb_tailroom(skb));
+	swdata = cppi5_hdesc_get_swdata(desc_rx);
+	*((void **)swdata) = skb;
+
+	return k3_udma_glue_push_rx_chn(rx_chn->rx_chan, 0, desc_rx, desc_dma);
+}
+
+static int vport_rx_packets(struct virtual_port *vport, u32 rx_chan_idx)
+{
+	struct rx_dma_chan *rx_chn = &vport->rx_chans[rx_chan_idx];
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	u32 buf_dma_len, pkt_len, port_id = 0, csum_info;
+	struct device *dev = proxy_priv->dev;
+	struct vport_netdev_priv *ndev_priv;
+	struct cppi5_host_desc_t *desc_rx;
+	struct vport_netdev_stats *stats;
+	struct sk_buff *skb, *new_skb;
+	dma_addr_t desc_dma, buf_dma;
+	struct net_device *ndev;
+	u32 flow_idx = 0;
+	void **swdata;
+	int ret = 0;
+	u32 *psdata;
+
+	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chan, flow_idx, &desc_dma);
+	if (ret) {
+		if (ret != -ENODATA)
+			dev_err(dev, "RX: pop chn fail %d\n", ret);
+		return ret;
+	}
+
+	if (desc_dma & 0x1) {
+		dev_dbg(dev, "%s RX tdown flow: %u\n", __func__, flow_idx);
+		return 0;
+	}
+
+	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
+	dev_dbg(dev, "%s flow_idx: %u desc %pad\n",
+		__func__, flow_idx, &desc_dma);
+
+	swdata = cppi5_hdesc_get_swdata(desc_rx);
+	skb = *swdata;
+	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
+	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
+	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
+	/* read port for dbg */
+	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
+	ndev = vport->ndev;
+	skb->dev = ndev;
+
+	psdata = cppi5_hdesc_get_psdata(desc_rx);
+	csum_info = psdata[2];
+	dev_dbg(dev, "%s rx csum_info:%#x\n", __func__, csum_info);
+
+	dma_unmap_single(dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
+
+	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+
+	if (unlikely(!netif_running(skb->dev))) {
+		dev_kfree_skb_any(skb);
+		return -ENODEV;
+	}
+
+	new_skb = netdev_alloc_skb_ip_align(ndev, MAX_PACKET_SIZE);
+	if (new_skb) {
+		skb_put(skb, pkt_len);
+		skb->protocol = eth_type_trans(skb, ndev);
+		vport_rx_csum(skb, csum_info);
+		napi_gro_receive(&rx_chn->napi_rx, skb);
+
+		ndev_priv = netdev_priv(ndev);
+		stats = this_cpu_ptr(ndev_priv->stats);
+
+		u64_stats_update_begin(&stats->syncp);
+		stats->rx_packets++;
+		stats->rx_bytes += pkt_len;
+		u64_stats_update_end(&stats->syncp);
+		kmemleak_not_leak(new_skb);
+	} else {
+		ndev->stats.rx_dropped++;
+		new_skb = skb;
+	}
+
+	if (netif_dormant(ndev)) {
+		dev_kfree_skb_any(new_skb);
+		ndev->stats.rx_dropped++;
+		return -ENODEV;
+	}
+
+	ret = vport_rx_push(vport, new_skb, rx_chn->rel_chan_idx);
+	if (WARN_ON(ret < 0)) {
+		dev_kfree_skb_any(new_skb);
+		ndev->stats.rx_errors++;
+		ndev->stats.rx_dropped++;
+	}
+
+	return ret;
+}
+
+static int vport_rx_poll(struct napi_struct *napi_rx, int budget)
+{
+	struct rx_dma_chan *rx_chn = container_of(napi_rx, struct rx_dma_chan,
+							 napi_rx);
+	struct virtual_port *vport = rx_chn->vport;
+	int num_rx = 0;
+	int cur_budget;
+	int ret;
+
+	/* process every flow */
+	cur_budget = budget;
+
+	while (cur_budget--) {
+		ret = vport_rx_packets(vport, rx_chn->rel_chan_idx);
+		if (ret)
+			break;
+		num_rx++;
+	}
+
+	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
+		enable_irq(rx_chn->irq);
+
+	return num_rx;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


