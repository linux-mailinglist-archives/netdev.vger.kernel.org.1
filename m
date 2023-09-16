Return-Path: <netdev+bounces-34232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0E7A2E8C
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6A128219C
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971BC10965;
	Sat, 16 Sep 2023 08:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8D11731;
	Sat, 16 Sep 2023 08:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F3C433CA;
	Sat, 16 Sep 2023 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851838;
	bh=OTXCsvCc3TTe8yvZj3iGweMMXsRHTGyqZXpD3RGqgpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMhh2lw+vln8G8IB4k3d/8NLqMICTmGuIlEbqSsPIXpB0PtK9WqdngXbHvulXIV/V
	 SuIXWXvhdOSgrmZ+wbGqqdWBNFE6CgSxXY12CuSjN0MsiWtN/2mesoPvfNzpUEXRw4
	 po6sbI5W3IXMUbUQPIuKC/LTSob9SbBb5UUbYQCI06EGOKz5unKAp3g7FEW91/jzbX
	 TVApQIZCoO3FhNksOmH1RcGK8zqZO4QREXQwT9B6B5uTSyOIOXYfzASwtqoegVeAz7
	 EAnAmlNNMMdQgn42fHz3p2bDykIJO4MUV/LCQ0xtqSqvOfskWulUHjGdJoXg3eK5gV
	 0jMjLsQP3eTTA==
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
Subject: [PATCH net-next v2 01/23] net: stmmac: dwmac-anarion: use devm_stmmac_probe_config_dt()
Date: Sat, 16 Sep 2023 15:58:07 +0800
Message-Id: <20230916075829.1560-2-jszhang@kernel.org>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 58a7f08e8d78..0df3a2ad0986 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -115,7 +115,7 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(gmac))
 		return PTR_ERR(gmac);
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
@@ -124,13 +124,7 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
 	anarion_gmac_init(pdev, gmac);
 	plat_dat->bsp_priv = gmac;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret) {
-		stmmac_remove_config_dt(pdev, plat_dat);
-		return ret;
-	}
-
-	return 0;
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id anarion_dwmac_match[] = {
@@ -141,7 +135,7 @@ MODULE_DEVICE_TABLE(of, anarion_dwmac_match);
 
 static struct platform_driver anarion_dwmac_driver = {
 	.probe  = anarion_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "anarion-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1


