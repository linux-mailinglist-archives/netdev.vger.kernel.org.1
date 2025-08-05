Return-Path: <netdev+bounces-211753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D5B1B79D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDC623AC3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F963277CA4;
	Tue,  5 Aug 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J18TIwth"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350427CCE0
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408127; cv=none; b=UXuVyQw3BZLsZ1SAEPmJ4UK3scQTiIniwwy/dnmPl9ckx8PFE1qf/TY6QdlKDPMSjS7MuM+wxYbnR9qNwOtotnW4F2zCnLImd8U/Za902ENzbiBctAAnJbkg7clIgmaT7WNwXrRjSVQFsZGB+Pi8C0UebKcEFYeuIMeEszzIkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408127; c=relaxed/simple;
	bh=rHKpjajgpDGTgG+3OF/YtVmm8fzh8QZi+8NsTsdD4GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDVw2RAXnqI7qsACVEWfvJG6Elfoj100VOUB5ltQtxXGX1OVfT7VkIrBx/Ph7srrKSj6hbxY5aZTeyo822yWW+5KBmfFTiuefb9f68RjVzX5a0KCkHtb+QUmxeB2R+8b59uQ7YsXEucpg9Ot/ly5Tk8Kg4vfHvBDhA/n8Qt7ECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J18TIwth; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7RpDsALexoT6DD56ZX3x5H76tqdICKHDob8Z0ppPBA=;
	b=J18TIwthw0muA5Tm7KlBMymbpiq4+G9ZepfTg6MtVQoWIN4ClFDjF35LljZ2jbzN2crIhw
	n08MfYc/PzEowphhH7wveYsICOCseiyNTLGn8JGTmrRgxc1xVRjDJFQa2tL8XuMqgNE1R9
	gF1uAeNHqS4O3NYgH7KqlHblWDnUdvU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 6/7] net: axienet: Rearrange lifetime functions
Date: Tue,  5 Aug 2025 11:34:55 -0400
Message-Id: <20250805153456.1313661-7-sean.anderson@linux.dev>
In-Reply-To: <20250805153456.1313661-1-sean.anderson@linux.dev>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
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

(no changes since v3)

Changes in v3:
- Rework to use a separate axienet_common structure

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  41 ++++--
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 135 ++++++++++--------
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c |  43 +++---
 3 files changed, 126 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..d7215dd92ce9 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -467,6 +467,29 @@ struct skbuf_dma_descriptor {
 	int sg_len;
 };
 
+/**
+ * struct axienet_common - axienet private common data
+ * @pdev: Pointer to common platform device structure
+ * @axi_clk: AXI4-Lite bus clock
+ * @reset_lock: Lock held while resetting the device to prevent register access
+ * @mii_bus: Pointer to MII bus structure
+ * @mii_clk_div: MII bus clock divider value
+ * @regs_start: Resource start for axienet device addresses
+ * @regs: Base address for the axienet_local device address space
+ */
+struct axienet_common {
+	struct platform_device *pdev;
+
+	struct clk *axi_clk;
+
+	struct mutex reset_lock;
+	struct mii_bus *mii_bus;
+	u8 mii_clk_div;
+
+	void __iomem *regs;
+	resource_size_t regs_start;
+};
+
 /**
  * struct axienet_local - axienet private per device data
  * @ndev:	Pointer for net_device to which it will be attached.
@@ -549,6 +572,7 @@ struct skbuf_dma_descriptor {
 struct axienet_local {
 	struct net_device *ndev;
 	struct device *dev;
+	struct axienet_common *cp;
 
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
@@ -558,13 +582,11 @@ struct axienet_local {
 
 	bool switch_x_sgmii;
 
-	struct clk *axi_clk;
 	struct clk_bulk_data misc_clks[XAE_NUM_MISC_CLOCKS];
 
 	struct mii_bus *mii_bus;
 	u8 mii_clk_div;
 
-	resource_size_t regs_start;
 	void __iomem *regs;
 	void __iomem *dma_regs;
 
@@ -654,21 +676,14 @@ static inline u32 axienet_ior(struct axienet_local *lp, off_t offset)
 	return ioread32(lp->regs + offset);
 }
 
-static inline u32 axinet_ior_read_mcr(struct axienet_local *lp)
-{
-	return axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
-}
-
 static inline void axienet_lock_mii(struct axienet_local *lp)
 {
-	if (lp->mii_bus)
-		mutex_lock(&lp->mii_bus->mdio_lock);
+	mutex_lock(&lp->cp->reset_lock);
 }
 
 static inline void axienet_unlock_mii(struct axienet_local *lp)
 {
-	if (lp->mii_bus)
-		mutex_unlock(&lp->mii_bus->mdio_lock);
+	mutex_unlock(&lp->cp->reset_lock);
 }
 
 /**
@@ -738,7 +753,7 @@ static inline void axienet_dma_out_addr(struct axienet_local *lp, off_t reg,
 #endif /* CONFIG_64BIT */
 
 /* Function prototypes visible in xilinx_axienet_mdio.c for other files */
