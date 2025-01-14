Return-Path: <netdev+bounces-157950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2413AA0FEEA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0463818807AC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0343AA1;
	Tue, 14 Jan 2025 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Nto1FJHX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B931BDC3;
	Tue, 14 Jan 2025 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822845; cv=none; b=CGs69QUpsUkI7QLHkLyPdxK7KCysVi5CJWrMYghQKsRCdUW9l3NdePYZUO9S/zz9f3HSsxA6yxv+vr6SVE0GWgX4vKYOIpAtWEKw84ftcIkrU3Qies4xuyksl/ohTR1YgO7OLoKzA3QhS6HRAEVzarbuxa84EALfL/tZSdlN6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822845; c=relaxed/simple;
	bh=yYlWYuKft1TZ8UnDuRrBryTrOMf410VkzYA1C53sK+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkvRYx9oINUPxTagUqf/Gku12UDWM6tH3qwJsgU4GEtitWifbgxTm+RY+0/Kofj2RfcVitD7U3SUshlSY6VZF3ANuSjCUWvhxHptNrzGXN5IoCYW0EWTWQ9JXd9awUJBMWCWLIzKAxIRzJONqvckOCFroRumP5qWmV5ORvynZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Nto1FJHX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736822843; x=1768358843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yYlWYuKft1TZ8UnDuRrBryTrOMf410VkzYA1C53sK+k=;
  b=Nto1FJHXr9x6543x8s19m5TuZMNOdXT37sZYF9p9uu1+Kls69BMMBf/9
   hpekb5WnBMPTvkvWUaY+DgIqTMjAN5F70Zi3QHYi4wZKU5zWmyJ1E/DbB
   glJikS7p+SrMtn7fbiqW//m7o5vdETjytZ/KTRO9/hVJT3S5pn+jaFghl
   GxwRylMKf5DoaWdHXCq30QB+g5G5NJKL+667OzlfwQQXt/OQ9MaratRU3
   2rMaaCxnTNJnkG6/NTEDSiWeoI8FMnzMR4lTl/LxLqyLOw/Sp6L9zkdBU
   PxiGPkqlyq2Gb03/e0uLiQFkvFYxulsPhXK+isZUVMdxZoAqnaBJNmJ2P
   w==;
X-CSE-ConnectionGUID: 3H/3aTmFT+ORqeWeDEmzMA==
X-CSE-MsgGUID: DojnOr7HRPezjJix763ROw==
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="267771916"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 19:47:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 Jan 2025 19:46:59 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 13 Jan 2025 19:46:59 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Date: Mon, 13 Jan 2025 18:47:04 -0800
Message-ID: <20250114024704.36972-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The SGMII module of KSZ9477 switch can be setup in 3 ways: direct connect
without using any SFP, SGMII mode with 10/100/1000Base-T SFP, and SerDes
mode with 1000BaseX SFP, which can be fiber or copper.  Note some
1000Base-T copper SFPs advertise themselves as SGMII but start in
1000BaseX mode, and the PHY driver of the PHY inside will change it to
SGMII mode.

The SGMII module can only support basic link status of the SFP, so the
port can be simulated as having a regular internal PHY when SFP cage
logic is not present.  The original KSZ9477 evaluation board operates in
this way and so requires the simulation code.

A PCS driver for the SGMII port is provided to support the SFP cage
logic used in the phylink code.  It is used to confirm the link is up
and process the SGMII interrupt.

One issue for the 1000BaseX SFP is there is no link down interrupt, so
the driver has to use polling to detect link off when the link is up.

Note the SGMII interrupt cannot be masked in hardware.  Also the module
is not reset when the switch is reset.  It is important to reset the
module properly to make sure interrupt is not triggered prematurely.

One side effect is the SGMII interrupt is triggered when an internal PHY
is powered down and powered up.  This happens when a port using internal
PHY is turned off and then turned on.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v2
 - use standard MDIO names when programming MMD registers
 - use pcs_config API to setup SGMII module
 - remove the KSZ9477 device tree example as it was deemed unnecessary

 drivers/net/dsa/microchip/ksz9477.c     | 455 +++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h     |   9 +-
 drivers/net/dsa/microchip/ksz9477_reg.h |   1 +
 drivers/net/dsa/microchip/ksz_common.c  | 111 +++++-
 drivers/net/dsa/microchip/ksz_common.h  |  23 +-
 5 files changed, 588 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 29fe79ea74cd..3613eea1e3fb 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -12,6 +12,8 @@
 #include <linux/phy.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/irqdomain.h>
