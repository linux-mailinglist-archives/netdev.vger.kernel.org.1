Return-Path: <netdev+bounces-34250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E97A2ECD
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823E9282248
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687413AC7;
	Sat, 16 Sep 2023 08:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D1111B8;
	Sat, 16 Sep 2023 08:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E48DC433CA;
	Sat, 16 Sep 2023 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851967;
	bh=YIjtmUbVrg/RXcc1/xGF0odjZwPY+o3yQzwT12xvMT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ih3jhFek7Im/uNs9x+ian0b7ZipqTfZA29fQeyQ0M/r4MkwvWGCVgx/iFYivQs/xz
	 AIGGMW/YQ0RUlDqjdl7TSesFoSkgf0nud823dgrt0fyF16nrxFEa/+aUiHkwUzxU8E
	 DBFm8s9CiCMbiNrJtUAbx61Xo0Rp1bA8N/cWlsKGbz6drGc/M9tectoq9B3yeZ7osH
	 dB8bQvYXgi6Jj0osY7yn8ZEw4rZG6OWI8TlZnSpkQ2TisGhd2YHqz1SdaK+K7RbmDG
	 w1nfDAmwC+TDgh8NUHA32q6NcujKPO2jW6z2W/QrqkjEZWXD/MldrB0ASbVoZnHnFI
	 U5MxpToJREWdg==
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
Subject: [PATCH net-next v2 19/23] net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
Date: Sat, 16 Sep 2023 15:58:25 +0800
Message-Id: <20230916075829.1560-20-jszhang@kernel.org>
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
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index beceeae579bf..b857235f5b1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -108,36 +108,31 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	gmac = devm_kzalloc(dev, sizeof(*gmac), GFP_KERNEL);
-	if (!gmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!gmac)
+		return -ENOMEM;
 
 	ret = of_get_phy_mode(dev->of_node, &gmac->interface);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Can't get phy-mode\n");
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	gmac->tx_clk = devm_clk_get(dev, "allwinner_gmac_tx");
 	if (IS_ERR(gmac->tx_clk)) {
 		dev_err(dev, "could not get tx clock\n");
-		ret = PTR_ERR(gmac->tx_clk);
-		goto err_remove_config_dt;
+		return PTR_ERR(gmac->tx_clk);
 	}
 
 	/* Optional regulator for PHY */
 	gmac->regulator = devm_regulator_get_optional(dev, "phy");
 	if (IS_ERR(gmac->regulator)) {
-		if (PTR_ERR(gmac->regulator) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto err_remove_config_dt;
-		}
+		if (PTR_ERR(gmac->regulator) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "no regulator found\n");
 		gmac->regulator = NULL;
 	}
@@ -155,7 +150,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 
 	ret = sun7i_gmac_init(pdev, plat_dat->bsp_priv);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -165,8 +160,6 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 
 err_gmac_exit:
 	sun7i_gmac_exit(pdev, plat_dat->bsp_priv);
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
@@ -179,7 +172,7 @@ MODULE_DEVICE_TABLE(of, sun7i_dwmac_match);
 
 static struct platform_driver sun7i_dwmac_driver = {
 	.probe  = sun7i_gmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "sun7i-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1


