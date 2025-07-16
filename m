Return-Path: <netdev+bounces-207307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9FB06A3F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C2A563466
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F88192D97;
	Wed, 16 Jul 2025 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WligP8lI"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991414F98
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624106; cv=none; b=FfBr0G8JQSPzV9IftTconpcPsyopafOcNLE7C4LN9T3iqblW/rK3vP1+xRB/boYtGeg2m3J6u2VbOq1vg7Xq7cYRSIEz+8RB4iKwKanMYVx462b+KNkvPfKz/lpec59qsuIT3/9aYVmufrTa/Me21IkoeC3Vj8O+MGZTayteGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624106; c=relaxed/simple;
	bh=1qET2g0UQ0ixlLjAK341d4WPHlPJaytKV9Z0FEokY2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnhQPsx62+ZUfD6M7wTHM1ujCiyapYwsgOI43rjSI+isa5/Nuk68Uu9sYcXV9ztlGKYosCmp0blx8w4uSn7kocM/niEUrQNEhdcSQRX8viMgVaEycSeQIcVpZFJbm1TQ8RUWLRxpR69LSDzxzWQrsbV7E7kOj03ew80hLDWaN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WligP8lI; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxIH/H1ma2RCOsgWNb9NaryVCnHHPQRdHlbsQ+G8vNw=;
	b=WligP8lIj/7sY1ev6BnAWpDt8QbSoW5AGiTdGCXAcbMfM+9+YIUJ0pJ4ndz8avwPlY1CpH
	AI1lauvHN3PXElbEA4qm51wEksWAxZvXKaa3JbP/dapgO0ItTXxNBD+gPP18qLGRAa+ohA
	OEUaQGMe5+7gaJ4L8ifdlDh2uUTP5C8=
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
Subject: [PATCH net v2 4/4] net: axienet: Split into MAC and MDIO drivers
Date: Tue, 15 Jul 2025 20:01:10 -0400
Message-Id: <20250716000110.2267189-5-sean.anderson@linux.dev>
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

Returning EPROBE_DEFER after probing a bus may result in an infinite
probe loop if the EPROBE_DEFER error is never resolved. There are two
mutually-exclusive scenarios (that can both occur in the same system).
First, the PCS can be attached to our own MDIO bus:

MAC
 |
 +->MDIO
     |
     +->PCS
     +->PHY (etc)

In this scenario, we have to probe the MDIO bus before we can look up
the PCS, since otherwise the PCS will always be missing when we look for
it. But if we do things in the right order then we can't get
EPROBE_DEFER, and so there's no risk of a probe loop.

Second, the PCS can be attached to some other MDIO bus:

MAC              MDIO
 |                 |
 +->MDIO           +->PCS
      |
      +->PHY (etc)

In this scenario, the MDIO bus might not be present for whatever reason
(module not loaded, error in probe, etc.) and we have the possibility of
an EPROBE_DEFER error. If that happens, we will end up in a probe loop
because the PHY on our own MDIO bus incremented deferred_trigger_count
when it probed successfully:

deferred_probe_work_func()
  driver_probe_device(MAC)
    axienet_probe(MAC)
      mdiobus_register(MDIO)
        device_add(PHY)
          (probe successful)
          driver_bound(PHY)
            driver_deferred_probe_trigger()
      return -EPROBE_DEFER
    driver_deferred_probe_add(MAC)
    // deferred_trigger_count changed, so...
    driver_deferred_probe_trigger()

As I see it, this problem could be solved in the following four ways:

- Modify the driver core to detect and mitigate this sort of scenario
  (NACKed by Greg).
- Split the driver into MAC and MDIO parts (this commit).
- Modify phylink to allow connecting a PCS after phylink_create but
  before phylink_start. This is tricky because the PCS can affect the
  supported phy interfaces, and phy interfaces are validated in
  phylink_create.
- Defer phylink_create to ndo_open. This means that all the
  netdev/ethtool ops that use phylink now need to check ip the netdev is
  open and fall back to some other implementation. I don't think we can
  just return -EINVAL or whatever because using ethtool on a down device
  has historically worked. I am wary of breaking userspace because some
  tool assumes it can get_ksettings while the netdev is down.

Aside from the first option, the second one (this commit) has the best
UX. With the latter two, you could have a netdev that never comes up and
the user may not have very good insight as to why. For example, it may
not be obvious that the user should try to bring the netdev up again
after the PCS is probed. By waiting to create the netdev until after we
successfully probe the PCS we show up in devices_deferred and the netdev
can be brought up as usual.

Per the second bullet point above, split the MAC and MDIO functionality
into separate auxiliary devices. If the MAC fails with EPROBE_DEFER,
then the MDIO bus will remain bound, preventing a probe loop.

