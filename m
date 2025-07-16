Return-Path: <netdev+bounces-207328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C4B06A79
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2DB4E5E4C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFAA1A2872;
	Wed, 16 Jul 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+JRtcBD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8EE1A23A9;
	Wed, 16 Jul 2025 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625786; cv=none; b=Zs1PVJZyuNf0Xl36d5SFg23Xj/By34H6RShPT7SIvG+EceknMnkQQc3psMw/wG+qNKPR/9xMGtH0cpmwHrpQChhby9D1R8wn3BatZzhP3WK1Kchl8uXR8bBTV0m95p/hh9VXpG5wPLh+ogcTtwYhb0G9pwx93XMK1SpZG6CKzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625786; c=relaxed/simple;
	bh=0jjBZCfdtIzYBI1vEbYgQLeU2j7X9BDbeQfkakK5vKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6QCIgscWnYoome0i7iwSpOfKF7cCSYaDgUjb4+1VxZDAQdj/bb1H1jSNOrsw0TvvzizBT596SaSIebmA0Vm9qSqxaQogtI5G6KscVAx7DbJXxGMiciFRtu4luXolebWK9vO98b1A+HxbKaB8cvSnpPzw9QWPjOgUAODNLzNor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+JRtcBD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b52bf417cso3855934b3a.0;
        Tue, 15 Jul 2025 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625784; x=1753230584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmWvdu6wKIqsdKOr9VtFXu/CMv+sSUrgoUry/ap68X4=;
        b=k+JRtcBD43Rphe6Pd9LE0yYEW5IszXyC5khDY4YU4u7PYChcK0q0ZaAaVzWEOnWoPp
         C0AFng/PuTleyIWVObXHLm5BklDPzC/d2+qnleNh0uxhV1PlzHvmdUF8p8acYe4Mt9EA
         /sJF1wmQLjJlyJKa2Rg5nvVJe/c4p+RRB3yJFdBCTJ9aFLjkLTci4ni5pMH0qr3n3WCF
         oMN2W1WAgx/OYflJO1Jp+7LoayKKQHBvaQl4qT17gXtbepaDtshIUC5be1BC9cektGvj
         W6CWP/ltItWS8QubbzGlL6hHPprfhiTLzzgG2OQMgHFmxsdmJgiVj7xdXe2Zw7CVaxkT
         Cp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625784; x=1753230584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmWvdu6wKIqsdKOr9VtFXu/CMv+sSUrgoUry/ap68X4=;
        b=eIVgpQa+4WG1Y8C5O0GDrOtVpPljYVZXJCLCBYMrtCHJeZm+ovi3vAu1x3x3br/S94
         m6vlhH0PF7MMe0JOraUuasb+7FQw7qq5QClIlPy7Xg/8dmCN/uaFAzSrWPi+cv1fc2CN
         L0xBwKo3tghSNAeyLyvyE4ZiwdtxWRyUzhDYf56v84YhKyXjOAL38/5d6EZVKDBQ6NiR
         wnmX5z3NAPY8ixJdg2fOS+TFH3GE0rAo2B+l/CciWP4A6EmBveIqWibTDoSh1puVfSJs
         bw7wF6UCZM+roQNtNyi5HOf9FAdGi0aid9glmdrrvlcGTau9yC9ZF3VfzjcBlPYYyjP9
         DFeg==
X-Forwarded-Encrypted: i=1; AJvYcCUIKFKvYC9jblo+axDOI+4NkDzyj7Ov+CCYyuaDP7Z5fx1ZzXWa8um4iHySE9gbvU9PSTXtOa+0@vger.kernel.org, AJvYcCUQ9q5M5uhrxkr2oJlkuiXKqv5lj2WumMDUg/DA2FBan4ZiJ79Ef+Lye9519/a8xmXkzBtAtQHZmV4V@vger.kernel.org, AJvYcCVs1RAzR8W0imqIZmkkq+50H+lxt6XQ/C4GcIMVhDC3F43Y3f3Jeaq3sO3BkMwfIrG/tt4GMLA0x7aHxU77@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl5bv6bchTkMTYrPFxA8eFn1BqFvrTlqHnW7H6q3VV47ijpNj
	RveQyInZ88KebhJSAl8pN3nR9GU46slL/a0r0kg1XkYkCof7NyEeFDAO
X-Gm-Gg: ASbGncsqzzYadqub9CtC+gvWYOTpmBDbE124aRBR8vP4tBoJe9WxkoSCP6QDPfb/EtG
	s9a85e/cc/ZDTDXRFlT2029ygybHceYEeqlCYAxK3B1Ggn7n5rgm9JBJhbmv2U3ftZCWkr60UnF
	baGn1CdDOdp+Hv0q2UgvffgkNVDwbeaT3svsjray3YAEImBwKh+t3FLsfuXg3UbIPu+2OQX6Dqh
	GqwjMphWJU0Aj2PksgHkffs6soW4SpT1ImmhKZDkb820BqLx09HsXyVPp+xFJ12myNd0BNuizlj
	Yu4xxixuPjhhKnu/cc0XmYoys9FMjpk+uYYBQdgnWMwzn1OIHrkhPVrUK2oMc5hrtHooHIpXYtv
	SGAzKnzAmHZNe+7xeGIJORQLXIt3vPiQztEpBw3SJ
X-Google-Smtp-Source: AGHT+IEgfzA9fuTRgM+to6hjCUyfPEtCDfrWzcMhxwPm/yQzFKYV+VbfeifCFvi7QB+8+doiMo2tIA==
X-Received: by 2002:a05:6a00:2e28:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-75724872367mr742792b3a.23.1752625783841;
        Tue, 15 Jul 2025 17:29:43 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:43 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: dsa: b53: Define chip IDs for more bcm63xx SoCs
