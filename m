Return-Path: <netdev+bounces-29769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C885F7849B0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059431C20B7E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33F1DDEE;
	Tue, 22 Aug 2023 18:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247E1DA59
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:50:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731BCD6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KsLiqnb32ZcxjS1LxD1pBZYLglJtuaP+623PTyulk2g=; b=NqBejPsyt7HIdR/H0+xVVLINKR
	DyOmk65LmIM1I2NZv+htLfJLstz31Wgy9+cgjGntLfZ33UMRHD/u1WM/ns564rYTeU1/VQs2d+5T9
	v0d3+UvZwSkkG5rVpTEryuOO9dHTI94Jy/zEEoVsPoi9A6GNpNjKIBmS7L8TeFd8jNhfhz1m826Ro
	5W541McFfeTh4inZxoetQ84ZQE2URSGD1qwCVrN7jqyIR6M7g7HfBM7ytB7XBNDK4BOEFJYY5z3w6
	eMuqoOg8Dn+bNrnLqDKQaevDTu1/jsKzG5k5/Oy0cMj9dyoxbgKei/dJqdhUkwwzaK1+SKp0bg/HD
	1bjHUfmQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50516 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qYWSd-0001sz-1C;
	Tue, 22 Aug 2023 19:50:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qYWSd-005fYF-L9; Tue, 22 Aug 2023 19:50:39 +0100
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
Subject: [PATCH net-next 8/9] net: stmmac: move xgmac specific phylink caps to
 dwxgmac2 core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qYWSd-005fYF-L9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Aug 2023 19:50:39 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the xgmac specific phylink capabilities to the dwxgmac2 support
core.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 34e1b0c3f346..f352be269deb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,6 +47,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
+static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
+{
+	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
+						 MAC_10000FD | MAC_25000FD |
+						 MAC_40000FD | MAC_50000FD |
+						 MAC_100000FD;
+}
+
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1490,6 +1498,7 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
+	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1551,6 +1560,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
+	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0b02845e7e9d..5cf8304564c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1227,16 +1227,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
 
-	if (priv->plat->has_xgmac) {
-		priv->phylink_config.mac_capabilities |= MAC_2500FD;
-		priv->phylink_config.mac_capabilities |= MAC_5000FD;
-		priv->phylink_config.mac_capabilities |= MAC_10000FD;
-		priv->phylink_config.mac_capabilities |= MAC_25000FD;
-		priv->phylink_config.mac_capabilities |= MAC_40000FD;
-		priv->phylink_config.mac_capabilities |= MAC_50000FD;
-		priv->phylink_config.mac_capabilities |= MAC_100000FD;
-	}
-
 	/* Half-Duplex can only work with single queue */
 	if (priv->plat->tx_queues_to_use > 1)
 		priv->phylink_config.mac_capabilities &=
-- 
2.30.2


