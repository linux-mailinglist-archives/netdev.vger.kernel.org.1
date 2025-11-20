Return-Path: <netdev+bounces-240428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A0C74C0F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D92E363630
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A72E9759;
	Thu, 20 Nov 2025 15:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CE2C08BB;
	Thu, 20 Nov 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650953; cv=none; b=Nxkmig1Ut3V+NHUHxLhKXtesXHKGDdnWGto0FWCOtwvF7rvJNNs85MhGzh7kIOR0umh+pktfzElr3es/iSruVc9QqZeRbIezrN6IlQCVOAYVoR0DSy56a0CHCMYfDUJwcz7lFekA0LGrN+9kpnqWbAF4KtLw4e70AizI34to8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650953; c=relaxed/simple;
	bh=ohxnMMil76nOC/j9QLze1X0V3va0leE/Dj2yQkVJUPE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DeEaRGrX67PPLU/MGlb/PF5Yv3BfqIlOH+PnfFqK1W5LpTHvBePRDBkuWQuuV0RxssoJGc1XDPEmM3RBNbj6Oh9GKLKzKaZKF6N/BIMZfuR92naO8ci56FPKIbbSNHI3dYxs5hROoKa6gIQaX2nSrWR7sTRO6gbkNZdN6mDNywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vM6Aw-000000007uc-48mS;
	Thu, 20 Nov 2025 15:02:23 +0000
Date: Thu, 20 Nov 2025 15:02:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: mxl-gpy: fix link properties on USXGMII and
 internal PHYs
Message-ID: <71fccf3f56742116eb18cc070d2a9810479ea7f9.1763650701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gpy_update_interface() returns early in case the PHY is internal or
connected via USXGMII. In this case the gigabit master/slave property
as well as MDI/MDI-X status also won't be read which seems wrong.
Always read those properties by moving the logic to retrieve them to
gpy_read_status().

Fixes: fd8825cd8c6fc ("net: phy: mxl-gpy: Add PHY Auto/MDI/MDI-X set driver for GPY211 chips")
Fixes: 311abcdddc00a ("net: phy: add support to get Master-Slave configuration")
Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 221b315203d06..2a873f791733a 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -578,13 +578,7 @@ static int gpy_update_interface(struct phy_device *phydev)
 		break;
 	}
 
-	if (phydev->speed == SPEED_2500 || phydev->speed == SPEED_1000) {
-		ret = genphy_read_master_slave(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
-	return gpy_update_mdix(phydev);
+	return 0;
 }
 
 static int gpy_read_status(struct phy_device *phydev)
@@ -639,6 +633,16 @@ static int gpy_read_status(struct phy_device *phydev)
 		ret = gpy_update_interface(phydev);
 		if (ret < 0)
 			return ret;
+
+		if (phydev->speed == SPEED_2500 || phydev->speed == SPEED_1000) {
+			ret = genphy_read_master_slave(phydev);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = gpy_update_mdix(phydev);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
-- 
2.51.2

