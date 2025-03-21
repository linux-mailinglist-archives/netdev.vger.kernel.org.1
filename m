Return-Path: <netdev+bounces-176738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE5A6BCA5
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA51518920EB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7387D07D;
	Fri, 21 Mar 2025 14:11:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F6152532
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566271; cv=none; b=rZ1sDI8zAgcLqd/TXSoR6lcsZo21wPML8c/b8+IjHWQPPR8cfeL+fOidnygXbxfC1/kJ+5J0UkAhcfeqIuHAPNPeVAbh1woD8Q8vKLfAWIL0Exiks/BIYors5KeIj4FjTRUMii7rlr9a5zn6lGs+1hD/2vf+I5jWn4RIt/kTJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566271; c=relaxed/simple;
	bh=llcBPHfMZnyABw81/FCC3AgIL0fn4mqZk80JFddzQZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlG7YJ4/5zn63mxaKPIPlBd5UA4esAB3f0X8EnpoilV4jfue5ZqRz83SgaohBBqh4mhmwrY8RyGkRuFEPu//K/ib3JdZdk3+Rwm6aSF6i+ZxAaXvoXoBhs9dqlKXRp+lCIOCsvF8WdRkrH6tPNWHRlBw8/cv1e7HSHehKOabp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tvd5D-0007WQ-8U; Fri, 21 Mar 2025 15:10:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tvd5B-000vyX-1e;
	Fri, 21 Mar 2025 15:10:45 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tvd5B-008x39-2j;
	Fri, 21 Mar 2025 15:10:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net v1 1/1] net: dsa: microchip: fix DCB apptrust configuration on KSZ88x3
Date: Fri, 21 Mar 2025 15:10:44 +0100
Message-Id: <20250321141044.2128973-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Remove KSZ88x3-specific priority and apptrust configuration logic that was
based on incorrect register access assumptions. Also fix the register
offset for KSZ8_REG_PORT_1_CTRL_0 to align with get_port_addr() logic.

The KSZ88x3 switch family uses a different register layout compared to
KSZ9477-compatible variants. Specifically, port control registers need
offset adjustment through get_port_addr(), and do not match the datasheet
values directly.

Commit a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for
KSZ88X3 family") introduced quirks based on datasheet offsets, which do
not work with the driver's internal addressing model. As a result, these
quirks addressed the wrong ports and caused unstable behavior.

This patch removes all KSZ88x3-specific DCB quirks and corrects the port
control register offset, effectively restoring working and predictable
apptrust configuration.

Fixes: a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for KSZ88X3 family")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8.c    |  11 +-
 drivers/net/dsa/microchip/ksz_dcb.c | 231 +---------------------------
 2 files changed, 9 insertions(+), 233 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index da7110d67558..be433b4e2b1c 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1625,7 +1625,6 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
 	const u32 *masks;
-	int queues;
 	u8 member;
 
 	masks = dev->info->masks;
@@ -1633,15 +1632,7 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	/* enable broadcast storm limit */
 	ksz_port_cfg(dev, port, P_BCAST_STORM_CTRL, PORT_BROADCAST_STORM, true);
 
-	/* For KSZ88x3 enable only one queue by default, otherwise we won't
-	 * be able to get rid of PCP prios on Port 2.
-	 */
-	if (ksz_is_ksz88x3(dev))
-		queues = 1;
-	else
-		queues = dev->info->num_tx_queues;
-
-	ksz8_port_queue_split(dev, port, queues);
+	ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
 
 	/* replace priority */
 	ksz_port_cfg(dev, port, P_802_1P_CTRL,
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 30b4a6186e38..c3b501997ac9 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -10,7 +10,12 @@
 #include "ksz_dcb.h"
 #include "ksz8.h"
 
-#define KSZ8_REG_PORT_1_CTRL_0			0x10
+/* Port X Control 0 register.
+ * The datasheet specifies: Port 1 - 0x10, Port 2 - 0x20, Port 3 - 0x30.
+ * However, the driver uses get_port_addr(), which maps Port 1 to offset 0.
+ * Therefore, we define the base offset as 0x00 here to align with that logic.
+ */
+#define KSZ8_REG_PORT_1_CTRL_0			0x00
 #define KSZ8_PORT_DIFFSERV_ENABLE		BIT(6)
 #define KSZ8_PORT_802_1P_ENABLE			BIT(5)
 #define KSZ8_PORT_BASED_PRIO_M			GENMASK(4, 3)
@@ -181,49 +186,6 @@ int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
 	return (data & mask) >> shift;
 }
 
