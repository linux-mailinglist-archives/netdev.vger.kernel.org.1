Return-Path: <netdev+bounces-39050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141217BD8DD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DF11C20949
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2F63A7;
	Mon,  9 Oct 2023 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TRpwqayF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9571863C
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:39:51 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8299
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y3s/FIPfy9ha3pi4l4DqdhSktniQNQ+h1CyMx8WRa1U=; b=TRpwqayFpQz/EVeR1B4tr+VFeX
	GL0plgBxjLr2RDEKjWCU2aUOnoKk3arzgf8QC6p8fDATDtNreqpR6JRuJ08NHRbhpSAFhUTmDrNQW
	hvH06e3g/t9vFA4oHHsrJFDPiw/QcgA0FC1pYFDyn7wCe0d2VkG+uM7ErMWQWTX5e6PILr0Tnq4BJ
	zyDxg+napZigpfh/Fou0byipR1jJ7hHKu6Z0ushEyohP4C1YvXdT3rIjN8m8iZKUhIKV4Bd6Sdk4Y
	ahwD5s8hY0rwtjty+Le2JQ0Ol7xWD92Bk0Aa2qinxj9AbA2i5+NlkNxl5hIlUBt7ctoaQq6vDssot
	5tTNHPqQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54114 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qpnfr-0008M4-38;
	Mon, 09 Oct 2023 11:39:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qpnft-009Ncg-3o; Mon, 09 Oct 2023 11:39:45 +0100
In-Reply-To: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 1/3] net: dsa: vsc73xx: add phylink capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qpnft-009Ncg-3o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Oct 2023 11:39:45 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add phylink capabilities for vsc73xx. Although this switch driver does
populates the .adjust_link method, dsa_slave_phy_setup() will still be
used to create phylink instances for the LAN ports, although phylink
won't be used for shared links.

There are two different classes of switch - 5+1 and 8 port. The 5+1
port switches uses port indicies 0-4 for the user interfaces and 6 for
the CPU port. The 8 port is confusing - some comments in the driver
imply that port index 7 is used, but the driver actually still uses 6,
so that is what we go with. Also, there appear to be no DTs in the
kernel tree that are using the 8 port variety.

It also looks like port 5 is always skipped.

The switch supports 10M, 100M and 1G speeds. It is not clear whether
all these speeds are supported on the CPU interface. It also looks like
symmetric pause is supported, whether asymmetric pause is as well is
unclear. However, it looks like the pause configuration is entirely
static, and doesn't depend on negotiation results.

So, let's do the best effort we can based on the information found in
the driver when creating vsc73xx_phylink_get_caps().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4f09e7438f3b..35a846d7e13f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1037,6 +1037,31 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 	return 9600 - ETH_HLEN - ETH_FCS_LEN;
 }
 
+static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
+				     struct phylink_config *config)
+{
+	unsigned long *interfaces = config->supported_interfaces;
+
+	if (port == 5)
+		return;
+
+	if (port == CPU_PORT) {
+		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
+	}
+
+	if (port <= 4) {
+		/* Internal PHYs */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL, interfaces);
+		/* phylib default */
+		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+	}
+
+	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
@@ -1050,6 +1075,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.30.2


