Return-Path: <netdev+bounces-158323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B51A11633
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE0166621
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21717BD9;
	Wed, 15 Jan 2025 00:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849A35955;
	Wed, 15 Jan 2025 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901990; cv=none; b=IXfMSBlOqdntZKlE542T618bbY5ufWUjgXAd9302yWL6PP9cEXLXC7I0E7xPeShH0bl5X9PfO7u4+lAPG3NRB2Hlye8M+vqagaBVyG5GPxe6+PJCgPgzw8O5Yon/LWGhZZM3mlWCwxU5lUCad2+m9RRJOb870sAElCY+VzM8+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901990; c=relaxed/simple;
	bh=zEkCb3U0z3Zufn3PSL6wqGqv05fQweYTUgQHddW1Z/Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZaMMCKyOY0tM7FMX26OcQYAHeR9Mt/Gm12XdvaDQA6NQxJorMkePiCI1LNkkLjzb1wnF9m0mznUMlQiSENqvnTdgPwjoBs5mUYhidSsyYpGYxhmqr8tRlXGTVZtbufQOCVoKhtkFI+zjuwq6EAtHkWVYxPq6vRLBcpf9gj6hV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tXrY2-000000005Ye-1gaU;
	Wed, 15 Jan 2025 00:46:18 +0000
Date: Wed, 15 Jan 2025 00:46:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: realtek: clear status if link is down
Message-ID: <229e077bad31d1a9086426f60c3a4f4ac20d2c1a.1736901813.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Clear speed, duplex and master/slave status in case the link is down
to avoid reporting bogus link(-partner) properties.

Fixes: 5cb409b3960e ("net: phy: realtek: clear 1000Base-T link partner advertisement")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f348e..3f0e03e2abce 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -720,8 +720,12 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	if (!phydev->link)
+	if (!phydev->link) {
+		phydev->duplex = DUPLEX_UNKNOWN;
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+		phydev->speed = SPEED_UNKNOWN;
 		return 0;
+	}
 
 	val = phy_read_paged(phydev, 0xa43, 0x12);
 	if (val < 0)
@@ -1028,11 +1032,11 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 		return ret;
 
 	if (phydev->autoneg == AUTONEG_DISABLE ||
-	    !genphy_c45_aneg_done(phydev))
+	    !genphy_c45_aneg_done(phydev) ||
+	    !phydev->link) {
 		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
-
-	/* Vendor register as C45 has no standardized support for 1000BaseT */
-	if (phydev->autoneg == AUTONEG_ENABLE) {
+	} else {
+		/* Vendor register as C45 has no standardized support for 1000BaseT */
 		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
 				   RTL822X_VND2_GANLPAR);
 		if (val < 0)
@@ -1041,8 +1045,12 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
 	}
 
-	if (!phydev->link)
+	if (!phydev->link) {
+		phydev->duplex = DUPLEX_UNKNOWN;
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+		phydev->speed = SPEED_UNKNOWN;
 		return 0;
+	}
 
 	/* Read actual speed from vendor register. */
 	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
-- 
2.47.1


