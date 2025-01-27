Return-Path: <netdev+bounces-161042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2677A1CF7B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 02:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA13F3A6C98
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB83B192;
	Mon, 27 Jan 2025 01:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D9748F;
	Mon, 27 Jan 2025 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941908; cv=none; b=Ft729Kjn8vi3K6mJtyNNWbb8/4x8tXJIJXlCSrooayzx4L0QbSa82b8iu/dJZK75qKO6if22YNtaJSTuWLPM1dTCCsVBOjqITMOIa5tnLzP2Q15jKPM4WpoKcQymFCwRCFb4YWz26o5cV+WQx6wUyItWQOLm5fAt8y7zlCpTwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941908; c=relaxed/simple;
	bh=VILVIJVqU8673f5da3A1S/hfggt45YYaBzs9lLDllBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhpqXsa7GJ769uBojB8YVQK9hzMIEx665D2f51YY2Eh8tN5zrF0XvUc4bm/oPiluw9s+Ny35jDt+0blvTEoTNWqCFptU3decjBgF0jPsK5XYQRa/dv5G3LJOUrmC/q+pS/1npg0RjGnZbfguH8kIWtGfhMKi3y9y+/XKqyPRAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Jan 2025 10:38:25 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 989FF200705C;
	Mon, 27 Jan 2025 10:38:25 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 10:38:25 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id D93A8AB187;
	Mon, 27 Jan 2025 10:38:24 +0900 (JST)
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
Subject: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value when FIFO size isn't specified
Date: Mon, 27 Jan 2025 10:38:20 +0900
Message-Id: <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
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
index 1d0491e15e5b..e3ce2c214c0b 100644
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
-	    priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
+	if (!priv->plat->rx_fifo_size) {
+		if (priv->dma_cap.rx_fifo_size) {
+			priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
+		} else {
+			dev_err(priv->device, "Can't specify Rx FIFO size\n");
+			return -ENODEV;
+		}
+	} else if (priv->dma_cap.rx_fifo_size &&
+		   priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
 		dev_warn(priv->device,
 			 "Rx FIFO size (%u) exceeds dma capability\n",
 			 priv->plat->rx_fifo_size);
 		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
 	}
-	if (priv->dma_cap.tx_fifo_size &&
-	    priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
+	if (!priv->plat->tx_fifo_size) {
+		if (priv->dma_cap.tx_fifo_size) {
+			priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
+		} else {
+			dev_err(priv->device, "Can't specify Tx FIFO size\n");
+			return -ENODEV;
+		}
+	} else if (priv->dma_cap.tx_fifo_size &&
+		   priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
 		dev_warn(priv->device,
 			 "Tx FIFO size (%u) exceeds dma capability\n",
 			 priv->plat->tx_fifo_size);
-- 
2.25.1


