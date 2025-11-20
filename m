Return-Path: <netdev+bounces-240412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D79C7483B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 082D634F122
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8933EB17;
	Thu, 20 Nov 2025 14:17:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA8296BBB;
	Thu, 20 Nov 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648255; cv=none; b=rWxVT2Jf5XCpeNVEZi111QOSEEPxvUSk/y0a5n3yVnQsVtOZkz5GUiWsiZmsuyT03SkS55NVc8xTC5hWo7a3fEinVQSqkXT+uEsTNHVVdJfZgKFSU0rrD9i36F2PiRmEtYlh2UevMaBA1RsgAZfCqrY1alT8tWhqwtwhRQHPMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648255; c=relaxed/simple;
	bh=8LKrdJ4ZKkAEZnN8+Iyb26NauZMgTMJmm4GgPPiy9FE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tFpO4F3ddkcINotloTMh7wjIO0PCOF9hD9aiKP91NHgIGPGJJRWCs2YmmBSMtCev2KkQJ/AS4EeQAQG8CgxbdD5Wxl+NVNqipJRXKWb3nbY0OVVr2VGU001WvScE6On1jEiLnnkLcBbox3sFakqrnA8Zq153Dojkp5sLvKB86iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vM5TI-000000007eW-27IJ;
	Thu, 20 Nov 2025 14:17:16 +0000
Date: Thu, 20 Nov 2025 14:17:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: mxl-gpy: fix bogus error on USXGMII and
 integrated PHY
Message-ID: <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As the interface mode doesn't need to be updated on PHYs connected with
USXGMII and integrated PHYs, gpy_update_interface() should just return 0
in these cases rather than -EINVAL which has wrongly been introduced by
commit 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface()
function return type"), as this breaks support for those PHYs.

Fixes: 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface() function return type")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 0daf0e86844a0..0058284b08f3b 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -541,7 +541,7 @@ static int gpy_update_interface(struct phy_device *phydev)
 	/* Interface mode is fixed for USXGMII and integrated PHY */
 	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
 	    phydev->interface == PHY_INTERFACE_MODE_INTERNAL)
-		return -EINVAL;
+		return 0;
 
 	/* Automatically switch SERDES interface between SGMII and 2500-BaseX
 	 * according to speed. Disable ANEG in 2500-BaseX mode.
-- 
2.51.2

