Return-Path: <netdev+bounces-28547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390477FCBE
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854831C214D4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A08174E1;
	Thu, 17 Aug 2023 17:09:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7133174C6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10155C43397;
	Thu, 17 Aug 2023 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292189;
	bh=H6r17igTApBMtumIbML4/Pv00+k0irJssUyt+I4FyfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYpTTr3Bt7kUAgHnD+wrvXcht/aMFZ37ye8zlLZaCbzamr0O075RyZSz23otSW+/I
	 YFbZfGI1uQnLMW1zyJXqdY2ItxEqCvwT36UV+ZpL6i3HM075xn/Bb0ODnzp7m6m2qb
	 8BF9OrUBbp8v3a7qFxGj7P0Aeqf8r9+l7R2uda486x8Xj9bU7QjTFnkHAqOWXTaTev
	 zjlp4hZGZU8Dh6dEM9P+GxiEtVMPcT67RfeTmSpAxS487TbFmfTwomQiK5dL5Hp0sS
	 wUt/gT5Ilg0hZf+ZJDnYE2IkyF+fXx+E77ZRbtsCNwx21b89C+eFzMYdk5t2UgK9NC
	 Nu3sUuN2du5OQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v5 5/9] net: stmmac: xgmac: support per-channel irq
Date: Fri, 18 Aug 2023 00:57:45 +0800
Message-Id: <20230817165749.672-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230817165749.672-1-jszhang@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IP supports per channel interrupt, add support for this usage case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 33 +++++++++++--------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 7f68bef456b7..18a042834d75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -340,6 +340,8 @@
 
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
+#define XGMAC_INTM			GENMASK(13, 12)
+#define XGMAC_INTM_MODE1		0x1
 #define XGMAC_SWR			BIT(0)
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 1ef8fc132c2d..ce228c362403 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->perch_irq_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value &= ~XGMAC_INTM;
+		value |= FIELD_PREP(XGMAC_INTM, XGMAC_INTM_MODE1);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
@@ -365,20 +372,20 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	}
 
 	/* TX/RX NORMAL interrupts */
-	if (likely(intr_status & XGMAC_NIS)) {
-		if (likely(intr_status & XGMAC_RI)) {
-			u64_stats_update_begin(&rx_q->rxq_stats.syncp);
-			rx_q->rxq_stats.rx_normal_irq_n++;
-			u64_stats_update_end(&rx_q->rxq_stats.syncp);
-			ret |= handle_rx;
-		}
-		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
-			u64_stats_update_begin(&tx_q->txq_stats.syncp);
-			tx_q->txq_stats.tx_normal_irq_n++;
-			u64_stats_update_end(&tx_q->txq_stats.syncp);
-			ret |= handle_tx;
-		}
+	if (likely(intr_status & XGMAC_RI)) {
+		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
+		rx_q->rxq_stats.rx_normal_irq_n++;
+		u64_stats_update_end(&rx_q->rxq_stats.syncp);
+		ret |= handle_rx;
+	}
+	if (likely(intr_status & XGMAC_TI)) {
+		u64_stats_update_begin(&tx_q->txq_stats.syncp);
+		tx_q->txq_stats.tx_normal_irq_n++;
+		u64_stats_update_end(&tx_q->txq_stats.syncp);
+		ret |= handle_tx;
 	}
+	if (unlikely(intr_status & XGMAC_TBU))
+		ret |= handle_tx;
 
 	/* Clear interrupts */
 	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
-- 
2.40.1


