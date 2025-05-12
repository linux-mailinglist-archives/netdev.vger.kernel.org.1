Return-Path: <netdev+bounces-189810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF736AB3D21
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BD219E45F0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964E253357;
	Mon, 12 May 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nc+Bgtwy"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB923535A
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066261; cv=none; b=AIErf5Wlff721noIKMQZSQ6HlXaUPjcony8jOPi5X9mq3GtgXDvcjsUZhhSci7vWugEJGzv0WWX+QxNOtRWQQZQa5ulCSSxaGNLih/bbYjM/wlz+0olcZnty1210Z1pl8vqvtJAGPOxHkdBEdVcYSRdXVUU6sjFFNVvsH3/tpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066261; c=relaxed/simple;
	bh=pQYMjoP8KLLBE4iI8UXsfZzxIWrzo2b+3EVxDRWtCZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQvTD9Dhx62yZmYWkyjBslmM6LYspnJncl96cdXPYQq67tSWZ2FwKi9xOlnfQegZ5eG63U1VpbmPSUTwKkmdLlP5SbTsnWMIYOLpIhQ04+wsQrokgk0l4qvISOI6PxsUX5Od3zWsOf1OOynfZiLBpgkeMdn8iPO6Xp1plD/XteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nc+Bgtwy; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747066256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeW99aUNrHsV5YdlA6peeJca2dzX7zAprTdpjPgwrXI=;
	b=nc+BgtwyD6WUgjTq34FU4v/XUT/gd7S2C2uHg8VfuGm06cKvltiF4+3XfZ8cow0VT7XEdb
	Jo7WyqIoOQ/WdQsEzvn/aUjWAEE1E5PwbueKzGmk+Fzh6RgcSJbCS6qX2YnCT44f3m9uL5
	FnDOHRNG9wlI2b1Gpgc8P5EYkoWKXW8=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [net-next PATCH v4 08/11] net: axienet: Convert to use PCS subsystem
Date: Mon, 12 May 2025 12:10:10 -0400
Message-Id: <20250512161013.731955-9-sean.anderson@linux.dev>
In-Reply-To: <20250512161013.731955-1-sean.anderson@linux.dev>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert the AXI Ethernet driver to use the PCS subsystem, including the
new Xilinx PCA/PMA driver. Unfortunately, we must use a helper to work
with bare MDIO nodes without a compatible.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
Tested-by: Suraj Gupta <suraj.gupta2@amd.com>

---

Changes in v4:
- Convert to dev-less pcs_put

Changes in v3:
- Select PCS_XILINX unconditionally

 drivers/net/ethernet/xilinx/Kconfig           |   7 ++
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   4 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 104 ++++--------------
 drivers/net/pcs/pcs-xilinx.c                  |   9 +-
 4 files changed, 31 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 7502214cc7d5..9f130376e1eb 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -25,8 +25,15 @@ config XILINX_EMACLITE
 
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
+	depends on COMMON_CLK
+	depends on GPIOLIB
 	depends on HAS_IOMEM
+	depends on OF
+	depends on PCS
 	depends on XILINX_DMA
+	select MDIO_DEVICE
+	select OF_DYNAMIC
+	select PCS_XILINX
 	select PHYLINK
 	select DIMLIB
 	help
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..f46e862245eb 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -473,7 +473,6 @@ struct skbuf_dma_descriptor {
  * @dev:	Pointer to device structure
  * @phylink:	Pointer to phylink instance
  * @phylink_config: phylink configuration settings
- * @pcs_phy:	Reference to PCS/PMA PHY if used
  * @pcs:	phylink pcs structure for PCS PHY
  * @switch_x_sgmii: Whether switchable 1000BaseX/SGMII mode is enabled in the core
  * @axi_clk:	AXI4-Lite bus clock
@@ -553,8 +552,7 @@ struct axienet_local {
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
 
-	struct mdio_device *pcs_phy;
-	struct phylink_pcs pcs;
+	struct phylink_pcs *pcs;
 
 	bool switch_x_sgmii;
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 054abf283ab3..9490ecb6fa43 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -35,6 +35,8 @@
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 #include <linux/math64.h>
+#include <linux/pcs.h>
+#include <linux/pcs-xilinx.h>
 #include <linux/phy.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
@@ -2519,63 +2521,6 @@ static const struct ethtool_ops axienet_ethtool_ops = {
 	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
 };
 
-static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
-{
-	return container_of(pcs, struct axienet_local, pcs);
-}
-
-static void axienet_pcs_get_state(struct phylink_pcs *pcs,
-				  unsigned int neg_mode,
-				  struct phylink_link_state *state)
-{
-	struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
-
-	phylink_mii_c22_pcs_get_state(pcs_phy, neg_mode, state);
-}
-
-static void axienet_pcs_an_restart(struct phylink_pcs *pcs)
-{
-	struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
-
-	phylink_mii_c22_pcs_an_restart(pcs_phy);
-}
-
-static int axienet_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
-			      phy_interface_t interface,
-			      const unsigned long *advertising,
-			      bool permit_pause_to_mac)
-{
-	struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
-	struct net_device *ndev = pcs_to_axienet_local(pcs)->ndev;
-	struct axienet_local *lp = netdev_priv(ndev);
-	int ret;
-
-	if (lp->switch_x_sgmii) {
-		ret = mdiodev_write(pcs_phy, XLNX_MII_STD_SELECT_REG,
-				    interface == PHY_INTERFACE_MODE_SGMII ?
-					XLNX_MII_STD_SELECT_SGMII : 0);
-		if (ret < 0) {
-			netdev_warn(ndev,
-				    "Failed to switch PHY interface: %d\n",
-				    ret);
-			return ret;
-		}
-	}
-
-	ret = phylink_mii_c22_pcs_config(pcs_phy, interface, advertising,
-					 neg_mode);
-	if (ret < 0)
-		netdev_warn(ndev, "Failed to configure PCS: %d\n", ret);
-
-	return ret;
-}
-
-static const struct phylink_pcs_ops axienet_pcs_ops = {
-	.pcs_get_state = axienet_pcs_get_state,
-	.pcs_config = axienet_pcs_config,
-	.pcs_an_restart = axienet_pcs_an_restart,
-};
-
 static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 						  phy_interface_t interface)
 {
@@ -2583,8 +2528,8 @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
-	    interface ==  PHY_INTERFACE_MODE_SGMII)
-		return &lp->pcs;
+	    interface == PHY_INTERFACE_MODE_SGMII)
+		return lp->pcs;
 
 	return NULL;
 }