+#include <linux/phylink.h>
 #include <net/dsa.h>
 #include <net/switchdev.h>
 
@@ -161,6 +163,415 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
 					10, 1000);
 }
 
+static void port_sgmii_s(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 len)
+{
+	u32 data;
+
+	data = (devid & MII_MMD_CTRL_DEVAD_MASK) << 16;
+	data |= reg;
+	if (len > 1)
+		data |= PORT_SGMII_AUTO_INCR;
+	ksz_pwrite32(dev, port, REG_PORT_SGMII_ADDR__4, data);
+}
+
+static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 *buf, u16 len)
+{
+	u32 data;
+
+	mutex_lock(&dev->sgmii_mutex);
+	port_sgmii_s(dev, port, devid, reg, len);
+	while (len) {
+		ksz_pread32(dev, port, REG_PORT_SGMII_DATA__4, &data);
+		*buf++ = (u16)data;
+		len--;
+	}
+	mutex_unlock(&dev->sgmii_mutex);
+}
+
+static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 *buf, u16 len)
+{
+	u32 data;
+
+	mutex_lock(&dev->sgmii_mutex);
+	port_sgmii_s(dev, port, devid, reg, len);
+	while (len) {
+		data = *buf++;
+		ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, data);
+		len--;
+	}
+	mutex_unlock(&dev->sgmii_mutex);
+}
+
+static void port_sgmii_reset(struct ksz_device *dev, uint p)
+{
+	u16 ctrl = BMCR_RESET;
+
+	port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
+}
+
+static phy_interface_t port_sgmii_detect(struct ksz_device *dev, uint p)
+{
+	phy_interface_t interface = PHY_INTERFACE_MODE_1000BASEX;
+	u16 buf[6];
+	int i = 0;
+
+	/* Read all 6 registers to spend more time waiting for valid result. */
+	do {
+		port_sgmii_r(dev, p, MDIO_MMD_VEND2, MII_BMCR, buf, 6);
+		i++;
+	} while (!buf[5] && i < 10);
+	if ((buf[5] & LPA_LPACK) &&
+	    (!(buf[5] & (LPA_1000XHALF | LPA_1000XFULL))))
+		interface = PHY_INTERFACE_MODE_SGMII;
+	return interface;
+}
+
+static void port_sgmii_setup(struct ksz_device *dev, uint p, bool pcs,
+			     bool master, bool autoneg, bool intr, int speed,
+			     int duplex)
+{
+	u16 ctrl;
+	u16 cfg;
+	u16 adv;
+
+	cfg = 0;
+	if (pcs)
+		cfg |= SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
+	if (master) {
+		cfg |= SR_MII_TX_CFG_PHY_MASTER;
+		cfg |= SR_MII_SGMII_LINK_UP;
+	}
+	port_sgmii_w(dev, p, MDIO_MMD_VEND2, MMD_SR_MII_AUTO_NEG_CTRL, &cfg, 1);
+
+	/* Need to write to advertise register to send correct signal. */
+	/* Default value is 0x0020. */
+	adv = ADVERTISE_1000XPSE_ASYM | ADVERTISE_1000XPAUSE;
+	adv |= (duplex == DUPLEX_FULL) ?
+	       ADVERTISE_1000XFULL : ADVERTISE_1000XHALF;
+	port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_ADVERTISE, &adv, 1);
+	port_sgmii_r(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
+	if (master || !autoneg) {
+		ctrl &= ~(BMCR_SPEED1000 | BMCR_SPEED100 | BMCR_FULLDPLX);
+		switch (speed) {
+		case SPEED_100:
+			ctrl |= BMCR_SPEED100;
+			break;
+		case SPEED_1000:
+			ctrl |= BMCR_SPEED1000;
+			break;
+		}
+		if (duplex == DUPLEX_FULL)
+			ctrl |= BMCR_FULLDPLX;
+	}
+	if (!autoneg) {
+		ctrl &= ~BMCR_ANENABLE;
+		port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
+		goto sgmii_setup_last;
+	} else if (!(ctrl & BMCR_ANENABLE)) {
+		ctrl |= BMCR_ANENABLE;
+		port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
+	}
+	if (master && autoneg) {
+		ctrl |= BMCR_ANRESTART;
+		port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
+	}
+
+sgmii_setup_last:
+	if (intr) {
+		cfg |= SR_MII_AUTO_NEG_COMPLETE_INTR;
+		port_sgmii_w(dev, p, MDIO_MMD_VEND2, MMD_SR_MII_AUTO_NEG_CTRL,
+			     &cfg, 1);
+	}
+}
+
+#define PORT_LINK_UP		BIT(0)
+#define PORT_LINK_CHANGE	BIT(1)
+#define PORT_LINK_INVALID	BIT(2)
+
+static int sgmii_port_get_speed(struct ksz_device *dev, uint p)
+{
+	struct ksz_port *info = &dev->ports[p];
+	struct ksz_pcs *priv = info->pcs_priv;
+	int ret = 0;
+	u16 status;
+	u16 speed;
+	u16 data;
+	u8 link;
+
+	port_sgmii_r(dev, p, MDIO_MMD_VEND2, MII_BMSR, &status, 1);
+	port_sgmii_r(dev, p, MDIO_MMD_VEND2, MII_BMSR, &status, 1);
+	port_sgmii_r(dev, p, MDIO_MMD_VEND2, MMD_SR_MII_AUTO_NEG_STATUS, &data,
+		     1);
+
+	/* Typical register values with different SFPs.
+	 * 10/100/1000: 1f0001 = 01ad  1f0005 = 4000  1f8002 = 0008
+	 *              1f0001 = 01bd  1f0005 = d000  1f8002 = 001a
+	 * 1000:        1f0001 = 018d  1f0005 = 0000  1f8002 = 0000
+	 *              1f0001 = 01ad  1f0005 = 40a0  1f8002 = 0001
+	 *              1f0001 = 01ad  1f0005 = 41a0  1f8002 = 0001
+	 * fiber:       1f0001 = 0189  1f0005 = 0000  1f8002 = 0000
+	 *              1f0001 = 01ad  1f0005 = 41a0  1f8002 = 0001
+	 */
+
+	if (data & SR_MII_AUTO_NEG_COMPLETE_INTR) {
+		data &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
+		port_sgmii_w(dev, p, MDIO_MMD_VEND2, MMD_SR_MII_AUTO_NEG_STATUS,
+			     &data, 1);
+	}
+
+	/* Not running in SGMII mode where data indicates link status. */
+	if (info->interface != PHY_INTERFACE_MODE_SGMII && !data) {
+		u16 link_up = BMSR_LSTATUS;
+
+		if (info->interface == PHY_INTERFACE_MODE_1000BASEX)
+			link_up |= BMSR_ANEGCOMPLETE;
+		if ((status & link_up) == link_up)
+			data = SR_MII_STAT_LINK_UP |
+			       (SR_MII_STAT_1000_MBPS << SR_MII_STAT_S) |
+			       SR_MII_STAT_FULL_DUPLEX;
+	}
+	if (data & SR_MII_STAT_LINK_UP)
+		ret = PORT_LINK_UP;
+
+	link = (data & ~SR_MII_AUTO_NEG_COMPLETE_INTR);
+	if (priv->link == link)
+		return ret;
+
+	if (data & SR_MII_STAT_LINK_UP) {
+		u16 ctrl = 0;
+
+		/* Need to update control register with same link setting. */
+		if (info->interface != PHY_INTERFACE_MODE_INTERNAL)
+			ctrl = BMCR_ANENABLE;
+		speed = (data >> SR_MII_STAT_S) & SR_MII_STAT_M;
+		if (speed == SR_MII_STAT_1000_MBPS)
+			ctrl |= BMCR_SPEED1000;
+		else if (speed == SR_MII_STAT_100_MBPS)
+			ctrl |= BMCR_SPEED100;
+		if (data & SR_MII_STAT_FULL_DUPLEX)
+			ctrl |= BMCR_FULLDPLX;
+		port_sgmii_w(dev, p, MDIO_MMD_VEND2, MII_BMCR, &ctrl, 1);
+
+		info->phydev.speed = SPEED_10;
+		if (speed == SR_MII_STAT_1000_MBPS)
+			info->phydev.speed = SPEED_1000;
+		else if (speed == SR_MII_STAT_100_MBPS)
+			info->phydev.speed = SPEED_100;
+
+		info->phydev.duplex = 0;
+		if (data & SR_MII_STAT_FULL_DUPLEX)
+			info->phydev.duplex = 1;
+	}
+	ret |= PORT_LINK_CHANGE;
+	priv->link = link;
+	info->phydev.link = (ret & PORT_LINK_UP);
+	return ret;
+}
+
+static bool sgmii_need_polling(struct ksz_device *dev, struct ksz_port *p)
+{
+	struct ksz_pcs *priv = p->pcs_priv;
+
+	/* SGMII mode has link up and link down interrupts. */
+	if (p->interface == PHY_INTERFACE_MODE_SGMII && priv->has_intr)
+		return false;
+
+	/* SerDes mode has link up interrupt but not link down interrupt. */
+	if (p->interface == PHY_INTERFACE_MODE_1000BASEX && priv->has_intr &&
+	    !p->phydev.link)
+		return false;
+
+	/* Direct connect mode has no link change. */
+	if (p->interface == PHY_INTERFACE_MODE_INTERNAL)
+		return false;
+	return true;
+}
+
+static void ksz9477_sgmii_setup(struct ksz_device *dev, int port,
+				phy_interface_t intf)
+{
+	struct ksz_port *p = &dev->ports[port];
+	struct ksz_pcs *priv = p->pcs_priv;
+	struct phy_device *phydev = NULL;
+	bool autoneg, master, pcs;
+
+	if (!priv->using_sfp && dev->ds->user_mii_bus)
+		phydev = mdiobus_get_phy(dev->ds->user_mii_bus, port);
+	if (phydev || p->interface == PHY_INTERFACE_MODE_INTERNAL)
+		intf = p->interface;
+
+	/* PHY driver can change the mode to PHY_INTERFACE_MODE_SGMII from
+	 * PHY_INTERFACE_MODE_1000BASEX, so this function can be called again
+	 * after the interface is changed.
+	 */
+	if (intf != p->interface) {
+		dev_info(dev->dev, "switching to %s after %s was detected.\n",
+			 phy_modes(intf), phy_modes(p->interface));
+		p->interface = intf;
+	}
+	switch (p->interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		autoneg = true;
+		master = false;
+		pcs = true;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		autoneg = true;
+		master = true;
+		pcs = false;
+		break;
+	default:
+		autoneg = false;
+		master = true;
+		pcs = true;
+		break;
+	}
+	port_sgmii_setup(dev, port, pcs, master, autoneg, priv->has_intr,
+			 SPEED_1000, DUPLEX_FULL);
+
+	sgmii_port_get_speed(dev, port);
+
+	/* Need to check link down if using 1000BASEX SFP. */
+	if (sgmii_need_polling(dev, p))
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(500));
+}
+
+static void sgmii_update_link(struct ksz_device *dev)
+{
+	u8 port = dev->info->sgmii_port - 1;
+	struct ksz_port *p = &dev->ports[port];
+	int ret;
+
+	ret = sgmii_port_get_speed(dev, port);
+	if (ret & PORT_LINK_CHANGE) {
+		struct phy_device *phydev;
+
+		/* When simulating PHY. */
+		p->phydev.interrupts = PHY_INTERRUPT_ENABLED;
+		phydev = mdiobus_get_phy(dev->ds->user_mii_bus, port);
+		if (phydev)
+			phy_trigger_machine(phydev);
+
+		/* When using SFP code. */
+		dsa_port_phylink_mac_change(dev->ds, port, p->phydev.link);
+	}
+
+	/* No interrupt for link down. */
+	if (sgmii_need_polling(dev, p))
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(500));
+}
+
+static void sgmii_check_work(struct work_struct *work)
+{
+	struct ksz_device *dev = container_of(work, struct ksz_device,
+					      sgmii_check.work);
+
+	sgmii_update_link(dev);
+}
+
+static irqreturn_t ksz9477_sgmii_irq_thread_fn(int irq, void *dev_id)
+{
+	struct ksz_pcs *priv = dev_id;
+	struct ksz_device *dev = priv->dev;
+	u8 port = priv->port;
+	u16 data16 = 0;
+
+	port_sgmii_w(dev, port, SR_MII, MMD_SR_MII_AUTO_NEG_STATUS, &data16, 1);
+	sgmii_update_link(dev);
+	return IRQ_HANDLED;
+}
+
+static void sgmii_initial_setup(struct ksz_device *dev, int port)
+{
+	struct ksz_port *p = &dev->ports[port];
+	struct ksz_pcs *priv = p->pcs_priv;
+	int irq, ret;
+
+	irq = irq_find_mapping(p->pirq.domain, PORT_SGMII_INT_LOC);
+	if (irq > 0) {
+		ret = request_threaded_irq(irq, NULL,
+					   ksz9477_sgmii_irq_thread_fn,
+					   IRQF_ONESHOT, "SGMII", priv);
+		if (!ret)
+			priv->has_intr = 1;
+	}
+
+	/* Make invalid so the correct value is set. */
+	priv->link = 0xff;
+
+	INIT_DELAYED_WORK(&dev->sgmii_check, sgmii_check_work);
+}
+
+int ksz9477_pcs_create(struct ksz_device *dev)
+{
+	/* This chip has a SGMII port. */
+	if (dev->info->sgmii_port > 0) {
+		int port = dev->info->sgmii_port - 1;
+		struct ksz_port *p = &dev->ports[port];
+		struct ksz_pcs *pcs_priv;
+
+		pcs_priv = devm_kzalloc(dev->dev, sizeof(struct ksz_pcs),
+					GFP_KERNEL);
+		if (!pcs_priv)
+			return -ENOMEM;
+		p->pcs_priv = pcs_priv;
+		pcs_priv->dev = dev;
+		pcs_priv->port = port;
+		pcs_priv->pcs.neg_mode = true;
+
+		/* Switch reset does not reset SGMII module. */
+		port_sgmii_reset(dev, port);
+
+		/* Detect which mode to use if not using direct connect. */
+		if (p->interface != PHY_INTERFACE_MODE_INTERNAL)
+			p->interface = port_sgmii_detect(dev, port);
+	}
+	return 0;
+}
+
+int ksz9477_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+		       phy_interface_t interface,
+		       const unsigned long *advertising)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+	struct ksz_port *p = &dev->ports[priv->port];
+
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		p->pcs_priv->using_sfp = 1;
+	ksz9477_sgmii_setup(dev, priv->port, interface);
+	return 0;
+}
+
+void ksz9477_pcs_get_state(struct phylink_pcs *pcs,
+			   struct phylink_link_state *state)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+	struct ksz_port *p = &dev->ports[priv->port];
+	u8 status;
+	int ret;
+
+	ksz_pread8(dev, priv->port, REG_PORT_STATUS_0, &status);
+	ret = sgmii_port_get_speed(dev, priv->port);
+	if (!(ret & PORT_LINK_UP))
+		state->link = false;
+	state->duplex = p->phydev.duplex;
+	state->speed = p->phydev.speed;
+	state->pause &= ~(MLO_PAUSE_RX | MLO_PAUSE_TX);
+	if (status & PORT_RX_FLOW_CTRL)
+		state->pause |= MLO_PAUSE_RX;
+	if (status & PORT_TX_FLOW_CTRL)
+		state->pause |= MLO_PAUSE_TX;
+	if (state->interface == PHY_INTERFACE_MODE_SGMII)
+		state->an_complete = state->link;
+}
+
 int ksz9477_reset_switch(struct ksz_device *dev)
 {
 	u8 data8;
@@ -345,7 +756,7 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 	 * A fixed PHY can be setup in the device tree, but this function is
 	 * still called for that port during initialization.
 	 * For RGMII PHY there is no way to access it so the fixed PHY should
-	 * be used.  For SGMII PHY the supporting code will be added later.
+	 * be used.  SGMII PHY is simulated as a regular PHY.
 	 */
 	if (!dev->info->internal_phy[addr]) {
 		struct ksz_port *p = &dev->ports[addr];
@@ -355,7 +766,10 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			val = 0x1140;
 			break;
 		case MII_BMSR:
-			val = 0x796d;
+			if (p->phydev.link)
+				val = 0x796d;
+			else
+				val = 0x7949;
 			break;
 		case MII_PHYSID1:
 			val = 0x0022;
@@ -368,6 +782,10 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			break;
 		case MII_LPA:
 			val = 0xc5e1;
+			if (p->phydev.speed == SPEED_10)
+				val &= ~0x0180;
+			if (p->phydev.duplex == 0)
+				val &= ~0x0140;
 			break;
 		case MII_CTRL1000:
 			val = 0x0700;
@@ -378,6 +796,24 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			else
 				val = 0;
 			break;
+		case MII_ESTATUS:
+			val = 0x3000;
+			break;
+
+		/* This register holds the PHY interrupt status. */
+		case MII_TPISTATUS:
+			val = (LINK_DOWN_INT | LINK_UP_INT) << 8;
+			if (p->phydev.interrupts == PHY_INTERRUPT_ENABLED) {
+				if (p->phydev.link)
+					val |= LINK_UP_INT;
+				else
+					val |= LINK_DOWN_INT;
+			}
+			p->phydev.interrupts = 0;
+			break;
+		default:
+			val = 0;
+			break;
 		}
 	} else {
 		ret = ksz_pread16(dev, addr, 0x100 + (reg << 1), &val);
@@ -978,6 +1414,13 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 
 	if (dev->info->gbit_capable[port])
 		config->mac_capabilities |= MAC_1000FD;
+
+	if (dev->info->sgmii_port == port + 1) {
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+	}
 }
 
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
@@ -1079,6 +1522,9 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		     PORT_FORCE_TX_FLOW_CTRL | PORT_FORCE_RX_FLOW_CTRL,
 		     !dev->info->internal_phy[port]);
 