Date: Tue, 15 Jul 2025 17:29:03 -0700
Message-ID: <20250716002922.230807-5-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716002922.230807-1-kylehendrydev@gmail.com>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for bcm6318, bcm6328, bcm6362, bcm6368 chip IDs,
update tables and switch init.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 21 ++++++---------------
 drivers/net/dsa/b53/b53_mmap.c   |  8 ++++----
 drivers/net/dsa/b53/b53_priv.h   | 13 +++++++++++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 77acc7b8abfb..9942fb6f7f4b 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1410,7 +1410,7 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 	b53_read8(dev, B53_CTRL_PAGE, B53_RGMII_CTRL_P(port), &rgmii_ctrl);
 	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 
-	if (is63268(dev))
+	if (is6318_268(dev))
 		rgmii_ctrl |= RGMII_CTRL_MII_OVERRIDE;
 
 	rgmii_ctrl |= RGMII_CTRL_ENABLE_GMII;
@@ -2774,19 +2774,6 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK_63XX,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE_63XX,
 	},
-	{
-		.chip_id = BCM63268_DEVICE_ID,
-		.dev_name = "BCM63268",
-		.vlans = 4096,
-		.enabled_ports = 0, /* pdata must provide them */
-		.arl_bins = 4,
-		.arl_buckets = 1024,
-		.imp_port = 8,
-		.vta_regs = B53_VTA_REGS_63XX,
-		.duplex_reg = B53_DUPLEX_STAT_63XX,
-		.jumbo_pm_reg = B53_JUMBO_PORT_MASK_63XX,
-		.jumbo_size_reg = B53_JUMBO_MAX_SIZE_63XX,
-	},
 	{
 		.chip_id = BCM53010_DEVICE_ID,
 		.dev_name = "BCM53010",
@@ -2936,13 +2923,17 @@ static const struct b53_chip_data b53_switch_chips[] = {
 
 static int b53_switch_init(struct b53_device *dev)
 {
+	u32 chip_id = dev->chip_id;
 	unsigned int i;
 	int ret;
 
+	if (is63xx(dev))
+		chip_id = BCM63XX_DEVICE_ID;
+
 	for (i = 0; i < ARRAY_SIZE(b53_switch_chips); i++) {
 		const struct b53_chip_data *chip = &b53_switch_chips[i];
 
-		if (chip->chip_id == dev->chip_id) {
+		if (chip->chip_id == chip_id) {
 			if (!dev->enabled_ports)
 				dev->enabled_ports = chip->enabled_ports;
 			dev->name = chip->dev_name;
diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index a0c06d703861..09631792049c 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -352,16 +352,16 @@ static const struct of_device_id b53_mmap_of_table[] = {
 		.data = (void *)BCM63XX_DEVICE_ID,
 	}, {
 		.compatible = "brcm,bcm6318-switch",
-		.data = (void *)BCM63268_DEVICE_ID,
+		.data = (void *)BCM6318_DEVICE_ID,
 	}, {
 		.compatible = "brcm,bcm6328-switch",
-		.data = (void *)BCM63XX_DEVICE_ID,
+		.data = (void *)BCM6328_DEVICE_ID,
 	}, {
 		.compatible = "brcm,bcm6362-switch",
-		.data = (void *)BCM63XX_DEVICE_ID,
+		.data = (void *)BCM6362_DEVICE_ID,
 	}, {
 		.compatible = "brcm,bcm6368-switch",
-		.data = (void *)BCM63XX_DEVICE_ID,
+		.data = (void *)BCM6368_DEVICE_ID,
 	}, {
 		.compatible = "brcm,bcm63268-switch",
 		.data = (void *)BCM63268_DEVICE_ID,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index f1124f5e50da..458775f95164 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -73,6 +73,10 @@ enum {
 	BCM53125_DEVICE_ID = 0x53125,
 	BCM53128_DEVICE_ID = 0x53128,
 	BCM63XX_DEVICE_ID = 0x6300,
+	BCM6318_DEVICE_ID = 0x6318,
+	BCM6328_DEVICE_ID = 0x6328,
+	BCM6362_DEVICE_ID = 0x6362,
+	BCM6368_DEVICE_ID = 0x6368,
 	BCM63268_DEVICE_ID = 0x63268,
 	BCM53010_DEVICE_ID = 0x53010,
 	BCM53011_DEVICE_ID = 0x53011,
@@ -220,12 +224,17 @@ static inline int is531x5(struct b53_device *dev)
 static inline int is63xx(struct b53_device *dev)
 {
 	return dev->chip_id == BCM63XX_DEVICE_ID ||
+		dev->chip_id == BCM6318_DEVICE_ID ||
+		dev->chip_id == BCM6328_DEVICE_ID ||
+		dev->chip_id == BCM6362_DEVICE_ID ||
+		dev->chip_id == BCM6368_DEVICE_ID ||
 		dev->chip_id == BCM63268_DEVICE_ID;
 }
 
-static inline int is63268(struct b53_device *dev)
+static inline int is6318_268(struct b53_device *dev)
 {
-	return dev->chip_id == BCM63268_DEVICE_ID;
+	return dev->chip_id == BCM6318_DEVICE_ID ||
+		dev->chip_id == BCM63268_DEVICE_ID;
 }
 
 static inline int is5301x(struct b53_device *dev)
-- 
2.43.0


