Return-Path: <netdev+bounces-133411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB06995D78
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DC91F25E06
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AA481A3;
	Wed,  9 Oct 2024 01:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921751D69E;
	Wed,  9 Oct 2024 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438910; cv=none; b=rvPrpoQsbCidKZBap3Hnx5noodzCaM9h/HGTvm2BPFAgAn6Je6Pn/QegOCu+sbAnU2/vEjxFciNS+R9qxMs+QwTM259zQntW7q5zNewRXJfFgx6fSmoD0vFpA1e9Lxg46UAVO1M8z+ajtjanoJzWDJ7LN3z+sxsJHleRf/Rwybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438910; c=relaxed/simple;
	bh=4QybyFI5BeHIub9LUUFOIe0xEtsKHGv0EB6XlnLBAqg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ZkPLSzWq6rx0JlaEfAj2GQhMeIKr5OjODdhVsmlKSMwBwuqqTCNBfYXpGPtZMr7j2wWVDG5qyaWU3BkC1xO8Sho009n9ukhijpgHVVn9eisYsh7GQngdccIBlVp68Kq5nEcPjqdnMPkjFrCRuogN5xpWlKhr5my17iJsnuzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syLur-000000003I6-06w3;
	Wed, 09 Oct 2024 01:55:05 +0000
Date: Wed, 9 Oct 2024 02:55:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: phy: realtek: clear 1000Base-T link
 partner advertisement
Message-ID: <533a65aa7191f03633b6af119ef6f01e5d5a8ee5.1728438615.git.daniel@makrotopia.org>
References: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>

Clear 1000Base-T link partner advertisement bits in Clause-45
read_status() function in case auto-negotiation is disabled or has not
been completed.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 895008738ec0..49b47341c17e 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1033,6 +1033,10 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
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

