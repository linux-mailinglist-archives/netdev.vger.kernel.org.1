Return-Path: <netdev+bounces-88786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B088A8922
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49E7283ACA
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7348171E59;
	Wed, 17 Apr 2024 16:43:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41414882F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372216; cv=none; b=EDZZAWCByZhO0yBen6+0DyawMylfvFIo1zPP3+ALH1C5oV9wbDl2KPfDLaFg21LLd7cKJyNPeS8wl/HvuYVMuDX8S6gLS/6sb8rN3ps6DykcNa5GT7zK0y0HtuN0GKHwLMJClFebbi6f2GCJvScY6NR/v8jPahF/axmf7SjShpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372216; c=relaxed/simple;
	bh=msyoR8psGA34dyrl4EIM/ln6JTeFBgyF/vyuhfWSiuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5Qjit/luV2t9s2f/qPbDIJEq/nsbv/QwFhba9AC6ibgefvYJrqQ3Plyh+pUaLIbw3aHSJrA3/G67xipc5OfquF7FaplzWCTxFCPMNZhUruxscFNdszw6StDPDgTuXdNwS5OF1pm+8tWF2uzsHM6MzVg4xTRsA0h8dn9yiAcoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NT-0007N2-VR; Wed, 17 Apr 2024 18:43:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-00CpCc-RJ; Wed, 17 Apr 2024 18:43:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-007MeC-2S;
	Wed, 17 Apr 2024 18:43:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next v1 3/4] net: phy: realtek: provide TimeSync data path delays for RTL8211E
Date: Wed, 17 Apr 2024 18:43:15 +0200
Message-Id: <20240417164316.1755299-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417164316.1755299-1-o.rempel@pengutronix.de>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Provide default data path delays for RTL8211E.

The measurements was done against with iMX8MP STMMAC and LAN8841 as the
link partner.

This values was calculated based on RGMII-PHY-PHY-RGMII measurements,
where the link partner is LAN8841. Following values was measured:
- data flow from RTL8211E to LAN8841:
  746ns @ 1000Mbps
  1770ns @ 100Mbps
  932000ns @ 10Mbps
- data flow from LAN8841 to RTL8211E:
  594ns @ 1000Mbps
  1130ns @ 100Mbps
  8920ns @ 10Mbps

Before this patch ptp4l reported following path delays:
~610ns @ 1000Mbps
~942ns @ 100Mbps
~465998ns @ 10Mbps

PPS offset compared to grand master was:
~ -114ns @ 1000Mbps
~ -215ns @ 100Mbps
~ -465998ns @ 10Mbps

Magnetic - Cable - Magnetic - delay in this setup was about 5ns.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/realtek.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 1fa70427b2a26..e39fec8d166b9 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -221,6 +221,47 @@ static int rtl8211e_config_intr(struct phy_device *phydev)
 	return err;
 }
 
+static int rtl8211e_get_timesync_data_path_delays(struct phy_device *phydev,
+						  struct phy_timesync_delay *tsd)
+{
+	phydev_warn(phydev, "Time stamping is not supported\n");
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		/* The values are measured with RTL8211E and LAN8841 as link
+		 * partners and confirmed with i211 to be in sane range.
+		 */
+		if (phydev->speed == SPEED_1000) {
+			tsd->tx_min_delay_ns = 326;
+			tsd->rx_min_delay_ns = 406;
+			return 0;
+		} else if (phydev->speed == SPEED_100) {
+			tsd->tx_min_delay_ns = 703;
+			tsd->rx_min_delay_ns = 621;
+			return 0;
+		} else if (phydev->speed == SPEED_10) {
+			/* This value is suspiciously big, with atypical
+			 * shift to Egress side. This value is confirmed
+			 * by measuring RGMII-PHY-PHY-RGMII path delay.
+			 * Similar results are confirmed with LAN8841 and i211
+			 * as link partners.
+			 */
+			tsd->tx_min_delay_ns = 920231;
+			tsd->rx_min_delay_ns = 1674;
+			return 0;
+		}
+	default:
+		break;
+	}
+
+	phydev_warn(phydev, "Not tested or not supported modes for path delay values\n");
+
+	return -EOPNOTSUPP;
+}
+
 static int rtl8211f_config_intr(struct phy_device *phydev)
 {
 	u16 val;
@@ -935,6 +976,7 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.get_timesync_data_path_delays = rtl8211e_get_timesync_data_path_delays,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
-- 
2.39.2


