Return-Path: <netdev+bounces-151864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56059F1602
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA1C2841D6
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D11EF0BA;
	Fri, 13 Dec 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L/niVw4t"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C01F03E2;
	Fri, 13 Dec 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118525; cv=none; b=dIfd7TsLxndcr9ZQvC0nmRaa/8Ir5klsdqy8wlhG4TIHZPOtnZ6yAFQqfyO0Ul5bG45HnzD73QNQGTVgj12E8y9ygHqdcriUu7FGsvNn7Xn3YIPgqZ/vYqIpjrjyO9S6ntkrZgfiP+dIU/Bmv6HpybPV2FA6iWYz/1HRDPZqHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118525; c=relaxed/simple;
	bh=qm2FBUfP120JYJBGjVWf6BHggAiBDu2UJXq1cdQTu2M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XzPY+1yKx1fscYmiprnetQGmJTYc0fjCmBe2+Ivn24cgfo0k3tK3p0+fPs64/anOUtSiJQNWBllQl70JLuY2mrRUqJJVoagUIDteOuoL4/0jgS4WxuPAGl3TVYdynMRqyzSe6Fy6ylw5N561R/xuJu4Ewv8Tu5T5okIfuIhX3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L/niVw4t; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yydHl5BH5Sb6MLQ4m8pTbWEBjAsjzLNECa7MKHOHJLc=; b=L/niVw4tv8rIjtUYlrmUm/to63
	7TWOizwe65Scj1N18yS/1bNUTtMQU/c4fovuuQxm+QDWYWUgKpHzcOOzjqOccwnwRX0RpkPS/n7O+
	rHnQvWMJHc+ZiOVEVzF8VqQ6iBrJKR3pjzSvaVyDHiVifTBkhwyglwKX3dDkI0Wb5Xe6q5cfyVkg3
	A/0Io2liQyGXd4xgS2zw/fzPlhokjXGsBK79SRVmMyTIyxUWsIRDascvHL3C2oPrFmcT3jb3WM0vN
	GJLU0LWrkTkmET7jTC3iebx1OuGeQNeDoBAWKB5wT2IJTfTBYGqTrLo64zTHi+PkXykYMe5ClCKCG
	BZ6ne/oQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41426 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tMBRT-0007EF-09;
	Fri, 13 Dec 2024 19:35:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tMBRQ-006vat-7F; Fri, 13 Dec 2024 19:35:12 +0000
In-Reply-To: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>,
	 Andrew Lunn <andrew+netdev@lunn.ch>,
	 davem@davemloft.net,
	 Eric Dumazet <edumazet@google.com>,
	 Jakub Kicinski <kuba@kernel.org>,
	 Paolo Abeni <pabeni@redhat.com>,
	 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	 Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>,
	 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	 netdev@vger.kernel.org,
	 linux-stm32@st-md-mailman.stormreply.com,
	 linux-arm-kernel@lists.infradead.org,
	 linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net: stmmac: use PCS supported_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tMBRQ-006vat-7F@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Dec 2024 19:35:12 +0000

Use the PCS' supported_interfaces member to build the MAC level
supported_interfaces bitmap.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d45fd7a3acd5..0e45c4a48bb5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1206,6 +1206,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
+	struct phylink_pcs *pcs;
 	struct phylink *phylink;
 
 	priv->phylink_config.dev = &priv->dev->dev;
@@ -1227,8 +1228,14 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 
 	/* If we have an xpcs, it defines which PHY interfaces are supported. */
 	if (priv->hw->xpcs)
-		xpcs_get_interfaces(priv->hw->xpcs,
-				    priv->phylink_config.supported_interfaces);
+		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
+	else
+		pcs = priv->hw->phylink_pcs;
+
+	if (pcs)
+		phy_interface_or(priv->phylink_config.supported_interfaces,
+				 priv->phylink_config.supported_interfaces,
+				 pcs->supported_interfaces);
 
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
-- 
2.30.2


