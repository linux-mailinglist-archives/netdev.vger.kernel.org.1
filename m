Return-Path: <netdev+bounces-107640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1119B91BCAE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DA21C2215D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B285152530;
	Fri, 28 Jun 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VnReDcvL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1B14A60A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570740; cv=none; b=fgfiZLNPY9rqfWcErVhGJhr0FUG0FArrQ+7zqoCdfviPsG6c1uxWmQOj8s88ELptDyInMIyJ/VRQ34sa3gkpbeVYhBiplEDka3SbbCD+GLSXvncp2hClBfIwtOAUgWm/7Uk5nHG1GsWxcynoHaxrdbpEvebwlJcUkP9d+Qcy3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570740; c=relaxed/simple;
	bh=oKxmadcOiC0OmWTso0/jMCB25X8yuZ11jOcq8uvKtuc=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=ZMTwG3ASw2HdjeGIHAZDTIkFRBrVnRdw2pChC38rcwRX4qnwUmaFc54vGlPdykTiGtukK7VOWrfRB9qUp3bhotkkxugWcPwHXp71AXGWLnmqd4H1PbSMYEI9JmcrXfIH9NmFxeVt5Y39QbGz9U98fMW0zA0mqiOnwMLX1RJGOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VnReDcvL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=87vA3uzi5c7jDtiTvLydvZfuR3BLcvEj+sYNTVkGX5Q=; b=VnReDcvLA7Quq+yf2p9WR81yHD
	/G/XwTTgI6ISdRcwJwOmccYYXMXV1NLyUyKGTLYvE/xjdceUl4b7p1aOTGIrFmARXKRedLjqvfLAm
	Xagg91ZRS6KPJns5HaZcp9kWBJ2x151cRuTL4K8d8IAWj4uygRZ8RwwRQDomf3C+Vr4/hEMKuB3iy
	G3zm15WefXljM4AVqPjKp5GfYFI7M2LdjGFlg2hCOZSvNTiGqa9fhFkMY48Q4muGQN6N1pGRGjWT0
	GI39SO3XFYaT+nZKHRf+egidjHGkeGuBxP8epgfiHOnEeyrWy6qm5Zll3hi2/fPL/EhcQQwOK7+cz
	tbCS+Cgw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36860 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sN8tj-0006MY-2R;
	Fri, 28 Jun 2024 11:32:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sN8tn-00GDCZ-Jj; Fri, 28 Jun 2024 11:32:11 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: phy: fix potential use of NULL pointer in
 phy_suspend()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 28 Jun 2024 11:32:11 +0100

phy_suspend() checks the WoL status, and then dereferences
phydrv->flags if (and only if) we decided that WoL has been enabled
on either the PHY or the netdev.

We then check whether phydrv was NULL, but we've potentially already
dereferenced the pointer.

If phydrv is NULL, then phy_ethtool_get_wol() will return an error
and leave wol.wolopts set to zero. However, if netdev->wol_enabled
is true, then we would dereference a NULL pointer.

Checking the PHY drivers, the only place that phydev->wol_enabled is
checked by them is in their suspend/resume callbacks and nowhere else
(which is correct, because phylib only updates this in phy_suspend()).

So, move the NULL pointer check earlier to avoid a NULL pointer
dereference. Leave the check for phydrv->suspend in place as a driver
may populate the .resume method but not the .suspend method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..19f8ae113dd3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1980,7 +1980,7 @@ int phy_suspend(struct phy_device *phydev)
 	const struct phy_driver *phydrv = phydev->drv;
 	int ret;
 
-	if (phydev->suspended)
+	if (phydev->suspended || !phydrv)
 		return 0;
 
 	phy_ethtool_get_wol(phydev, &wol);
@@ -1989,7 +1989,7 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
 
-	if (!phydrv || !phydrv->suspend)
+	if (!phydrv->suspend)
 		return 0;
 
 	ret = phydrv->suspend(phydev);
-- 
2.30.2


