Return-Path: <netdev+bounces-147418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747269D978A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3932F16736A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A081D1F6B;
	Tue, 26 Nov 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wiVdL77/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B481CB528
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625560; cv=none; b=kk4zZ3qnMCfuWlugfIu5DpF+932NUaWNfo3edUcXHvlqd0wYKGI/Ap6IKMFdo7N5B/5G8bIcpQTyN84LJP3zF8DuB4ebRsda0x1dIfbXNJ9AKwdsNV8FGLcV7iSyzR8/fE8tjceCx/3NBHEJ1urVeRABCBzUhyxoZcp6aollUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625560; c=relaxed/simple;
	bh=qg5W8XV2MCstAySc07sG7IU8nwE6JYV+/rhN3v8hoDA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nEuRKX78WJ83VSir3Rbk8b/0v4j+pd8MMNgWj+rONBxHHvQwZ7ugJO79HCH3Ksf5q2zshogvOsHGjJVIIVREillQlceJC/U6qtnqMSGbtRQ7/5U3K2ESZxVMLJLjV25EABXdTObPJfp3btjcbqFgKJYQ5pD6bzUx5YFGh34nPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wiVdL77/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LdW5Yx0SG3F8/WfyoFPcGHNk+kX/hW5pThNLPaZ3wWw=; b=wiVdL77/UavYrTh6C+a8AncCcR
	DOgwH9iZjeWOUj/8r9oCIq59JaKtilDrTJxehVLDoETTim5ARKuQSKYZvLEOhMyXl5ntSPeAcG3+f
	UjgjyAGxvaVCv+vF9KBstpBKD0u8QXSuvsW9owh4StGO8VqzlXfnIZh2paYneO2tF3TSYxpkKG+cA
	RR5NilUmrYekuDqcjsNRJLOZF+yElgL68/VKSvxVLi27bcD6t9KPG7qAmXJAWlcUbDWqHl/w+hSxl
	DCgJcE/Y+KqFiumwm5fD0yWUnTAd3EUspAFu7BULQ1n0vjz0OoF0I2PnapksmYDOGUJGOuHPtbejX
	RtdPikIg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48726 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3L-0006rx-2B;
	Tue, 26 Nov 2024 12:52:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3K-005yhZ-E8; Tue, 26 Nov 2024 12:52:26 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 03/23] net: phy: marvell: use
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
Message-Id: <E1tFv3K-005yhZ-E8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:26 +0000

Rather than calling genphy_c45_ethtool_get_eee() to retrieve whether
EEE is enabled, use the value stored in the phy_device eee_cfg
structure.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index cd50cd6a7f75..1d117fa8c564 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1508,7 +1508,6 @@ static int m88e1540_get_fld(struct phy_device *phydev, u8 *msecs)
 
 static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
 {
-	struct ethtool_keee eee;
 	int val, ret;
 
 	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
@@ -1518,8 +1517,7 @@ static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
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


