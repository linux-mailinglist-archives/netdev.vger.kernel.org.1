Return-Path: <netdev+bounces-164665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9EA2EA50
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983BF7A7ED1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25E1DF998;
	Mon, 10 Feb 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vX4SdZRc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C851E3DC4
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184859; cv=none; b=WMk8jqgldSGBKiFNWk0ni9WmZdUcsiGA1Bh+qg4TjOAPNMC+7u1fNY3tFhqEnATKSLPnT5yw2ji0EwXjFaBC+C8u5krq4WdRno9ulh8AJzFoUyqr7t+GEinnQZAF4NB/MzJ/CPgmzthxaC4Mbx27KfOyU0+JyLiV+rtuC5lSxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184859; c=relaxed/simple;
	bh=Sn/MEUMsk2TVTj/tfMTfKw4YYi1N2qB0G/JoTzTjh4c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CA58qKPdM6DoOqlUpiRCRu0rRXS03Mm8rL1GT9YbLtGX644yc7SKxQ2TC5HPfd59nWNP2oZpdqiIBoMDPVDrRT8Jn0hHBbjo9b1EqUvZbvQJJKpedbAyYr/x/t4HNaw1UGFQs9eEUYY8n2XwF4TGv6Y84BVjGJKJcWOUnz3qAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vX4SdZRc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EBcD+jSZTJ87ExoztZaJ1Ni32E6UJjFerwHmJRvv+KY=; b=vX4SdZRckIpwiVehwiL8ayoJTf
	/wu+ImWEw1MIIAPDc3l8gpGEDDvSHXQMrQiCBcSE65z2n5aX9VFPmPmWnHC0L4y7lHpTdevhGy+uF
	rZJ+0IcccngHq9natEFmM0OHZ9AKwV6UHGUz+CHTJyEkyGU79LQTNuhaK5HBzQDEw0q19qDH79zgG
	mpTElpQJYb3rJPXNF0+km3/40VhfwqOcEQy6a3/yxvt1Pt0LYWWSW9U0TvqqoL9GJywVUf40heH02
	2Q1rGoPC13mOhgOvlaXB8jg1rEtcituBs3CL332oSVbD6eCPnkzxjrWVMGUbaRtlyhH0rewGeZKoJ
	iuORQECA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38714 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRQX-0006Vm-28;
	Mon, 10 Feb 2025 10:54:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thRQE-003w76-3C; Mon, 10 Feb 2025 10:53:50 +0000
In-Reply-To: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
References: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/8] net: stmmac: call xpcs_config_eee_mult_fact()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thRQE-003w76-3C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:53:50 +0000

Arrange for stmmac to call the new xpcs_config_eee_mult_fact() function
to configure the EEE clock multiplying factor. This will allow the
removal of the xpcs_config_eee() calls in the next patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 0c7d81ddd440..7c0a4046bbe3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -524,6 +524,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	if (ret)
 		return dev_err_probe(priv->device, ret, "No xPCS found\n");
 
+	xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
+
 	priv->hw->xpcs = xpcs;
 
 	return 0;
-- 
2.30.2


