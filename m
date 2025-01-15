Return-Path: <netdev+bounces-158639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E959A12CD7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4947A164837
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ABA1D95A2;
	Wed, 15 Jan 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N0/VZvON"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089A1D8E07
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973785; cv=none; b=GK5npODugk0hT1xwsPuahit1ymfrekGdcXVtnmsPtWUURcXS+NZRgAN8VB0lnKkK/ql+XCw28f/ffvnpDpSnfnxv5NObLTTA0vWpuQt0NUsx+9Tnh2pElkkkVQ2n4melD+aZS3kCpLe4v8txpjff/fOecxH5z+/ixSMY0XrwWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973785; c=relaxed/simple;
	bh=CyRp38k18gKLFj3buN+Rqe7v3YnvGWYNvcD9gCqrBMM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OY/PeHFX6ZdPwfJeREhEz1ncatkwkUI9aFqx89Us1ylbABDh9QcxYjrmHIg5D76YedHK5+KIqDwdt0BrJv1gZUS8wBlL0/LBWK0YVj/cGNYtzXPrcxCSEcxRkWfE+UFt98UOlNIvF3PknF9/fWFFn6qE++HTBinZ/qSj6kuJfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N0/VZvON; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=weR9Z/CkPANR3PvdWqGOb/Y+LHB/KJHILnKwZHgGiFY=; b=N0/VZvONhngbqSzpyFGBIJ/qN4
	003l5PbF+73jtiFHm3O2tlNy+gA2/VVmXIVmEFLICiHaoIV4uZae6JFTzqms80aXGnfVJaOSbdlRD
	rdzJMSevekXXjGBSf7tMEAE7KUnzOyhCIfNFPgH9N3vO1pZWAm2sZq2VfmtxVgRas/u4GgeN54dc0
	auw1I2zWE2xzKw0srxWUpMOuoPeAUr4eAfSUwBdG6fGG92uyOUeaov+X4ydb95d4FN6gibmxaKm1k
	hYfAdERvA+03hxA9vloZEPgB3msrh0W4mNGVInWIlzijY/1kZAGDDBsJYcRF/8NvjHD3x7eUzmYR4
	g8IJ0vPw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54728 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYAE4-0001ij-29;
	Wed, 15 Jan 2025 20:42:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYADl-0014Ph-EV; Wed, 15 Jan 2025 20:42:37 +0000
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 3/9] net: phylink: add phylink_link_is_up() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tYADl-0014Ph-EV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Jan 2025 20:42:37 +0000

Add a helper to determine whether the link is up or down. Currently
this is only used in one location, but becomes necessary to test
when reconfiguring EEE.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 31754d5fd659..e3fc1d1be1ed 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1641,20 +1641,21 @@ static void phylink_link_down(struct phylink *pl)
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


