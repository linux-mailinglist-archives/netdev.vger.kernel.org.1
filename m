Return-Path: <netdev+bounces-17473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48958751BF8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36FC281C4B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A62DDB6;
	Thu, 13 Jul 2023 08:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141038BEC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:42:50 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11F30EE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uqCHlHHFBT5YuXO3dwAtuW/rcl5PC7+ZS6n8O3v9YUE=; b=vNNwF/jRYlhkZlf7IB/lZP3sp2
	czyhGNesUHXFtGcUM+C7JiPdCJbOk8WAiZsOJRjwQOE+cXNVcWd0jhEvnO2QE9Ygy1mx9awrxPNVE
	/nEymXVuqYDqLEl86nVMTTe2qO7378+i2fbOOWYoAtH+9mwnDTvhnO3QKPvP9AN262GiHlCEkjXAm
	37UlUUXu5yq9oB3oplKpQlayb6VEJpIvQoKOSSvevA6ZeNpV2brrnJ0kFl6ZgQAtvRK/GHJqOs9gp
	S2J0GZg8yemF4N97GkedgLAqG2WFWj0IS10u4Qhdva4pCRCUxaHdhCyftsH5FRoxiT2K+VxfT8d2J
	ei3HCbIA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37346 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qJruN-00069U-2Q;
	Thu, 13 Jul 2023 09:42:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qJruN-00Gkjw-H3; Thu, 13 Jul 2023 09:42:43 +0100
In-Reply-To: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
References: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 08/11] net: dsa: mv88e6xxx: convert 88e6185 to
 phylink_pcs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qJruN-00Gkjw-H3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jul 2023 09:42:43 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert the 88E6185 SERDES code to use the phylink_pcs infrastructure.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/Makefile   |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c     |  14 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c | 190 +++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.c   | 109 ---------------
 drivers/net/dsa/mv88e6xxx/serdes.h   |  11 +-
 5 files changed, 196 insertions(+), 129 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-6185.c

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index 1409e691ab77..9becf56fdec1 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -9,6 +9,7 @@ mv88e6xxx-objs += global2.o
 mv88e6xxx-objs += global2_avb.o
 mv88e6xxx-objs += global2_scratch.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += hwtstamp.o
+mv88e6xxx-objs += pcs-6185.o
 mv88e6xxx-objs += phy.o
 mv88e6xxx-objs += port.o
 mv88e6xxx-objs += port_hidden.o
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index acbe55762f5e..fd876cf5577f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4230,15 +4230,13 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 	.stats_get_strings = mv88e6095_stats_get_strings,
 	.stats_get_stats = mv88e6095_stats_get_stats,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
-	.serdes_power = mv88e6185_serdes_power,
-	.serdes_get_lane = mv88e6185_serdes_get_lane,
-	.serdes_pcs_get_state = mv88e6185_serdes_pcs_get_state,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
 	.reset = mv88e6185_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
 	.phylink_get_caps = mv88e6095_phylink_get_caps,
+	.pcs_ops = &mv88e6185_pcs_ops,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
 };
 
@@ -4276,18 +4274,14 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
-	.serdes_power = mv88e6185_serdes_power,
-	.serdes_get_lane = mv88e6185_serdes_get_lane,
-	.serdes_pcs_get_state = mv88e6185_serdes_pcs_get_state,
 	.serdes_irq_mapping = mv88e6390_serdes_irq_mapping,
-	.serdes_irq_enable = mv88e6097_serdes_irq_enable,
-	.serdes_irq_status = mv88e6097_serdes_irq_status,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6085_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.phylink_get_caps = mv88e6095_phylink_get_caps,
+	.pcs_ops = &mv88e6185_pcs_ops,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
@@ -4768,9 +4762,6 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
-	.serdes_power = mv88e6185_serdes_power,
-	.serdes_get_lane = mv88e6185_serdes_get_lane,
-	.serdes_pcs_get_state = mv88e6185_serdes_pcs_get_state,
 	.set_cascade_port = mv88e6185_g1_set_cascade_port,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
