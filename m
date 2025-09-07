Return-Path: <netdev+bounces-220690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C5B47FEE
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E573C3DCC
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7227FB0E;
	Sun,  7 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n/ZOmyrZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390E4315A
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277850; cv=none; b=Bgpb151ixq3tkCSajMv5ze9quM5UwLoIHdXPth5+qOU6f8lbWyi0oym8q5S4HOyhe2E/0n98uAKK02Gmne6io80CvMIFHF64jMzkdqF718v+LM+Sbac6xbd/0U5H3OT2lciWpCIIOezHp3YywfIA1CmyV+cw+JLmQawo1oRRSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277850; c=relaxed/simple;
	bh=1SzYHmUfMiOAPyVfA1xoClg2pS6aBVqdehtrj2bPPT8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=TT2g4BKg2iSCF8TcXQz/I3uoa16/7wdAA2GuvOBQnIQyVgpZPT6/acQ0ltcjhghpPPdPxJewHRYtO6esLeaou7XIAeAdMApjox5vzlP9UXR3HbZ7wRjhZNMWyxa0vQoYauwRfnwOB55AL6nXeE5VeEjHFVmi7xEv0a+gWrpzqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n/ZOmyrZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nQr8pDGvJqG8Ks79KRR43ZWQUQciHWRvkcNT72VdUps=; b=n/ZOmyrZndPTcH3+SvTPrqc7b4
	JcHNlL6yfLEUyO6sJyDmkGfwFi5MrF4cEfXHHUH1wKQwUy66hIq6rMA1q/uUA7g/2U5b2iQL0DN8r
	UtSCnylbQuC2P7PGK61Kbt3PuEosBeaFJjfSNzmEfZJYUELuXPRHdMG8lHgr3d/x3tj8JMljpI9Ah
	IpO4zVVB37RfBEkw5b/9IoxLBZhLUshymGVyPP0G+4jHt4VKEDd2cpROaDevVykQ+s6GuOkfbma1/
	SLN52T+Ktq9LVyo9tKE9NmWJl3ydGnHm2d3qxm8hCkiYEHEV41a+tO7WEhE2nbcCBvo8yBBpKlxuo
	YhdfbbrA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53836 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uvMF0-000000005ei-3Gtm;
	Sun, 07 Sep 2025 21:44:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uvMEz-00000003Aoe-3qWe;
	Sun, 07 Sep 2025 21:44:01 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net] net: phy: fix phy_uses_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 07 Sep 2025 21:44:01 +0100

The blamed commit changed the conditions which phylib uses to stop
and start the state machine in the suspend and resume paths, and
while improving it, has caused two issues.

The original code used this test:

	phydev->attached_dev && phydev->adjust_link

and if true, the paths would handle the PHY state machine. This test
evaluates true for normal drivers that are using phylib directly
while the PHY is attached to the network device, but false in all
other cases, which include the following cases:

- when the PHY has never been attached to a network device.
- when the PHY has been detached from a network device (as phy_detach()
   sets phydev->attached_dev to NULL, phy_disconnect() calls
   phy_detach() and additionally sets phydev->adjust_link NULL.)
- when phylink is using the driver (as phydev->adjust_link is NULL.)

Only the third case was incorrect, and the blamed commit attempted to
fix this by changing this test to (simplified for brevity, see
phy_uses_state_machine()):

	phydev->phy_link_change == phy_link_change ?
		phydev->attached_dev && phydev->adjust_link : true

However, this also incorrectly evaluates true in the first two cases.

Fix the first case by ensuring that phy_uses_state_machine() returns
false when phydev->phy_link_change is NULL.

Fix the second case by ensuring that phydev->phy_link_change is set to
NULL when phy_detach() is called.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

v2: updated commit description

 drivers/net/phy/phy_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7556aa3dd7ee..c82c1997147b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -287,8 +287,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
 	if (phydev->phy_link_change == phy_link_change)
 		return phydev->attached_dev && phydev->adjust_link;
 
-	/* phydev->phy_link_change is implicitly phylink_phy_change() */
-	return true;
+	return !!phydev->phy_link_change;
 }
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
@@ -1864,6 +1863,8 @@ void phy_detach(struct phy_device *phydev)
 		phydev->attached_dev = NULL;
 		phy_link_topo_del_phy(dev, phydev);
 	}
+
+	phydev->phy_link_change = NULL;
 	phydev->phylink = NULL;
 
 	if (!phydev->is_on_sfp_module)
-- 
2.47.3


