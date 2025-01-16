Return-Path: <netdev+bounces-158723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74403A1311B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F481655DC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0326AEC;
	Thu, 16 Jan 2025 02:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A194A78F36;
	Thu, 16 Jan 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993411; cv=none; b=kNkp6ohtqxuE4tJ2E3I0EBNSSQhTXdHaLUFsIs1mykklDB+1KgMMS9rZkY0AFC2s/tgEK4spETsE5jSWucFkZ06ZMOF/NhP5XOatvlyImZxF0SnSaQLNST6AH5vIo1yT9UFj6zKiqYSBm+4B/rMQz1k0bsYbaBpA8uGWB20QAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993411; c=relaxed/simple;
	bh=6tF8RkX5O30H9TBMHSmfJ+AI2FTWJQCWNTQGdyS0+ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLfSRhlT3rcolbBuZN8NaxH/DTtqTKsJPmRKdwbpDeTVzz4CElIpiBx9iutcPTrIOmiJYUOUMgUsEtUimlQAtaVyuvUzooga+S/JE7Z4VCCpo22dc3TNAyCLsqjja7eTqLZiPH6OxTSmRLgHBqlqtlqRSvHM9FooY2bggiMqLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Jan 2025 11:08:59 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 9AF1D200C4F1;
	Thu, 16 Jan 2025 11:08:59 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 16 Jan 2025 11:08:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 01B83AB187;
	Thu, 16 Jan 2025 11:08:58 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 1/2] net: stmmac: Limit FIFO size by hardware feature value
Date: Thu, 16 Jan 2025 11:08:52 +0900
Message-Id: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
the platform layer.

However, these values are constrained by upper limits determined by the
capabilities of each hardware feature. There is a risk that the upper
bits will be truncated due to the calculation, so it's appropriate to
limit them to the upper limit values.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..2d69c3c4b329 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2375,9 +2375,9 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	u32 chan = 0;
 	u8 qmode = 0;
 
-	if (rxfifosz == 0)
+	if (!rxfifosz || rxfifosz > priv->dma_cap.rx_fifo_size)
 		rxfifosz = priv->dma_cap.rx_fifo_size;
-	if (txfifosz == 0)
+	if (!txfifosz || txfifosz > priv->dma_cap.tx_fifo_size)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
 	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
@@ -2851,9 +2851,9 @@ static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 	int rxfifosz = priv->plat->rx_fifo_size;
 	int txfifosz = priv->plat->tx_fifo_size;
 
-	if (rxfifosz == 0)
+	if (!rxfifosz || rxfifosz > priv->dma_cap.rx_fifo_size)
 		rxfifosz = priv->dma_cap.rx_fifo_size;
-	if (txfifosz == 0)
+	if (!txfifosz || txfifosz > priv->dma_cap.tx_fifo_size)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
 	/* Adjust for real per queue fifo size */
-- 
2.25.1


