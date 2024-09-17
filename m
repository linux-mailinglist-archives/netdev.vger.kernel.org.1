Return-Path: <netdev+bounces-128695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A497B0F9
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC5B28D10
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6117107F;
	Tue, 17 Sep 2024 13:50:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80C4C66;
	Tue, 17 Sep 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726581004; cv=none; b=qFFafPVeEni3wtMP+1bJQaKQ6AzRUadv1a7VJPYbYbVuByOx9aduzjonNk/I1dzy9aQyE6bhjfztQt//tr+0EDx+4T1N8bHt2s/6FTY1Bv+0mieer3SqVXutC8u2Vtz3AAkhZ0XACeEAO7Fi0T3HlCZiIFGxNrdgcQe0WVCZ13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726581004; c=relaxed/simple;
	bh=w0vN3DG+jikGbQ6GCYnGSvqU3lD9wxY+HLMk2hyPE3c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AB46AL0HB3LHO1ziiNfsFkqK2C7pLmaojTYbD7do9UER3Druq2xMso6df9LnIbuLX9Kq8MtQpFveasbverOU71Vb8Aj9LaaxcBBkwM0kVwHhv2E/dm+gKhN2cguE+SRwJP143Vm4WW3yD4YMR+rCaTRHQTTkPcaACyLAMuCSE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sqYaR-000000003C2-1aRP;
	Tue, 17 Sep 2024 13:49:47 +0000
Date: Tue, 17 Sep 2024 14:49:40 +0100
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
Subject: [PATCH net 1/2] net: phy: aquantia: fix setting active_low bit
Message-ID: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

phy_modify_mmd was used wrongly in aqr_phy_led_active_low_set() resulting
in a no-op instead of setting the VEND1_GLOBAL_LED_DRIVE_VDD bit.
Correctly set VEND1_GLOBAL_LED_DRIVE_VDD bit.

Fixes: 61578f679378 ("net: phy: aquantia: add support for PHY LEDs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/aquantia/aquantia_leds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_leds.c b/drivers/net/phy/aquantia/aquantia_leds.c
index 0516ac02c3f81..201c8df93fad9 100644
--- a/drivers/net/phy/aquantia/aquantia_leds.c
+++ b/drivers/net/phy/aquantia/aquantia_leds.c
@@ -120,7 +120,8 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable)
 {
 	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, AQR_LED_DRIVE(index),
-			      VEND1_GLOBAL_LED_DRIVE_VDD, enable);
+			      VEND1_GLOBAL_LED_DRIVE_VDD,
+			      enable ? VEND1_GLOBAL_LED_DRIVE_VDD : 0);
 }
 
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index, unsigned long modes)
-- 
2.46.1