-int axienet_mdio_setup(struct axienet_local *lp);
-void axienet_mdio_teardown(struct axienet_local *lp);
+int axienet_mdio_setup(struct axienet_common *lp);
+void axienet_mdio_teardown(struct axienet_common *lp);
 
 #endif /* XILINX_AXI_ENET_H */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 28927c7c6c41..f235ef15187c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -225,8 +225,8 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 
 static u64 axienet_dma_rate(struct axienet_local *lp)
 {
-	if (lp->axi_clk)
-		return clk_get_rate(lp->axi_clk);
+	if (lp->cp->axi_clk)
+		return clk_get_rate(lp->cp->axi_clk);
 	return 125000000; /* arbitrary guess if no clock rate set */
 }
 
@@ -2749,29 +2749,17 @@ static void axienet_disable_misc(void *clocks)
 	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks);
 }
 
-/**
- * axienet_probe - Axi Ethernet probe function.
- * @pdev:	Pointer to platform device structure.
- *
- * Return: 0, on success
- *	    Non-zero error value on failure.
- *
- * This is the probe routine for Axi Ethernet driver. This is called before
- * any other driver routines are invoked. It allocates and sets up the Ethernet
- * device. Parses through device tree and populates fields of
- * axienet_local. It registers the Ethernet device.
- */
-static int axienet_probe(struct platform_device *pdev)
+static int axienet_mac_probe(struct axienet_common *cp)
 {
-	int ret;
+	struct platform_device *pdev = cp->pdev;
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	struct axienet_local *lp;
 	struct net_device *ndev;
-	struct resource *ethres;
+	struct device_node *np;
 	u8 mac_addr[ETH_ALEN];
 	int addr_width = 32;
 	u32 value;
+	int ret;
 
 	ndev = devm_alloc_etherdev(dev, sizeof(*lp));
 	if (!ndev)
@@ -2790,6 +2778,8 @@ static int axienet_probe(struct platform_device *pdev)
 	lp = netdev_priv(ndev);
 	lp->ndev = ndev;
 	lp->dev = dev;
+	lp->cp = cp;
+	lp->regs = cp->regs;
 	lp->options = XAE_OPTION_DEFAULTS;
 	lp->rx_bd_num = RX_BD_NUM_DEFAULT;
 	lp->tx_bd_num = TX_BD_NUM_DEFAULT;
@@ -2801,17 +2791,6 @@ static int axienet_probe(struct platform_device *pdev)
 	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
 	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
 
-	lp->axi_clk = devm_clk_get_optional_enabled(dev, "s_axi_lite_clk");
-	if (!lp->axi_clk) {
-		/* For backward compatibility, if named AXI clock is not present,
-		 * treat the first clock specified as the AXI clock.
-		 */
-		lp->axi_clk = devm_clk_get_optional_enabled(dev, NULL);
-	}
-	if (IS_ERR(lp->axi_clk))
-		return dev_err_probe(dev, PTR_ERR(lp->axi_clk),
-				     "could not get AXI clock\n");
-
 	lp->misc_clks[0].id = "axis_clk";
 	lp->misc_clks[1].id = "ref_clk";
 	lp->misc_clks[2].id = "mgt_clk";
@@ -2831,12 +2810,6 @@ static int axienet_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Map device registers */
-	lp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
-	if (IS_ERR(lp->regs))
-		return PTR_ERR(lp->regs);
-	lp->regs_start = ethres->start;
-
 	/* Setup checksum offload, but default to off if not specified */
 	lp->features = 0;
 
@@ -3045,11 +3018,6 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
 					XAXIDMA_DFT_TX_USEC);
 
