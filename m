Return-Path: <netdev+bounces-218569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1627FB3D4A2
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94136188B649
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184A2737F9;
	Sun, 31 Aug 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V5OfPEM0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BE25BF13
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661685; cv=none; b=GLs9JBqWcXCAh8ES8Iktgq9WpIRvzOMbULxhaj+xkP3keZf+5kXVsulC0Q0VyFLmQxMZUHmotKSNbXBl+2eBCUV2y7sROlSQ0Eqvcu0FR+8yPtf1QkpJDv09V1zg7IIEaCcHMEqunCMEW/VoDMNesdIE4dlRL0dG5kSYL1nLqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661685; c=relaxed/simple;
	bh=0K65MdPzf/WBTHHW1vUa9jYLsWixgTzZh0AnViqQfKc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mL/WxoNM7bdLtWoeyu8ieZger8Yf+wVXOjGzoI4MZ2lgzMobRL1YwLn/j8tn3fxs6scymWvH3CfVLnIg3M+cD7ZBQ6INjFObXM6TlfilGtQdkjL3HNB1BWER7w68DvJ7wSR5T+w5AeqtfdqXZywT6zPNl4wVDQxZPtzaTtxoOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V5OfPEM0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CH6dudRd3jD8OpBtH2qFstgQ+iLD3REQCgVo5fn1VGM=; b=V5OfPEM0rTFl2mBSnyzaqUHT9b
	ltAw6Mt8DNIkOMi3BQLD1AKM//94kfLfW+pSjwsIkkR9Ns4LqPQjvuDeH3ohOqjj1zIA+ZZBEXg2v
	17W3OZUrHt1Rx+CCpN37ljWcJwOt2k6Z+1y2tJ2ozDg1cshgzYJCF0WEcBQ2g7x0Msdp+XXTABd+E
	0SyMgESr+So9eQKuMCzWyxDnrcJ0lTF5ykzEuLzNU40zZ8PFCi9tWfudm/qK5j+mXgS6N1oGQb5J2
	gVJmPa0bbRfFHgtCrwwjfkQbNdv7ZCI3cJQ4DQxSR419YA4rMXB2UXZscNsentfkBiVgZZhwE1ESe
	XZxks4fg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47278 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uslwt-0000000058D-1FTT;
	Sun, 31 Aug 2025 18:34:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uslws-00000001SP5-1R2R;
	Sun, 31 Aug 2025 18:34:38 +0100
In-Reply-To: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 2/3] net: phylink: provide phylink_get_inband_type()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uslws-00000001SP5-1R2R@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 31 Aug 2025 18:34:38 +0100

Provide a function to get the type of the inband signalling used for
a PHY interface type. This will be used in the subsequent patch to
address problems with 10G optical modules.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 79 ++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7f867b361dd..8283416ccf5d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1016,6 +1016,42 @@ static void phylink_pcs_an_restart(struct phylink *pl)
 		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
+enum inband_type {
+	INBAND_NONE,
+	INBAND_CISCO_SGMII,
+	INBAND_BASEX,
+};
+
+static enum inband_type phylink_get_inband_type(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		/* These protocols are designed for use with a PHY which
+		 * communicates its negotiation result back to the MAC via
+		 * inband communication. Note: there exist PHYs that run
+		 * with SGMII but do not send the inband data.
+		 */
+		return INBAND_CISCO_SGMII;
+
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		/* 1000base-X is designed for use media-side for Fibre
+		 * connections, and thus the Autoneg bit needs to be
+		 * taken into account. We also do this for 2500base-X
+		 * as well, but drivers may not support this, so may
+		 * need to override this.
+		 */
+		return INBAND_BASEX;
+
+	default:
+		return INBAND_NONE;
+	}
+}
+
 /**
  * phylink_pcs_neg_mode() - helper to determine PCS inband mode
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -1043,46 +1079,19 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 	unsigned int pcs_ib_caps = 0;
 	unsigned int phy_ib_caps = 0;
 	unsigned int neg_mode, mode;
-	enum {
-		INBAND_CISCO_SGMII,
-		INBAND_BASEX,
-	} type;
-
-	mode = pl->req_link_an_mode;
+	enum inband_type type;
 
-	pl->phy_ib_mode = 0;
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_USXGMII:
-	case PHY_INTERFACE_MODE_10G_QXGMII:
-		/* These protocols are designed for use with a PHY which
-		 * communicates its negotiation result back to the MAC via
-		 * inband communication. Note: there exist PHYs that run
-		 * with SGMII but do not send the inband data.
-		 */
-		type = INBAND_CISCO_SGMII;
-		break;
-
-	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_2500BASEX:
-		/* 1000base-X is designed for use media-side for Fibre
-		 * connections, and thus the Autoneg bit needs to be
-		 * taken into account. We also do this for 2500base-X
-		 * as well, but drivers may not support this, so may
-		 * need to override this.
-		 */
-		type = INBAND_BASEX;
-		break;
-
-	default:
+	type = phylink_get_inband_type(interface);
+	if (type == INBAND_NONE) {
 		pl->pcs_neg_mode = PHYLINK_PCS_NEG_NONE;
-		pl->act_link_an_mode = mode;
+		pl->act_link_an_mode = pl->req_link_an_mode;
 		return;
 	}
 
+	mode = pl->req_link_an_mode;
+
+	pl->phy_ib_mode = 0;
+
 	if (pcs)
 		pcs_ib_caps = phylink_pcs_inband_caps(pcs, interface);
 
-- 
2.47.2


