Return-Path: <netdev+bounces-161369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A9A20D80
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4953A7B21
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA519DF61;
	Tue, 28 Jan 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yV54mE8F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572F1D5AAD
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079268; cv=none; b=rqIAO7p8DtJ447yXOLsfqaEnKCu/pq4kA2Wnpv5TTJ/9PLAQQeNQ9vJ18VT0BLukeqLi3H01hjSjqvt6FvfGWDzaoOewC5q/zuw7U+1Go3yZv3w8kswGTMxV8s8bKf9IFBj8LZpQ8dy1ZyZhbgGs41QezYowds5exMf3VCwIEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079268; c=relaxed/simple;
	bh=1A5HUh3zzw8eMuKg+8ZlEU6PRqhFFqySc4yfyJUEE+A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=p2dJOBQKxQyWMuMMwRPcnfj5SWnB4yf9JoaOPvM+hha+Y9lN/QVbW5PazKjw/K3i74a5HeTO5moBqUbqb2cqw5oklkZmXZ3t5VMwmq1rCJfiZHywuSJ0gyHNaKTShZufBufJDqkZmn8osIO0H4tZAkqjaYtpaqg43ftW4sHPAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yV54mE8F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FzqEwFhraiQ3i+QhTMew1i129n2QgfNW9SfHL20WQVw=; b=yV54mE8Fn+8MuE63sRKrarSyHV
	ZUkrCUnVb/wnlo+9HqcZ3EjLtmaJMc4NL6jvLCsyxoD0K9JdJRwknwl1Ywt66JgMQcK4MN6cTRQXf
	q4j921CVN1Z06sKeelsSMy1s7JVAJAvhUuOFRWao61fw0hnRrRk9qPOALu4CvbM3/79+V8H97qHnp
	nGt0GqQdoF3/gGiLbXOHfjo/+KMdVm3260YqU8A4nY4iMEUJygU9TUXtvgK1Rl4UCP2H5XaeWmJjM
	LQqGJk3dsZHVXLhTi71DT3FiuR6fObhWYMIDVcT5pnxkcB83XLLZv4yxZPCICZ21UTttv7OvHZd+P
	1CdXXQNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45792 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoS-0007UU-01;
	Tue, 28 Jan 2025 15:47:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcno8-0037Gi-Mp; Tue, 28 Jan 2025 15:47:20 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 07/22] net: stmmac: remove unnecessary
 priv->eee_enabled tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcno8-0037Gi-Mp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:20 +0000

Phylink will not call the mac_disable_tx_lpi() and mac_enable_tx_lpi()
methods randomly - the first method to be called will be the enable
method, and then after, the disable method will be called once between
subsequent enable calls. Thus there is a guaranteed ordering.

Therefore, we know the previous state of priv->eee_enabled, and can
remove it from both methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++----------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f63946eb6747..485b2bfaf811 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1046,18 +1046,17 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 
 	mutex_lock(&priv->lock);
 
-	/* Check if it needs to be deactivated */
-	if (priv->eee_enabled) {
-		netdev_dbg(priv->dev, "disable EEE\n");
-		priv->eee_sw_timer_en = false;
-		del_timer_sync(&priv->eee_ctrl_timer);
-		stmmac_reset_eee_mode(priv, priv->hw);
-		stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
-		if (priv->hw->xpcs)
-			xpcs_config_eee(priv->hw->xpcs,
-					priv->plat->mult_fact_100ns, false);
-	}
 	priv->eee_enabled = false;
+
+	netdev_dbg(priv->dev, "disable EEE\n");
+	priv->eee_sw_timer_en = false;
+	del_timer_sync(&priv->eee_ctrl_timer);
+	stmmac_reset_eee_mode(priv, priv->hw);
+	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+	if (priv->hw->xpcs)
+		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
+				false);
+
 	mutex_unlock(&priv->lock);
 }
 
@@ -1071,13 +1070,13 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	mutex_lock(&priv->lock);
 
-	if (!priv->eee_enabled) {
-		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
-				     STMMAC_DEFAULT_TWT_LS);
-		if (priv->hw->xpcs)
-			xpcs_config_eee(priv->hw->xpcs,
-					priv->plat->mult_fact_100ns, true);
-	}
+	priv->eee_enabled = true;
+
+	stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
+			     STMMAC_DEFAULT_TWT_LS);
+	if (priv->hw->xpcs)
+		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
+				true);
 
 	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
 		/* Use hardware LPI mode */
@@ -1092,8 +1091,6 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 		stmmac_restart_sw_lpi_timer(priv);
 	}
 
-	priv->eee_enabled = true;
-
 	mutex_unlock(&priv->lock);
 	netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
 
-- 
2.30.2


