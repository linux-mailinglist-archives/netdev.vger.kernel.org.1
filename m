Return-Path: <netdev+bounces-159930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAAFA1769E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 05:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AD9169DE5
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93B19F13F;
	Tue, 21 Jan 2025 04:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119A1898F2;
	Tue, 21 Jan 2025 04:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434506; cv=none; b=mq8zN56fDuTTczhfvO2fiX1UUvgb2C7XESq7ZS2SllLdE0ZKGw8BPJmnoGE2TWu4beHFaKaIiRR0iv5vi2d8QXnxetFAxYAA1Iig2pgAXibyh2X3AM9qfcqro2QgySRdAdA9Vgg7hPT24dbor3LlaeYcZypZj3PdnB48PYfQhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434506; c=relaxed/simple;
	bh=e4leDXp6VuCT2itGM7/rpLDnf84Ap/dIPcoQa/xJ92E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRbbdvtLU/wccZaY/tYli3Rf1dov4fypxatxm7U6a8Y3Ux2kIaBDsZyy3VTEJGJ9SoFub0xsOFKA1y3/xAM1ToVxFBvhRB942sdfQlvCblTkQvzz7+mf72xoScRtSZ9V+I/DZuqAV+X5Nh4F0xq8vc+U1DtpGkgCKxB+Mt9OaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Jan 2025 13:41:43 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 19AA12006FCC;
	Tue, 21 Jan 2025 13:41:43 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 21 Jan 2025 13:41:43 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 59F4B66E;
	Tue, 21 Jan 2025 13:41:42 +0900 (JST)
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
Subject: [PATCH net v2 1/3] net: stmmac: Limit the number of MTL queues to hardware capability
Date: Tue, 21 Jan 2025 13:41:36 +0900
Message-Id: <20250121044138.2883912-2-hayashi.kunihiko@socionext.com>
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

The number of MTL queues to use is specified by the parameter
"snps,{tx,rx}-queues-to-use" from stmmac_platform layer.

However, the maximum numbers of queues are constrained by upper limits
determined by the capability of each hardware feature. It's appropriate
to limit the values not to exceed the upper limit values and display
a warning message.

Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..251a8c15637f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7232,6 +7232,19 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (priv->dma_cap.tsoen)
 		dev_info(priv->device, "TSO supported\n");
 
+	if (priv->plat->rx_queues_to_use > priv->dma_cap.number_rx_queues) {
+		dev_warn(priv->device,
+			 "Number of Rx queues exceeds dma capability (%d)\n",
+			 priv->plat->rx_queues_to_use);
+		priv->plat->rx_queues_to_use = priv->dma_cap.number_rx_queues;
+	}
+	if (priv->plat->tx_queues_to_use > priv->dma_cap.number_tx_queues) {
+		dev_warn(priv->device,
+			 "Number of Tx queues exceeds dma capability (%d)\n",
+			 priv->plat->tx_queues_to_use);
+		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
+	}
+
 	priv->hw->vlan_fail_q_en =
 		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
-- 
2.25.1


