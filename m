Return-Path: <netdev+bounces-275561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KjEICdCM02n1iwcAu9opvQ
	(envelope-from <netdev+bounces-275561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:37:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DCA3A2DC4
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E5B303309D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97132AADE;
	Mon,  6 Apr 2026 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvvGzHVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8243242D8;
	Mon,  6 Apr 2026 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471707; cv=none; b=aJOc1zLNUL9ie7BAwYOyOyLaGyZgCcPMqD1XMb8T+REY2hfXouvIRI6v1g6S1OmlWirXUwGi5WQuQG+fscmjvfLKMHtLtaAXd+lPQosrfUHHj8sJ/x2obvMReVAFe/sN1G7AZLT/P9TDy0lpuO/xvWq2XzzeYedJHhl5laKRKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471707; c=relaxed/simple;
	bh=pKWLxQu8uEi5B33fKbYi1pbpk8PczMyJsB4hQ8Hf8Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLuxIBQc4bIkbaLtW9drsOQxLNo8DuEuyp8AbN2i2TJhU2cwQH8CejQV4heEpBxDTQb3YuoOJF+6alfVJEhO8p3GXahf36GKUsis/2r7HdQqCDZC6Ob6cV53pKEH7kv3jgX9SpJWLLrC5zwYtHnG/1VyCPxiBWiahW71Qy/1Sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvvGzHVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6303BC2BC9E;
	Mon,  6 Apr 2026 10:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471706;
	bh=pKWLxQu8uEi5B33fKbYi1pbpk8PczMyJsB4hQ8Hf8Y4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvvGzHVlPtHMisr3jvVttoUhFOUxunZpalBKjukXWzuOz02kvStiw/PP8E/CiH/J9
	 gOxAlZVCHrh4Tajrw1et6hs9rq8bhR81S6YNmXiwCXRZZODOcWLmkZlXFvCnJ+Ak1M
	 zGRLxWrW5koRu4Kj/4xC30FuKJswPHt3j+POhNPKNdB2E4J6K8kxKFcLFVGCfnGubV
	 Ny4KqdPfPKdgnv8yDWu+QKyk+66vusVMtNyDdXoqRI+/IJfhnXUctwoE99RuGtooIN
	 YPeCdT0m9at1nYS47wHDY6wD/lhjnsPoyA38O1KnFPCWoiVSCOfCkIIdFgRhpK1r1z
	 uFa0UujVb/ZKQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:11 +0200
Subject: [PATCH net-next v3 06/12] net: airoha: Introduce airoha_gdm_dev
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-6-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275561-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95DCA3A2DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
As a result multiple net_devices can connect to the same GDM{3,4} port
and there is a theoretical "1:n" relation between GDM port and
net_devices.
Introduce airoha_gdm_dev struct to collect net_device related info (e.g.
net_device and external phy pointer). Please note this is just a
preliminary patch and we are still supporting a single net_device for
each GDM port. Subsequent patches will add support for multiple net_devices
connected to the same GDM port.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 268 +++++++++++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h |  13 +-
 drivers/net/ethernet/airoha/airoha_ppe.c |  17 +-
 3 files changed, 180 insertions(+), 118 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d67d844b788b..c2fc4967c340 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -617,6 +617,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct page *page = virt_to_head_page(e->buf);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
 		struct airoha_gdm_port *port;
+		struct net_device *netdev;
 		int data_len, len, p;
 
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
@@ -639,6 +640,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			goto free_frag;
 
 		port = eth->ports[p];
+		netdev = port->dev->dev;
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf, q->buf_size);
 			if (!q->skb)
