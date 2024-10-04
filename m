Return-Path: <netdev+bounces-132122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31AF990835
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896DE1F215A5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437A1E378B;
	Fri,  4 Oct 2024 15:46:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7651E3781;
	Fri,  4 Oct 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056814; cv=none; b=ELAj1Kz4uekQjs3FjNSZ55au5umlVqqmnDJpirI45onwHjUgNCY8p+4bWj/hUJ/BG4WdlMAktC9B12h0nJnJExLeQhIGkY3nABt6o+yBdUvX23i/awddgSrzrJuqxwN39ndtKeF8dw77/g52PDtosqWBzw1xJ+tvuSst67zMLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056814; c=relaxed/simple;
	bh=E9NV0+0MgQ0Q59cqhh7ZaoK0E/2u0Q0LWhMKN9IPmB4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tUzTnKduvABp4DGCzw/zAYsQo8Ao0imntmhFXb8d7tWQ93k/RgyTogLIc/HwBKM/wDsfKasp6U7gh4Qcp4qSx+wqYdMxfD/exFlLtIGG/eEZjlepqBnAyN8JUfzr3xuyMEZLil8EDZHz4mTGbXUT0jOnGUkZlLOBeop1pLGpOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swkVr-000000008HC-3hfl;
	Fri, 04 Oct 2024 15:46:40 +0000
Date: Fri, 4 Oct 2024 16:46:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next] net: phy: always set polarity_modes if op is
 supported
Message-ID: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some PHYs drive LEDs active-low by default and polarity needs to be
configured in case the 'active-low' property is NOT set.
One way to achieve this without introducing an additional 'active-high'
property would be to always call the led_polarity_set operation if it
is supported by the phy driver.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phy_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 560e338b307a..d25c61223e83 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3362,11 +3362,11 @@ static int of_phy_led(struct phy_device *phydev,
 	if (of_property_read_bool(led, "inactive-high-impedance"))
 		set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
 
-	if (modes) {
-		/* Return error if asked to set polarity modes but not supported */
-		if (!phydev->drv->led_polarity_set)
-			return -EINVAL;
+	/* Return error if asked to set polarity modes but not supported */
+	if (modes && !phydev->drv->led_polarity_set)
+		return -EINVAL;
 
+	if (phydev->drv->led_polarity_set) {
 		err = phydev->drv->led_polarity_set(phydev, index, modes);
 		if (err)
 			return err;
-- 
2.46.2