+	if (dev->info->sgmii_port == port + 1)
+		sgmii_initial_setup(dev, port);
+
 	if (cpu_port)
 		member = dsa_user_ports(ds);
 	else
@@ -1348,6 +1794,9 @@ int ksz9477_switch_init(struct ksz_device *dev)
 
 void ksz9477_switch_exit(struct ksz_device *dev)
 {
+	if (dev->info->sgmii_port > 0 &&
+	    delayed_work_pending(&dev->sgmii_check))
+		cancel_delayed_work_sync(&dev->sgmii_check);
 	ksz9477_reset_switch(dev);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index d2166b0d881e..cf9f9e4d7d41 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 series Header file
  *
- * Copyright (C) 2017-2022 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_H
@@ -97,4 +97,11 @@ void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
 				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
 				  unsigned long cookie, u32 prio);
 
+int ksz9477_pcs_create(struct ksz_device *dev);
+int ksz9477_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+		       phy_interface_t interface,
+		       const unsigned long *advertising);
+void ksz9477_pcs_get_state(struct phylink_pcs *pcs,
+			   struct phylink_link_state *state);
+
 #endif
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index ff579920078e..db646b97a2ff 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -803,6 +803,7 @@
 #define REG_PORT_INT_STATUS		0x001B
 #define REG_PORT_INT_MASK		0x001F
 
