Return-Path: <netdev+bounces-94495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4E8BFB1F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FF01F230EB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFAE82484;
	Wed,  8 May 2024 10:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E253381729
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164755; cv=none; b=OIJbwppUgI/6CeCqwLhmISdjD8XQEUnCZ1f7xgg46H28xhKm6OimjP9XevR8lxP5VvcLeSjljRfQqlFR/hK7iZK32TkoVU6g5p/E/Hsh58N271H3yz2W9QZPs6UToOFM7rHEVy9+OkaKhYpgN3zYPN2Vy8cgZFXD8V/qovLA5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164755; c=relaxed/simple;
	bh=9GMqPY+WGCaEYEwNzV8SklJ7IpIqbn01xpSTtJB9/io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAHU073Ua3iQvua8Xh1GOHJhTYI2O1qnYeQPI//YCOgxpztwNiAKFlKgOWFoiLGIlK2yc/RmnWjgzcsTAylbqSANPZmHMuvO4EBEkhjgqh7xq+7l3eckZ9KBNvoTccB+kbFIJNB3Qdjjzn8hq1W/kNZUPNHtZemTkIsR4u5oHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehV-0004BK-8n; Wed, 08 May 2024 12:39:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-000G0H-I6; Wed, 08 May 2024 12:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-00HLTj-1W;
	Wed, 08 May 2024 12:39:03 +0200
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
	Woojung Huh <Woojung.Huh@microchip.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 2/3] net: dsa: microchip: dcb: rename IPV to IPM
Date: Wed,  8 May 2024 12:39:01 +0200
Message-Id: <20240508103902.4134098-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508103902.4134098-1-o.rempel@pengutronix.de>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
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

IPV is added and used term in 802.1Qci PSFP and merged into 802.1Q (from
802.1Q-2018) for another functions.

Even it does similar operation holding temporal priority value
internally (as it is named), because KSZ datasheet doesn't use the term
of IPV (Internal Priority Value) and avoiding any confusion later when
PSFP is in the Linux world, it is better to rename IPV to IPM (Internal
Priority Mapping).

In addition, LAN937x documentation already use IPV for 802.1Qci PSFP
related functionality. This will conflict with other part of
functionality with will be named IPM from now.

Suggested-by: Woojung Huh <Woojung.Huh@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 46 +++++++++++------------
 drivers/net/dsa/microchip/ksz_common.h |  2 +-
 drivers/net/dsa/microchip/ksz_dcb.c    | 52 +++++++++++++-------------
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 95622dec2b28a..7b243538dd1e2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1227,7 +1227,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
@@ -1257,7 +1257,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
-		.num_ipvs = 4,
+		.num_ipms = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
@@ -1298,7 +1298,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
-		.num_ipvs = 4,
+		.num_ipms = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
@@ -1325,7 +1325,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
-		.num_ipvs = 4,
+		.num_ipms = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
@@ -1352,7 +1352,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x4,	/* can be configured as cpu port */
 		.port_cnt = 3,
 		.num_tx_queues = 4,
-		.num_ipvs = 4,
+		.num_ipms = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
@@ -1378,7 +1378,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 4,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
@@ -1413,7 +1413,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 6,		/* total physical port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1447,7 +1447,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1479,7 +1479,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1507,7 +1507,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
@@ -1536,7 +1536,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
@@ -1570,7 +1570,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1602,7 +1602,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
@@ -1630,7 +1630,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 6,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
@@ -1658,7 +1658,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 8,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
@@ -1690,7 +1690,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
@@ -1722,7 +1722,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 8,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
-		.num_ipvs = 8,
+		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
@@ -2726,20 +2726,20 @@ static int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
 						  int port)
 {
 	u32 queue_map = 0;
-	int ipv;
+	int ipm;
 
-	for (ipv = 0; ipv < dev->info->num_ipvs; ipv++) {
+	for (ipm = 0; ipm < dev->info->num_ipms; ipm++) {
 		int queue;
 
 		/* Traffic Type (TT) is corresponding to the Internal Priority
-		 * Value (IPV) in the switch. Traffic Class (TC) is
+		 * Value (IPM) in the switch. Traffic Class (TC) is
 		 * corresponding to the queue in the switch.
 		 */
-		queue = ieee8021q_tt_to_tc(ipv, dev->info->num_tx_queues);
+		queue = ieee8021q_tt_to_tc(ipm, dev->info->num_tx_queues);
 		if (queue < 0)
 			return queue;
 
-		queue_map |= queue << (ipv * KSZ9477_PORT_TC_MAP_S);
+		queue_map |= queue << (ipm * KSZ9477_PORT_TC_MAP_S);
 	}
 
 	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