@@ -646,8 +648,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
-			q->skb->dev = port->dev;
-			q->skb->protocol = eth_type_trans(q->skb, port->dev);
+			q->skb->dev = netdev;
+			q->skb->protocol = eth_type_trans(q->skb, netdev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
@@ -665,7 +667,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
 			continue;
 
-		if (netdev_uses_dsa(port->dev)) {
+		if (netdev_uses_dsa(netdev)) {
 			/* PPE module requires untagged packets to work
 			 * properly and it provides DSA port index via the
 			 * DMA descriptor. Report DSA tag to the DSA stack
@@ -1639,19 +1641,20 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 	spin_unlock(&port->stats.lock);
 }
 
-static int airoha_dev_open(struct net_device *dev)
+static int airoha_dev_open(struct net_device *netdev)
 {
-	int err, len = ETH_HLEN + dev->mtu + ETH_FCS_LEN;
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = port->qdma;
 	u32 pse_port = FE_PSE_PORT_PPE1;
 
-	netif_tx_start_all_queues(dev);
+	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(port, true);
 	if (err)
 		return err;
 
-	if (netdev_uses_dsa(dev))
+	if (netdev_uses_dsa(netdev))
 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 			      GDM_STAG_EN_MASK);
 	else
@@ -1679,19 +1682,20 @@ static int airoha_dev_open(struct net_device *dev)
 	return 0;
 }
 
-static int airoha_dev_stop(struct net_device *dev)
+static int airoha_dev_stop(struct net_device *netdev)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = port->qdma;
 	int i, err;
 
-	netif_tx_disable(dev);
+	netif_tx_disable(netdev);
 	err = airoha_set_vip_for_gdm_port(port, false);
 	if (err)
 		return err;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
-		netdev_tx_reset_subqueue(dev, i);
+		netdev_tx_reset_subqueue(netdev, i);
 
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    FE_PSE_PORT_DROP);
@@ -1712,16 +1716,17 @@ static int airoha_dev_stop(struct net_device *dev)
 	return 0;
 }
 
-static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
+static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int err;
 
-	err = eth_mac_addr(dev, p);
+	err = eth_mac_addr(netdev, p);
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port, dev->dev_addr);
+	airoha_set_macaddr(port, netdev->dev_addr);
 
 	return 0;
 }
@@ -1787,16 +1792,17 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	return 0;
 }
 
-static int airoha_dev_init(struct net_device *dev)
+static int airoha_dev_init(struct net_device *netdev)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->eth;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
 	port->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
-	port->dev->irq = port->qdma->irq_banks[0].irq;
-	airoha_set_macaddr(port, dev->dev_addr);
+	dev->dev->irq = port->qdma->irq_banks[0].irq;
+	airoha_set_macaddr(port, netdev->dev_addr);
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -1821,10 +1827,11 @@ static int airoha_dev_init(struct net_device *dev)
 	return 0;
 }
 
-static void airoha_dev_get_stats64(struct net_device *dev,
+static void airoha_dev_get_stats64(struct net_device *netdev,
 				   struct rtnl_link_stats64 *storage)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
 	airoha_update_hw_stats(port);
@@ -1843,36 +1850,39 @@ static void airoha_dev_get_stats64(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
-static int airoha_dev_change_mtu(struct net_device *dev, int mtu)
+static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
 
 	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
 		      GDM_LONG_LEN_MASK,
 		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
-	WRITE_ONCE(dev->mtu, mtu);
+	WRITE_ONCE(netdev->mtu, mtu);
 
 	return 0;
 }
 
-static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
+static u16 airoha_dev_select_queue(struct net_device *netdev,
+				   struct sk_buff *skb,
 				   struct net_device *sb_dev)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int queue, channel;
 
 	/* For dsa device select QoS channel according to the dsa user port
 	 * index, rely on port id otherwise. Select QoS queue based on the
 	 * skb priority.
 	 */
-	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
+	channel = netdev_uses_dsa(netdev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
 	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
 
-	return queue < dev->num_tx_queues ? queue : 0;
+	return queue < netdev->num_tx_queues ? queue : 0;
 }
 
 static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
@@ -1936,9 +1946,10 @@ int airoha_get_fe_port(struct airoha_gdm_port *port)
 }
 
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
-				   struct net_device *dev)
+				   struct net_device *netdev)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = port->qdma;
 	u32 nr_frags, tag, msg0, msg1, len;
 	struct airoha_queue_entry *e;
@@ -1951,7 +1962,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	u8 fport;
 
 	qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx);
-	tag = airoha_get_dsa_tag(skb, dev);
+	tag = airoha_get_dsa_tag(skb, netdev);
 
 	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
 			  qid / AIROHA_NUM_QOS_QUEUES) |
@@ -1987,7 +1998,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	spin_lock_bh(&q->lock);
 
