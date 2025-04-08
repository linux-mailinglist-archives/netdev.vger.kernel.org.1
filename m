Return-Path: <netdev+bounces-179996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB8A7F0E2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90AB17BE2F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1522F152;
	Mon,  7 Apr 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUuVzC/3"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612E22E3F7
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067903; cv=none; b=iSf7Deu6EvxZ/afnewKDfv8Sw6VqveQNXQPmzl3P2qLwb8WBpzjkrIewF2RFPbktYHG6JUvPS0zMjrA992+sKcMsOqdkiDB0/csxSTkDCqI4P/J8o1KkmsgCLipyUaKwDwVA625Hh2001dfw9XjQo41NXv18LF6u6t4eHK6n5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067903; c=relaxed/simple;
	bh=FFKDo4SrvItPxqq4yWeHqtfM8V2/1/fxjD53owkzIR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fcp3uQ7LntgUB+27Lzve9ipQ/w1xl9IIbVDIMXwy6H+rszUdyfj1sARYaZPrrkAwtSlwfB28d/BAU7FX/oTxZv+ChBq7YDZ2EPoRH/v/CHhNPmpxpTW1pYS8KjsLi2R8+u67nX26Hls9Ydhgh4hSSgS9dboMzA+g3G82PRzeXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUuVzC/3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744067898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxjb3yeKy4CF7T9Xkm0zyQV9n3etk2CfYVe4WJyUFO0=;
	b=iUuVzC/3T151yOEXpHA/gQfRkF/R2LiJ7ziybtDJxfiSrbsFWvVB5o/Jof2Jmi2m8QK3aU
	NPgh/yIldw014ZUCgKYi0Im1lgXCkJwqiPy/TkfmWFJ1okZSkcYSvLqDk/vmlhMAflCZWI
	IUBnrEX/k9D+OXNVgH8SQCSqut3m+Og=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [net-next PATCH v2 08/14] net: pcs: lynx: Convert to an MDIO driver
Date: Mon,  7 Apr 2025 19:17:39 -0400
Message-Id: <20250407231746.2316518-9-sean.anderson@linux.dev>
In-Reply-To: <20250407231746.2316518-1-sean.anderson@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This converts the lynx PCS driver to a proper MDIO driver.
This allows using a more conventional driver lifecycle (e.g. with a
probe and remove). It will also make it easier to add interrupt support.

The existing helpers are converted to bind the MDIO driver instead of
creating the PCS directly. As lynx_pcs_create_mdiodev creates the PCS
device, we can just set the modalias. For lynx_pcs_create_fwnode, we try
to get the PCS the usual way, and if that fails we edit the devicetree
to add a compatible and reprobe the device.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Add support for #pcs-cells
- Remove unused variable lynx_properties

 drivers/net/dsa/ocelot/Kconfig                |   4 +
 drivers/net/dsa/ocelot/felix_vsc9959.c        |  11 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c      |  11 +-
 drivers/net/ethernet/altera/Kconfig           |   2 +
 drivers/net/ethernet/altera/altera_tse_main.c |   7 +-
 drivers/net/ethernet/freescale/dpaa/Kconfig   |   2 +-
 drivers/net/ethernet/freescale/dpaa2/Kconfig  |   3 +
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  11 +-
 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   |   8 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 -
 .../freescale/enetc/enetc_pf_common.c         |   4 +-
 drivers/net/ethernet/freescale/fman/Kconfig   |   4 +-
 .../net/ethernet/freescale/fman/fman_memac.c  |  27 +++--
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   3 +
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   6 +-
 drivers/net/pcs/Kconfig                       |  11 +-
 drivers/net/pcs/pcs-lynx.c                    | 110 ++++++++++--------
 include/linux/pcs-lynx.h                      |  13 ++-
 19 files changed, 130 insertions(+), 110 deletions(-)