-/**
- * ksz88x3_port_set_default_prio_quirks - Quirks for default priority
- * @dev: Pointer to the KSZ switch device structure
- * @port: Port number for which to set the default priority
- * @prio: Priority value to set
- *
- * This function implements quirks for setting the default priority on KSZ88x3
- * devices. On Port 2, no other priority providers are working
- * except of PCP. So, configuring default priority on Port 2 is not possible.
- * On Port 1, it is not possible to configure port priority if PCP
- * apptrust on Port 2 is disabled. Since we disable multiple queues on the
- * switch to disable PCP on Port 2, we need to ensure that the default priority
- * configuration on Port 1 is in agreement with the configuration on Port 2.
- *
- * Return: 0 on success, or a negative error code on failure
- */
-static int ksz88x3_port_set_default_prio_quirks(struct ksz_device *dev, int port,
-						u8 prio)
-{
-	if (!prio)
-		return 0;
-
-	if (port == KSZ_PORT_2) {
-		dev_err(dev->dev, "Port priority configuration is not working on Port 2\n");
-		return -EINVAL;
-	} else if (port == KSZ_PORT_1) {
-		u8 port2_data;
-		int ret;
-
-		ret = ksz_pread8(dev, KSZ_PORT_2, KSZ8_REG_PORT_1_CTRL_0,
-				 &port2_data);
-		if (ret)
-			return ret;
-
-		if (!(port2_data & KSZ8_PORT_802_1P_ENABLE)) {
-			dev_err(dev->dev, "Not possible to configure port priority on Port 1 if PCP apptrust on Port 2 is disabled\n");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 /**
  * ksz_port_set_default_prio - Sets the default priority for a port on a KSZ
  *			       switch
@@ -239,18 +201,12 @@ static int ksz88x3_port_set_default_prio_quirks(struct ksz_device *dev, int port
 int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
-	int reg, shift, ret;
+	int reg, shift;
 	u8 mask;
 
 	if (prio >= dev->info->num_ipms)
 		return -EINVAL;
 
-	if (ksz_is_ksz88x3(dev)) {
-		ret = ksz88x3_port_set_default_prio_quirks(dev, port, prio);
-		if (ret)
-			return ret;
-	}
-
 	ksz_get_default_port_prio_reg(dev, &reg, &mask, &shift);
 
 	return ksz_prmw8(dev, port, reg, mask, (prio << shift) & mask);
@@ -518,155 +474,6 @@ static int ksz_port_set_apptrust_validate(struct ksz_device *dev, int port,
 	return -EINVAL;
 }
 
-/**
- * ksz88x3_port1_apptrust_quirk - Quirk for apptrust configuration on Port 1
- *				  of KSZ88x3 devices
- * @dev: Pointer to the KSZ switch device structure
- * @port: Port number for which to set the apptrust selectors
- * @reg: Register address for the apptrust configuration
- * @port1_data: Data to set for the apptrust configuration
- *
- * This function implements a quirk for apptrust configuration on Port 1 of
- * KSZ88x3 devices. It ensures that apptrust configuration on Port 1 is not
- * possible if PCP apptrust on Port 2 is disabled. This is because the Port 2
- * seems to be permanently hardwired to PCP classification, so we need to
- * do Port 1 configuration always in agreement with Port 2 configuration.
- *
- * Return: 0 on success, or a negative error code on failure
- */
-static int ksz88x3_port1_apptrust_quirk(struct ksz_device *dev, int port,
-					int reg, u8 port1_data)
-{
-	u8 port2_data;
-	int ret;
-
-	/* If no apptrust is requested for Port 1, no need to care about Port 2
-	 * configuration.
-	 */
-	if (!(port1_data & (KSZ8_PORT_802_1P_ENABLE | KSZ8_PORT_DIFFSERV_ENABLE)))
-		return 0;
-
-	/* We got request to enable any apptrust on Port 1. To make it possible,
-	 * we need to enable multiple queues on the switch. If we enable
-	 * multiqueue support, PCP classification on Port 2 will be
-	 * automatically activated by HW.
-	 */
-	ret = ksz_pread8(dev, KSZ_PORT_2, reg, &port2_data);
-	if (ret)
-		return ret;
-
-	/* If KSZ8_PORT_802_1P_ENABLE bit is set on Port 2, the driver showed
-	 * the interest in PCP classification on Port 2. In this case,
-	 * multiqueue support is enabled and we can enable any apptrust on
-	 * Port 1.
-	 * If KSZ8_PORT_802_1P_ENABLE bit is not set on Port 2, the PCP
-	 * classification on Port 2 is still active, but the driver disabled
-	 * multiqueue support and made frame prioritization inactive for
-	 * all ports. In this case, we can't enable any apptrust on Port 1.
-	 */
-	if (!(port2_data & KSZ8_PORT_802_1P_ENABLE)) {
-		dev_err(dev->dev, "Not possible to enable any apptrust on Port 1 if PCP apptrust on Port 2 is disabled\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * ksz88x3_port2_apptrust_quirk - Quirk for apptrust configuration on Port 2
- *				  of KSZ88x3 devices
- * @dev: Pointer to the KSZ switch device structure
- * @port: Port number for which to set the apptrust selectors
- * @reg: Register address for the apptrust configuration
- * @port2_data: Data to set for the apptrust configuration
- *
- * This function implements a quirk for apptrust configuration on Port 2 of
- * KSZ88x3 devices. It ensures that DSCP apptrust is not working on Port 2 and
- * that it is not possible to disable PCP on Port 2. The only way to disable PCP
- * on Port 2 is to disable multiple queues on the switch.
- *
- * Return: 0 on success, or a negative error code on failure
- */
-static int ksz88x3_port2_apptrust_quirk(struct ksz_device *dev, int port,
-					int reg, u8 port2_data)
-{
-	struct dsa_switch *ds = dev->ds;
-	u8 port1_data;
-	int ret;
-
-	/* First validate Port 2 configuration. DiffServ/DSCP is not working
-	 * on this port.
-	 */
-	if (port2_data & KSZ8_PORT_DIFFSERV_ENABLE) {
-		dev_err(dev->dev, "DSCP apptrust is not working on Port 2\n");
-		return -EINVAL;
-	}
-
-	/* If PCP support is requested, we need to enable all queues on the
-	 * switch to make PCP priority working on Port 2.
-	 */
-	if (port2_data & KSZ8_PORT_802_1P_ENABLE)
-		return ksz8_all_queues_split(dev, dev->info->num_tx_queues);
-
-	/* We got request to disable PCP priority on Port 2.
-	 * Now, we need to compare Port 2 configuration with Port 1
-	 * configuration.
-	 */
-	ret = ksz_pread8(dev, KSZ_PORT_1, reg, &port1_data);
-	if (ret)
-		return ret;
-
-	/* If Port 1 has any apptrust enabled, we can't disable multiple queues
-	 * on the switch, so we can't disable PCP on Port 2.
-	 */
-	if (port1_data & (KSZ8_PORT_802_1P_ENABLE | KSZ8_PORT_DIFFSERV_ENABLE)) {
-		dev_err(dev->dev, "Not possible to disable PCP on Port 2 if any apptrust is enabled on Port 1\n");
-		return -EINVAL;
-	}
-
-	/* Now we need to ensure that default priority on Port 1 is set to 0
-	 * otherwise we can't disable multiqueue support on the switch.
-	 */
-	ret = ksz_port_get_default_prio(ds, KSZ_PORT_1);
-	if (ret < 0) {
-		return ret;
-	} else if (ret) {
-		dev_err(dev->dev, "Not possible to disable PCP on Port 2 if non zero default priority is set on Port 1\n");
-		return -EINVAL;
-	}
-
-	/* Port 1 has no apptrust or default priority set and we got request to
-	 * disable PCP on Port 2. We can disable multiqueue support to disable
-	 * PCP on Port 2.
-	 */
-	return ksz8_all_queues_split(dev, 1);
-}
-
-/**
- * ksz88x3_port_apptrust_quirk - Quirk for apptrust configuration on KSZ88x3
- *			       devices
- * @dev: Pointer to the KSZ switch device structure
- * @port: Port number for which to set the apptrust selectors
- * @reg: Register address for the apptrust configuration
- * @data: Data to set for the apptrust configuration
- *
- * This function implements a quirk for apptrust configuration on KSZ88x3
- * devices. It ensures that apptrust configuration on Port 1 and
- * Port 2 is done in agreement with each other.
- *
- * Return: 0 on success, or a negative error code on failure
- */
-static int ksz88x3_port_apptrust_quirk(struct ksz_device *dev, int port,
-				       int reg, u8 data)
-{
-	if (port == KSZ_PORT_1)
-		return ksz88x3_port1_apptrust_quirk(dev, port, reg, data);
-	else if (port == KSZ_PORT_2)
-		return ksz88x3_port2_apptrust_quirk(dev, port, reg, data);
-
-	return 0;
-}
-
 /**
  * ksz_port_set_apptrust - Sets the apptrust selectors for a port on a KSZ
  *			   switch
@@ -707,12 +514,6 @@ int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
 		}
 	}
 
-	if (ksz_is_ksz88x3(dev)) {
-		ret = ksz88x3_port_apptrust_quirk(dev, port, reg, data);
-		if (ret)
-			return ret;
-	}
-
 	return ksz_prmw8(dev, port, reg, mask, data);
 }
 
@@ -799,21 +600,5 @@ int ksz_dcb_init_port(struct ksz_device *dev, int port)
  */
 int ksz_dcb_init(struct ksz_device *dev)
 {
-	int ret;
-
-	ret = ksz_init_global_dscp_map(dev);
-	if (ret)
-		return ret;
-
-	/* Enable 802.1p priority control on Port 2 during switch initialization.
-	 * This setup is critical for the apptrust functionality on Port 1, which
-	 * relies on the priority settings of Port 2. Note: Port 1 is naturally
-	 * configured before Port 2, necessitating this configuration order.
-	 */
-	if (ksz_is_ksz88x3(dev))
-		return ksz_prmw8(dev, KSZ_PORT_2, KSZ8_REG_PORT_1_CTRL_0,
-				 KSZ8_PORT_802_1P_ENABLE,
-				 KSZ8_PORT_802_1P_ENABLE);
-
-	return 0;
+	return ksz_init_global_dscp_map(dev);
 }
-- 
2.39.5


