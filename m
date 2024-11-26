Return-Path: <netdev+bounces-147365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A99D9461
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725A92818B6
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245F1BD4FD;
	Tue, 26 Nov 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GRpm2OY0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7F1BD030
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613101; cv=none; b=m9gSnBIupjxWhAOFsa7bd/dGTRRZGKPHzY0ty8e2Sk148arPe6t0FHJoZhDzgp2m9ByJ8QDP7y595MxzX01rYgOabbnUxRFFbk3KHi1jqcxxsyoEI/JhxN1stMjiW1gJZGzxlErGUAaHBJ2S76IGmZy3zXHyvKzA39MS0y5nw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613101; c=relaxed/simple;
	bh=F/mJbibc4w4LwNmg45zcCtlQEa9vFmru2pNOLYqkgz0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jNAKfRpypeWbT/h9fvp2cay52YgBkHbxaNk33UBxp89RPjAfYj/WHjp99i8o2WSYn2T+NIy70LOYkecwOEmkLSsUAPdHTXCJZA7+354O3TSHbOweS6AXikgQCad66yXnMFzdzYWUVNSKoAAMAzhs/lpQ/eHACZFXrVv5bXyhEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GRpm2OY0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g+THxpnpB+Pzg6AUVLr1ssu3RzIpCwc8waUglBp2qOw=; b=GRpm2OY0Zw0dJ0N+JCTvCDY78n
	u/QvZL7ScctRtwe7RGBf4kpWi7XVw4YtbaM1qwpYF4J05XPZMdNGPeKc8SpLS26YdEQ8yNKmbd7ie
	kHnui34Z0DMzM+/Hr+YwsbUL0msNZE8MNjBkoB4zbY9p+76eonE4Brx9Zb8jVtsvY07xRu3aouvxz
	SC0ihPwuX1bbU4rf2u0I9vcEguCHgRnF27k/U5XImtUjHTdMiUwV/EGVBOBnDpGIDYofEs2gxrNQI
	51ax/HuGD3AJhMe/JtzhWST+IN4pqaOrPowlRqv1GrYXdDQVw5CRYgu+dgSz/Rx/QCPJ0wOtMKvLh
	8mNWhP4A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46102 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFroN-0006TK-1Q;
	Tue, 26 Nov 2024 09:24:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFroM-005xQ8-6e; Tue, 26 Nov 2024 09:24:46 +0000
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
Subject: [PATCH RFC net-next 06/16] net: phy: marvell: implement
 phy_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFroM-005xQ8-6e@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:46 +0000

Provide an implementation for phy_inband_caps() for Marvell PHYs used
on SFP modules, so that phylink knows the PHYs capabilities.

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


