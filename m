Return-Path: <netdev+bounces-75391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F188869B74
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5F41C210C2
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50719146910;
	Tue, 27 Feb 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J25mWs/N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8C146000
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049609; cv=none; b=O5J0o1Htuk0RqEsfbnWpZqyUkSppIbRg74+lBuF6iEXZDM5nLBXSDxPbBvCMjMqMon1yArcAIpq9HfC1KYrhdZeL0CpEzBwdcMiqZTEsGHFx1+pVazr1jnMQiWQ/hDioe7K9s7huVLREkxxFOdShSlNmvBgOzZ0FIfGgkXvrtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049609; c=relaxed/simple;
	bh=ViuZGX50JmEx2mAD00159MuafPAFKtq9bN4Yyy/BDA8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Nmvjj5Is/b67+rDBlqcSywy7m3Q0rB4qYpptPN2vxWzvGezaCzF8ecW3Jvox0j/GesyRv+g+6/jHX/73kduQ7rVqDjglJbcQmrIVHDPTeD5dAFSJlx+kfl43uA2XfiQLZ+alAtxR/0tfV0ygPK991StPwhE6Q4p+h13tV0Q3/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J25mWs/N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yLcx11rp2lBhYp1/lHqhayGTmf5wvxLufEInbcf5Cx0=; b=J25mWs/NJD7vWt14zalFVp4cE6
	Fr8cldINeByBrCPsIqKfdGvyQEDTrx1vzmIiWlpt9N1ET0qkJWlRqdi8i+Loodswle2nPkhzhxjjE
	BaEFldBxrYTi3n9LKTY1Rk2Z5gmDNqPK936/MTOKdTasnqUg0eYWchkLjB/ofg1MEndZQ4Z6Uxnj7
	82vlxqyGGYi6pLbF692vcD9DcHQ8r6aGg3Gz01XKRgLUPLuYKRceHjBHHrfgfO8S5O36vFS6s4UGa
	EemqTgniIxry4TPGOrpOsD7tsLQ9FtXOszDY5DSBl+0BZTFwHyunUIszY/T/dbBdxU1Si6g0b4z49
	DOqsDI8Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45040 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rezry-0000YC-1f;
	Tue, 27 Feb 2024 15:59:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rezry-003cXf-5f; Tue, 27 Feb 2024 15:59:50 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next] net: phy: marvell: add comment about
 m88e1111_config_init_1000basex()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rezry-003cXf-5f@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 27 Feb 2024 15:59:50 +0000

The comment in m88e1111_config_init_1000basex() is wrong - it claims
that Autoneg will be enabled, but this doesn't actually happen.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
The 88E1111 datasheet says that when changing HWCFG to 1100 (1000base-X
no AN) then one also needs to clear bit 12 in the fibre BMCR.
Furthermore, it says that in the Mode Switching chapter that when
switching the mode between 1000 and 1100, bit 12 of the fibre BMCR needs
to be manually updated.

However, the 88E1111 code doesn't do this, it just changes HWCFG and then
seems to hope for the best. Is this something which should be fixed?

 drivers/net/phy/marvell.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 1faa22f58366..42ed013385bf 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -919,7 +919,10 @@ static int m88e1111_config_init_1000basex(struct phy_device *phydev)
 	if (extsr < 0)
 		return extsr;
 
-	/* If using copper mode, ensure 1000BaseX auto-negotiation is enabled */
+	/* If using copper mode, ensure 1000BaseX auto-negotiation is enabled.
+	 * FIXME: this does not actually enable 1000BaseX auto-negotiation if
+	 * it was previously disabled in the Fiber BMCR!
+	 */
 	mode = extsr & MII_M1111_HWCFG_MODE_MASK;
 	if (mode == MII_M1111_HWCFG_MODE_COPPER_1000X_NOAN) {
 		err = phy_modify(phydev, MII_M1111_PHY_EXT_SR,
-- 
2.30.2