-	ret = axienet_mdio_setup(lp);
-	if (ret)
-		dev_warn(dev,
-			 "error registering MDIO bus: %d\n", ret);
-
 	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
 	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
 		np = of_parse_phandle(dev->of_node, "pcs-handle", 0);
@@ -3061,17 +3029,14 @@ static int axienet_probe(struct platform_device *pdev)
 			np = of_parse_phandle(dev->of_node, "phy-handle", 0);
 		}
 		if (!np) {
-			dev_err(dev, "pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
-			ret = -EINVAL;
-			goto cleanup_mdio;
+			dev_err(dev,
+				"pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
+			return -EINVAL;
 		}
 		lp->pcs_phy = of_mdio_find_device(np);
-		if (!lp->pcs_phy) {
-			ret = -EPROBE_DEFER;
-			of_node_put(np);
-			goto cleanup_mdio;
-		}
 		of_node_put(np);
+		if (!lp->pcs_phy)
+			return -EPROBE_DEFER;
 		lp->pcs.ops = &axienet_pcs_ops;
 		lp->pcs.poll = true;
 	}
@@ -3096,7 +3061,7 @@ static int axienet_probe(struct platform_device *pdev)
 	if (IS_ERR(lp->phylink)) {
 		ret = PTR_ERR(lp->phylink);
 		dev_err(dev, "phylink_create error (%i)\n", ret);
-		goto cleanup_mdio;
+		goto cleanup_pcs;
 	}
 
 	ret = register_netdev(lp->ndev);
@@ -3109,32 +3074,24 @@ static int axienet_probe(struct platform_device *pdev)
 
 cleanup_phylink:
 	phylink_destroy(lp->phylink);
-
-cleanup_mdio:
+cleanup_pcs:
 	if (lp->pcs_phy)
 		put_device(&lp->pcs_phy->dev);
-	if (lp->mii_bus)
-		axienet_mdio_teardown(lp);
 	return ret;
 }
 
-static void axienet_remove(struct platform_device *pdev)
+static void axienet_mac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
-
-	if (lp->phylink)
-		phylink_destroy(lp->phylink);
-
+	phylink_destroy(lp->phylink);
 	if (lp->pcs_phy)
 		put_device(&lp->pcs_phy->dev);
-
-	axienet_mdio_teardown(lp);
 }
 
-static void axienet_shutdown(struct platform_device *pdev)
+static void axienet_mac_shutdown(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
@@ -3182,10 +3139,64 @@ static int axienet_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
 				axienet_suspend, axienet_resume);
 
