Return-Path: <netdev+bounces-30371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58B78707D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7B41C20E2A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AFD30E;
	Thu, 24 Aug 2023 13:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2D125B1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:38:44 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2EC7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nphjihgOb/6ZWNEn5bdh2uvaeqrnXDrlYgYpyu/X48Y=; b=JMgjf29fkIhzJJLdTsZLUfNMYs
	wYPUEc5sixRKsbxFyhL3mciHDk3Zmam2+UW8rv4DiiDoUIMQAmpkJb1UvjbBiRD6T1He5krmwvP5I
	GNyLNbi79ZNpmnW+/5ECjiuowbIJHfGGVpLjGDapJy7ncLzKtJmrbaTioyZKPlZ4UPdakXHkzLT6y
	YY05eAr15YoN0QVYwhB59JVSap3JX6bltVEU89smoqa5ntNtSMS+Zhdl78wiDwtYMpqbmqqXe7g8R
	77a/OQ2EQcqGbdXNPiiN2r8qNI30DSyt/77H773lxsE4s/ia9NkwzRFLtF9AhtgQY/NiyUE/BE7ut
	1kWgUL+A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48212 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qZAXi-0004ES-1G;
	Thu, 24 Aug 2023 14:38:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qZAXi-005pUV-Nq; Thu, 24 Aug 2023 14:38:34 +0100
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
Subject: [PATCH net-next 09/10] net: stmmac: move
 priv->phylink_config.mac_managed_pm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qZAXi-005pUV-Nq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 24 Aug 2023 14:38:34 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move priv->phylink_config.mac_managed_pm to be along side the other
phylink initialisations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5cf8304564c6..7cfc2918c913 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1207,6 +1207,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 
 	priv->phylink_config.dev = &priv->dev->dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
+	priv->phylink_config.mac_managed_pm = true;
 
 	mdio_bus_data = priv->plat->mdio_bus_data;
 	if (mdio_bus_data)
@@ -1231,7 +1232,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	if (priv->plat->tx_queues_to_use > 1)
 		priv->phylink_config.mac_capabilities &=
 			~(MAC_10HD | MAC_100HD | MAC_1000HD);
-	priv->phylink_config.mac_managed_pm = true;
 
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
-- 
2.30.2


