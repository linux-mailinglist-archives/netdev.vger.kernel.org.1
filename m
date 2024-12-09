Return-Path: <netdev+bounces-150235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257249E98A8
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C1B285550
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA51ACEDB;
	Mon,  9 Dec 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hRENGoWm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB21B0407
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754217; cv=none; b=nDt0FPKnMIickYj6i/EhrJOud4G1R6YdmNJBS04+hLigMMyn+tkXsew+d7yBmYezUQK+jAP4K55KdAiAKm4UOItMaVD/8i4PYAUbUD9zx4kPAlDjjrHfpdbExSblhZl3989LfcCLQQlaKe/XPZ3FEEmXE/4NbJUvc4OEXTUwPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754217; c=relaxed/simple;
	bh=dcuYUPLjO0VlVJQlAOr7MKLiieYlV518TPBXLHWmNbI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=EN9PDevmZML1YtBGaVW6B3j4peJUKZc5CUIHKDsm+PlgYw2z1DjJSvkEdVlovfkManQd2lDVO3PD/8QfdpNqnu0GbOrkvlEmPx4YPBkItiZfsSlZVu6nPkjMS68IGbCVNfnJLLXmkNVXhdc82bkzefdc6GTp62QwoFZM+xHOjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hRENGoWm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b1OzkI5FeOyMcGqV2D4mMFhkDblO5taxKA6QVrLg4Ps=; b=hRENGoWm68TH0KJFB9jynDZnPC
	DeEcySV67A9wotYS3SrWsxNLX1cmhDApQIz321b7yf6kYs6ZgQRquckpbhaqPdOQ6wRFZDjz3teAe
	Euwj8T7nzIMVaD0xvRql6w4E58Sg+aJhUtmTHo3HDcTM3jptFjbpzAb5OpLB5K+wsWX0e/V87MKer
	lH3WNs4sUy3qUh+ObUMIHdYNePUy/T8Z81gpUDk3p50VBycWd1D/V0oPT0Qb69R8ZOyhvIbDJH+xn
	G4zJHvS1iwUlpigK1g58LPDhOTd49/7g35398b9aiMnYW4P9+MeoUCJFQe5RIlr+85Q6N2g0Z4g+j
	RA2kMR1Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36578 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKefZ-0000wh-2U;
	Mon, 09 Dec 2024 14:23:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKefY-006SMd-Af; Mon, 09 Dec 2024 14:23:28 +0000
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 03/10] net: phy: add configuration of rx clock stop
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tKefY-006SMd-Af@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Dec 2024 14:23:28 +0000

Add a function to allow configuration of the PCS's clock stop enable
bit, used to configure whether the xMII receive clock can be stopped
during LPI mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 27 ++++++++++++++++++++++-----
 include/linux/phy.h   |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 8fb4224c7576..caf472b5d4e5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1660,6 +1660,27 @@ int phy_eee_tx_clock_stop_capable(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_eee_tx_clock_stop_capable);
 
+/**
+ * phy_eee_rx_clock_stop() - configure PHY receive clock in LPI
+ * @phydev: target phy_device struct
+ * @clk_stop_enable: flag to indicate whether the clock can be stopped
+ *
+ * Configure whether the PHY can disable its receive clock during LPI mode,
+ * See IEEE 802.3 sections 22.2.2.2, 35.2.2.10, and 45.2.3.1.4.
+ *
+ * Returns: 0 or negative error.
+ */
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable)
+{
+	/* Configure the PHY to stop receiving xMII
+	 * clock while it is signaling LPI.
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+			      MDIO_PCS_CTRL1_CLKSTOP_EN,
+			      clk_stop_enable ? MDIO_PCS_CTRL1_CLKSTOP_EN : 0);
+}
+EXPORT_SYMBOL_GPL(phy_eee_rx_clock_stop);
+
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
@@ -1684,11 +1705,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 		return -EPROTONOSUPPORT;
 
 	if (clk_stop_enable)
-		/* Configure the PHY to stop receiving xMII
-		 * clock while it is signaling LPI.
-		 */
-		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
-				       MDIO_PCS_CTRL1_CLKSTOP_EN);
+		ret = phy_eee_rx_clock_stop(phydev, true);
 
 	return ret < 0 ? ret : 0;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 267de08c227c..f865a8fc56c3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2073,6 +2073,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
 int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.30.2


