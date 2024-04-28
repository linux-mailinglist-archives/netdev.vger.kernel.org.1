Return-Path: <netdev+bounces-91983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558398B4B43
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7935F1C20FCF
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5C2AF01;
	Sun, 28 Apr 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ajWycqwU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164F21101
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714300407; cv=none; b=dNx0aedDbM9GrUMAuQ0K35IGZWDU3VUI363aQKbMfJLxsJw7S7l3+hyDcUffXyV2BoAa5TbjMhaC4Ge1xO2um+a004ck/96RJEFaLpao9zm/Q+a9gw48uvsGLP0betCjy2yUNRwVrp5rChvfgofDfvliQAYSk+McQ4D73EiqfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714300407; c=relaxed/simple;
	bh=NZw7kRl7XCRLruXIqG70pRehj0F2PFd5GGVIGlCRbBI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Bal2QmQdfmqF/dCCDYBLEZwJVPHk7zHmEojcc0+tuETXK6M5U+A9L6b5ZRHQljO8AM5Zk02dhSYh7h5sQfLiNqJ5eF8kC+NExL0qrrrjZpqLGtIwnu1oNkpLFVx98xSqPhXX4EJEU6t2lMI2DuP3BlUACUyzUGN/iySk4wh9INQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ajWycqwU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kNJ7nWzVlQEkLdteBM2EE+GHhSKQb4WFO6svtQyPy34=; b=ajWycqwUqzOOFX5Z40mdTh+rMY
	YvwTYi587mHIFIAJjKxKsLKIkA2ZxQOikcbwYxsP9soVANoD5JbCJfFArq6YfeRw7tdZheKeJlPHT
	76W66YFRWMWjKaapiRJ/bVLCXJ4byWLTKdYObSTjygQy8twxsoe0EhIqQnxHLiuk2tI0IaK2/OUaF
	RUBij3RAVlRT1cR/ncFZP2sLycT8iw1eNWaKJqQnUcsf57rjjaRl8smIdel8+rFF8fNcdev/XA814
	lvzIUUH+VtMkwFpmFluXju/SW/Kh7eROfd+VI1QOBqgk0XWS/OicXb7w9nmbheTMypGEfRzJhtA2E
	3sCNDmvQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35438 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s11qI-00024i-0j;
	Sun, 28 Apr 2024 11:33:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s11qJ-00AHi0-Kk; Sun, 28 Apr 2024 11:33:11 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	 Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: realtek: provide own phylink MAC
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s11qJ-00AHi0-Kk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Apr 2024 11:33:11 +0100

Convert realtek to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c. We need to provide a stub for
the mandatory mac_config() method for rtl8366rb.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This patch has been built-tested with -Wunused-const-variable

 drivers/net/dsa/realtek/realtek.h   |  2 ++
 drivers/net/dsa/realtek/rtl8365mb.c | 32 +++++++++++++++++++----------
 drivers/net/dsa/realtek/rtl8366rb.c | 29 +++++++++++++++++++-------
 drivers/net/dsa/realtek/rtl83xx.c   |  1 +
 4 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e0b1aa01337b..a1b2e0b529d5 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -17,6 +17,7 @@
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
 
+struct phylink_mac_ops;
 struct realtek_ops;
 struct dentry;
 struct inode;
