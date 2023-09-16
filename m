Return-Path: <netdev+bounces-34245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936AD7A2EC6
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD9928225F
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A3125DC;
	Sat, 16 Sep 2023 08:12:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8E134D1;
	Sat, 16 Sep 2023 08:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181DEC433CA;
	Sat, 16 Sep 2023 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851930;
	bh=YmboYqxdl0thrb4XWc4/zOz9FdEZLOtHhduc2bzg0Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZXk0eNYb/PX8/VUpZLIpmpUyHghY9JkGOmkOQq4oex1qaTWzWTbh4CVhx8JL0ztd
	 MYBLv4UQl9YWiUD5jZ3imMF+HXiLMcOsNcyhneSkJ/N6vt5Qu8X6vThjoBJG8um1ws
	 Qm15l03Pf/vgCCrS/YEDQUUJvozNrH2yJ0gZ6wpq3mFVIn8eD6e/RGkeagXWtrvae3
	 cbmdFZZQMwxWNUD8UmURuFl4vynpHNUOmu3heWKe8P+Nd/ylIsFJBF6CImPZM5Dac2
	 B5Kt+V7Orb2W2Fj2eiwINdednf2ACJvvMhnJP1OkQttjH1QHjW1hsrk4RUkb8Kw8ZW
	 UgewWneZ5Qj1g==
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
Subject: [PATCH net-next v2 14/23] net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
Date: Sat, 16 Sep 2023 15:58:20 +0800
Message-Id: <20230916075829.1560-15-jszhang@kernel.org>
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

The calling of stmmac_pltfr_remove() now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c    | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 9bf102bbc6a0..03e7701d0186 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -400,21 +400,19 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	dwmac = devm_kzalloc(dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!dwmac)
+		return -ENOMEM;
 
 	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
 	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
 		ret = PTR_ERR(dwmac->stmmac_ocp_rst);
 		dev_err(dev, "error getting reset control of ocp %d\n", ret);
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
@@ -422,7 +420,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	ret = socfpga_dwmac_parse_data(dwmac, dev);
 	if (ret) {
 		dev_err(dev, "Unable to parse OF data\n");
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	dwmac->ops = ops;
@@ -431,7 +429,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ndev = platform_get_drvdata(pdev);
 	stpriv = netdev_priv(ndev);
@@ -492,8 +490,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 err_dvr_remove:
 	stmmac_dvr_remove(&pdev->dev);
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
@@ -504,7 +500,7 @@ static void socfpga_dwmac_remove(struct platform_device *pdev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct phylink_pcs *pcs = priv->hw->lynx_pcs;
 
-	stmmac_pltfr_remove(pdev);
+	stmmac_pltfr_remove_no_dt(pdev);
 
 	lynx_pcs_destroy(pcs);
 }
-- 
2.40.1