diff --git a/drivers/net/dsa/ocelot/Kconfig b/drivers/net/dsa/ocelot/Kconfig
index 081e7a88ea02..e879f82537db 100644
--- a/drivers/net/dsa/ocelot/Kconfig
+++ b/drivers/net/dsa/ocelot/Kconfig
@@ -42,7 +42,9 @@ config NET_DSA_MSCC_FELIX
 	select NET_DSA_TAG_OCELOT_8021Q
 	select NET_DSA_TAG_OCELOT
 	select FSL_ENETC_MDIO
+	select PCS
 	select PCS_LYNX
+	select MDIO_DEVICE
 	help
 	  This driver supports the VSC9959 (Felix) switch, which is embedded as
 	  a PCIe function of the NXP LS1028A ENETC RCiEP.
@@ -58,7 +60,9 @@ config NET_DSA_MSCC_SEVILLE
 	select NET_DSA_MSCC_FELIX_DSA_LIB
 	select NET_DSA_TAG_OCELOT_8021Q
 	select NET_DSA_TAG_OCELOT
+	select PCS
 	select PCS_LYNX
+	select MDIO_DEVICE
 	help
 	  This driver supports the VSC9953 (Seville) switch, which is embedded
 	  as a platform device on the NXP T1040 SoC.
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 2de12611ab57..a67fc2f8528c 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -12,6 +12,7 @@
 #include <net/tc_act/tc_gate.h>
 #include <soc/mscc/ocelot.h>
 #include <linux/dsa/ocelot.h>
+#include <linux/pcs.h>
 #include <linux/pcs-lynx.h>
 #include <net/pkt_sched.h>
 #include <linux/iopoll.h>
@@ -1033,7 +1034,7 @@ static int vsc9959_mdio_bus_alloc(struct ocelot *ocelot)
 		if (ocelot_port->phy_mode == PHY_INTERFACE_MODE_INTERNAL)
 			continue;
 
-		phylink_pcs = lynx_pcs_create_mdiodev(felix->imdio, port);
+		phylink_pcs = lynx_pcs_create_mdiodev(dev, felix->imdio, port);
 		if (IS_ERR(phylink_pcs))
 			continue;
 
@@ -1050,12 +1051,8 @@ static void vsc9959_mdio_bus_free(struct ocelot *ocelot)
 	struct felix *felix = ocelot_to_felix(ocelot);
 	int port;
 
-	for (port = 0; port < ocelot->num_phys_ports; port++) {
-		struct phylink_pcs *phylink_pcs = felix->pcs[port];
-
-		if (phylink_pcs)
-			lynx_pcs_destroy(phylink_pcs);
-	}
+	for (port = 0; port < ocelot->num_phys_ports; port++)
+		pcs_put(ocelot->dev, felix->pcs[port]);
 	mdiobus_unregister(felix->imdio);
 	mdiobus_free(felix->imdio);
 }
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 28bcdef34a6c..0e61bd8bc7cd 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -10,6 +10,7 @@
 #include <linux/mdio/mdio-mscc-miim.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_mdio.h>
+#include <linux/pcs.h>
 #include <linux/pcs-lynx.h>
 #include <linux/dsa/ocelot.h>
 #include <linux/iopoll.h>
@@ -926,7 +927,7 @@ static int vsc9953_mdio_bus_alloc(struct ocelot *ocelot)
 		if (ocelot_port->phy_mode == PHY_INTERFACE_MODE_INTERNAL)
 			continue;
 
-		phylink_pcs = lynx_pcs_create_mdiodev(felix->imdio, addr);
+		phylink_pcs = lynx_pcs_create_mdiodev(dev, felix->imdio, addr);
 		if (IS_ERR(phylink_pcs))
 			continue;
 
@@ -943,12 +944,8 @@ static void vsc9953_mdio_bus_free(struct ocelot *ocelot)
 	struct felix *felix = ocelot_to_felix(ocelot);
 	int port;
 
-	for (port = 0; port < ocelot->num_phys_ports; port++) {
-		struct phylink_pcs *phylink_pcs = felix->pcs[port];
-
-		if (phylink_pcs)
-			lynx_pcs_destroy(phylink_pcs);
-	}
+	for (port = 0; port < ocelot->num_phys_ports; port++)
+		pcs_put(ocelot->dev, felix->pcs[port]);
 
 	/* mdiobus_unregister and mdiobus_free handled by devres */
 }
