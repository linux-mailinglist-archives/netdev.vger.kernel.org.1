Return-Path: <netdev+bounces-134232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D6998762
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801A82890A4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3ED1C5781;
	Thu, 10 Oct 2024 13:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889ED19E7D0;
	Thu, 10 Oct 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566283; cv=none; b=pSheX+/pSTz24+dbnVCWMmjJWtPIx769diJy2QMCzMGWht+j3Cb1HDv9TWMFJXWW2Dg9H+1QEitAt3NG8q9nLczomtaFWL8eI+U1+F0BgCZ7iKWTlsMgK4LIfs3GtSdQ1mQNGAC8Ec/pKbE8KJYOLuVYnt1JR9Xh7Ilfka29zIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566283; c=relaxed/simple;
	bh=pmZkziTP4H04NCTyV/VABVeRU1eoGGt+z+UFFzzgfWs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R+j8yMM/jOct6Pib/H6tqk8m7aew92NhOtI7rnDEL+mrzkCZJ0nUs4ck7+TksrXik3XNQD7PEvZxB8c1/QN7Re1NV0knLrQMcbl2E9CgAcDOD9GDwdIxk9pKMha4JKL+oLKMfXXhBHCa9KmmivMi9k5sksgPQ709QU84OKJisOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syt3E-000000003Js-3884;
	Thu, 10 Oct 2024 13:17:56 +0000
Date: Thu, 10 Oct 2024 14:17:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: phylink: allow half-duplex modes with RATE_MATCH_PAUSE
Message-ID: <d6c1a15cdf2596c2f68eab912c79635854cede9b.1728566181.git.daniel@makrotopia.org>
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

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

