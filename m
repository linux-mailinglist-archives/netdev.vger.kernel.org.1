Return-Path: <netdev+bounces-147417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103569D9788
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D31285CFB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69041D3564;
	Tue, 26 Nov 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xp3QzuFn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544031CCEDB
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625554; cv=none; b=Ns+Dg7RNRFnknj2J9VAU2QP47EO5p0gR4JM3IstNOCSUY7z5DlszdimZUcYdgn+BMPUI43QX7eFOCB0Tz4w5eMq/4orTlEBUXxSGcfEoemVwHS+U+xc/0yjeTMEhr204yQ0bcYbiudAaHEHHD+Hly2QfEW9NF1Ud6Qcazfj+IX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625554; c=relaxed/simple;
	bh=zOogGAdKerJCr6aqv9UKgT6t7Bjp+p9TX5XOIt0/Kzg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NPlW3B1RiQjOCiCVl7BAZ/+X/4LgFmv0aSg7f4N3EG11vpr0KNyqE+ox61ZswZpm4xUs+MvA5F8fE1lXwUD6YgGXVIo3zqFNJZHM3nZxJDCVTQLxo0Rt23ZpajwsuwqbVrJe6i6eDMCXtz+vhXTxBpcjuItfZYvjGd+BndC/h7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xp3QzuFn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RM45E2RyeGgWmHoLgnNlNxoB8BWudpg068BttE0fp4M=; b=Xp3QzuFnWm49I8N/BBG+PZE8s3
	pkE5+cxFtQAXX7vyvPF25qhB/KAOgZcXGKvO4dCV7GIZW2DMNv14rn6uDNT3NTpC0WtVhE2pt/dW4
	L0mOQcl/mw9yiniEIzNaJPve2nk4aOyvcirf5/ZHwho+zqQFBU188aWUlZAfRtjbUhXkXIWxywB2L
	W+Er7sArdulAnW8ITwLHke89ZtoKDV6jQsnVevu7n9VGk1R0h8i2NLXmJ40/jAZ6lAxSlV62h9I/1
	mZqYgul2QhUSamKdwwHKprbr/udKOi5/4aGF/jJJ6S/wbz4lIh9ML9bgwdvKkE7zLkRXDwzZC8zsq
	+uzwXpjw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48716 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3G-0006rc-17;
	Tue, 26 Nov 2024 12:52:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3F-005yhT-AA; Tue, 26 Nov 2024 12:52:21 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 02/23] net: phy: fix phy_ethtool_set_eee()
 incorrectly enabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3F-005yhT-AA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:21 +0000

When phy_ethtool_set_eee_noneg() detects a change in the LPI
parameters, it attempts to update phylib state and trigger the link
to cycle so the MAC sees the updated parameters.

However, in doing so, it sets phydev->enable_tx_lpi depending on
whether the EEE configuration allows the MAC to generate LPI without
taking into account the result of negotiation.

This can be demonstrated with a 1000base-T FD interface by:

 # ethtool --set-eee eno0 advertise 8   # cause EEE to be not negotiated
 # ethtool --set-eee eno0 tx-lpi off
 # ethtool --set-eee eno0 tx-lpi on

This results in being true, despite EEE not having been negotiated and:
 # ethtool --show-eee eno0
	EEE status: enabled - inactive
	Tx LPI: 250 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

Fix this by keeping track of whether EEE was negotiated via a new
eee_active member in struct phy_device, and include this state in
the decision whether phydev->enable_tx_lpi should be set.

Fixes: 3e43b903da04 ("net: phy: Immediately call adjust_link if only tx_lpi_enabled changes")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c |  2 +-
 drivers/net/phy/phy.c     | 30 ++++++++++++++++++------------
 include/linux/phy.h       |  2 ++
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 96d0b3a5a9d3..944ae98ad110 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1530,7 +1530,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 		return ret;
 
 	data->eee_enabled = is_enabled;
-	data->eee_active = ret;
+	data->eee_active = phydev->eee_active;
 	linkmode_copy(data->supported, phydev->supported_eee);
 
 	return 0;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a660a80f34b7..0d20b534122b 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -990,14 +990,14 @@ static int phy_check_link_status(struct phy_device *phydev)
 		phydev->state = PHY_RUNNING;
 		err = genphy_c45_eee_is_active(phydev,
 					       NULL, NULL, NULL);
-		if (err <= 0)
-			phydev->enable_tx_lpi = false;
-		else
-			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
+		phydev->eee_active = err > 0;
+		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
+					phydev->eee_active;
 
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
 		phydev->state = PHY_NOLINK;
+		phydev->eee_active = false;
 		phydev->enable_tx_lpi = false;
 		phy_link_down(phydev);
 	}
@@ -1685,15 +1685,21 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
 static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
 				      const struct eee_config *old_cfg)
 {
-	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
+	bool enable_tx_lpi;
+
+	if (!phydev->link)
+		return;
+
+	enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
+
+	if (phydev->enable_tx_lpi != enable_tx_lpi ||
 	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
-		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
-		if (phydev->link) {
-			phydev->link = false;
-			phy_link_down(phydev);
-			phydev->link = true;
-			phy_link_up(phydev);
-		}
+		phydev->enable_tx_lpi = false;
+		phydev->link = false;
+		phy_link_down(phydev);
+		phydev->enable_tx_lpi = enable_tx_lpi;
+		phydev->link = true;
+		phy_link_up(phydev);
 	}
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 77c6d6451638..563c46205685 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -602,6 +602,7 @@ struct macsec_ops;
  * @supported_eee: supported PHY EEE linkmodes
  * @advertising_eee: Currently advertised EEE linkmodes
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
+ * @eee_active: phylib private state, indicating that EEE has been negotiated
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
@@ -723,6 +724,7 @@ struct phy_device {
 	/* Energy efficient ethernet modes which should be prohibited */
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
 	bool enable_tx_lpi;
+	bool eee_active;
 	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
-- 
2.30.2


