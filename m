Return-Path: <netdev+bounces-115015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F4944E2C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BFE1C25B0B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48961A57C9;
	Thu,  1 Aug 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaYw0VBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05941A4885
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522964; cv=none; b=Y+7h4AQsBd9Efum2ueX4YDzGPRBqg2F9xcj4R+qXRYwRPOYjF6YlOQfBfXk01WNH6qO8UMHz4Y0WTa8rnnkVM75frm+w7WhKzk6K/00sKEH/dBXhIZ1wIHc8k09nl+XTBAZIsCbB/UBCjTJPRuStHld3p9CwcaBWtV9Hfma50ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522964; c=relaxed/simple;
	bh=XyiRfGVfjXMgzy6c5ALdFgv6uBYj6iz2le63R/kYzAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV8gNf/aUC7Aqy4C7s4xblVMwBvLyBwHsvkquqVhi0PM0zfvL4hfniw36W8ACv7lrwrYnwIcDhqsVG70qqstRg3YPwBWQBMeNa68WzsdV4IK+G/Rr/dfp0YKjSWfe/Ev3rDivJKjJPb1R4a8FKneygGeVptGEWt3YV489yXiqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaYw0VBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF78C4AF09;
	Thu,  1 Aug 2024 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522964;
	bh=XyiRfGVfjXMgzy6c5ALdFgv6uBYj6iz2le63R/kYzAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaYw0VBL7OpGnIdm+g86mjxrjpC6FQw52HeifXcgHGroX9DXSiE2OZ9AcOIinHiwf
	 9YnMnHlJq/gke101dPiUpMiXLhKpfMZG/D8h1V7JSOtjivci/CpoACSZiRtI8Ln4pc
	 4uRbtJqlm0NSaU1k8BKdXKbwGO4AQN1ToweGhs05IFSTi0tQGqHdq6DMiXBAR/bf85
	 dA2NIjrY2cW0ZCyWht4e/+jGjv/p0H/M797L+uIm69oNOgNKe4K0mF9dU0oz+ss12K
	 fNlUiuMjOMB55ungXkGfo/aeLF8kiclh29mqDLBJfhvnxcPrJh1S2JLZ3m7cQv+U9K
	 P5kTlaSuLK4cg==
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
Subject: [PATCH v2 net-next 8/8] net: airoha: Link the gdm port to the selected qdma controller
Date: Thu,  1 Aug 2024 16:35:10 +0200
Message-ID: <95b515df34ba4727f7ae5b14a1d0462cceec84ff.1722522582.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722522582.git.lorenzo@kernel.org>
References: <cover.1722522582.git.lorenzo@kernel.org>
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
index 13c72ab6d87a..db4267225fa4 100644
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
@@ -2138,7 +2138,7 @@ static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 
 static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 {
-	struct airoha_eth *eth = port->eth;
+	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, i = 0;
 
 	spin_lock(&port->stats.lock);
@@ -2283,22 +2283,22 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
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
 
@@ -2308,15 +2308,15 @@ static int airoha_dev_open(struct net_device *dev)
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
 
@@ -2332,7 +2332,7 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port->eth, dev->dev_addr);
+	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
 
 	return 0;
 }
@@ -2341,7 +2341,7 @@ static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 
-	airoha_set_macaddr(port->eth, dev->dev_addr);
+	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
 
 	return 0;
 }
@@ -2375,10 +2375,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
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
@@ -2406,7 +2405,6 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
-	qdma = &eth->qdma[0];
 	q = &qdma->q_tx[qid];
 	if (WARN_ON_ONCE(!q->ndesc))
 		goto error;
@@ -2489,7 +2487,7 @@ static void airoha_ethtool_get_drvinfo(struct net_device *dev,
 				       struct ethtool_drvinfo *info)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->eth;
+	struct airoha_eth *eth = port->qdma->eth;
 
 	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
@@ -2570,6 +2568,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
+	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	int err, index;
 	u32 id;
@@ -2599,6 +2598,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 		return -ENOMEM;
 	}
 
+	qdma = &eth->qdma[index % AIROHA_MAX_NUM_QDMA];
 	dev->netdev_ops = &airoha_netdev_ops;
 	dev->ethtool_ops = &airoha_ethtool_ops;
 	dev->max_mtu = AIROHA_MAX_MTU;
@@ -2608,6 +2608,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 			   NETIF_F_SG | NETIF_F_TSO;
 	dev->features |= dev->hw_features;
 	dev->dev.of_node = np;
+	dev->irq = qdma->irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
 	err = of_get_ethdev_address(np, dev);
@@ -2623,8 +2624,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
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


