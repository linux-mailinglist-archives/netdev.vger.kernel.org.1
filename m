Return-Path: <netdev+bounces-59146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3A58197C9
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B16284702
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0022BE65;
	Wed, 20 Dec 2023 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIzTwYBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17833F9E3
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4874440b3a.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046432; x=1703651232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeFLkpiB9e7iREYudWc+Y8vKKazGSnV5plLxMStfV9Q=;
        b=cIzTwYBrrEFHmA+cwm1zxnA3F9RI5V7RsPExkXR1bh3GT0i7/b4vMSd6JquvK+N9QL
         9idSBjdxr7UNaEIK2vOk/0HLSu9SNQQ9W/3AxqMIWXhnC+QRWRsQ28x1/TMZcBjj0wEY
         TZOIS1IfC083sZG0cixwSs26HbyiGm+MVX4Rfd74NYSi+2/2pPv8nGYR8Hwp8fIl2XfT
         yK66g2upK4gUQzMp+q60jlZmkWCHSOSINf0J2qwMV8FYll59GMa7R8VC9Gn4QK3G8OKV
         CWyr2tjFIBRMP7JCBADFQby0WH2X/529GiUjuCjnnVpPYCFbdttUJkj7D+5faIOuXTOq
         a1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046432; x=1703651232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeFLkpiB9e7iREYudWc+Y8vKKazGSnV5plLxMStfV9Q=;
        b=O9BLhPOSW/sfQH7wktO8lN+DK86iNZX2TAi/wIqg4m+EGF7PxjWf/IA1ekWzC6jh0C
         GZreS5rCK1K7gPo32oef/wUrJoAUpM13eK+NhQ9WcoyYpnR3XmIL2SJ8BLIrGlh01CXO
         5PcMG0Pu5L9uazWYQrh4ompvyztPMCwW63n4G8dvrTNJD2tCuyju7RQcZ6XSni3ckLez
         tEK0c0Rdedt0SElT+P+oxUDbyJVrpMEU9waaBvv+5wey7uxp+3EXBBFpYwBj+HYBB2VB
         dTkdSreFK5jfT/K5neSd78VbntROgSQnhjEShkL6ZHbU8gsmMhTpTJlm7afxCo2Rg20N
         1RuA==
X-Gm-Message-State: AOJu0Ywlv97NFZQPk6Bo4Pkq2yMe0e1kX6/EIt+dk4M5j8z/ry4nffhs
	ZX0MpBWW43s0eiH5E24Hn6+sKL2h1R1Gits8
X-Google-Smtp-Source: AGHT+IGL+zNOIH4qrMxPCW+KuFefL7t7xNEo2lzyNfa5xOCIseNm1764hN9f/ce8M21HEmUj+JpD2Q==
X-Received: by 2002:a05:6a20:c329:b0:18b:208b:7043 with SMTP id dk41-20020a056a20c32900b0018b208b7043mr16764701pzb.49.1703046432200;
        Tue, 19 Dec 2023 20:27:12 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:27:11 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus setup to realtek-dsa
Date: Wed, 20 Dec 2023 01:24:28 -0300
Message-ID: <20231220042632.26825-6-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>
References: <20231220042632.26825-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the user MDIO driver, despite numerous references to SMI, including
its compatible string, there's nothing inherently specific about the SMI
interface in the user MDIO bus. Consequently, the code has been migrated
to the common module. All references to SMI have been eliminated, with
the exception of the compatible string, which will continue to function
as before.

The realtek-mdio will now use this driver instead of the generic DSA
driver ("dsa user smi"), which should not be used with OF[1].

There was a change in how the driver looks for the MDIO node in the
device tree. Now, it first checks for a child node named "mdio," which
is required by both interfaces in binding docs but used previously only
by realtek-mdio. If the node is not found, it will also look for a
compatible string, required only by SMI-connected devices in binding
docs and compatible with the old realtek-smi behavior.

The line assigning dev.of_node in mdio_bus has been removed since the
subsequent of_mdiobus_register will always overwrite it.

ds->user_mii_bus is only defined if all user ports do not declare a
phy-handle, providing a warning about the erroneous device tree[2].

