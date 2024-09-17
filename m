Return-Path: <netdev+bounces-128696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB26D97B0FB
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923F0B22D60
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507817B4E9;
	Tue, 17 Sep 2024 13:50:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E5179647;
	Tue, 17 Sep 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726581007; cv=none; b=Aw29A0iTamPZWNXjpy/fYKMMcUhkma21kB9xYfFSl0kU8PJGkU+u2lkfVaQRJLYwOMDpqoMLsIMKksWOp4vSuOqGYCaonG27IbAfs4lp6ZrzgvMOnaVUysZxeUEhdi0FVo8DJ6FS+Fc+w7QLSnMX6y399mkicqRjwqock98wT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726581007; c=relaxed/simple;
	bh=gw7MvQz9a6KdHMGP6jgz3vO72yePOn0tXs7Cfib63Tk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGy7inZ+dVAx4UOcgIDFKRJNtAjM3HAAdSzPUWKIXNwFqRschMuuhuO8/noOuHb/KwD/EM82YilytqsjKoP7Vs0e1KWJj+RGwOL7tq7Pye+OqVPncs8mX1U/OqarrQH1zH8ewLgLsvhdCurD/KEhMrSzqc/vBc4kDIHlemLhaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sqYac-000000003CM-3Qjc;
	Tue, 17 Sep 2024 13:49:58 +0000
Date: Tue, 17 Sep 2024 14:49:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: phy: aquantia: fix applying active_low bit
 after reset
Message-ID: <9b1f0cd91f4cda54c8be56b4fe780480baf4aa0f.1726580902.git.daniel@makrotopia.org>
References: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>

for_each_set_bit was used wrongly in aqr107_config_init() when iterating
over LEDs. Drop misleading 'index' variable and call
aqr_phy_led_active_low_set() for each set bit representing an LED which
is driven by VDD instead of GND pin.

Fixes: 61578f679378 ("net: phy: aquantia: add support for PHY LEDs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a59..650df261eea8e 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -478,7 +478,7 @@ static int aqr107_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
 	u32 led_active_low;
-	int ret, index = 0;
+	int ret;
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
@@ -505,10 +505,9 @@ static int aqr107_config_init(struct phy_device *phydev)
 
 	/* Restore LED polarity state after reset */
 	for_each_set_bit(led_active_low, &priv->leds_active_low, AQR_MAX_LEDS) {
-		ret = aqr_phy_led_active_low_set(phydev, index, led_active_low);
+		ret = aqr_phy_led_active_low_set(phydev, led_active_low, true);
 		if (ret)
 			return ret;
-		index++;
 	}
 
 	return 0;
-- 
2.46.1

