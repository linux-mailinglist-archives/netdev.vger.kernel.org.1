Return-Path: <netdev+bounces-99036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9DB8D37A4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBF21C23D61
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48F12B8B;
	Wed, 29 May 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ogYkuNg2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B23C2ED
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989398; cv=none; b=DjpDBOb8S91gnWvLZyS0FVzGvG2GBwUY83T+4Znh/fjHyIIW6UK2ls+PhnQ56e7nprhVfp7SA5oPzsPVNGZ2so5ESp5Olp2PP+GQcQmQmy0PLxc2Yjry9IxG3N8yxilghUX8sg14YPjOydaA/qmukuD7GVilRl5EYXiF377Xsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989398; c=relaxed/simple;
	bh=CHXeVcOxd0UzaY8yj8lIT+XgwRUaoEwyxjgK+6SPRrI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=i6vs5qFEUOBZq0ZRorOQcmPtswXAq4tGgksHmsROcQ2HhqSq2uCsMRBbjiRTxFJRELsQxa6kLgIbMCLP0cJX68QIO4uRJP0tjLR8xk6TlJDroMy8HwgU/Ph4u4bjfyHOWC0Zu8MAcEz+MdmKBmLSrNW1wEX5hEoVMLIKGtrQJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ogYkuNg2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jrnjzB7F3wcMn320kdy6SKYULM0j5Eqx/IjuBbSJc84=; b=ogYkuNg2+g9hKjYtcmQKKp04S6
	sAtKeuWv++oaMXKeKURi9geL9JBaLw52BoAs6YJIeD1r1+bkgchYCwsz1Zj2iYMWePBhbt131BIZN
	Y16+kbLwQ60AHOaaqi/IzM+80aw6eWGjFgFxwSZnIbUlAx1TNrYUfBm3fZXmCLF1XJPaAM+5HjXio
	k1lfyrqThJOtc6cipODgtNThHZeGQubcLSy3KQ8KXej4x1culHBRlLCl0cgFK1PY5gcIvlcTa6Pp8
	Mrb6dQs2sjhDTSSmnkfvGtDjU4OgrzXVtLzcBcTXIdyvyYI3firRPwrPTZZhFiAo7B+IqU/moRK5E
	ARpa+KIg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44828 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCJN8-0006B4-23;
	Wed, 29 May 2024 14:29:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCJNB-00EcrJ-7L; Wed, 29 May 2024 14:29:45 +0100
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	 Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 6/6] net: stmmac: dwmac-intel: remove checking for
 fixed link
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCJNB-00EcrJ-7L@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 14:29:45 +0100

With the new default_an_inband functionality in phylink, there is no
need to check for a fixed link when this flag is set, since a fixed
link will now override default_an_inband.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 5e96146b8bd9..56649edb18cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -589,17 +589,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 		plat->mdio_bus_data->default_an_inband = true;
 	}
 
-	/* For fixed-link setup, we clear default_an_inband */
-	if (fwnode) {
-		struct fwnode_handle *fixed_node;
-
-		fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
-		if (fixed_node)
-			plat->mdio_bus_data->default_an_inband = false;
-
-		fwnode_handle_put(fixed_node);
-	}
-
 	/* Ensure mdio bus scan skips intel serdes and pcs-xpcs */
 	plat->mdio_bus_data->phy_mask = 1 << INTEL_MGBE_ADHOC_ADDR;
 	plat->mdio_bus_data->phy_mask |= 1 << INTEL_MGBE_XPCS_ADDR;
-- 
2.30.2


