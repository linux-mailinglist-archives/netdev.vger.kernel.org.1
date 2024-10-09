Return-Path: <netdev+bounces-133410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B69E6995D76
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C51F25BC2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117D1E49F;
	Wed,  9 Oct 2024 01:54:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CD4084D;
	Wed,  9 Oct 2024 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438891; cv=none; b=oUVa4TFERWTAPgLXPgfXdGCc34ngLCqirbHPLf2M4nbKS+JwxPsvVta54jOIgrd1a4Qj65rdYeLdAUyZUYZndPFUjVWHf1AK9Ce5N/UxfSpoX+C6AcSuIREY9aQmoWNm8HryRxshT24xsfJ/K8PRVT4RqNtjtpfz2aTdcfwj36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438891; c=relaxed/simple;
	bh=3C8O1PAu44Cvvhh+q7cPn0mbyFC6tQ09mhZZ0xN7ga4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TltUiRWI1KeRL7yoVhfmEju6Aw8WDK04gWIR9k9iTFNS6f0vBBj9P58dR6UE4D5P7uzIxwavH3/PDfeGWE1t5iVwG0xbqPXiB8a4tVwwQo3bES6kobhAU8X7LWHzvK+eBdLMqZTDlnZU0O2mlBIKYzffKTrShoVk+n9JxxzjXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syLuY-000000003HX-1Yqf;
	Wed, 09 Oct 2024 01:54:46 +0000
Date: Wed, 9 Oct 2024 02:54:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: phy: realtek: change order of calls in C22
 read_status()
Message-ID: <60787816b201fbdd093e0de31e2c5c780ea7678f.1728438615.git.daniel@makrotopia.org>
References: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>

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
index 717284a71667..895008738ec0 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -956,17 +956,25 @@ static void rtl822xb_update_interface(struct phy_device *phydev)
 
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

