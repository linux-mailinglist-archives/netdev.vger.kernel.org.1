Return-Path: <netdev+bounces-134222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598FD998723
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A97B1C23D41
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088041C9DD3;
	Thu, 10 Oct 2024 13:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857951C9DD2;
	Thu, 10 Oct 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565653; cv=none; b=rpLDxnQXJmgBXqKvvynfnOnC7gHSjJkYoxyjqnQs8AbNMOgvtJVBx9YSCaz2DeEvibZsNFoIKU8AoBdLvbq4pwd6tf+Q4l3GV+4Ute68MTEQQHOTcNLLshJfpsSvuVfhjSVU5ZRvjrEBAWWt7WqdobrVPlvY2t1TUrATPotPJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565653; c=relaxed/simple;
	bh=CWA+RUY+gmucXxC1SBH3sCdIavkh6AfQSTJyM97pcSo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5+Zr+qhgtvjNB8HMdSoGGw7qivn6GarFlpXi7ZKIh3deAvT8UPDk7R8k86xdy0m+JbZSspdNaKJr2qLu3bB6JYPHvgeiApiVwAJzWz1THLgmaYrmXYOgBYL7RNHZmsJb37EU1Eu0MZ8OgAOMsKaOuzVB8JLXUS5udDatA5E9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syst7-000000003Fv-0wjd;
	Thu, 10 Oct 2024 13:07:29 +0000
Date: Thu, 10 Oct 2024 14:07:26 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: phy: realtek: change order of calls in
 C22 read_status()
Message-ID: <b15929a41621d215c6b2b57393368086589569ec.1728565530.git.daniel@makrotopia.org>
References: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>

Always call rtlgen_read_status() first, so genphy_read_status() which
is called by it clears bits in case auto-negotiation has not completed.
Also clear 10GBT link-partner advertisement bits in case auto-negotiation
is disabled or has not completed.

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 9bbbbad1ca5a..831089583845 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -949,17 +949,25 @@ static void rtl822xb_update_interface(struct phy_device *phydev)
 
 static int rtl822x_read_status(struct phy_device *phydev)
 {
-	if (phydev->autoneg == AUTONEG_ENABLE) {
-		int lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
+	int lpadv, ret;
 
-		if (lpadv < 0)
-			return lpadv;
+	ret = rtlgen_read_status(phydev);
+	if (ret < 0)
+		return ret;
 
-		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
-						  lpadv);
+	if (phydev->autoneg == AUTONEG_DISABLE ||
+	    !phydev->autoneg_complete) {
+		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+		return 0;
 	}
 
-	return rtlgen_read_status(phydev);
+	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
+	if (lpadv < 0)
+		return lpadv;
+
+	mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, lpadv);
+
+	return 0;
 }
 
 static int rtl822xb_read_status(struct phy_device *phydev)
-- 
2.47.0

