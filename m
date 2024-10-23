Return-Path: <netdev+bounces-138248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77B9ACB75
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C3286B0C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A41AF4EF;
	Wed, 23 Oct 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ovBqo3Dj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768D12B71
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690912; cv=none; b=Zg6a9OotwnIubnN4+ESsySWuFEmTSR7jADm1UImTbIIaP3Bx0Q/Cq5mGKCi6spMfYFhoXkhtIt5OQKCmezo/XfUvdeDm+bj5MFOVKCDsJld0i/i4qxVAXnxFwNrLxR72HEsR2niE+8WWS80zBAQrNSfg2l27E8WTrslct7RfXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690912; c=relaxed/simple;
	bh=zhXbwc6+5a6D+d0ZJwM6/6i7r6QoT7snvA4cetQsRkE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bPqDUjTeIEkVEvVX3BBKzLXivW69damxNFfsiZel9/wWbcMPRFiIfJIKSNnedyjxgQZXd2wKpj/zV+DnvjEl69ZI+LOjequeCZwpYE4KIiAdTlx3sr08RJaS7g695OK8vIFxww+p6zA8YVPMCCPLJuGiSMh0TOH3Qa/RXrZUlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ovBqo3Dj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7bAdTUSeeIalnLMyPNPUyOo+d01Hp0PeG3yJSslBkJ0=; b=ovBqo3DjU+Q76ljatBHUCq+F+m
	plvpQ8pLNiZq5FGz1obj2QGL7QH8hQLI260bBo9zAdKqmfquLiRL6G2iunB4KlG80WZMq+u3psqFY
	mpEMeT7r8MxqCm+Hrs+BDgaH0Iz9bOolIrufiHjrwXitBM6E1TrvFPRWjqX3jy/g5OkeGMgz5fX7j
	lXR3P2ScIySFg6Yg5K4isHLnSQGdC8LFHxWxiHD9LO2d5mC8JSBYttrzJaB+SbTL2CFLVfObyMCGY
	DXWUNMCXinJxja1w1FBFAkIHT1Fvb7HBD2tqeaXjO/XTUFNc4Kv/XMjLbKm1dcxCazdN/57K8oGzI
	3vuwQ/2A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33780 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t3bcQ-0006Ul-2A;
	Wed, 23 Oct 2024 14:41:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t3bcQ-000c85-S4; Wed, 23 Oct 2024 14:41:46 +0100
In-Reply-To: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
References: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: phylink: add common validation for
 sfp_select_interface()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t3bcQ-000c85-S4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 23 Oct 2024 14:41:46 +0100

Whenever we call sfp_select_interface(), we check the returned value
and print an error. There are two cases where this happens with the
same message. Provide a common function to do this.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b5870f8666ac..62d347d1112c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2415,6 +2415,21 @@ int phylink_ethtool_set_wol(struct phylink *pl, struct ethtool_wolinfo *wol)
 }
 EXPORT_SYMBOL_GPL(phylink_ethtool_set_wol);
 
+static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
+						const unsigned long *link_modes)
+{
+	phy_interface_t interface;
+
+	interface = sfp_select_interface(pl->sfp_bus, link_modes);
+	if (interface == PHY_INTERFACE_MODE_NA)
+		phylink_err(pl,
+			    "selection of interface failed, advertisement %*pb\n",
+			    __ETHTOOL_LINK_MODE_MASK_NBITS,
+			    link_modes);
+
+	return interface;
+}
+
 static void phylink_merge_link_mode(unsigned long *dst, const unsigned long *b)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask);
@@ -2597,15 +2612,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 	 * link can be configured correctly.
 	 */
 	if (pl->sfp_bus) {
-		config.interface = sfp_select_interface(pl->sfp_bus,
+		config.interface = phylink_sfp_select_interface(pl,
 							config.advertising);
-		if (config.interface == PHY_INTERFACE_MODE_NA) {
-			phylink_err(pl,
-				    "selection of interface failed, advertisement %*pb\n",
-				    __ETHTOOL_LINK_MODE_MASK_NBITS,
-				    config.advertising);
+		if (config.interface == PHY_INTERFACE_MODE_NA)
 			return -EINVAL;
-		}
 
 		/* Revalidate with the selected interface */
 		linkmode_copy(support, pl->supported);
@@ -3234,13 +3244,9 @@ static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
 		return ret;
 	}
 
-	iface = sfp_select_interface(pl->sfp_bus, config.advertising);
-	if (iface == PHY_INTERFACE_MODE_NA) {
-		phylink_err(pl,
-			    "selection of interface failed, advertisement %*pb\n",
-			    __ETHTOOL_LINK_MODE_MASK_NBITS, config.advertising);
+	iface = phylink_sfp_select_interface(pl, config.advertising);
+	if (iface == PHY_INTERFACE_MODE_NA)
 		return -EINVAL;
-	}
 
 	config.interface = iface;
 	linkmode_copy(support1, support);
-- 
2.30.2


