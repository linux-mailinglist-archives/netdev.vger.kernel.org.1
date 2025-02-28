Return-Path: <netdev+bounces-170517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A018A48E68
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB7816E718
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5A15533F;
	Fri, 28 Feb 2025 02:15:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24359139E;
	Fri, 28 Feb 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708920; cv=none; b=QxwG7mx5KDz1fAQN+QAINHmgxKvrAXaEFUdVYgR+T3gC0YCY2gVN2Wm8SN3A7UFkNIcCjUmf98oa7jLL3bQHHoZSpHqQM7OMNzpThnDG9TLW4mSYTEpbuILc0UjAawN/Dg5OS9qilPlTxuYChxZdcjw02SVxlu7+i7flP1DG+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708920; c=relaxed/simple;
	bh=lnSpolmVmbsLZUSV/Vy9GXK+El8CCUSe80kmO4zr6C0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=er5Yrfp0ld+m+mm72gy8HGsPk5t2mRJKTg+MCkhAHXQhHa3OREGTFDGkVB/hjL7HimXig+LxqFYs9vPzvoL4C0EfE2Kxbx6n5yZPlpWm9Zi0gFVyqkpq+rfnC60UvVxvdTNn0NMHF33mpgj3e9+PjvzFoSfPKgg/DDpZRDvnCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tnptw-000000006iu-3YZk;
	Fri, 28 Feb 2025 02:14:56 +0000
Date: Fri, 28 Feb 2025 02:14:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt7530: make use of REGMAP_IRQ
Message-ID: <0d50a1437c6d298b13fb19db546a20d10b643cc3.1740708525.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use REGMAP_IRQ instead of open-coding irq chip handler and mask/unmask.
This greatly simplifies the code and allows to remove (almost) all
interrupt related functions from mt7530.c.

Tested on MT7988A built-in switch as well as MT7531AE IC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/mt7530.c | 235 +++++++++------------------------------
 drivers/net/dsa/mt7530.h |   4 -
 3 files changed, 56 insertions(+), 184 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 2d10b4d6cfbb..bb9812b3b0e8 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -37,6 +37,7 @@ config NET_DSA_LANTIQ_GSWIP
 config NET_DSA_MT7530
 	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
 	select NET_DSA_TAG_MTK
+	select REGMAP_IRQ
 	imply NET_DSA_MT7530_MDIO
 	imply NET_DSA_MT7530_MMIO
 	help
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8422262febaf..a62a6d3d3a59 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2050,131 +2050,6 @@ mt7530_setup_gpio(struct mt7530_priv *priv)
 }
 #endif /* CONFIG_GPIOLIB */
 
-static irqreturn_t
-mt7530_irq_thread_fn(int irq, void *dev_id)
-{
-	struct mt7530_priv *priv = dev_id;
-	bool handled = false;
-	u32 val;
-	int p;
-
-	mt7530_mutex_lock(priv);
-	val = mt7530_mii_read(priv, MT7530_SYS_INT_STS);
-	mt7530_mii_write(priv, MT7530_SYS_INT_STS, val);
-	mt7530_mutex_unlock(priv);
-
-	for (p = 0; p < MT7530_NUM_PHYS; p++) {
-		if (BIT(p) & val) {
-			unsigned int irq;
-
-			irq = irq_find_mapping(priv->irq_domain, p);
-			handle_nested_irq(irq);
-			handled = true;
-		}
-	}
-
-	return IRQ_RETVAL(handled);
-}
-
-static void
-mt7530_irq_mask(struct irq_data *d)
-{
-	struct mt7530_priv *priv = irq_data_get_irq_chip_data(d);
-
-	priv->irq_enable &= ~BIT(d->hwirq);
-}
-
-static void
-mt7530_irq_unmask(struct irq_data *d)
-{
-	struct mt7530_priv *priv = irq_data_get_irq_chip_data(d);
-
-	priv->irq_enable |= BIT(d->hwirq);
-}
-
-static void
-mt7530_irq_bus_lock(struct irq_data *d)
-{
-	struct mt7530_priv *priv = irq_data_get_irq_chip_data(d);
-
-	mt7530_mutex_lock(priv);
-}
-
-static void
-mt7530_irq_bus_sync_unlock(struct irq_data *d)
-{
-	struct mt7530_priv *priv = irq_data_get_irq_chip_data(d);
-
-	mt7530_mii_write(priv, MT7530_SYS_INT_EN, priv->irq_enable);
-	mt7530_mutex_unlock(priv);
-}
-
-static struct irq_chip mt7530_irq_chip = {
-	.name = KBUILD_MODNAME,
-	.irq_mask = mt7530_irq_mask,
-	.irq_unmask = mt7530_irq_unmask,
-	.irq_bus_lock = mt7530_irq_bus_lock,
-	.irq_bus_sync_unlock = mt7530_irq_bus_sync_unlock,
-};
-
-static int
-mt7530_irq_map(struct irq_domain *domain, unsigned int irq,
-	       irq_hw_number_t hwirq)
-{
-	irq_set_chip_data(irq, domain->host_data);
-	irq_set_chip_and_handler(irq, &mt7530_irq_chip, handle_simple_irq);
-	irq_set_nested_thread(irq, true);
-	irq_set_noprobe(irq);
-
-	return 0;
-}
-
-static const struct irq_domain_ops mt7530_irq_domain_ops = {
-	.map = mt7530_irq_map,
-	.xlate = irq_domain_xlate_onecell,
-};
-
-static void
-mt7988_irq_mask(struct irq_data *d)
-{
-	struct mt7530_priv *priv = irq_data_get_irq_chip_data(d);
-
-	priv->irq_enable &= ~BIT(d->hwirq);
-	mt7530_mii_write(priv, MT7530_SYS_INT_EN, priv->irq_enable);
-}
-
-static void
-mt7988_irq_unmask(struct irq_data *d)
-{
-	struct mt7530_priv *priv = irq_data_get_irq_chip_data(d);
-
-	priv->irq_enable |= BIT(d->hwirq);
-	mt7530_mii_write(priv, MT7530_SYS_INT_EN, priv->irq_enable);
-}
-
-static struct irq_chip mt7988_irq_chip = {
-	.name = KBUILD_MODNAME,
-	.irq_mask = mt7988_irq_mask,
-	.irq_unmask = mt7988_irq_unmask,
-};
-
-static int
-mt7988_irq_map(struct irq_domain *domain, unsigned int irq,
-	       irq_hw_number_t hwirq)
-{
-	irq_set_chip_data(irq, domain->host_data);
-	irq_set_chip_and_handler(irq, &mt7988_irq_chip, handle_simple_irq);
-	irq_set_nested_thread(irq, true);
-	irq_set_noprobe(irq);
-
-	return 0;
-}
-
-static const struct irq_domain_ops mt7988_irq_domain_ops = {
-	.map = mt7988_irq_map,
-	.xlate = irq_domain_xlate_onecell,
-};
-
 static void
 mt7530_setup_mdio_irq(struct mt7530_priv *priv)
 {
@@ -2191,49 +2066,71 @@ mt7530_setup_mdio_irq(struct mt7530_priv *priv)
 	}
 }
 
