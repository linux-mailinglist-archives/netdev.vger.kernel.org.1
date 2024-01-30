Return-Path: <netdev+bounces-67037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93B841E8F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D071C2656C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06958108;
	Tue, 30 Jan 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gJ98xZGU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179B57883
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605256; cv=none; b=T6Ih/SlubpRgL9gsfBI11L8l0AR1IbNIFeBAgrcCr+FrUN1OhYiPXc4Y7xRkBTbYYSR94SzMsrr5yu5gYicMEnoYTTDNOXDSjYTimJ8rJWdgil6SR3Q2IaIcJdyyVv6X2pVO7DTszQHxU3adiCthqi8PDrloSuGPJ+ITsDp67vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605256; c=relaxed/simple;
	bh=rHmb+EnY552iAwyThZzrxep75BZoEz2Kwh8tIxuy7S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dpW7U3SBYQ6bphr87IQQbccU3B/dZgyXtPCTljhIkbsQMLsjwGhzbAcvoALFmx8Y6ekgQdmLvStBylUsr+2lAHmjHFHaBuzebF+84vYHqYkg4jPIqp9/CbQXGQ35mOxYO2q30ogtOrxPtTKdkxJzKQP7kG+tWT5dmpWJj2gDk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gJ98xZGU; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1706605253; x=1738141253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tvz70IdctJnKsbqofsJWErVfvjXtAjx0RF9ovOR/Eak=;
  b=gJ98xZGUjGfanfsjXjvT7NXnUo3jJm1vniYtTiuWupcwV4yroU8TDRRF
   rwWuzt8A3Drn97Vw2B9ePSh2881NUSUQPXoSoqSth2KTbCQ6ZX+92tptd
   f1i1Q3JP3D40qs+5z5e4mwaqJ7BrEcsCtXOz16h1Zsc2TVWTrLoXvgKEP
   x98UP2r1IxVZPQjMI59+Chmftc2wT9jerLCBtdac70tJLSgzpdqQ2XuEk
   KqiFDVvllFpkDj2okUDKDN193Hi+SFn6ChdNPleTaXt7+Hkpg1tvBFF2s
   ABPqRb4sN7DhjDeRO34/548hJGPUI68tqIkLIPy1Wec0OX+Z/seXZa6tl
   Q==;
X-IronPort-AV: E=Sophos;i="6.05,707,1701126000"; 
   d="scan'208";a="35141042"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Jan 2024 10:00:45 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2E4F6280075;
	Tue, 30 Jan 2024 10:00:45 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] net: phy: dp83867: Add support for active-low LEDs
Date: Tue, 30 Jan 2024 10:00:43 +0100
Message-Id: <20240130090043.663865-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the led_polarity_set callback for setting LED polarity.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
With the addition of LED polarity modes, PHY LEDs attached to this PHY can
be configured as active-low.

Note1: This callback is only called if at least once bit of 'enum phy_led_modes'
  is set. This works only because active-high is default on this hardware.

Note2: DP83867_SW_RESET in dp83867_phy_reset clears any previously set config.
  This needs to be addressed as well. Same for interface down/up cycle which
  might include a hardware reset as well. So LED config needs to be cached.

But that's independent from this change.

[1] https://lore.kernel.org/all/20240125203702.4552-4-ansuelsmth@gmail.com/

 drivers/net/phy/dp83867.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 5f08f9d38bd7a..4120385c5a79d 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -158,6 +158,7 @@
 /* LED_DRV bits */
 #define DP83867_LED_DRV_EN(x)	BIT((x) * 4)
 #define DP83867_LED_DRV_VAL(x)	BIT((x) * 4 + 1)
+#define DP83867_LED_POLARITY(x)	BIT((x) * 4 + 2)
 
 #define DP83867_LED_FN(idx, val)	(((val) & 0xf) << ((idx) * 4))
 #define DP83867_LED_FN_MASK(idx)	(0xf << ((idx) * 4))
@@ -1152,6 +1153,26 @@ static int dp83867_led_hw_control_get(struct phy_device *phydev, u8 index,
 	return 0;
 }
 
+static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
+				    unsigned long modes)
+{
+	/* Default active high */
+	u16 polarity = DP83867_LED_POLARITY(index);
+	u32 mode;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			polarity = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return phy_modify(phydev, DP83867_LEDCR2,
+			  DP83867_LED_POLARITY(index), polarity);
+}
+
 static struct phy_driver dp83867_driver[] = {
 	{
 		.phy_id		= DP83867_PHY_ID,
@@ -1184,6 +1205,7 @@ static struct phy_driver dp83867_driver[] = {
 		.led_hw_is_supported = dp83867_led_hw_is_supported,
 		.led_hw_control_set = dp83867_led_hw_control_set,
 		.led_hw_control_get = dp83867_led_hw_control_get,
+		.led_polarity_set = dp83867_led_polarity_set,
 	},
 };
 module_phy_driver(dp83867_driver);
-- 
2.34.1


