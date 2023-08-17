Return-Path: <netdev+bounces-28542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F4577FC9E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04135281024
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39493171AC;
	Thu, 17 Aug 2023 17:09:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED5171A4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4C9C43391;
	Thu, 17 Aug 2023 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292177;
	bh=4IGcaQBS31O4UxIqmGLC17t6CNsWT5osrD81dv+HBug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3Ecdo94iULh102ihxFOsBgvc/1wjMNN1TBd/yV9CJ2QXFoLCfRS/tftGeX+pFDDy
	 zOoqoSgYlFjX/ZtEqsbGx5lhzi6xuIA5NMf4yyHPjuViJvsenCN7NCbYLS5W8mrb99
	 DCD9Sq1518sj/JXp9G+pKv1Xd7nxilp89P/0C5JuoQGKU7KjDIfXaAwNrxP8q+U1Tw
	 jAZEj/+/U46IDJDmnJ0Obpr8B9r1ykPeaT6w+5D34mqNOEsa7KkITEa2Xd8f7wKcjy
	 zGezq4lKcHBRK511EfQZruiuMHkJi+RLLpsdYg2GsyJZMSwcMkaLOFU2ydd38gxIA6
	 0wbkKhuJaqwqQ==
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
Subject: [PATCH net-next v5 1/9] net: stmmac: correct RX COE parsing for xgmac
Date: Fri, 18 Aug 2023 00:57:41 +0800
Message-Id: <20230817165749.672-2-jszhang@kernel.org>
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

xgmac can support RX COE, but there's no two kinds of COE, I.E type 1
and type 2 COE.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 733b5e900817..3d90ca983389 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7035,7 +7035,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (priv->plat->rx_coe) {
 		priv->hw->rx_csum = priv->plat->rx_coe;
 		dev_info(priv->device, "RX Checksum Offload Engine supported\n");
-		if (priv->synopsys_id < DWMAC_CORE_4_00)
+		if (priv->synopsys_id < DWMAC_CORE_4_00 && !priv->plat->has_xgmac)
 			dev_info(priv->device, "COE Type %d\n", priv->hw->rx_csum);
 	}
 	if (priv->plat->tx_coe)
-- 
2.40.1