+static const struct regmap_irq mt7530_irqs[] = {
+	REGMAP_IRQ_REG_LINE(0, 32), /* PHY 0 */
+	REGMAP_IRQ_REG_LINE(1, 32), /* PHY 1 */
+	REGMAP_IRQ_REG_LINE(2, 32), /* PHY 2 */
+	REGMAP_IRQ_REG_LINE(3, 32), /* PHY 3 */
+	REGMAP_IRQ_REG_LINE(4, 32), /* PHY 4 */
+	REGMAP_IRQ_REG_LINE(5, 32), /* PHY 5 */
+	REGMAP_IRQ_REG_LINE(6, 82), /* PHY 6 */
+	REGMAP_IRQ_REG_LINE(16, 32), /* MAC */
+	REGMAP_IRQ_REG_LINE(17, 32), /* BMU */
+	REGMAP_IRQ_REG_LINE(18, 32), /* MIB */
+	REGMAP_IRQ_REG_LINE(22, 32), /* ARL_COL_FULL_COL */
+	REGMAP_IRQ_REG_LINE(23, 32), /* ARL_COL_FULL */
+	REGMAP_IRQ_REG_LINE(24, 32), /* ARL_TLB_ERR */
+	REGMAP_IRQ_REG_LINE(25, 32), /* ARL_PKT_QERR */
+	REGMAP_IRQ_REG_LINE(26, 32), /* ARL_EQ_ERR */
+	REGMAP_IRQ_REG_LINE(27, 32), /* ARL_PKT_BC */
+	REGMAP_IRQ_REG_LINE(28, 32), /* ARL_SEC_IG1X */
+	REGMAP_IRQ_REG_LINE(29, 32), /* ARL_SEC_VLAN */
+	REGMAP_IRQ_REG_LINE(30, 32), /* ARL_SEC_TAG */
+	REGMAP_IRQ_REG_LINE(31, 32), /* ACL */
+};
+
+static const struct regmap_irq_chip mt7530_regmap_irq_chip = {
+	.name = KBUILD_MODNAME,
+	.status_base = MT7530_SYS_INT_STS,
+	.unmask_base = MT7530_SYS_INT_EN,
+	.ack_base = MT7530_SYS_INT_STS,
+	.init_ack_masked = true,
+	.irqs = mt7530_irqs,
+	.num_irqs = ARRAY_SIZE(mt7530_irqs),
+	.num_regs = 1,
+};
+
 static int
 mt7530_setup_irq(struct mt7530_priv *priv)
 {
+	struct regmap_irq_chip_data *irq_data;
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	int ret;
+	int irq, ret;
 
 	if (!of_property_read_bool(np, "interrupt-controller")) {
 		dev_info(dev, "no interrupt support\n");
 		return 0;
 	}
 
-	priv->irq = of_irq_get(np, 0);
-	if (priv->irq <= 0) {
-		dev_err(dev, "failed to get parent IRQ: %d\n", priv->irq);
-		return priv->irq ? : -EINVAL;
-	}
-
-	if (priv->id == ID_MT7988 || priv->id == ID_EN7581)
-		priv->irq_domain = irq_domain_add_linear(np, MT7530_NUM_PHYS,
-							 &mt7988_irq_domain_ops,
-							 priv);
-	else
-		priv->irq_domain = irq_domain_add_linear(np, MT7530_NUM_PHYS,
-							 &mt7530_irq_domain_ops,
-							 priv);
-
-	if (!priv->irq_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
+	irq = of_irq_get(np, 0);
+	if (irq <= 0) {
+		dev_err(dev, "failed to get parent IRQ: %d\n", irq);
+		return irq ? : -EINVAL;
 	}
 
 	/* This register must be set for MT7530 to properly fire interrupts */
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
 
-	ret = request_threaded_irq(priv->irq, NULL, mt7530_irq_thread_fn,
-				   IRQF_ONESHOT, KBUILD_MODNAME, priv);
-	if (ret) {
-		irq_domain_remove(priv->irq_domain);
-		dev_err(dev, "failed to request IRQ: %d\n", ret);
+	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
+					      priv->regmap, irq,
+					      IRQF_ONESHOT,
+					      0, &mt7530_regmap_irq_chip, &irq_data);
+	if (ret)
 		return ret;
-	}
+
+	priv->irq_domain = regmap_irq_get_domain(irq_data);
 
 	return 0;
 }
