Return-Path: <netdev+bounces-99034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEC8D37A0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAFA2876F5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD812B87;
	Wed, 29 May 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sgvnac0I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6EA13ADA
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989387; cv=none; b=D6qkGsvaMWb4GvSwkRJunhUAvPBkjApJfLq2bp0eDMXiHXOJRcFvDE/ZAUHO14Hf5gEfnYgT4S6nmL8yiwUGdXF2a1vNCaSe/CCeLYpE9VmhIZ2FTIMs7hGmOxIwWRZvndvYh3Mf2l/w0dkAd3IJ6ZUN7Ww6AGqj+RMym/eAmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989387; c=relaxed/simple;
	bh=AGrumtKSDenFURQ8AmhTQxtcuUtiNLINOq77ZEFVlGA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=A5E0DvXK9NRiAJ2E2cSbYENXpED4HfTjns0ZEPCSu2tiBtuhDIfdTC+536zWbXlf8rTmLhibEY53+sYhzN7XoifZtPHbSJnzmf7d0LXVCQuQ4TkGVwmOss6QqAuyJwN/mA/pOCuswoXToJaG3z2Uk+1EhZS1djmwRPoF8j9Uv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sgvnac0I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I/Ap/ljJSxlOSU1gMqQyV0kXXftaGCsI7K45AcpMgJk=; b=sgvnac0IUz2BinfrHimnNfZlye
	9ADmwbt5vq/8EyUBjoWMX/rGW/Vp1huu7CYS6c2OCv5cEIYZ6UwG3KaeicGHg/hSVsqK0cIXM5YM7
	sbiLOFdftORABxWOPTtI9Z3WDlzTO0mpD8GjOk1g+bRkCb+rP93Swyhr2Amvt7t8M6zEGtMRC6ZLf
	Bah/KRNb97ts49xp8A2Z4QeiVE96/R7A6OvaZQb/EAGJrCSPK43L/SW3QhrYXZXJkOy1wxePaXPyH
	bZ0A9S//afJQ9ONzDduuJEvjPbZvPf2V+jTzM7A1uSrzEDY0Vp6hBQw8tELq4i6WIkencHPE07o9z
	4hhnF7Bw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42270 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCJMy-0006AV-1M;
	Wed, 29 May 2024 14:29:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCJN1-00Ecr7-02; Wed, 29 May 2024 14:29:35 +0100
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	 Serge Semin <fancer.lancer@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/6] net: fman_memac: remove the now unnecessary
 checking for fixed-link
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCJN1-00Ecr7-02@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 14:29:35 +0100

Since default_an_inband can be overriden by a fixed-link specification,
there is no need for memac to be checking for this before setting
default_an_inband. Remove this code and update the comment.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 9c44a3581950..796e6f4e583d 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1066,7 +1066,6 @@ int memac_initialization(struct mac_device *mac_dev,
 			 struct fman_mac_params *params)
 {
 	int			 err;
-	struct device_node      *fixed;
 	struct phylink_pcs	*pcs;
 	struct fman_mac		*memac;
 	unsigned long		 capabilities;
@@ -1222,18 +1221,15 @@ int memac_initialization(struct mac_device *mac_dev,
 		memac->rgmii_no_half_duplex = true;
 
 	/* Most boards should use MLO_AN_INBAND, but existing boards don't have
-	 * a managed property. Default to MLO_AN_INBAND if nothing else is
-	 * specified. We need to be careful and not enable this if we have a
-	 * fixed link or if we are using MII or RGMII, since those
-	 * configurations modes don't use in-band autonegotiation.
+	 * a managed property. Default to MLO_AN_INBAND rather than MLO_AN_PHY.
+	 * Phylink will allow this to be overriden by a fixed link. We need to
+	 * be careful and not enable this if we are using MII or RGMII, since
+	 * those configurations modes don't use in-band autonegotiation.
 	 */
-	fixed = of_get_child_by_name(mac_node, "fixed-link");
-	if (!fixed && !of_property_read_bool(mac_node, "fixed-link") &&
-	    !of_property_read_bool(mac_node, "managed") &&
+	if (!of_property_read_bool(mac_node, "managed") &&
 	    mac_dev->phy_if != PHY_INTERFACE_MODE_MII &&
 	    !phy_interface_mode_is_rgmii(mac_dev->phy_if))
 		mac_dev->phylink_config.default_an_inband = true;
-	of_node_put(fixed);
 
 	err = memac_init(mac_dev->fman_mac);
 	if (err < 0)
-- 
2.30.2