Fixes: 1a02556086fc ("net: axienet: Properly handle PCS/PMA PHY for 1000BaseX mode")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Fix building as a module
- Expand commit message with much more info on the problem and possible
  solutions

 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 107 ++++++++++++------
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c |  31 +++--
 3 files changed, 98 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 7502214cc7d5..3b940d2d3115 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -27,6 +27,7 @@ config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
 	depends on HAS_IOMEM
 	depends on XILINX_DMA
+	select AUXILIARY_BUS
 	select PHYLINK
 	select DIMLIB
 	help
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index c2512c04a88f..0638c4cafd4f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -22,6 +22,7 @@
  *  - Add support for extended VLAN support.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
@@ -2749,13 +2750,16 @@ static void axienet_disable_misc(void *clocks)
 	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks);
 }
 
-static int axienet_mac_probe(struct axienet_local *lp)
+static int axienet_mac_probe(struct auxiliary_device *auxdev,
+			     const struct auxiliary_device_id *id)
 {
+	struct axienet_local *lp = auxdev->dev.platform_data;
 	struct net_device *ndev = lp->ndev;
 	struct device_node *np;
 	int ret;
 
-	SET_NETDEV_DEV(ndev, lp->dev);
+	auxiliary_set_drvdata(auxdev, ndev);
+	SET_NETDEV_DEV(ndev, &auxdev->dev);
 	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
 	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
 		np = of_parse_phandle(lp->dev->of_node, "pcs-handle", 0);
@@ -2818,9 +2822,9 @@ static int axienet_mac_probe(struct axienet_local *lp)
 	return ret;
 }
 
-static void axienet_mac_remove(struct platform_device *pdev)
+static void axienet_mac_remove(struct auxiliary_device *auxdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = auxiliary_get_drvdata(auxdev);
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
@@ -2829,9 +2833,9 @@ static void axienet_mac_remove(struct platform_device *pdev)
 		put_device(&lp->pcs_phy->dev);
 }
 
-static void axienet_mac_shutdown(struct platform_device *pdev)
+static void axienet_mac_shutdown(struct auxiliary_device *auxdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = auxiliary_get_drvdata(auxdev);
 
 	rtnl_lock();
 	netif_device_detach(ndev);
@@ -2877,6 +2881,23 @@ static int axienet_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
 				axienet_suspend, axienet_resume);
 
