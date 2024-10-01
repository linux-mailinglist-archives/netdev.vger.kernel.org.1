Return-Path: <netdev+bounces-130946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341FF98C239
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6577A1C22125
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD551CBE8F;
	Tue,  1 Oct 2024 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ABMPpS5z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA51CBE8B
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798699; cv=none; b=qAe7SQfazmMwYhH3KMfGEAgqzYJ5Qr8lle5Hb3m+XkMOVXsq3UQeEHHM3bulmMptEO4M0e34eUqVbblx+7z1j8lde3gaAbURhkEKmN9P3OktT9sWw6aGHfWAhOYKsMyiI660LKfTmsJJsVjMVwT4o55/pb6j0SIPJl2i6DrUVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798699; c=relaxed/simple;
	bh=PCzxpacAhO8quZG2Nu/mZPKr9jo97b7Hc0cF6LZjaEg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pBcfoVXiBW0qpQbAXrS3MswqFxqGJA7oAWLv95WISaR7/Rbd3EMGFv7O1siGm97KEmChkACHCPH8R74QB4IQhveL5TirXxIAL8xBfv9GRVhdXMzRxOw7DNRZHGCw2LgTZTmFLXlOq6Ke05MKTsp0WnqIrPc3nBUKDj2BT28DG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ABMPpS5z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fXDHPYVXyXAY4PkJNtdgxO7YGAhnoJif58XzNkVCyfI=; b=ABMPpS5z8TgYenW3fgyTTlRa1m
	eL2kP/5JFNVQUfkkuycWSntdDMTWSoAyA+muzI0FUmQNy5JYNpCdYW/y7BuNZnZ/FNEf97ErCsYR/
	KlX20hZAYX/5Ym7Sh5256E052FPscz8hxvP0FOJNYeScKpQLC02PBHlewQIYgatKX3Fasi9ysLoMm
	Mb/fphRgj1CT32eiicuiKMgft1UsruMSRlgtQ4YNdWAiliZpCtCUTkafzxmGUHko7d+1kEGbiY8mj
	OLdYlndofCO6OLgWidlKTIAjG/HvkH71CACHgxyt6zAgZCfQKaJ5hHTh4EPbMgfLNRNpxDiUKHpaT
	a4MtCeUw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42600 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMh-00066n-1Z;
	Tue, 01 Oct 2024 17:04:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMf-005ZId-Mx; Tue, 01 Oct 2024 17:04:41 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 07/10] net: dsa: sja1105: call PCS config/link_up via
 pcs_ops structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMf-005ZId-Mx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:41 +0100

Call the PCS operations through the ops structure, which avoids needing
to export xpcs internal functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 5481ccb921df..e5918ac862eb 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2377,6 +2377,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 
 	for (i = 0; i < ds->num_ports; i++) {
 		struct dw_xpcs *xpcs = priv->xpcs[i];
+		struct phylink_pcs *pcs;
 		unsigned int neg_mode;
 
 		mac[i].speed = mac_speed[i];
@@ -2387,12 +2388,15 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
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
 
@@ -2408,8 +2412,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
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


