Return-Path: <netdev+bounces-207305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE1B06A3B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DA81A601CA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2125A353;
	Wed, 16 Jul 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gXJFCa7A"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863D220F41
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624102; cv=none; b=gvXiK8/bJ6Xgza4VgTI4l6t6VvFXlAgiNKteV6LUN8PWOyI5PBIULiOTX96pN977NaZl2CE+GyyO+8u/jbCmBeaVj7EWfNmcPVODddKmo2ahduyTVEzOg3KyBvcF8sSOGhQl1vG1/rdq10EpI5fiod5/S9uOcH+IbjTlwhSpooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624102; c=relaxed/simple;
	bh=2i1FxjxOMTCwOm03sAbB/L2Jx/vMon7IQsQ4YXaWjB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDjZU8nBwUHfrtNPHEbYW/14feX1Z6vvXMjzc8eTymxtPM9xGoZTSes4HYdB7UmJvqvM6qi7FAl7X0lryvoqLwmfU5j6PwFCQwyZK/qzqMPl6Ac3psdwDp6+a1nj6rsQPSdJkh4xJvc2zYWNDj1yO++O+X++5TkqllNjk7OOIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gXJFCa7A; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSPJIQb7zZXYaxjVPnZA2dEJZu7SMOpHsNQQVyaAN70=;
	b=gXJFCa7AKfGi9aAZ1fJlrVQl8e8dlfMkQ926d3oyDKFqN3LQznfY+iwmBmMo7bUomtHNwI
	swwiCFYq39XPV0wXe44C1O5u0vvneVnkO6CK9m+6htRYq++/f0G9v3kuYIWi8pu8R5XRv+
	BfUZTaYQmCIfOTxGqLVc92q1MKYIaFA=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2 3/4] net: axienet: Rearrange lifetime functions
Date: Tue, 15 Jul 2025 20:01:09 -0400
Message-Id: <20250716000110.2267189-4-sean.anderson@linux.dev>
In-Reply-To: <20250716000110.2267189-1-sean.anderson@linux.dev>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rearrange the lifetime functions (probe, remove, etc.) in preparation
for the next commit. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 252 +++++++++---------
 1 file changed, 133 insertions(+), 119 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1f277e5e4a62..c2512c04a88f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2749,6 +2749,134 @@ static void axienet_disable_misc(void *clocks)
 	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks);
 }
 
