Return-Path: <netdev+bounces-18358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8075696B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4F281191
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1B253A3;
	Mon, 17 Jul 2023 16:43:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA715D0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:43:36 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFD10D8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:43:34 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1qLRJd-0004l0-Sf; Mon, 17 Jul 2023 18:43:17 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 2/2] net: stmmac: platform: add support for phy-supply
Date: Mon, 17 Jul 2023 18:43:07 +0200
Message-Id: <20230717164307.2868264-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717164307.2868264-1-m.felsch@pengutronix.de>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add generic phy-supply handling support to control the phy regulator.
Use the common stmmac_platform code path so all drivers using
stmmac_probe_config_dt() and stmmac_pltfr_pm_ops can use it.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 51 +++++++++++++++++++
 include/linux/stmmac.h                        |  1 +
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index eb0b2898daa3d..6193d42b53fb7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -10,6 +10,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -423,6 +424,15 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (plat->interface < 0)
 		plat->interface = plat->phy_interface;
 
+	/* Optional regulator for PHY */
+	plat->phy_regulator = devm_regulator_get_optional(&pdev->dev, "phy");
+	if (IS_ERR(plat->phy_regulator)) {
+		if (PTR_ERR(plat->phy_regulator) == -EPROBE_DEFER)
+			return ERR_CAST(plat->phy_regulator);
+		dev_info(&pdev->dev, "No regulator found\n");
+		plat->phy_regulator = NULL;
+	}
+
 	/* Some wrapper drivers still rely on phy_node. Let's save it while
 	 * they are not converted to phylink. */
 	plat->phy_node = of_parse_phandle(np, "phy-handle", 0);
@@ -659,6 +669,38 @@ void stmmac_remove_config_dt(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 
+static int stmmac_phy_power(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat,
+			    bool enable)
+{
+	struct regulator *regulator = plat->phy_regulator;
+	int ret = 0;
+
+	if (regulator) {
+		if (enable)
+			ret = regulator_enable(regulator);
+		else
+			regulator_disable(regulator);
+	}
+
+	if (ret)
+		dev_err(&pdev->dev, "Fail to enable regulator\n");
+
+	return ret;
+}
+
+static int stmmac_phy_power_on(struct platform_device *pdev,
+			       struct plat_stmmacenet_data *plat)
+{
+	return stmmac_phy_power(pdev, plat, true);
+}
+
+static void stmmac_phy_power_off(struct platform_device *pdev,
+				 struct plat_stmmacenet_data *plat)
+{
+	stmmac_phy_power(pdev, plat, false);
+}
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
@@ -720,6 +762,8 @@ int stmmac_pltfr_remove(struct platform_device *pdev)
 
 	stmmac_remove_config_dt(pdev, plat);
 
+	stmmac_phy_power_off(pdev, plat);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
@@ -742,6 +786,8 @@ static int __maybe_unused stmmac_pltfr_suspend(struct device *dev)
 	if (priv->plat->exit)
 		priv->plat->exit(pdev, priv->plat->bsp_priv);
 
+	stmmac_phy_power_off(pdev, priv->plat);
+
 	return ret;
 }
 
@@ -757,6 +803,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
+
+	ret = stmmac_phy_power_on(pdev, priv->plat);
+	if (ret)
+		return ret;
 
 	if (priv->plat->init)
 		priv->plat->init(pdev, priv->plat->bsp_priv);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 225751a8fd8e3..456bab4a3b362 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -209,6 +209,7 @@ struct plat_stmmacenet_data {
 	int phy_addr;
 	int interface;
 	phy_interface_t phy_interface;
+	struct regulator *phy_regulator;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
 	struct device_node *phylink_node;
-- 
2.39.2


