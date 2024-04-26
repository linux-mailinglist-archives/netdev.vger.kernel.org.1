Return-Path: <netdev+bounces-91760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F78B3C6C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7F1C21377
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A314F109;
	Fri, 26 Apr 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FZtWSRBk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D21474A0
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147692; cv=none; b=MjqDd4nN6DA4o9Urwza3ECnURE4uw/jwV3HgPvvELBQcWhgQ6ZKdPozVrDiK17gjmBs4SNg9H4hRzf36sFAeAl5NTgwPWUnTT9Sxued8tIp4kS9wEU/z8sXwwln5BGDritaTAAYEqaa8i0ifNQT647MQgiCRVHfvtHhzcrowjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147692; c=relaxed/simple;
	bh=FK+m7Vej259h+cYeueduKeyyJIGkINL6tWgbJBpLdt0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pwlyyqfBOEDXdD1WsNBFlLi6Fd2xuzJNb0OfxFsScuYU0bBTMvnUm0lZVYLw7QPjJYVCxExNeupUwDM90v58ce9UsamEpn6Fes2dDoiUrF71wsYIgqLQUg8T89QWKLc5IkUeNb17XLEeSzTHl8ZXin3+6qNG6MvGYLAgxF6GPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FZtWSRBk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ryPcrT+v62G71ztSDyXJvDRUHQ8by4qA4GCRZ3OZV6Q=; b=FZtWSRBkiIr2U0H/fLm86q4DEw
	zC9KR39aogzj4bkB4KS0TLMZk8E0pfby3qW8+wRvvYJPvBEEwiiNfo/DbiL5SFUUp+J9xvUFMOKnT
	WpxawyLUzGRCe5Ub9wdwfnLJvdGoUMTsHjNZzO/jU2fna3UblgH/2QT8fKdfxFnn3jf5G8o/LYUa1
	GbdFiqxV5lhn2WFg7MYy+7ZizYwIQk3R/JvmowZqgBXcJU60qneOdoDt+sVv7sSann7Uie42erGsR
	qPlg7mjE0VgKkAeIWhrvTTXH1Z47Th805pWMWg/wpLm/hN0Lczf9AXefq2poiE8TFZ1ZjYzpVQ8oj
	Y0tQj4hA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49290 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0O7G-0000U0-0d;
	Fri, 26 Apr 2024 17:08:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0O7H-009gpq-IF; Fri, 26 Apr 2024 17:08:03 +0100
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
Subject: [PATCH net-next 2/4] net: dsa: ksz_common: provide own phylink MAC
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
Message-Id: <E1s0O7H-009gpq-IF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:08:03 +0100

Convert ksz_common to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 42 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f4469ee24239..4a754801bca4 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2523,14 +2523,15 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 	return 0;
 }
 
-static void ksz_mac_link_down(struct dsa_switch *ds, int port,
-			      unsigned int mode, phy_interface_t interface)
+static void ksz_phylink_mac_link_down(struct phylink_config *config,
+				      unsigned int mode,
+				      phy_interface_t interface)
 {
-	struct ksz_device *dev = ds->priv;
-	struct ksz_port *p = &dev->ports[port];
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
 
 	/* Read all MIB counters when the link is going down. */
-	p->read = true;
+	dev->ports[dp->index].read = true;
 	/* timer started */
 	if (dev->mib_read_interval)
 		schedule_delayed_work(&dev->mib_read, 0);
@@ -3065,11 +3066,13 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 	return interface;
 }
 
-static void ksz_phylink_mac_config(struct dsa_switch *ds, int port,
+static void ksz_phylink_mac_config(struct phylink_config *config,
 				   unsigned int mode,
 				   const struct phylink_link_state *state)
 {
-	struct ksz_device *dev = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	int port = dp->index;
 
 	if (ksz_is_ksz88x3(dev)) {
 		dev->ports[port].manual_flow = !(state->pause & MLO_PAUSE_AN);
@@ -3206,16 +3209,19 @@ static void ksz9477_phylink_mac_link_up(struct ksz_device *dev, int port,
 	ksz_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
 }
 
-static void ksz_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void ksz_phylink_mac_link_up(struct phylink_config *config,
+				    struct phy_device *phydev,
 				    unsigned int mode,
 				    phy_interface_t interface,
-				    struct phy_device *phydev, int speed,
-				    int duplex, bool tx_pause, bool rx_pause)
+				    int speed, int duplex, bool tx_pause,
+				    bool rx_pause)
 {
-	struct ksz_device *dev = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
 
-	dev->dev_ops->phylink_mac_link_up(dev, port, mode, interface, phydev,
-					  speed, duplex, tx_pause, rx_pause);
+	dev->dev_ops->phylink_mac_link_up(dev, dp->index, mode, interface,
+					  phydev, speed, duplex, tx_pause,
+					  rx_pause);
 }
 
 static int ksz_switch_detect(struct ksz_device *dev)
@@ -3869,6 +3875,12 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static const struct phylink_mac_ops ksz_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
@@ -3878,9 +3890,6 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
-	.phylink_mac_config	= ksz_phylink_mac_config,
-	.phylink_mac_link_up	= ksz_phylink_mac_link_up,
-	.phylink_mac_link_down	= ksz_mac_link_down,
 	.port_setup		= ksz_port_setup,
 	.set_ageing_time	= ksz_set_ageing_time,
 	.get_strings		= ksz_get_strings,
@@ -3936,6 +3945,7 @@ struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
 	ds->dev = base;
 	ds->num_ports = DSA_MAX_PORTS;
 	ds->ops = &ksz_switch_ops;
+	ds->phylink_mac_ops = &ksz_phylink_mac_ops;
 
 	swdev = devm_kzalloc(base, sizeof(*swdev), GFP_KERNEL);
 	if (!swdev)
-- 
2.30.2


