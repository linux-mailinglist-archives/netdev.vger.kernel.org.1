Return-Path: <netdev+bounces-89125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB918A97D7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9AB1C20DCD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2215E207;
	Thu, 18 Apr 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q0AyzPbH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871F15E1FC
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437492; cv=none; b=pVtYZnRDZZhqEPz8nbxAoHLyWlxjtPb8YNe5vvRh+pZk6zZEz89sq/6s7V/dY23CWK0+rn+SI3coA6+VClIMdiWi2wP2uyv8nLy3Ud31MVvN5A7GQSyDgO/+haNWM00qAyp2lpba9ly1mOZ9pFB0uTF8T6Ogux/i1wv2CF4wYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437492; c=relaxed/simple;
	bh=nu6lA76N5WLXYvWzhF8Lf/Nyns34NYM0MBJ0QLMuRJ8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=NDRf37bnpBZNDGmQ/yCfqwvy4RU+s4TmqqEa3HqABzDRWJwCGKB0XGd5wqj3tn55phm1uNiPU2DlEEU+tIYtD4kklzpS9d4wpA56Ep8/RBzGpnj5C1WidCB+9r6UIA19FDXFw5xQQc7zXkWdZtjY6ky35gS/RNDqph0fWqPX+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q0AyzPbH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7EU2L0mFIj9DzZB8BI0h80C8FpKbnCjNoYG/6UMX2OU=; b=Q0AyzPbH7wacPnQPSPllcEe1Fa
	4c/e4dZwB0h55uydUrR1ywhRKnc9kyoOFUWC8rP8CJw+KS3UTHtqv8o4G3vDufCvBUjWpu+xpBaz2
	ZgEVLJddl4vNsl/s0aRl4hilTrIOegKA1Eo+f7P4goeP9rBdUXqF3/vsD6WUk7xaDER8CtjRvVNtU
	iv18l2ZsImQ5uGFs3cwYQbi0Lqx8pRm3DEOM5r0t3UGIF7oNIohN5gEUUalyi20cyYaaLfdkZ0FGq
	pJ9cn2GY/iicdwSg3hpZBCMtFSedQSvdP5Ga02KWgMCCqk58ArFVVcQAOPjs3OD7fELUWEBPSFuKN
	InzWmoqg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44078 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rxPMO-0005nz-2o;
	Thu, 18 Apr 2024 11:51:20 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rxPMP-007f9I-Qq; Thu, 18 Apr 2024 11:51:21 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: George McCollister <george.mccollister@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: xrs700x: fix missing initialisation of
 ds->phylink_mac_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rxPMP-007f9I-Qq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Apr 2024 11:51:21 +0100

The kernel build bot identified the following mistake in the recently
merged 860a9bed2651 ("net: dsa: xrs700x: provide own phylink MAC
operations") patch:

drivers/net/dsa/xrs700x/xrs700x.c:714:37: warning: 'xrs700x_phylink_mac_ops' defined but not used [-Wunused-const-variable=]
     714 | static const struct phylink_mac_ops xrs700x_phylink_mac_ops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~

Fix the omitted assignment of ds->phylink_mac_ops.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Normal builds don't catch this, and W=1 produces 5.3klines of warnings,
so its pretty difficult to build-test changes such as these and have
confidence that they are correct. If anyone knows of a solution to
this problem...

 drivers/net/dsa/xrs700x/xrs700x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 6605fa44bcf0..de3b768f2ff9 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -780,6 +780,7 @@ struct xrs700x *xrs700x_switch_alloc(struct device *base, void *devpriv)
 	INIT_DELAYED_WORK(&priv->mib_work, xrs700x_mib_work);
 
 	ds->ops = &xrs700x_ops;
+	ds->phylink_mac_ops = &xrs700x_phylink_mac_ops;
 	ds->priv = priv;
 	priv->dev = base;
 
-- 
2.30.2


