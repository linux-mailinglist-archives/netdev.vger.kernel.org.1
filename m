Return-Path: <netdev+bounces-170324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AEA48291
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39529163135
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DC23C8C4;
	Thu, 27 Feb 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bUfHcvNH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80C26A0C9
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668736; cv=none; b=kza7yecCDHIfly43XJsNp3rpOCPwQiGFmWYD/f+q4NezqXaz1QXSyBcURA8Y6BtA+xnoKm45mMng13EQp5ZeTlrqezut6zP51mgyUkykJGZ5hwDuxKlPw69lWKU9OgUxeKsVhdPUHNbjePOP54um/QpJrHhIRSVk1GozYcfBwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668736; c=relaxed/simple;
	bh=qkVCo1cLIBr1fl8n1h4Xv6ZcRbytCsh3vdzLpMVvD+0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dOvcflNR1EmWH/SaKt8gWU1hLMVB3ucoFVjiabn8uxKyWPsR1Ac27c4Z6/b1ebVhlsG0ADB/A8o5/M1Ceoku9TRbRPzDgomVJiFJwlmaXG4Y2MfIYoTwqQcayMGA1Z/9YnWmf9COCvaijfy5tfVeyKtjxjiRmeXyaSwX1mHfK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bUfHcvNH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oqa9NrYSVqKjM2Z1WEm2zE1O8fLef4BbBY8UX3zYRHE=; b=bUfHcvNHZZ5SJoDEH9o6VZS8yT
	9IhsP0ZHaMibY/KgJKZ/xFPBCKcsRvGvmV41u79gEkJby5BCMlqOHKSlGZjt8DCB0T0oFj0w1pwXS
	Tx449dfOTHKhr4/yO40JpDbuoH8iQHwjXUHLwrTz/EU5a5yDLOy/y9qNtZITTiQpVkavr2HD8ydcr
	vdCAqAFOUXRiAdmESNWzdcMPmCeaAVfVlv4gLSK1cIAqwn/D9xgRSTkvWQYD/ILLwjRZsi2IvfCAZ
	9wupUKteH4/ShpR5j66Dqxwp833xNJAhroeMdbN08QmxBWyQODFNkGN5s60n8YR7YrXkZTZy1U94r
	OD4FqwGA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46940 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tnfS3-0007Wq-16;
	Thu, 27 Feb 2025 15:05:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tnfRj-0057SF-9t; Thu, 27 Feb 2025 15:05:07 +0000
In-Reply-To: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 2/5] net: stmmac: remove redundant racy tear-down
 in stmmac_dvr_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tnfRj-0057SF-9t@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 15:05:07 +0000

While the network device is registered, it is published to userspace,
and thus userspace can change its state. This means calling
functions such as stmmac_stop_all_dma() and stmmac_mac_set() are
racy.

Moreover, unregister_netdev() will unpublish the network device, and
then if appropriate call the .ndo_stop() method, which is
stmmac_release(). This will first call phylink_stop() which will
synchronously take the link down, resulting in stmmac_mac_link_down()
and stmmac_mac_set(, false) being called.

stmmac_release() will also call stmmac_stop_all_dma().

Consequently, neither of these two functions need to called prior
to unregister_netdev() as that will safely call paths that will
result in this work being done if necessary.

Remove these redundant racy calls.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 84d8b1c9f6d4..9462d05c40c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7757,8 +7757,6 @@ void stmmac_dvr_remove(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 
-	stmmac_stop_all_dma(priv);
-	stmmac_mac_set(priv, priv->ioaddr, false);
 	unregister_netdev(ndev);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2


