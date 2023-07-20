Return-Path: <netdev+bounces-19364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDE75A7B9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA711C2111B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA85171B0;
	Thu, 20 Jul 2023 07:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F2171A4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:23:58 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4D919A7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:23:57 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1qMO0I-00086j-7R; Thu, 20 Jul 2023 09:23:14 +0200
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
Cc: devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
Date: Thu, 20 Jul 2023 09:23:04 +0200
Message-Id: <20230720072304.3358701-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720072304.3358701-1-m.felsch@pengutronix.de>
References: <20230720072304.3358701-1-m.felsch@pengutronix.de>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add generic phy-supply handling support to control the phy regulator to
avoid handling it within the glue code. Use the generic stmmac_platform
code to register a possible phy-supply and the stmmac_main code to
handle the power on/off.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog
v3:
- rebased onto net-next/main
- fixed changelog style

v2:
- adapt stmmac_phy_power
- move power-on/off into stmmac_main to handle WOL
- adapt commit message

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 58 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 10 ++++
 include/linux/stmmac.h                        |  1 +
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e7ca52f0d2f2d..6ffb03abddfd9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -31,6 +31,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -1128,6 +1129,55 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 	}
 }
 
+/**
+ * stmmac_phy_power - PHY regulator on/off
+ * @priv: driver private structure
+ * @enable: turn on the regulator if true else turn it off
+ * Enable or disable the regulator powering the PHY.
+ */
+static int stmmac_phy_power(struct stmmac_priv *priv, bool enable)
+{
+	struct regulator *regulator = priv->plat->phy_regulator;
+	struct device *dev = priv->device;
+
+	if (!regulator)
+		return 0;
+
+	if (enable) {
+		int ret;
+
+		ret = regulator_enable(regulator);
+		if (ret)
+			dev_err(dev, "Fail to enable regulator\n");
+
+		return ret;
+	}
+
+	regulator_disable(regulator);
+
+	return 0;
+}
+
+/**
+ * stmmac_phy_power_on - PHY regulator on
+ * @priv: driver private structure
+ * Enable the PHY regulator
+ */
+static int stmmac_phy_power_on(struct stmmac_priv *priv)
+{
+	return stmmac_phy_power(priv, true);
+}
+
+/**
+ * stmmac_phy_power_off - PHY regulator off
+ * @priv: driver private structure
+ * Disable the PHY regulator
+ */
+static void stmmac_phy_power_off(struct stmmac_priv *priv)
+{
+	stmmac_phy_power(priv, false);
+}
+
 /**
  * stmmac_init_phy - PHY initialization
  * @dev: net device structure
@@ -1253,7 +1303,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		return PTR_ERR(phylink);
 
 	priv->phylink = phylink;
-	return 0;
+
+	return stmmac_phy_power_on(priv);
 }
 
 static void stmmac_display_rx_rings(struct stmmac_priv *priv,
@@ -7588,6 +7639,7 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
+	stmmac_phy_power_off(priv);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
@@ -7651,6 +7703,8 @@ int stmmac_suspend(struct device *dev)
 		if (device_may_wakeup(priv->device))
 			phylink_speed_down(priv->phylink, false);
 		phylink_suspend(priv->phylink, false);
+		if (!priv->plat->use_phy_wol)
+			stmmac_phy_power_off(priv);
 	}
 	rtnl_unlock();
 
@@ -7733,6 +7787,8 @@ int stmmac_resume(struct device *dev)
 		priv->irq_wake = 0;
 	} else {
 		pinctrl_pm_select_default_state(priv->device);
+		if (!priv->plat->use_phy_wol)
+			stmmac_phy_power_on(priv);
 		/* reset the phy so that it's ready */
 		if (priv->mii)
 			stmmac_mdio_reset(priv->mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 23d53ea04b24d..18988da4614cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -424,6 +425,15 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
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
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d04..b5d2d75de2759 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -222,6 +222,7 @@ struct plat_stmmacenet_data {
 	int phy_addr;
 	int interface;
 	phy_interface_t phy_interface;
+	struct regulator *phy_regulator;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
 	struct device_node *phylink_node;
-- 
2.39.2


