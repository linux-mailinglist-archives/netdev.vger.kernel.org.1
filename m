Return-Path: <netdev+bounces-34252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145387A2ED1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354621C20A46
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD211C8E;
	Sat, 16 Sep 2023 08:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D013FED;
	Sat, 16 Sep 2023 08:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF32C433CC;
	Sat, 16 Sep 2023 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851980;
	bh=Vn4X1L24g5YyN7wIK/5umFerdTWl1xsiC5BXRJlo0ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9HcqfTQBB5HNBS5CaxsZ9ATh339mrairARWQy/+9ekCD43XOyoPlsXz+SMZjx7k9
	 ocb+OAj3EzdtjZn/KPBJhVsDwXga1309k6T+xbV2vZdZRhiu3xPJs7ZVNXOs3L0ICA
	 n/k1kTPyhSXQc1gAJP6+YD0ZoGYie/fuAfxkL4tKF4m169q5/rYDUwtgr/7B7a5bLH
	 pEdVVqmKbWEW4H+pvTRL9UlOIpcy+S9MoQWNZCA+j3au9cSPs7KVQsE47dNIvRJKCF
	 huSA+CNTG+zuFTMKrei+TGDDMd1mgTOZRcF7dmfkbtotuHtMPQe9J9xX0udXRt/V9H
	 snKFQjeUi+UvQ==
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
Subject: [PATCH net-next v2 21/23] net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
Date: Sat, 16 Sep 2023 15:58:27 +0800
Message-Id: <20230916075829.1560-22-jszhang@kernel.org>
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
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index 22d113fb8e09..45f5d66a11c2 100644
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
 
@@ -252,22 +250,15 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 
 remove:
 	visconti_eth_clock_remove(pdev);
-remove_config:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
 
 static void visconti_eth_dwmac_remove(struct platform_device *pdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	stmmac_pltfr_remove(pdev);
+	stmmac_pltfr_remove_no_dt(pdev);
 
 	visconti_eth_clock_remove(pdev);
-
-	stmmac_remove_config_dt(pdev, priv->plat);
 }
 
 static const struct of_device_id visconti_eth_dwmac_match[] = {
-- 
2.40.1


