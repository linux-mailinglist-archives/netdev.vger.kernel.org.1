Return-Path: <netdev+bounces-203253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8CAF106E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47FA1891938
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617DA254874;
	Wed,  2 Jul 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yYTtOF1O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E862571B9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449515; cv=none; b=UFoCssA4aiMbg/UmGSXz4HxTQIO6xxrb/s1pn2Z4h14kzp4bw3csb9NHCN76ZQS2sQqIoDYaHXBdXKaHS6oIXJ9TdTzvAscpVSM4X4bAVTyfDwsXEIQJu4UltVyNezSpnTJWd0Gf77JeYZ/aojel3zPn/4QRkbXKkrDn/KXym+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449515; c=relaxed/simple;
	bh=F9VW0d2Ycp8QnyLV8O0KgdwwvVlaoH//h4zVs3OY3b0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QhvZzWQGtQk+ds3u4LANmNCASvD82JXm4bScJXRo3l5GbIhNKjtQ2e7Ohjj++zPg+3oFz0c/yrq54KMuTFYKm02EPYG5m3dCJEqFKpFTkdirwqdKOHDdHGCeuCUOdX0ouV7j/UkW91nPyUjja/fkBarFfbcBge8LeiitGhTaRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yYTtOF1O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vz52zhiNVquPSLOpcWpWV/7ThJP+LhGH80lqUgQrr20=; b=yYTtOF1OOAQ1tbTrem7O9PfaJw
	cDrJxZyPu09keLsf4s1jNwllDt3PXE9/zSqRKo943jn4mcHBTzAYYzBGiSz7wdh58XC7+l0i5ySaR
	4k/kvtN3gafRCZAvIr6ka3Y6MtzB97tkf2XWuGr281rSvr8SX34uA/srNQYqXexvMujtRVWIYhI2G
	yOCQ+1CwUl0vMi9MTXmTdeT/ukRlC67OE9ZbrURvPUD0Ml/o+lptFNcVvGXQhxMGjc1hwdu4KeCbR
	BUV7k6UeYXolgRIfT7RRvfXFtlWMZD/lkXk6PJzBRI/QytAFn4xv8ufLqbbozj6FN5o8CrzSBNHOn
	BjQBnM7w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52892 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uWu1a-0007OF-03;
	Wed, 02 Jul 2025 10:45:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uWu0u-005KXc-A4; Wed, 02 Jul 2025 10:44:24 +0100
In-Reply-To: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: phylink: restrict SFP interfaces to those
 that are supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uWu0u-005KXc-A4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 02 Jul 2025 10:44:24 +0100

When configuring an optical SFP interface, restrict the bitmap of SFP
interfaces (pl->sfp_interfaces) to those that are supported by the
host, rather than calculating this in a local variable.

This will allow us to avoid recomputing this in the
phylink_ethtool_ksettings_set() path.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 67218d278ce6..6420e76f8ab1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3582,7 +3582,6 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 static int phylink_sfp_config_optical(struct phylink *pl)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	struct phylink_link_state config;
 	phy_interface_t interface;
 	int ret;
@@ -3596,9 +3595,9 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 	/* Find the union of the supported interfaces by the PCS/MAC and
 	 * the SFP module.
 	 */
-	phy_interface_and(interfaces, pl->config->supported_interfaces,
+	phy_interface_and(pl->sfp_interfaces, pl->config->supported_interfaces,
 			  pl->sfp_interfaces);
-	if (phy_interface_empty(interfaces)) {
+	if (phy_interface_empty(pl->sfp_interfaces)) {
 		phylink_err(pl, "unsupported SFP module: no common interface modes\n");
 		return -EINVAL;
 	}
@@ -3614,14 +3613,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 	 * mask to only those link modes that can be supported.
 	 */
 	ret = phylink_validate_mask(pl, NULL, pl->sfp_support, &config,
-				    interfaces);
+				    pl->sfp_interfaces);
 	if (ret) {
 		phylink_err(pl, "unsupported SFP module: validation with support %*pb failed\n",
 			    __ETHTOOL_LINK_MODE_MASK_NBITS, support);
 		return ret;
 	}
 
-	interface = phylink_choose_sfp_interface(pl, interfaces);
+	interface = phylink_choose_sfp_interface(pl, pl->sfp_interfaces);
 	if (interface == PHY_INTERFACE_MODE_NA) {
 		phylink_err(pl, "failed to select SFP interface\n");
 		return -EINVAL;
-- 
2.30.2