-	txq = netdev_get_tx_queue(dev, qid);
+	txq = netdev_get_tx_queue(netdev, qid);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
 	if (q->queued + nr_frags >= q->ndesc) {
@@ -2010,9 +2021,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		dma_addr_t addr;
 		u32 val;
 
-		addr = dma_map_single(dev->dev.parent, data, len,
+		addr = dma_map_single(netdev->dev.parent, data, len,
 				      DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
+		if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
 			goto error_unmap;
 
 		list_move_tail(&e->list, &tx_list);
@@ -2059,8 +2070,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	while (!list_empty(&tx_list)) {
 		e = list_first_entry(&tx_list, struct airoha_queue_entry,
 				     list);
-		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
-				 DMA_TO_DEVICE);
+		dma_unmap_single(netdev->dev.parent, e->dma_addr,
+				 e->dma_len, DMA_TO_DEVICE);
 		e->dma_addr = 0;
 		list_move_tail(&e->list, &q->tx_list);
 	}
@@ -2068,25 +2079,27 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	spin_unlock_bh(&q->lock);
 error:
 	dev_kfree_skb_any(skb);
-	dev->stats.tx_dropped++;
+	netdev->stats.tx_dropped++;
 
 	return NETDEV_TX_OK;
 }
 
-static void airoha_ethtool_get_drvinfo(struct net_device *dev,
+static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
 				       struct ethtool_drvinfo *info)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = port->qdma->eth;
 
 	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
 }
 
-static void airoha_ethtool_get_mac_stats(struct net_device *dev,
+static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
 					 struct ethtool_eth_mac_stats *stats)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
 	airoha_update_hw_stats(port);
@@ -2114,11 +2127,12 @@ static const struct ethtool_rmon_hist_range airoha_ethtool_rmon_ranges[] = {
 };
 
 static void
-airoha_ethtool_get_rmon_stats(struct net_device *dev,
+airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 			      struct ethtool_rmon_stats *stats,
 			      const struct ethtool_rmon_hist_range **ranges)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_hw_stats *hw_stats = &port->stats;
 	unsigned int start;
 
@@ -2147,7 +2161,8 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 int channel, enum tx_sched_mode mode,
 					 const u16 *weights, u8 n_weights)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int i;
 
 	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
@@ -2235,7 +2250,8 @@ static int airoha_qdma_set_tx_ets_sched(struct net_device *dev, int channel,
 static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	u64 cpu_tx_packets = airoha_qdma_rr(port->qdma,
 					    REG_CNTR_VAL(channel << 1));
@@ -2501,7 +2517,8 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 					 int channel, u32 rate,
 					 u32 bucket_size)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int i, err;
 
 	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
@@ -2527,7 +2544,8 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
 	int err, num_tx_queues = netdev->real_num_tx_queues;
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
@@ -2638,11 +2656,12 @@ static int airoha_tc_matchall_act_validate(struct tc_cls_matchall_offload *f)
 	return 0;
 }
 
-static int airoha_dev_tc_matchall(struct net_device *dev,
+static int airoha_dev_tc_matchall(struct net_device *netdev,
 				  struct tc_cls_matchall_offload *f)
 {
 	enum trtcm_unit_type unit_type = TRTCM_BYTE_UNIT;
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	u32 rate = 0, bucket_size = 0;
 
 	switch (f->command) {
@@ -2677,18 +2696,19 @@ static int airoha_dev_tc_matchall(struct net_device *dev,
 static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
 					void *type_data, void *cb_priv)
 {
-	struct net_device *dev = cb_priv;
-	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct net_device *netdev = cb_priv;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = port->qdma->eth;
 
-	if (!tc_can_offload(dev))
+	if (!tc_can_offload(netdev))
 		return -EOPNOTSUPP;
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
 		return airoha_ppe_setup_tc_block_cb(&eth->ppe->dev, type_data);
 	case TC_SETUP_CLSMATCHALL:
-		return airoha_dev_tc_matchall(dev, type_data);
+		return airoha_dev_tc_matchall(netdev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2737,7 +2757,8 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 
 static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
 	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
@@ -2748,7 +2769,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 					   struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
@@ -2762,7 +2784,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int q;
 
 	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
@@ -2775,7 +2798,8 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 					    struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
@@ -2811,8 +2835,8 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 	return 0;
 }
 
-static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
-			       void *type_data)
+static int airoha_dev_tc_setup(struct net_device *dev,
+			       enum tc_setup_type type, void *type_data)
 {
 	switch (type) {
 	case TC_SETUP_QDISC_ETS:
@@ -2878,25 +2902,81 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
 	}
 }
 
-bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
-			      struct airoha_gdm_port *port)
+bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
+			     struct airoha_gdm_dev *dev)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
-		if (eth->ports[i] == port)
+		struct airoha_gdm_port *port = eth->ports[i];
+
+		if (!port)
+			continue;
+
+		if (port->dev == dev)
 			return true;
 	}
 
 	return false;
 }
 
