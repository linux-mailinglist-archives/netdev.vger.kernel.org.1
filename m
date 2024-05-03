Return-Path: <netdev+bounces-93270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E198BAD5E
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706D91F22678
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487CF15443C;
	Fri,  3 May 2024 13:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAF15442A
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742055; cv=none; b=V4fi41kzz//IP4ShPDWUXugE708sSszheLV9/+1cDJP/ePE/B3FwYl9TKnFcIwgWh1WgAs04XUECaB2yw5EGdPt4ZsZFTAnm8XVFzHIa+3UZ3tWDUXxtyJx0VbY6YgjmY9gNi6ymjj0nxkTvgy+xo31h3ijikq0yLggt55s/vwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742055; c=relaxed/simple;
	bh=f8U15C2FskeHh1Xyvad5ZfX9RonSLWOi12ui6sXzhRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkSirYjEqaee9/6slvJ6oP3hVbMuF8KVsqz2seqWJCkqtotE8NAb8IwTGuDHx0yUqLNr0xZfwUGNLcLpmvPU5A3KXmPeytYkp5A4GyHHNxXEYBSGN0bZWSkbDFEeBiUUOd9XaBKFGZRVlg264qYJNjF6JYm7cPx5orEKs1wRTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjf-0006EP-GH; Fri, 03 May 2024 15:13:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiKP-VA; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GIA-2W;
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
Subject: [PATCH net-next v7 11/12] net: dsa: microchip: add support DSCP priority mapping
Date: Fri,  3 May 2024 15:13:50 +0200
Message-Id: <20240503131351.1969097-12-o.rempel@pengutronix.de>
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

Microchip KSZ and LAN variants do not have per port DSCP priority
configuration. Instead there is a global DSCP mapping table.

This patch provides write access to this global DSCP map. In case entry
is "deleted", we map corresponding DSCP entry to a best effort prio,
which is expected to be the default priority for all untagged traffic.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c |  3 ++
 drivers/net/dsa/microchip/ksz_dcb.c    | 60 +++++++++++++++++++-------
 drivers/net/dsa/microchip/ksz_dcb.h    |  2 +
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 695748d33c02a..95622dec2b28a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2360,6 +2360,7 @@ static int ksz_setup(struct dsa_switch *ds)
 	ksz_init_mib_timer(dev);
 
 	ds->configure_vlan_while_not_filtering = false;
+	ds->dscp_prio_mapping_is_global = true;
 
 	if (dev->dev_ops->setup) {
 		ret = dev->dev_ops->setup(ds);
@@ -3990,6 +3991,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
 	.port_get_apptrust	= ksz_port_get_apptrust,
 	.port_set_apptrust	= ksz_port_set_apptrust,
 };
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 80fb322de8f74..5e520c02afd72 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -310,6 +310,19 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 	return (data >> shift) & mask;
 }
 
+static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipv)
+{
+	int reg, per_reg, shift;
+	u8 mask;
+
+	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
+
+	shift = (dscp % per_reg) * (8 / per_reg);
+
+	return ksz_rmw8(dev, reg + (dscp / per_reg), mask << shift,
+			ipv << shift);
+}
+
 /**
  * ksz_init_global_dscp_map - Initializes the global DSCP-to-priority mapping
  * @dev: Pointer to the KSZ switch device structure
@@ -321,9 +334,7 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
  */
 static int ksz_init_global_dscp_map(struct ksz_device *dev)
 {
-	int reg, per_reg, ret, dscp;
-	u8 data = 0;
-	u8 mask;
+	int ret, dscp;
 
 	/* On KSZ9xxx variants, DSCP remapping is disabled by default.
 	 * Enable to have, predictable and reproducible behavior across
@@ -337,10 +348,8 @@ static int ksz_init_global_dscp_map(struct ksz_device *dev)
 			return ret;
 	}
 
-	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
-
 	for (dscp = 0; dscp < DSCP_MAX; dscp++) {
-		int ipv, shift, tt;
+		int ipv, tt;
 
 		/* Map DSCP to Traffic Type, which is corresponding to the
 		 * Internal Priority Value (IPV) in the switch.
@@ -362,19 +371,40 @@ static int ksz_init_global_dscp_map(struct ksz_device *dev)
 		if (ipv < 0)
 			return ipv;
 
-		shift = (dscp % per_reg) * (8 / per_reg);
-		data |= (ipv & mask) << shift;
+		ret = ksz_set_global_dscp_entry(dev, dscp, ipv);
+	}
 
-		if (dscp % per_reg == per_reg - 1) {
-			ret = ksz_write8(dev, reg + (dscp / per_reg), data);
-			if (ret)
-				return ret;
+	return 0;
+}
 
-			data = 0;
-		}
+int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (prio >= dev->info->num_ipvs)
+		return -ERANGE;
+
+	return ksz_set_global_dscp_entry(dev, dscp, prio);
+}
+
+int ksz_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct ksz_device *dev = ds->priv;
+	int ipv;
+
+	if (ksz_port_get_dscp_prio(ds, port, dscp) != prio)
+		return 0;
+
+	if (is_ksz8(dev)) {
+		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
+					 dev->info->num_tx_queues);
+		if (ipv < 0)
+			return ipv;
+	} else {
+		ipv = IEEE8021Q_TT_BE;
 	}
 
-	return 0;
+	return ksz_set_global_dscp_entry(dev, dscp, ipv);
 }
 
 /**
diff --git a/drivers/net/dsa/microchip/ksz_dcb.h b/drivers/net/dsa/microchip/ksz_dcb.h
index 254c0e7bdafca..e2065223ba90c 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.h
+++ b/drivers/net/dsa/microchip/ksz_dcb.h
@@ -11,6 +11,8 @@
 int ksz_port_get_default_prio(struct dsa_switch *ds, int port);
 int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio);
 int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp);
+int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio);
+int ksz_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio);
 int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
 			  const unsigned char *sel,
 			  int nsel);
-- 
2.39.2