+static int axienet_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axienet_common *cp;
+	struct resource *ethres;
+	int ret;
+
+	cp = devm_kzalloc(dev, sizeof(*cp), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->pdev = pdev;
+	mutex_init(&cp->reset_lock);
+
+	cp->axi_clk = devm_clk_get_optional_enabled(dev, "s_axi_lite_clk");
+	if (!cp->axi_clk) {
+		/* For backward compatibility, if named AXI clock is not present,
+		 * treat the first clock specified as the AXI clock.
+		 */
+		cp->axi_clk = devm_clk_get_optional_enabled(dev, NULL);
+	}
+	if (IS_ERR(cp->axi_clk))
+		return dev_err_probe(dev, PTR_ERR(cp->axi_clk),
+				     "could not get AXI clock\n");
+
+	/* Map device registers */
+	cp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
+	if (IS_ERR(cp->regs))
+		return PTR_ERR(cp->regs);
+	cp->regs_start = ethres->start;
+
+	ret = axienet_mdio_setup(cp);
+	if (ret)
+		dev_warn(dev, "error registering MDIO bus: %d\n", ret);
+
+	ret = axienet_mac_probe(cp);
+	if (!ret)
+		return 0;
+
+	if (cp->mii_bus)
+		axienet_mdio_teardown(cp);
+	return ret;
+}
+
+static void axienet_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	axienet_mac_remove(pdev);
+	if (lp->mii_bus)
+		axienet_mdio_teardown(lp->cp);
+}
+
 static struct platform_driver axienet_driver = {
 	.probe = axienet_probe,
 	.remove = axienet_remove,
-	.shutdown = axienet_shutdown,
+	.shutdown = axienet_mac_shutdown,
 	.driver = {
 		 .name = "xilinx_axienet",
 		 .pm = &axienet_pm_ops,
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 1903a1d50b05..4d50b3d0f7ee 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/of_address.h>
 #include <linux/of_mdio.h>
+#include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/iopoll.h>
 
@@ -22,13 +23,13 @@
 
 /**
  * axienet_mdio_wait_until_ready - MDIO wait function
- * @lp:	Pointer to axienet local data structure.
+ * @lp:	Pointer to axienet common data structure.
  *
  * Return :	0 on success, Negative value on errors
  *
  * Wait till MDIO interface is ready to accept a new transaction.
  */
-static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
+static int axienet_mdio_wait_until_ready(struct axienet_common *lp)
 {
 	u32 val;
 
@@ -39,11 +40,11 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 
 /**
  * axienet_mdio_mdc_enable - MDIO MDC enable function
- * @lp:	Pointer to axienet local data structure.
+ * @lp:	Pointer to axienet common data structure.
  *
  * Enable the MDIO MDC. Called prior to a read/write operation
  */
-static void axienet_mdio_mdc_enable(struct axienet_local *lp)
+static void axienet_mdio_mdc_enable(struct axienet_common *lp)
 {
 	iowrite32((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK,
 		  lp->regs + XAE_MDIO_MC_OFFSET);
@@ -51,11 +52,11 @@ static void axienet_mdio_mdc_enable(struct axienet_local *lp)
 
 /**
  * axienet_mdio_mdc_disable - MDIO MDC disable function
- * @lp:	Pointer to axienet local data structure.
+ * @lp:	Pointer to axienet common data structure.
  *
  * Disable the MDIO MDC. Called after a read/write operation
  */
-static void axienet_mdio_mdc_disable(struct axienet_local *lp)
+static void axienet_mdio_mdc_disable(struct axienet_common *lp)
 {
 	u32 mc_reg;
 
@@ -80,8 +81,9 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 {
 	u32 rc;
 	int ret;
-	struct axienet_local *lp = bus->priv;
+	struct axienet_common *lp = bus->priv;
 
+	guard(mutex)(&lp->reset_lock);
 	axienet_mdio_mdc_enable(lp);
 
 	ret = axienet_mdio_wait_until_ready(lp);
@@ -127,13 +129,14 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 			      u16 val)
 {
-	struct axienet_local *lp = bus->priv;
+	struct axienet_common *lp = bus->priv;
 	int ret;
 	u32 mcr;
 
 	dev_dbg(&bus->dev, "%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
+	guard(mutex)(&lp->reset_lock);
 	axienet_mdio_mdc_enable(lp);
 
 	ret = axienet_mdio_wait_until_ready(lp);
@@ -171,7 +174,7 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
  **/
 static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
 {
-	struct axienet_local *lp = bus->priv;
+	struct axienet_common *lp = bus->priv;
 	u32 mdio_freq = DEFAULT_MDIO_FREQ;
 	u32 host_clock;
 	u32 clk_div;
@@ -187,7 +190,7 @@ static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
 		/* Legacy fallback: detect CPU clock frequency and use as AXI
 		 * bus clock frequency. This only works on certain platforms.
 		 */
-		np1 = of_find_node_by_name(NULL, "lpu");
+		np1 = of_find_node_by_name(NULL, "cpu");
 		if (!np1) {
 			dev_warn(&bus->dev,
 				 "Could not find CPU device node.\n");
@@ -258,6 +261,7 @@ static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
 		"Setting MDIO clock divisor to %u/%u Hz host clock.\n",
 		lp->mii_clk_div, host_clock);
 
+	guard(mutex)(&lp->reset_lock);
 	axienet_mdio_mdc_enable(lp);
 
 	ret = axienet_mdio_wait_until_ready(lp);
@@ -269,7 +273,7 @@ static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
 
 /**
  * axienet_mdio_setup - MDIO setup function
- * @lp:		Pointer to axienet local data structure.
+ * @lp:		Pointer to axienet common data structure.
  *
  * Return:	0 on success, -ETIMEDOUT on a timeout, -EOVERFLOW on a clock
  *		divisor overflow, -ENOMEM when mdiobus_alloc (to allocate
@@ -278,7 +282,7 @@ static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
  * Sets up the MDIO interface by initializing the MDIO clock.
  * Register the MDIO interface.
  **/
-int axienet_mdio_setup(struct axienet_local *lp)
+int axienet_mdio_setup(struct axienet_common *lp)
 {
 	struct device_node *mdio_node;
 	struct mii_bus *bus;
@@ -295,18 +299,21 @@ int axienet_mdio_setup(struct axienet_local *lp)
 	bus->name = "Xilinx Axi Ethernet MDIO";
 	bus->read = axienet_mdio_read;
 	bus->write = axienet_mdio_write;
-	bus->parent = lp->dev;
+	bus->parent = &lp->pdev->dev;
 	lp->mii_bus = bus;
 
-	mdio_node = of_get_child_by_name(lp->dev->of_node, "mdio");
-	ret = axienet_mdio_enable(bus, mdio_node);
+	mdio_node = of_get_child_by_name(lp->pdev->dev.of_node, "mdio");
+	scoped_guard(mutex, &lp->reset_lock)
+		ret = axienet_mdio_enable(bus, mdio_node);
 	if (ret < 0)
 		goto unregister;
 
 	ret = of_mdiobus_register(bus, mdio_node);
 	of_node_put(mdio_node);
-	axienet_mdio_mdc_disable(lp);
+	scoped_guard(mutex, &lp->reset_lock)
+		axienet_mdio_mdc_disable(lp);
 	if (ret) {
+unregister:
 		mdiobus_free(bus);
 		lp->mii_bus = NULL;
 	}
@@ -315,11 +322,11 @@ int axienet_mdio_setup(struct axienet_local *lp)
 
 /**
  * axienet_mdio_teardown - MDIO remove function
- * @lp:		Pointer to axienet local data structure.
+ * @lp:		Pointer to axienet common data structure.
  *
  * Unregisters the MDIO and frees any associate memory for mii bus.
  */
-void axienet_mdio_teardown(struct axienet_local *lp)
+void axienet_mdio_teardown(struct axienet_common *lp)
 {
 	mdiobus_unregister(lp->mii_bus);
 	mdiobus_free(lp->mii_bus);
-- 
2.35.1.1320.gc452695387.dirty