+static const struct auxiliary_device_id xilinx_axienet_mac_id_table[] = {
+	{ .name = KBUILD_MODNAME ".mac", },
+	{ },
+};
+MODULE_DEVICE_TABLE(auxiliary, xilinx_axienet_mac_id_table);
+
+static struct auxiliary_driver xilinx_axienet_mac = {
+	.name = "mac",
+	.id_table = xilinx_axienet_mac_id_table,
+	.probe = axienet_mac_probe,
+	.remove = axienet_mac_remove,
+	.shutdown = axienet_mac_shutdown,
+	.driver = {
+		 .pm = &axienet_pm_ops,
+	},
+};
+
 /**
  * axienet_probe - Axi Ethernet probe function.
  * @pdev:	Pointer to platform device structure.
@@ -2892,12 +2913,14 @@ static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
 static int axienet_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct auxiliary_device *auxdev;
 	struct device_node *np;
 	struct axienet_local *lp;
 	struct net_device *ndev;
 	struct resource *ethres;
 	u8 mac_addr[ETH_ALEN];
 	int addr_width = 32;
+	char name[20];
 	u32 value;
 
 	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(*lp));
@@ -2906,7 +2929,6 @@ static int axienet_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ndev);
 
-	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->features = NETIF_F_SG;
 	ndev->ethtool_ops = &axienet_ethtool_ops;
 
@@ -3174,41 +3196,62 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
 					XAXIDMA_DFT_TX_USEC);
 
-	ret = axienet_mdio_setup(lp);
-	if (ret)
-		dev_warn(&pdev->dev,
-			 "error registering MDIO bus: %d\n", ret);
-
-	ret = axienet_mac_probe(lp);
-	if (!ret)
-		return 0;
-
-	if (lp->mii_bus)
-		axienet_mdio_teardown(lp);
-	return ret;
-}
-
-static void axienet_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct axienet_local *lp = netdev_priv(ndev);
-
-	axienet_mac_remove(pdev);
-	axienet_mdio_teardown(lp);
+	snprintf(name, sizeof(name), "mdio.%llx",
+		 (unsigned long long)lp->regs_start);
+	auxdev = devm_auxiliary_device_create(&pdev->dev, name, lp);
+	if (IS_ERR(auxdev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(auxdev),
+				     "could not create MDIO bus\n");
+
+	snprintf(name, sizeof(name), "mac.%llx",
+		 (unsigned long long)lp->regs_start);
+	auxdev = devm_auxiliary_device_create(&pdev->dev, name, lp);
+	if (IS_ERR(auxdev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(auxdev),
+				     "could not create MAC\n");
+
+	return 0;
 }
 
 static struct platform_driver axienet_driver = {
 	.probe = axienet_probe,
-	.remove = axienet_remove,
-	.shutdown = axienet_mac_shutdown,
 	.driver = {
 		 .name = "xilinx_axienet",
-		 .pm = &axienet_pm_ops,
 		 .of_match_table = axienet_of_match,
 	},
 };
 
-module_platform_driver(axienet_driver);
+extern struct auxiliary_driver xilinx_axienet_mdio;
+
+static int __init axienet_init(void)
+{
+	int ret;
+
+	ret = auxiliary_driver_register(&xilinx_axienet_mdio);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_driver_register(&xilinx_axienet_mac);
+	if (ret)
+		goto unregister_mdio;
+
+	ret = platform_driver_register(&axienet_driver);
+	if (ret) {
+		auxiliary_driver_unregister(&xilinx_axienet_mac);
+unregister_mdio:
+		auxiliary_driver_unregister(&xilinx_axienet_mdio);
+	}
+	return ret;
+}
+module_init(axienet_init);
+
+static void __exit axienet_exit(void)
+{
+	platform_driver_register(&axienet_driver);
+	auxiliary_driver_unregister(&xilinx_axienet_mac);
+	auxiliary_driver_unregister(&xilinx_axienet_mdio);
+}
+module_exit(axienet_exit);
 
 MODULE_DESCRIPTION("Xilinx Axi Ethernet driver");
 MODULE_AUTHOR("Xilinx");
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 9ca2643c921e..85792da17d0c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -9,6 +9,7 @@
  * Copyright (c) 2010 - 2012 Xilinx, Inc. All rights reserved.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk.h>
 #include <linux/of_address.h>
 #include <linux/of_mdio.h>
@@ -277,12 +278,15 @@ static int axienet_mdio_enable(struct axienet_local *lp, struct device_node *np)
  * Sets up the MDIO interface by initializing the MDIO clock.
  * Register the MDIO interface.
  **/
-int axienet_mdio_setup(struct axienet_local *lp)
+static int axienet_mdio_probe(struct auxiliary_device *auxdev,
+			      const struct auxiliary_device_id *id)
 {
+	struct axienet_local *lp = auxdev->dev.platform_data;
 	struct device_node *mdio_node;
 	struct mii_bus *bus;
 	int ret;
 
+	auxiliary_set_drvdata(auxdev, lp);
 	bus = mdiobus_alloc();
 	if (!bus)
 		return -ENOMEM;
@@ -294,7 +298,7 @@ int axienet_mdio_setup(struct axienet_local *lp)
 	bus->name = "Xilinx Axi Ethernet MDIO";
 	bus->read = axienet_mdio_read;
 	bus->write = axienet_mdio_write;
-	bus->parent = lp->dev;
+	bus->parent = &auxdev->dev;
 	lp->mii_bus = bus;
 
 	mdio_node = of_get_child_by_name(lp->dev->of_node, "mdio");
@@ -317,15 +321,24 @@ int axienet_mdio_setup(struct axienet_local *lp)
 	return ret;
 }
 
-/**
- * axienet_mdio_teardown - MDIO remove function
- * @lp:		Pointer to axienet local data structure.
- *
- * Unregisters the MDIO and frees any associate memory for mii bus.
- */
-void axienet_mdio_teardown(struct axienet_local *lp)
+static void axienet_mdio_remove(struct auxiliary_device *auxdev)
 {
+	struct axienet_local *lp = auxiliary_get_drvdata(auxdev);
+
 	mdiobus_unregister(lp->mii_bus);
 	mdiobus_free(lp->mii_bus);
 	lp->mii_bus = NULL;
 }
+
+static const struct auxiliary_device_id xilinx_axienet_mdio_id_table[] = {
+	{ .name = KBUILD_MODNAME ".mdio", },
+	{ },
+};
+MODULE_DEVICE_TABLE(auxiliary, xilinx_axienet_mdio_id_table);
+
+struct auxiliary_driver xilinx_axienet_mdio = {
+	.name = "mdio",
+	.id_table = xilinx_axienet_mdio_id_table,
+	.probe = axienet_mdio_probe,
+	.remove = axienet_mdio_remove,
+};
-- 
2.35.1.1320.gc452695387.dirty


