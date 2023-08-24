Return-Path: <netdev+bounces-30367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40C787070
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A864C2815E5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2ED1119C;
	Thu, 24 Aug 2023 13:38:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC28288E8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:38:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064BFD
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fL2vmU0lJyEilSH6H6zvhSQ3kxhQLqqMcqHG138QaUM=; b=v048nZiNmFsgapvw8SNn1zpX0p
	YWAbOIBRp6gG7xg3O96UaGgdLNwRwAMVIogELoM8iwKRPERMwmAGf5OgN/4AEzmp2O63wLVjWhGbx
	mKTMJwpHrZ8IbXJ8Lt+TCUx8mqRyUWGecy7iZG2uriugF/BqNUCle4RkvoR7dKqwHx6Y27DJibR12
	tDs/nLXX3J3Tixcw1x5plCjJFJL9VXzZU+LeXZ7ddqYj5NnDUjXitdoHHAWpeKqa9u3BT9V0rosNG
	/2RgAy7Si4n8BU8aNwXo1bArrI4yn3GfiaKjbdGUXCw1/g+l+uIrV+Tmpt+cDbMBaLjZCKD9P4Ud2
	IeISrkmw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54822 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qZAXN-0004D7-2k;
	Thu, 24 Aug 2023 14:38:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qZAXO-005pU7-61; Thu, 24 Aug 2023 14:38:14 +0100
In-Reply-To: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 05/10] net: stmmac: use phylink_limit_mac_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qZAXO-005pU7-61@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 24 Aug 2023 14:38:14 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use phylink_limit_mac_speed() to limit the MAC capabilities rather
than coding this for each speed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++-----------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe733a9f5fe4..30a085f2b8fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1200,10 +1200,10 @@ static int stmmac_init_phy(struct net_device *dev)
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
-	int max_speed = priv->plat->max_speed;
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
 	struct phylink *phylink;
+	int max_speed;
 
 	priv->phylink_config.dev = &priv->dev->dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
@@ -1222,29 +1222,18 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 				    priv->phylink_config.supported_interfaces);
 
 	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100;
-
-	if (!max_speed || max_speed >= 1000)
-		priv->phylink_config.mac_capabilities |= MAC_1000;
+		MAC_10 | MAC_100 | MAC_1000;
 
 	if (priv->plat->has_gmac4) {
-		if (!max_speed || max_speed >= 2500)
-			priv->phylink_config.mac_capabilities |= MAC_2500FD;
+		priv->phylink_config.mac_capabilities |= MAC_2500FD;
 	} else if (priv->plat->has_xgmac) {
-		if (!max_speed || max_speed >= 2500)
-			priv->phylink_config.mac_capabilities |= MAC_2500FD;
-		if (!max_speed || max_speed >= 5000)
-			priv->phylink_config.mac_capabilities |= MAC_5000FD;
-		if (!max_speed || max_speed >= 10000)
-			priv->phylink_config.mac_capabilities |= MAC_10000FD;
-		if (!max_speed || max_speed >= 25000)
-			priv->phylink_config.mac_capabilities |= MAC_25000FD;
-		if (!max_speed || max_speed >= 40000)
-			priv->phylink_config.mac_capabilities |= MAC_40000FD;
-		if (!max_speed || max_speed >= 50000)
-			priv->phylink_config.mac_capabilities |= MAC_50000FD;
-		if (!max_speed || max_speed >= 100000)
-			priv->phylink_config.mac_capabilities |= MAC_100000FD;
+		priv->phylink_config.mac_capabilities |= MAC_2500FD;
+		priv->phylink_config.mac_capabilities |= MAC_5000FD;
+		priv->phylink_config.mac_capabilities |= MAC_10000FD;
+		priv->phylink_config.mac_capabilities |= MAC_25000FD;
+		priv->phylink_config.mac_capabilities |= MAC_40000FD;
+		priv->phylink_config.mac_capabilities |= MAC_50000FD;
+		priv->phylink_config.mac_capabilities |= MAC_100000FD;
 	}
 
 	/* Half-Duplex can only work with single queue */
@@ -1253,6 +1242,10 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 			~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	priv->phylink_config.mac_managed_pm = true;
 
+	max_speed = priv->plat->max_speed;
+	if (max_speed)
+		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
+
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
-- 
2.30.2


