Return-Path: <netdev+bounces-34243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D967A2EC3
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7207A1C209F4
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97279111A1;
	Sat, 16 Sep 2023 08:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82548134B9;
	Sat, 16 Sep 2023 08:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41DC433CC;
	Sat, 16 Sep 2023 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851916;
	bh=isFMv5J3rpOHLVDhhNbIoTnhkQjoG9ObXVsYmwnSTWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8Dujy+CQpnn20jOp4hfFCrL0YMWPTrkPx9UkZC0mGwmsD581rKr8waQDUEiJymJM
	 LF1FQ1gE9T6HbjfLot3zV+of7uE6E/pEmZ9eLTdV3CJ6W1rVeFDbNu9wEf4LCpNlUN
	 9apO353t7HkpmQ4zHf0TY1E4gYHIJZIEsqhGiSswJMKIOPKd4LQjrQZJ2kEVz/fGum
	 SSwFsmFnB3mPyjZ0tLDDCwkHJYnY4Kg3JRc7wNCEoCtMDPXd+lYmfHqHZ6V4IDfirS
	 D/heg3pY6tEx7VOuPsVmoSX4vsiblGAA9Wq9sKiQMW8/4qDX/ieAwK1znNJtQKn2ar
	 y9xudAthRcg6A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 12/23] net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
Date: Sat, 16 Sep 2023 15:58:18 +0800
Message-Id: <20230916075829.1560-13-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230916075829.1560-1-jszhang@kernel.org>
References: <20230916075829.1560-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the driver's probe() function by using the devres
variant of stmmac_probe_config_dt().

The remove_new() callback now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 55 ++++++-------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 0b159dc0d5f6..37f249980929 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -400,33 +400,27 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!dwmac)
+		return -ENOMEM;
 
 	dwmac->data = (const struct meson8b_dwmac_data *)
 		of_device_get_match_data(&pdev->dev);
-	if (!dwmac->data) {
-		ret = -EINVAL;
-		goto err_remove_config_dt;
-	}
+	if (!dwmac->data)
+		return -EINVAL;
 	dwmac->regs = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(dwmac->regs)) {
-		ret = PTR_ERR(dwmac->regs);
-		goto err_remove_config_dt;
-	}
+	if (IS_ERR(dwmac->regs))
+		return PTR_ERR(dwmac->regs);
 
 	dwmac->dev = &pdev->dev;
 	ret = of_get_phy_mode(pdev->dev.of_node, &dwmac->phy_mode);
 	if (ret) {
 		dev_err(&pdev->dev, "missing phy-mode property\n");
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	/* use 2ns as fallback since this value was previously hardcoded */
@@ -448,53 +442,40 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 		if (dwmac->rx_delay_ps > 3000 || dwmac->rx_delay_ps % 200) {
 			dev_err(dwmac->dev,
 				"The RGMII RX delay range is 0..3000ps in 200ps steps");
-			ret = -EINVAL;
-			goto err_remove_config_dt;
+			return -EINVAL;
 		}
 	} else {
 		if (dwmac->rx_delay_ps != 0 && dwmac->rx_delay_ps != 2000) {
 			dev_err(dwmac->dev,
 				"The only allowed RGMII RX delays values are: 0ps, 2000ps");
-			ret = -EINVAL;
-			goto err_remove_config_dt;
+			return -EINVAL;
 		}
 	}
 
 	dwmac->timing_adj_clk = devm_clk_get_optional(dwmac->dev,
 						      "timing-adjustment");
-	if (IS_ERR(dwmac->timing_adj_clk)) {
-		ret = PTR_ERR(dwmac->timing_adj_clk);
-		goto err_remove_config_dt;
-	}
+	if (IS_ERR(dwmac->timing_adj_clk))
+		return PTR_ERR(dwmac->timing_adj_clk);
 
 	ret = meson8b_init_rgmii_delays(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = meson8b_init_rgmii_tx_clk(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = dwmac->data->set_phy_mode(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = meson8b_init_prg_eth(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	plat_dat->bsp_priv = dwmac;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_remove_config_dt;
-
-	return 0;
-
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
-
-	return ret;
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
 static const struct meson8b_dwmac_data meson8b_dwmac_data = {
@@ -539,7 +520,7 @@ MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
 
 static struct platform_driver meson8b_dwmac_driver = {
 	.probe  = meson8b_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "meson8b-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1