+#define PORT_SGMII_INT_LOC		3
 #define PORT_SGMII_INT			BIT(3)
 #define PORT_PTP_INT			BIT(2)
 #define PORT_PHY_INT			BIT(1)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796894af..0101a706bdd6 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2,7 +2,7 @@
 /*
  * Microchip switch driver main logic
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #include <linux/delay.h>
@@ -354,10 +354,26 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 					int speed, int duplex, bool tx_pause,
 					bool rx_pause);
 
+static struct phylink_pcs *
+ksz_phylink_mac_select_pcs(struct phylink_config *config,
+			   phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	struct ksz_port *p = &dev->ports[dp->index];
+
+	if (dev->info->sgmii_port == dp->index + 1 &&
+	    (interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_1000BASEX))
+		return &p->pcs_priv->pcs;
+	return NULL;
+}
+
 static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_select_pcs	= ksz_phylink_mac_select_pcs,
 };
 
 static const struct ksz_dev_ops ksz9477_dev_ops = {
@@ -395,6 +411,9 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
 	.exit = ksz9477_switch_exit,
+	.pcs_create = ksz9477_pcs_create,
+	.pcs_config = ksz9477_pcs_config,
+	.pcs_get_state = ksz9477_pcs_get_state,
 };
 
 static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
@@ -1035,8 +1054,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x701b, 0x701b),
 	regmap_reg_range(0x701f, 0x7020),
 	regmap_reg_range(0x7030, 0x7030),
-	regmap_reg_range(0x7200, 0x7203),
-	regmap_reg_range(0x7206, 0x7207),
+	regmap_reg_range(0x7200, 0x7207),
 	regmap_reg_range(0x7300, 0x7301),
 	regmap_reg_range(0x7400, 0x7401),
 	regmap_reg_range(0x7403, 0x7403),
@@ -1552,6 +1570,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
 		.ptp_capable = true,
+		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -1944,6 +1963,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -2018,6 +2038,40 @@ static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 		dev->dev_ops->get_caps(dev, port, config);
 }
 
+static int ksz_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			  phy_interface_t interface,
+			  const unsigned long *advertising,
+			  bool permit_pause_to_mac)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+
+	if (dev->dev_ops->pcs_config)
+		return dev->dev_ops->pcs_config(pcs, neg_mode, interface,
+						advertising);
+	return 0;
+}
+
+static void ksz_pcs_get_state(struct phylink_pcs *pcs,
+			      struct phylink_link_state *state)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+
+	if (dev->dev_ops->pcs_get_state)
+		dev->dev_ops->pcs_get_state(pcs, state);
+}
+
+static void ksz_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static const struct phylink_pcs_ops ksz_pcs_ops = {
+	.pcs_config = ksz_pcs_config,
+	.pcs_an_restart = ksz_pcs_an_restart,
+	.pcs_get_state = ksz_pcs_get_state,
+};
+
 void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 {
 	struct ethtool_pause_stats *pstats;
@@ -2067,7 +2121,7 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 
 	spin_unlock(&mib->stats64_lock);
 
-	if (dev->info->phy_errata_9477) {
+	if (dev->info->phy_errata_9477 && dev->info->sgmii_port != port + 1) {
 		ret = ksz9477_errata_monitor(dev, port, raw->tx_late_col);
 		if (ret)
 			dev_err(dev->dev, "Failed to monitor transmission halt\n");
@@ -2342,7 +2396,9 @@ static int ksz_phy_addr_to_port(struct ksz_device *dev, int addr)
 	struct dsa_port *dp;
 
 	dsa_switch_for_each_user_port(dp, ds) {
-		if (dev->info->internal_phy[dp->index] &&
+		/* Allow SGMII port to act as having a PHY. */
+		if ((dev->info->internal_phy[dp->index] ||
+		     dev->info->sgmii_port == dp->index + 1) &&
 		    dev->phy_addr_map[dp->index] == addr)
 			return dp->index;
 	}