@@ -4778,6 +4769,7 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.pcs_ops = &mv88e6185_pcs_ops,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
 };
 
diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6185.c b/drivers/net/dsa/mv88e6xxx/pcs-6185.c
new file mode 100644
index 000000000000..4d677f836807
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6185.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Marvell 88E6185 family SERDES PCS support
+ *
+ * Copyright (c) 2008 Marvell Semiconductor
+ *
+ * Copyright (c) 2017 Andrew Lunn <andrew@lunn.ch>
+ */
+#include <linux/phylink.h>
+
+#include "global2.h"
+#include "port.h"
+#include "serdes.h"
+
+struct mv88e6185_pcs {
+	struct phylink_pcs phylink_pcs;
+	unsigned int irq;
+	char name[64];
+
+	struct mv88e6xxx_chip *chip;
+	int port;
+};
+
+static struct mv88e6185_pcs *pcs_to_mv88e6185_pcs(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct mv88e6185_pcs, phylink_pcs);
+}
+
+static irqreturn_t mv88e6185_pcs_handle_irq(int irq, void *dev_id)
+{
+	struct mv88e6185_pcs *mpcs = dev_id;
+	struct mv88e6xxx_chip *chip;
+	irqreturn_t ret = IRQ_NONE;
+	bool link_up;
+	u16 status;
+	int port;
+	int err;
+
+	chip = mpcs->chip;
+	port = mpcs->port;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &status);
+	mv88e6xxx_reg_unlock(chip);
+
+	if (!err) {
+		link_up = !!(status & MV88E6XXX_PORT_STS_LINK);
+
+		phylink_pcs_change(&mpcs->phylink_pcs, link_up);
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static void mv88e6185_pcs_get_state(struct phylink_pcs *pcs,
+				    struct phylink_link_state *state)
+{
+	struct mv88e6185_pcs *mpcs = pcs_to_mv88e6185_pcs(pcs);
+	struct mv88e6xxx_chip *chip = mpcs->chip;
+	int port = mpcs->port;
+	u16 status;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &status);
+	mv88e6xxx_reg_unlock(chip);
+
+	if (err)
+		status = 0;
+
+	state->link = !!(status & MV88E6XXX_PORT_STS_LINK);
+	if (state->link) {
+		state->duplex = status & MV88E6XXX_PORT_STS_DUPLEX ?
+			DUPLEX_FULL : DUPLEX_HALF;
+
+		switch (status & MV88E6XXX_PORT_STS_SPEED_MASK) {
+		case MV88E6XXX_PORT_STS_SPEED_1000:
+			state->speed = SPEED_1000;
+			break;
+
+		case MV88E6XXX_PORT_STS_SPEED_100:
+			state->speed = SPEED_100;
+			break;
+
+		case MV88E6XXX_PORT_STS_SPEED_10:
+			state->speed = SPEED_10;
+			break;
+
+		default:
+			state->link = false;
+			break;
+		}
+	}
+}
+
+static int mv88e6185_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+				phy_interface_t interface,
+				const unsigned long *advertising,
+				bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static void mv88e6185_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static const struct phylink_pcs_ops mv88e6185_phylink_pcs_ops = {
+	.pcs_get_state = mv88e6185_pcs_get_state,
+	.pcs_config = mv88e6185_pcs_config,
+	.pcs_an_restart = mv88e6185_pcs_an_restart,
+};
+
+static int mv88e6185_pcs_init(struct mv88e6xxx_chip *chip, int port)
+{
+	struct mv88e6185_pcs *mpcs;
+	struct device *dev;
+	unsigned int irq;
+	int err;
+
+	/* There are no configurable serdes lanes on this switch chip, so
+	 * we use the static cmode configuration to determine whether we
+	 * have a PCS or not.
+	 */
+	if (chip->ports[port].cmode != MV88E6185_PORT_STS_CMODE_SERDES &&
+	    chip->ports[port].cmode != MV88E6185_PORT_STS_CMODE_1000BASE_X)
+		return 0;
+
+	dev = chip->dev;
+
+	mpcs = kzalloc(sizeof(*mpcs), GFP_KERNEL);
+	if (!mpcs)
+		return -ENOMEM;
+
+	mpcs->chip = chip;
+	mpcs->port = port;
+	mpcs->phylink_pcs.ops = &mv88e6185_phylink_pcs_ops;
+
+	irq = mv88e6xxx_serdes_irq_mapping(chip, port);
+	if (irq) {
+		snprintf(mpcs->name, sizeof(mpcs->name),
+			 "mv88e6xxx-%s-serdes-%d", dev_name(dev), port);
+
+		err = request_threaded_irq(irq, NULL, mv88e6185_pcs_handle_irq,
+					   IRQF_ONESHOT, mpcs->name, mpcs);
+		if (err) {
+			kfree(mpcs);
+			return err;
+		}
+
+		mpcs->irq = irq;
+	} else {
+		mpcs->phylink_pcs.poll = true;
+	}
+
+	chip->ports[port].pcs_private = &mpcs->phylink_pcs;
+
+	return 0;
+}
+
+static void mv88e6185_pcs_teardown(struct mv88e6xxx_chip *chip, int port)
+{
+	struct mv88e6185_pcs *mpcs;
+
+	mpcs = chip->ports[port].pcs_private;
+	if (!mpcs)
+		return;
+
+	if (mpcs->irq)
+		free_irq(mpcs->irq, mpcs);
+
+	kfree(mpcs);
+
+	chip->ports[port].pcs_private = NULL;
+}
+
+static struct phylink_pcs *mv88e6185_pcs_select(struct mv88e6xxx_chip *chip,
+						int port,
+						phy_interface_t interface)
+{
+	return chip->ports[port].pcs_private;
+}
+
+const struct mv88e6xxx_pcs_ops mv88e6185_pcs_ops = {
+	.pcs_init = mv88e6185_pcs_init,
+	.pcs_teardown = mv88e6185_pcs_teardown,
+	.pcs_select = mv88e6185_pcs_select,
+};
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 7ea36d04d9fa..5ac5687e76a9 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -460,115 +460,6 @@ int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
 	return lane;
 }
 
