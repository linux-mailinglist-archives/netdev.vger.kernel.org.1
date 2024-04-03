Return-Path: <netdev+bounces-84520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761A897256
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476E61C263B7
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80252149C4B;
	Wed,  3 Apr 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K9TWKH0M"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C1149C4A
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153927; cv=none; b=u+TYagAqEkWLEzHmLX1HBvw2or4D6di1JdeVUk0l8Hv5eH1Our2FBNzDDAvONFytwU9WVizOPYzR848FWuyY+b3H4ULmcMNJnu8mMGrhA1LH4xR9DyHiBcC6ESBLt8VocKepglPAbPXZvPTwzq15bqu21wPqT4vuTAidBJLfiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153927; c=relaxed/simple;
	bh=bJsnLn4LIYXEjoGcIIu9xQMGtexIzH9tm3oeFygFsL4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FFdefVv/Lz0voZC4FDsETJxx+/C6q1Jk/LaAoRsAT4VaKX8qFOy9dXDAifO6duLJTiQKvkGm6R3o1VVTjEbO7Wevn9o2Wzf/vKmybSUiSMnIyf3qjCxq3eyPuUjhuAKS9A55cKUnUvBN9b6vB3ttHNrcfFEa4phO3V+RVIZCw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K9TWKH0M; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J2Jl8SShLMB4BimkYYvCy9xAAnzatO1bCd7kco8Ur2M=; b=K9TWKH0M3kOvBdmXmip8RTds9n
	j0M0qjTnu4xukYb3EplU+4OxRqrI2aqsTjYspXCE8cRknj49E5Q3KYqKn4WpwmcA2vNusPusoqjsy
	fHGjp/uUTG5AO0QHgXhSr/CLO5VNG0coxAL0/XHsHjDZE3XGBGhL8FGfrrrUYdZAT4HIvnl2LZNVE
	raWKnE+PPy+zIRxUNproaoftJuOgqMKBqrwHCdpBVhoBxdOnwJBeoFnU9cmT1GBZLdR0SnBSF2Bax
	fjQiqwWPcFPSlRt1+K8NExMif4FTpQ+hJ7ScVigDORqibNRmuybMuDqurt3xkmlyrR5KkORyd6uCz
	S2tg6GLA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60014 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rs1Ro-0008Vk-1g;
	Wed, 03 Apr 2024 15:18:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rs1Rp-005g7S-3j; Wed, 03 Apr 2024 15:18:41 +0100
In-Reply-To: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
References: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rs1Rp-005g7S-3j@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Apr 2024 15:18:41 +0100

Rather than having a shim for each and every phylink MAC operation,
allow DSA switch drivers to provide their own ops structure.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h | 5 +++++
 net/dsa/port.c    | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index f228b479a5fd..7edfd8de8882 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -457,6 +457,11 @@ struct dsa_switch {
 	 */
 	const struct dsa_switch_ops	*ops;
 
+	/*
+	 * Allow a DSA switch driver to override the phylink MAC ops
+	 */
+	const struct phylink_mac_ops	*phylink_mac_ops;
+
 	/*
 	 * User mii_bus and devices for the individual ports.
 	 */
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 02bf1c306bdc..4cafbc505009 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1662,6 +1662,7 @@ static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
 
 int dsa_port_phylink_create(struct dsa_port *dp)
 {
+	const struct phylink_mac_ops *mac_ops;
 	struct dsa_switch *ds = dp->ds;
 	phy_interface_t mode;
 	struct phylink *pl;
@@ -1685,8 +1686,12 @@ int dsa_port_phylink_create(struct dsa_port *dp)
 		}
 	}
 
-	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
-			    mode, &dsa_port_phylink_mac_ops);
+	mac_ops = &dsa_port_phylink_mac_ops;
+	if (ds->phylink_mac_ops)
+		mac_ops = ds->phylink_mac_ops;
+
+	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
+			    mac_ops);
 	if (IS_ERR(pl)) {
 		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
 		return PTR_ERR(pl);
-- 
2.30.2


