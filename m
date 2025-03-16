Return-Path: <netdev+bounces-175115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9DAA635A5
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888F716C68B
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A213632B;
	Sun, 16 Mar 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SA0H33LW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F7DF49
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742128822; cv=none; b=hmDTqk+mpCXsD8iGiSX6r8ONZ/j0dYIIxqjpQJoWcxQVn65E2ysulcCTbTZ5Va8qO+xZYWBjf2UxwQyt0C+6RHi3a0dqdZnvHDKRTm5l8KgZFEPA9xayOcROdo45zGvft0SB8DPbBlMrycPNZwpAlYR+dyowVQPhb/+kbhj+2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742128822; c=relaxed/simple;
	bh=DW6z3V7TF/LmVZsnY61GoUzlcxEoTpTTg1Z6BAXkKM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=BTNWZVgJrbhiage3JnB22stv5xkDpYxkcN6KK2RYB/hVqxSrLfc405l6vb4/oxmooJFYGfSYeJwq6gRaEYfUPWOQ1b/Fj8pwBBhcT9eG4FSVIofKNpVguVjPDzX0UG79FUbZ3G42f0cKBo9WhIZnu9sR0rAPJHK0MCwFZG4yQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SA0H33LW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bMOQew/SwnZg1oGSmVcweRNt/5J0WoX40rXcSh015ug=; b=SA0H33LWnofbYuCEkG3n0xLMPG
	OzObet7DSL6ZoMhyotAkV6OqRXdPS8l8DyNqUMp4cWpKrtOnB6WEJJbkX9VZ2t8xeIpBaE7ZTjfIf
	wNm0ktE8eOzkVvYj6Ctxw2IiZXRnIhwCyRZnOGIafCiK1RKJYB2xMfj5EP7wHyl1QYe0lf6pwKv9C
	ykC1/Ll/27gTVg1J2N3xByMlZJYCBAo1KD1Yb/z4HZVenhsxLAp7+FnJrf/OWWgFVArTJ+NbsTIHd
	jGMD9dVBIMNQOgpjhUpnb6BRYTVTZZJKjLlnI9lo/GiLwF1g+Npx5WpbBrnZ4mLDCf87S0iOE5B3/
	UoL/k6vg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58062 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ttnHr-0002S8-1X;
	Sun, 16 Mar 2025 12:40:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ttnHW-00785s-Uq; Sun, 16 Mar 2025 12:39:54 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phy: realtek: disable PHY-mode EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ttnHW-00785s-Uq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 16 Mar 2025 12:39:54 +0000

Realtek RTL8211F has a "PHY-mode" EEE support which interferes with an
IEEE 802.3 compliant implementation. This mode defaults to enabled, and
results in the MAC receive path not seeing the link transition to LPI
state.

Fix this by disabling PHY-mode EEE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This patch isn't the best approach...
---
 drivers/net/phy/realtek/realtek_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 7a0b19d66aca..893c82479671 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -33,6 +33,9 @@
 
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
+#define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
+
 #define RTL8211F_INSR				0x1d
 
 #define RTL8211F_LEDCR				0x10
@@ -55,8 +58,6 @@
 #define RTL8211E_TX_DELAY			BIT(12)
 #define RTL8211E_RX_DELAY			BIT(11)
 
-#define RTL8211F_CLKOUT_EN			BIT(0)
-
 #define RTL8201F_ISR				0x1e
 #define RTL8201F_ISR_ANERR			BIT(15)
 #define RTL8201F_ISR_DUPLEX			BIT(13)
@@ -453,6 +454,12 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			str_enabled_disabled(val_rxdly));
 	}
 
+	/* Disable PHY-mode EEE so LPI is passed to the MAC */
+	ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR2,
+			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
+	if (ret)
+		return ret;
+
 	if (priv->has_phycr2) {
 		ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR2,
 				       RTL8211F_CLKOUT_EN, priv->phycr2);
-- 
2.30.2


