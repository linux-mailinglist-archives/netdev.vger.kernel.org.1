Return-Path: <netdev+bounces-152507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F129F45B5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C8016D907
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C087D1DA113;
	Tue, 17 Dec 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCcn0jKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA3126BF7;
	Tue, 17 Dec 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423062; cv=none; b=RChIalZcGys+7RyuIPmDP3VXgmLXvH16Gx6FAqqTGShDrPh1x4QPjIwCkX/N/stJpHj3oSydeQvgbU22Xzr4eBWB2LsAyvU2Rhru1zy/tM0SMIx4WZU9u0DwtIecZg5BfEmz9NzEpsg9nUjSHziivrHCyKmQHd5zundlPr7E1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423062; c=relaxed/simple;
	bh=2z7JFRJcAUvGHRU71NcCuaR1lyuqm1pPGOs2diBBCOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rsWRKt7S1WFIkvyBllzSGKn8QsRTkFMHAMaM9hzSVhatlO7Yys2sPy/RTBvS8uz5NKg30oGlDzaLG47uWraC2d79OWqmAfQNWyCeVVX9oJ4PRLICKlui+AiC7L8DE0gWl3/QFXsuot2fa2CaY/Comvd8ZzuZxeDPKHt7Phs/AGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCcn0jKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC72C4CED3;
	Tue, 17 Dec 2024 08:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734423062;
	bh=2z7JFRJcAUvGHRU71NcCuaR1lyuqm1pPGOs2diBBCOA=;
	h=From:To:Cc:Subject:Date:From;
	b=DCcn0jKeLG2nM+e/bAZpIHfhSxtAPAyFHhu9PB3rgk7JyBxywwxnYpxmlsZgBSFLl
	 vD7upSsrHYfVwu0GKcZ/MZtAPUkWDA/lWsOyat7JRqK5sNvIqeGUdbs5inYV+jAD85
	 JAOO81JRbpEljrKzneVZdaFRNsKODU1EThVxWTExIb/Gpn7YG9LjtweW1Rv1dUzBrJ
	 UQWtGAmwRECgdYcMRX7HsD8SYSOuTqtxsg+RlTtznEb3F3obrH0RNyTYiR+fpbbuhX
	 ll8jbuJfzaNbdmP2RcM3QMCDpPUz4pnA9fyZMjcEV1zQoqdGCaDTJ+WfEv09kPCd8/
	 s+kCsIjDMjHaA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>,
	Daniel Golle <daniel@makrotopia.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: avoid undefined behavior in *_led_polarity_set()
Date: Tue, 17 Dec 2024 09:10:34 +0100
Message-Id: <20241217081056.238792-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc runs into undefined behavior at the end of the three led_polarity_set()
callback functions if it were called with a zero 'modes' argument and it
just ends the function there without returning from it.

This gets flagged by 'objtool' as a function that continues on
to the next one:

drivers/net/phy/aquantia/aquantia_leds.o: warning: objtool: aqr_phy_led_polarity_set+0xf: can't find jump dest instruction at .text+0x5d9
drivers/net/phy/intel-xway.o: warning: objtool: xway_gphy_led_polarity_set() falls through to next function xway_gphy_config_init()
drivers/net/phy/mxl-gpy.o: warning: objtool: gpy_led_polarity_set() falls through to next function gpy_led_hw_control_get()

There is no point to micro-optimize the behavior here to save a single-digit
number of bytes in the kernel, so just change this to a "return -EINVAL"
as we do when any unexpected bits are set.

Fixes: 1758af47b98c ("net: phy: intel-xway: add support for PHY LEDs")
Fixes: 9d55e68b19f2 ("net: phy: aquantia: correctly describe LED polarity override")
Fixes: eb89c79c1b8f ("net: phy: mxl-gpy: correctly describe LED polarity")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/phy/aquantia/aquantia_leds.c | 2 +-
 drivers/net/phy/intel-xway.c             | 2 +-
 drivers/net/phy/mxl-gpy.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_leds.c b/drivers/net/phy/aquantia/aquantia_leds.c
index 00ad2313fed3..951f46104eff 100644
--- a/drivers/net/phy/aquantia/aquantia_leds.c
+++ b/drivers/net/phy/aquantia/aquantia_leds.c
@@ -156,5 +156,5 @@ int aqr_phy_led_polarity_set(struct phy_device *phydev, int index, unsigned long
 	if (force_active_high || force_active_low)
 		return aqr_phy_led_active_low_set(phydev, index, force_active_low);
 
-	unreachable();
+	return -EINVAL;
 }
diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index b672c55a7a4e..e6ed2413e514 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -529,7 +529,7 @@ static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
 	if (force_active_high)
 		return phy_clear_bits(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index));
 
-	unreachable();
+	return -EINVAL;
 }
 
 static struct phy_driver xway_gphy[] = {
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index db3c1f72b407..a8ccf257c109 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -1014,7 +1014,7 @@ static int gpy_led_polarity_set(struct phy_device *phydev, int index,
 	if (force_active_high)
 		return phy_clear_bits(phydev, PHY_LED, PHY_LED_POLARITY(index));
 
-	unreachable();
+	return -EINVAL;
 }
 
 static struct phy_driver gpy_drivers[] = {
-- 
2.39.5


