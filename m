Return-Path: <netdev+bounces-136562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C19A217B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5D41C21256
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BBC1DC1AF;
	Thu, 17 Oct 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kYyyeZRi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDE81DA614
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165980; cv=none; b=PejdR778k1ZqQahebjN1D0rL2RQ1FxMXm5ihbmFh+kI+mV5iEQX6o+EJ68LgCmQuIN7IkLuxuNXMKL+NiV9Lhli1e0QfXFGztbx511wHyYHs199uuZVSCZwkW3VenCqvO21mS8IiWtoEtbOFKn0Rlmu8VqCW1AjCovu7jcGXcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165980; c=relaxed/simple;
	bh=2yp+Qt3OSbOiwzD7Nfr7hyfD3Ulo3b9jUAM1bXi2zpg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QNrBLyKgRVbDB6fqRZrZx7xSx26t68eyc6N+f1D8xjSxLaRtFjTYVtgt/CZdHuYRNGvtIdQfd3AkwtU9qXef0RI1GG1WIxnmp8ywvVAuuQXiqCzgOXJL6V2d/kcTJUT7Zr0wrZIv8vVyENCmkdH73Bl7Vq9Axe/9k5NgoOdcgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kYyyeZRi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xiwJtIJgNsWscj+Fc76PN7FObjtVKjifptCZnbrZZbE=; b=kYyyeZRieEirja+E3/uBUofSj3
	iFBZ+gsS4edl6LWi9Xmr1yWxr0+PL7fYvStQ35rhaI91Y9hrIV3xcj3AopBHgANaf5UBUv/RjvtJD
	wGzTvNLtKSgwOSlyLJiBG7PE/1Cg3ahxLnEiJqY5cTWTidRWzCNfUtjWdyRQeUilv/xiLGZlnoQHg
	v91E/ls0S2G0hPOAYO17aOKdFfnMfnQeAdpAU1KqMwJEWWXMyGtSa+O1R48rULVVAAJED7ovFWQjo
	4xo0C4y1QBn+b4Q6zWwUf05xIgxYxc3hh1zD+u318ef/8YS2y6z04BTlb8RgbmBjhyqI0v1aPdNQr
	YWfw/CsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34564 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P3h-0006Uw-2G;
	Thu, 17 Oct 2024 12:52:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P3h-000EK9-NO; Thu, 17 Oct 2024 12:52:49 +0100
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
Subject: [PATCH net-next 3/7] net: pcs: xpcs: rearrange
 xpcs_link_up_1000basex()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P3h-000EK9-NO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:52:49 +0100

Rearrange xpcs_link_up_1000basex() to make it more obvious what will
happen in the following commit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 183df8f8c50f..3222b8851bff 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1133,12 +1133,13 @@ static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
 		return;
 	}
 
+	if (duplex != DUPLEX_FULL)
+		dev_err(&xpcs->mdiodev->dev, "%s: half duplex not supported\n",
+			__func__);
+
 	val = BMCR_SPEED1000;
 	if (duplex == DUPLEX_FULL)
 		val |= BMCR_FULLDPLX;
-	else
-		dev_err(&xpcs->mdiodev->dev, "%s: half duplex not supported\n",
-			__func__);
 
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR, val);
 	if (ret)
-- 
2.30.2


