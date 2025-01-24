Return-Path: <netdev+bounces-160758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1DA1B35F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2135416D4DF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8340521C169;
	Fri, 24 Jan 2025 10:14:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C1021B1A3;
	Fri, 24 Jan 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713657; cv=none; b=NtRslSkMB1/os1TSY4GFO20vjqUPiadxKTIXvHbjbf9CnYQ43RTA9CoS1zbdGRTeFoICQ5dsYzeOi8ZVDDw4mLVeW4rQObaKjGgU4FPI1zaSKwjZ9OMZd0nlW6k+7zLuniJPf1zQwPymhSgRDmeoyiuaOOjpUrqp6L/Tf36YPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713657; c=relaxed/simple;
	bh=648f3ADXLeyvbsUtPLCeMmzUow6UGYPVwoX63oyRwPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1aDnGW+ay1VPf5yKopazlMfjPF38Hpa7Sz5uDLO7ku5DptlniA4NMzwRlsqR6l/Ywxmq1mGT9lhGn4mGwjIFjdZKYtgxhk/OD5cGluHDUU2mjTF9hjCyK3ywUneEqxyw/ye0oUQeZFK+3/oFjd9Icl1rJn/bYndoTUSPcUQ7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jan 2025 19:14:06 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 19A3A208E6F3;
	Fri, 24 Jan 2025 19:14:06 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 24 Jan 2025 19:14:06 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id A102C373C;
	Fri, 24 Jan 2025 19:14:05 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>,
	Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net v3 3/3] net: stmmac: Specify hardware capability value when FIFO size isn't specified
Date: Fri, 24 Jan 2025 19:13:59 +0900
Message-Id: <20250124101359.2926906-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250124101359.2926906-1-hayashi.kunihiko@socionext.com>
References: <20250124101359.2926906-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Tx/Rx FIFO size is not specified in advance, the driver checks if
the value is zero and sets the hardware capability value in functions
where that value is used.

Consolidate the check and settings into function stmmac_hw_init() and
remove redundant other statements.

If FIFO size is zero and the hardware capability also doesn't have upper
limit values, return with an error message.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 251a812e4e77..efeefb9eff8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2375,11 +2375,6 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	u32 chan = 0;
 	u8 qmode = 0;
 
-	if (rxfifosz == 0)
-		rxfifosz = priv->dma_cap.rx_fifo_size;
-	if (txfifosz == 0)
-		txfifosz = priv->dma_cap.tx_fifo_size;
-
 	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
 	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 		rxfifosz /= rx_channels_count;
@@ -2851,11 +2846,6 @@ static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 	int rxfifosz = priv->plat->rx_fifo_size;
 	int txfifosz = priv->plat->tx_fifo_size;
 
-	if (rxfifosz == 0)
-		rxfifosz = priv->dma_cap.rx_fifo_size;
-	if (txfifosz == 0)
-		txfifosz = priv->dma_cap.tx_fifo_size;
-
 	/* Adjust for real per queue fifo size */
 	rxfifosz /= rx_channels_count;
 	txfifosz /= tx_channels_count;
@@ -5856,9 +5846,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	const int mtu = new_mtu;
 	int ret;
 
-	if (txfifosz == 0)
-		txfifosz = priv->dma_cap.tx_fifo_size;
-
 	txfifosz /= priv->plat->tx_queues_to_use;
 
 	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
@@ -7247,15 +7234,29 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
 	}
 
-	if (priv->dma_cap.rx_fifo_size &&
-	    priv->dma_cap.rx_fifo_size < priv->plat->rx_fifo_size) {
+	if (!priv->plat->rx_fifo_size) {
+		if (priv->dma_cap.rx_fifo_size) {
+			priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
+		} else {
+			dev_err(priv->device, "Can't specify Rx FIFO size\n");
+			return -ENODEV;
+		}
+	} else if (priv->dma_cap.rx_fifo_size &&
+		   priv->dma_cap.rx_fifo_size < priv->plat->rx_fifo_size) {
 		dev_warn(priv->device,
 			 "Rx FIFO size (%u) exceeds dma capability\n",
 			 priv->plat->rx_fifo_size);
 		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
 	}
-	if (priv->dma_cap.tx_fifo_size &&
-	    priv->dma_cap.tx_fifo_size < priv->plat->tx_fifo_size) {
+	if (!priv->plat->tx_fifo_size) {
+		if (priv->dma_cap.tx_fifo_size) {
+			priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
+		} else {
+			dev_err(priv->device, "Can't specify Tx FIFO size\n");
+			return -ENODEV;
+		}
+	} else if (priv->dma_cap.tx_fifo_size &&
+		   priv->dma_cap.tx_fifo_size < priv->plat->tx_fifo_size) {
 		dev_warn(priv->device,
 			 "Tx FIFO size (%u) exceeds dma capability\n",
 			 priv->plat->tx_fifo_size);
-- 
2.25.1