With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
no longer necessary. Now, the realtek_variant.ds_ops can be used
directly.

The realtek_priv.setup_interface() has been removed as we can directly
call the new common function.

The switch unregistration and the MDIO node decrement in refcount were
moved into realtek_common_remove() as both interfaces now need to put
the MDIO node.

[1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/
[2] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 87 +++++++++++++++++++++++-
 drivers/net/dsa/realtek/realtek-common.h |  1 +
 drivers/net/dsa/realtek/realtek-mdio.c   |  6 --
 drivers/net/dsa/realtek/realtek-smi.c    | 68 ------------------
 drivers/net/dsa/realtek/realtek.h        |  5 +-
 drivers/net/dsa/realtek/rtl8365mb.c      | 49 ++-----------
 drivers/net/dsa/realtek/rtl8366rb.c      | 52 ++------------
 7 files changed, 100 insertions(+), 168 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index bf3933a99072..b1f0095d5bce 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/module.h>
+#include <linux/of_mdio.h>
 
 #include "realtek.h"
 #include "realtek-common.h"
@@ -21,6 +22,85 @@ void realtek_common_unlock(void *ctx)
 }
 EXPORT_SYMBOL_GPL(realtek_common_unlock);
 
+static int realtek_common_user_mdio_read(struct mii_bus *bus, int addr,
+					 int regnum)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_read(priv, addr, regnum);
+}
+
+static int realtek_common_user_mdio_write(struct mii_bus *bus, int addr,
+					  int regnum, u16 val)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_write(priv, addr, regnum, val);
+}
+
+int realtek_common_setup_user_mdio(struct dsa_switch *ds)
+{
+	const char *compatible = "realtek,smi-mdio";
+	struct realtek_priv *priv =  ds->priv;
+	struct device_node *phy_node;
+	struct device_node *mdio_np;
+	struct dsa_port *dp;
+	int ret;
+
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
+	if (!mdio_np) {
+		mdio_np = of_get_compatible_child(priv->dev->of_node, compatible);
+		if (!mdio_np) {
+			dev_err(priv->dev, "no MDIO bus node\n");
+			return -ENODEV;
+		}
+	}
+
+	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
+	if (!priv->user_mii_bus) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+	priv->user_mii_bus->priv = priv;
+	priv->user_mii_bus->name = "Realtek user MII";
+	priv->user_mii_bus->read = realtek_common_user_mdio_read;
+	priv->user_mii_bus->write = realtek_common_user_mdio_write;
+	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
+		 ds->index);
+	priv->user_mii_bus->parent = priv->dev;
+
+	/* When OF describes the MDIO, connecting ports with phy-handle,
+	 * ds->user_mii_bus should not be used *
+	 */
+	dsa_switch_for_each_user_port(dp, ds) {
+		phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
+		of_node_put(phy_node);
+		if (phy_node)
+			continue;
+
+		dev_warn(priv->dev,
+			 "DS user_mii_bus in use as '%s' is missing phy-handle",
+			 dp->name);
+		ds->user_mii_bus = priv->user_mii_bus;
+		break;
+	}
+
+	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
+	if (ret) {
+		dev_err(priv->dev, "unable to register MDIO bus %s\n",
+			priv->user_mii_bus->id);
+		goto err_put_node;
+	}
+
+	return 0;
+
+err_put_node:
+	of_node_put(mdio_np);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(realtek_common_setup_user_mdio);
+
 /* sets up driver private data struct, sets up regmaps, parse common device-tree
  * properties and finally issues a hardware reset.
  */
@@ -108,7 +188,7 @@ int realtek_common_register_switch(struct realtek_priv *priv)
 
 	priv->ds->priv = priv;
 	priv->ds->dev = priv->dev;
-	priv->ds->ops = priv->ds_ops;
+	priv->ds->ops = priv->variant->ds_ops;
 	priv->ds->num_ports = priv->num_ports;
 
 	ret = dsa_register_switch(priv->ds);
@@ -126,6 +206,11 @@ void realtek_common_remove(struct realtek_priv *priv)
 	if (!priv)
 		return;
 
