Return-Path: <netdev+bounces-30929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B59E789FA8
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF111C208CC
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA7101E7;
	Sun, 27 Aug 2023 13:53:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7710959
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 13:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888A8C433CA;
	Sun, 27 Aug 2023 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693144430;
	bh=2bvndDeKIa1am5zfMWn8oY7XCThEt0L62331HK8Om4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpsKqOzZidGunvuUuKkUzRb3nxHPc6vpjly9uclBMCkpdnASEMbh1YnJNIzuIbDs7
	 YwPRHtAGPCt0WsivqZnsO/4j80+ouaxH2miPPoKo+rWIj31qs9kXie4PLbSMlmHwCP
	 MM1fG7LvhxkHPtPod8gs8W8m93I6nxiQdniWVkYsm3BfU6+paCY7ZtlP2O6vGb0Icc
	 sjJb8ffbiBVdGNnWamtfou93biN5+pYsY+gWElJtkrWDnRLG18sNjH0gg3MaBiYRyu
	 njcB1BQ9+akEOgCe7fu1pN/JXOGheQfy7Wxjb6nqDwuVHu/6SiVGMcZ7vtfZg4rf5f
	 wZqSpIl1vo4+A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: stmmac: dwmac-starfive: improve error handling during probe
Date: Sun, 27 Aug 2023 21:41:49 +0800
Message-Id: <20230827134150.2918-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827134150.2918-1-jszhang@kernel.org>
References: <20230827134150.2918-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After stmmac_probe_config_dt() succeeds, when error happens later,
stmmac_remove_config_dt() needs to be called for proper error handling.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 892612564694..b68f42795eaa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -111,18 +111,24 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 				     "dt configuration failed\n");
 
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac)
-		return -ENOMEM;
+	if (!dwmac) {
+		err = -ENOMEM;
+		goto err_remove_config_dt;
+	}
 
 	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
-	if (IS_ERR(dwmac->clk_tx))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
-				     "error getting tx clock\n");
+	if (IS_ERR(dwmac->clk_tx)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
+				    "error getting tx clock\n");
+		goto err_remove_config_dt;
+	}
 
 	clk_gtx = devm_clk_get_enabled(&pdev->dev, "gtx");
-	if (IS_ERR(clk_gtx))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
-				     "error getting gtx clock\n");
+	if (IS_ERR(clk_gtx)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
+				    "error getting gtx clock\n");
+		goto err_remove_config_dt;
+	}
 
 	/* Generally, the rgmii_tx clock is provided by the internal clock,
 	 * which needs to match the corresponding clock frequency according
@@ -139,15 +145,17 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 
 	err = starfive_dwmac_set_mode(plat_dat);
 	if (err)
-		return err;
+		goto err_remove_config_dt;
 
 	err = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (err) {
-		stmmac_remove_config_dt(pdev, plat_dat);
-		return err;
-	}
+	if (err)
+		goto err_remove_config_dt;
 
 	return 0;
+
+err_remove_config_dt:
+	stmmac_remove_config_dt(pdev, plat_dat);
+	return err;
 }
 
 static const struct of_device_id starfive_dwmac_match[] = {
-- 
2.40.1


