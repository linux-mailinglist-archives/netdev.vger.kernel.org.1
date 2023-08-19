Return-Path: <netdev+bounces-29083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F581781938
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8597E281B6F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF994A0A;
	Sat, 19 Aug 2023 11:12:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3ED20F4
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:12:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E536D21D70
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=97CXNfAX7MUPbh3dnXriKEc7KyKMVm4X4PA+yCJbOBY=; b=N356wQyydFzIYgWB464vfA5ukl
	vHEzMxQVV9AYk7ONtAUGJNcxSMqbVHkwHZewTRZamrUskTUDqOUGRkrZK3NiXub63OJN6nUdxk60q
	1kIRVGQ/leKjUzZzMkZ8JQTCkQ45Uj9F3oj0hFXdugnA8zIdE6oh6nS+Qxf4UJ9bORDhHr88FRns7
	mFb2u5XFLUIjr34BvPo9T+RLaPFoJjhNL9MHhZRZ9AfHxwbGGG+/rCwoW5JrGYq5hZ5rHR2NIEdl/
	LYt0r7kaVCxpSi8kX8cIAKJJJ+RI0+nf+fi1KM5A4bfeR5/CXNuJMgtMrtYD1MqxVyBStFMlHI2hO
	fcafqF4A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56122 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qXJrF-0006kg-2U;
	Sat, 19 Aug 2023 12:11:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qXJrG-005Oey-10; Sat, 19 Aug 2023 12:11:06 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Alvin __ipraga" <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: realtek: add phylink_get_caps
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 19 Aug 2023 12:11:06 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The user ports use RSGMII, but we don't have that, and DT doesn't
specify a phy interface mode, so phylib defaults to GMII. These support
1G, 100M and 10M with flow control. It is unknown whether asymetric
pause is supported at all speeds.

The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
and support speeds specific to each, with full duplex only supported
in some modes. Flow control may be supported again by hardware pin
strapping, and theoretically is readable through a register but no
information is given in the datasheet for that.

So, we do a best efforts - and be lenient.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
First posted in
https://lore.kernel.org/r/ZNd4AJlLLmszeOxg@shell.armlinux.org.uk
and fixed up Vladimir's feedback slightly differently from proposed.

 drivers/net/dsa/realtek/rtl8366rb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 25f88022b9e4..a38c893ec384 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1049,6 +1049,32 @@ static enum dsa_tag_protocol rtl8366_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_RTL4_A;
 }
 
+static void rtl8366rb_phylink_get_caps(struct dsa_switch *ds, int port,
+				       struct phylink_config *config)
+{
+	unsigned long *interfaces = config->supported_interfaces;
+	struct realtek_priv *priv = ds->priv;
+
+	if (port == priv->cpu_port) {
+		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+		/* REVMII only supports 100M FD */
+		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
+		/* RGMII only supports 1G FD */
+		phy_interface_set_rgmii(interfaces);
+
+		config->mac_capabilities = MAC_1000 | MAC_100 |
+					   MAC_SYM_PAUSE;
+	} else {
+		/* RSGMII port, but we don't have that, and we don't
+		 * specify in DT, so phylib uses the default of GMII
+		 */
+		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+		config->mac_capabilities = MAC_1000 | MAC_100 | MAC_10 |
+					   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+	}
+}
+
 static void
 rtl8366rb_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
 		      phy_interface_t interface, struct phy_device *phydev,
@@ -1796,6 +1822,7 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
+	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
 	.get_strings = rtl8366_get_strings,
@@ -1821,6 +1848,7 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
 	.setup = rtl8366rb_setup,
 	.phy_read = rtl8366rb_dsa_phy_read,
 	.phy_write = rtl8366rb_dsa_phy_write,
+	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
 	.get_strings = rtl8366_get_strings,
-- 
2.30.2