@@ -3609,7 +3609,7 @@ static int ksz_tc_ets_add(struct ksz_device *dev, int port,
 	for (tc_prio = 0; tc_prio < ARRAY_SIZE(p->priomap); tc_prio++) {
 		int queue;
 
-		if (tc_prio >= dev->info->num_ipvs)
+		if (tc_prio >= dev->info->num_ipms)
 			break;
 
 		queue = ksz_ets_band_to_queue(p, p->priomap[tc_prio]);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index baf236792e107..c784fd23a9937 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -62,7 +62,7 @@ struct ksz_chip_data {
 	int port_cnt;
 	u8 port_nirqs;
 	u8 num_tx_queues;
-	u8 num_ipvs; /* number of Internal Priority Values */
+	u8 num_ipms; /* number of Internal Priority Maps */
 	bool tc_cbs_supported;
 	const struct ksz_dev_ops *ops;
 	const struct phylink_mac_ops *phylink_mac_ops;
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 879471cf815e3..07f6742df41bd 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -52,7 +52,7 @@ static const struct ksz_apptrust_map ksz9477_apptrust_map_to_bit[] = {
 };
 
 /* ksz_supported_apptrust[] - Supported apptrust selectors and Priority Order
- *			      of Internal Priority Value (IPV) sources.
+ *			      of Internal Priority Map (IPM) sources.
  *
  * This array defines the apptrust selectors supported by the hardware, where
  * the index within the array indicates the priority of the selector - lower
@@ -246,7 +246,7 @@ int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 	int reg, shift, ret;
 	u8 mask;
 
-	if (prio >= dev->info->num_ipvs)
+	if (prio >= dev->info->num_ipms)
 		return -EINVAL;
 
 	if (ksz_is_ksz88x3(dev)) {
@@ -282,7 +282,7 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
 
 	/* If DSCP remapping is disabled, DSCP bits 3-5 are used as Internal
-	 * Priority Value (IPV)
+	 * Priority Map (IPM)
 	 */
 	if (!is_ksz8(dev)) {
 		ret = ksz_read8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL, &data);
@@ -290,7 +290,7 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 			return ret;
 
 		/* If DSCP remapping is disabled, DSCP bits 3-5 are used as
-		 * Internal Priority Value (IPV)
+		 * Internal Priority Map (IPM)
 		 */
 		if (!(data & KSZ9477_SW_TOS_DSCP_REMAP))
 			return FIELD_GET(KSZ9477_SW_TOS_DSCP_DEFAULT_PRIO_M,
@@ -331,7 +331,7 @@ static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipm)
 	shift = (dscp % per_reg) * (8 / per_reg);
 
 	return ksz_rmw8(dev, reg + (dscp / per_reg), mask << shift,
-			ipv << shift);
+			ipm << shift);
 }
 
 /**
@@ -360,15 +360,15 @@ static int ksz_init_global_dscp_map(struct ksz_device *dev)
 	}
 
 	for (dscp = 0; dscp < DSCP_MAX; dscp++) {
-		int ipv, tt;
+		int ipm, tt;
 
 		/* Map DSCP to Traffic Type, which is corresponding to the
-		 * Internal Priority Value (IPV) in the switch.
+		 * Internal Priority Map (IPM) in the switch.
 		 */
 		if (!is_ksz8(dev)) {
-			ipv = ietf_dscp_to_ieee8021q_tt(dscp);
+			ipm = ietf_dscp_to_ieee8021q_tt(dscp);
 		} else {
-			/* On KSZ8xxx variants we do not have IPV to queue
+			/* On KSZ8xxx variants we do not have IPM to queue
 			 * remapping table. We need to convert DSCP to Traffic
 			 * Type and then to queue.
 			 */
@@ -376,13 +376,13 @@ static int ksz_init_global_dscp_map(struct ksz_device *dev)
 			if (tt < 0)
 				return tt;
 
-			ipv = ieee8021q_tt_to_tc(tt, dev->info->num_tx_queues);
+			ipm = ieee8021q_tt_to_tc(tt, dev->info->num_tx_queues);
 		}
 
-		if (ipv < 0)
-			return ipv;
+		if (ipm < 0)
+			return ipm;
 
-		ret = ksz_set_global_dscp_entry(dev, dscp, ipv);
+		ret = ksz_set_global_dscp_entry(dev, dscp, ipm);
 	}
 
 	return 0;
@@ -402,7 +402,7 @@ int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (prio >= dev->info->num_ipvs)
+	if (prio >= dev->info->num_ipms)
 		return -ERANGE;
 
 	return ksz_set_global_dscp_entry(dev, dscp, prio);
@@ -421,21 +421,21 @@ int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 int ksz_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
-	int ipv;
+	int ipm;
 
 	if (ksz_port_get_dscp_prio(ds, port, dscp) != prio)
 		return 0;
 
 	if (is_ksz8(dev)) {
-		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
+		ipm = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
 					 dev->info->num_tx_queues);
-		if (ipv < 0)
-			return ipv;
+		if (ipm < 0)
+			return ipm;
 	} else {
-		ipv = IEEE8021Q_TT_BE;
+		ipm = IEEE8021Q_TT_BE;
 	}
 
-	return ksz_set_global_dscp_entry(dev, dscp, ipv);
+	return ksz_set_global_dscp_entry(dev, dscp, ipm);
 }
 
 /**
@@ -772,20 +772,20 @@ int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int *nsel)
 int ksz_dcb_init_port(struct ksz_device *dev, int port)
 {
 	const u8 *sel;
-	int ret, ipv;
+	int ret, ipm;
 	int sel_len;
 
 	if (is_ksz8(dev)) {
-		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
+		ipm = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
 					 dev->info->num_tx_queues);
-		if (ipv < 0)
-			return ipv;
+		if (ipm < 0)
+			return ipm;
 	} else {
-		ipv = IEEE8021Q_TT_BE;
+		ipm = IEEE8021Q_TT_BE;
 	}
 
 	/* Set the default priority for the port to Best Effort */
-	ret = ksz_port_set_default_prio(dev->ds, port, ipv);
+	ret = ksz_port_set_default_prio(dev->ds, port, ipm);
 	if (ret)
 		return ret;
 
-- 
2.39.2


