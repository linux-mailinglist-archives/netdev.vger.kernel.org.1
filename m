Return-Path: <netdev+bounces-34246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D717A2EC7
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA322281AFC
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707CF134A3;
	Sat, 16 Sep 2023 08:12:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BD10965;
	Sat, 16 Sep 2023 08:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7670C433CC;
	Sat, 16 Sep 2023 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851938;
	bh=DKEvP3IapJYTsAbn033GPqYVOiEf5sbsPE67h+G6Mqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMur2taxkAcQGcr/Nn3XDMCGpecz6RS6VoYgg4Deagg84YSPeo41Gc2Uo0fLn6xpf
	 9z8sC4/VNHpCivd2zB8pqggwYd911uKpf/cVt1Jsy3D4uHqD3ytevG8b/Y1fx4qeXw
	 qhnaDvpQ4UwUegJ28+CSRnvj+OeDVr09S8QVRp1vflARUU7EF0lID3UG+H40XOKmQD
	 NolZtcM9MDO0mTRW0TXg4yyTQTZWQ5ggFJLLnAoUb7sBY8Pwhf514q3GE0AlIvExqc
	 xuSo68Ee7mxPoSmn0seGpVJBQfm8wafAEOoU4/FupoAGuAsFvQybj4Wt6r7KE7uMuf
	 zRx2TMsWJBJAw==
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
Subject: [PATCH net-next v2 15/23] net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
Date: Sat, 16 Sep 2023 15:58:21 +0800
Message-Id: <20230916075829.1560-16-jszhang@kernel.org>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 9289bb87c3e3..e87b4d335c72 100644
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