@@ -2434,11 +2490,15 @@ static int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
 	int ret;
 
 	dsa_switch_for_each_user_port(dp, dev->ds) {
-		if (!dev->info->internal_phy[dp->index])
+		/* Allow SGMII port to act as having a PHY. */
+		if (!dev->info->internal_phy[dp->index] &&
+		    dev->info->sgmii_port != dp->index + 1)
 			continue;
 
 		phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
 		if (!phy_node) {
+			if (dev->info->sgmii_port == dp->index + 1)
+				continue;
 			dev_err(dev->dev, "failed to parse phy-handle for port %d.\n",
 				dp->index);
 			phys_are_valid = false;
@@ -2775,6 +2835,17 @@ static int ksz_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	if (dev->info->sgmii_port > 0) {
+		if (dev->dev_ops->pcs_create) {
+			ret = dev->dev_ops->pcs_create(dev);
+			if (ret)
+				return ret;
+			p = &dev->ports[dev->info->sgmii_port - 1];
+			if (p->pcs_priv)
+				p->pcs_priv->pcs.ops = &ksz_pcs_ops;
+		}
+	}
+
 	/* set broadcast storm protection 10% rate */
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   BROADCAST_STORM_RATE,
@@ -3613,6 +3684,10 @@ static void ksz_phylink_mac_config(struct phylink_config *config,
 	if (dev->info->internal_phy[port])
 		return;
 
+	/* No need to configure XMII control register when using SGMII. */
+	if (dev->info->sgmii_port == port + 1)
+		return;
+
 	if (phylink_autoneg_inband(mode)) {
 		dev_err(dev->dev, "In-band AN not supported!\n");
 		return;
@@ -4595,6 +4670,9 @@ static int ksz_suspend(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 
 	cancel_delayed_work_sync(&dev->mib_read);
+	if (dev->info->sgmii_port > 0 &&
+	    delayed_work_pending(&dev->sgmii_check))
+		cancel_delayed_work_sync(&dev->sgmii_check);
 	return 0;
 }
 
@@ -4604,6 +4682,9 @@ static int ksz_resume(struct dsa_switch *ds)
 
 	if (dev->mib_read_interval)
 		schedule_delayed_work(&dev->mib_read, dev->mib_read_interval);
+	if (dev->info->sgmii_port > 0)
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(100));
 	return 0;
 }
 
@@ -4755,6 +4836,22 @@ static void ksz_parse_rgmii_delay(struct ksz_device *dev, int port_num,
 	dev->ports[port_num].rgmii_tx_val = tx_delay;
 }
 
+static void ksz_parse_sgmii(struct ksz_device *dev, int port,
+			    struct device_node *dn)
+{
+	const char *managed;
+
+	if (dev->info->sgmii_port != port + 1)
+		return;
+	/* SGMII port can be used without using SFP.
+	 * The sfp declaration is returned as being a fixed link so need to
+	 * check the managed string to know the port is not using sfp.
+	 */
+	if (of_phy_is_fixed_link(dn) &&
+	    of_property_read_string(dn, "managed", &managed))
+		dev->ports[port].interface = PHY_INTERFACE_MODE_INTERNAL;
+}
+
 /**
  * ksz_drive_strength_to_reg() - Convert drive strength value to corresponding
  *				 register value.
@@ -5021,6 +5118,7 @@ int ksz_switch_register(struct ksz_device *dev)
 	mutex_init(&dev->regmap_mutex);
 	mutex_init(&dev->alu_mutex);
 	mutex_init(&dev->vlan_mutex);
+	mutex_init(&dev->sgmii_mutex);
 
 	ret = ksz_switch_detect(dev);
 	if (ret)
@@ -5097,6 +5195,7 @@ int ksz_switch_register(struct ksz_device *dev)
 						&dev->ports[port_num].interface);
 
 				ksz_parse_rgmii_delay(dev, port_num, port);
+				ksz_parse_sgmii(dev, port_num, port);
 			}
 			of_node_put(ports);
 		}
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index af17a9c030d4..962bba382556 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip switch driver common header
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #ifndef __KSZ_COMMON_H
@@ -93,6 +93,7 @@ struct ksz_chip_data {
 	bool internal_phy[KSZ_MAX_NUM_PORTS];
 	bool gbit_capable[KSZ_MAX_NUM_PORTS];
 	bool ptp_capable;
+	u8 sgmii_port;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 };
@@ -121,6 +122,15 @@ struct ksz_switch_macaddr {
 	refcount_t refcount;
 };
 
+struct ksz_pcs {
+	struct phylink_pcs pcs;
+	struct ksz_device *dev;
+	u8 port;
+	u32 has_intr:1;
+	u32 link:8;
+	u32 using_sfp:1;
+};
+
 struct ksz_port {
 	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	bool learning;
@@ -141,6 +151,7 @@ struct ksz_port {
 	void *acl_priv;
 	struct ksz_irq pirq;
 	u8 num;
+	struct ksz_pcs *pcs_priv;
 #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
 	struct hwtstamp_config tstamp_config;
 	bool hwts_tx_en;
@@ -162,6 +173,8 @@ struct ksz_device {
 	struct mutex regmap_mutex;	/* regmap access */
 	struct mutex alu_mutex;		/* ALU access */
 	struct mutex vlan_mutex;	/* vlan access */
+	struct mutex sgmii_mutex;	/* SGMII access */
+	const struct phylink_pcs_ops *pcs_ops;
 	const struct ksz_dev_ops *dev_ops;
 
 	struct device *dev;
@@ -188,6 +201,7 @@ struct ksz_device {
 	struct ksz_port *ports;
 	struct delayed_work mib_read;
 	unsigned long mib_read_interval;
+	struct delayed_work sgmii_check;
 	u16 mirror_rx;
 	u16 mirror_tx;
 	u16 port_mask;
@@ -440,6 +454,13 @@ struct ksz_dev_ops {
 	int (*reset)(struct ksz_device *dev);
 	int (*init)(struct ksz_device *dev);
 	void (*exit)(struct ksz_device *dev);
+
+	int (*pcs_create)(struct ksz_device *dev);
+	int (*pcs_config)(struct phylink_pcs *pcs, unsigned int neg_mode,
+			  phy_interface_t interface,
+			  const unsigned long *advertising);
+	void (*pcs_get_state)(struct phylink_pcs *pcs,
+			      struct phylink_link_state *state);
 };
 
 struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
-- 
2.34.1


