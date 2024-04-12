Return-Path: <netdev+bounces-87443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575688A322A
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486061C22FD6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F01509AB;
	Fri, 12 Apr 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UMrH5UJb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D1149C72
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934921; cv=none; b=M65cGWk0DrP6aB6fKzLpO56LwzslL67lU9sF4BvFwA7rJU76dnrPINOnoTU5TQFf3n81s5Fi29/F9wNCrOWAYmH27SdOb6SS3ijSkue/mECVIQEcElywDMjl54tQOPqAq1NmWvckzIwmqvBnIEqJbAizvGfMfCI6oWXL9n7LumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934921; c=relaxed/simple;
	bh=Ordgrzm0jr4wWTX4n3QGcT5xOoan8HBMWL4B7PF+juQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=tHws3C4O/+8ndKoPN0zNnBAoJRfV3fyOt4KaaWPmmqMFk12BDmNyPo9P0uVM+ZbB76hZVhihYJEJQTz6WU68fXnaox8Wtlrv01nk8NiVBM/qEze7h9uoAsF1tqKpg+D6PqlQcURHBPSN9ODUCWlyMi0QWyLNCLektz5rUvxmwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UMrH5UJb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kYzIyB/TOmufMv9vsv2N+sl8g4N8xwfM/tUDF6xFAyk=; b=UMrH5UJbPwiJ7H+bif3g7oNnnl
	6QrHx8abkqVT13O+IDxey79IemEFH6W7OiyhT0w6KRa1o+cX8nxMFSec9GfmLeu9Gc1AEAp/hFz+G
	3OrTiw2YLLDMkJwPa4OI0RWDnyEfFAtmhx3ODDrgfw7Ld2dgQ55YeiOvRBVU1WpwmEvUGqsht+RWG
	oHzkMSw3Ok3Cn0AcXn7SIG2dAUpERefFo4MQfmeLZmowBFTAWDJkWryENsVy68i2fak52qt9xiA6k
	mj93WWqA3vw20ZnnMpfv0EjyOoT0VCgAwfJfzlkoH0BpTdP7cO9jY/g8Ee9ACIL0xmClB41DkN0OY
	dCChonyw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42496 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIcN-0002bs-32;
	Fri, 12 Apr 2024 16:15:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIcO-006bQQ-Md; Fri, 12 Apr 2024 16:15:08 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: felix: provide own phylink MAC operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:08 +0100

Convert felix to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/ocelot/felix.c      | 54 +++++++++++++++++++----------
 drivers/net/dsa/ocelot/felix.h      |  1 +
 drivers/net/dsa/ocelot/ocelot_ext.c |  1 +
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 61e95487732d..3aa66bf9eafc 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1050,24 +1050,32 @@ static void felix_phylink_get_caps(struct dsa_switch *ds, int port,
 		  config->supported_interfaces);
 }
 
-static void felix_phylink_mac_config(struct dsa_switch *ds, int port,
+static void felix_phylink_mac_config(struct phylink_config *config,
 				     unsigned int mode,
 				     const struct phylink_link_state *state)
 {
-	struct ocelot *ocelot = ds->priv;
-	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
+	int port = dp->index;
+	struct felix *felix;
+
+	felix = ocelot_to_felix(ocelot);
 
 	if (felix->info->phylink_mac_config)
 		felix->info->phylink_mac_config(ocelot, port, mode, state);
 }
 
-static struct phylink_pcs *felix_phylink_mac_select_pcs(struct dsa_switch *ds,
-							int port,
-							phy_interface_t iface)
+static struct phylink_pcs *
+felix_phylink_mac_select_pcs(struct phylink_config *config,
+			     phy_interface_t iface)
 {
-	struct ocelot *ocelot = ds->priv;
-	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
 	struct phylink_pcs *pcs = NULL;
+	int port = dp->index;
+	struct felix *felix;
+
+	felix = ocelot_to_felix(ocelot);
 
 	if (felix->pcs && felix->pcs[port])
 		pcs = felix->pcs[port];
@@ -1075,11 +1083,13 @@ static struct phylink_pcs *felix_phylink_mac_select_pcs(struct dsa_switch *ds,
 	return pcs;
 }
 
-static void felix_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void felix_phylink_mac_link_down(struct phylink_config *config,
 					unsigned int link_an_mode,
 					phy_interface_t interface)
 {
-	struct ocelot *ocelot = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
+	int port = dp->index;
 	struct felix *felix;
 
 	felix = ocelot_to_felix(ocelot);
@@ -1088,15 +1098,19 @@ static void felix_phylink_mac_link_down(struct dsa_switch *ds, int port,
 				     felix->info->quirks);
 }
 
-static void felix_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void felix_phylink_mac_link_up(struct phylink_config *config,
+				      struct phy_device *phydev,
 				      unsigned int link_an_mode,
 				      phy_interface_t interface,
-				      struct phy_device *phydev,
 				      int speed, int duplex,
 				      bool tx_pause, bool rx_pause)
 {
-	struct ocelot *ocelot = ds->priv;
-	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
+	int port = dp->index;
+	struct felix *felix;
+
+	felix = ocelot_to_felix(ocelot);
 
 	ocelot_phylink_mac_link_up(ocelot, port, phydev, link_an_mode,
 				   interface, speed, duplex, tx_pause, rx_pause,
@@ -2083,6 +2097,14 @@ static void felix_get_mm_stats(struct dsa_switch *ds, int port,
 	ocelot_port_get_mm_stats(ocelot, port, stats);
 }
 
+const struct phylink_mac_ops felix_phylink_mac_ops = {
+	.mac_select_pcs		= felix_phylink_mac_select_pcs,
+	.mac_config		= felix_phylink_mac_config,
+	.mac_link_down		= felix_phylink_mac_link_down,
+	.mac_link_up		= felix_phylink_mac_link_up,
+};
+EXPORT_SYMBOL_GPL(felix_phylink_mac_ops);
+
 const struct dsa_switch_ops felix_switch_ops = {
 	.get_tag_protocol		= felix_get_tag_protocol,
 	.change_tag_protocol		= felix_change_tag_protocol,
@@ -2104,10 +2126,6 @@ const struct dsa_switch_ops felix_switch_ops = {
 	.get_sset_count			= felix_get_sset_count,
 	.get_ts_info			= felix_get_ts_info,
 	.phylink_get_caps		= felix_phylink_get_caps,
-	.phylink_mac_config		= felix_phylink_mac_config,
-	.phylink_mac_select_pcs		= felix_phylink_mac_select_pcs,
-	.phylink_mac_link_down		= felix_phylink_mac_link_down,
-	.phylink_mac_link_up		= felix_phylink_mac_link_up,
 	.port_enable			= felix_port_enable,
 	.port_fast_age			= felix_port_fast_age,
 	.port_fdb_dump			= felix_fdb_dump,
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index dbf5872fe367..4d3489aaa659 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -82,6 +82,7 @@ struct felix_tag_proto_ops {
 			      struct netlink_ext_ack *extack);
 };
 
+extern const struct phylink_mac_ops felix_phylink_mac_ops;
 extern const struct dsa_switch_ops felix_switch_ops;
 
 /* DSA glue / front-end for struct ocelot */
diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index 22187d831c4b..a8927dc7aca4 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -96,6 +96,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 	ds->num_tx_queues = felix->info->num_tx_queues;
 
 	ds->ops = &felix_switch_ops;
+	ds->phylink_mac_ops = &felix_phylink_mac_ops;
 	ds->priv = ocelot;
 	felix->ds = ds;
 	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
-- 
2.30.2