-int mv88e6185_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
-			   bool up)
-{
-	/* The serdes power can't be controlled on this switch chip but we need
-	 * to supply this function to avoid returning -EOPNOTSUPP in
-	 * mv88e6xxx_serdes_power_up/mv88e6xxx_serdes_power_down
-	 */
-	return 0;
-}
-
-int mv88e6185_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
-{
-	/* There are no configurable serdes lanes on this switch chip but we
-	 * need to return a non-negative lane number so that callers of
-	 * mv88e6xxx_serdes_get_lane() know this is a serdes port.
-	 */
-	switch (chip->ports[port].cmode) {
-	case MV88E6185_PORT_STS_CMODE_SERDES:
-	case MV88E6185_PORT_STS_CMODE_1000BASE_X:
-		return 0;
-	default:
-		return -ENODEV;
-	}
-}
-
-int mv88e6185_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
-				   int lane, struct phylink_link_state *state)
-{
-	int err;
-	u16 status;
-
-	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &status);
-	if (err)
-		return err;
-
-	state->link = !!(status & MV88E6XXX_PORT_STS_LINK);
-
-	if (state->link) {
-		state->duplex = status & MV88E6XXX_PORT_STS_DUPLEX ? DUPLEX_FULL : DUPLEX_HALF;
-
-		switch (status &  MV88E6XXX_PORT_STS_SPEED_MASK) {
-		case MV88E6XXX_PORT_STS_SPEED_1000:
-			state->speed = SPEED_1000;
-			break;
-		case MV88E6XXX_PORT_STS_SPEED_100:
-			state->speed = SPEED_100;
-			break;
-		case MV88E6XXX_PORT_STS_SPEED_10:
-			state->speed = SPEED_10;
-			break;
-		default:
-			dev_err(chip->dev, "invalid PHY speed\n");
-			return -EINVAL;
-		}
-	} else {
-		state->duplex = DUPLEX_UNKNOWN;
-		state->speed = SPEED_UNKNOWN;
-	}
-
-	return 0;
-}
-
-int mv88e6097_serdes_irq_enable(struct mv88e6xxx_chip *chip, int port, int lane,
-				bool enable)
-{
-	u8 cmode = chip->ports[port].cmode;
-
-	/* The serdes interrupts are enabled in the G2_INT_MASK register. We
-	 * need to return 0 to avoid returning -EOPNOTSUPP in
-	 * mv88e6xxx_serdes_irq_enable/mv88e6xxx_serdes_irq_disable
-	 */
-	switch (cmode) {
-	case MV88E6185_PORT_STS_CMODE_SERDES:
-	case MV88E6185_PORT_STS_CMODE_1000BASE_X:
-		return 0;
-	}
-
-	return -EOPNOTSUPP;
-}
-
-static void mv88e6097_serdes_irq_link(struct mv88e6xxx_chip *chip, int port)
-{
-	u16 status;
-	int err;
-
-	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &status);
-	if (err) {
-		dev_err(chip->dev, "can't read port status: %d\n", err);
-		return;
-	}
-
-	dsa_port_phylink_mac_change(chip->ds, port, !!(status & MV88E6XXX_PORT_STS_LINK));
-}
-
-irqreturn_t mv88e6097_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
-					int lane)
-{
-	u8 cmode = chip->ports[port].cmode;
-
-	switch (cmode) {
-	case MV88E6185_PORT_STS_CMODE_SERDES:
-	case MV88E6185_PORT_STS_CMODE_1000BASE_X:
-		mv88e6097_serdes_irq_link(chip, port);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
 {
 	u8 cmode = chip->ports[port].cmode;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 93d40d66d7c5..93d363eb61ea 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -112,7 +112,6 @@ struct phylink_link_state;
 int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 			       u16 status, struct phylink_link_state *state);
 
-int mv88e6185_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
@@ -126,8 +125,6 @@ int mv88e6390_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 				int lane, unsigned int mode,
 				phy_interface_t interface,
 				const unsigned long *advertise);
-int mv88e6185_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
-				   int lane, struct phylink_link_state *state);
 int mv88e6352_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
 				   int lane, struct phylink_link_state *state);
 int mv88e6390_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
