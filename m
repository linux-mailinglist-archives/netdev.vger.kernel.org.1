Return-Path: <netdev+bounces-137854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0579AA180
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E89B238F7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9719DFA7;
	Tue, 22 Oct 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QYg7Txiy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BB19CCF3
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598064; cv=none; b=DzpgmVbUeD5sRoqn1/nj9QjL/XkSeBCJvZ/zAzZRjNWRzXJm1z2HlaAgwZMiSebKIOokeunj83PG/pgo2Cs+HwhikGuOlpKFkX/aeegzSDTYzQiNyRaxeP5cKg3cBINZrrNvGaQ3VI3rW1AEkXvNfRJrjR4V5Mxyix5+x4zy+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598064; c=relaxed/simple;
	bh=7W3VWC4Gr/aMVvSULF6dAOEXumBmxj5wMiTJWgHjx3c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uAdM2yMQGDcKhPbZTYLjIVP0nPz2nObqzjZM3JFzrz/qkNtyJy4KMQSU3u9a2pafVZVcn9D8pPrBbtjNhpoOlln9KQlsHNzp+BJNK/pXY4d5KQD3KYhICM95Ua8yIOFZKA7p7txY/M3eVKVchmfzGECDLLadiCZngCVBQRk/DVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QYg7Txiy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o8UzyQfoAfPycTLgeOTRSpcOriGseKUzK400ZjNe5/U=; b=QYg7Txiyeauvx6w6qD2Wqwu+gp
	ZNWP1MxVnYsHk9TDwVI9qa6x2V56uF+wq1uqJjWvKbBrukqIyU+EAm8pgu2dApa3C0wyiWWiAVluD
	pYo/t4fXtaw614+LVSdYk6asQ/IL3mwaP9fd4gvhziyYdMm/SgDCTZSCFESQmac7pPlEslz7D1YX6
	8qJtZXC9EXEJW5uHB4WWComYjzN28l0WE56atismQngk8WSXvbxPO+yLsCGdsjoLfnV1e+wdSS55u
	Klk1PDjvKIeBM4EpG+/OdCcZ7z1R00q9fPzZikS+Vh5+Drs4XnYfoh7CQuUyIEkxBd1wOF0sjq8U7
	tTUDo/Mg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40870 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t3DSr-0004oc-2C;
	Tue, 22 Oct 2024 12:54:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t3DSr-000Vxg-Qx; Tue, 22 Oct 2024 12:54:17 +0100
In-Reply-To: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] net: phylink: simplify how SFP PHYs are attached
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t3DSr-000Vxg-Qx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Oct 2024 12:54:17 +0100

There are a few issues with how SFP PHYs are attached:

a) The phylink_sfp_connect_phy() and phylink_sfp_config_phy() code
   validates the configuration three times:

1. To discover the support/advertising masks that the PHY/PCS/MAC
   can support in order to select an interface.
2. To validate the selected interface.
3. When the PHY is brought up after being attached, another validation
   is done.

   This is needlessly complex.

b) The configuration is set prior to the PHY being attached, which
   means we don't have the PHY available in phylink_major_config()
   for phylink_pcs_neg_mode() to make decisions upon.

We have already added an extra step to validate the selected interface,
so we can now move the attachment and bringup of the PHY earlier,
inside phylink_sfp_config_phy(). This results in the validation at
step 2 above becoming entirely unnecessary, so remove that too.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 43 +++++++++++++--------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4049d85cb477..183d6fc6d416 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3231,10 +3231,8 @@ static void phylink_sfp_set_config(struct phylink *pl, u8 mode,
 static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
 				  struct phy_device *phy)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(support1);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
 	struct phylink_link_state config;
-	phy_interface_t iface;
 	int ret;
 
 	linkmode_copy(support, phy->supported);
@@ -3255,20 +3253,21 @@ static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
 		return ret;
 	}
 
-	iface = phylink_sfp_select_interface(pl, config.advertising);
-	if (iface == PHY_INTERFACE_MODE_NA)
+	config.interface = phylink_sfp_select_interface(pl, config.advertising);
+	if (config.interface == PHY_INTERFACE_MODE_NA)
 		return -EINVAL;
 
-	config.interface = iface;
-	linkmode_copy(support1, support);
-	ret = phylink_validate(pl, support1, &config);
-	if (ret) {
-		phylink_err(pl,
-			    "validation of %s/%s with support %*pb failed: %pe\n",
-			    phylink_an_mode_str(mode),
-			    phy_modes(config.interface),
-			    __ETHTOOL_LINK_MODE_MASK_NBITS, support,
-			    ERR_PTR(ret));
+	/* Attach the PHY so that the PHY is present when we do the major
+	 * configuration step.
+	 */
+	ret = phylink_attach_phy(pl, phy, config.interface);
+	if (ret < 0)
+		return ret;
+
+	/* This will validate the configuration for us. */
+	ret = phylink_bringup_phy(pl, phy, config.interface);
+	if (ret < 0) {
+		phy_detach(phy);
 		return ret;
 	}
 
@@ -3426,7 +3425,6 @@ static bool phylink_phy_no_inband(struct phy_device *phy)
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phylink *pl = upstream;
-	phy_interface_t interface;
 	u8 mode;
 	int ret;
 
@@ -3449,20 +3447,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 			  pl->config->supported_interfaces);
 
 	/* Do the initial configuration */
-	ret = phylink_sfp_config_phy(pl, mode, phy);
-	if (ret < 0)
-		return ret;
-
-	interface = pl->link_config.interface;
-	ret = phylink_attach_phy(pl, phy, interface);
-	if (ret < 0)
-		return ret;
-
-	ret = phylink_bringup_phy(pl, phy, interface);
-	if (ret)
-		phy_detach(phy);
-
-	return ret;
+	return phylink_sfp_config_phy(pl, mode, phy);
 }
 
 static void phylink_sfp_disconnect_phy(void *upstream,
-- 
2.30.2


