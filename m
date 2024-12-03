Return-Path: <netdev+bounces-148573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640769E2369
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C498166684
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03D1F8906;
	Tue,  3 Dec 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZGuKPAQq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92B646
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239890; cv=none; b=NW8NIKZfM+oJJHsXm4ep23zoQThkvXqWEedxXY7v1zQxVsPiNdS1dr4JRhMpevsRPSqvoxv3gRa0f7LSvONimvmGlWxoYaWuc1XuU8h7xJEsj9G7R3TZ9RTH4CrND0oSCIm2Zu2VG7Ae9rPMna9D6jqKXzkRcXuwny/A71ICs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239890; c=relaxed/simple;
	bh=8pvCbn/YPti0EPvFMOPLHe4nyb9CJu3HzdyS21wB76I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pssG2diemQc6ue3URrEqVKkqdtGYs38PhXhPtYxyLkj3hPCEmsfLXK+6vIwPsbj98jQSYwSMXSWO7wffx+V3Hr8V/FZjzrveW1+M4dQ+hNZxwsc2sRqkQDGSvjXjp3sUJgVkPoJWw9N7r0EtPY5lkYMUMcDvYuxHLteh8bhooTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZGuKPAQq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=abVQ3lbdX1v1+GMptjrQ+piJq6aFDOrbwCjX86ep9CY=; b=ZGuKPAQqBH7vCNbDy4jaqqLCU/
	zvthonhSCF6GIcCGpJyM81s5nZlyiIHizG2FZdJIfPrb9BbVMjEz2l706qhHi81bXssmxkEgzv1ic
	W9JdFIzyguj2yMeojvhDO+tZNpCH7Zck6NgGbIcHbF7464PkaqTh2brwhD6xEvmHusYCnGt3rVwyK
	B5oJrSwSkzLCq3PTRuGr/+c+g6YqX0A+/L6QweEL/CZvTCUHDh5pz0/JOIVkkYG8rZ9tL8q3nWP+y
	xnOXh7h4IxLRK/XtUGnOFUQz2uJNp1Sfbto+gux29iAIsRC09NcPd1THmwkcdmfD7V5me3y6kr7+5
	EhVLxxCw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58962 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUs0-00028u-0e;
	Tue, 03 Dec 2024 15:31:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUrz-006IUO-3r; Tue, 03 Dec 2024 15:31:23 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 08/13] net: phy: marvell: implement config_inband()
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
Message-Id: <E1tIUrz-006IUO-3r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:23 +0000

Implement the config_inband() method for Marvell 88E1112, 88E1111,
and Finisar's 88E1111 variant.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 3075ebc3f964..b885bc0fe6e0 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -731,6 +731,34 @@ static unsigned int m88e1111_inband_caps(struct phy_device *phydev,
 	return 0;
 }
 
+static int m88e1111_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	u16 extsr, bmcr;
+	int err;
+
+	if (phydev->interface != PHY_INTERFACE_MODE_1000BASEX &&
+	    phydev->interface != PHY_INTERFACE_MODE_SGMII)
+		return -EINVAL;
+
+	if (modes == LINK_INBAND_BYPASS)
+		extsr = MII_M1111_HWCFG_SERIAL_AN_BYPASS;
+	else
+		extsr = 0;
+
+	if (modes == LINK_INBAND_DISABLE)
+		bmcr = 0;
+	else
+		bmcr = BMCR_ANENABLE;
+
+	err = phy_modify(phydev, MII_M1111_PHY_EXT_SR,
+			 MII_M1111_HWCFG_SERIAL_AN_BYPASS, extsr);
+	if (err < 0)
+		return extsr;
+
+	return phy_modify_paged(phydev, MII_MARVELL_FIBER_PAGE, MII_BMCR,
+				BMCR_ANENABLE, bmcr);
+}
+
 static int m88e1111_config_aneg(struct phy_device *phydev)
 {
 	int extsr = phy_read(phydev, MII_M1111_PHY_EXT_SR);
@@ -3692,6 +3720,7 @@ static struct phy_driver marvell_drivers[] = {
 		/* PHY_GBIT_FEATURES */
 		.probe = marvell_probe,
 		.inband_caps = m88e1111_inband_caps,
+		.config_inband = m88e1111_config_inband,
 		.config_init = m88e1112_config_init,
 		.config_aneg = marvell_config_aneg,
 		.config_intr = marvell_config_intr,
@@ -3714,6 +3743,7 @@ static struct phy_driver marvell_drivers[] = {
 		.flags = PHY_POLL_CABLE_TEST,
 		.probe = marvell_probe,
 		.inband_caps = m88e1111_inband_caps,
+		.config_inband = m88e1111_config_inband,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
 		.read_status = marvell_read_status,
@@ -3738,6 +3768,7 @@ static struct phy_driver marvell_drivers[] = {
 		/* PHY_GBIT_FEATURES */
 		.probe = marvell_probe,
 		.inband_caps = m88e1111_inband_caps,
+		.config_inband = m88e1111_config_inband,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
 		.read_status = marvell_read_status,
-- 
2.30.2