@@ -117,6 +118,7 @@ struct realtek_ops {
 struct realtek_variant {
 	const struct dsa_switch_ops *ds_ops;
 	const struct realtek_ops *ops;
+	const struct phylink_mac_ops *phylink_mac_ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
 	u8 cmd_write;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 12665a8a3412..b9674f68b756 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1048,11 +1048,13 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		phy_interface_set_rgmii(config->supported_interfaces);
 }
 
-static void rtl8365mb_phylink_mac_config(struct dsa_switch *ds, int port,
+static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 					 unsigned int mode,
 					 const struct phylink_link_state *state)
 {
-	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct realtek_priv *priv = dp->ds->priv;
+	u8 port = dp->index;
 	int ret;
 
 	if (mode != MLO_AN_PHY && mode != MLO_AN_FIXED) {
@@ -1076,13 +1078,15 @@ static void rtl8365mb_phylink_mac_config(struct dsa_switch *ds, int port,
 	 */
 }
 
-static void rtl8365mb_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 					    unsigned int mode,
 					    phy_interface_t interface)
 {
-	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct realtek_priv *priv = dp->ds->priv;
 	struct rtl8365mb_port *p;
 	struct rtl8365mb *mb;
+	u8 port = dp->index;
 	int ret;
 
 	mb = priv->chip_data;
@@ -1101,16 +1105,18 @@ static void rtl8365mb_phylink_mac_link_down(struct dsa_switch *ds, int port,
 	}
 }
 
-static void rtl8365mb_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
+					  struct phy_device *phydev,
 					  unsigned int mode,
 					  phy_interface_t interface,
-					  struct phy_device *phydev, int speed,
-					  int duplex, bool tx_pause,
+					  int speed, int duplex, bool tx_pause,
 					  bool rx_pause)
 {
-	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct realtek_priv *priv = dp->ds->priv;
 	struct rtl8365mb_port *p;
 	struct rtl8365mb *mb;
+	u8 port = dp->index;
 	int ret;
 
 	mb = priv->chip_data;
@@ -2106,15 +2112,18 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
+static const struct phylink_mac_ops rtl8365mb_phylink_mac_ops = {
+	.mac_config = rtl8365mb_phylink_mac_config,
+	.mac_link_down = rtl8365mb_phylink_mac_link_down,
+	.mac_link_up = rtl8365mb_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
-	.phylink_mac_config = rtl8365mb_phylink_mac_config,
-	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
-	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
@@ -2136,6 +2145,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 const struct realtek_variant rtl8365mb_variant = {
 	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
+	.phylink_mac_ops = &rtl8365mb_phylink_mac_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
 	.cmd_write = 0xb8,
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index e10ae94cf771..6fb271c2e62d 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1077,11 +1077,19 @@ static void rtl8366rb_phylink_get_caps(struct dsa_switch *ds, int port,
 }
 
 static void
-rtl8366rb_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
-		      phy_interface_t interface, struct phy_device *phydev,
+rtl8366rb_mac_config(struct phylink_config *config, unsigned int mode,
+		     const struct phylink_link_state *state)
+{
+}
+
+static void
+rtl8366rb_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
+		      unsigned int mode, phy_interface_t interface,
 		      int speed, int duplex, bool tx_pause, bool rx_pause)
 {
-	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct realtek_priv *priv = dp->ds->priv;
+	int port = dp->index;
 	unsigned int val;
 	int ret;
 
@@ -1147,10 +1155,12 @@ rtl8366rb_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
 }
 
 static void
-rtl8366rb_mac_link_down(struct dsa_switch *ds, int port, unsigned int mode,
+rtl8366rb_mac_link_down(struct phylink_config *config, unsigned int mode,
 			phy_interface_t interface)
 {
-	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct realtek_priv *priv = dp->ds->priv;
+	int port = dp->index;
 	int ret;
 
 	if (port != priv->cpu_port)
@@ -1849,12 +1859,16 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
+static const struct phylink_mac_ops rtl8366rb_phylink_mac_ops = {
+	.mac_config = rtl8366rb_mac_config,
+	.mac_link_down = rtl8366rb_mac_link_down,
+	.mac_link_up = rtl8366rb_mac_link_up,
+};
+
 static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
 	.phylink_get_caps = rtl8366rb_phylink_get_caps,
-	.phylink_mac_link_up = rtl8366rb_mac_link_up,
-	.phylink_mac_link_down = rtl8366rb_mac_link_down,
 	.get_strings = rtl8366_get_strings,
 	.get_ethtool_stats = rtl8366_get_ethtool_stats,
 	.get_sset_count = rtl8366_get_sset_count,
@@ -1892,6 +1906,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 const struct realtek_variant rtl8366rb_variant = {
 	.ds_ops = &rtl8366rb_switch_ops,
 	.ops = &rtl8366rb_ops,
+	.phylink_mac_ops = &rtl8366rb_phylink_mac_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xa9,
 	.cmd_write = 0xa8,
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index d2e876805393..5f46deb8a21f 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -236,6 +236,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
 	ds->priv = priv;
 	ds->dev = priv->dev;
 	ds->ops = priv->variant->ds_ops;
+	ds->phylink_mac_ops = priv->variant->phylink_mac_ops;
 	ds->num_ports = priv->num_ports;
 
 	ret = dsa_register_switch(ds);
-- 
2.30.2


