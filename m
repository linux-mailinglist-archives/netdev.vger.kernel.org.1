Return-Path: <netdev+bounces-141556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD119BB547
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AB2282B4F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34C91BC062;
	Mon,  4 Nov 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dZlFXwJc"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F0E1BE223;
	Mon,  4 Nov 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725330; cv=none; b=UWTIt1aFULemvNs/s8ef9XH6b6hOBQUlwzxSoTiNwMxYsI0ieh/e3RHvoO1W7q7Fu1MlOn0gbu0t9zVbrH1GeC54optcERZ/YfHVJ5KnE0ZF8WNY4Oatui2ecs4trfHPW7NCP7LOG9GKhyh7JlpeEO20+CQpLSaQkkwZRnIuse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725330; c=relaxed/simple;
	bh=81bXzyf/c0KElFkbrGf0peXgTbgrEywCB4w+SEhzFh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTPkOSGGVgBYEqNPxrkEfyW7UGPPalvHsBXO/Yu6rPB++qQ2STEDRYMaW+VYocb7rytSD6iTzL/1bVRdFyqdKlMz0pOjq9EynpyX71ecCBCh4VW3BQRx0vy2Dseu94K/I+nfJNnSnU+gRD+HsmUJ8ffWeFsD84cpsiT2NB/onx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dZlFXwJc; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=yReYF
	cMZ5fi0QK3NMeC05hlOMsUoL2XX7F1e3XLspqo=; b=dZlFXwJcnOk73IdtMSuNp
	5TvNcfVz+HSkoAi8AvrEWnmQV/Wbo5MpbXt0eW2j1TkB3OBiDGrWY1JzNzfsHFY4
	a/ykJ6Nn1DzR5SyidLqiApY8RSp2otqNdxbOdlNnCp09sJl6V9zUgbYsoWWUZyak
	55RTUffMOTN18EoUKP5frM=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H6e8xShnPaEoFA--.33421S3;
	Mon, 04 Nov 2024 21:01:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.wu@rock-chips.com,
	Johan Jonker <jbx6244@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 1/2] net: arc: fix the device for dma_map_single/dma_unmap_single
Date: Mon,  4 Nov 2024 21:01:38 +0800
Message-ID: <20241104130147.440125-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104130147.440125-1-andyshrk@163.com>
References: <20241104130147.440125-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6e8xShnPaEoFA--.33421S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF43Zw4kJF4rurykZr1xGrg_yoW7Cry3pF
	1rGa4SyFW2qFnFkrWrJrWUXr1Yywn5J34S9ay7G392gFnxXrn3Wry0yFy2y3yFyFZ2kF4f
	Ar1DCFyfXFn7WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAjjgUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQGNXmcovEiZFgABsO

From: Johan Jonker <jbx6244@gmail.com>

The ndev->dev and pdev->dev aren't the same device, use ndev->dev.parent
which has dma_mask, ndev->dev.parent is just pdev->dev.
Or it would cause the following issue:

[   39.933526] ------------[ cut here ]------------
[   39.938414] WARNING: CPU: 1 PID: 501 at kernel/dma/mapping.c:149 dma_map_page_attrs+0x90/0x1f8

Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- Add fix tag.
- Add cover letter.

 drivers/net/ethernet/arc/emac_main.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_main.c b/drivers/net/ethernet/arc/emac_main.c
