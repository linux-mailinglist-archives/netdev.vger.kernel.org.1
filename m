Return-Path: <netdev+bounces-273916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FJvHYrCzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A63757F0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E1683038E01
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51C3659EC;
	Wed,  1 Apr 2026 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBPJ2kHf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2136494B;
	Wed,  1 Apr 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026818; cv=none; b=N0zIDG9GgYB72nIlVDHIEaWaqVibsTnqhJRQDqfJMzamxKNaUVnPnt/B4AZuuwepJVxm/i7hdV0r0ko3hWsQGRe9zP4bMqNk0AB/k9aOJLawPtnWEG+Zi2XPSdBHbf9H45mOWsCIMVEZSB7S1j9sEGOglqJ2V0sMY0r405U8Tiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026818; c=relaxed/simple;
	bh=QZQvOkQ/1iSf93EwZQ5PjKCfU5ZTuGTp+gDrXTmaMVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1Gf+Xu/ZuJ7rpSelIcGLYLJgeBgOnTnytkp9xzgUGk2yxN6b7TVNoi59GXYZkg2jMLusdOgx1w0pq58Gds4EubcNyUi4JPuwu7d1to3mNnrxX8pJ8CGxHpvhaplWkxmWeavhwSFpiyN1w8ph6cYAePNW43outhLvZsdqhIj7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBPJ2kHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACFDC2BCB5;
	Wed,  1 Apr 2026 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026817;
	bh=QZQvOkQ/1iSf93EwZQ5PjKCfU5ZTuGTp+gDrXTmaMVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CBPJ2kHftQZOozisROQDQlXh5DyR7hE9tiQ6eZf/S+3VU8Avw2oXPAHVKPiIqUglb
	 UmuUzYWswtlMok/CkpSauXPsdNlsgdETyvyR66u+xg9mktk712R5AqKVu110pCxn1a
	 sEgKMLXk+VyiFdnKM809BagXqj73nG1lmG03cVo62D771r6JHnLENjqLT9kIUGwVYn
	 qjzPB1KLOh3mYjEA7TgLpzMSiPWzeUgC9vB19fUsfry/EBn5T9pGWC3EMUu3ZSgyn5
	 iPvn3MN02qEStvs8m6byxtkfkfz58+xvysgdTqiWhK8IRNOeB89yET5giADyVa6Mww
	 7vq5z8wiyL3gQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Apr 2026 08:59:24 +0200
Subject: [PATCH net-next v2 06/11] net: airoha: Introduce airoha_gdm_dev
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-airoha-eth-multi-serdes-v2-6-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
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
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 187A63757F0
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
index 268f4e34f38d2df128f0be52ae00fec07e46b1bf..99f19edb993b8143973f2ed91c41dfa975eab6ef 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -616,6 +616,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct page *page = virt_to_head_page(e->buf);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
 		struct airoha_gdm_port *port;
+		struct net_device *netdev;
 		int data_len, len, p;
 
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
@@ -638,6 +639,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			goto free_frag;
 
 		port = eth->ports[p];
+		netdev = port->dev->dev;
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf, q->buf_size);
 			if (!q->skb)
