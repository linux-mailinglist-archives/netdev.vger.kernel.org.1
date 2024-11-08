Return-Path: <netdev+bounces-143341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA959C2180
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4868B260BB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E57195980;
	Fri,  8 Nov 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1eXDnPDS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5C1957F8
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081731; cv=none; b=Cyfyp3bEPxKi5Y6AqWUbCtU5jyqQFX645cOkon8lg7G7+X6JPlsmpqIIAHkUT4pjJEcmo6Dol6GUBnwDQqtqKyZUYIdKnRuFDFe+XVo2JcSCXe1MZUlsYnYQWtNvssDfdvyJ90PuJoRRoWT2VnQS2qUU+VcAg4HqV5LgYvnQ+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081731; c=relaxed/simple;
	bh=tv5k0R4kEz3tOAem5oX0O/B+hKVh1mZh72XYl7yFdvI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VHKVEhInW2eIkW9qHkAEOqd1zOAv8f0E8VNLwBVLM1sZD0zbC8obRFJso0Fz426kqE5L3fURYWp5nad7Erh6RtBhSZ0MVdDJ5Cg73hzhosLYJ5MuNf1SAPoLftcfQsdUw7Q2gzlMm4BKGL48HvPeKtCsH1KDEMLTHJRjn556Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1eXDnPDS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RXOPMKI68I0nm6kL07Ir8wmbWUKvFch17HhVS8CWl6I=; b=1eXDnPDSU5cETCDwNcQbFmwQ46
	ywLOOEk8gUd4BzWgDb5bXsKY+lU7ljBJOBkqMyHRzM9ZwN5ovgql2wanX7gqg84X8tghgf0QRlFMh
	dNQ4/zS84/Dql0FxaKQ5xDRonEhCBtsPCvwgkP6tkPacCmILoFQSlYvrq9hMr2RJ18i3a87ZvJRFX
	PMhZW52oLhNcq1lgisWkm551jQcI7MaQfD3dAeL/+A7m2WqbLJzpaHehUsrxaIjA08s2tAVkmWaUE
	7oH5t2toJLzvttxWHHxDjAiBDAKGMLFmPitRGJxtHMFtqVKxDoUFumcavbd6zJ2QgEiwyB/lw89iE
	Z7VIFQHw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36632 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t9RQz-0005aZ-06;
	Fri, 08 Nov 2024 16:02:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t9RQz-002Ff5-EA; Fri, 08 Nov 2024 16:02:05 +0000
In-Reply-To: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 5/5] net: phylink: clean up phylink_resolve()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t9RQz-002Ff5-EA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Nov 2024 16:02:05 +0000

Now that we have reduced the indentation level, clean up the code
formatting.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index aaeb8b11e758..b1e828a4286d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1472,51 +1472,48 @@ static void phylink_resolve(struct work_struct *w)
 	} else {
 		phylink_mac_pcs_get_state(pl, &link_state);
 
-		/* The PCS may have a latching link-fail indicator.
-		 * If the link was up, bring the link down and
-		 * re-trigger the resolve. Otherwise, re-read the
-		 * PCS state to get the current status of the link.
+		/* The PCS may have a latching link-fail indicator. If the link
+		 * was up, bring the link down and re-trigger the resolve.
+		 * Otherwise, re-read the PCS state to get the current status
+		 * of the link.
 		 */
 		if (!link_state.link) {
 			if (cur_link_state)
 				retrigger = true;
 			else
-				phylink_mac_pcs_get_state(pl,
-							  &link_state);
+				phylink_mac_pcs_get_state(pl, &link_state);
 		}
 
-		/* If we have a phy, the "up" state is the union of
-		 * both the PHY and the MAC
+		/* If we have a phy, the "up" state is the union of both the
+		 * PHY and the MAC
 		 */
 		if (pl->phydev)
 			link_state.link &= pl->phy_state.link;
 
 		/* Only update if the PHY link is up */
 		if (pl->phydev && pl->phy_state.link) {
-			/* If the interface has changed, force a
-			 * link down event if the link isn't already
-			 * down, and re-resolve.
+			/* If the interface has changed, force a link down
+			 * event if the link isn't already down, and re-resolve.
 			 */
-			if (link_state.interface !=
-			    pl->phy_state.interface) {
+			if (link_state.interface != pl->phy_state.interface) {
 				retrigger = true;
 				link_state.link = false;
 			}
+
 			link_state.interface = pl->phy_state.interface;
 
-			/* If we are doing rate matching, then the
-			 * link speed/duplex comes from the PHY
+			/* If we are doing rate matching, then the link
+			 * speed/duplex comes from the PHY
 			 */
 			if (pl->phy_state.rate_matching) {
 				link_state.rate_matching =
 					pl->phy_state.rate_matching;
 				link_state.speed = pl->phy_state.speed;
-				link_state.duplex =
-					pl->phy_state.duplex;
+				link_state.duplex = pl->phy_state.duplex;
 			}
 
-			/* If we have a PHY, we need to update with
-			 * the PHY flow control bits.
+			/* If we have a PHY, we need to update with the PHY
+			 * flow control bits.
 			 */
 			link_state.pause = pl->phy_state.pause;
 			mac_config = true;
-- 
2.30.2


