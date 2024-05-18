Return-Path: <netdev+bounces-97092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDA8C910C
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B3E1F211A4
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D64482DB;
	Sat, 18 May 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lEB4SdzD"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EF2BD18;
	Sat, 18 May 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036270; cv=none; b=ZjiA11eCxsfUACA7fYYflrzF4r6/ZvEKtG60cHl6ejFpkbkt9t34ECi+Q2tugKmibppME8FbpEl+DT0u0jUJPRXfy9RJTLgPfgjdy4MWxp4uqPz7Lp3PAazRhyL+P/kWF1j4rjXwLWNN0mdu0606k/Lg61VmepELB/ENC9foo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036270; c=relaxed/simple;
	bh=9SoVvIRSrJk77rcTUkgJ+es7gE0GmGp5ZO6Mg6yDizU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE7eI4SdkdLDMniEU/OtL/t3P0ORElKH49SXpuVS+lLLcIUZs6e24oWefJJzYqHkpq5n+hw5vQx4MGWWtLiMVJz3fBrRd+7KJqReWXD13al+eXzWDYwkr9E4fzDgitrK9cPI001257KnpYbBQ/P0xmKnSN13Jpt+GeEqbCm1Qac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lEB4SdzD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICi23w110141;
	Sat, 18 May 2024 07:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036242;
	bh=l8Tg5nTpOb8jjPX4ecgYTeUqBjWYnttismzv9xPhAh0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lEB4SdzDa9aamUcov4y/zj1F0x/X2/F6pZy/Q+Rsopc6PXlsfFf+LNOnybVveiaBe
	 qCs9egCZktnZTVnO71egclmdMdqYyn0yyXhCuXJ2ARGmNNt3LXG+9cWE9xD3V0ZIHe
	 dy7yU1uDdiatMTQ31qTFum3pOhOLInc1+RUBiWDk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICi2HK129758
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:02 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9Y041511;
	Sat, 18 May 2024 07:43:57 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 18/28] net: ethernet: ti: cpsw-proxy-client: implement and register ndo_start_xmit
Date: Sat, 18 May 2024 18:12:24 +0530
Message-ID: <20240518124234.2671651-19-s-vadapalli@ti.com>
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

Add the function "vport_ndo_xmit()" and register it as the driver's
.ndo_start_xmit callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 152 ++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 646eab90832c..7cbe1d4b5112 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1411,9 +1411,161 @@ static int vport_ndo_open(struct net_device *ndev)
 	return 0;
 }
 
