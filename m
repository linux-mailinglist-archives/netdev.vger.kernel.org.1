Return-Path: <netdev+bounces-234745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26EC26BAD
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D096C464CD3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5853491C5;
	Fri, 31 Oct 2025 19:23:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445230DD31;
	Fri, 31 Oct 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938592; cv=none; b=WWnRALHOS5CssapiqUfMTPTYAk/zpGfiTY7usRSWzQPubG6N0htrEShzBV2c2Q5mGUkwvl/PPqNsZjp4fjz3s5dYiqMhPtGJDeF02ribhEQYIy+snvpyeqP1bdmNzSpYlE5Se7MH9HgwzBhdQtQX005KNqA+p5YxWP7zseEdnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938592; c=relaxed/simple;
	bh=CSxnXsB58gbXocXTo/y4KcJI+9aNHSPU0QxadsecUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMGMwL0Yluo0Xj3cKHhYn8OSyNd2RGHUDpSmnRwzkCj9j4+GY3HUmpwtdTEh5L70AfaIIRXOIHtdCBJviqULf2jpLTXn5cxQ4boGdymqpTPCusPOGbfviIqjEaPNVatT8LVqSxz6kZpo6gjNZRSSe6P0oySXhCzCZuVvaeOf8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEuiG-000000005vf-3lID;
	Fri, 31 Oct 2025 19:23:05 +0000
Date: Fri, 31 Oct 2025 19:23:01 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v6 12/12] net: dsa: add driver for MaxLinear GSW1xx
 switch family
