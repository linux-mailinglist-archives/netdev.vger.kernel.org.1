Return-Path: <netdev+bounces-147367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDEF9D9463
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3FB16157F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF61D432D;
	Tue, 26 Nov 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fXVGaR7V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A41D4342
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613113; cv=none; b=eDv9kDyIPR9drTj5L4d6s0WovbgrTsw4C9Tovqd9Ajrpny/tY0fwAenntQySqitxXU7MbcREC5XX6bij3nGyj6L3vlkT2zV9s12ge+Dsh9m2xEKSFlJskba7T+3lcNIXKrC/jmsuLVn0wSWxQ8MJlPzORjqgdYUWKiDgcvw32vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613113; c=relaxed/simple;
	bh=LdPjWTC5NF7nUUv87LY3ZziKoB5YL2qQy3z3xYlUQI0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PFpoy/A2EXd7SZxoxbWkz2RAtVby5pRdCz0NGYZY3rCrG9Dd8PpVxYu8/a26cjZ/KfPsj1M1f1mHugPntjIIuPmtN+l+6aqWSQwqvYiqbtrIgGllYsKwo3F9/NUog3CFIYF6lpqdP75t/C8wmMSK4XmHYv62nwU3GeLkHTaRlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fXVGaR7V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b7vDHQj8gjKPY/OyXucbwCCZPbu1weEAVbULrbU1toE=; b=fXVGaR7VyNcLKRYUi6uqPSBeDM
	gL4BL0GswdwPbKqmbLzZTD8hJ5QvPZwLaCKOWEhV1Q3xEbYDsNH/5ejhoY/RYdMdgAr/R/yXuZe6/
	1184mUyrpKLgXz3jDZ82/wY784QdpvCZA59mrQj54Y4CfUXq4Dw1DjsR6zqIqc+8DWg0fRIy3jf+m
	Qrj7VqJMKv/3nYL9B+C34tWyWuEuBWE/ZftUzPRuhuwKrQo75Cv0/7Adtl7GZgNoig5zv0Ld4gbRR
	hda4zRuVfCyilJRoEuNPy4POkJCavzOnIL4k2LCup3Zef1gMfHE65h5Bk2c1lM/qH+cmmqSKXbzC3
	HQYCJf2g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32892 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFroX-0006Tz-21;
	Tue, 26 Nov 2024 09:24:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFroW-005xQK-Ee; Tue, 26 Nov 2024 09:24:56 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 08/16] net: phy: marvell: implement
 config_inband() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFroW-005xQK-Ee@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:56 +0000

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


