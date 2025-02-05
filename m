Return-Path: <netdev+bounces-163016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527FBA28C10
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B21889E11
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C61547E9;
	Wed,  5 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="howcuFCq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBA13D897
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762855; cv=none; b=uZJOXpInOlhzRTmkw3NWlYnanpyIArFz20SihPkHKp8fGEQwnW0RmQi2gr2RRnyobE5J49N9tWVPhSPCta49ZmVOfTokDmi8vCbu444JPz7bgzBmB4jKJATCE7V+XB2jzEDd2E3SPuXgGdpsmkrdZf5+vwBpJt8e6G2yDh+iJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762855; c=relaxed/simple;
	bh=fZe97zZYZKbGgDmS9rP52Ygi3PKXSKdBkVUrCe/KMAU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tAegdfmCAMinXrT3MwVlmBoazzJ8anGNmuDHETO8rw1X/cC8I3bdXuK3qomYkyb19k1AL30myyfJVvY4oepdeUGeGxwrE/aPIKh2wU1bRPo/Ez6NC0F84j2PPQJl4GUk6oM+F7yDCkIsIVRPLpKD9jgQ15cuG/bfwA2MSMIh/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=howcuFCq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HapMKEDwluimEXPuPk+qD/5tw9RztvwWMl7+HqoD6wo=; b=howcuFCqo4EhehmK5FI0Xffgiw
	YTu67hn3iXNCeCrxvLDyS9q8igh6mdsaVlnoqKKnLniiplKLSAZ/qlzUyYVGdMKEUpjVxb9zonIav
	xCLnfWFKrHV+V5l3wbRG9uKHUaoTrQglXxHoPvUHkNHPPpRNzUVitT0xfTLKoPAx/Ckm5E0zUgtmS
	AOSQb07EsstsijXH1k5JkhRmxfiJts1wAtj+8Jf41G9OuS9GzjNNMVzJTUvAmeE+1PDzyQdDY154/
	hAgIjsUqAPFtMxKHdZGUkWjeGpMEa2nBXgrWVkDl5zTlzaw7+W1RRX+JL1iTg7OBW7lLVyhPflQGd
	09XNH7sg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51742 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffe1-0007Bv-22;
	Wed, 05 Feb 2025 13:40:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdi-003ZIH-5h; Wed, 05 Feb 2025 13:40:26 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 09/14] net: stmmac: remove unnecessary LPI disable
 when enabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffdi-003ZIH-5h@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:40:26 +0000

Remove the unnecessary LPI disable when enabling LPI - as noted in
previous commits, there will never be two consecutive calls to
stmmac_mac_enable_tx_lpi() without an intervening
stmmac_mac_disable_tx_lpi.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3cb5645673cb..921c4badd5fb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -390,11 +390,6 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 	return dirty;
 }
 
-static void stmmac_disable_hw_lpi_timer(struct stmmac_priv *priv)
-{
-	stmmac_set_eee_lpi_timer(priv, priv->hw, 0);
-}
-
 static void stmmac_enable_hw_lpi_timer(struct stmmac_priv *priv)
 {
 	stmmac_set_eee_lpi_timer(priv, priv->hw, priv->tx_lpi_timer);
@@ -1082,14 +1077,10 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
 		/* Use hardware LPI mode */
-		del_timer_sync(&priv->eee_ctrl_timer);
-		priv->tx_path_in_lpi_mode = false;
-		priv->eee_sw_timer_en = false;
 		stmmac_enable_hw_lpi_timer(priv);
 	} else {
 		/* Use software LPI mode */
 		priv->eee_sw_timer_en = true;
-		stmmac_disable_hw_lpi_timer(priv);
 		stmmac_restart_sw_lpi_timer(priv);
 	}
 
-- 
2.30.2