Message-ID: <6b62366d0414931f77975ae7a3594cfcb0b8c02c.1761938079.git.daniel@makrotopia.org>
References: <cover.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761938079.git.daniel@makrotopia.org>

Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
and Intel GRX MIPS router SoCs. The main difference is that instead of
using memory-mapped I/O to communicate with the host CPU these ICs are
connected via MDIO (or SPI, which isn't supported by this driver).
Implement the regmap API to access the switch registers over MDIO to allow
reusing lantiq_gswip_common for all core functionality.

The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
2500Base-X, which can either be used to connect an external PHY or SFP
cage, or as the CPU port. Support for the SerDes interface is implemented
in this driver using the phylink_pcs interface.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 * break out PCS reset into dedicated function
 * drop hacky support for reverse-SGMII
 * remove again the custom properties for TX and RX inverted SerDes
   PCS in favor of waiting for generic properties to land

v3:
 * avoid disrupting link when calling .pcs_config()
 * sort functions and phylink_pcs_ops instance in same order as
   struct definition
 * always set bootstrap override bits and add explanatory comment
 * move definitions to separate header file
 * add custom properties for TX and RX inverted data on the SerDes
   interface

v2: remove left-overs of 4k VLAN support (will be added in future)

 drivers/net/dsa/lantiq/Kconfig          |  12 +
 drivers/net/dsa/lantiq/Makefile         |   1 +
 drivers/net/dsa/lantiq/lantiq_gswip.h   |   1 +
 drivers/net/dsa/lantiq/mxl-gsw1xx.c     | 733 ++++++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h     | 126 ++++
 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h | 154 +++++
 6 files changed, 1027 insertions(+)
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.h
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h

diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
index 78db82a47d09..4a9771be5d58 100644
--- a/drivers/net/dsa/lantiq/Kconfig
+++ b/drivers/net/dsa/lantiq/Kconfig
@@ -10,3 +10,15 @@ config NET_DSA_LANTIQ_GSWIP
 	help
 	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
 	  the xrx200 / VR9 SoC.
+
+config NET_DSA_MXL_GSW1XX
+	tristate "MaxLinear GSW1xx Ethernet switch support"
+	select NET_DSA_TAG_MXL_GSW1XX
+	select NET_DSA_LANTIQ_COMMON
+	help
+	  This enables support for the MaxLinear GSW1xx family of 1GE switches
+	    GSW120 4 port, 2 PHYs, RGMII & SGMII/2500Base-X
+	    GSW125 4 port, 2 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
+	    GSW140 6 port, 4 PHYs, RGMII & SGMII/2500Base-X
+	    GSW141 6 port, 4 PHYs, RGMII & SGMII
+	    GSW145 6 port, 4 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
diff --git a/drivers/net/dsa/lantiq/Makefile b/drivers/net/dsa/lantiq/Makefile
index 65ffa7bb71aa..85fce605310b 100644
--- a/drivers/net/dsa/lantiq/Makefile
+++ b/drivers/net/dsa/lantiq/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_LANTIQ_COMMON) += lantiq_gswip_common.o
+obj-$(CONFIG_NET_DSA_MXL_GSW1XX) += mxl-gsw1xx.o
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 0c32ec85e127..9c38e51a75e8 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -255,6 +255,7 @@ struct gswip_hw_info {
 	unsigned int allowed_cpu_ports;
 	unsigned int mii_ports;
 	int mii_port_reg_offset;
+	bool supports_2500m;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
 	enum dsa_tag_protocol tag_protocol;
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
new file mode 100644
index 000000000000..0816c61a47f1
--- /dev/null
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -0,0 +1,733 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* DSA Driver for MaxLinear GSW1xx switch devices
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (C) 2023 - 2024 MaxLinear Inc.
+ * Copyright (C) 2022 Snap One, LLC.  All rights reserved.
+ * Copyright (C) 2017 - 2019 Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2010 Lantiq Deutschland
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_mdio.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+
+#include "lantiq_gswip.h"
+#include "mxl-gsw1xx.h"
+#include "mxl-gsw1xx_pce.h"
+
+struct gsw1xx_priv {
+	struct mdio_device	*mdio_dev;
+	int			smdio_badr;
+	struct			regmap *sgmii;
+	struct			regmap *gpio;
+	struct			regmap *clk;
+	struct			regmap *shell;
+	struct			phylink_pcs pcs;
+	phy_interface_t		tbi_interface;
+	struct gswip_priv	gswip;
+};
+
+static int gsw1xx_config_smdio_badr(struct gsw1xx_priv *priv,
+				    unsigned int reg)
+{
+	struct mii_bus *bus = priv->mdio_dev->bus;
+	int sw_addr = priv->mdio_dev->addr;
+	int smdio_badr = priv->smdio_badr;
+	int res;
+
+	if (smdio_badr == GSW1XX_SMDIO_BADR_UNKNOWN ||
+	    reg - smdio_badr >= GSW1XX_SMDIO_BADR ||
+	    smdio_badr > reg) {
+		/* Configure the Switch Base Address */
+		smdio_badr = reg & ~GENMASK(3, 0);
+		res = __mdiobus_write(bus, sw_addr, GSW1XX_SMDIO_BADR, smdio_badr);
+		if (res < 0) {
+			dev_err(&priv->mdio_dev->dev,
+				"%s: Error %d, configuring switch base\n",
+				__func__, res);
+			return res;
+		}
+		priv->smdio_badr = smdio_badr;
+	}
+
+	return smdio_badr;
+}
+
+static int gsw1xx_regmap_read(void *context, unsigned int reg,
+			      unsigned int *val)
+{
+	struct gsw1xx_priv *priv = context;
+	struct mii_bus *bus = priv->mdio_dev->bus;
+	int sw_addr = priv->mdio_dev->addr;
+	int smdio_badr;
+	int res;
+
+	smdio_badr = gsw1xx_config_smdio_badr(priv, reg);
+	if (smdio_badr < 0)
+		return smdio_badr;
+
+	res = __mdiobus_read(bus, sw_addr, reg - smdio_badr);
+	if (res < 0) {
+		dev_err(&priv->mdio_dev->dev, "%s: Error %d reading 0x%x\n",
+			__func__, res, reg);
+		return res;
+	}
+
+	*val = res;
+
+	return 0;
+}
+
+static int gsw1xx_regmap_write(void *context, unsigned int reg,
+			       unsigned int val)
+{
+	struct gsw1xx_priv *priv = context;
+	struct mii_bus *bus = priv->mdio_dev->bus;
+	int sw_addr = priv->mdio_dev->addr;
+	int smdio_badr;
+	int res;
+
+	smdio_badr = gsw1xx_config_smdio_badr(priv, reg);
+	if (smdio_badr < 0)
+		return smdio_badr;
+
+	res = __mdiobus_write(bus, sw_addr, reg - smdio_badr, val);
+	if (res < 0)
+		dev_err(&priv->mdio_dev->dev,
+			"%s: Error %d, writing 0x%x:0x%x\n", __func__, res, reg,
+			val);
+
+	return res;
+}
+
+static const struct regmap_bus gsw1xx_regmap_bus = {
+	.reg_write = gsw1xx_regmap_write,
+	.reg_read = gsw1xx_regmap_read,
+};
+
+static void gsw1xx_mdio_regmap_lock(void *mdio_lock)
+{
+	mutex_lock_nested(mdio_lock, MDIO_MUTEX_NESTED);
+}
+
+static void gsw1xx_mdio_regmap_unlock(void *mdio_lock)
+{
+	mutex_unlock(mdio_lock);
+}
+
+static unsigned int gsw1xx_pcs_inband_caps(struct phylink_pcs *pcs,
+					   phy_interface_t interface)
+{
+	return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+}
+
+static struct gsw1xx_priv *pcs_to_gsw1xx(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct gsw1xx_priv, pcs);
+}
+
+static int gsw1xx_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
+
+	/* Deassert SGMII shell reset */
+	return regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+				 GSW1XX_RST_REQ_SGMII_SHELL);
+}
+
+static void gsw1xx_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
+
+	/* Assert SGMII shell reset */
+	regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+			GSW1XX_RST_REQ_SGMII_SHELL);
+
+	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
+}
+
+static void gsw1xx_pcs_get_state(struct phylink_pcs *pcs,
+				 unsigned int neg_mode,
+				 struct phylink_link_state *state)
+{
+	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(priv->sgmii, GSW1XX_SGMII_TBI_TBISTAT, &val);
+	if (ret < 0)
+		return;
+
+	state->link = !!(val & GSW1XX_SGMII_TBI_TBISTAT_LINK);
+	state->an_complete = !!(val & GSW1XX_SGMII_TBI_TBISTAT_AN_COMPLETE);
+
+	ret = regmap_read(priv->sgmii, GSW1XX_SGMII_TBI_LPSTAT, &val);
+	if (ret < 0)
+		return;
+
+	state->duplex = (val & GSW1XX_SGMII_TBI_LPSTAT_DUPLEX) ?
+			 DUPLEX_FULL : DUPLEX_HALF;
+	if (val & GSW1XX_SGMII_TBI_LPSTAT_PAUSE_RX)
+		state->pause |= MLO_PAUSE_RX;
+
+	if (val & GSW1XX_SGMII_TBI_LPSTAT_PAUSE_TX)
+		state->pause |= MLO_PAUSE_TX;
+
+	switch (FIELD_GET(GSW1XX_SGMII_TBI_LPSTAT_SPEED, val)) {
+	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	case GSW1XX_SGMII_TBI_LPSTAT_SPEED_NOSGMII:
+		if (state->interface == PHY_INTERFACE_MODE_1000BASEX)
+			state->speed = SPEED_1000;
+		else if (state->interface == PHY_INTERFACE_MODE_2500BASEX)
+			state->speed = SPEED_2500;
+		else
+			state->speed = SPEED_UNKNOWN;
+		break;
+	}
+}
+
+static int gsw1xx_pcs_phy_xaui_write(struct gsw1xx_priv *priv, u16 addr,
+				     u16 data)
+{
+	int ret, val;
+
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_D, data);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_A, addr);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_C,
+			   GSW1XX_SGMII_PHY_WRITE |
+			   GSW1XX_SGMII_PHY_RESET_N);
+	if (ret < 0)
+		return ret;
+
+	return regmap_read_poll_timeout(priv->sgmii, GSW1XX_SGMII_PHY_C,
+					val, val & GSW1XX_SGMII_PHY_STATUS,
+					1000, 100000);
+}
+
+static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
+{
+	int ret;
+	u16 val;
+
+	/* Assert and deassert SGMII shell reset */
+	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+			      GSW1XX_RST_REQ_SGMII_SHELL);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+				GSW1XX_RST_REQ_SGMII_SHELL);
+	if (ret < 0)
+		return ret;
+
+	/* Hardware Bringup FSM Enable  */
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_HWBU_CTRL,
+			   GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM |
+			   GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Configure SGMII PHY Receiver */
+	val = FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_EQ,
+			 GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF) |
+	      GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN |
+	      GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN |
+	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
+			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
+
+	/* TODO: Take care of inverted RX pair once generic property is
+	 *       available
+	 */
+
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
+	if (ret < 0)
+		return ret;
+
+	val = FIELD_PREP(GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL,
+			 GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF);
+
+	/* TODO: Take care of inverted TX pair once generic property is
+	 *       available
+	 */
+
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_TX0_CFG3, val);
+	if (ret < 0)
+		return ret;
+
+	/* Reset and Release TBI */
+	val = GSW1XX_SGMII_TBI_TBICTL_INITTBI | GSW1XX_SGMII_TBI_TBICTL_ENTBI |
+	      GSW1XX_SGMII_TBI_TBICTL_CRSTRR | GSW1XX_SGMII_TBI_TBICTL_CRSOFF;
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TBICTL, val);
+	if (ret < 0)
+		return ret;
+	val &= ~GSW1XX_SGMII_TBI_TBICTL_INITTBI;
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TBICTL, val);
+	if (ret < 0)
+		return ret;
+
+	/* Release Tx Data Buffers */
+	ret = regmap_set_bits(priv->sgmii, GSW1XX_SGMII_PCS_TXB_CTL,
+			      GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB);
+	if (ret < 0)
+		return ret;
+	ret = regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_PCS_TXB_CTL,
+				GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB);
+	if (ret < 0)
+		return ret;
+
+	/* Release Rx Data Buffers */
+	ret = regmap_set_bits(priv->sgmii, GSW1XX_SGMII_PCS_RXB_CTL,
+			      GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB);
+	if (ret < 0)
+		return ret;
+	return regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_PCS_RXB_CTL,
+				 GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB);
+}
+
+static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
+	u16 txaneg, anegctl, nco_ctrl;
+	bool reconf = false;
+	int ret = 0;
+
+	/* do not unnecessarily disrupt link and skip resetting the hardware in
+	 * case the PCS has previously been successfully configured for this
+	 * interface mode
+	 */
+	if (priv->tbi_interface == interface)
+		reconf = true;
+
+	/* mark PCS configuration as incomplete */
+	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
+
+	if (!reconf)
+		ret = gsw1xx_pcs_reset(priv);
+
+	if (ret)
+		return ret;
+
+	/* override bootstrap pin settings
+	 * OVRANEG sets ANEG Mode, Enable ANEG and restart ANEG to be
+	 * taken from bits ANMODE, ANEGEN, RANEG of the ANEGCTL register.
+	 * OVERABL sets ability bits in tx_config_reg to be taken from
+	 * the TXANEGH and TXANEGL registers.
+	 */
+	anegctl = GSW1XX_SGMII_TBI_ANEGCTL_OVRANEG |
+		  GSW1XX_SGMII_TBI_ANEGCTL_OVRABL;
+
+	switch (phylink_get_link_timer_ns(interface)) {
+	case 10000:
+		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
+				      GSW1XX_SGMII_TBI_ANEGCTL_LT_10US);
+		break;
+	case 1600000:
+		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
+				      GSW1XX_SGMII_TBI_ANEGCTL_LT_1_6MS);
+		break;
+	case 5000000:
+		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
+				      GSW1XX_SGMII_TBI_ANEGCTL_LT_5MS);
+		break;
+	case 10000000:
+		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
+				      GSW1XX_SGMII_TBI_ANEGCTL_LT_10MS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (neg_mode & PHYLINK_PCS_NEG_INBAND)
+		anegctl |= GSW1XX_SGMII_TBI_ANEGCTL_ANEGEN;
+
+	txaneg = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+
+	if (interface == PHY_INTERFACE_MODE_SGMII) {
+		/* lacking a defined reverse-SGMII interface mode this
+		 * driver only supports SGMII (MAC side) for now
+		 */
+		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
+				      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_MAC);
+		txaneg |= ADVERTISE_LPACK;
+	} else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+		   interface == PHY_INTERFACE_MODE_2500BASEX) {
+		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
+				      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_1000BASEX);
+	} else {
+		dev_err(priv->gswip.dev, "%s: wrong interface mode %s\n",
+			__func__, phy_modes(interface));
+		return -EINVAL;
+	}
+
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TXANEGH,
+			   FIELD_GET(GENMASK(15, 8), txaneg));
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TXANEGL,
+			   FIELD_GET(GENMASK(7, 0), txaneg));
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL, anegctl);
+	if (ret < 0)
+		return ret;
+
+	if (!reconf) {
+		/* setup SerDes clock speed */
+		if (interface == PHY_INTERFACE_MODE_2500BASEX)
+			nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
+		else
+			nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
+
+		ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
+					 GSW1XX_SGMII_HSP_MASK |
+					 GSW1XX_SGMII_SEL,
+					 nco_ctrl);
+		if (ret)
+			return ret;
+
+		ret = gsw1xx_pcs_phy_xaui_write(priv, 0x30, 0x80);
+		if (ret)
+			return ret;
+	}
+
+	/* PCS configuration has now been completed, store mode to prevent
+	 * disrupting the link in case of future calls of this function for the
+	 * same interface mode.
+	 */
+	priv->tbi_interface = interface;
+
+	return 0;
+}
+
+static void gsw1xx_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
+
+	regmap_set_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
+			GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
+}
+
+static void gsw1xx_pcs_link_up(struct phylink_pcs *pcs,
+			       unsigned int neg_mode,
+			       phy_interface_t interface, int speed,
+			       int duplex)
+{
+	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
+	u16 lpstat;
+
+	/* When in-band AN is enabled hardware will set lpstat */
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		return;
+
+	/* Force speed and duplex settings */
+	if (interface == PHY_INTERFACE_MODE_SGMII) {
+		if (speed == SPEED_10)
+			lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
+					    GSW1XX_SGMII_TBI_LPSTAT_SPEED_10);
+		else if (speed == SPEED_100)
+			lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
+					    GSW1XX_SGMII_TBI_LPSTAT_SPEED_100);
+		else
+			lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
+					    GSW1XX_SGMII_TBI_LPSTAT_SPEED_1000);
+	} else {
+		lpstat = FIELD_PREP(GSW1XX_SGMII_TBI_LPSTAT_SPEED,
+				    GSW1XX_SGMII_TBI_LPSTAT_SPEED_NOSGMII);
+	}
+
+	if (duplex == DUPLEX_FULL)
+		lpstat |= GSW1XX_SGMII_TBI_LPSTAT_DUPLEX;
+
+	regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_LPSTAT, lpstat);
+}
+
+static const struct phylink_pcs_ops gsw1xx_pcs_ops = {
+	.pcs_inband_caps = gsw1xx_pcs_inband_caps,
+	.pcs_enable = gsw1xx_pcs_enable,
+	.pcs_disable = gsw1xx_pcs_disable,
+	.pcs_get_state = gsw1xx_pcs_get_state,
+	.pcs_config = gsw1xx_pcs_config,
+	.pcs_an_restart = gsw1xx_pcs_an_restart,
+	.pcs_link_up = gsw1xx_pcs_link_up,
+};
+
+static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
+				    struct phylink_config *config)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000;
+
+	switch (port) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+	case 4: /* port 4: SGMII */
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		if (priv->hw_info->supports_2500m) {
+			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+				  config->supported_interfaces);
+			config->mac_capabilities |= MAC_2500FD;
+		}
+		return; /* no support for EEE on SGMII port */
+	case 5: /* port 5: RGMII or RMII */
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  config->supported_interfaces);
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	}
+
+	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
+	config->lpi_timer_default = 20;
+	memcpy(config->lpi_interfaces, config->supported_interfaces,
+	       sizeof(config->lpi_interfaces));
+}
+
+static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
+							 phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *gswip_priv = dp->ds->priv;
+	struct gsw1xx_priv *gsw1xx_priv = container_of(gswip_priv,
+						       struct gsw1xx_priv,
+						       gswip);
+
+	switch (dp->index) {
+	case GSW1XX_SGMII_PORT:
+		return &gsw1xx_priv->pcs;
+	default:
+		return NULL;
+	}
+}
+
+static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
+					 const char *name,
+					 unsigned int reg_base,
+					 unsigned int max_register)
+{
+	const struct regmap_config config = {
+		.name = name,
+		.reg_bits = 16,
+		.val_bits = 16,
+		.reg_base = reg_base,
+		.max_register = max_register,
+		.lock = gsw1xx_mdio_regmap_lock,
+		.unlock = gsw1xx_mdio_regmap_unlock,
+		.lock_arg = &priv->mdio_dev->bus->mdio_lock,
+	};
+
+	return devm_regmap_init(&priv->mdio_dev->dev, &gsw1xx_regmap_bus,
+				priv, &config);
+}
+
+static int gsw1xx_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct gsw1xx_priv *priv;
+	u32 version;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->mdio_dev = mdiodev;
+	priv->smdio_badr = GSW1XX_SMDIO_BADR_UNKNOWN;
+
+	priv->gswip.dev = dev;
+	priv->gswip.hw_info = of_device_get_match_data(dev);
+	if (!priv->gswip.hw_info)
+		return -EINVAL;
+
+	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
+					       GSW1XX_SWITCH_BASE, 0xfff);
+	if (IS_ERR(priv->gswip.gswip))
+		return PTR_ERR(priv->gswip.gswip);
+
+	priv->gswip.mdio = gsw1xx_regmap_init(priv, "mdio", GSW1XX_MMDIO_BASE,
+					      0xff);
+	if (IS_ERR(priv->gswip.mdio))
+		return PTR_ERR(priv->gswip.mdio);
+
+	priv->gswip.mii = gsw1xx_regmap_init(priv, "mii", GSW1XX_RGMII_BASE,
+					     0xff);
+	if (IS_ERR(priv->gswip.mii))
+		return PTR_ERR(priv->gswip.mii);
+
+	priv->sgmii = gsw1xx_regmap_init(priv, "sgmii", GSW1XX_SGMII_BASE,
+					 0xfff);
+	if (IS_ERR(priv->sgmii))
+		return PTR_ERR(priv->sgmii);
+
+	priv->gpio = gsw1xx_regmap_init(priv, "gpio", GSW1XX_GPIO_BASE, 0xff);
+	if (IS_ERR(priv->gpio))
+		return PTR_ERR(priv->gpio);
+
+	priv->clk = gsw1xx_regmap_init(priv, "clk", GSW1XX_CLK_BASE, 0xff);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->shell = gsw1xx_regmap_init(priv, "shell", GSW1XX_SHELL_BASE,
+					 0xff);
+	if (IS_ERR(priv->shell))
+		return PTR_ERR(priv->shell);
+
+	priv->pcs.ops = &gsw1xx_pcs_ops;
+	priv->pcs.poll = true;
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  priv->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  priv->pcs.supported_interfaces);
+	if (priv->gswip.hw_info->supports_2500m)
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  priv->pcs.supported_interfaces);
+	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
+
+	/* assert SGMII reset to power down SGMII unit */
+	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+			      GSW1XX_RST_REQ_SGMII_SHELL);
+	if (ret < 0)
+		return ret;
+
+	/* configure GPIO pin-mux for MMDIO in case of external PHY connected to
+	 * SGMII or RGMII as slave interface
+	 */
+	regmap_set_bits(priv->gpio, GPIO_ALTSEL0, 3);
+	regmap_set_bits(priv->gpio, GPIO_ALTSEL1, 3);
+
+	ret = regmap_read(priv->gswip.gswip, GSWIP_VERSION, &version);
+	if (ret)
+		return ret;
+
+	ret = gswip_probe_common(&priv->gswip, version);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, &priv->gswip);
+
+	return 0;
+}
+
+static void gsw1xx_remove(struct mdio_device *mdiodev)
+{
+	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
+
+	if (!priv)
+		return;
+
+	gswip_disable_switch(priv);
+
+	dsa_unregister_switch(priv->ds);
+}
+
+static void gsw1xx_shutdown(struct mdio_device *mdiodev)
+{
+	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
+
+	if (!priv)
+		return;
+
+	dev_set_drvdata(&mdiodev->dev, NULL);
+
+	gswip_disable_switch(priv);
+}
+
+static const struct gswip_hw_info gsw12x_data = {
+	.max_ports		= GSW1XX_PORTS,
+	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
+	.mii_ports		= BIT(GSW1XX_MII_PORT),
+	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
+	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
+	.supports_2500m		= true,
+	.pce_microcode		= &gsw1xx_pce_microcode,
+	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
+	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+};
+
+static const struct gswip_hw_info gsw140_data = {
+	.max_ports		= GSW1XX_PORTS,
+	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
+	.mii_ports		= BIT(GSW1XX_MII_PORT),
+	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
+	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
+	.supports_2500m		= true,
+	.pce_microcode		= &gsw1xx_pce_microcode,
+	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
+	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+};
+
+static const struct gswip_hw_info gsw141_data = {
+	.max_ports		= GSW1XX_PORTS,
+	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
+	.mii_ports		= BIT(GSW1XX_MII_PORT),
+	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
+	.phylink_get_caps	= gsw1xx_phylink_get_caps,
+	.pce_microcode		= &gsw1xx_pce_microcode,
+	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
+	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+};
+
+/*
+ * GSW125 is the industrial temperature version of GSW120.
+ * GSW145 is the industrial temperature version of GSW140.
+ */
+static const struct of_device_id gsw1xx_of_match[] = {
+	{ .compatible = "maxlinear,gsw120", .data = &gsw12x_data },
+	{ .compatible = "maxlinear,gsw125", .data = &gsw12x_data },
+	{ .compatible = "maxlinear,gsw140", .data = &gsw140_data },
+	{ .compatible = "maxlinear,gsw141", .data = &gsw141_data },
+	{ .compatible = "maxlinear,gsw145", .data = &gsw140_data },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, gsw1xx_of_match);
+
+static struct mdio_driver gsw1xx_driver = {
+	.probe		= gsw1xx_probe,
+	.remove		= gsw1xx_remove,
+	.shutdown	= gsw1xx_shutdown,
+	.mdiodrv.driver	= {
+		.name = "mxl-gsw1xx",
+		.of_match_table = gsw1xx_of_match,
+	},
+};
+
+mdio_module_driver(gsw1xx_driver);
+
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_DESCRIPTION("Driver for MaxLinear GSW1xx ethernet switch");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
new file mode 100644
index 000000000000..38e03c048a26
--- /dev/null
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Register definitions for MaxLinear GSW1xx series switches
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (C) 2023 - 2024 MaxLinear Inc.
+ */
+#ifndef __MXL_GSW1XX_H
+#define __MXL_GSW1XX_H
+
+#include <linux/bitfield.h>
+
+#define GSW1XX_PORTS				6
+/* Port used for RGMII or optional RMII */
+#define GSW1XX_MII_PORT				5
+/* Port used for SGMII */
+#define GSW1XX_SGMII_PORT			4
+
+#define GSW1XX_SYS_CLK_FREQ			340000000
+
+/* SMDIO switch register base address */
+#define GSW1XX_SMDIO_BADR			0x1f
+#define  GSW1XX_SMDIO_BADR_UNKNOWN		-1
+
+/* GSW1XX SGMII PCS */
+#define GSW1XX_SGMII_BASE			0xd000
+#define GSW1XX_SGMII_PHY_HWBU_CTRL		0x009
+#define  GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM	BIT(0)
+#define  GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN	BIT(3)
+#define GSW1XX_SGMII_TBI_TXANEGH		0x300
+#define GSW1XX_SGMII_TBI_TXANEGL		0x301
+#define GSW1XX_SGMII_TBI_ANEGCTL		0x304
+#define  GSW1XX_SGMII_TBI_ANEGCTL_LT		GENMASK(1, 0)
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_10US	0
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_1_6MS	1
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_5MS	2
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_10MS	3
+#define  GSW1XX_SGMII_TBI_ANEGCTL_ANEGEN	BIT(2)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_RANEG		BIT(3)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_OVRABL	BIT(4)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_OVRANEG	BIT(5)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_ANMODE	GENMASK(7, 6)
+#define   GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_1000BASEX	1
+#define   GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_PHY	2
+#define   GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_MAC	3
+#define  GSW1XX_SGMII_TBI_ANEGCTL_BCOMP		BIT(15)
+
+#define GSW1XX_SGMII_TBI_TBICTL			0x305
+#define  GSW1XX_SGMII_TBI_TBICTL_INITTBI	BIT(0)
+#define  GSW1XX_SGMII_TBI_TBICTL_ENTBI		BIT(1)
+#define  GSW1XX_SGMII_TBI_TBICTL_CRSTRR		BIT(4)
+#define  GSW1XX_SGMII_TBI_TBICTL_CRSOFF		BIT(5)
+#define GSW1XX_SGMII_TBI_TBISTAT		0x309
+#define  GSW1XX_SGMII_TBI_TBISTAT_LINK		BIT(0)
+#define  GSW1XX_SGMII_TBI_TBISTAT_AN_COMPLETE	BIT(1)
+#define GSW1XX_SGMII_TBI_LPSTAT			0x30a
+#define  GSW1XX_SGMII_TBI_LPSTAT_DUPLEX		BIT(0)
+#define  GSW1XX_SGMII_TBI_LPSTAT_PAUSE_RX	BIT(1)
+#define  GSW1XX_SGMII_TBI_LPSTAT_PAUSE_TX	BIT(2)
+#define  GSW1XX_SGMII_TBI_LPSTAT_SPEED		GENMASK(6, 5)
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_10	0
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_100	1
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_1000	2
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_NOSGMII	3
+#define GSW1XX_SGMII_PHY_D			0x100
+#define GSW1XX_SGMII_PHY_A			0x101
+#define GSW1XX_SGMII_PHY_C			0x102
+#define  GSW1XX_SGMII_PHY_STATUS		BIT(0)
+#define  GSW1XX_SGMII_PHY_READ			BIT(4)
+#define  GSW1XX_SGMII_PHY_WRITE			BIT(8)
+#define  GSW1XX_SGMII_PHY_RESET_N		BIT(12)
+#define GSW1XX_SGMII_PCS_RXB_CTL		0x401
+#define  GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB	BIT(1)
+#define GSW1XX_SGMII_PCS_TXB_CTL		0x404
+#define  GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB	BIT(1)
+
+#define GSW1XX_SGMII_PHY_RX0_CFG2		0x004
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_EQ		GENMASK(2, 0)
+#define   GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF	2
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_INVERT	BIT(3)
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN	BIT(4)
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN	BIT(5)
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT	GENMASK(12, 6)
+#define   GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF	20
+
+#define GSW1XX_SGMII_PHY_TX0_CFG3		0x007
+#define  GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_EN	BIT(12)
+#define  GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL	GENMASK(11, 9)
+#define   GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF	4
+#define  GSW1XX_SGMII_PHY_TX0_CFG3_INVERT	BIT(8)
+
+/* GSW1XX PDI Registers */
+#define GSW1XX_SWITCH_BASE			0xe000
+
+/* GSW1XX MII Registers */
+#define GSW1XX_RGMII_BASE			0xf100
+
+/* GSW1XX GPIO Registers */
+#define GSW1XX_GPIO_BASE			0xf300
+#define GPIO_ALTSEL0				0x83
+#define GPIO_ALTSEL0_EXTPHY_MUX_VAL		0x03c3
+#define GPIO_ALTSEL1				0x84
+#define GPIO_ALTSEL1_EXTPHY_MUX_VAL		0x003f
+
+/* MDIO bus controller */
+#define GSW1XX_MMDIO_BASE			0xf400
+
+/* generic IC registers */
+#define GSW1XX_SHELL_BASE			0xfa00
+#define  GSW1XX_SHELL_RST_REQ			0x01
+#define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
+/* RGMII PAD Slew Control Register */
+#define  GSW1XX_SHELL_RGMII_SLEW_CFG		0x78
+#define   RGMII_SLEW_CFG_RX_2_5_V		BIT(4)
+#define   RGMII_SLEW_CFG_TX_2_5_V		BIT(5)
+
+/* SGMII clock related settings */
+#define GSW1XX_CLK_BASE				0xf900
+#define  GSW1XX_CLK_NCO_CTRL			0x68
+#define   GSW1XX_SGMII_HSP_MASK			GENMASK(3, 2)
+#define   GSW1XX_SGMII_SEL			BIT(1)
+#define   GSW1XX_SGMII_1G			0x0
+#define   GSW1XX_SGMII_2G5			0xc
+#define   GSW1XX_SGMII_1G_NCO1			0x0
+#define   GSW1XX_SGMII_2G5_NCO2			0x2
+
+#endif /* __MXL_GSW1XX_H */
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h b/drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h
new file mode 100644
index 000000000000..eefcd411a340
--- /dev/null
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCE microcode code update for driver for MaxLinear GSW1xx switch chips
+ *
+ * Copyright (C) 2023 - 2024 MaxLinear Inc.
+ * Copyright (C) 2022 Snap One, LLC.  All rights reserved.
+ * Copyright (C) 2017 - 2019 Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2010 Lantiq Deutschland
+ */
+
+#include "lantiq_gswip.h"
+
+#define INSTR 0
+#define IPV6 1
+#define LENACCU 2
+
+/* GSWIP_2.X */
+enum {
+	OUT_MAC0 = 0,
+	OUT_MAC1,
+	OUT_MAC2,
+	OUT_MAC3,
+	OUT_MAC4,
+	OUT_MAC5,
+	OUT_ETHTYP,
+	OUT_VTAG0,
+	OUT_VTAG1,
+	OUT_ITAG0,
+	OUT_ITAG1,	/* 10 */
+	OUT_ITAG2,
+	OUT_ITAG3,
+	OUT_IP0,
+	OUT_IP1,
+	OUT_IP2,
+	OUT_IP3,
+	OUT_SIP0,
+	OUT_SIP1,
+	OUT_SIP2,
+	OUT_SIP3,	/* 20 */
+	OUT_SIP4,
+	OUT_SIP5,
+	OUT_SIP6,
+	OUT_SIP7,
+	OUT_DIP0,
+	OUT_DIP1,
+	OUT_DIP2,
+	OUT_DIP3,
+	OUT_DIP4,
+	OUT_DIP5,	/* 30 */
+	OUT_DIP6,
+	OUT_DIP7,
+	OUT_SESID,
+	OUT_PROT,
+	OUT_APP0,
+	OUT_APP1,
+	OUT_IGMP0,
+	OUT_IGMP1,
+	OUT_STAG0 = 61,
+	OUT_STAG1 = 62,
+	OUT_NONE = 63,
+};
+
+/* parser's microcode flag type */
+enum {
+	FLAG_ITAG = 0,
+	FLAG_VLAN,
+	FLAG_SNAP,
+	FLAG_PPPOE,
+	FLAG_IPV6,
+	FLAG_IPV6FL,
+	FLAG_IPV4,
+	FLAG_IGMP,
+	FLAG_TU,
+	FLAG_HOP,
+	FLAG_NN1,	/* 10 */
+	FLAG_NN2,
+	FLAG_END,
+	FLAG_NO,	/* 13 */
+	FLAG_SVLAN,	/* 14 */
+};
+
+#define PCE_MC_M(val, msk, ns, out, len, type, flags, ipv4_len) \
+	{ (val), (msk), ((ns) << 10 | (out) << 4 | (len) >> 1),\
+	 ((len) & 1) << 15 | (type) << 13 | (flags) << 9 | (ipv4_len) << 8 }
+
+/* V22_2X (IPv6 issue fixed) */
+static const struct gswip_pce_microcode gsw1xx_pce_microcode[] = {
+	/*       value   mask    ns  fields      L  type     flags       ipv4_len */
+	PCE_MC_M(0x88c3, 0xFFFF, 1,  OUT_ITAG0,  4, INSTR,   FLAG_ITAG,  0),
+	PCE_MC_M(0x8100, 0xFFFF, 4,  OUT_STAG0,  2, INSTR,   FLAG_SVLAN, 0),
+	PCE_MC_M(0x88A8, 0xFFFF, 4,  OUT_STAG0,  2, INSTR,   FLAG_SVLAN, 0),
+	PCE_MC_M(0x9100, 0xFFFF, 4,  OUT_STAG0,  2, INSTR,   FLAG_SVLAN, 0),
+	PCE_MC_M(0x8100, 0xFFFF, 5,  OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
+	PCE_MC_M(0x88A8, 0xFFFF, 6,  OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
+	PCE_MC_M(0x9100, 0xFFFF, 4,  OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
+	PCE_MC_M(0x8864, 0xFFFF, 20, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0800, 0xFFFF, 24, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x86DD, 0xFFFF, 25, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x8863, 0xFFFF, 19, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0xF800, 13, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 44, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0600, 0x0600, 44, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 15, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0xAAAA, 0xFFFF, 17, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0300, 0xFF00, 45, OUT_NONE,   0, INSTR,   FLAG_SNAP,  0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_DIP7,   3, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 21, OUT_DIP7,   3, INSTR,   FLAG_PPPOE, 0),
+	PCE_MC_M(0x0021, 0xFFFF, 24, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0057, 0xFFFF, 25, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 44, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x4000, 0xF000, 27, OUT_IP0,    4, INSTR,   FLAG_IPV4,  1),
+	PCE_MC_M(0x6000, 0xF000, 30, OUT_IP0,    3, INSTR,   FLAG_IPV6,  0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 28, OUT_IP3,    2, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 29, OUT_SIP0,   4, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 44, OUT_NONE,   0, LENACCU, FLAG_NO,    0),
+	PCE_MC_M(0x1100, 0xFF00, 43, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0600, 0xFF00, 43, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0xFF00, 36, OUT_IP3,   17, INSTR,   FLAG_HOP,   0),
+	PCE_MC_M(0x2B00, 0xFF00, 36, OUT_IP3,   17, INSTR,   FLAG_NN1,   0),
+	PCE_MC_M(0x3C00, 0xFF00, 36, OUT_IP3,   17, INSTR,   FLAG_NN2,   0),
+	PCE_MC_M(0x0000, 0x0000, 43, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x00F0, 38, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 44, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0xFF00, 36, OUT_NONE,   0, IPV6,    FLAG_HOP,   0),
+	PCE_MC_M(0x2B00, 0xFF00, 36, OUT_NONE,   0, IPV6,    FLAG_NN1,   0),
+	PCE_MC_M(0x3C00, 0xFF00, 36, OUT_NONE,   0, IPV6,    FLAG_NN2,   0),
+	PCE_MC_M(0x0000, 0x00FC, 44, OUT_PROT,   0, IPV6,    FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 44, OUT_NONE,   0, IPV6,    FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 44, OUT_SIP0,  16, INSTR,   FLAG_NO,    0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_APP0,   4, INSTR,   FLAG_IGMP,  0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+	PCE_MC_M(0x0000, 0x0000, 45, OUT_NONE,   0, INSTR,   FLAG_END,   0),
+};
-- 
2.51.2

