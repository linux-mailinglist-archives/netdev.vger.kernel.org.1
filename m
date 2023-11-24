Return-Path: <netdev+bounces-50828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C37F73CF
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591DD281CDD
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9F2556C;
	Fri, 24 Nov 2023 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YektizKq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBB3D43
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aIU+YqSr+FD/3i6UbVXclt+W8yp2xWGXuQB8elbYW2Q=; b=YektizKqgmnv4KaeURF+dy3N3Y
	KED7UXtw2degbgkUy1rPpbPNoktOh+ZV4p17U6+ddB6CEp4cQnfcLbvbFAfKiCDC7w62xItCAYVX7
	W2CAdHnn7VvtdbRg5EfJgrl2YZ4osAGM0bwgZkgaGVj6VluwIOjOW6FWRxYwPb+lap7h6afr5z4Hz
	b7Pogfwfvy+WEdce7mDJhz01hqcPE8Zv+pscunHt7B4is5NHabtaUSsajVlBf4+LCmT4b4pL0c1q/
	AldjZtrHTIy9IEjVFzm7w2wfn65XuVceJ9o1GaqON/vJnBwwfQLRN1f/P8pccm+VO0svhqi8At7qo
	qUd1gviQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52628 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VIT-0002uR-2V;
	Fri, 24 Nov 2023 12:28:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VIV-00DDMF-Pi; Fri, 24 Nov 2023 12:28:39 +0000
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 10/10] net: phylink: use the PHY's
 possible_interfaces if populated
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r6VIV-00DDMF-Pi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:28:39 +0000

Some PHYs such as Aquantia, Broadcom 84881, and Marvell 88X33x0 can
switch between a set of interface types depending on the negotiated
media speed, or can use rate adaption for some or all of these
interface types.

We currently assume that these are Clause 45 PHYs that are configured
not to use a specific set of interface modes, which has worked so far,
but is just a work-around. In this workaround, we validate using all
interfaces that the MAC supports, which can lead to extra modes being
advertised that can not be supported.

To properly address this, switch to using the newly introduced PHY
possible_interfaces bitmap which indicates which interface modes will
be used by the PHY as configured. We calculate the union of the PHY's
possible interfaces and MACs supported interfaces, checking that is
non-empty. If the PHY is on a SFP, we further reduce the set by those
which can be used on a SFP module, again checking that is non-empty.
Finally, we validate the subset of interfaces, taking account of
whether rate matching will be used for each individual interface mode.

This becomes independent of whether the PHY is clause 22 or clause 45.

It is encouraged that all PHYs that switch interface modes or use
rate matching should populate phydev->possible_interfaces.

Tested-by: Luo Jie <quic_luoj@quicinc.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 67 +++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 39d85e47422e..48d3bd3e9fc7 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -121,6 +121,19 @@ do {									\
 })
 #endif
 
+static const phy_interface_t phylink_sfp_interface_preference[] = {
+	PHY_INTERFACE_MODE_25GBASER,
+	PHY_INTERFACE_MODE_USXGMII,
+	PHY_INTERFACE_MODE_10GBASER,
+	PHY_INTERFACE_MODE_5GBASER,
+	PHY_INTERFACE_MODE_2500BASEX,
+	PHY_INTERFACE_MODE_SGMII,
+	PHY_INTERFACE_MODE_1000BASEX,
+	PHY_INTERFACE_MODE_100BASEX,
+};
+
+static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
+
 /**
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
  * @mask: ethtool link mode mask
@@ -1764,6 +1777,47 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 				unsigned long *supported,
 				struct phylink_link_state *state)
 {
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+
+	/* If the PHY provides a bitmap of the interfaces it will be using
+	 * depending on the negotiated media speeds, use this to validate
+	 * which ethtool link modes can be used.
+	 */
+	if (!phy_interface_empty(phy->possible_interfaces)) {
+		/* We only care about the union of the PHY's interfaces and
+		 * those which the host supports.
+		 */
+		phy_interface_and(interfaces, phy->possible_interfaces,
+				  pl->config->supported_interfaces);
+
+		if (phy_interface_empty(interfaces)) {
+			phylink_err(pl, "PHY has no common interfaces\n");
+			return -EINVAL;
+		}
+
+		if (phy_on_sfp(phy)) {
+			/* If the PHY is on a SFP, limit the interfaces to
+			 * those that can be used with a SFP module.
+			 */
+			phy_interface_and(interfaces, interfaces,
+					  phylink_sfp_interfaces);
+
+			if (phy_interface_empty(interfaces)) {
+				phylink_err(pl, "SFP PHY's possible interfaces becomes empty\n");
+				return -EINVAL;
+			}
+		}
+
+		phylink_dbg(pl, "PHY %s uses interfaces %*pbl, validating %*pbl\n",
+			    phydev_name(phy),
+			    (int)PHY_INTERFACE_MODE_MAX,
+			    phy->possible_interfaces,
+			    (int)PHY_INTERFACE_MODE_MAX, interfaces);
+
+		return phylink_validate_mask(pl, phy, supported, state,
+					     interfaces);
+	}
+
 	/* Check whether we would use rate matching for the proposed interface
 	 * mode.
 	 */
@@ -3032,19 +3086,6 @@ static void phylink_sfp_detach(void *upstream, struct sfp_bus *bus)
 	pl->netdev->sfp_bus = NULL;
 }
 
-static const phy_interface_t phylink_sfp_interface_preference[] = {
-	PHY_INTERFACE_MODE_25GBASER,
-	PHY_INTERFACE_MODE_USXGMII,
-	PHY_INTERFACE_MODE_10GBASER,
-	PHY_INTERFACE_MODE_5GBASER,
-	PHY_INTERFACE_MODE_2500BASEX,
-	PHY_INTERFACE_MODE_SGMII,
-	PHY_INTERFACE_MODE_1000BASEX,
-	PHY_INTERFACE_MODE_100BASEX,
-};
-
-static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
-
 static phy_interface_t phylink_choose_sfp_interface(struct phylink *pl,
 						    const unsigned long *intf)
 {
-- 
2.30.2


