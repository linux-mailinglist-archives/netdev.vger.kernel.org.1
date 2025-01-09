Return-Path: <netdev+bounces-156741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880DA07BAA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B4616AD61
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111C220697;
	Thu,  9 Jan 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lja7CoXJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BF21E08A
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435792; cv=none; b=nERPDuBLq8Q0kEfCFKJSIV7gCu9jzGuJPX1BWOcfdeW6rGWKCCDAbOkqSjUlEd0OZovCvCz4ptH8o7s/SUfQuR9jMxhJB6txcw0ZkuYZVwlP2jTAbpp3KxTGbyalNCXK6sAeo1Jt1z88+qHnps0n2l4v1vn7OR8VoE4D6wQL0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435792; c=relaxed/simple;
	bh=MZtLE5F1Y++R/FvnltKHa6duo1px+Eq1zh+gP458lDg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CinzPBZujON61yBUiPqRL0QcgdKbVJigG1qSafR5F6bk+PrM+8Kx9LbNrSR9d0ZtFH/Xmfjcl3Qrzx8jYlBIu73nWOFuGON1Z6H0XVYdFu3f7dnr3MlDF2GrdLEYgZ5X0GnSbkFRTtI3uZUowlrmfCLXXAEPoY3EnPf9CgpmYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lja7CoXJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5xzWHY7CCln9l/THG/P2Qq643Grj7kUnbBQsLpWiTZM=; b=lja7CoXJcshFjyTvCXDsLzzcv4
	EPHfppnHRakqRMypQzy/m0zVfZCnzfnNkKmQ/e68bvk0Kxa1SoasnjS4CaHCMcdGyQYppWVPjT8Wf
	FcjA9oXj9EDjz24tAVvmoYTvLHR+RmbT+LCSgmhSu2Hv6p1bxRYtdYaDCpW17T/odhTfP6ySsC2C6
	fcW+/eQEa1yTPxHpeldlwk7yRNHzIc+6cHpqQv2Ex1Zm2R3Bynafgb1nZvjn7R8W2xLS+6WKbvd6v
	1Ti5xcKXPX8PhcV+lg0GXoZLN8tDozIN6DvoAZqneokrVBFj2GhNaDPZS20BKxdK1NBHT0BiQx+nX
	KOxIIxsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47886 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVuGO-0002EH-0g;
	Thu, 09 Jan 2025 15:16:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVuG1-000BXo-S7; Thu, 09 Jan 2025 15:15:37 +0000
In-Reply-To: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	kernel-team@meta.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next 5/5] net: phylink: provide fixed state for 1000base-X
 and 2500base-X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVuG1-000BXo-S7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 09 Jan 2025 15:15:37 +0000

When decoding clause 22 state, if in-band is disabled and using either
1000base-X or 2500base-X, rather than reporting link-down, we know the
speed, and we only support full duplex. Pause modes taken from XPCS.

This fixes a problem reported by Eric Woudstra.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5174c22e2091..0ae96d1376b4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3882,27 +3882,36 @@ void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
 	if (!state->link)
 		return;
 
-	/* If in-band is disabled, then the advertisement data is not
-	 * meaningful.
-	 */
-	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED)
-		return;
-
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
-		phylink_decode_c37_word(state, lpa, SPEED_1000);
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+			phylink_decode_c37_word(state, lpa, SPEED_1000);
+		} else {
+			state->speed = SPEED_1000;
+			state->duplex = DUPLEX_FULL;
+			state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
+		}
 		break;
 
 	case PHY_INTERFACE_MODE_2500BASEX:
-		phylink_decode_c37_word(state, lpa, SPEED_2500);
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+			phylink_decode_c37_word(state, lpa, SPEED_2500);
+		} else {
+			state->speed = SPEED_2500;
+			state->duplex = DUPLEX_FULL;
+			state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
+		}
 		break;
 
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
-		phylink_decode_sgmii_word(state, lpa);
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+			phylink_decode_sgmii_word(state, lpa);
 		break;
+
 	case PHY_INTERFACE_MODE_QUSGMII:
-		phylink_decode_usgmii_word(state, lpa);
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+			phylink_decode_usgmii_word(state, lpa);
 		break;
 
 	default:
-- 
2.30.2


