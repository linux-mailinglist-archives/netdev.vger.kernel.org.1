Return-Path: <netdev+bounces-196374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C76AD46C5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99853A7FC7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE729B21D;
	Tue, 10 Jun 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Un2uyUnu"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD0298277
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598327; cv=none; b=TQro4euksOAiqMKCLF+Gd+yJdqx/niMP4WZP+gitaba1jrNnvpgrOU/97m2YxdRQiFx1cahJfDJ/5nj8YuCEm6YP7c5VzskG0kCRWUZrp+fJx6qVNYd5fr+bXP7DJssliBZ1eq/DWbd3H7RDihyMmnzM6gHgpOtMyNzI/qvB1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598327; c=relaxed/simple;
	bh=utm6HKL0GSQ25yr/curLR+u9egxh9S9PNcbu70vf6P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/WxoqCdIR4qnOj9oJrhHAr9gGlh6QmN/lioow+6M8Ufw58DyrQBd8feXLIMvpT+7M24TuK3Yp13J8khPTrbq1g1dzh3/9EO/DE9AwYPcMWFFYYYkNT7jgfAJKr0gw7NC8j7rPgNh92iaq5kKYjqU7oT7ll+BhIqbBBH26rQ8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Un2uyUnu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfzlRJR2V1iKWMyi3X6nG0P5vlyntH87+PcrekOaX1M=;
	b=Un2uyUnu+6/F5Fn5HutzkP9BTzvb0mh+XYG6xemp335iYd+BVVAmy7Lqol8bZYCW4uEKSx
	/S0QFVouKRNDJLHJXXcQIQ0F8Icm8jGhtKwB2A88bRfMr3OZFP1ZV+0CaqDC5bjrmoX99/
	gk8FbhfYNrvMCKP+F8rXfoNy8/mSj0I=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [net-next PATCH v6 07/10] net: axienet: Convert to use PCS subsystem
Date: Tue, 10 Jun 2025 19:31:31 -0400
Message-Id: <20250610233134.3588011-8-sean.anderson@linux.dev>
In-Reply-To: <20250610233134.3588011-1-sean.anderson@linux.dev>
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
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
with bare MDIO nodes without a compatible. This functionality is gated
behind a config to allow it to be disabled by vendors who have fixed all
of their devicetrees.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

---

Changes in v6:
- Introduce config for compatibility helpers
- Move axienet_pcs_fixup to this commit

Changes in v5:
- Use MDIO_BUS instead of MDIO_DEVICE

Changes in v4:
- Convert to dev-less pcs_put

Changes in v3:
- Select PCS_XILINX unconditionally

 drivers/net/ethernet/xilinx/Kconfig           |  13 ++
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   4 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 160 +++++++++---------
 3 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 7502214cc7d5..d9c7a151bbaa 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -27,12 +27,25 @@ config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
 	depends on HAS_IOMEM
 	depends on XILINX_DMA
+	select MDIO_BUS
+	select OF_DYNAMIC
 	select PHYLINK
 	select DIMLIB
 	help
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
 	  AXI bus interface used in Xilinx Virtex FPGAs and Soc's.
 
+config XILINX_AXI_EMAC_PCS_COMPAT
+	bool "Xilinx AXI Ethernet PCS compatibility shim"
+	default PCS_XILINX
+	depends on XILINX_AXI_EMAC
+	select OF_DYNAMIC
+	help
+	  Enable support for older devicetrees which do not have compatibles
+	  for the Xilinx PCS/PMA. If you enable this option, you should
+	  probably enable PCS_XILINX too. If you do not use 1G speeds, or you
+	  do not have a (Xilinx) PCS, say n. If unsure, say y.
+
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
 	depends on HAS_IOMEM
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
index 6011d7eae0c7..09852960713b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 #include <linux/math64.h>
+#include <linux/pcs.h>
 #include <linux/phy.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
@@ -2519,63 +2520,6 @@ static const struct ethtool_ops axienet_ethtool_ops = {
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
@@ -2583,8 +2527,8 @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
-	    interface ==  PHY_INTERFACE_MODE_SGMII)
-		return &lp->pcs;
+	    interface == PHY_INTERFACE_MODE_SGMII)
+		return lp->pcs;
 
 	return NULL;
 }
@@ -2744,6 +2688,59 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	axienet_setoptions(ndev, lp->options);
 }
 
+#ifdef CONFIG_XILINX_AXI_EMAC_PCS_COMPAT
+static int axienet_pcs_fixup(struct of_changeset *ocs, struct device_node *np,
+			     void *data)
+{
+	unsigned int interface, mode_count, mode = 0;
+	const unsigned long *interfaces = data;
+	const char **modes;
+	int ret;
+
+	mode_count = bitmap_weight(interfaces, PHY_INTERFACE_MODE_MAX);
+	WARN_ON_ONCE(!mode_count);
+	modes = kcalloc(mode_count, sizeof(*modes), GFP_KERNEL);
+	if (!modes)
+		return -ENOMEM;
+
+	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
+		modes[mode++] = phy_modes(interface);
+	ret = of_changeset_add_prop_string_array(ocs, np, "xlnx,pcs-modes",
+						 modes, mode_count);
+	kfree(modes);
+	if (ret)
+		return ret;
+
+	return of_changeset_add_prop_string(ocs, np, "compatible", "xlnx,pcs");
+}
+
+/**
+ * axienet_pcs_get() - PCS Compatibility function for old device trees
+ * @dev: The MAC device
+ * @interfaces: The interfaces to use as a fallback
+ *
+ * This is a helper function to ensure backwards compatibility with device
+ * trees which do not include compatible strings for the PCS/PMA.
+ *
+ * Return: a PCS, or an error pointer
+ */
+static struct phylink_pcs *axienet_pcs_get(struct device *dev,
+					   const unsigned long *interfaces)
+{
+	struct fwnode_handle *fwnode;
+	struct phylink_pcs *pcs;
+
+	fwnode = pcs_find_fwnode(dev_fwnode(dev), NULL, "phy-handle", false);
+	if (IS_ERR(fwnode))
+		return ERR_CAST(fwnode);
+
+	pcs = pcs_get_by_fwnode_compat(dev, fwnode, axienet_pcs_fixup,
+				       (void *)interfaces);
+	fwnode_handle_put(fwnode);
+	return pcs;
+}
+#endif
+
 /**
  * axienet_probe - Axi Ethernet probe function.
  * @pdev:	Pointer to platform device structure.
@@ -3056,28 +3053,27 @@ static int axienet_probe(struct platform_device *pdev)
 
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
+#ifdef CONFIG_XILINX_AXI_EMAC_PCS_COMPAT
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
+		lp->pcs = axienet_pcs_get(&pdev->dev, interfaces);
+#else
+		lp->pcs = pcs_get(&pdev->dev, NULL);
+#endif
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
@@ -3115,8 +3111,6 @@ static int axienet_probe(struct platform_device *pdev)
 	phylink_destroy(lp->phylink);
 
 cleanup_mdio:
-	if (lp->pcs_phy)
-		put_device(&lp->pcs_phy->dev);
 	if (lp->mii_bus)
 		axienet_mdio_teardown(lp);
 cleanup_clk:
@@ -3139,9 +3133,7 @@ static void axienet_remove(struct platform_device *pdev)
 	if (lp->phylink)
 		phylink_destroy(lp->phylink);
 
-	if (lp->pcs_phy)
-		put_device(&lp->pcs_phy->dev);
-
+	pcs_put(lp->pcs);
 	axienet_mdio_teardown(lp);
 
 	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-- 
2.35.1.1320.gc452695387.dirty


