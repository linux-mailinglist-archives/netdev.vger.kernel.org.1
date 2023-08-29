Return-Path: <netdev+bounces-31195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27278C29F
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CE928103C
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1351548A;
	Tue, 29 Aug 2023 10:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A515481
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5E2C433C9;
	Tue, 29 Aug 2023 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306369;
	bh=R5nkuuiNFkrWBoIZMqvZG0C7QkTrSVA812AJPM93YC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJsu/I3d87cvHLK0Qgq+FtAhg4MTdzl3KQQ2FINF1VhorGE0SMH9XFIO3zlJvpvsa
	 IxrTWPp0pXrzu3s5EXKgFU2QxWW3G9LGqR7t7wKk1QgRo+ZO130xflrB7lto9iB9aa
	 d8HmMmgA5B/Irwo+1l3feOkwjXW9f3GhIlIxbUyJ2rw6+k/4nJdNXhszgGs8k7Edy/
	 2n6N/9DaRQih16aotIDSDnTn5t2uAFk0MUI5wu0rrTg+9l0R7d/B3MCehS71dZMI5z
	 5LAs+uKq3Q8wEY6000Q7lO4uMAbjnTY7nRP8kRwcVbuiZUNWvuzmYEELEu9pNxjkkK
	 aXXMJx7SVFgpA==
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
Subject: [PATCH net-next 03/22] net: stmmac: dwmac-generic: use devm_stmmac_probe_config_dt()
Date: Tue, 29 Aug 2023 18:40:14 +0800
Message-Id: <20230829104033.955-4-jszhang@kernel.org>
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
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c  | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index 20fc455b3337..84582fc04d2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -27,7 +27,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 		return ret;
 
 	if (pdev->dev.of_node) {
-		plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+		plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 		if (IS_ERR(plat_dat)) {
 			dev_err(&pdev->dev, "dt configuration failed\n");
 			return PTR_ERR(plat_dat);
@@ -46,17 +46,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 		plat_dat->unicast_filter_entries = 1;
 	}
 
-	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_remove_config_dt;
-
-	return 0;
-
-err_remove_config_dt:
-	if (pdev->dev.of_node)
-		stmmac_remove_config_dt(pdev, plat_dat);
-
-	return ret;
+	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id dwmac_generic_match[] = {
@@ -77,7 +67,7 @@ MODULE_DEVICE_TABLE(of, dwmac_generic_match);
 
 static struct platform_driver dwmac_generic_driver = {
 	.probe  = dwmac_generic_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = STMMAC_RESOURCE_NAME,
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1