@@ -3056,28 +3001,23 @@ static int axienet_probe(struct platform_device *pdev)
 
 	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
 	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
-		np = of_parse_phandle(pdev->dev.of_node, "pcs-handle", 0);
-		if (!np) {
-			/* Deprecated: Always use "pcs-handle" for pcs_phy.
-			 * Falling back to "phy-handle" here is only for
-			 * backward compatibility with old device trees.
-			 */
-			np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
-		}
-		if (!np) {
-			dev_err(&pdev->dev, "pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
-			ret = -EINVAL;
-			goto cleanup_mdio;
-		}
-		lp->pcs_phy = of_mdio_find_device(np);
-		if (!lp->pcs_phy) {
-			ret = -EPROBE_DEFER;
-			of_node_put(np);
+		DECLARE_PHY_INTERFACE_MASK(interfaces);
+
+		phy_interface_zero(interfaces);
+		if (lp->switch_x_sgmii ||
+		    lp->phy_mode == PHY_INTERFACE_MODE_SGMII)
+			__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
+		if (lp->switch_x_sgmii ||
+		    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX)
+			__set_bit(PHY_INTERFACE_MODE_1000BASEX, interfaces);
+
+		lp->pcs = axienet_xilinx_pcs_get(&pdev->dev, interfaces);
+		if (IS_ERR(lp->pcs)) {
+			ret = PTR_ERR(lp->pcs);
+			dev_err_probe(&pdev->dev, ret,
+				      "could not get PCS for 1000BASE-X/SGMII\n");
 			goto cleanup_mdio;
 		}
-		of_node_put(np);
-		lp->pcs.ops = &axienet_pcs_ops;
-		lp->pcs.poll = true;
 	}
 
 	lp->phylink_config.dev = &ndev->dev;
@@ -3115,8 +3055,6 @@ static int axienet_probe(struct platform_device *pdev)
 	phylink_destroy(lp->phylink);
 
 cleanup_mdio:
-	if (lp->pcs_phy)
-		put_device(&lp->pcs_phy->dev);
 	if (lp->mii_bus)
 		axienet_mdio_teardown(lp);
 cleanup_clk:
@@ -3139,9 +3077,7 @@ static void axienet_remove(struct platform_device *pdev)
 	if (lp->phylink)
 		phylink_destroy(lp->phylink);
 
-	if (lp->pcs_phy)
-		put_device(&lp->pcs_phy->dev);
-
+	pcs_put(lp->pcs);
 	axienet_mdio_teardown(lp);
 
 	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
diff --git a/drivers/net/pcs/pcs-xilinx.c b/drivers/net/pcs/pcs-xilinx.c
index cc42e2a22cd2..6405949c1a75 100644
--- a/drivers/net/pcs/pcs-xilinx.c
+++ b/drivers/net/pcs/pcs-xilinx.c
@@ -354,10 +354,8 @@ static int xilinx_pcs_probe(struct mdio_device *mdiodev)
 
 	/* Sanity check */
 	ret = get_phy_c22_id(mdiodev->bus, mdiodev->addr, &phy_id);
-	if (ret) {
-		dev_err_probe(dev, ret, "could not read id\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not read id\n");
 	if ((phy_id & 0xfffffff0) != 0x01740c00)
 		dev_warn(dev, "unknown phy id %x\n", phy_id);
 
@@ -448,8 +446,7 @@ static int axienet_xilinx_pcs_fixup(struct of_changeset *ocs,
 	if (ret)
 		return ret;
 
-	return of_changeset_add_prop_string(ocs, np, "compatible",
-					    "xlnx,pcs");
+	return of_changeset_add_prop_string(ocs, np, "compatible", "xlnx,pcs");
 #else
 	return -ENODEV;
 #endif
-- 
2.35.1.1320.gc452695387.dirty