+static int axienet_mac_probe(struct axienet_local *lp)
+{
+	struct net_device *ndev = lp->ndev;
+	struct device_node *np;
+	int ret;
+
+	SET_NETDEV_DEV(ndev, lp->dev);
+	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
+	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
+		np = of_parse_phandle(lp->dev->of_node, "pcs-handle", 0);
+		if (!np) {
+			/* Deprecated: Always use "pcs-handle" for pcs_phy.
+			 * Falling back to "phy-handle" here is only for
+			 * backward compatibility with old device trees.
+			 */
+			np = of_parse_phandle(lp->dev->of_node, "phy-handle", 0);
+		}
+		if (!np) {
+			dev_err(lp->dev,
+				"pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
+			return -EINVAL;
+		}
+		lp->pcs_phy = of_mdio_find_device(np);
+		of_node_put(np);
+		if (!lp->pcs_phy)
+			return -EPROBE_DEFER;
+		lp->pcs.ops = &axienet_pcs_ops;
+		lp->pcs.poll = true;
+	}
+
+	lp->phylink_config.dev = &ndev->dev;
+	lp->phylink_config.type = PHYLINK_NETDEV;
+	lp->phylink_config.mac_managed_pm = true;
+	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
+		MAC_10FD | MAC_100FD | MAC_1000FD;
+
+	__set_bit(lp->phy_mode, lp->phylink_config.supported_interfaces);
+	if (lp->switch_x_sgmii) {
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  lp->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  lp->phylink_config.supported_interfaces);
+	}
+
+	lp->phylink = phylink_create(&lp->phylink_config, lp->dev->fwnode,
+				     lp->phy_mode,
+				     &axienet_phylink_ops);
+	if (IS_ERR(lp->phylink)) {
+		ret = PTR_ERR(lp->phylink);
+		dev_err(lp->dev, "phylink_create error (%i)\n", ret);
+		goto cleanup_pcs;
+	}
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(lp->dev, "register_netdev() error (%i)\n", ret);
+		goto cleanup_phylink;
+	}
+
+	return 0;
+
+cleanup_phylink:
+	phylink_destroy(lp->phylink);
+cleanup_pcs:
+	if (lp->pcs_phy)
+		put_device(&lp->pcs_phy->dev);
+	return ret;
+}
+
+static void axienet_mac_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	unregister_netdev(ndev);
+	phylink_destroy(lp->phylink);
+	if (lp->pcs_phy)
+		put_device(&lp->pcs_phy->dev);
+}
+
+static void axienet_mac_shutdown(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+
+	rtnl_lock();
+	netif_device_detach(ndev);
+
+	if (netif_running(ndev))
+		dev_close(ndev);
+
+	rtnl_unlock();
+}
+
+static int axienet_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+
+	if (!netif_running(ndev))
+		return 0;
+
+	netif_device_detach(ndev);
+
+	rtnl_lock();
+	axienet_stop(ndev);
+	rtnl_unlock();
+
+	return 0;
+}
+
+static int axienet_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+
+	if (!netif_running(ndev))
+		return 0;
+
+	rtnl_lock();
+	axienet_open(ndev);
+	rtnl_unlock();
+
+	netif_device_attach(ndev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
+				axienet_suspend, axienet_resume);
+
 /**
  * axienet_probe - Axi Ethernet probe function.
  * @pdev:	Pointer to platform device structure.
@@ -3051,69 +3179,10 @@ static int axienet_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev,
 			 "error registering MDIO bus: %d\n", ret);
 
-	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
-	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
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
-			goto cleanup_mdio;
-		}
-		of_node_put(np);
-		lp->pcs.ops = &axienet_pcs_ops;
-		lp->pcs.poll = true;
-	}
+	ret = axienet_mac_probe(lp);
+	if (!ret)
+		return 0;
 
-	lp->phylink_config.dev = &ndev->dev;
-	lp->phylink_config.type = PHYLINK_NETDEV;
-	lp->phylink_config.mac_managed_pm = true;
-	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
-		MAC_10FD | MAC_100FD | MAC_1000FD;
-
-	__set_bit(lp->phy_mode, lp->phylink_config.supported_interfaces);
-	if (lp->switch_x_sgmii) {
-		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-			  lp->phylink_config.supported_interfaces);
-		__set_bit(PHY_INTERFACE_MODE_SGMII,
-			  lp->phylink_config.supported_interfaces);
-	}
-
-	lp->phylink = phylink_create(&lp->phylink_config, pdev->dev.fwnode,
-				     lp->phy_mode,
-				     &axienet_phylink_ops);
-	if (IS_ERR(lp->phylink)) {
-		ret = PTR_ERR(lp->phylink);
-		dev_err(&pdev->dev, "phylink_create error (%i)\n", ret);
-		goto cleanup_mdio;
-	}
-
-	ret = register_netdev(lp->ndev);
-	if (ret) {
-		dev_err(lp->dev, "register_netdev() error (%i)\n", ret);
-		goto cleanup_phylink;
-	}
-
-	return 0;
-
-cleanup_phylink:
-	phylink_destroy(lp->phylink);
-
-cleanup_mdio:
-	if (lp->pcs_phy)
-		put_device(&lp->pcs_phy->dev);
 	if (lp->mii_bus)
 		axienet_mdio_teardown(lp);
 	return ret;
@@ -3124,69 +3193,14 @@ static void axienet_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	unregister_netdev(ndev);
-
-	if (lp->phylink)
-		phylink_destroy(lp->phylink);
-
-	if (lp->pcs_phy)
-		put_device(&lp->pcs_phy->dev);
-
+	axienet_mac_remove(pdev);
 	axienet_mdio_teardown(lp);
 }
 
-static void axienet_shutdown(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-
-	rtnl_lock();
-	netif_device_detach(ndev);
-
-	if (netif_running(ndev))
-		dev_close(ndev);
-
-	rtnl_unlock();
-}
-
-static int axienet_suspend(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-
-	if (!netif_running(ndev))
-		return 0;
-
-	netif_device_detach(ndev);
-
-	rtnl_lock();
-	axienet_stop(ndev);
-	rtnl_unlock();
-
-	return 0;
-}
-
-static int axienet_resume(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-
-	if (!netif_running(ndev))
-		return 0;
-
-	rtnl_lock();
-	axienet_open(ndev);
-	rtnl_unlock();
-
-	netif_device_attach(ndev);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
-				axienet_suspend, axienet_resume);
-
 static struct platform_driver axienet_driver = {
 	.probe = axienet_probe,
 	.remove = axienet_remove,
-	.shutdown = axienet_shutdown,
+	.shutdown = axienet_mac_shutdown,
 	.driver = {
 		 .name = "xilinx_axienet",
 		 .pm = &axienet_pm_ops,
-- 
2.35.1.1320.gc452695387.dirty


