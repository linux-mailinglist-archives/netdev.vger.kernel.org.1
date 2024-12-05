Return-Path: <netdev+bounces-149336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230EB9E52B5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50E52845BB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853C1D8E07;
	Thu,  5 Dec 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CLrsY50m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAAC2066DC
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395328; cv=none; b=tizLZRaLBu1LiXPzJSGgL1IF++6uvHZjCoomABCynN0LHPKf+0aN57bm4YsPh3OgyyaSoh7dqM6Kufo8K4e6jL4OFqw7R88czc0EkyalOT8inxaFKcaQjW3eddpy/sMtFXN4aGamSUeyVCSQdzSZRe0GBxpW/Pw37zPA4gNQHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395328; c=relaxed/simple;
	bh=QvdO7owUx/YNgQYlG/LBwXGDTRze+7KFuxgE/tMRLvM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uesgA4kuVeBvCkz+tFLCU1uXVI/RMEK3BmchYE9YleeZVI4SL2TFhmtbiQeucChkJiYD57GLiN+IJLVovRDUxDGtt2ruEhTryYNWLXToCpQcSILLQ9+Lu/94AuYKzbS+k6+taILXMO3G6E9oTEd0fVXKMCjvsSvFaXIMxMPhLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CLrsY50m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VHD6rFXzAf1AN1hsTtXdN7tejBP2h79eMxrw+YRAJ1U=; b=CLrsY50m9lPcqtnQCEedBraIhZ
	ZBRw7H5FWa6xet9jrWWxDVEzuZV9y/toNzeEPEL9QvA5EvnEtukAWPAiKOtDaMfZ12htSfBbEPt09
	GHGjZep9qiUDlYUTWj0u0dRiRCEwARV6ZXuKFXxifkSqdz36AIvBjpduc/MTUsMlb6DcA1cK8tFsP
	xwywlKp/D5bSG/v0gdDXY+HuIC+wEVXi/gPZ/7qYDs97iPyYDZcQr82g4xSaXwiAq/SBufBWjm7xm
	gusyJdWIrBVpg3GWam0cnAx0wRmgiL0fzh8aatYqJT8PUgQPnOXSIfASKBMpMH/9aEGJO6snPq/gQ
	ydxt+0xA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46314 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ9J3-0004ZW-2q;
	Thu, 05 Dec 2024 10:42:02 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ9J2-006LIh-Fl; Thu, 05 Dec 2024 10:42:00 +0000
In-Reply-To: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/4] net: phy: marvell: use
 phydev->eee_cfg.eee_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ9J2-006LIh-Fl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 10:42:00 +0000

Rather than calling genphy_c45_ethtool_get_eee() to retrieve whether
EEE is enabled, use the value stored in the phy_device eee_cfg
structure.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index b885bc0fe6e0..ffe223ad9e5f 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1550,7 +1550,6 @@ static int m88e1540_get_fld(struct phy_device *phydev, u8 *msecs)
 
 static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
 {
-	struct ethtool_keee eee;
 	int val, ret;
 
 	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
@@ -1560,8 +1559,7 @@ static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
 	/* According to the Marvell data sheet EEE must be disabled for
 	 * Fast Link Down detection to work properly
 	 */
-	ret = genphy_c45_ethtool_get_eee(phydev, &eee);
-	if (!ret && eee.eee_enabled) {
+	if (phydev->eee_cfg.eee_enabled) {
 		phydev_warn(phydev, "Fast Link Down detection requires EEE to be disabled!\n");
 		return -EBUSY;
 	}
-- 
2.30.2


