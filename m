Return-Path: <netdev+bounces-248321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C5D06E7F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886203014DBB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA023B604;
	Fri,  9 Jan 2026 03:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385319A288;
	Fri,  9 Jan 2026 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927797; cv=none; b=dGJV6zmBN/vBVlWX41By+qzexQlrY1Ips2yV7QfXAKlx3H7sRVPaM+StPBX7cR3n88GmiPxJ8uOYgY3oOGSOknWiQEQcrp6esrpbGXQJdYEO7U++698opO9PB5EbztrfCDTsYi7UFXJvqUCaawqt3XW38GDQmAmXbhBGUR2FVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927797; c=relaxed/simple;
	bh=kO1mpmyAP2DRh5/wDZxZoieVtP2B/Fq/8rWBoXAej2A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvz3/l+pU3c2Klw3YkoahlMXftEKNGdzDMOgv/+Gj6oyvxjsg3swzaXrYP8q2tOK2Nc/UO75ut9uWpqd8Tgzo+oJwi7EKzqtVZQmteoU7A2GkJIHYN2qR+IVNwZvDatdF9NEWKFRn8CPJOjCMowhVkCYfbWXGRskEF3HMzG9ZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1ve2mN-000000005k0-0la4;
	Fri, 09 Jan 2026 03:03:11 +0000
Date: Fri, 9 Jan 2026 03:03:08 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: phy: realtek: support interrupt also for
 C22 variants
Message-ID: <1b01a903484f441c0fc2e61f7277910b2fac7855.1767926665.git.daniel@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767926665.git.daniel@makrotopia.org>

Now that access to MDIO_MMD_VEND2 works transparently also in Clause-22
mode, add interrupt support also for the C22 variants of the
RTL8221B-VB-CG and RTL8221B-VM-CG. This results in the C22 and C45
driver instances now having all the same features implemented.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index eb5b540ada0e5..7302b25b8908b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -2275,6 +2275,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
 		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
+		.config_intr	= rtl8221b_config_intr,
+		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
@@ -2307,6 +2309,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_c22_match_phy_device,
 		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
+		.config_intr	= rtl8221b_config_intr,
+		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
-- 
2.52.0

