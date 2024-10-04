Return-Path: <netdev+bounces-132124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4012990849
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D111F22D95
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B11C726B;
	Fri,  4 Oct 2024 15:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D712C81F;
	Fri,  4 Oct 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057135; cv=none; b=cHqi/SorOaacqeq1m6KfRcHlV9vQiS2BzO1Fl5CH7N7yJ6Vv5x19rX6vf4vCuvtE/9CmVO86mtUMjlEYwGxnKvaZj9lhQiYxu6UVmMb1TtAhJiclOoaBfPeqJEVm1X5/17u90NXBttGIHB78mwDFevKj3TcGZU1lkZTvNP6PpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057135; c=relaxed/simple;
	bh=izWmkxzfoMRvkuKlP2NpzZGq/RrFuIXEq8KvqTeN6eQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YloNQ16+bqQJO+1pHuVNf5s4EJcsQChgJOnrVJB+yWIds+95d0M4VjgGXPblA3q0tTKg115Ssk5uG8bZIomkDm/LaB3G8xxAZb65vUNnMMO91NuaKsF8FuYZRMypSOCKHAD844E0oahbuNOxgudMqnrWvo1iK9bBDqxNdfqtioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swkbB-000000008I7-3Tst;
	Fri, 04 Oct 2024 15:52:09 +0000
Date: Fri, 4 Oct 2024 16:52:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: realtek: make sure paged read is
 protected by mutex
Message-ID: <792b8c0d1fc194e2b53cb09d45a234bc668e34c6.1728057091.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As we cannot rely on phy_read_paged function before the PHY is
identified, the paged read in rtlgen_supports_2_5gbps needs to be open
coded as it is being called by the match_phy_device function, ie. before
.read_page and .write_page have been populated.

Make sure it is also protected by the MDIO bus mutex and use
rtl821x_write_page instead of 3 individually locked MDIO bus operations.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 3941cfa1c5f2..c4d0d93523ad 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1030,9 +1030,11 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
 
-	phy_write(phydev, RTL821x_PAGE_SELECT, 0xa61);
-	val = phy_read(phydev, 0x13);
-	phy_write(phydev, RTL821x_PAGE_SELECT, 0);
+	mutex_lock(&phydev->mdio.bus->mdio_lock);
+	rtl821x_write_page(phydev, 0xa61);
+	val = __phy_read(phydev, 0x13);
+	rtl821x_write_page(phydev, 0);
+	mutex_unlock(&phydev->mdio.bus->mdio_lock);
 
 	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
-- 
2.46.2