+	dsa_unregister_switch(priv->ds);
+
+	if (priv->user_mii_bus)
+		of_node_put(priv->user_mii_bus->dev.of_node);
+
 	/* leave the device reset asserted */
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
index 518d091ff496..b1c2a50d85cd 100644
--- a/drivers/net/dsa/realtek/realtek-common.h
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -7,6 +7,7 @@
 
 void realtek_common_lock(void *ctx);
 void realtek_common_unlock(void *ctx);
+int realtek_common_setup_user_mdio(struct dsa_switch *ds);
 struct realtek_priv *
 realtek_common_probe(struct device *dev, struct regmap_config rc,
 		     struct regmap_config rc_nolock);
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 967f6c1e8df0..e2b5432eeb26 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -142,7 +142,6 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->bus = mdiodev->bus;
 	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
-	priv->ds_ops = priv->variant->ds_ops_mdio;
 
 	ret = realtek_common_register_switch(priv);
 	if (ret)
@@ -156,11 +155,6 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
-	if (!priv)
-		return;
-
-	dsa_unregister_switch(priv->ds);
-
 	realtek_common_remove(priv);
 }
 EXPORT_SYMBOL_GPL(realtek_mdio_remove);
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 2b2c6e34bae5..383689163057 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -31,7 +31,6 @@
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
@@ -339,63 +338,6 @@ static const struct regmap_config realtek_smi_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
-static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
-{
-	struct realtek_priv *priv = bus->priv;
-
-	return priv->ops->phy_read(priv, addr, regnum);
-}
-
-static int realtek_smi_mdio_write(struct mii_bus *bus, int addr, int regnum,
-				  u16 val)
-{
-	struct realtek_priv *priv = bus->priv;
-
-	return priv->ops->phy_write(priv, addr, regnum, val);
-}
-
-static int realtek_smi_setup_mdio(struct dsa_switch *ds)
-{
-	struct realtek_priv *priv =  ds->priv;
-	struct device_node *mdio_np;
-	int ret;
-
-	mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
-	if (!mdio_np) {
-		dev_err(priv->dev, "no MDIO bus node\n");
-		return -ENODEV;
-	}
-
-	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
-	if (!priv->user_mii_bus) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
-	priv->user_mii_bus->priv = priv;
-	priv->user_mii_bus->name = "SMI user MII";
-	priv->user_mii_bus->read = realtek_smi_mdio_read;
-	priv->user_mii_bus->write = realtek_smi_mdio_write;
-	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
-		 ds->index);
-	priv->user_mii_bus->dev.of_node = mdio_np;
-	priv->user_mii_bus->parent = priv->dev;
-	ds->user_mii_bus = priv->user_mii_bus;
-
-	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
-	if (ret) {
-		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-			priv->user_mii_bus->id);
-		goto err_put_node;
-	}
-
-	return 0;
-
-err_put_node:
-	of_node_put(mdio_np);
-
-	return ret;
-}
-
 int realtek_smi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -417,8 +359,6 @@ int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mdio);
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = realtek_smi_setup_mdio;
-	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = realtek_common_register_switch(priv);
 	if (ret)