+static netdev_tx_t vport_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct device *dev = proxy_priv->dev;
+	struct netdev_queue *netif_txq;
+	dma_addr_t desc_dma, buf_dma;
+	struct tx_dma_chan *tx_chn;
+	void **swdata;
+	int ret, i, q;
+	u32 pkt_len;
+	u32 *psdata;
+
+	/* padding enabled in hw */
+	pkt_len = skb_headlen(skb);
+
+	/* Get Queue / TX DMA Channel for the SKB */
+	q = skb_get_queue_mapping(skb);
+	tx_chn = &vport->tx_chans[q];
+	netif_txq = netdev_get_tx_queue(ndev, q);
+
+	/* Map the linear buffer */
+	buf_dma = dma_map_single(dev, skb->data, pkt_len,
+				 DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, buf_dma))) {
+		dev_err(dev, "Failed to map tx skb buffer\n");
+		ndev->stats.tx_errors++;
+		goto drop_free_skb;
+	}
+
+	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+	if (!first_desc) {
+		dev_dbg(dev, "Failed to allocate descriptor\n");
+		dma_unmap_single(dev, buf_dma, pkt_len, DMA_TO_DEVICE);
+		goto busy_stop_q;
+	}
+
+	cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
+			 PS_DATA_SIZE);
+	cppi5_desc_set_pktids(&first_desc->hdr, 0, 0x3FFF);
+	cppi5_hdesc_set_pkttype(first_desc, 0x7);
+	/* target port has to be 0 */
+	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, vport->port_type);
+
+	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
+	swdata = cppi5_hdesc_get_swdata(first_desc);
+	*(swdata) = skb;
+	psdata = cppi5_hdesc_get_psdata(first_desc);
+
+	/* HW csum offload if enabled */
+	psdata[2] = 0;
+	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		unsigned int cs_start, cs_offset;
+
+		cs_start = skb_transport_offset(skb);
+		cs_offset = cs_start + skb->csum_offset;
+		/* HW numerates bytes starting from 1 */
+		psdata[2] = ((cs_offset + 1) << 24) |
+			    ((cs_start + 1) << 16) | (skb->len - cs_start);
+		dev_dbg(dev, "%s tx psdata:%#x\n", __func__, psdata[2]);
+	}
+
+	if (!skb_is_nonlinear(skb))
+		goto done_tx;
+
+	dev_dbg(dev, "fragmented SKB\n");
+
+	/* Handle the case where skb is fragmented in pages */
+	cur_desc = first_desc;
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		u32 frag_size = skb_frag_size(frag);
+
+		next_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+		if (!next_desc) {
+			dev_err(dev, "Failed to allocate descriptor\n");
+			goto busy_free_descs;
+		}
+
+		buf_dma = skb_frag_dma_map(dev, frag, 0, frag_size,
+					   DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, buf_dma))) {
+			dev_err(dev, "Failed to map tx skb page\n");
+			k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
+			ndev->stats.tx_errors++;
+			goto drop_free_descs;
+		}
+
+		cppi5_hdesc_reset_hbdesc(next_desc);
+		cppi5_hdesc_attach_buf(next_desc,
+				       buf_dma, frag_size, buf_dma, frag_size);
+
+		desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool,
+						      next_desc);
+		cppi5_hdesc_link_hbdesc(cur_desc, desc_dma);
+
+		pkt_len += frag_size;
+		cur_desc = next_desc;
+	}
+	WARN_ON(pkt_len != skb->len);
+
+done_tx:
+	skb_tx_timestamp(skb);
+
+	/* report bql before sending packet */
+	dev_dbg(dev, "push 0 %d Bytes\n", pkt_len);
+
+	netdev_tx_sent_queue(netif_txq, pkt_len);
+
+	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
+	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
+	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chan, first_desc, desc_dma);
+	if (ret) {
+		dev_err(dev, "can't push desc %d\n", ret);
+		/* inform bql */
+		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
+		ndev->stats.tx_errors++;
+		goto drop_free_descs;
+	}
+
+	if (k3_cppi_desc_pool_avail(tx_chn->desc_pool) < MAX_SKB_FRAGS) {
+		netif_tx_stop_queue(netif_txq);
+		/* Barrier, so that stop_queue visible to other cpus */
+		smp_mb__after_atomic();
+		dev_dbg(dev, "netif_tx_stop_queue %d\n", q);
+
+		/* re-check for smp */
+		if (k3_cppi_desc_pool_avail(tx_chn->desc_pool) >=
+		    MAX_SKB_FRAGS) {
+			netif_tx_wake_queue(netif_txq);
+			dev_dbg(dev, "netif_tx_wake_queue %d\n", q);
+		}
+	}
+
+	return NETDEV_TX_OK;
+
+drop_free_descs:
+	vport_xmit_free(tx_chn, dev, first_desc);
+drop_free_skb:
+	ndev->stats.tx_dropped++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+
+busy_free_descs:
+	vport_xmit_free(tx_chn, dev, first_desc);
+busy_stop_q:
+	netif_tx_stop_queue(netif_txq);
+	return NETDEV_TX_BUSY;
+}
+
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_open		= vport_ndo_open,
 	.ndo_stop		= vport_ndo_stop,
+	.ndo_start_xmit		= vport_ndo_xmit,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
-- 
2.40.1


