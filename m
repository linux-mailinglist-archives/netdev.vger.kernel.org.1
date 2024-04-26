Return-Path: <netdev+bounces-91761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263A8B3C6D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA951C20DD1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7114D6FA;
	Fri, 26 Apr 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U7c/z5Q1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC131474A0
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147700; cv=none; b=GZXXbEF/iOmErZutVsh+FeALZwqDaS41kM8GwniRe+5HQXFSXXL0JUgUY91nKhIyt4Wo5S/K27Qhx1IShmHzBcGioJrFvkURe7E+qlEFGFG/OwS9nMJD3/RP9tH/RBHS/cpgoZAOOmtMcOp95TTpnS/BcYjPR642w/CB2annSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147700; c=relaxed/simple;
	bh=lETqJd0U6ydwkYld1nPCG5ZfYcDdo84ow2xKB2EeNc0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Qp8SeJBeYRZGGWCcq+hsOvrcMo30nFDcl0g9M05h1xZm+IipyjDTfPVbnPmq0p1DIkMu56mm1eFJuNGhPQ2yVw+OFJ/qV/MqvYZM1awJMuuenuYIpKBRCShQWm4DvIwG+NUaNBNVTaogoIj1Eb8BWWs0pS8o6P25JAJk//6LMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U7c/z5Q1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wBRI02wiYBzrx2Z+obSnSBLmupK3FWlKHlLHbRcNdFU=; b=U7c/z5Q1pjOD2pGumJv9CpuvjH
	Gg4Dml8Q0MKXbEwnYAf5j2qXS7vB9G2m70r1KcmH2hAxHPXpLx+zthhQFjeFnry8RIuKIaNHcIVUy
	ewOSNsNh7r1ayzLWyKTGOkcfAu8jxnF+qf7u8PGsdFFRgQyhl4lq+uAmngaEw/F7rqMHSCufy7uCf
	ynwy2omAxgFwBHhLl7oh2UfoJFA3j5DAY8QyWFBgJyIRhhsya0a165dHUGNwEGr8UyEYTTSHukquF
	ZfLmtCyrjiAxVkSX0TGO3r1SUl/ZxVa6T4dc+OM3lCuaSRYODF6Mmz5RvbfI8sUdUu1fCVQ1HQT1u
	vugDhYbA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49300 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0O7L-0000UE-1G;
	Fri, 26 Apr 2024 17:08:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0O7M-009gpw-Lj; Fri, 26 Apr 2024 17:08:08 +0100
In-Reply-To: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
References: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Florian Fainelli <f.fainelli@gmail.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] net: dsa: ksz_common: sub-driver phylink ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s0O7M-009gpw-Lj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:08:08 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz8.h       |  6 +-
 drivers/net/dsa/microchip/ksz8795.c    | 10 ++-
 drivers/net/dsa/microchip/ksz_common.c | 84 ++++++++++++++++----------
 drivers/net/dsa/microchip/ksz_common.h |  2 +
 4 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 571c26ce71e4..9a286d73e9cf 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -54,9 +54,9 @@ int ksz8_reset_switch(struct ksz_device *dev);
 int ksz8_switch_init(struct ksz_device *dev);
 void ksz8_switch_exit(struct ksz_device *dev);
 int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
-void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
-			      unsigned int mode, phy_interface_t interface,
-			      struct phy_device *phydev, int speed, int duplex,
+void ksz8_phylink_mac_link_up(struct phylink_config *config,
+			      struct phy_device *phydev, unsigned int mode,
+			      phy_interface_t interface, int speed, int duplex,
 			      bool tx_pause, bool rx_pause);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index ecef6f6f830b..b2f66cc75208 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1702,11 +1702,15 @@ static void ksz8_cpu_port_link_up(struct ksz_device *dev, int speed, int duplex,
 		 SW_10_MBIT, ctrl);
 }
 
-void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
-			      unsigned int mode, phy_interface_t interface,
-			      struct phy_device *phydev, int speed, int duplex,
+void ksz8_phylink_mac_link_up(struct phylink_config *config,
+			      struct phy_device *phydev, unsigned int mode,
+			      phy_interface_t interface, int speed, int duplex,
 			      bool tx_pause, bool rx_pause)
 {
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	int port = dp->index;
+
 	/* If the port is the CPU port, apply special handling. Only the CPU
 	 * port is configured via global registers.
 	 */
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4a754801bca4..2ff0cb175daf 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -253,6 +253,19 @@ static const struct ksz_drive_strength ksz8830_drive_strengths[] = {
 	{ KSZ8873_DRIVE_STRENGTH_16MA, 16000 },
 };
 
+static void ksz_phylink_mac_config(struct phylink_config *config,
+				   unsigned int mode,
+				   const struct phylink_link_state *state);
+static void ksz_phylink_mac_link_down(struct phylink_config *config,
+				      unsigned int mode,
+				      phy_interface_t interface);
+
+static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz8_phylink_mac_link_up,
+};
+
 static const struct ksz_dev_ops ksz8_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
@@ -277,7 +290,6 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
-	.phylink_mac_link_up = ksz8_phylink_mac_link_up,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
@@ -286,13 +298,19 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.change_mtu = ksz8_change_mtu,
 };
 
-static void ksz9477_phylink_mac_link_up(struct ksz_device *dev, int port,
+static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
+					struct phy_device *phydev,
 					unsigned int mode,
 					phy_interface_t interface,
-					struct phy_device *phydev, int speed,
-					int duplex, bool tx_pause,
+					int speed, int duplex, bool tx_pause,
 					bool rx_pause);
 
