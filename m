Return-Path: <netdev+bounces-94855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660358C0DEC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAA2B20B17
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5F14AD1B;
	Thu,  9 May 2024 10:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF714A600;
	Thu,  9 May 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248866; cv=none; b=Te9K6JV4zg9Jm33/6clEBGeVUF3GVQ5r9A3OlIkYeIir9F1wjbHvsnG6S1eKsUemQJ2Yw9XzNLmMPAZNtfMn+4zofuG7QVE++4f8ANuT4gN2849ADuL65d9VnckydSPAIKNRcEc0crWM9SApXo2JNSzD8nfS8E5tOu6XRyddenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248866; c=relaxed/simple;
	bh=08JimUmQRxTjn4B+q3auuFtqKI5+6brRqqK5PHYKf7Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NpRz1NssUTt4kKFOzBfhaZLb88NioEfz163TTRNWNal+8LMLxT3r5SGHbq6uxV+u+dKmeZfHt1Jg0a9vgZV1uP1ghAdeAO4wn14Bipg4TX1OMufteZ3ks1HHLgQoSJu8i8x896CZyBN77JW70jYJIqkOJsijTxzI8BBnRY11zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s50a2-000000006oK-40ff;
	Thu, 09 May 2024 10:00:51 +0000
Date: Thu, 9 May 2024 11:00:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: air_en8811h: reset netdev rules when
 LED is set manually
Message-ID: <5ed8ea615890a91fa4df59a7ae8311bbdf63cdcf.1715248281.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Setting LED_OFF via brightness_set should deactivate hw control, so make
sure netdev trigger rules also get cleared in that case.
This fixes unwanted restoration of the default netdev trigger rules and
matches the behaviour when using the 'netdev' trigger without any
hardware offloading.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: send to net-next instead of net tree because driver is present only
    in net-next tree. Improve commit description while at it.

 drivers/net/phy/air_en8811h.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 4c9a1c9c805e..3cdc8c6b30b6 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -544,6 +544,10 @@ static int air_hw_led_on_set(struct phy_device *phydev, u8 index, bool on)
 
 	changed |= (priv->led[index].rules != 0);
 
+	/* clear netdev trigger rules in case LED_OFF has been set */
+	if (!on)
+		priv->led[index].rules = 0;
+
 	if (changed)
 		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
 				      AIR_PHY_LED_ON(index),
-- 
2.45.0


