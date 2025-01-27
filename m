Return-Path: <netdev+bounces-161041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC2A1CF79
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 02:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400FB18878B1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8284426AFB;
	Mon, 27 Jan 2025 01:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE046BF;
	Mon, 27 Jan 2025 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941908; cv=none; b=nVBLJKQk7UYnVre7U5ZcuphA6rwq1PDNgNZJ49CWuNDSb+2ZYSDozcTyO/bu1q6d/lnPM43CPbmQWKIt0TqMsdZfo08fsp5VPrwwGtBA9PaR8XlqgAxxQ/eh3fyCnh+lznLP898U6L0yHQ+CUcsLAMzbe8zmErgw9U82mK1WzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941908; c=relaxed/simple;
	bh=uo1sE1GSwZjpFo0hVXF7RTMa3TtEZXrtvW9bx2+o3Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWTMGYU3cU961DCnPdG3C8ZOR22tVih62sRMraov2p6X/CZ3LRZ+sOB4ug4Nl9ZpkaFYqybpiDtUtYUnNDuVlQ1oEcyn9WMxfq0oGT8/wzGrI1uiS5L1+ssp+4UUe6RnfCnGwWJ30IxX8sUcPXXE5Xpg3p8H2k0S3p3emThDElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jan 2025 10:38:24 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 98D66200B5D4;
	Mon, 27 Jan 2025 10:38:24 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 10:38:24 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 34CADAB187;
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
Subject: [PATCH net v4 2/3] net: stmmac: Limit FIFO size by hardware capability
Date: Mon, 27 Jan 2025 10:38:19 +0900
Message-Id: <20250127013820.2941044-3-hayashi.kunihiko@socionext.com>
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

Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
stmmac_platform layer.

However, these values are constrained by upper limits determined by the
capabilities of each hardware feature. There is a risk that the upper
bits will be truncated due to the calculation, so it's appropriate to
limit them to the upper limit values and display a warning message.

This only works if the hardware capability has the upper limit values.

Fixes: e7877f52fd4a ("stmmac: Read tx-fifo-depth and rx-fifo-depth from the devicetree")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 97c3d1b89529..1d0491e15e5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7247,6 +7247,21 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
 	}
 
+	if (priv->dma_cap.rx_fifo_size &&
+	    priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
+		dev_warn(priv->device,
+			 "Rx FIFO size (%u) exceeds dma capability\n",
+			 priv->plat->rx_fifo_size);
+		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
+	}
+	if (priv->dma_cap.tx_fifo_size &&
+	    priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
+		dev_warn(priv->device,
+			 "Tx FIFO size (%u) exceeds dma capability\n",
+			 priv->plat->tx_fifo_size);
+		priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
+	}
+
 	priv->hw->vlan_fail_q_en =
 		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
-- 
2.25.1


