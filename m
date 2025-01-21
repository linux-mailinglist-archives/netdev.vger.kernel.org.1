Return-Path: <netdev+bounces-159931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9227A1769F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 05:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F53A502B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22F1A2550;
	Tue, 21 Jan 2025 04:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C918E025;
	Tue, 21 Jan 2025 04:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434506; cv=none; b=irYO9p+paCNkT7ufJn2KOW831OAK8XZ4EODtvrVaUpFIXpznuNM3fhR1bpSkDfvWoIxMZW1yCmt7yGuc9rsCyhooYTslYdgWCi9ZYb9XQw2JQ55vUhdm3lLSwvpQuEO14AAfwxjDqJ0jyoitaY7BwGhJIx1noFPz6pmBM4DDdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434506; c=relaxed/simple;
	bh=z9vKbUwVvzWZdsr7EToeCfacAI/GSht7qTZOabQ2JR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jU7LLusAB754+/2tIgzhNrF9Dk53fQXT8q4mOoOWKNRTaFiugU47KY1/7O+WA5qBm+7tmqY3jvd32JxRCrYzHTN4y+SHyA9mfCiSL1e4xodh3JJ8uY7favFnOzUI8H/0b6Ve2vOL9bUSlrXzzuxbXhQE1/NHaldcYIjR2lIlEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Jan 2025 13:41:43 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 95E662006FCC;
	Tue, 21 Jan 2025 13:41:43 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 21 Jan 2025 13:41:43 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 29382C3C1E;
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
Subject: [PATCH net v2 2/3] net: stmmac: Limit FIFO size by hardware capability
Date: Tue, 21 Jan 2025 13:41:37 +0900
Message-Id: <20250121044138.2883912-3-hayashi.kunihiko@socionext.com>
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

Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
stmmac_platform layer.

However, these values are constrained by upper limits determined by the
capabilities of each hardware feature. There is a risk that the upper
bits will be truncated due to the calculation, so it's appropriate to
limit them to the upper limit values and display a warning message.

Fixes: e7877f52fd4a ("stmmac: Read tx-fifo-depth and rx-fifo-depth from the devicetree")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 251a8c15637f..da3316e3e93b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7245,6 +7245,19 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
 	}
 
+	if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
+		dev_warn(priv->device,
+			 "Rx FIFO size exceeds dma capability (%d)\n",
+			 priv->plat->rx_fifo_size);
+		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
+	}
+	if (priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
+		dev_warn(priv->device,
+			 "Tx FIFO size exceeds dma capability (%d)\n",
+			 priv->plat->tx_fifo_size);
+		priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
+	}
+
 	priv->hw->vlan_fail_q_en =
 		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
-- 
2.25.1


