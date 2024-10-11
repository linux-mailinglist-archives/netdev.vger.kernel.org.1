Return-Path: <netdev+bounces-134460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F01999B3B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 05:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA02B22E26
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8B1F12FB;
	Fri, 11 Oct 2024 03:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84A3EA64;
	Fri, 11 Oct 2024 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618058; cv=none; b=Hb/pQUWitICWi6GMqAcSRaSMMOE3lkCZuLabIUSaxaA7Q9iljw0AJE7vqFeZebKNyF+Y80+UuPNutMKWlC+p56UGf++hpklkDkIg/4aj3zsx732peSfn1mmHAu57nx0S4mrEdVOXwVQOgQzrVVyL02dfdB+olENuujYERuvb9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618058; c=relaxed/simple;
	bh=KZPa446WxeR67uYXzBnlKdTnG1LF2eiLhWpos9Ht3WI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FZXk1QueP+s2klY9MwtEPBuncoJWJFYQndLXYry19qt5aoXezDcU8r4k6S4MkLHhcB0CqCoIaLo5HHZz/VajEwGUxBRDMJLk77xUhbREzv0uexPhEfRvP8+6MFVDYoCRKIgaKafuJzkRRc9Iwx+9KBUcnEoGgdwCe7riyRGNTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sz6WF-000000006aB-0iGR;
	Fri, 11 Oct 2024 03:40:47 +0000
Date: Fri, 11 Oct 2024 04:40:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phylink: allow half-duplex modes with
 RATE_MATCH_PAUSE
Message-ID: <b157c0c289cfba024039a96e635d037f9d946745.1728617993.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

PHYs performing rate-matching using MAC-side flow-control always
perform duplex-matching as well in case they are supporting
half-duplex modes at all.
No longer remove half-duplex modes from their capabilities.

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: Fix Suggested-by: tag

 drivers/net/phy/phylink.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4309317de3d1..24a3144e870a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -599,15 +599,8 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 		 * max speed at full duplex.
 		 */
 		if (mac_capabilities &
-		    phylink_cap_from_speed_duplex(max_speed, DUPLEX_FULL)) {
-			/* Although a duplex-matching phy might exist, we
-			 * conservatively remove these modes because the MAC
-			 * will not be aware of the half-duplex nature of the
-			 * link.
-			 */
+		    phylink_cap_from_speed_duplex(max_speed, DUPLEX_FULL))
 			matched_caps = GENMASK(__fls(caps), __fls(MAC_10HD));
-			matched_caps &= ~(MAC_1000HD | MAC_100HD | MAC_10HD);
-		}
 		break;
 	}
 	case RATE_MATCH_CRS:
-- 
2.47.0