diff --git a/drivers/net/ethernet/altera/Kconfig b/drivers/net/ethernet/altera/Kconfig
index 4ef819a9a1ad..daf508a195a5 100644
--- a/drivers/net/ethernet/altera/Kconfig
+++ b/drivers/net/ethernet/altera/Kconfig
@@ -5,7 +5,9 @@ config ALTERA_TSE
 	depends on HAS_IOMEM
 	select PHYLIB
 	select PHYLINK
+	select PCS
 	select PCS_LYNX
+	select MDIO_DEVICE
 	select MDIO_REGMAP
 	select REGMAP_MMIO
 	help
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 3f6204de9e6b..7b34b6dc521e 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -32,6 +32,7 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/pcs.h>
 #include <linux/pcs-lynx.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
@@ -1412,7 +1413,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_init_pcs;
 	}
 
-	priv->pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
+	priv->pcs = lynx_pcs_create_mdiodev(&pdev->dev, pcs_bus, 0);
 	if (IS_ERR(priv->pcs)) {
 		ret = PTR_ERR(priv->pcs);
 		goto err_init_pcs;
@@ -1444,7 +1445,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 
 	return 0;
 err_init_phylink:
-	lynx_pcs_destroy(priv->pcs);
+	pcs_put(&pdev->dev, priv->pcs);
 err_init_pcs:
 	unregister_netdev(ndev);
 err_register_netdev:
@@ -1466,7 +1467,7 @@ static void altera_tse_remove(struct platform_device *pdev)
 	altera_tse_mdio_destroy(ndev);
 	unregister_netdev(ndev);
 	phylink_destroy(priv->phylink);
-	lynx_pcs_destroy(priv->pcs);
+	pcs_put(&pdev->dev, priv->pcs);
 
 	free_netdev(ndev);
 }
diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig b/drivers/net/ethernet/freescale/dpaa/Kconfig
index 2b560661c82a..3129f029445b 100644
--- a/drivers/net/ethernet/freescale/dpaa/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
@@ -3,7 +3,7 @@ menuconfig FSL_DPAA_ETH
 	tristate "DPAA Ethernet"
 	depends on FSL_DPAA && FSL_FMAN
 	select PHYLINK
-	select PCS_LYNX
+	select MDIO_DEVICE
 	help
 	  Data Path Acceleration Architecture Ethernet driver,
 	  supporting the Freescale QorIQ chips.
diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
index d029b69c3f18..28e63dc4acbf 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
@@ -2,8 +2,11 @@
 config FSL_DPAA2_ETH
 	tristate "Freescale DPAA2 Ethernet"
 	depends on FSL_MC_BUS && FSL_MC_DPIO
+	select OF_DYNAMIC
 	select PHYLINK
+	select PCS
 	select PCS_LYNX
+	select MDIO_DEVICE
 	select FSL_XGMAC_MDIO
 	select NET_DEVLINK
 	help
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 422ce13a7c94..26accbe7e736 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -2,6 +2,7 @@
 /* Copyright 2019 NXP */
 
 #include <linux/acpi.h>
+#include <linux/pcs.h>
 #include <linux/pcs-lynx.h>
 #include <linux/phy/phy.h>
 #include <linux/property.h>
@@ -262,7 +263,7 @@ static int dpaa2_pcs_create(struct dpaa2_mac *mac,
 		return 0;
 	}
 
