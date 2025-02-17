Return-Path: <netdev+bounces-166982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B034A383CF
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A180173A0D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C6422258B;
	Mon, 17 Feb 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHIjGfBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990621C9E4;
	Mon, 17 Feb 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797323; cv=none; b=sGXZJiyZscsHTO2p7QIgicbi65uNE6pdAlwQmCKH/KJaOuz+eR1D2LBMXj59mT2XQvYItpxYaRT3c5niM5h4udsiJbRY4F9CakRsDiK/edldxBZ919ug/OU9eYQjKBetB/4QGgUJKpVSrQDC83njf6BggSjJBmPyIfrFLwWvhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797323; c=relaxed/simple;
	bh=6PWC818ZtuH6Oyc32LpcXRRNu0olUP6Lyo19SqxkH1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhAVF5yy7E3Rsv+tedSJOudDPdDgUtP7ppPcQbgZRfmJsABY4jutyu7NRRIk9BxukV5JbOGGh0s+PCHST0QXdcVSYRW4FiXX/TJj4v9T5mYZRUxclGCdnxprUzljyU+bNOyoQovJG6ji3ZTYPel4fhmI9ypm3z3/4o72qlRZnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHIjGfBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B330BC4CED1;
	Mon, 17 Feb 2025 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797323;
	bh=6PWC818ZtuH6Oyc32LpcXRRNu0olUP6Lyo19SqxkH1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MHIjGfBGtJzrFh296NMU8GAxrfucC+mcMOfvvabAQblfXUBxtFqbA9ma53yZetk1y
	 QQDCoLtkdBNyg082St3kywDLpGIxbg76vryt12veFSlbfN5alZe1Y6eKy/YEkwsIfi
	 KgaRd9jMx2bkWjtIGXqvgUV4eHQHWEe83StrbxDM7ZkkmtUdBOGiOulz/8rRjJkh21
	 RxVzPOvSupQ0ZPQDFTXmKhH4FsPUjZiIpMlEVdnPkcM6zJJoBo1J4sMnDgHyarKezk
	 PEQBSN45ao/yVfnb9CMx7fHtz0PZorclcDmH8Lvrb2+Vy7EO9plQ5Gkpbq+ZU72E4L
	 IOWWCUu9bjDsw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 17 Feb 2025 14:01:11 +0100
Subject: [PATCH net-next v5 07/15] net: airoha: Enable support for multiple
 net_devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-airoha-en7581-flowtable-offload-v5-7-28be901cb735@kernel.org>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
In-Reply-To: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.2

In the current codebase airoha_eth driver supports just a single
net_device connected to the Packet Switch Engine (PSE) lan port (GDM1).
As shown in commit 23020f049327 ("net: airoha: Introduce ethernet
support for EN7581 SoC"), PSE can switch packets between four GDM ports.
Enable the capability to create a net_device for each GDM port of the
PSE module. Moreover, since the QDMA blocks can be shared between
net_devices, do not stop TX/RX DMA in airoha_dev_stop() if there are
active net_devices for this QDMA block.
This is a preliminary patch to enable flowtable hw offloading for EN7581
SoC.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 35 +++++++++++++++++++-------------
 drivers/net/ethernet/airoha/airoha_eth.h |  4 +++-
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4f45db86d8d8d6b7a13d56a9315773f8685a09f6..513914da8503c1162b0f1b4fcca57434385fa4d1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1562,6 +1562,7 @@ static int airoha_dev_open(struct net_device *dev)
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
+	atomic_inc(&qdma->users);
 
 	return 0;
 }
@@ -1577,16 +1578,20 @@ static int airoha_dev_stop(struct net_device *dev)
 	if (err)
 		return err;
 
-	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
-			  GLOBAL_CFG_TX_DMA_EN_MASK |
-			  GLOBAL_CFG_RX_DMA_EN_MASK);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
+		netdev_tx_reset_subqueue(dev, i);
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-		if (!qdma->q_tx[i].ndesc)
-			continue;
+	if (atomic_dec_and_test(&qdma->users)) {
+		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+				  GLOBAL_CFG_TX_DMA_EN_MASK |
+				  GLOBAL_CFG_RX_DMA_EN_MASK);
 
-		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-		netdev_tx_reset_subqueue(dev, i);
+		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+			if (!qdma->q_tx[i].ndesc)
+				continue;
+
+			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
+		}
 	}
 
 	return 0;
@@ -2330,13 +2335,14 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
 	}
 }
 
-static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
+static int airoha_alloc_gdm_port(struct airoha_eth *eth,
+				 struct device_node *np, int index)
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
 	struct airoha_qdma *qdma;
 	struct net_device *dev;
-	int err, index;
+	int err, p;
 	u32 id;
 
 	if (!id_ptr) {
@@ -2345,14 +2351,14 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	}
 
 	id = be32_to_cpup(id_ptr);
-	index = id - 1;
+	p = id - 1;
 
 	if (!id || id > ARRAY_SIZE(eth->ports)) {
 		dev_err(eth->dev, "invalid gdm port id: %d\n", id);
 		return -EINVAL;
 	}
 
-	if (eth->ports[index]) {
+	if (eth->ports[p]) {
 		dev_err(eth->dev, "duplicate gdm port id: %d\n", id);
 		return -EINVAL;
 	}
@@ -2400,7 +2406,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	port->qdma = qdma;
 	port->dev = dev;
 	port->id = id;
-	eth->ports[index] = port;
+	eth->ports[p] = port;
 
 	err = airoha_metadata_dst_alloc(port);
 	if (err)
@@ -2472,6 +2478,7 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
 
+	i = 0;
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
 			continue;
@@ -2479,7 +2486,7 @@ static int airoha_probe(struct platform_device *pdev)
 		if (!of_device_is_available(np))
 			continue;
 
-		err = airoha_alloc_gdm_port(eth, np);
+		err = airoha_alloc_gdm_port(eth, np, i++);
 		if (err) {
 			of_node_put(np);
 			goto error_napi_stop;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fee6c10eaedfd30207205b6557e856091fd45d7e..74bdfd9e8d2fb3706f5ec6a4e17fe07fbcb38c3d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -13,7 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/reset.h>
 
-#define AIROHA_MAX_NUM_GDM_PORTS	1
+#define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		2
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
@@ -212,6 +212,8 @@ struct airoha_qdma {
 	u32 irqmask[QDMA_INT_REG_MAX];
 	int irq;
 
+	atomic_t users;
+
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];

-- 
2.48.1


