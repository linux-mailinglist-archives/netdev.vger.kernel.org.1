Return-Path: <netdev+bounces-31212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D661278C2CF
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ACD1C20A32
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C53156C4;
	Tue, 29 Aug 2023 10:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4316403
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A528C433CA;
	Tue, 29 Aug 2023 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306485;
	bh=KSe7NuuTmvNFUfkVlgyIp0m+TWXLJzpYZqE/n8ra5Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTPGxZCuLLZc4QW8EWFJFFrdXXOk/U9oGCOR1rpE3WRlVOfOzEifOgkFsWv4EeGYt
	 hSoz/kU4u/35xdFnqiB0BpgZkjKY5Z1guaquCeN2iReO7Qu+FRBtflMtLYC1AQOlHp
	 GH/b0kMQ33KhTgZ1SzDxdrOkKlcYHVw7whbFkPl2BzqGOeetv0pYGQ3+jof+6/IQuA
	 wvbZSg3Di65UmAWOJHw6RnnTjtqcW+kS5fBBKtXQ8HQRfy0fUnpvKFQLXz7nkg+O0r
	 iwu2xgsG5Lbac7cX5de82QoNr//2h1tU2XfDGYkU3Y+JIhf/5aPWZ1gJcUeGwpXw1X
	 Ut+mu5MorOOxQ==
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
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 20/22] net: stmmac: dwmac-tegra: use devm_stmmac_probe_config_dt()
Date: Tue, 29 Aug 2023 18:40:31 +0800
Message-Id: <20230829104033.955-21-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230829104033.955-1-jszhang@kernel.org>
References: <20230829104033.955-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the driver's probe() function by using the devres
variant of stmmac_probe_config_dt().

The calling of stmmac_pltfr_remove() now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index e0f3cbd36852..7e512c0762ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -284,7 +284,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_clks;
 
-	plat = stmmac_probe_config_dt(pdev, res.mac);
+	plat = devm_stmmac_probe_config_dt(pdev, res.mac);
 	if (IS_ERR(plat)) {
 		err = PTR_ERR(plat);
 		goto disable_clks;
@@ -303,7 +303,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 						   GFP_KERNEL);
 		if (!plat->mdio_bus_data) {
 			err = -ENOMEM;
-			goto remove;
+			goto disable_clks;
 		}
 	}
 
@@ -321,7 +321,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 				 500, 500 * 2000);
 	if (err < 0) {
 		dev_err(mgbe->dev, "timeout waiting for TX lane to become enabled\n");
-		goto remove;
+		goto disable_clks;
 	}
 
 	plat->serdes_powerup = mgbe_uphy_lane_bringup_serdes_up;
@@ -342,12 +342,10 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 
 	err = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (err < 0)
-		goto remove;
+		goto disable_clks;
 
 	return 0;
 
-remove:
-	stmmac_remove_config_dt(pdev, plat);
 disable_clks:
 	clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
 
@@ -360,7 +358,7 @@ static void tegra_mgbe_remove(struct platform_device *pdev)
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
 
-	stmmac_pltfr_remove(pdev);
+	stmmac_pltfr_remove_no_dt(pdev);
 }
 
 static const struct of_device_id tegra_mgbe_match[] = {
-- 
2.40.1


