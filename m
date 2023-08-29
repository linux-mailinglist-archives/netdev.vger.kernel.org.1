Return-Path: <netdev+bounces-31207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1E078C2CA
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094E628110F
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7D154B4;
	Tue, 29 Aug 2023 10:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1015AE0
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B9FC433CB;
	Tue, 29 Aug 2023 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306449;
	bh=55LOh8Jj1l92AMhvY++Ej5I2LE8fPAWDd+oTYSYLd1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCoG3BdllVlhL465cTgrGCXeB1eh6gBb4bx4nyLW3doaI69uN1mDB63MVEOZfnDVw
	 Acddc/LoC3BCLG9B/hQRYa1JiAVWBGUH3F2Wfk52DRFZwWJePzZ9TQwP1pag1oMznZ
	 pZWhyivSlSE5x99KbWCeg9lvXnvnN0WVbjiAlwTlyyX1hvO+7vFFDSc+1oXBS/VSxZ
	 0bztUrpaiJJ9EQnKxHzOhe7L+SOJp8MgFHPUHKiy7vP64vfPfnOFh7I1hQ5qNrp31Q
	 Yx5dPxIor8s7n/u78Bd641UpuOCqOD0vhW62qxC/vEOkcpxUtaZJb17Dm1PzMP3EaQ
	 wnwmw3FmNxywQ==
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
Subject: [PATCH net-next 15/22] net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
Date: Tue, 29 Aug 2023 18:40:26 +0800
Message-Id: <20230829104033.955-16-jszhang@kernel.org>
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

The remove_new() callback now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 892612564694..76f3a36f32c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -105,7 +105,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to get resources\n");
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
@@ -141,13 +141,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (err) {
-		stmmac_remove_config_dt(pdev, plat_dat);
-		return err;
-	}
-
-	return 0;
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id starfive_dwmac_match[] = {
@@ -158,7 +152,7 @@ MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
 
 static struct platform_driver starfive_dwmac_driver = {
 	.probe  = starfive_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name = "starfive-dwmac",
 		.pm = &stmmac_pltfr_pm_ops,
-- 
2.40.1