@@ -2253,26 +2150,6 @@ mt7530_free_mdio_irq(struct mt7530_priv *priv)
 	}
 }
 
-static void
-mt7530_free_irq_common(struct mt7530_priv *priv)
-{
-	free_irq(priv->irq, priv);
-	irq_domain_remove(priv->irq_domain);
-}
-
-static void
-mt7530_free_irq(struct mt7530_priv *priv)
-{
-	struct device_node *mnp, *np = priv->dev->of_node;
-
-	mnp = of_get_child_by_name(np, "mdio");
-	if (!mnp)
-		mt7530_free_mdio_irq(priv);
-	of_node_put(mnp);
-
-	mt7530_free_irq_common(priv);
-}
-
 static int
 mt7530_setup_mdio(struct mt7530_priv *priv)
 {
@@ -2307,13 +2184,13 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	bus->parent = dev;
 	bus->phy_mask = ~ds->phys_mii_mask;
 
-	if (priv->irq && !mnp)
+	if (priv->irq_domain && !mnp)
 		mt7530_setup_mdio_irq(priv);
 
 	ret = devm_of_mdiobus_register(dev, bus, mnp);
 	if (ret) {
 		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
-		if (priv->irq && !mnp)
+		if (priv->irq_domain && !mnp)
 			mt7530_free_mdio_irq(priv);
 	}
 
@@ -3096,8 +2973,6 @@ mt753x_setup(struct dsa_switch *ds)
 		return ret;
 
 	ret = mt7530_setup_mdio(priv);
-	if (ret && priv->irq)
-		mt7530_free_irq_common(priv);
 	if (ret)
 		return ret;
 
@@ -3108,11 +2983,11 @@ mt753x_setup(struct dsa_switch *ds)
 		priv->pcs[i].port = i;
 	}
 
-	if (priv->create_sgmii) {
+	if (priv->create_sgmii)
 		ret = priv->create_sgmii(priv);
-		if (ret && priv->irq)
-			mt7530_free_irq(priv);
-	}
+
+	if (ret && priv->irq_domain)
+		mt7530_free_mdio_irq(priv);
 
 	return ret;
 }
@@ -3356,8 +3231,8 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
 void
 mt7530_remove_common(struct mt7530_priv *priv)
 {
-	if (priv->irq)
-		mt7530_free_irq(priv);
+	if (priv->irq_domain)
+		mt7530_free_mdio_irq(priv);
 
 	dsa_unregister_switch(priv->ds);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 448200689f49..747ad2f9cd2b 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -815,9 +815,7 @@ struct mt753x_info {
  * @p5_mode:		Holding the current mode of port 5 of the MT7530 switch
  * @p5_sgmii:		Flag for distinguishing if port 5 of the MT7531 switch
  *			has got SGMII
- * @irq:		IRQ number of the switch
  * @irq_domain:		IRQ domain of the switch irq_chip
- * @irq_enable:		IRQ enable bits, synced to SYS_INT_EN
  * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
  * @active_cpu_ports:	Holding the active CPU ports
  * @mdiodev:		The pointer to the MDIO device structure
@@ -842,9 +840,7 @@ struct mt7530_priv {
 	struct mt753x_pcs	pcs[MT7530_NUM_PORTS];
 	/* protect among processes for registers access*/
 	struct mutex reg_mutex;
-	int irq;
 	struct irq_domain *irq_domain;
-	u32 irq_enable;
 	int (*create_sgmii)(struct mt7530_priv *priv);
 	u8 active_cpu_ports;
 	struct mdio_device *mdiodev;
-- 
2.48.1


