Return-Path: <netdev+bounces-31197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77578C2A7
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA01281065
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4821548E;
	Tue, 29 Aug 2023 10:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB711548D
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC1C433CA;
	Tue, 29 Aug 2023 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306381;
	bh=NfmMNorB1i8iTRlNbscAGy8iJ8mMIBVk/gLt8TbXCus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0Yd+txvCUqerxhQdKMHb0eC2/pdb1ARG/YXEdJxh7lPhf7WSIVfH/mp/FDnBT6H5
	 3vrpRt+lp8auapOTcS95cLi7kV8gW1zDrMoDnq7LKMtCblNlYgzC6JYhFrcL7M0Z1X
	 FPNa5ip4SNX4pq8V+phSXRpOSQE0BQJcXC7tg67+bTDJ8sNVX7ORo8M0ceLgrcN6Jv
	 Qmpr8sCk7f0/EIWqMpxfqcOlmveBkIA/NroYgYLIW0OLr1R/kPs/NP+wKpdngBHxoT
	 /HzsbhEV+JciUgc/9tRr731hXBrarWO9LIyYV+QiRDIDue+629780wOpQqzpRlWvAM
	 O1m+B6wPVY1og==
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
Subject: [PATCH net-next 05/22] net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
Date: Tue, 29 Aug 2023 18:40:16 +0800
Message-Id: <20230829104033.955-6-jszhang@kernel.org>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 535856fffaea..f4c817e9fc13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -331,15 +331,14 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data) {
 		dev_err(&pdev->dev, "failed to get match data\n");
-		ret = -EINVAL;
-		goto err_match_data;
+		return -EINVAL;
 	}
 
 	dwmac->ops = data;
@@ -348,7 +347,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	ret = imx_dwmac_parse_dt(dwmac, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse OF data\n");
-		goto err_parse_dt;
+		return ret;
 	}
 
 	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
@@ -365,7 +364,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 
 	ret = imx_dwmac_clks_config(dwmac, true);
 	if (ret)
-		goto err_clks_config;
+		return ret;
 
 	ret = imx_dwmac_init(pdev, dwmac);
 	if (ret)
@@ -385,10 +384,6 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	imx_dwmac_exit(pdev, plat_dat->bsp_priv);
 err_dwmac_init:
 	imx_dwmac_clks_config(dwmac, false);
-err_clks_config:
-err_parse_dt:
-err_match_data:
-	stmmac_remove_config_dt(pdev, plat_dat);
 	return ret;
 }
 
@@ -423,7 +418,7 @@ MODULE_DEVICE_TABLE(of, imx_dwmac_match);
 
 static struct platform_driver imx_dwmac_driver = {
 	.probe  = imx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "imx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1


