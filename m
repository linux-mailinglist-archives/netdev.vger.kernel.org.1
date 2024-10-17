Return-Path: <netdev+bounces-136563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F7B9A217C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF34528930E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8DD1DC196;
	Thu, 17 Oct 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o3rZRNmy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB371DA614
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165985; cv=none; b=XYTzXwNCi0S2ZDHp42sQpKJREeIlYkaxgIn3syYGMNfTscFOMRM1RwOMWeuMXEBuDI9Xbs8oftDgn9y0QgNqZw8xULpx/tauQNsjcB2EVHE8M3sVfneIZPCsnlvwUH6w9aJHkwTX7cKOGoC6pz64woWv+51oavQ36trhyZUWqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165985; c=relaxed/simple;
	bh=ZReJJ4+8SRatT2h+2ZEKPInEKod6q8AiVsSGne2O2QY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RpoOv00Zh82EImz71XIwkMprfy303BmNyOvIVaoLAzlpEwB/pNi4g2ZOATG0yHh9nAynNKn7frr4dl+QBoepLaFJ3RMUXGFMxdZIo9Q6eFTMWwHxKrCd9Oel3b8YL51fbWwyX3PhSX8VUX+Jnf5/sm4/tDo8UFOYi22I2GQMdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o3rZRNmy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=78v0O6Lf1RTV/V5F8ii++JNttCnVNllCHlWuYu7zyvA=; b=o3rZRNmyAWWA3OGlRZTjxS048f
	6ArtnN/kyVhviJGP7TzvKrOpbYJY5o4EWp8Uesdwd44A3J3s994eclLyfCdhBILc8oMEXURHthoOW
	adNA38B8WgIO5hfsKynt68sw/7ddZ9xg3GQVnDLiSOd6EVyGJs8j/roPGA1AmmXqyMceudWkeOan0
	Lti6or5MJm2klEev1vgcI9WhCIwhHeJySoEoIu9FNaTBvzBG+hRQzRBmI+hm6vchkQEdoy9UgnbYI
	FP9QNk70+F4gptLxIv1DY1P8zyuhcIrdh1tWnPWJHyw03YiBoF6aZaasBh8ihoBFzYOBycKAm7Wr8
	yLN2tpIg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34578 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P3m-0006VA-2U;
	Thu, 17 Oct 2024 12:52:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P3m-000EKL-Qn; Thu, 17 Oct 2024 12:52:54 +0100
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/7] net: pcs: xpcs: replace open-coded
 mii_bmcr_encode_fixed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P3m-000EKL-Qn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:52:54 +0100

We can now see that we have an open-coded version of
mii_bmcr_encode_fixed() when this is called with SPEED_1000:

        val = BMCR_SPEED1000;
        if (duplex == DUPLEX_FULL)
                val |= BMCR_FULLDPLX;

Replace this with a call to mii_bmcr_encode_fixed().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3222b8851bff..5b38f9019f83 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1137,10 +1137,7 @@ static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
 		dev_err(&xpcs->mdiodev->dev, "%s: half duplex not supported\n",
 			__func__);
 
-	val = BMCR_SPEED1000;
-	if (duplex == DUPLEX_FULL)
-		val |= BMCR_FULLDPLX;
-
+	val = mii_bmcr_encode_fixed(speed, duplex);
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR, val);
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
-- 
2.30.2