+static int airoha_alloc_gdm_device(struct airoha_eth *eth,
+				   struct airoha_gdm_port *port,
+				   struct device_node *np)
+{
+	struct airoha_gdm_dev *dev;
+	struct net_device *netdev;
+	int err;
+
+	netdev = devm_alloc_etherdev_mqs(eth->dev, sizeof(*dev),
+					 AIROHA_NUM_NETDEV_TX_RINGS,
+					 AIROHA_NUM_RX_RING);
+	if (!netdev) {
+		dev_err(eth->dev, "alloc_etherdev failed\n");
+		return -ENOMEM;
+	}
+
+	netdev->netdev_ops = &airoha_netdev_ops;
+	netdev->ethtool_ops = &airoha_ethtool_ops;
+	netdev->max_mtu = AIROHA_MAX_MTU;
+	netdev->watchdog_timeo = 5 * HZ;
+	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6 |
+			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
+			      NETIF_F_HW_TC;
+	netdev->features |= netdev->hw_features;
+	netdev->vlan_features = netdev->hw_features;
+	netdev->dev.of_node = np;
+	SET_NETDEV_DEV(netdev, eth->dev);
+
+	/* reserve hw queues for HTB offloading */
+	err = netif_set_real_num_tx_queues(netdev, AIROHA_NUM_TX_RING);
+	if (err)
+		return err;
+
+	err = of_get_ethdev_address(np, netdev);
+	if (err) {
+		if (err == -EPROBE_DEFER)
+			return err;
+
+		eth_hw_addr_random(netdev);
+		dev_info(eth->dev, "generated random MAC address %pM\n",
+			 netdev->dev_addr);
+	}
+
+	dev = netdev_priv(netdev);
+	dev->dev = netdev;
+	dev->port = port;
+	port->dev = dev;
+	dev->eth = eth;
+
+	return 0;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np)
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
-	struct net_device *dev;
 	int err, p;
 	u32 id;
 
@@ -2918,51 +2998,20 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 		return -EINVAL;
 	}
 
-	dev = devm_alloc_etherdev_mqs(eth->dev, sizeof(*port),
-				      AIROHA_NUM_NETDEV_TX_RINGS,
-				      AIROHA_NUM_RX_RING);
-	if (!dev) {
-		dev_err(eth->dev, "alloc_etherdev failed\n");
+	port = devm_kzalloc(eth->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
 		return -ENOMEM;
-	}
-
-	dev->netdev_ops = &airoha_netdev_ops;
-	dev->ethtool_ops = &airoha_ethtool_ops;
-	dev->max_mtu = AIROHA_MAX_MTU;
-	dev->watchdog_timeo = 5 * HZ;
-	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
-			   NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |
-			   NETIF_F_SG | NETIF_F_TSO |
-			   NETIF_F_HW_TC;
-	dev->features |= dev->hw_features;
-	dev->vlan_features = dev->hw_features;
-	dev->dev.of_node = np;
-	SET_NETDEV_DEV(dev, eth->dev);
-
-	/* reserve hw queues for HTB offloading */
-	err = netif_set_real_num_tx_queues(dev, AIROHA_NUM_TX_RING);
-	if (err)
-		return err;
-
-	err = of_get_ethdev_address(np, dev);
-	if (err) {
-		if (err == -EPROBE_DEFER)
-			return err;
-
-		eth_hw_addr_random(dev);
-		dev_info(eth->dev, "generated random MAC address %pM\n",
-			 dev->dev_addr);
-	}
 
-	port = netdev_priv(dev);
 	u64_stats_init(&port->stats.syncp);
 	spin_lock_init(&port->stats.lock);
-	port->eth = eth;
-	port->dev = dev;
 	port->id = id;
 	eth->ports[p] = port;
 
-	return airoha_metadata_dst_alloc(port);
+	err = airoha_metadata_dst_alloc(port);
+	if (err)
+		return err;
+
+	return airoha_alloc_gdm_device(eth, port, np);
 }
 
 static int airoha_register_gdm_devices(struct airoha_eth *eth)
