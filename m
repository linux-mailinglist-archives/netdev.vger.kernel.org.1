Return-Path: <netdev+bounces-30372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33678707F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BDA1C20E7E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DC2891D;
	Thu, 24 Aug 2023 13:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F5288E8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:38:50 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF361FD
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J3e+4Vo84h0ny8OR5GBo+JRGtZ3c958TOz/VATLJd6Y=; b=lmgTDgz83a5mOXKNh+PJ985QvN
	KEjVZ3UQLkQ9nWZbTeOOx21/M/wHkLTVITHnMD+aL8qtKlBzwOvpfp/fjeBycqmRpzuNHfYzf7YRw
	iXccBVFYh0CcV/vO7xNy1DoWwSDHL8kd629FQdCZ9dIqAY0mRoQvkWfcUgAe8yi95pvur7jOC7TJO
	oWzrxRyaIlKvYaAvQlcv16+CUzxZbV6cQm7z3dwSg3dCDeXjWT8WHqFmPzUrk183FHvWbF9mp2jKD
	70x62aqTMGKGBgL2uBxSz2ciD2vyVIfxOwn0I8Fd7Po7LDYvU+i/iiA/63d35ZCL/BdG/d32G+dS6
	3cBvd7iA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60606 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qZAXn-0004Ej-1g;
	Thu, 24 Aug 2023 14:38:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qZAXn-005pUb-SP; Thu, 24 Aug 2023 14:38:39 +0100
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
Subject: [PATCH net-next 10/10] net: stmmac: convert half-duplex support to
 positive logic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qZAXn-005pUb-SP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 24 Aug 2023 14:38:39 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rather than detecting when half-duplex is not supported, and clearing
the MAC capabilities, reverse the if() condition and use it to set the
capabilities instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7cfc2918c913..33ca5c50bdcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1223,16 +1223,17 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 				    priv->phylink_config.supported_interfaces);
 
 	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000;
+						MAC_10FD | MAC_100FD |
+						MAC_1000FD;
+
+	/* Half-Duplex can only work with single queue */
+	if (priv->plat->tx_queues_to_use <= 1)
+		priv->phylink_config.mac_capabilities |= MAC_10HD | MAC_100HD |
+							 MAC_1000HD;
 
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
 
-	/* Half-Duplex can only work with single queue */
-	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
-
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
 		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-- 
2.30.2


