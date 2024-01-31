Return-Path: <netdev+bounces-67447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46384384C
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 08:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07201F26EC2
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4355C2D;
	Wed, 31 Jan 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RvrQ/caU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28D5DF35
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687460; cv=none; b=T078Pi2vpxieEIYYIuxHBxo5rPPRf9fEKdjvj1hjOIIgpKqork5f7uogCYoT1K43KVDNsAAVNvjIk4FpUwYV56jAm0VSvalJ0/mN55LPrbglK/iYzT38KBEQh31XFTZXgXuQuWoqIzOzZwUHmQ9Tt8pFDrGPClXSKbZshfYzO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687460; c=relaxed/simple;
	bh=Wc0xOVIWckfRHHIOn/q+oHdUUmf63oj788j1ZPHCFSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWYhCH740zKTPd8vDxOBuyNuyzOaSxhi30y+iVRxLUqLOKj79KDulzGoae4EwmQhdPawIvOQ5sL5RtXnKZR+Xz8GedOO9q/WBzVW2M7yliYhX4DKVXmAGrG/Pz40nL1d9/fGdCZUQni4hdyoBtYpM+217ZSSpMiZQcmy5IxVQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RvrQ/caU; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1706687456; x=1738223456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KX4ONkvDBzPCJ/JU8NWuUGEp9jRU1yWD5msoD5yYawA=;
  b=RvrQ/caUMyhzSTuiyVAvwShp0Aq/r2ROdJirDuk6itUKVRPzVJbd6tfB
   fxBWOLpCsAAsh4auylTCrntZnU1mBHLnxNHB93Eau6A98Zq2tl1rF3eKq
   tGA59oIICHSha5yaAB4mRETSFKeHqrnwi5XNXX2whDVFJg2McdyopuQnm
   3d2a0CuUde/kbuePoNxXjkRBg6X8XwTA87WGTGTy7aIeKvMieelzAJJAW
   A5lukBCprbmfJlBL4nC8+dMSckTbJEPE+fD+OwKqpfAWUXvMYEMpqud6r
   xovbklOj5+WeLQtFaNxHeHlzNNbTbJpnxRQavKvsqzkDZpSU9Nm19Wav+
   Q==;
X-IronPort-AV: E=Sophos;i="6.05,231,1701126000"; 
   d="scan'208";a="35162019"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2024 08:50:52 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1718B280075;
	Wed, 31 Jan 2024 08:50:52 +0100 (CET)
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
Subject: [PATCH net-next RESEND 1/1] net: phy: dp83867: Add support for active-low LEDs
Date: Wed, 31 Jan 2024 08:50:48 +0100
Message-Id: <20240131075048.1092551-1-alexander.stein@ew.tq-group.com>
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

This is just a resend with target tree named in subject

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


