Return-Path: <netdev+bounces-158534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6CA1265A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C3168FA0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47619146A7A;
	Wed, 15 Jan 2025 14:43:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712B78C6C;
	Wed, 15 Jan 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952223; cv=none; b=u3OREcGYfWv6QzJL0Qz8CslfxWDa7t2geUCS3yTvf0TKrduxDxR7rkJfko6epdOerOvKFr+a5zWwBD8HtwLIp3msd5xhNwQfVM4vc91Qs9Sko3DK67/QOkFFKouz7cii4CvTerXWCffQ4SM3P3CypWZAwZNT7x51vBIZvBU4Dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952223; c=relaxed/simple;
	bh=wwxdpcLQVMX/FeBDgj0mXlU4TChQb6kQBWzp9h7YvTM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdS5I7lB1ngGOzoLvrFGwJdXCwUEkRB3toVw+Shheq/h28EntHrDSirr6dE46t1vdOkxYcjwCWd5F36GWFC0w8ULLsmE7TI06CEkFqZv6JAgWIlbwC14UlVdMoBECf73txRdHpPSACNSEKNDT1cXn+EWmq/xfix4zPVzvMsfGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tY4cM-00000000226-005g;
	Wed, 15 Jan 2025 14:43:38 +0000
Date: Wed, 15 Jan 2025 14:43:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: phy: realtek: clear 1000Base-T lpa if link is
 down
Message-ID: <67e38eee4c46b921938fb33f5bc86c8979b9aa33.1736951652.git.daniel@makrotopia.org>
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

Only read 1000Base-T link partner advertisement if autonegotiation has
completed and otherwise 1000Base-T link partner advertisement bits.

This fixes bogus 1000Base-T link partner advertisement after link goes
down (eg. by disconnecting the wire).
Fixes: 5cb409b3960e ("net: phy: realtek: clear 1000Base-T link partner advertisement")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f348e..26b324ab0f90 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1023,23 +1023,20 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 {
 	int ret, val;
 
-	ret = genphy_c45_read_status(phydev);
-	if (ret < 0)
-		return ret;
-
-	if (phydev->autoneg == AUTONEG_DISABLE ||
-	    !genphy_c45_aneg_done(phydev))
-		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
-
 	/* Vendor register as C45 has no standardized support for 1000BaseT */
-	if (phydev->autoneg == AUTONEG_ENABLE) {
+	if (phydev->autoneg == AUTONEG_ENABLE && genphy_c45_aneg_done(phydev)) {
 		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
 				   RTL822X_VND2_GANLPAR);
 		if (val < 0)
 			return val;
-
-		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+	} else {
+		val = 0;
 	}
+	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
 
 	if (!phydev->link)
 		return 0;
-- 
2.47.1

