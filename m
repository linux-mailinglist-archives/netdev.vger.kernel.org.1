Return-Path: <netdev+bounces-158537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C31A12664
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C647E163DB6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA101448E3;
	Wed, 15 Jan 2025 14:45:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6586351;
	Wed, 15 Jan 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952309; cv=none; b=uAOsgjCi2fXRAZcRAWDYRTTKWdJJokQwRlvL/889RKxwnAT1N4zzHuj7KMAQ3b5pXF8wFn3ka+e8Il+r0u9wZeLPcaJfBTnxFi9yvxdbikG8SfanfaXNJdXkCxgqcWFu57xPHwwDM++Yb17BB9QD/MJxposcN5CMOx1Eio6Tww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952309; c=relaxed/simple;
	bh=PKoLj1+pfi203+5tnce30xBjEeHcsamzYTmOV6+rSww=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeq365SDk7CCssAs1zByr+KlaspAkyFOcQisUMoAeFVFgiKaZDfakJHrtbaYOjXh4Gk2pTHmXptj9EtQz4KxEdPylU5TUGpMgswDcapRhc5C2M+NthCAw0Mm8ga02R0qmZraaxSd183iSSOvG0uIOflFjckaG+G/2S4jVCsQsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tY4dj-0000000023r-1053;
	Wed, 15 Jan 2025 14:45:03 +0000
Date: Wed, 15 Jan 2025 14:45:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: phy: realtek: always clear NBase-T lpa
Message-ID: <566d4771d68a1e18d2d48860e25891e468e26551.1736951652.git.daniel@makrotopia.org>
References: <cover.1736951652.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736951652.git.daniel@makrotopia.org>

Clear NBase-T link partner advertisement before calling
rtlgen_read_status() to avoid phy_resolve_aneg_linkmode() wrongly
setting speed and duplex.

This fixes bogus 2.5G/5G/10G link partner advertisement and thus
speed and duplex being set by phy_resolve_aneg_linkmode() due to stale
NBase-T lpa.

Fixes: 68d5cd09e891 ("net: phy: realtek: change order of calls in C22 read_status()")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 93704abb6787..9cefca1aefa1 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -952,15 +952,15 @@ static int rtl822x_read_status(struct phy_device *phydev)
 {
 	int lpadv, ret;
 
+	mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+
 	ret = rtlgen_read_status(phydev);
 	if (ret < 0)
 		return ret;
 
 	if (phydev->autoneg == AUTONEG_DISABLE ||
-	    !phydev->autoneg_complete) {
-		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+	    !phydev->autoneg_complete)
 		return 0;
-	}
 
 	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
 	if (lpadv < 0)
-- 
2.47.1

