Return-Path: <netdev+bounces-134223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B4B998728
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD111F224F3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F411C7B8F;
	Thu, 10 Oct 2024 13:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADE1C5781;
	Thu, 10 Oct 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565666; cv=none; b=GtE1UTupiN6ywvQXwTSMplyS3LUNDE5qBzRa6BVRL87fYjL0VPAVgsmQZPBbL48jgOTgGRmmtBRrSvMUWW7z4GY2ZZi5kSncKdUZ8IwM2YzIguI/3RCGwBDBSjWr/H7i0dZGXo2q096+8CLxShIE9xgkGxmanZQez8ZNdOnKVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565666; c=relaxed/simple;
	bh=zPVg2gMyVqA4OZwd/+kF2oYfU8SMlv/jurD8ILW1QXI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umgvYVCkJ2u6h3LEbKaDGunhb0pFM3zbgc6GhzEkV4LhZamJ9ywYGhzGdq1M/OQ8sGBWU6EevvsW2IrPoSo7eg3wEpx38zoQNnji53fkdLfIjZC5uKHN6JY1t8OLtjJj6clNE0drkmN0sPY1rhXjFZKr7nljMqUxVBzw/HKYk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1systK-000000003GE-0Ftn;
	Thu, 10 Oct 2024 13:07:42 +0000
Date: Thu, 10 Oct 2024 14:07:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: phy: realtek: clear 1000Base-T link
 partner advertisement
Message-ID: <9dc9b47b2d675708afef3ad366bfd78eb584d958.1728565530.git.daniel@makrotopia.org>
References: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>

Clear 1000Base-T link partner advertisement bits in Clause-45
read_status() function in case auto-negotiation is disabled or has not
been completed.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 831089583845..dd7e857b481d 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1026,6 +1026,10 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	if (phydev->autoneg == AUTONEG_DISABLE ||
+	    !genphy_c45_aneg_done(phydev))
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+
 	/* Vendor register as C45 has no standardized support for 1000BaseT */
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-- 
2.47.0

