Return-Path: <netdev+bounces-88265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70CE8A6826
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755B62828E0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10390127E0E;
	Tue, 16 Apr 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IffiNoNF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931D1272C9
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262762; cv=none; b=oHdqA2RBjhwuAKgJfxlPF72l2+iRwxjdB9JXnKfaD3pFou0O8wRKTXQzUAlpGZfRACRbYYMFOXU0feSdoNG/4K5Hd93RYsUw67qbnJGj1bC6WaRfnPblPr46l8cBzYQjwOPhCv+nceRsp0qItZlCRCahYP9dkAFz4f71HRD1AcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262762; c=relaxed/simple;
	bh=DoJdHtJtX5iuddoHdDLzlVK99u2bxmHMwNF2xSbaAo0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=ewugyayA2iAIw8f8IMgPxF21nHBNzhdW0fUMN+pY26qTuBbIWmCwB1y10GBGT54qRb5XjshwnqS8lEPAknsDRgbPmC3vNfRd1bqrBLRZUv2oqErhM2tjlvKMkulc9dJU9rel7+HYVz8qfChCRu6bilbzMb6w+w+RyKmvaERh3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IffiNoNF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i+72edgonlZun1QAAkQPvp12rBPMsjOD8ekDbuIaFQk=; b=IffiNoNFNDt8QEGuP2bnpTgSsG
	Vvx6kydHtL802xUIfrO8uoc/2LWXRgoy2SsUnxlZkpsJuTUywobLyKctt2MQiZS8ZdWwFp50LGdvm
	uqZ/1iPgq2K96r7KW/q4pEfgflHUYzkK5KDbz6K2KELuWsGHU4MTVDAR1Dy8t7XKzUVy+m1pYHnLB
	D+zNP8hoHAxDN8ojY/CxYSuVn/1Hbm/J4yo+hHqOEbN6EZ9elbAn3cxCHNDIF/u1THJHdt664gTZ2
	Vki61S9pT219IFuvM8EtLvextnknZyEPbICAWYe1JvF+Q/w6ZFLYJxqm+KR1A1rgWJnLaQYJO7zXZ
	DurIjVeg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rwfuD-0008Q9-0F;
	Tue, 16 Apr 2024 11:19:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rwfuE-007537-1u; Tue, 16 Apr 2024 11:19:14 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: lan9303: provide own phylink MAC
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
Message-Id: <E1rwfuE-007537-1u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Apr 2024 11:19:14 +0100

Convert lan9303 to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c. We need to provide stubs for
the mac_link_down() and mac_config() methods which are mandatory.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/lan9303-core.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index fcb20eac332a..666b4d766c00 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1293,14 +1293,29 @@ static void lan9303_phylink_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static void lan9303_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void lan9303_phylink_mac_config(struct phylink_config *config,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
+{
+}
+
+static void lan9303_phylink_mac_link_down(struct phylink_config *config,
+					  unsigned int mode,
+					  phy_interface_t interface)
+{
+}
+
+static void lan9303_phylink_mac_link_up(struct phylink_config *config,
+					struct phy_device *phydev,
 					unsigned int mode,
 					phy_interface_t interface,
-					struct phy_device *phydev, int speed,
-					int duplex, bool tx_pause,
+					int speed, int duplex, bool tx_pause,
 					bool rx_pause)
 {
-	struct lan9303 *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct lan9303 *chip = dp->ds->priv;
+	struct dsa_switch *ds = dp->ds;
+	int port = dp->index;
 	u32 ctl;
 	u32 reg;
 
@@ -1330,6 +1345,12 @@ static void lan9303_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	regmap_write(chip->regmap, flow_ctl_reg[port], reg);
 }
 
+static const struct phylink_mac_ops lan9303_phylink_mac_ops = {
+	.mac_config	= lan9303_phylink_mac_config,
+	.mac_link_down	= lan9303_phylink_mac_link_down,
+	.mac_link_up	= lan9303_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops lan9303_switch_ops = {
 	.get_tag_protocol	= lan9303_get_tag_protocol,
 	.setup			= lan9303_setup,
@@ -1337,7 +1358,6 @@ static const struct dsa_switch_ops lan9303_switch_ops = {
 	.phy_read		= lan9303_phy_read,
 	.phy_write		= lan9303_phy_write,
 	.phylink_get_caps	= lan9303_phylink_get_caps,
-	.phylink_mac_link_up	= lan9303_phylink_mac_link_up,
 	.get_ethtool_stats	= lan9303_get_ethtool_stats,
 	.get_sset_count		= lan9303_get_sset_count,
 	.port_enable		= lan9303_port_enable,
@@ -1365,6 +1385,7 @@ static int lan9303_register_switch(struct lan9303 *chip)
 	chip->ds->num_ports = LAN9303_NUM_PORTS;
 	chip->ds->priv = chip;
 	chip->ds->ops = &lan9303_switch_ops;
+	chip->ds->phylink_mac_ops = &lan9303_phylink_mac_ops;
 	base = chip->phy_addr_base;
 	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1 + base, base);
 
-- 
2.30.2


