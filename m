Return-Path: <netdev+bounces-148578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16E9E2570
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AE6B45986
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05A1F8939;
	Tue,  3 Dec 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tigLSWZU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313211F75B6
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239917; cv=none; b=dDnjM+7v+o4sbYpFX0js8Q8f9TolumgJHdPQQGstgc011tGyCJEvHVu0ErOW4WfhRfSQ7HfY9yMDv6qgOwR7YzSi5DJ1pn3/vkXxcd6kNClWP0umAduZDYUd3UuGWzbrkQRsx5Bpel+xi/ERdjCz8FteuBjoTrTY9rrVc31ZVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239917; c=relaxed/simple;
	bh=6eIBXgM1Iu7jes442VSZYKcS0hjg5boZg0u040qRHlk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=neAEeLKkJy3SL692y5FoN3teYwbLIYG1LqN046dw7/cyCmZybGcY9QPPEtUaWiZXZKIVeIFq0NzMyuBxWxDdddzF1QGMI3Pz5Xv3OPJsSIG+V5Bt/Tb7UIfO95kNAEcUAZFEtDDg7TlLCrEm1KNc8xHVFV+N+2vhldcTakyPUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tigLSWZU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uf4WYKSTze3bSnwu7K9kB/i9fwhUx0yrzfWqKQGsojI=; b=tigLSWZUTpqGeEyg22VImz9IzQ
	9d+xGzo9/AwXt5+fmG30Uy3VoxNhcxSzkFd0ib2o24QQZDJx4Z3sAm/2caoXcN0YOWqrcC9WYNzwi
	mJQPI0HCBWaS9bVZrdbqP1SV9otJq6Tgu8SSDj7wvuDBX66JVIgKfQNuC7syKnOMJwaZNA+vMpHYM
	723AJAT6cAjsk0mS9J1mGjN5C1rtBo0q5y6WfF+I6nCgByNjYogw8NLOMlHotbO3t+C599EaeZUuE
	rNkNWlueoIFKb9ZVWT6jShBUTgAigCWhfuEQxli0SC6ijq8FAH0NQaddqhfIAQ/3N8yg+XC4/IyDX
	55hqIqbA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39300 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUsP-0002A2-2i;
	Tue, 03 Dec 2024 15:31:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUsO-006IUt-KN; Tue, 03 Dec 2024 15:31:48 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 13/13] net: phylink: remove phylink_phy_no_inband()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUsO-006IUt-KN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:48 +0000

Remove phylink_phy_no_inband() now that we are handling the lack of
inband negotiation by querying the capabilities of the PHY and PCS,
and the BCM84881 PHY driver provides us the information necessary to
make the decision.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b0881fa9c72e..95fbc363f9a6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3391,10 +3391,11 @@ static phy_interface_t phylink_choose_sfp_interface(struct phylink *pl,
 	return interface;
 }
 
-static void phylink_sfp_set_config(struct phylink *pl, u8 mode,
+static void phylink_sfp_set_config(struct phylink *pl,
 				   unsigned long *supported,
 				   struct phylink_link_state *state)
 {
+	u8 mode = MLO_AN_INBAND;
 	bool changed = false;
 
 	phylink_dbg(pl, "requesting link mode %s/%s with support %*pb\n",
@@ -3428,8 +3429,7 @@ static void phylink_sfp_set_config(struct phylink *pl, u8 mode,
 		phylink_mac_initial_config(pl, false);
 }
 
-static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
-				  struct phy_device *phy)
+static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
 	struct phylink_link_state config;
@@ -3473,7 +3473,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
 
 	pl->link_port = pl->sfp_port;
 
-	phylink_sfp_set_config(pl, mode, support, &config);
+	phylink_sfp_set_config(pl, support, &config);
 
 	return 0;
 }
@@ -3548,7 +3548,7 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	pl->link_port = pl->sfp_port;
 
-	phylink_sfp_set_config(pl, MLO_AN_INBAND, pl->sfp_support, &config);
+	phylink_sfp_set_config(pl, pl->sfp_support, &config);
 
 	return 0;
 }
@@ -3619,19 +3619,9 @@ static void phylink_sfp_link_up(void *upstream)
 	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_LINK);
 }
 
-/* The Broadcom BCM84881 in the Methode DM7052 is unable to provide a SGMII
- * or 802.3z control word, so inband will not work.
- */
-static bool phylink_phy_no_inband(struct phy_device *phy)
-{
-	return phy->is_c45 && phy_id_compare(phy->c45_ids.device_ids[1],
-					     0xae025150, 0xfffffff0);
-}
-
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phylink *pl = upstream;
-	u8 mode;
 
 	/*
 	 * This is the new way of dealing with flow control for PHYs,
@@ -3642,17 +3632,12 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	 */
 	phy_support_asym_pause(phy);
 
-	if (phylink_phy_no_inband(phy))
-		mode = MLO_AN_PHY;
-	else
-		mode = MLO_AN_INBAND;
-
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
 			  pl->config->supported_interfaces);
 
 	/* Do the initial configuration */
-	return phylink_sfp_config_phy(pl, mode, phy);
+	return phylink_sfp_config_phy(pl, phy);
 }
 
 static void phylink_sfp_disconnect_phy(void *upstream,
-- 
2.30.2


