Return-Path: <netdev+bounces-224073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F386B80721
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005EE3B2AD5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1D2E4252;
	Wed, 17 Sep 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XvgiZMxP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E932E724
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121946; cv=none; b=hDU1IwuY1VSBiGt2X4UB3ZTrX31xIzkTMmKzvUaHbBnhn6F9v/V2Zdd2NNxcfEyXFq+kda355G5kgo//Lv94zkUKt6tNRZdviM1VJ7cVULGfM5Lru2JhisynWmqR5hUkHRbnNpOifyxJzVVrpP/qLWBTUCH95Kl2uH4BRximPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121946; c=relaxed/simple;
	bh=JllRX1fbfYpGbKr5JSRlvtCaouJU+rHvqB5P7YvgJkU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=krd6+q1ConAWz9asFKFkKVkC+Ii+Wga85vHGHrz2rGfs5Uimpf7cnjmiSp03awgCDJDMK73cWUurCXzMLgDP4DLd18vqHa7QYqw8b+7x+AXEQjE1QYrKsuwfZF3A5uOy/b+DYvi6vsXsUgFGaCEEZKbB7bSyZbRBlCSMkmtEC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XvgiZMxP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yL4Jk45sqLts/HACU8QhKLj5qhtjExvGIb6xotspnvs=; b=XvgiZMxPsDZi8tAosLbTB8USRC
	T7x0p3I/klz5DPwpbFdJk7CDIyXGdk/68efzEal2nxvmPK4/oVO1sy0cEi0u4hO/cBQBHI3fhgE/I
	KfjzsFUdyYuzbWzlqwi1MG4Ko/VBR3d9fXs+U6B0U3vxSgfel3STI7S9o397AgSvAUd1m5O6L0Pnt
	C6/YRpKbLxC+JkH2wMQDMAtWt+YBXOPP2IAA9vSIHp4mYBZ0p+eCfFl6EtZG7t5UHKAeIyzmimA9o
	XwJKdOgAjwGZGj1KsMcBM+wxzec4/KNniN0E/7Preyfgg+bNcASrq1PmdmSO2JSkVoq7R7m/7dSIL
	GTZa9l8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36628 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpC-000000004js-0dfg;
	Wed, 17 Sep 2025 16:12:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpB-00000006H23-0pRi;
	Wed, 17 Sep 2025 16:12:01 +0100
In-Reply-To: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 01/10] net: stmmac: rework mac_interface and
 phy_interface documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpB-00000006H23-0pRi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:01 +0100

Based on new research, it has come to light that the comment that I
added in a014c35556b9 ("net: stmmac: clarify difference between
"interface" and "phy_interface"") is not fully correct.

Update the comment to properly describe the difference between the two.

All of the DTS files in the kernel tree do not mention the "mac-mode"
property, which results in mac_interface and phy_interface being the
same. Also, none of the platform glue drivers set mac_interface to
anything but PHY_INTERFACE_MODE_NA. This means that for all the
platforms known to mainline, mac_interface is either the same as
phy_interface, or it is PHY_INTERFACE_MODE_NA.

Thus, updating the definition for mac_interface in stmmac.h has no
material effect on current uses known to mainline, but the change opens
the door to cleaning up all uses.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/stmmac.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index e284f04964bf..f14f34ec6d5e 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -190,18 +190,32 @@ struct plat_stmmacenet_data {
 	int bus_id;
 	int phy_addr;
 	/* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
-	 *       ^                               ^
-	 * mac_interface                   phy_interface
+	 *                          ^            ^
+	 *                    mac_interface phy_interface
 	 *
-	 * mac_interface is the MAC-side interface, which may be the same
-	 * as phy_interface if there is no intervening PCS. If there is a
-	 * PCS, then mac_interface describes the interface mode between the
-	 * MAC and PCS, and phy_interface describes the interface mode
-	 * between the PCS and PHY.
+	 * The Synopsys dwmac core only covers the MAC and an optional
+	 * integrated PCS. Where the integrated PCS is used with a SerDes,
+	 * e.g. for 1000base-X or Cisco SGMII, the connection between the
+	 * PCS and SerDes will be TBI.
+	 *
+	 * Where the Synopsys dwmac core has been instantiated with multiple
+	 * interface modes, these are selected via core-external configuration
+	 * which is sampled when the dwmac core is reset. How this is done is
+	 * platform glue specific, but this defines the interface used from
+	 * the Synopsys dwmac core to the rest of the SoC.
+	 *
+	 * Where PCS other than the optional integrated Synopsys dwmac PCS
+	 * is used, this counts as "the rest of the SoC" in the above
+	 * paragraph.
+	 *
+	 * Thus, mac_interface is of little use inside the stmmac code;
+	 * please do not use unless there is a definite requirement, and
+	 * make sure to gain review feedback first.
 	 */
 	phy_interface_t mac_interface;
 	/* phy_interface is the PHY-side interface - the interface used by
-	 * an attached PHY.
+	 * an attached PHY or SFP etc. This is equivalent to the interface
+	 * that phylink uses.
 	 */
 	phy_interface_t phy_interface;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
-- 
2.47.3


