Return-Path: <netdev+bounces-147425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583259D979D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F141285C7A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC331D318F;
	Tue, 26 Nov 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rjwn3XIL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490E1D2F54
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625597; cv=none; b=Nm8kiefxnu6KPRlO8Nzsu2cxOa02YeTei3xpayS7GCmL8DAdtzRoJHzro+ZbA+PYwXAQdvSKx6t7iHCAnT6UZLdxvalVZ7+oypqybVOCg7Cwq2aVjlZghCjpeTyGBgPTEzruiKKi9L1EgOAo5xnA2SxmGkCjRobKa0mk7gqBZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625597; c=relaxed/simple;
	bh=FXtqTwTRu+TzZldDZB4+VwSJYaeSIAw8r1aOm9yArdU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qHLf0v4VLgF9fn+8bYX6M094BWLHEbO9WEXwUPTWL7h6E0aRneLYL2mB52vJTTbLdqjcggd8HqHXZxr+/0+Qqva5Xvhh6mjZal+TrG9FsI/mo6tDcRI68/W6i19yG2mYodPImI4wY4+P+QKKIA/HZz8f+XChOAinEuHDXHC2djQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Rjwn3XIL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wc3sVUvSf0qUFVLW+MD3C2Ls9fTd5d+/oumz9FXoC4A=; b=Rjwn3XILVDPJ0eirjgFSYPimec
	F4nd33yRg4/1N8ULTyd6TYmvclbMLfFCl7aYr/57Ya6A6kYcQ6AhhjT/aeRPDJ5j21SAwVN+tC6T9
	cI0froY5Q0UgqXWzSKyxUCLnISyhavJxEYk4ctGTsGL/yldCVq6hF3mFpZgBP5h2oiyrn65YqMUMr
	yl/nuZYf8YXtLKHh0e0ebaU9HM29SiIhmfG5I8dqlp9kxpwkOaV8o4sMQZBMaqGV01PaLjHHQ3qhG
	o2U/lN9rFTPuyPToId0p+Wo4v7Fzq8HCzHikPrMk8ECVBzwW+jxQQ+Z9RCOApDmeuyuAmZwFCIr3l
	+Ia2TmqA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39456 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3w-0006uM-0F;
	Tue, 26 Nov 2024 12:53:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3u-005yiF-76; Tue, 26 Nov 2024 12:53:02 +0000
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
Subject: [PATCH RFC net-next 10/23] net: phylink: add phylink_link_is_up()
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3u-005yiF-76@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:53:02 +0000

Add a helper to determine whether the link is up or down. Currently
this is only used in one location, but becomes necessary to test
when reconfiguring EEE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 30a654e98352..1d68809403de 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1442,20 +1442,21 @@ static void phylink_link_down(struct phylink *pl)
 	phylink_info(pl, "Link is Down\n");
 }
 
+static bool phylink_link_is_up(struct phylink *pl)
+{
+	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
+}
+
 static void phylink_resolve(struct work_struct *w)
 {
 	struct phylink *pl = container_of(w, struct phylink, resolve);
 	struct phylink_link_state link_state;
-	struct net_device *ndev = pl->netdev;
 	bool mac_config = false;
 	bool retrigger = false;
 	bool cur_link_state;
 
 	mutex_lock(&pl->state_mutex);
-	if (pl->netdev)
-		cur_link_state = netif_carrier_ok(ndev);
-	else
-		cur_link_state = pl->old_link_state;
+	cur_link_state = phylink_link_is_up(pl);
 
 	if (pl->phylink_disable_state) {
 		pl->link_failed = false;
-- 
2.30.2


