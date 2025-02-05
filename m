Return-Path: <netdev+bounces-163192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF24A298C4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C963A9D5A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBFC1FDE0A;
	Wed,  5 Feb 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW3/ADf6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE91FCFEF;
	Wed,  5 Feb 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779740; cv=none; b=cCDOIE7RiXWvgX4lJ2GFnVfYsGCR6zP7g0LhkAe0mr50AKaew8NMFj1zOkwngIgtKMvfnTgAq7hsEyA8Eeq8MqZ5DKBp8c36q1lQDymNpP6oUWspxyibqn6F28ChUg9xchqxfD9YqRdajWVsfEnPR6clSdbz0NXMWTvo0r7VSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779740; c=relaxed/simple;
	bh=b8KVn1GzHBRsxxYc2agv9jSTthBrazkDNNMMiDPN+yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANJUzgxwf3cVyD4RTazXbkubJDnYWwK9WBi/7GHKFnupWoKm5B99JnZ2tahQGWuI5oaFcr+S15SQEUwHpA1n4W7TnrugjhYFB+jn7yAn+rh3M6YIYBznlWa2MZX/Sc9aKDtzE9yekLYF+EkFQeqFPYXoutkfBnXZbmLAyZ6Tsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW3/ADf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CDAC4CED1;
	Wed,  5 Feb 2025 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779739;
	bh=b8KVn1GzHBRsxxYc2agv9jSTthBrazkDNNMMiDPN+yQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eW3/ADf64TRG/83KCaYwsIQN2xeD3dzV1PE7IXXUL9xUmUz50ZjNTJ9pHZfz9YrVn
	 7iYcvSCnP+7QMzCboG+4JlOQHie6z/iJd5qFkp36vVgVLAIHLW6mjbGIMAdMX3vg0u
	 NLKltVa/9JR3dKcDOTxi6Mx5l0n8L9yePKUQIb0Q+Rgc1+m9SjZsoIZbK+1JJxi0Vt
	 geMGoaUTTcfdHgNWv6lFusht+r7EIc8L5MzsnLet7+LYFRR3RcsUuzPUtlmiEMb0vV
	 kAzp+CUndFSvbZI1/BC9wzCVsg17/4e8qGLcanqCvB5xxaWmZnN/5yIc02/MU6V/cR
	 /Uzqd8WWnJSYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 05 Feb 2025 19:21:25 +0100
Subject: [PATCH net-next 06/13] net: airoha: Enable support for multiple
 net_devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-6-d362cfa97b01@kernel.org>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
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
index ab95f3da21d90bd42282a9f3f5474ce42a69c9d4..42b5e0945fb8738f70d0b77bf597a7a04e5f0716 100644
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
@@ -2321,13 +2326,14 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
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
@@ -2336,14 +2342,14 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
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
@@ -2391,7 +2397,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	port->qdma = qdma;
 	port->dev = dev;
 	port->id = id;
-	eth->ports[index] = port;
+	eth->ports[p] = port;
 
 	err = airoha_metadata_dst_alloc(port);
 	if (err)
@@ -2463,6 +2469,7 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
 
+	i = 0;
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
 			continue;
@@ -2470,7 +2477,7 @@ static int airoha_probe(struct platform_device *pdev)
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


