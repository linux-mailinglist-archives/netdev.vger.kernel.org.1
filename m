Return-Path: <netdev+bounces-160756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B455A1B35A
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FFD16D3F3
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1C21A45E;
	Fri, 24 Jan 2025 10:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D197219A68;
	Fri, 24 Jan 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713654; cv=none; b=U3cUtxpi9qjOLRzcTa44zm07coLE+ohnjwx68Zq1LLKf5ma/CutW7ZeMP0gl4NABRkczz9rJBlQdWE+VTrCK9mFdO2sLTlRRkG15KgdO/FARkhVXege6AqZswY+L/oW5WN44zNaiOBHXJPca8Zm1qnCK0f5bQfvfORS3nZH7Or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713654; c=relaxed/simple;
	bh=CQDsddN8t7MLA+8k+CjCEy4lV6PX8oxAuM4pc3oKKeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlYd08R/GMdGQ7Ekfguzan++cBsAyi0xdjF7qhI1A2b4kf7QkUmPIhBlY4OVxZ/OOZ4PDxWsJKm+KxB993KNS9t6EOWdA6CItDKqPsGojNqekP5ruUfKOJMdQlwQtmG+7fI/23e/pVU9XRar6zsFQG7mKmFZTRc8ZyJzEgaY6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jan 2025 19:14:05 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E2374208E6F3;
	Fri, 24 Jan 2025 19:14:04 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 24 Jan 2025 19:14:04 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 59D96373C;
	Fri, 24 Jan 2025 19:14:04 +0900 (JST)
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
Subject: [PATCH net v3 1/3] net: stmmac: Limit the number of MTL queues to hardware capability
Date: Fri, 24 Jan 2025 19:13:57 +0900
Message-Id: <20250124101359.2926906-2-hayashi.kunihiko@socionext.com>
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

The number of MTL queues to use is specified by the parameter
"snps,{tx,rx}-queues-to-use" from stmmac_platform layer.

However, the maximum numbers of queues are constrained by upper limits
determined by the capability of each hardware feature. It's appropriate
to limit the values not to exceed the upper limit values and display
a warning message.

This only works if the hardware capability has the upper limit values.

Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..be1e6fa6d557 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7232,6 +7232,21 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (priv->dma_cap.tsoen)
 		dev_info(priv->device, "TSO supported\n");
 
+	if (priv->dma_cap.number_rx_queues &&
+	    priv->dma_cap.number_rx_queues < priv->plat->rx_queues_to_use) {
+		dev_warn(priv->device,
+			 "Number of Rx queues (%u) exceeds dma capability\n",
+			 priv->plat->rx_queues_to_use);
+		priv->plat->rx_queues_to_use = priv->dma_cap.number_rx_queues;
+	}
+	if (priv->dma_cap.number_tx_queues &&
+	    priv->dma_cap.number_tx_queues < priv->plat->tx_queues_to_use) {
+		dev_warn(priv->device,
+			 "Number of Tx queues (%u) exceeds dma capability\n",
+			 priv->plat->tx_queues_to_use);
+		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
+	}
+
 	priv->hw->vlan_fail_q_en =
 		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
-- 
2.25.1


