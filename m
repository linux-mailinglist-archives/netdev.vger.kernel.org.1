Return-Path: <netdev+bounces-31205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA278C2C6
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B64A1C209E3
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD615487;
	Tue, 29 Aug 2023 10:53:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E615AC4
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D4AC433CD;
	Tue, 29 Aug 2023 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306436;
	bh=QnUj2UcWjwSt/r3IooG168fCs/+hvc8TMJRfrlPuAhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQCzh2+e4WTaPurAbAgzEWpY0F8UbACCyXNLDJBGaVZL2XMn+LmO9shCkYByhHwyA
	 SadFDfH8WTWWsSYk5GvHFznBBETXmXUgfQYRZBUPGN/IoYvzreR2TIgT3NLMpsyzst
	 j+kjIMILuNR18DML5bPnW6NpBjWN3bNYuuk4Edvt32xU2jxwVbyPclul02sp56Y40x
	 eRTFgFFB0+tEyyiboGANNnYPa1SQIWyLydltIQT9gWbKUazV8ukHbuftuoudUVHOMq
	 EjR1rkfRh9n+i3t+zbjQsZGoodK8qLuR/9QurjoO7/x5IxOS2J3JyEGzHnO6glhVJX
	 E7wQzuz6Ee+WA==
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
Subject: [PATCH net-next 13/22] net: stmmac: dwmac-rk: use devm_stmmac_probe_config_dt()
Date: Tue, 29 Aug 2023 18:40:24 +0800
Message-Id: <20230829104033.955-14-jszhang@kernel.org>
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

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d920a50dd16c..382e8de1255d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1824,7 +1824,7 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
@@ -1836,18 +1836,16 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = rk_fix_speed;
 
 	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
-	if (IS_ERR(plat_dat->bsp_priv)) {
-		ret = PTR_ERR(plat_dat->bsp_priv);
-		goto err_remove_config_dt;
-	}
+	if (IS_ERR(plat_dat->bsp_priv))
+		return PTR_ERR(plat_dat->bsp_priv);
 
 	ret = rk_gmac_clk_init(plat_dat);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = rk_gmac_powerup(plat_dat->bsp_priv);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -1857,8 +1855,6 @@ static int rk_gmac_probe(struct platform_device *pdev)
 
 err_gmac_powerdown:
 	rk_gmac_powerdown(plat_dat->bsp_priv);
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
-- 
2.40.1


