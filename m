Return-Path: <netdev+bounces-114227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE49419BA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6AB2AC7D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0E189502;
	Tue, 30 Jul 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLQVEi1E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE91A619C
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356621; cv=none; b=vCHpxmDOC5M56JWhgSCsZavQOJVxYfhqSNpbo4lZBbIyW21XIQk4J6FNjeiNn/S5opbxd8rFidOXrKbZBg67O+6w7XMX7j//asVfHuplIGX7/090LUxAOFTn27ze2x4IgRRVQE2bF5ppKCIMcQ/xezo6U0KNLTbuEYNA690BMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356621; c=relaxed/simple;
	bh=S+hd0QEypXzvenTaxTAONOLIjLtSz5FwVzamPp8KRP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPCqnzGrqObJ8FnCh/weRD2jMD7y8Ls5aSSuQUj6O5m/PC34N9hAqeyZfe31JMwsy/ecEX2Etlh3/A3Tjcl76XIYGUEs7I1BKxOIHFMW9xXxjKPAavH+axJGMhz5zMQKTb0CwtgwDeqYz7ELJM4BYTAF5Fu3dAFhC3SBRpEN6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLQVEi1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DB9C4AF0F;
	Tue, 30 Jul 2024 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356621;
	bh=S+hd0QEypXzvenTaxTAONOLIjLtSz5FwVzamPp8KRP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLQVEi1E4QOV/CAupduKdQBVtLP1RHWE0nsj54gTdLsycWnXEa7WXvrcL0kNmMvRB
	 rGUkmspZqvlyYTgQqmoMAH9/J/85EbBlh2cna293KYTE8LmkufzD6A0KTx/Xdtp2CA
	 mZbk6icdGC3SuhmjyW9/0qZHpHcgXKW1EJ0zK/ijgQKlw6V6YbxdKV16YvC4oAx2GO
	 HYUIb4uDBsyfu4acSpzdMsy5epunVQmkRf0BKNMF4xOJitrjyEkopsNWgsD1A4niSa
	 YHbEXn3qvTO9UlUT6dMAWiYloTWuH6RDUEK/WVlSI6+Pt4RLMRafwAZ/chPK3SpLhh
	 VDEio0w0FWgNA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH net-next 9/9] net: airoha: Link the gdm port to the selected qdma controller
Date: Tue, 30 Jul 2024 18:22:48 +0200
Message-ID: <f41009fd2cd6f4230fc4c689c617afaac06ff41f.1722356015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link the running gdm port to the qdma controller used to connect with
the CPU. Moreover, load all QDMA controllers available on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 37 +++++++++++-----------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 7a2acb550165..358e47280c65 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -18,7 +18,7 @@
 #include <uapi/linux/ppp_defs.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	1
-#define AIROHA_MAX_NUM_QDMA		1
+#define AIROHA_MAX_NUM_QDMA		2
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			2000
@@ -805,8 +805,8 @@ struct airoha_qdma {
 };
 
 struct airoha_gdm_port {
+	struct airoha_qdma *qdma;
 	struct net_device *dev;
-	struct airoha_eth *eth;
 	int id;
 
 	struct airoha_hw_stats stats;
@@ -2141,7 +2141,7 @@ static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 
 static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 {
-	struct airoha_eth *eth = port->eth;
+	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, i = 0;
 
 	spin_lock(&port->stats.lock);
@@ -2286,22 +2286,22 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 static int airoha_dev_open(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->eth;
+	struct airoha_qdma *qdma = port->qdma;
 	int err;
 
 	netif_tx_start_all_queues(dev);
-	err = airoha_set_gdm_ports(eth, true);
+	err = airoha_set_gdm_ports(qdma->eth, true);
 	if (err)
 		return err;
 
 	if (netdev_uses_dsa(dev))
-		airoha_fe_set(eth, REG_GDM_INGRESS_CFG(port->id),
+		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 			      GDM_STAG_EN_MASK);
 	else
-		airoha_fe_clear(eth, REG_GDM_INGRESS_CFG(port->id),
+		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
-	airoha_qdma_set(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
@@ -2311,15 +2311,15 @@ static int airoha_dev_open(struct net_device *dev)
 static int airoha_dev_stop(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->eth;
+	struct airoha_qdma *qdma = port->qdma;
 	int err;
 
 	netif_tx_disable(dev);
-	err = airoha_set_gdm_ports(eth, false);
+	err = airoha_set_gdm_ports(qdma->eth, false);
 	if (err)
 		return err;
 
-	airoha_qdma_clear(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
 			  GLOBAL_CFG_RX_DMA_EN_MASK);
 
@@ -2335,7 +2335,7 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port->eth, dev->dev_addr);
+	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
 
 	return 0;
 }
@@ -2344,7 +2344,7 @@ static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 
-	airoha_set_macaddr(port->eth, dev->dev_addr);
+	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
 
 	return 0;
 }
@@ -2378,10 +2378,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	u32 msg0 = 0, msg1, len = skb_headlen(skb);
 	int i, qid = skb_get_queue_mapping(skb);
-	struct airoha_eth *eth = port->eth;
+	struct airoha_qdma *qdma = port->qdma;
 	u32 nr_frags = 1 + sinfo->nr_frags;
 	struct netdev_queue *txq;
-	struct airoha_qdma *qdma;
 	struct airoha_queue *q;
 	void *data = skb->data;
 	u16 index;
@@ -2409,7 +2408,6 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
-	qdma = &eth->qdma[0];
 	q = &qdma->q_tx[qid];
 	if (WARN_ON_ONCE(!q->ndesc))
 		goto error;
@@ -2492,7 +2490,7 @@ static void airoha_ethtool_get_drvinfo(struct net_device *dev,
 				       struct ethtool_drvinfo *info)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->eth;
+	struct airoha_eth *eth = port->qdma->eth;
 
 	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
@@ -2573,6 +2571,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
+	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	int err, index;
 	u32 id;
@@ -2602,6 +2601,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 		return -ENOMEM;
 	}
 
+	qdma = &eth->qdma[index % AIROHA_MAX_NUM_QDMA];
 	dev->netdev_ops = &airoha_netdev_ops;
 	dev->ethtool_ops = &airoha_ethtool_ops;
 	dev->max_mtu = AIROHA_MAX_MTU;
@@ -2611,6 +2611,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 			   NETIF_F_SG | NETIF_F_TSO;
 	dev->features |= dev->hw_features;
 	dev->dev.of_node = np;
+	dev->irq = qdma->irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
 	err = of_get_ethdev_address(np, dev);
@@ -2626,8 +2627,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	port = netdev_priv(dev);
 	u64_stats_init(&port->stats.syncp);
 	spin_lock_init(&port->stats.lock);
+	port->qdma = qdma;
 	port->dev = dev;
-	port->eth = eth;
 	port->id = id;
 	eth->ports[index] = port;
 
-- 
2.45.2