+static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz9477_phylink_mac_link_up,
+};
+
 static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.setup = ksz9477_setup,
 	.get_port_addr = ksz9477_get_port_addr,
@@ -319,7 +337,6 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.mdb_add = ksz9477_mdb_add,
 	.mdb_del = ksz9477_mdb_del,
 	.change_mtu = ksz9477_change_mtu,
-	.phylink_mac_link_up = ksz9477_phylink_mac_link_up,
 	.get_wol = ksz9477_get_wol,
 	.set_wol = ksz9477_set_wol,
 	.wol_pre_shutdown = ksz9477_wol_pre_shutdown,
@@ -331,6 +348,12 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.exit = ksz9477_switch_exit,
 };
 
+static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz9477_phylink_mac_link_up,
+};
+
 static const struct ksz_dev_ops lan937x_dev_ops = {
 	.setup = lan937x_setup,
 	.teardown = lan937x_teardown,
@@ -359,7 +382,6 @@ static const struct ksz_dev_ops lan937x_dev_ops = {
 	.mdb_add = ksz9477_mdb_add,
 	.mdb_del = ksz9477_mdb_del,
 	.change_mtu = lan937x_change_mtu,
-	.phylink_mac_link_up = ksz9477_phylink_mac_link_up,
 	.config_cpu_port = lan937x_config_cpu_port,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
 	.enable_stp_addr = ksz9477_enable_stp_addr,
@@ -1197,6 +1219,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1224,6 +1247,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
 		.ops = &ksz8_dev_ops,
+		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1263,6 +1287,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
 		.ops = &ksz8_dev_ops,
+		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1288,6 +1313,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
 		.ops = &ksz8_dev_ops,
+		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1313,6 +1339,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,
 		.num_tx_queues = 4,
 		.ops = &ksz8_dev_ops,
+		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1339,6 +1366,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1371,6 +1399,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1403,6 +1432,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1433,6 +1463,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1461,6 +1492,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1489,6 +1521,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1554,6 +1587,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
+		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1581,6 +1615,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
+		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1608,6 +1643,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
+		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1639,6 +1675,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
+		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1670,6 +1707,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
+		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -3187,13 +3225,16 @@ static void ksz_duplex_flowctrl(struct ksz_device *dev, int port, int duplex,
 	ksz_prmw8(dev, port, regs[P_XMII_CTRL_0], mask, val);
 }
 
-static void ksz9477_phylink_mac_link_up(struct ksz_device *dev, int port,
+static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
+					struct phy_device *phydev,
 					unsigned int mode,
 					phy_interface_t interface,
-					struct phy_device *phydev, int speed,
-					int duplex, bool tx_pause,
+					int speed, int duplex, bool tx_pause,
 					bool rx_pause)
 {
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	int port = dp->index;
 	struct ksz_port *p;
 
 	p = &dev->ports[port];
@@ -3209,21 +3250,6 @@ static void ksz9477_phylink_mac_link_up(struct ksz_device *dev, int port,
 	ksz_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
 }
 
-static void ksz_phylink_mac_link_up(struct phylink_config *config,
-				    struct phy_device *phydev,
-				    unsigned int mode,
-				    phy_interface_t interface,
-				    int speed, int duplex, bool tx_pause,
-				    bool rx_pause)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct ksz_device *dev = dp->ds->priv;
-
-	dev->dev_ops->phylink_mac_link_up(dev, dp->index, mode, interface,
-					  phydev, speed, duplex, tx_pause,
-					  rx_pause);
-}
-
 static int ksz_switch_detect(struct ksz_device *dev)
 {
 	u8 id1, id2, id4;
@@ -3875,12 +3901,6 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static const struct phylink_mac_ops ksz_phylink_mac_ops = {
-	.mac_config	= ksz_phylink_mac_config,
-	.mac_link_down	= ksz_phylink_mac_link_down,
-	.mac_link_up	= ksz_phylink_mac_link_up,
-};
-
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
@@ -3945,7 +3965,6 @@ struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
 	ds->dev = base;
 	ds->num_ports = DSA_MAX_PORTS;
 	ds->ops = &ksz_switch_ops;
-	ds->phylink_mac_ops = &ksz_phylink_mac_ops;
 
 	swdev = devm_kzalloc(base, sizeof(*swdev), GFP_KERNEL);
 	if (!swdev)
@@ -4335,6 +4354,9 @@ int ksz_switch_register(struct ksz_device *dev)
 	/* set the real number of ports */
 	dev->ds->num_ports = dev->info->port_cnt;
 
+	/* set the phylink ops */
+	dev->ds->phylink_mac_ops = dev->info->phylink_mac_ops;
+
 	/* Host port interface will be self detected, or specifically set in
 	 * device tree.
 	 */
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c88ab5e89ecc..9409b844af63 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -22,6 +22,7 @@
 
 struct ksz_device;
 struct ksz_port;
+struct phylink_mac_ops;
 
 enum ksz_regmap_width {
 	KSZ_REGMAP_8,
@@ -61,6 +62,7 @@ struct ksz_chip_data {
 	bool tc_cbs_supported;
 	bool tc_ets_supported;
 	const struct ksz_dev_ops *ops;
+	const struct phylink_mac_ops *phylink_mac_ops;
 	bool ksz87xx_eee_link_erratum;
 	const struct ksz_mib_names *mib_names;
 	int mib_cnt;
-- 
2.30.2


