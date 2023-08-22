Return-Path: <netdev+bounces-29763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6DA7849A1
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CDC280F9E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3A1DA59;
	Tue, 22 Aug 2023 18:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF031DA2C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:50:18 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149110B
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ctf+gHySOP5Wm8CJUoGTJUIHkbgxUwCF/1UiE1lOtX0=; b=RKgos06Ui7zkoTdCIwymGUh+10
	wqvmXcxJbxTBJM5nQJeuHXEELmtQcW/j3UVI+XtxFTIYln0lw9x5RUMc6j9kN/lKxuE9ZxHDANip2
	virNaxEsdIq9z32/0fISvqgT/O1zv5wt8KyGit5zOlMSB8lykUEldZXLDPW8cA/0WBO8cTVkpblJn
	3Bve0O4BeU8Lc89kaqC9fWfdZyfyiYz43/ql0RviOL73BpWsMh7IeaSm5EHh5fQShxYigXBx7Mkoc
	7PPOan/z8vDjUarqv3dT804ohVfCOi6aUuLcHWm1CC9/miXpNNzzjg8CKVrnHMFs5x2Aa5ThIayEu
	T6NzrC/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45032 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qYWS8-0001rK-1U;
	Tue, 22 Aug 2023 19:50:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qYWS8-005fXa-OQ; Tue, 22 Aug 2023 19:50:08 +0100
In-Reply-To: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
References: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/9] net: stmmac: convert plat->phylink_node to
 fwnode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qYWS8-005fXa-OQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Aug 2023 19:50:08 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All users of plat->phylink_node first convert it to a fwnode. Rather
than repeatedly convert to a fwnode, store it as a fwnode. To reflect
this change, call it plat->port_node instead - it is used for more
than just phylink.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c     | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 +-
 include/linux/stmmac.h                                | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7a9bbcf03ea5..a2dfb624e10c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1153,7 +1153,7 @@ static int stmmac_init_phy(struct net_device *dev)
 	if (!phylink_expects_phy(priv->phylink))
 		return 0;
 
-	fwnode = of_fwnode_handle(priv->plat->phylink_node);
+	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
 
@@ -1200,7 +1200,7 @@ static int stmmac_init_phy(struct net_device *dev)
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data = priv->plat->mdio_bus_data;
-	struct fwnode_handle *fwnode = of_fwnode_handle(priv->plat->phylink_node);
+	struct fwnode_handle *fwnode = priv->plat->port_node;
 	int max_speed = priv->plat->max_speed;
 	int mode = priv->plat->phy_interface;
 	struct phylink *phylink;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index dd9e2fec5328..fa9e7e7040b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -533,11 +533,11 @@ int stmmac_mdio_register(struct net_device *ndev)
 	int err = 0;
 	struct mii_bus *new_bus;
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct fwnode_handle *fwnode = of_fwnode_handle(priv->plat->phylink_node);
 	struct stmmac_mdio_bus_data *mdio_bus_data = priv->plat->mdio_bus_data;
 	struct device_node *mdio_node = priv->plat->mdio_node;
 	struct device *dev = ndev->dev.parent;
 	struct fwnode_handle *fixed_node;
+	struct fwnode_handle *fwnode;
 	int addr, found, max_addr;
 
 	if (!mdio_bus_data)
@@ -601,6 +601,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 		stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
 
 	/* If fixed-link is set, skip PHY scanning */
+	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..ff330423ee66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -428,7 +428,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->phy_node = of_parse_phandle(np, "phy-handle", 0);
 
 	/* PHYLINK automatically parses the phy-handle property */
-	plat->phylink_node = np;
+	plat->port_node = of_fwnode_handle(np);
 
 	/* Get max speed of operation from device tree */
 	of_property_read_u32(np, "max-speed", &plat->max_speed);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 784277d666eb..b2ccd827bb80 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -227,7 +227,7 @@ struct plat_stmmacenet_data {
 	phy_interface_t phy_interface;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
-	struct device_node *phylink_node;
+	struct fwnode_handle *port_node;
 	struct device_node *mdio_node;
 	struct stmmac_dma_cfg *dma_cfg;
 	struct stmmac_est *est;
-- 
2.30.2


