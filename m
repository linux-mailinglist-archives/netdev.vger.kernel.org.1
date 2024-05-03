Return-Path: <netdev+bounces-93272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99A8BAD60
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00987281F2D
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848191553A6;
	Fri,  3 May 2024 13:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4551153815
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742055; cv=none; b=GhI/Rb4Pei13FXAswv3j6UfarVCb0qbxcRl834YU559VYP3FTk1domFzd2v08DoobzPpcq8mJEJCX5XIVHi+UpXrMBMKZBqN2qn84WsRg9aP1w7ch/wMHNCm+sCLWBA0ZgjrERQdkA+M0H2uzMZJ5w9Hq8fad7NCV5o+GmPpNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742055; c=relaxed/simple;
	bh=+1SYSE/2GzyaachD9ro2jNnf1LDG8GwGNwnOrURrGTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3ZAupRbnbWrn2JWdvklSLW6xC/TnQk4gf3LgnAW7S4ckuNcuMBcuCVIvxjIMZuI8vi6xvApO327s3ShqXcyIHvMTSd92urOAlmkMjjXL50OTE+CPQNbY3FntH03oWpVtqdDA0yrjNKo5biY9nnDxzW+nr24wucYW8UVcjbltCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjb-0006ED-6k; Fri, 03 May 2024 15:13:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiK8-Lz; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GGe-1w;
	Fri, 03 May 2024 15:13:53 +0200
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
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v7 02/12] net: dsa: microchip: add IPV information support
Date: Fri,  3 May 2024 15:13:41 +0200
Message-Id: <20240503131351.1969097-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503131351.1969097-1-o.rempel@pengutronix.de>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
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

Most of Microchip KSZ switches use Internal Priority Value associated
with every frame. For example, it is possible to map any VLAN PCP or
DSCP value to IPV and at the end, map IPV to a queue.

Since amount of IPVs is not equal to amount of queues, add this
information and make use of it in some functions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v3:
- rename max_ipvs to num_ipvs
- drop comparison of num_tx_queues and num_ipvs. It makes no much sense.
---
 drivers/net/dsa/microchip/ksz_common.c | 21 +++++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 302990fad38d3..034d4a5c63fbf 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1225,6 +1225,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1255,6 +1256,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
@@ -1295,6 +1297,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
@@ -1321,6 +1324,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
@@ -1347,6 +1351,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.cpu_ports = 0x4,	/* can be configured as cpu port */
 		.port_cnt = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 4,
 		.ops = &ksz8_dev_ops,
 		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
@@ -1372,6 +1377,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 4,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1407,6 +1413,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 6,		/* total physical port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1440,6 +1447,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1471,6 +1479,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 2,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.ops = &ksz9477_dev_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1498,6 +1507,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1527,6 +1537,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1561,6 +1572,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 7,		/* total physical port count */
 		.port_nirqs = 3,
 		.num_tx_queues = 4,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &ksz9477_dev_ops,
@@ -1593,6 +1605,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1621,6 +1634,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 6,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1649,6 +1663,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 8,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1681,6 +1696,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 5,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -1713,6 +1729,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 8,		/* total physical port count */
 		.port_nirqs = 6,
 		.num_tx_queues = 8,
+		.num_ipvs = 8,
 		.tc_cbs_supported = true,
 		.tc_ets_supported = true,
 		.ops = &lan937x_dev_ops,
@@ -3565,7 +3582,7 @@ static int ksz_tc_ets_add(struct ksz_device *dev, int port,
 	for (tc_prio = 0; tc_prio < ARRAY_SIZE(p->priomap); tc_prio++) {
 		int queue;
 
-		if (tc_prio > KSZ9477_MAX_TC_PRIO)
+		if (tc_prio >= dev->info->num_ipvs)
 			break;
 
 		queue = ksz_ets_band_to_queue(p, p->priomap[tc_prio]);
@@ -3607,7 +3624,7 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 	/* Revert the queue mapping for TC-priority to its default setting on
 	 * the chip.
 	 */
-	for (tc_prio = 0; tc_prio <= KSZ9477_MAX_TC_PRIO; tc_prio++) {
+	for (tc_prio = 0; tc_prio < dev->info->num_ipvs; tc_prio++) {
 		int queue;
 
 		queue = tc_prio >> s;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 9409b844af635..962e060f6f829 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -59,6 +59,7 @@ struct ksz_chip_data {
 	int port_cnt;
 	u8 port_nirqs;
 	u8 num_tx_queues;
+	u8 num_ipvs; /* number of Internal Priority Values */
 	bool tc_cbs_supported;
 	bool tc_ets_supported;
 	const struct ksz_dev_ops *ops;
@@ -721,7 +722,6 @@ static inline int is_lan937x(struct ksz_device *dev)
 #define KSZ9477_PORT_MRI_TC_MAP__4	0x0808
 
 #define KSZ9477_PORT_TC_MAP_S		4
-#define KSZ9477_MAX_TC_PRIO		7
 
 /* CBS related registers */
 #define REG_PORT_MTI_QUEUE_INDEX__4	0x0900
-- 
2.39.2