-	pcs = lynx_pcs_create_fwnode(node);
+	pcs = lynx_pcs_create_fwnode(&mac->mc_dev->dev, node);
 	fwnode_handle_put(node);
 
 	if (pcs == ERR_PTR(-EPROBE_DEFER)) {
@@ -288,12 +289,8 @@ static int dpaa2_pcs_create(struct dpaa2_mac *mac,
 
 static void dpaa2_pcs_destroy(struct dpaa2_mac *mac)
 {
-	struct phylink_pcs *phylink_pcs = mac->pcs;
-
-	if (phylink_pcs) {
-		lynx_pcs_destroy(phylink_pcs);
-		mac->pcs = NULL;
-	}
+	pcs_put(&mac->mc_dev->dev, mac->pcs);
+	mac->pcs = NULL;
 }
 
 static void dpaa2_mac_set_supported_interfaces(struct dpaa2_mac *mac)
diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 6c2779047dcd..6a58254b9a5f 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -24,7 +24,9 @@ config FSL_ENETC
 	select FSL_ENETC_MDIO
 	select NXP_ENETC_PF_COMMON
 	select PHYLINK
+	select PCS
 	select PCS_LYNX
+	select MDIO_DEVICE
 	select DIMLIB
 	help
 	  This driver supports NXP ENETC gigabit ethernet controller PCIe
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 203862ec1114..737797b541a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -34,12 +34,7 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
 					       struct mii_bus *bus)
 {
-	return lynx_pcs_create_mdiodev(bus, 0);
-}
-
-static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
-{
-	lynx_pcs_destroy(pcs);
+	return lynx_pcs_create_mdiodev(&pf->si->pdev->dev, bus, 0);
 }
 
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
@@ -1003,7 +998,6 @@ static const struct enetc_pf_ops enetc_pf_ops = {
 	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
 	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
 	.create_pcs = enetc_pf_create_pcs,
-	.destroy_pcs = enetc_pf_destroy_pcs,
 	.enable_psfp = enetc_psfp_enable,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index a26a12863855..d5e02d02c7a8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -42,7 +42,6 @@ struct enetc_pf_ops {
 	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
 	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
 	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
-	void (*destroy_pcs)(struct phylink_pcs *pcs);
 	int (*enable_psfp)(struct enetc_ndev_priv *priv);
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3fd9b0727875..f5b75d40f7c5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -4,6 +4,7 @@
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/pcs.h>
 
 #include "enetc_pf_common.h"
 
@@ -248,8 +249,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 static void enetc_imdio_remove(struct enetc_pf *pf)
 {
-	if (pf->pcs && pf->ops->destroy_pcs)
-		pf->ops->destroy_pcs(pf->pcs);
+	pcs_put(&pf->si->pdev->dev, pf->pcs);
 
 	if (pf->imdio) {
 		mdiobus_unregister(pf->imdio);
diff --git a/drivers/net/ethernet/freescale/fman/Kconfig b/drivers/net/ethernet/freescale/fman/Kconfig
index a55542c1ad65..b87b22220972 100644
--- a/drivers/net/ethernet/freescale/fman/Kconfig
+++ b/drivers/net/ethernet/freescale/fman/Kconfig
@@ -3,10 +3,12 @@ config FSL_FMAN
 	tristate "FMan support"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST
 	select GENERIC_ALLOCATOR
+	select OF_DYNAMIC
+	select MDIO_DEVICE
 	select PHYLINK
+	select PCS
 	select PCS_LYNX
 	select CRC32
-	default n
 	help
 		Freescale Data-Path Acceleration Architecture Frame Manager
 		(FMan) support
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 3925441143fa..fc12f3e44824 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -11,6 +11,7 @@
 
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/pcs.h>
 #include <linux/pcs-lynx.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
@@ -972,21 +973,23 @@ static int memac_init(struct fman_mac *memac)
 	return 0;
 }
 
-static void pcs_put(struct phylink_pcs *pcs)
+static void memac_pcs_put(struct device *dev, struct phylink_pcs *pcs)
 {
 	if (IS_ERR_OR_NULL(pcs))
 		return;
 
-	lynx_pcs_destroy(pcs);
+	pcs_put(dev, pcs);
 }
 
 static int memac_free(struct fman_mac *memac)
 {
+	struct device *dev = memac->dev_id->dev;
+
 	free_init_resources(memac);
 
-	pcs_put(memac->sgmii_pcs);
-	pcs_put(memac->qsgmii_pcs);
-	pcs_put(memac->xfi_pcs);
+	memac_pcs_put(dev, memac->sgmii_pcs);
+	memac_pcs_put(dev, memac->qsgmii_pcs);
+	memac_pcs_put(dev, memac->xfi_pcs);
 	kfree(memac->memac_drv_param);
 	kfree(memac);
 
@@ -1033,7 +1036,8 @@ static struct fman_mac *memac_config(struct mac_device *mac_dev,
 	return memac;
 }
 
-static struct phylink_pcs *memac_pcs_create(struct device_node *mac_node,
+static struct phylink_pcs *memac_pcs_create(struct device *dev,
+					    struct device_node *mac_node,
 					    int index)
 {
 	struct device_node *node;
@@ -1043,7 +1047,7 @@ static struct phylink_pcs *memac_pcs_create(struct device_node *mac_node,
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	pcs = lynx_pcs_create_fwnode(of_fwnode_handle(node));
+	pcs = lynx_pcs_create_fwnode(dev, of_fwnode_handle(node));
 	of_node_put(node);
 
 	return pcs;
@@ -1100,7 +1104,7 @@ int memac_initialization(struct mac_device *mac_dev,
 
 	err = of_property_match_string(mac_node, "pcs-handle-names", "xfi");
 	if (err >= 0) {
-		memac->xfi_pcs = memac_pcs_create(mac_node, err);
+		memac->xfi_pcs = memac_pcs_create(mac_dev->dev, mac_node, err);
 		if (IS_ERR(memac->xfi_pcs)) {
 			err = PTR_ERR(memac->xfi_pcs);
 			dev_err_probe(mac_dev->dev, err, "missing xfi pcs\n");
@@ -1112,7 +1116,8 @@ int memac_initialization(struct mac_device *mac_dev,
 
 	err = of_property_match_string(mac_node, "pcs-handle-names", "qsgmii");
 	if (err >= 0) {
-		memac->qsgmii_pcs = memac_pcs_create(mac_node, err);
+		memac->qsgmii_pcs = memac_pcs_create(mac_dev->dev, mac_node,
+						     err);
 		if (IS_ERR(memac->qsgmii_pcs)) {
 			err = PTR_ERR(memac->qsgmii_pcs);
 			dev_err_probe(mac_dev->dev, err,
@@ -1128,11 +1133,11 @@ int memac_initialization(struct mac_device *mac_dev,
 	 */
 	err = of_property_match_string(mac_node, "pcs-handle-names", "sgmii");
 	if (err == -EINVAL || err == -ENODATA)
-		pcs = memac_pcs_create(mac_node, 0);
+		pcs = memac_pcs_create(mac_dev->dev, mac_node, 0);
 	else if (err < 0)
 		goto _return_fm_mac_free;
 	else
-		pcs = memac_pcs_create(mac_node, err);
+		pcs = memac_pcs_create(mac_dev->dev, mac_node, err);
 
 	if (IS_ERR(pcs)) {
 		err = PTR_ERR(pcs);
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 3c820ef56775..3df23331c726 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -170,9 +170,12 @@ config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_INTEL_SOCFPGA
 	depends on OF && (ARCH_INTEL_SOCFPGA || COMPILE_TEST)
+	select OF_DYNAMIC
 	select MFD_SYSCON
+	select MDIO_DEVICE
 	select MDIO_REGMAP
 	select REGMAP_MMIO
+	select PCS
 	select PCS_LYNX
 	help
 	  Support for ethernet controller on Altera SOCFPGA
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 116855658559..2c2fb820752b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_net.h>
+#include <linux/pcs.h>
 #include <linux/phy.h>
 #include <linux/regmap.h>
 #include <linux/mdio/mdio-regmap.h>
@@ -415,7 +416,7 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
 	if (IS_ERR(pcs_bus))
 		return PTR_ERR(pcs_bus);
 
-	pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
+	pcs = lynx_pcs_create_mdiodev(priv->device, pcs_bus, 0);
 	if (IS_ERR(pcs))
 		return PTR_ERR(pcs);
 
@@ -425,8 +426,7 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
 
 static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
 {
-	if (priv->hw->phylink_pcs)
-		lynx_pcs_destroy(priv->hw->phylink_pcs);
+	pcs_put(priv->device, priv->hw->phylink_pcs);
 }
 
 static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index b764770063cc..91ff59899aaf 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -25,10 +25,15 @@ config PCS_XPCS
 	  DesignWare XPCS controllers.
 
 config PCS_LYNX
-	tristate
+	tristate "NXP Lynx PCS driver"
+	depends on PCS && MDIO_DEVICE
 	help
-	  This module provides helpers to phylink for managing the Lynx PCS
-	  which is part of the Layerscape and QorIQ Ethernet SERDES.
+	  This module provides driver support for the PCSs in Lynx 10g and 28g
+	  SerDes devices. These devices are present in NXP QorIQ SoCs,
+	  including the Layerscape series.
+
+	  If you want to use Ethernet on a QorIQ SoC, say "Y". If compiled as a
+	  module, it will be called "pcs-lynx".
 
 config PCS_MTK_LYNXI
 	tristate
diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 23b40e9eacbb..a4dbd2e366f2 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -1,11 +1,15 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2020 NXP
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
+ * Copyright 2020 NXP
  * Lynx PCS MDIO helpers
  */
 
 #include <linux/mdio.h>
 #include <linux/phylink.h>
+#include <linux/of.h>
+#include <linux/pcs.h>
 #include <linux/pcs-lynx.h>
+#include <linux/phylink.h>
 #include <linux/property.h>
 
 #define SGMII_CLOCK_PERIOD_NS		8 /* PCS is clocked at 125 MHz */
@@ -343,16 +347,16 @@ static const phy_interface_t lynx_interfaces[] = {
 	PHY_INTERFACE_MODE_USXGMII,
 };
 
-static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
+static int lynx_pcs_probe(struct mdio_device *mdio)
 {
+	struct device *dev = &mdio->dev;
 	struct lynx_pcs *lynx;
-	int i;
+	int i, ret;
 
-	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
+	lynx = devm_kzalloc(dev, sizeof(*lynx), GFP_KERNEL);
 	if (!lynx)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	mdio_device_get(mdio);
 	lynx->mdio = mdio;
 	lynx->pcs.ops = &lynx_pcs_phylink_ops;
 	lynx->pcs.poll = true;
@@ -360,32 +364,64 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 	for (i = 0; i < ARRAY_SIZE(lynx_interfaces); i++)
 		__set_bit(lynx_interfaces[i], lynx->pcs.supported_interfaces);
 
-	return lynx_to_phylink_pcs(lynx);
+	ret = devm_pcs_register_provider(dev, pcs_xlate_single, &lynx->pcs);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not register PCS\n");
+	dev_info(dev, "probed\n");
+	return 0;
 }
 
-struct phylink_pcs *lynx_pcs_create_mdiodev(struct mii_bus *bus, int addr)
+static const struct of_device_id lynx_pcs_of_match[] = {
+	{ .compatible = "fsl,lynx-pcs" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lynx_pcs_of_match);
+
+static struct mdio_driver lynx_pcs_driver = {
+	.probe = lynx_pcs_probe,
+	.mdiodrv.driver = {
+		.name = "lynx-pcs",
+		.of_match_table = of_match_ptr(lynx_pcs_of_match),
+	},
+};
+mdio_module_driver(lynx_pcs_driver);
+
+struct phylink_pcs *lynx_pcs_create_mdiodev(struct device *dev,
+					    struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdio;
 	struct phylink_pcs *pcs;
+	int err;
 
 	mdio = mdio_device_create(bus, addr);
 	if (IS_ERR(mdio))
 		return ERR_CAST(mdio);
 
-	pcs = lynx_pcs_create(mdio);
-
-	/* lynx_create() has taken a refcount on the mdiodev if it was
-	 * successful. If lynx_create() fails, this will free the mdio
-	 * device here. In any case, we don't need to hold our reference
-	 * anymore, and putting it here will allow mdio_device_put() in
-	 * lynx_destroy() to automatically free the mdio device.
-	 */
-	mdio_device_put(mdio);
+	mdio->bus_match = mdio_device_bus_match;
+	strscpy(mdio->modalias, "lynx-pcs");
+	err = mdio_device_register(mdio);
+	if (err) {
+		mdio_device_free(mdio);
+		return ERR_PTR(err);
+	}
 
+	pcs = pcs_get_by_dev(dev, &mdio->dev);
+	mdio_device_free(mdio);
 	return pcs;
 }
 EXPORT_SYMBOL(lynx_pcs_create_mdiodev);
 
+static int lynx_pcs_fixup(struct of_changeset *ocs,
+			  struct device_node *np, void *data)
+{
+#ifdef CONFIG_OF_DYNAMIC
+	return of_changeset_add_prop_string(ocs, np, "compatible",
+					    "fsl,lynx-pcs");
+#else
+	return -ENODEV;
+#endif
+}
+
 /*
  * lynx_pcs_create_fwnode() creates a lynx PCS instance from the fwnode
  * device indicated by node.
@@ -396,40 +432,12 @@ EXPORT_SYMBOL(lynx_pcs_create_mdiodev);
  *  -ENOMEM if we fail to allocate memory
  *  pointer to a phylink_pcs on success
  */
-struct phylink_pcs *lynx_pcs_create_fwnode(struct fwnode_handle *node)
+struct phylink_pcs *lynx_pcs_create_fwnode(struct device *dev,
+					   struct fwnode_handle *node)
 {
-	struct mdio_device *mdio;
-	struct phylink_pcs *pcs;
-
-	if (!fwnode_device_is_available(node))
-		return ERR_PTR(-ENODEV);
-
-	mdio = fwnode_mdio_find_device(node);
-	if (!mdio)
-		return ERR_PTR(-EPROBE_DEFER);
-
-	pcs = lynx_pcs_create(mdio);
-
-	/* lynx_create() has taken a refcount on the mdiodev if it was
-	 * successful. If lynx_create() fails, this will free the mdio
-	 * device here. In any case, we don't need to hold our reference
-	 * anymore, and putting it here will allow mdio_device_put() in
-	 * lynx_destroy() to automatically free the mdio device.
-	 */
-	mdio_device_put(mdio);
-
-	return pcs;
+	return pcs_get_by_fwnode_compat(dev, node, lynx_pcs_fixup, NULL);
 }
 EXPORT_SYMBOL_GPL(lynx_pcs_create_fwnode);
 
-void lynx_pcs_destroy(struct phylink_pcs *pcs)
-{
-	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
-
-	mdio_device_put(lynx->mdio);
-	kfree(lynx);
-}
-EXPORT_SYMBOL(lynx_pcs_destroy);
-
-MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
-MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pcs-lynx.h b/include/linux/pcs-lynx.h
index 7958cccd16f2..a95801337205 100644
--- a/include/linux/pcs-lynx.h
+++ b/include/linux/pcs-lynx.h
@@ -6,12 +6,13 @@
 #ifndef __LINUX_PCS_LYNX_H
 #define __LINUX_PCS_LYNX_H
 
-#include <linux/mdio.h>
-#include <linux/phylink.h>
+struct device;
+struct mii_bus;
+struct phylink_pcs;
 
-struct phylink_pcs *lynx_pcs_create_mdiodev(struct mii_bus *bus, int addr);
-struct phylink_pcs *lynx_pcs_create_fwnode(struct fwnode_handle *node);
-
-void lynx_pcs_destroy(struct phylink_pcs *pcs);
+struct phylink_pcs *lynx_pcs_create_mdiodev(struct device *dev,
+					    struct mii_bus *bus, int addr);
+struct phylink_pcs *lynx_pcs_create_fwnode(struct device *dev,
+					   struct fwnode_handle *node);
 
 #endif /* __LINUX_PCS_LYNX_H */
-- 
2.35.1.1320.gc452695387.dirty


