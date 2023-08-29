Return-Path: <netdev+bounces-31213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F98C78C2D4
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F5B2810FD
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A86156C7;
	Tue, 29 Aug 2023 10:54:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF716403
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC32AC433C8;
	Tue, 29 Aug 2023 10:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306492;
	bh=xaX/1pgdUp6jF0eAGOIu3QPf4VByZDmH71/iKbXHLBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilhXRwxhYHCwcTM0jfOnU1+PAELTaALR5BuUY5pkvJ41r8pdlesyGZZf8+8ntDxF0
	 S8Q9NUnqQyJvAE4afUKQrCRbe+E2xtKbpPgnTRbbiJrsq92illV9gNdd4z05zUBKQK
	 P3HJHlvNUw7trN6hsLTXDzRkNaEuJ/hjWK2xQSuKhQv0xiDk5jfWkTLU7cPgo2NNwd
	 mMjnyLPFyNBCkN97M5l8v619Csd77VWjb8UYiORhIdson+Ikj8+Gbo8QhJgDdXoMbC
	 824HRqoFSSIc8Uo7miNP9ZCxiRu923uCjqSdU4H5LropysJyVR+ddB48nxzGjNy4N6
	 lhfRBoYBgx6Jw==
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
Subject: [PATCH net-next 21/22] net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
Date: Tue, 29 Aug 2023 18:40:32 +0800
Message-Id: <20230829104033.955-22-jszhang@kernel.org>
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
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index 22d113fb8e09..75fafd23385a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -220,15 +220,13 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac) {
-		ret = -ENOMEM;
-		goto remove_config;
-	}
+	if (!dwmac)
+		return -ENOMEM;
 
 	spin_lock_init(&dwmac->lock);
 	dwmac->reg = stmmac_res.addr;
@@ -238,7 +236,7 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 
 	ret = visconti_eth_clock_probe(pdev, plat_dat);
 	if (ret)
-		goto remove_config;
+		return ret;
 
 	visconti_eth_init_hw(pdev, plat_dat);
 
@@ -252,8 +250,6 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 
 remove:
 	visconti_eth_clock_remove(pdev);
-remove_config:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
@@ -263,7 +259,7 @@ static void visconti_eth_dwmac_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
-	stmmac_pltfr_remove(pdev);
+	stmmac_pltfr_remove_no_dt(pdev);
 
 	visconti_eth_clock_remove(pdev);
 
-- 
2.40.1


