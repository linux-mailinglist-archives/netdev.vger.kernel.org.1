Return-Path: <netdev+bounces-129314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ADD97ECBF
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400341F216E0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB619CD01;
	Mon, 23 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eV/gtFO5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15719CCED
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100110; cv=none; b=MxCjyBGuAl7SZo2hvY2hYbK0BOtHF6vDqjAKVUadr/Xc9UH/yWHv3O3HP66PXGteZaAClPp58vxB2ZQC0IQ3/SlAd9l8rWfNlGANrTXw0I+i9for3wyQEKbY0sBgV11Yhth/PdzQIkoUZ54M/CkS8I0649NzYqZNC+qlsqNK/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100110; c=relaxed/simple;
	bh=SYi+bO0aDPxMfRoUiFjOeKzoAmfoqUhY3GtSxGy2MRI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=chCUQBeud4bB+vvv0/qlYVOhTtNW2SDrmHP48M65/nbpjlfR1OUJw4s/8z9q+S1Y6Q73mpueg/0aV+RX22Z1vvlpv975HSdLgSSOo93Xef7veOOpPcWnWiAdPgO3coTZhNbYrw6wZJ8HYBpYfcNz7QfnUuwUkJS92WeYzwxAEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eV/gtFO5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hB4I6KNKXW2Of1mZXzVBxj2ILyGc9/N2QyfLd6lRRSE=; b=eV/gtFO5ACfI2pgNzUHzlhT/1f
	9vNEDev20UCjA0Bek+OhAQzQgrPSbWOAbmJGoLdJU9DuLi6eitAWXTQx2/Ffj2EToUGKbPAa0uBdR
	6PBVcPyEZEwQrWpZKP236TqV2adXw0AGMvv/8zs2PHG4m8nzDpSsL04rWCnFydhij2U4pbEeDOV5Y
	203YcECJ6Z4Zp0dA/G3hUjI0LEA0B+4pUhpDYu1IG+V+cXB3EQtVTxT9mrkkow8ISDLD5/X79eUXx
	TugKK/Awr4aGu6/aF+oYCQ+JhW3tAHKeb85mpr7EAp1g2V1EGXCWvPxzZeL7q9hBnIyA9jADoQl98
	pPLrFprw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42210 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjd6-0004Ih-2u;
	Mon, 23 Sep 2024 15:01:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjd4-005NsF-Gt; Mon, 23 Sep 2024 15:01:30 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 07/10] net: dsa: sja1105: call PCS config/link_up
 via pcs_ops structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ssjd4-005NsF-Gt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:01:30 +0100

Call the PCS operations through the ops structure, which avoids needing
to export xpcs internal functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index b95c64b7e705..8ef1a1931a33 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2375,6 +2375,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 
 	for (i = 0; i < ds->num_ports; i++) {
 		struct dw_xpcs *xpcs = priv->xpcs[i];
+		struct phylink_pcs *pcs;
 		unsigned int neg_mode;
 
 		mac[i].speed = mac_speed[i];
@@ -2385,12 +2386,15 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		if (!xpcs)
 			continue;
 
+		pcs = &xpcs->pcs;
+
 		if (bmcr[i] & BMCR_ANENABLE)
 			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
 		else
 			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
 
-		rc = xpcs_do_config(xpcs, priv->phy_mode[i], NULL, neg_mode);
+		rc = pcs->ops->pcs_config(pcs, neg_mode, priv->phy_mode[i],
+					  NULL, true);
 		if (rc < 0)
 			goto out;
 
@@ -2406,8 +2410,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 			else
 				speed = SPEED_10;
 
-			xpcs_link_up(&xpcs->pcs, neg_mode, priv->phy_mode[i],
-				     speed, DUPLEX_FULL);
+			pcs->ops->pcs_link_up(pcs, neg_mode, priv->phy_mode[i],
+					      speed, DUPLEX_FULL);
 		}
 	}
 
-- 
2.30.2