@@ -432,14 +372,6 @@ void realtek_smi_remove(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
-	if (!priv)
-		return;
-
-	dsa_unregister_switch(priv->ds);
-
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
-
 	realtek_common_remove(priv);
 }
 EXPORT_SYMBOL_GPL(realtek_smi_remove);
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index fbd0616c1df3..7af6dcc1bb24 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -60,7 +60,6 @@ struct realtek_priv {
 
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
-	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
@@ -71,7 +70,6 @@ struct realtek_priv {
 	struct rtl8366_mib_counter *mib_counters;
 
 	const struct realtek_ops *ops;
-	int			(*setup_interface)(struct dsa_switch *ds);
 	int			(*write_reg_noack)(void *ctx, u32 addr, u32 data);
 
 	int			vlan_enabled;
@@ -115,8 +113,7 @@ struct realtek_ops {
 };
 
 struct realtek_variant {
-	const struct dsa_switch_ops *ds_ops_smi;
-	const struct dsa_switch_ops *ds_ops_mdio;
+	const struct dsa_switch_ops *ds_ops;
 	const struct realtek_ops *ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 58ec057b6c32..e890ad113ba3 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -828,17 +828,6 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return 0;
 }
 
-static int rtl8365mb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8365mb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8365mb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8365mb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static const struct rtl8365mb_extint *
 rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
 {
@@ -2017,12 +2006,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			goto out_teardown_irq;
-		}
+	ret = realtek_common_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		goto out_teardown_irq;
 	}
 
 	/* Start statistics counter polling */
@@ -2116,28 +2103,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
-	.get_tag_protocol = rtl8365mb_get_tag_protocol,
-	.change_tag_protocol = rtl8365mb_change_tag_protocol,
-	.setup = rtl8365mb_setup,
-	.teardown = rtl8365mb_teardown,
-	.phylink_get_caps = rtl8365mb_phylink_get_caps,
-	.phylink_mac_config = rtl8365mb_phylink_mac_config,
-	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
-	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.port_stp_state_set = rtl8365mb_port_stp_state_set,
-	.get_strings = rtl8365mb_get_strings,
-	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
-	.get_sset_count = rtl8365mb_get_sset_count,
-	.get_eth_phy_stats = rtl8365mb_get_phy_stats,
-	.get_eth_mac_stats = rtl8365mb_get_mac_stats,
-	.get_eth_ctrl_stats = rtl8365mb_get_ctrl_stats,
-	.get_stats64 = rtl8365mb_get_stats64,
-	.port_change_mtu = rtl8365mb_port_change_mtu,
-	.port_max_mtu = rtl8365mb_port_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
@@ -2146,8 +2112,6 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
 	.phylink_mac_config = rtl8365mb_phylink_mac_config,
 	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
 	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.phy_read = rtl8365mb_dsa_phy_read,
-	.phy_write = rtl8365mb_dsa_phy_write,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
@@ -2167,8 +2131,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 };
 
 const struct realtek_variant rtl8365mb_variant = {
-	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
+	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index e60a0a81d426..56619aa592ec 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1027,12 +1027,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			return -ENODEV;
-		}
+	ret = realtek_common_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		return -ENODEV;
 	}
 
 	return 0;
@@ -1772,17 +1770,6 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return ret;
 }
 
-static int rtl8366rb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8366rb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8366rb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8366rb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static int rtl8366rb_reset_chip(struct realtek_priv *priv)
 {
 	int timeout = 10;
@@ -1848,35 +1835,9 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
-	.get_tag_protocol = rtl8366_get_tag_protocol,
-	.setup = rtl8366rb_setup,
-	.phylink_get_caps = rtl8366rb_phylink_get_caps,
-	.phylink_mac_link_up = rtl8366rb_mac_link_up,
-	.phylink_mac_link_down = rtl8366rb_mac_link_down,
-	.get_strings = rtl8366_get_strings,
-	.get_ethtool_stats = rtl8366_get_ethtool_stats,
-	.get_sset_count = rtl8366_get_sset_count,
-	.port_bridge_join = rtl8366rb_port_bridge_join,
-	.port_bridge_leave = rtl8366rb_port_bridge_leave,
-	.port_vlan_filtering = rtl8366rb_vlan_filtering,
-	.port_vlan_add = rtl8366_vlan_add,
-	.port_vlan_del = rtl8366_vlan_del,
-	.port_enable = rtl8366rb_port_enable,
-	.port_disable = rtl8366rb_port_disable,
-	.port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
-	.port_bridge_flags = rtl8366rb_port_bridge_flags,
-	.port_stp_state_set = rtl8366rb_port_stp_state_set,
-	.port_fast_age = rtl8366rb_port_fast_age,
-	.port_change_mtu = rtl8366rb_change_mtu,
-	.port_max_mtu = rtl8366rb_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
-	.phy_read = rtl8366rb_dsa_phy_read,
-	.phy_write = rtl8366rb_dsa_phy_write,
 	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
@@ -1915,8 +1876,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 };
 
 const struct realtek_variant rtl8366rb_variant = {
-	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
+	.ds_ops = &rtl8366rb_switch_ops,
 	.ops = &rtl8366rb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xa9,
-- 
2.43.0