index 31ee477dd131e..8283aeee35fb6 100644
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -111,6 +111,7 @@ static void arc_emac_tx_clean(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
+	struct device *dev = ndev->dev.parent;
 	unsigned int i;
 
 	for (i = 0; i < TX_BD_NUM; i++) {
@@ -140,7 +141,7 @@ static void arc_emac_tx_clean(struct net_device *ndev)
 			stats->tx_bytes += skb->len;
 		}
 
-		dma_unmap_single(&ndev->dev, dma_unmap_addr(tx_buff, addr),
+		dma_unmap_single(dev, dma_unmap_addr(tx_buff, addr),
 				 dma_unmap_len(tx_buff, len), DMA_TO_DEVICE);
 
 		/* return the sk_buff to system */
@@ -174,6 +175,7 @@ static void arc_emac_tx_clean(struct net_device *ndev)
 static int arc_emac_rx(struct net_device *ndev, int budget)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = ndev->dev.parent;
 	unsigned int work_done;
 
 	for (work_done = 0; work_done < budget; work_done++) {
@@ -223,9 +225,9 @@ static int arc_emac_rx(struct net_device *ndev, int budget)
 			continue;
 		}
 
-		addr = dma_map_single(&ndev->dev, (void *)skb->data,
+		addr = dma_map_single(dev, (void *)skb->data,
 				      EMAC_BUFFER_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&ndev->dev, addr)) {
+		if (dma_mapping_error(dev, addr)) {
 			if (net_ratelimit())
 				netdev_err(ndev, "cannot map dma buffer\n");
 			dev_kfree_skb(skb);
@@ -237,7 +239,7 @@ static int arc_emac_rx(struct net_device *ndev, int budget)
 		}
 
 		/* unmap previosly mapped skb */
-		dma_unmap_single(&ndev->dev, dma_unmap_addr(rx_buff, addr),
+		dma_unmap_single(dev, dma_unmap_addr(rx_buff, addr),
 				 dma_unmap_len(rx_buff, len), DMA_FROM_DEVICE);
 
 		pktlen = info & LEN_MASK;
@@ -423,6 +425,7 @@ static int arc_emac_open(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phy_dev = ndev->phydev;
+	struct device *dev = ndev->dev.parent;
 	int i;
 
 	phy_dev->autoneg = AUTONEG_ENABLE;
@@ -445,9 +448,9 @@ static int arc_emac_open(struct net_device *ndev)
 		if (unlikely(!rx_buff->skb))
 			return -ENOMEM;
 
-		addr = dma_map_single(&ndev->dev, (void *)rx_buff->skb->data,
+		addr = dma_map_single(dev, (void *)rx_buff->skb->data,
 				      EMAC_BUFFER_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&ndev->dev, addr)) {
+		if (dma_mapping_error(dev, addr)) {
 			netdev_err(ndev, "cannot dma map\n");
 			dev_kfree_skb(rx_buff->skb);
 			return -ENOMEM;
@@ -548,6 +551,7 @@ static void arc_emac_set_rx_mode(struct net_device *ndev)
 static void arc_free_tx_queue(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = ndev->dev.parent;
 	unsigned int i;
 
 	for (i = 0; i < TX_BD_NUM; i++) {
@@ -555,7 +559,7 @@ static void arc_free_tx_queue(struct net_device *ndev)
 		struct buffer_state *tx_buff = &priv->tx_buff[i];
 
 		if (tx_buff->skb) {
-			dma_unmap_single(&ndev->dev,
+			dma_unmap_single(dev,
 					 dma_unmap_addr(tx_buff, addr),
 					 dma_unmap_len(tx_buff, len),
 					 DMA_TO_DEVICE);
@@ -579,6 +583,7 @@ static void arc_free_tx_queue(struct net_device *ndev)
 static void arc_free_rx_queue(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = ndev->dev.parent;
 	unsigned int i;
 
 	for (i = 0; i < RX_BD_NUM; i++) {
@@ -586,7 +591,7 @@ static void arc_free_rx_queue(struct net_device *ndev)
 		struct buffer_state *rx_buff = &priv->rx_buff[i];
 
 		if (rx_buff->skb) {
-			dma_unmap_single(&ndev->dev,
+			dma_unmap_single(dev,
 					 dma_unmap_addr(rx_buff, addr),
 					 dma_unmap_len(rx_buff, len),
 					 DMA_FROM_DEVICE);
@@ -679,6 +684,7 @@ static netdev_tx_t arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
 	unsigned int len, *txbd_curr = &priv->txbd_curr;
 	struct net_device_stats *stats = &ndev->stats;
 	__le32 *info = &priv->txbd[*txbd_curr].info;
+	struct device *dev = ndev->dev.parent;
 	dma_addr_t addr;
 
 	if (skb_padto(skb, ETH_ZLEN))
@@ -692,10 +698,9 @@ static netdev_tx_t arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_BUSY;
 	}
 
-	addr = dma_map_single(&ndev->dev, (void *)skb->data, len,
-			      DMA_TO_DEVICE);
+	addr = dma_map_single(dev, (void *)skb->data, len, DMA_TO_DEVICE);
 
-	if (unlikely(dma_mapping_error(&ndev->dev, addr))) {
+	if (unlikely(dma_mapping_error(dev, addr))) {
 		stats->tx_dropped++;
 		stats->tx_errors++;
 		dev_kfree_skb_any(skb);
-- 
2.34.1


