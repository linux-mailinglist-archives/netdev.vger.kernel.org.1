Return-Path: <netdev+bounces-229672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB19BDF97E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F053E3110
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0F335BBB;
	Wed, 15 Oct 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j3X4MWu7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72462335BB5
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544665; cv=none; b=Xw0THxF8fzCVAISJKyiZPNE1IuLo6mKsBskHg4oSU8lJgRd48HPO/CZQ4WodgpSvIeQcgg10u3bA2LhRhIwYYRUHX9VjEXV1TPFPOKwI/jJ14nPEo3e8sx4hw4zvuYWg1wIVUCVh1pMWDM7Px0/jq5jqh5blvbzjRyW+DXAZ93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544665; c=relaxed/simple;
	bh=cUwc+kZi5tkDbJ2jcEsnXY0ytMEeyaivVeEFW2v+N9Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OHGB2Mrbrn5soyEglQHvIocozZvVfDeFUSgoV0Y1aU8Ipk2kKG780mJKy0h/eZ012JLto1WtSdSSwzDppPyRzGnQD9VQezQYx2+zQOoQdgg8ih6RIk/lt85LzBSYjPlrlsnYisP0InRW7rob/eJSdMonA5HfOsE821KfwqkUXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j3X4MWu7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gb/wZg//idgP0aJjQsDqyZi+MpDmhmg/7WfGvBfMh50=; b=j3X4MWu7b4hQ1UJETH24Z2neRa
	ojTTrMUmEq6CCu2PgjNIr1pMf343ftlBy4+AIBohE11sMULn2XFTc3WS932Y1v0WFEsnP/ZNPKvNP
	j/556CK+p/UAX+i9D0FSngfkZHQd8xAMa57/Vbbeefrd4TgO8ltCRzeMQPtOMQwn04yxvzLJNBIly
	Mf8UdYiLQK4r2oE0acJTHzLZ/FtkNCK7Z3spBcL4HL35paQdkAcSW2bDEtoUkGxBAMRcTCHbnZFIW
	70zdlXhye57aWXXUoZNiu2+eN5rGu6XBOjP9AJE13GNGmcNWj9DlLqa9jDfYU7d1UkzjFEDMcBcuJ
	cEUfLjcg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34166 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v945U-000000005AH-2gB7;
	Wed, 15 Oct 2025 17:10:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v945T-0000000AmeV-2BvU;
	Wed, 15 Oct 2025 17:10:51 +0100
In-Reply-To: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/5] net: stmmac: avoid PHY speed change when
 configuring MTU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Oct 2025 17:10:51 +0100

There is no need to do the speed-down, speed-up dance when changing
the MTU as there is little power saving that can be gained from such
a brief interval between these, and the autonegotiation they cause
takes much longer.

Move the calls to phylink_speed_up() and phylink_speed_down() into
stmmac_open() and stmmac_release() respectively, reducing the work
done in the __-variants of these functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3728afa701c6..500cfd19e6b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3963,8 +3963,6 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
-	/* We may have called phylink_speed_down before */
-	phylink_speed_up(priv->phylink);
 
 	ret = stmmac_request_irq(dev);
 	if (ret)
@@ -4015,6 +4013,9 @@ static int stmmac_open(struct net_device *dev)
 
 	kfree(dma_conf);
 
+	/* We may have called phylink_speed_down before */
+	phylink_speed_up(priv->phylink);
+
 	return ret;
 
 err_disconnect_phy:
@@ -4032,13 +4033,6 @@ static void __stmmac_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u32 chan;
 
-	/* If the PHY or MAC has WoL enabled, then the PHY will not be
-	 * suspended when phylink_stop() is called below. Set the PHY
-	 * to its slowest speed to save power.
-	 */
-	if (device_may_wakeup(priv->device))
-		phylink_speed_down(priv->phylink, false);
-
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
@@ -4078,6 +4072,13 @@ static int stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	/* If the PHY or MAC has WoL enabled, then the PHY will not be
+	 * suspended when phylink_stop() is called below. Set the PHY
+	 * to its slowest speed to save power.
+	 */
+	if (device_may_wakeup(priv->device))
+		phylink_speed_down(priv->phylink, false);
+
 	__stmmac_release(dev);
 
 	phylink_disconnect_phy(priv->phylink);
-- 
2.47.3