@@ -2976,7 +3025,7 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 		if (!port)
 			continue;
 
-		err = register_netdev(port->dev);
+		err = register_netdev(port->dev->dev);
 		if (err)
 			return err;
 	}
@@ -3085,12 +3134,14 @@ static int airoha_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
+		struct airoha_gdm_dev *dev;
 
 		if (!port)
 			continue;
 
-		if (port->dev->reg_state == NETREG_REGISTERED)
-			unregister_netdev(port->dev);
+		dev = port->dev;
+		if (dev && dev->dev->reg_state == NETREG_REGISTERED)
+			unregister_netdev(dev->dev);
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3111,11 +3162,14 @@ static void airoha_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
+		struct airoha_gdm_dev *dev;
 
 		if (!port)
 			continue;
 
-		unregister_netdev(port->dev);
+		dev = port->dev;
+		if (dev)
+			unregister_netdev(dev->dev);
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 3088c24db26a..54cb9984ff4b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -532,10 +532,15 @@ struct airoha_qdma {
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
 };
 
+struct airoha_gdm_dev {
+	struct airoha_gdm_port *port;
+	struct net_device *dev;
+	struct airoha_eth *eth;
+};
+
 struct airoha_gdm_port {
 	struct airoha_qdma *qdma;
-	struct airoha_eth *eth;
-	struct net_device *dev;
+	struct airoha_gdm_dev *dev;
 	int id;
 
 	struct airoha_hw_stats stats;
@@ -648,8 +653,8 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 }
 
 int airoha_get_fe_port(struct airoha_gdm_port *port);
-bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
-			      struct airoha_gdm_port *port);
+bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
+			     struct airoha_gdm_dev *dev);
 
 void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
 			     u8 fport);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 2e6391f9f24b..65aadb29330e 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -291,12 +291,12 @@ static void airoha_ppe_foe_set_bridge_addrs(struct airoha_foe_bridge *br,
 
 static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 					struct airoha_foe_entry *hwe,
-					struct net_device *dev, int type,
+					struct net_device *netdev, int type,
 					struct airoha_flow_data *data,
 					int l4proto)
 {
 	u32 qdata = FIELD_PREP(AIROHA_FOE_SHAPER_ID, 0x7f), ports_pad, val;
-	int wlan_etype = -EINVAL, dsa_port = airoha_get_dsa_port(&dev);
+	int wlan_etype = -EINVAL, dsa_port = airoha_get_dsa_port(&netdev);
 	struct airoha_foe_mac_info_common *l2;
 	u8 smac_id = 0xf;
 
@@ -312,10 +312,11 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 	hwe->ib1 = val;
 
 	val = FIELD_PREP(AIROHA_FOE_IB2_PORT_AG, 0x1f);
-	if (dev) {
+	if (netdev) {
 		struct airoha_wdma_info info = {};
 
-		if (!airoha_ppe_get_wdma_info(dev, data->eth.h_dest, &info)) {
+		if (!airoha_ppe_get_wdma_info(netdev, data->eth.h_dest,
+					      &info)) {
 			val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ, info.idx) |
 			       FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT,
 					  FE_PSE_PORT_CDM4);
@@ -325,12 +326,14 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 				     FIELD_PREP(AIROHA_FOE_MAC_WDMA_WCID,
 						info.wcid);
 		} else {
-			struct airoha_gdm_port *port = netdev_priv(dev);
+			struct airoha_gdm_dev *dev = netdev_priv(netdev);
+			struct airoha_gdm_port *port;
 			u8 pse_port;
 
-			if (!airoha_is_valid_gdm_port(eth, port))
+			if (!airoha_is_valid_gdm_dev(eth, dev))
 				return -EINVAL;
 
+			port = dev->port;
 			if (dsa_port >= 0 || eth->ports[1])
 				pse_port = port->id == 4 ? FE_PSE_PORT_GDM4
 							 : port->id;
@@ -1430,7 +1433,7 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
-	struct net_device *dev = port->dev;
+	struct net_device *dev = port->dev->dev;
 	const u8 *addr = dev->dev_addr;
 	u32 val;
 

-- 
2.53.0


