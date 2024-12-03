Return-Path: <netdev+bounces-148571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575FA9E2366
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A3D164B52
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845A11F76D5;
	Tue,  3 Dec 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CutcdQcF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83B1F8AED
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239880; cv=none; b=cdQWGnVBqGVmk4+xNHajTBMbDt2bbVMqnTKHd5r1OyO8oVSiLyi5Apg1aqZauxuf2uzEKkpW6Ri9u9v/Vbt4I7RA4nlmox3IErDwxqnuaAIl0/+MN3HriQjq6/bcKAZY9yhURe/qrUXenRTQKPxEkogK5h8thnhJyR5ottGwzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239880; c=relaxed/simple;
	bh=Q7va0oi0HQUYGZSD7s7fnPmmHlIN+5X7GCpYydXHxWc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JnLaxJ55aFG8mYweB6H4UGhVPnVbIZDwMzKnC57s/bj0PRiFkLwQNH1O/A3wow6pWr49SqUr3r3+HZUyEnMM3dsFV7zFJeSPiNvCjh19ml5a+v03KXVc1+O0X5/0rFpzv4c1oK6Uc1TJTPawQN2eggQJyLopeHhn5Aq3XJvzFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CutcdQcF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=waUleP6vSkFH5yAxO/wXeyrEg/nb1nwkAYs0JL7/F0I=; b=CutcdQcFLVORAo490Iy6OkdWAI
	YWu4BkUU76bHZ9wOdklk4Ya6m7aELhCxFWA35TeQfJluvsAxFMaYuib+Rhx+0tfjaaCvjUAbk/cxJ
	88aJkiwnYB7LxQvjLkUeyMpZRgWpkCcg4tATen99MitFnyUdPF+1ZpLbl3mIMwgpNgJ3gBLQRrcJ9
	j7PwPqo+Zc8TIC4DkNygdTlsNmUGd6mLqdMcJa1dZJ7nNfWq4SIZQc3RQSL+ZSKf2Z5khrRjpky1g
	Ot/XK9RdvA4LfWb0KIAwowtYwZrvafwId0wb9ca+cssKrIEqt6HNTYvKjngDFSuHXsn6oIv/qW+lV
	uJn6mS5w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59302 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUrq-00028V-01;
	Tue, 03 Dec 2024 15:31:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUro-006IUC-Rq; Tue, 03 Dec 2024 15:31:12 +0000
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
Subject: [PATCH net-next 06/13] net: phy: marvell: implement phy_inband_caps()
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
Message-Id: <E1tIUro-006IUC-Rq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:12 +0000

Provide an implementation for phy_inband_caps() for Marvell PHYs used
on SFP modules, so that phylink knows the PHYs capabilities.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index cd50cd6a7f75..3075ebc3f964 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -717,6 +717,20 @@ static int marvell_config_aneg_fiber(struct phy_device *phydev)
 	return genphy_check_and_restart_aneg(phydev, changed);
 }
 
+static unsigned int m88e1111_inband_caps(struct phy_device *phydev,
+					 phy_interface_t interface)
+{
+	/* In 1000base-X and SGMII modes, the inband mode can be changed
+	 * through the Fibre page BMCR ANENABLE bit.
+	 */
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_SGMII)
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE |
+		       LINK_INBAND_BYPASS;
+
+	return 0;
+}
+
 static int m88e1111_config_aneg(struct phy_device *phydev)
 {
 	int extsr = phy_read(phydev, MII_M1111_PHY_EXT_SR);
@@ -3677,6 +3691,7 @@ static struct phy_driver marvell_drivers[] = {
 		.name = "Marvell 88E1112",
 		/* PHY_GBIT_FEATURES */
 		.probe = marvell_probe,
+		.inband_caps = m88e1111_inband_caps,
 		.config_init = m88e1112_config_init,
 		.config_aneg = marvell_config_aneg,
 		.config_intr = marvell_config_intr,
@@ -3698,6 +3713,7 @@ static struct phy_driver marvell_drivers[] = {
 		/* PHY_GBIT_FEATURES */
 		.flags = PHY_POLL_CABLE_TEST,
 		.probe = marvell_probe,
+		.inband_caps = m88e1111_inband_caps,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
 		.read_status = marvell_read_status,
@@ -3721,6 +3737,7 @@ static struct phy_driver marvell_drivers[] = {
 		.name = "Marvell 88E1111 (Finisar)",
 		/* PHY_GBIT_FEATURES */
 		.probe = marvell_probe,
+		.inband_caps = m88e1111_inband_caps,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
 		.read_status = marvell_read_status,
-- 
2.30.2