@@ -645,8 +647,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
-			q->skb->dev = port->dev;
-			q->skb->protocol = eth_type_trans(q->skb, port->dev);
+			q->skb->dev = netdev;
+			q->skb->protocol = eth_type_trans(q->skb, netdev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
@@ -664,7 +666,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
 			continue;
 
-		if (netdev_uses_dsa(port->dev)) {
+		if (netdev_uses_dsa(netdev)) {
 			/* PPE module requires untagged packets to work
 			 * properly and it provides DSA port index via the
 			 * DMA descriptor. Report DSA tag to the DSA stack
@@ -1622,19 +1624,20 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
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
@@ -1662,19 +1665,20 @@ static int airoha_dev_open(struct net_device *dev)
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
@@ -1695,16 +1699,17 @@ static int airoha_dev_stop(struct net_device *dev)
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
@@ -1770,16 +1775,17 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
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
@@ -1804,10 +1810,11 @@ static int airoha_dev_init(struct net_device *dev)
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
@@ -1826,36 +1833,39 @@ static void airoha_dev_get_stats64(struct net_device *dev,
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
@@ -1919,9 +1929,10 @@ int airoha_get_fe_port(struct airoha_gdm_port *port)
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
@@ -1934,7 +1945,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	u8 fport;
 
 	qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx);
-	tag = airoha_get_dsa_tag(skb, dev);
+	tag = airoha_get_dsa_tag(skb, netdev);
 
 	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
 			  qid / AIROHA_NUM_QOS_QUEUES) |
@@ -1970,7 +1981,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	spin_lock_bh(&q->lock);
 
-	txq = netdev_get_tx_queue(dev, qid);
+	txq = netdev_get_tx_queue(netdev, qid);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
 	if (q->queued + nr_frags >= q->ndesc) {
@@ -1993,9 +2004,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		dma_addr_t addr;
 		u32 val;
 
-		addr = dma_map_single(dev->dev.parent, data, len,
+		addr = dma_map_single(netdev->dev.parent, data, len,
 				      DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
+		if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
 			goto error_unmap;
 
 		list_move_tail(&e->list, &tx_list);
@@ -2042,8 +2053,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
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
@@ -2051,25 +2062,27 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
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
@@ -2097,11 +2110,12 @@ static const struct ethtool_rmon_hist_range airoha_ethtool_rmon_ranges[] = {
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
 
@@ -2130,7 +2144,8 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 int channel, enum tx_sched_mode mode,
 					 const u16 *weights, u8 n_weights)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int i;
 
 	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
@@ -2218,7 +2233,8 @@ static int airoha_qdma_set_tx_ets_sched(struct net_device *dev, int channel,
 static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	u64 cpu_tx_packets = airoha_qdma_rr(port->qdma,
 					    REG_CNTR_VAL(channel << 1));
@@ -2484,7 +2500,8 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 					 int channel, u32 rate,
 					 u32 bucket_size)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int i, err;
 
 	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
@@ -2510,7 +2527,8 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
 	int err, num_tx_queues = netdev->real_num_tx_queues;
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
@@ -2621,11 +2639,12 @@ static int airoha_tc_matchall_act_validate(struct tc_cls_matchall_offload *f)
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
@@ -2660,18 +2679,19 @@ static int airoha_dev_tc_matchall(struct net_device *dev,
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
@@ -2720,7 +2740,8 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
 
 static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
 	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
@@ -2731,7 +2752,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 					   struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
@@ -2745,7 +2767,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
 
 static int airoha_tc_htb_destroy(struct net_device *netdev)
 {
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 	int q;
 
 	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
@@ -2758,7 +2781,8 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
 					    struct tc_htb_qopt_offload *opt)
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
-	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	if (!test_bit(channel, port->qos_sq_bmap)) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
@@ -2794,8 +2818,8 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
 	return 0;
 }
 
-static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
-			       void *type_data)
+static int airoha_dev_tc_setup(struct net_device *dev,
+			       enum tc_setup_type type, void *type_data)
 {
 	switch (type) {
 	case TC_SETUP_QDISC_ETS:
@@ -2861,25 +2885,81 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
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
 
@@ -2901,51 +2981,20 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
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
@@ -2959,7 +3008,7 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 		if (!port)
 			continue;
 
-		err = register_netdev(port->dev);
+		err = register_netdev(port->dev->dev);
 		if (err)
 			return err;
 	}
@@ -3066,12 +3115,14 @@ static int airoha_probe(struct platform_device *pdev)
 
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
@@ -3092,11 +3143,14 @@ static void airoha_remove(struct platform_device *pdev)
 
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
index f04b8d8cfc09f74f288c347d03e18b4f4f3aa893..0700d6b76e4685c3047d3604f843781af312c7b6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -531,10 +531,15 @@ struct airoha_qdma {
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
@@ -647,8 +652,8 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 }
 
 int airoha_get_fe_port(struct airoha_gdm_port *port);
-bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
-			      struct airoha_gdm_port *port);
+bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
+			     struct airoha_gdm_dev *dev);
 
 void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
 			     u8 fport);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 0f42247a2ef3d67b7dadb6201079ff2c2defbf0d..a8c1a5adce30f0af416c0660abad67ea6240513e 100644
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
@@ -1423,7 +1426,7 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
-	struct net_device *dev = port->dev;
+	struct net_device *dev = port->dev->dev;
 	const u8 *addr = dev->dev_addr;
 	u32 val;
 

-- 
2.53.0


