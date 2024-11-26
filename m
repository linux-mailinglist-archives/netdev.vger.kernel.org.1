Return-Path: <netdev+bounces-147421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 429889D978F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F70B2632B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16181D3564;
	Tue, 26 Nov 2024 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wX1MOib1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9D194A66
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625574; cv=none; b=MGZcGCE27UT9owE4I4pcGkuQ1a5xR5YmhfrcSCwsgVcZPVXYAjKrwGhnJ4ZTx3fiI3Z9mrwvmaOZRTaKQgPjoXJosaUrqGD0NPr+QMIlfHTAC2/BV/j+dT3cwyf1CghNzaiBiWVum6yh797CCayC+jgspnrXg5vG+p+mZFxyaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625574; c=relaxed/simple;
	bh=VS1Jn0MKxK896HY0QyRsfm/vGGkWNaU0l71PD3kt0Vk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=epmkLtfpt8l9Js38GOBuL4DId/JNBWME/610gbakAStQqXahT9cRdxjyTcy8jyonVM5WENbL5VqNoMOozV9lcdxlkU7QShu0pNSrnXETXM/LgcuzEqxlk1OGJnIUnNymL3BI2YiUkrR/I48qbPrGZcJ7LLNnBFKZ/yCUXvP3DzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wX1MOib1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hM2Me0R442AO8DdVkavZVZg2yJn2icgsmunMOQ2V1M8=; b=wX1MOib1+DBlN4WWej5Q/tAJhg
	REEjg+iOgD99ePnruIdxN3PHit10xMAL0SCEtX+1ivn5+3Uig2LSQ7jWOTTLZZ3tP7mvEOYaDx3MI
	w7RqcHlIQ0DpabuMDYzrm40JdYp6B1sMSVu+94MOTjjVIRaqDMWZd1oT6Ii3Y4GKske7T09MbDKMl
	Xr/pZblsQCeWm6dQay6GbIVcjKMa3Bgo/2ppNP4ePpIoQbvn31CTVkFIoG/pIQhwqtNEua1/fpAAW
	p6ClYCvzdA9pA4C9QW4ymb6YPqSh0JcfGk3XfCTw03tcaHi7LQxY3PNpnYgaKnryQcbdHxuv4O6O+
	fGhRk24Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34386 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3a-0006sx-2x;
	Tue, 26 Nov 2024 12:52:43 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3Z-005yhr-Os; Tue, 26 Nov 2024 12:52:41 +0000
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
Subject: [PATCH RFC net-next 06/23] net: phy: update phy_ethtool_get_eee()
 documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3Z-005yhr-Os@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:41 +0000

Update the phy_ethtool_get_eee() documentation to make it clear that
all members of struct ethtool_keee are written by this function.

keee.supported, keee.advertised, keee.lp_advertised and keee.eee_active
are all written by genphy_c45_ethtool_get_eee().

keee.tx_lpi_timer, keee.tx_lpi_enabled and keee.eee_enabled are all
written by eeecfg_to_eee().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 18109f843e39..8caef54a60e0 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1648,8 +1648,8 @@ EXPORT_SYMBOL(phy_get_eee_err);
  * @phydev: target phy_device struct
  * @data: ethtool_keee data
  *
- * Description: reports the Supported/Advertisement/LP Advertisement
- * capabilities, etc.
+ * Description: get the current EEE settings, filling in all members of
+ * @data.
  */
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
-- 
2.30.2


