Return-Path: <netdev+bounces-209599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338A5B0FF4B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3184318801BC
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744362036E9;
	Thu, 24 Jul 2025 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMoJ3hfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F1201032;
	Thu, 24 Jul 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329206; cv=none; b=MsUaNbW/0k8YPjAay38ATJb7VTW+8a1kwioNH8NqNBKajPPIJ7IAVJHcVqeI8SojTlSa3BWx/Ej4VT8v+i5yERjghQwNejgkCYMD5XMsh+djtPteyOO1duA74aVCNm5V+s32OpsZewNIzZU8s+XwEV1aqPTyLlDRPEY8a9FcMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329206; c=relaxed/simple;
	bh=s+DYAPygR7QABwkMy1kuAl0KvT18/m32U9o1kCTztoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlOr+aJ1Jbd43b12DGpjcH610zQ7Rf0d/xvEZCAtg7tF4sX7cXcUfJvoKT7hWLCus4A+ZAYad/6Jpj2kt3gx9vL+dcjsXdFdP2b9pS9sSDa2lW0LYosuwlG37WLsRxb6tloM1JzFuynvApfWpq9VTp8hZ/FFMFddSuZ/i18pJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMoJ3hfi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23dc5bcf49eso6461255ad.2;
        Wed, 23 Jul 2025 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329204; x=1753934004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1BoxLpkkj9AbGYyPDPLJTBBxn9urvDL6x3z1tJIhGA=;
        b=QMoJ3hfik/ng2kd9qvaL1mGGbSzBQ6kMdzTemh9/Wae4tAiKo2mxXOHKYbntvWi4gr
         ugOsnPaxD88+EZcJa98QEYu6SiUT9GsorEDVuNRAf35UryU1CX3SDxd2IqcYlt4bEK2M
         bo2KSSaXZgRm9WcUswdLOzRZtWy3zR1A/ly0mfLyNGPsnDq6C9QBoDnStXaZUh4kSYWP
         vY24dau8+x8+xD8AGOQvhWiDfQuzvoviiVcDy1CrWNKzd5NurCY8Fzz2mab3dqf7ScJm
         p7NydFmEolwUkhlEdzjCdvRF8v7M0C9CfhWWrc4++m8V5ttIAi3MZY/oNG4xflq69V/M
         Tt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329204; x=1753934004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1BoxLpkkj9AbGYyPDPLJTBBxn9urvDL6x3z1tJIhGA=;
        b=W8lwlkexbglE+uGxZntmYeiIAPhJzM6UrudqWlk0GZGQVeQKc9I3rna0yEPWW0y7KC
         3nSyYHvZeJPDGyTU0PAgN+F7A9ODVAJTsiNWIoz7s2Il61H5UlVnidrb9CPbg6gcm7aR
         I4YCYHgLei/oR7KUyDcqwTT8J1ocb1Y4qPdJGSmNTyXAyzwRE3CHCU1trLZm1s3ZnlHZ
         kFJqQdbk+L9yB+p7eRxtNTAY+BqZ2uQ7K8FWaM90x4thx+Yv5XYgQ1sabPGr8Pu9qsQS
         uKXrG+XzAaZjk7B2mrWKeq25CsVeXeYrb/s1jGo8NxIija3rOj7ukfx2Goi12yeW99kv
         SAUw==
X-Forwarded-Encrypted: i=1; AJvYcCU9mcWaXUKNIECUIjGB/xVVpoMhOE0HAaxzx+nHmnDX/o7rT45EBFppcKuhwLBwWyAOHbdI91YpEb/u@vger.kernel.org, AJvYcCV5g2JwrCjPZolmGixRH1hBm/05YuCtePnVjvzU8C0ws+k+YT8kQV/3d7t6pDdoEMTHFVM6doWu@vger.kernel.org, AJvYcCW4tOW1QJT8GTPuqXDpWAXhL2+r6wGawWEvjbm3u+prkhcH9K4f5H39lrNA9YzkaMi94s7LtNLyoE50/3Au@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtWf062XfVk0YJIwupyO2/ynduFJqN7cXC4Tj4FeeIf1pHMH1
	n06VHU9l2ytb21SOvUc8pTTuRuTZ1ff7at1MHldOAudLv3N8WFuihK+z
X-Gm-Gg: ASbGnctGBeuV5utfCPEYM5QBwLf779ccrBo2quxlcgVGjAD1dURaaa/ErbfgHKn8uQS
	rVEDW7hmjtxBOuJbJMxgBwu2WCqMSFozDjLLrFtgVdWDL+wvNNjJxp4JbJoOscR0Fhtdl0g2VKq
	bHo8ZYpW3vvfQBwh6fCr9+NgkPfHFUO/LpiWiXtl0VyKTSsiY6sUsUxs94GvjTwqO6xvq2S/OsS
	k110dLKcoXOcvS6yl4mLa0I2Tc0npVuFhkV5GHbREqpYwTQmQuIJcUnNk2CNQnY2/ZJXpcWrXgH
	FQYgAgvdHcDX460m4Cy9GRfDKSHYMRhNru9ghWHUKIK4jY+VjOmyXJpy2iBoo1hSJA2riP+WO89
	roMt1BEj2G2He1GOa9cUeLcs7AHfWJS3WQB3MDxdL
X-Google-Smtp-Source: AGHT+IGR3rBEmvSdGEZ+vR0Y0ckdnOlNeD5W3SJCoTeL8g1TLoqu6IwgcFeQmzvXa0yz0nO8eHI/jg==
X-Received: by 2002:a17:903:11d0:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23f981943ffmr75704015ad.31.1753329203997;
        Wed, 23 Jul 2025 20:53:23 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/7] net: dsa: b53: Define chip IDs for more bcm63xx SoCs
Date: Wed, 23 Jul 2025 20:52:42 -0700
Message-ID: <20250724035300.20497-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724035300.20497-1-kylehendrydev@gmail.com>
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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
index c687360a5b7f..f97556c6ca2a 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -348,16 +348,16 @@ static const struct of_device_id b53_mmap_of_table[] = {
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


