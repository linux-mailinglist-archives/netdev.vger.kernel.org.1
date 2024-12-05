Return-Path: <netdev+bounces-149310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C089E5195
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A18A18803E4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E081D63CE;
	Thu,  5 Dec 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sAjRqda2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83D1D63C6
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391753; cv=none; b=UlOPYTn5/o0OWrPOyAAriaszUxPdlaqTt167pOh+YB8XqAnsSEKRNpqL4/urlfraIT2YctmgXdbMV0lDGfbgB2c6JiPkEj2V/xDPa26Y8dUqRWMeaNVN1QkHHN4X/1C7FJ05bkYNjw5dYxldSSW4jaPwW6h457xd1t4OPkSRFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391753; c=relaxed/simple;
	bh=pIzdI20dvJKGL2SESL4H2+F0XmvQiYc+5ukxILvmp4A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pVeGbXsCvhXwVhXKalamnd4BYgs/D+y/TYxvYPaG47GMh2VDAOhzBQG8o5QeX1nL0nI+2G0/qP0q5MRahCHqhIfF0u7RM+VuV3GupCOC4y+E/3j9A6k4oz+WaRe98ZDpM4wgZyIP20GeFTqLSeijgTYustzWa7D6Mw5eFsd+Bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sAjRqda2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A3y6MwUAGsUHiozWMnJnTOPGfmVxoyuHA6Uc8vPNLyU=; b=sAjRqda2Pzz4zayqttQHebInbQ
	pltGcFA3wdx2kUu+lxknjca8uFBS2Q5PryXnPgxPxg2ipEMYdyu8RrRY/7giZE6k8MxrK0DeUGZyG
	0/Zpj0AAmYwvkMcU5pLCzBiT1/xwH+7US45Gue74feSNXgsPuo8xVKuMTsx+6HUoS3wwWSO2boxsh
	zvRpyWVTM2DrHJrWnQkzFKKflmn9Mo00k3goQ7glOAmssnP3UWmwXmERVHKxEF1h2l/MBEaovR6+k
	Fn2L11+MSSaldWvYRzYBIYBdpMkGvfApsQm1jORDL1cyQBgaHL26EdmwZVHCKeKmck8pqkbaPLIUa
	+ciHJj/g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45918 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ8NN-0004To-1x;
	Thu, 05 Dec 2024 09:42:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ8NM-006L5J-AH; Thu, 05 Dec 2024 09:42:24 +0000
In-Reply-To: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] net: pcs: pcs-lynx: implement pcs_inband_caps()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 09:42:24 +0000

Report the PCS in-band capabilities to phylink for the Lynx PCS.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-lynx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index b79aedad855b..767a8c0714ac 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -35,6 +35,27 @@ enum sgmii_speed {
 #define phylink_pcs_to_lynx(pl_pcs) container_of((pl_pcs), struct lynx_pcs, pcs)
 #define lynx_to_phylink_pcs(lynx) (&(lynx)->pcs)
 
+static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
+					 phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return LINK_INBAND_DISABLE;
+
+	case PHY_INTERFACE_MODE_USXGMII:
+		return LINK_INBAND_ENABLE;
+
+	default:
+		return 0;
+	}
+}
+
 static void lynx_pcs_get_state_usxgmii(struct mdio_device *pcs,
 				       struct phylink_link_state *state)
 {
@@ -306,6 +327,7 @@ static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 }
 
 static const struct phylink_pcs_ops lynx_pcs_phylink_ops = {
+	.pcs_inband_caps = lynx_pcs_inband_caps,
 	.pcs_get_state = lynx_pcs_get_state,
 	.pcs_config = lynx_pcs_config,
 	.pcs_an_restart = lynx_pcs_an_restart,
-- 
2.30.2