@@ -146,8 +143,6 @@ unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
-int mv88e6185_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
-			   bool up);
 int mv88e6352_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 			   bool on);
 int mv88e6390_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
@@ -155,16 +150,12 @@ int mv88e6390_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 int mv88e6393x_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 			    bool on);
 int mv88e6393x_serdes_setup_errata(struct mv88e6xxx_chip *chip);
-int mv88e6097_serdes_irq_enable(struct mv88e6xxx_chip *chip, int port, int lane,
-				bool enable);
 int mv88e6352_serdes_irq_enable(struct mv88e6xxx_chip *chip, int port, int lane,
 				bool enable);
 int mv88e6390_serdes_irq_enable(struct mv88e6xxx_chip *chip, int port, int lane,
 				bool enable);
 int mv88e6393x_serdes_irq_enable(struct mv88e6xxx_chip *chip, int port,
 				 int lane, bool enable);
-irqreturn_t mv88e6097_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
-					int lane);
 irqreturn_t mv88e6352_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
 					int lane);
 irqreturn_t mv88e6390_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
@@ -254,4 +245,6 @@ mv88e6xxx_serdes_irq_status(struct mv88e6xxx_chip *chip, int port, int lane)
 	return chip->info->ops->serdes_irq_status(chip, port, lane);
 }
 
+extern const struct mv88e6xxx_pcs_ops mv88e6185_pcs_ops;
+
 #endif
-- 
2.30.2


