Return-Path: <netdev+bounces-143337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393199C217C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46041F233C7
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA42187FE4;
	Fri,  8 Nov 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fnzh4tY/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0C12CDA5
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081710; cv=none; b=dbrDrofhIWv6eYla5aiTHbNgMiilrIVKjL59O10eBF8PHEC5vAqLiXfVf0wVeCiYeHDXzCdLuEeHRPR+on0i/MgEdcxEihtjpJIx9/TVnsG2bftGUggZtYyWBLjiwjYyeDolV6yGDy/acri7IstMHdZzAuaVkSyTZ0O+d0a1otQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081710; c=relaxed/simple;
	bh=RkznWFHxz8lgA67vGEerxxBFBy5VCB2M/cvu8hVUuq4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=N2w1fygbeTYYufes/c6/Eu5pOXHzdVIG3GSynXc7SHtfOYVyIxJJZ0G3edIY5x4NnKRuCbuf6fcFuAA3OiBGUoYG8z48XA6EQJT9bX2etCAdodWG3xK1n44mZjFMcQvNs9PS9t2AW2Ijj5ltrI1Fs5pIp9Ke3cI0yoiTIWvMKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fnzh4tY/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IQoupKKIviQUlPSMME+Nbk7dTMUtyTJsz8Zkrc5NOJc=; b=fnzh4tY/yk6SyG3UFfoEBhfqoq
	i2bpcIGbFsMJD4400dUXzV5pl2+XEVL8hlqeHWviqbdiVz/3ZqhizaVWjjJiW45fBcKZJ4Js7o7pR
	07N+mdk8qf5GPUy1szG1Fvyhp9ltm+d5vfDJP62YbaKHLUExMC9CEt5vF7y3DP/DkoH1gZxGUmuAI
	THuBtBG4lhkM9IulUyS71+BZIyLuT2iqdEuElrUR1uR4UGNRaJqe09t9OAQPQpEX5L2XOURLuuifg
	9+lzvaBGKiVmr+W77OyV4gNXRh7txYJFc/luFNwRlKYr1XCjt6Y0sNs+k30fg/Ypq09I4RzGJ9cS3
	B2XPRj5w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43254 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t9RQe-0005Zp-1D;
	Fri, 08 Nov 2024 16:01:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t9RQe-002Feh-T1; Fri, 08 Nov 2024 16:01:44 +0000
In-Reply-To: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/5] net: phylink: move manual flow control setting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t9RQe-002Feh-T1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Nov 2024 16:01:44 +0000

Move the handling of manual flow control configuration to a common
location during resolve. We currently evaluate this for all but
fixed links.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6ca7ea970f51..65e81ef2225d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1467,7 +1467,6 @@ static void phylink_resolve(struct work_struct *w)
 		switch (pl->cur_link_an_mode) {
 		case MLO_AN_PHY:
 			link_state = pl->phy_state;
-			phylink_apply_manual_flow(pl, &link_state);
 			mac_config = link_state.link;
 			break;
 
@@ -1528,11 +1527,13 @@ static void phylink_resolve(struct work_struct *w)
 				link_state.pause = pl->phy_state.pause;
 				mac_config = true;
 			}
-			phylink_apply_manual_flow(pl, &link_state);
 			break;
 		}
 	}
 
+	if (pl->cur_link_an_mode != MLO_AN_FIXED)
+		phylink_apply_manual_flow(pl, &link_state);
+
 	if (mac_config) {
 		if (link_state.interface != pl->link_config.interface) {
 			/* The interface has changed, force the link down and
-- 
2.30.2


