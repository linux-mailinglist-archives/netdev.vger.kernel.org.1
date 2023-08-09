Return-Path: <netdev+bounces-25925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B57762E0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F06281011
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2EC19BBD;
	Wed,  9 Aug 2023 14:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AE18C1B
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:46:11 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F45C210D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/DS11pmQdEIWrJUmv4rgWPnLHLXJpkGPZKiIwN1AgjY=; b=uhL7KWzNY83mrkwNyplqoER21i
	VasurUZUsKXeu9zFRwiBimcKw2lY7oUtqbLG2Ie6t1JE2w0CywJSRofr24sCb6VgVPTcCFYngTsA5
	9BL6Jm3zXsqB2Lmwh1o4k07geQk83fGaaBfTOtijihRSrR65Tb2euOu3x6RMojnwjOlvlzVula5LQ
	+A/lktrhwtDSiLYGVszPV7ZL8pCQ7ESIaSaDeqFThpuJPVnABsTJiy2c1iFih1hmT+ViIpJE1yRll
	tSUUGFlfXMTs+raT878JwQlmFvfii6ato0aA0B+1S3I1XegFbsxhJQaInhpoWRKxNbaN6groFI30c
	CJ4Q6rkA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41226 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qTkRn-0002f3-1F;
	Wed, 09 Aug 2023 15:46:03 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qTkRn-003NBG-FH; Wed, 09 Aug 2023 15:46:03 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
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
Message-Id: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 09 Aug 2023 15:46:03 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
This is a fast ethernet switch, with internal PHYs for ports 0 through
4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
MII, REVMII, REVRMII and SNI without an internal PHY.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Sergei,

Would it be possible for you to check that this patch works with your
setup please?

Thanks!

 drivers/net/dsa/mv88e6060.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index fdda62d6eb16..0e776be5e941 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -247,11 +247,57 @@ mv88e6060_phy_write(struct dsa_switch *ds, int port, int regnum, u16 val)
 	return reg_write(priv, addr, regnum, val);
 }
 
+static void mv88e6060_phylink_get_caps(struct dsa_switch *ds, int port,
+				       struct phylink_config *config)
+{
+	unsigned long *interfaces = config->supported_interfaces;
+	struct mv88e6060_priv *priv = ds->priv;
+	int addr = REG_PORT(port);
+	int ret;
+
+	ret = reg_read(priv, addr, PORT_STATUS);
+	if (ret < 0) {
+		dev_err(ds->dev,
+			"port %d: unable to read status register: %pe\n",
+			port, ERR_PTR(ret));
+		return;
+	}
+
+	if (!(ret & PORT_STATUS_PORTMODE)) {
+		/* Port configured in SNI mode (acts as a 10Mbps PHY) */
+		config->mac_capabilities = MAC_10 | MAC_SYM_PAUSE;
+		/* I don't think SNI is SMII - SMII has a sync signal, and
+		 * SNI doesn't.
+		 */
+		__set_bit(PHY_INTERFACE_MODE_SMII, interfaces);
+		return;
+	}
+
+	config->mac_capabilities = MAC_100 | MAC_10 | MAC_SYM_PAUSE;
+
+	if (port >= 4) {
+		/* Ports 4 and 5 can support MII, REVMII and REVRMII modes */
+		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_REVRMII, interfaces);
+	}
+	if (port <= 4) {
+		/* Ports 0 to 3 have internal PHYs, and port 4 can optionally
+		 * use an internal PHY.
+		 */
+		/* Internal PHY */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL, interfaces);
+		/* Default phylib interface mode */
+		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+	}
+}
+
 static const struct dsa_switch_ops mv88e6060_switch_ops = {
 	.get_tag_protocol = mv88e6060_get_tag_protocol,
 	.setup		= mv88e6060_setup,
 	.phy_read	= mv88e6060_phy_read,
 	.phy_write	= mv88e6060_phy_write,
+	.phylink_get_caps = mv88e6060_phylink_get_caps,
 };
 
 static int mv88e6060_probe(struct mdio_device *mdiodev)
-- 
2.30.2


