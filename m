Return-Path: <netdev+bounces-159932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC52A176A3
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 05:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C888188B208
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB61AF0D8;
	Tue, 21 Jan 2025 04:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71C195B37;
	Tue, 21 Jan 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434508; cv=none; b=H7VZkB9elU4JzNL/1jTqVNM/My5xU7lMN9jcVYp+0U9zuDoHk9lxYE1Hw0UDDgbUXK4RuU1edhIqUDEQHbSJZTN/O2N3cAC4G7iS5My31imtS0R08bLo1/T0y7wkvMZbbuwpvjF09c/v44O6jOzBye5ZUTIu7cg5fral3cc0FBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434508; c=relaxed/simple;
	bh=qIGnc4wf9D/ddorQ7LFwkA9iDLncpdyT3J3OZsAbxlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3HbNYPY7YYgTU9padn5Md7pigV4JlAytoGgVyqtW5D/tr6V2i1fEGQ7b7PSTS+y6U4yHMBuTHEGxeOr84bKhwN8P48qtP2E+p4QesFMzkHi3jHNDT+OFvDrq3ki9w+GtpE0v9rIwLkRaqFsAvoH2/JLTDsBnJffp7E5t5NrADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Jan 2025 13:41:44 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1F030200847B;
	Tue, 21 Jan 2025 13:41:44 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 21 Jan 2025 13:41:44 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id C93EC66E;
	Tue, 21 Jan 2025 13:41:43 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Vince Bridgers <vbridger@opensource.altera.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net v2 3/3] net: stmmac: Specify hardware capability value when FIFO size isn't specified
Date: Tue, 21 Jan 2025 13:41:38 +0900
Message-Id: <20250121044138.2883912-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Tx/Rx FIFO size is not specified in advance, the driver checks if the
value is zero and sets the hardware capability value in functions where
that value is used.

This sets the hardware capability value as a default and removes redundant
statements.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index da3316e3e93b..486283c27963 100644
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
@@ -7245,13 +7232,17 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
 	}
 
-	if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
+	if (!priv->plat->rx_fifo_size) {
+		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
+	} else if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
 		dev_warn(priv->device,
 			 "Rx FIFO size exceeds dma capability (%d)\n",
 			 priv->plat->rx_fifo_size);
 		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
 	}
-	if (priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
+	if (!priv->plat->tx_fifo_size) {
+		priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
+	} else if (priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
 		dev_warn(priv->device,
 			 "Tx FIFO size exceeds dma capability (%d)\n",
 			 priv->plat->tx_fifo_size);
-- 
2.25.1


