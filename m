Return-Path: <netdev+bounces-99872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594138D6CDF
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8141C2182E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5984DFE;
	Fri, 31 May 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjTTIvQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C2134BC;
	Fri, 31 May 2024 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198524; cv=none; b=nHW60hmpu7yb6U/OFceeA96+CyGUKFwHg62pYnvg44ftu+bcW8FSFc+9PDgdYgHO3TcEWOpsepeuheKMUIPHpL4HtG0yqRg2K9mBFBculkZ1wmwlVe6k2xl/sIYk6H3kcH68AIBFzXD4IfbVGS/hWNrX3IBOjWO/Edk3CATN6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198524; c=relaxed/simple;
	bh=I2euR1rg97urE6SjnpaHdDD1hdP1+v1K5hV2TTGSHho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oquxPy8Zodwd6DPQ4IfxB61zehHD+qxRf1rBOnGKj5j6kUVNx23rQBYq8z4XAPcwGxUQTiI3jIiQ2Uk5sjHARnVOzF6yYlW51V5qOGt9ihRLCiUI4eCxvRblxdSnrB5OA29agXDvXMZC+LKvRmpslEA/r6GusSIa4ySqFV5Cx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjTTIvQS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42121d27861so24514135e9.0;
        Fri, 31 May 2024 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717198521; x=1717803321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW2qvjJrTnZwL1/2NhmaAVU1+pTJQnQOA3xzWTN0ygQ=;
        b=GjTTIvQSCTkgTa6l617GU36UxSOjJwWDtj+BQ+0qZD9qxx6qqPrR/8F20/bA6keO1K
         kpw02ljzkZEezYUfLnC6X6jzlfvdruqeM4CdvyTO7pV1gJXGc6zh8F20UIMOiN5nKccj
         faylfLZGZ8PAIxXsjN5z1bwg1xDbV1RVw5W9yiOgLyC0mO9nT3jMCDrapWUhUMFNBOd8
         bkkb3xibTpa24/bAwCb8DmLj8/NN4kcIV41IUQAYvJ9Dmcx5D6MMonxH0r5imAWvQ0ah
         E6yPc8JBnbqSaoQUbYDLyDF/Z/OlkC9LxG5TGGDnWS0IU61X+SwC0SN1num0VIcmLJJT
         KoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717198521; x=1717803321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW2qvjJrTnZwL1/2NhmaAVU1+pTJQnQOA3xzWTN0ygQ=;
        b=ZbMl+msqxAfgvCblCbRsKs4pPaI+IChCvsJ5GAvjQphD0E7ybGOHRpgW8lr17TsOUV
         yDg4yrZDfN16fM3X7OvuBTG/NAQJ9H5Xt7rcvI1yQKYOHjGemqgQck4pom1CnU9Qlcqb
         Ci1ZNCl9lgrkBhEdAxVBWHPAOH0tgJM9b7RfWZVQRHLfv4MtPZUP+sLj0lu0XcfD3Kyh
         TJPAjmNr5a+FxRma3j7sg6jsytul3V5O20xFzm6q6OC2Dnrmxhb9R0y89GdUAw1mMAOd
         SYAs75D2hg2yaENjZnkdkZE2vu8+kZ6m7oucANSM8Yo3utFjKCItXk37S8YwGDCEidjb
         yG+w==
X-Forwarded-Encrypted: i=1; AJvYcCUIGqvdnI0ICYDb40Ba7DM3GNWyVXnBTHCe1JNSJodkgLQLUhWeBSuoH25XGCcTNZne6R6zo42RR8c6k1E1gp4V7Q7EZyXXXO1eN9FYMZnTmAfwsdqhQz+ZUySu1g45eR7QUDtZ
X-Gm-Message-State: AOJu0YzHZ0Dtg6ZpduNKW0wEJ8vDJJ9p+jLynggIYAv8ZioRe/eX3VnO
	CN4Vs16UeOLLTjNfnOnjD/Xj2SeT7n33kmF2KIk8sp+4lhxn254O
X-Google-Smtp-Source: AGHT+IG4jzGUqh8PtjUvIaolkWqCqWhK6pKGtLVBHrmeVB2xqIgYR3ReD0Hdn6V5yIsxKQm1uPLajg==
X-Received: by 2002:adf:ee92:0:b0:34d:99ac:dcd0 with SMTP id ffacd0b85a97d-35e0f30bd45mr2093453f8f.49.1717198521153;
        Fri, 31 May 2024 16:35:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c9d78sm2779599f8f.27.2024.05.31.16.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:35:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [net-next PATCH v3 1/2] net: phy: aquantia: move priv and hw stat to header
Date: Sat,  1 Jun 2024 01:35:02 +0200
Message-ID: <20240531233505.24903-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for LEDs support, move priv and hw stat to header to
reference priv struct also in other .c outside aquantia.main

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Out of RFC

 drivers/net/phy/aquantia/aquantia.h      | 38 ++++++++++++++++++++++++
 drivers/net/phy/aquantia/aquantia_main.c | 37 -----------------------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 1c19ae74ad2b..c79b33d95628 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -87,6 +87,18 @@
 #define VEND1_GLOBAL_RSVD_STAT9_MODE		GENMASK(7, 0)
 #define VEND1_GLOBAL_RSVD_STAT9_1000BT2		0x23
 
+/* MDIO_MMD_C22EXT */
+#define MDIO_C22EXT_STAT_SGMII_RX_GOOD_FRAMES		0xd292
+#define MDIO_C22EXT_STAT_SGMII_RX_BAD_FRAMES		0xd294
+#define MDIO_C22EXT_STAT_SGMII_RX_FALSE_CARRIER		0xd297
+#define MDIO_C22EXT_STAT_SGMII_TX_GOOD_FRAMES		0xd313
+#define MDIO_C22EXT_STAT_SGMII_TX_BAD_FRAMES		0xd315
+#define MDIO_C22EXT_STAT_SGMII_TX_FALSE_CARRIER		0xd317
+#define MDIO_C22EXT_STAT_SGMII_TX_COLLISIONS		0xd318
+#define MDIO_C22EXT_STAT_SGMII_TX_LINE_COLLISIONS	0xd319
+#define MDIO_C22EXT_STAT_SGMII_TX_FRAME_ALIGN_ERR	0xd31a
+#define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
+
 #define VEND1_GLOBAL_INT_STD_STATUS		0xfc00
 #define VEND1_GLOBAL_INT_VEND_STATUS		0xfc01
 
@@ -113,6 +125,32 @@
 #define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL2	BIT(1)
 #define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL3	BIT(0)
 
+struct aqr107_hw_stat {
+	const char *name;
+	int reg;
+	int size;
+};
+
+#define SGMII_STAT(n, r, s) { n, MDIO_C22EXT_STAT_SGMII_ ## r, s }
+static const struct aqr107_hw_stat aqr107_hw_stats[] = {
+	SGMII_STAT("sgmii_rx_good_frames",	    RX_GOOD_FRAMES,	26),
+	SGMII_STAT("sgmii_rx_bad_frames",	    RX_BAD_FRAMES,	26),
+	SGMII_STAT("sgmii_rx_false_carrier_events", RX_FALSE_CARRIER,	 8),
+	SGMII_STAT("sgmii_tx_good_frames",	    TX_GOOD_FRAMES,	26),
+	SGMII_STAT("sgmii_tx_bad_frames",	    TX_BAD_FRAMES,	26),
+	SGMII_STAT("sgmii_tx_false_carrier_events", TX_FALSE_CARRIER,	 8),
+	SGMII_STAT("sgmii_tx_collisions",	    TX_COLLISIONS,	 8),
+	SGMII_STAT("sgmii_tx_line_collisions",	    TX_LINE_COLLISIONS,	 8),
+	SGMII_STAT("sgmii_tx_frame_alignment_err",  TX_FRAME_ALIGN_ERR,	16),
+	SGMII_STAT("sgmii_tx_runt_frames",	    TX_RUNT_FRAMES,	22),
+};
+
+#define AQR107_SGMII_STAT_SZ ARRAY_SIZE(aqr107_hw_stats)
+
+struct aqr107_priv {
+	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
+};
+
 #if IS_REACHABLE(CONFIG_HWMON)
 int aqr_hwmon_probe(struct phy_device *phydev);
 #else
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index d34cdec47636..252123d12efb 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -84,49 +84,12 @@
 #define MDIO_AN_RX_VEND_STAT3			0xe832
 #define MDIO_AN_RX_VEND_STAT3_AFR		BIT(0)
 
-/* MDIO_MMD_C22EXT */
-#define MDIO_C22EXT_STAT_SGMII_RX_GOOD_FRAMES		0xd292
-#define MDIO_C22EXT_STAT_SGMII_RX_BAD_FRAMES		0xd294
-#define MDIO_C22EXT_STAT_SGMII_RX_FALSE_CARRIER		0xd297
-#define MDIO_C22EXT_STAT_SGMII_TX_GOOD_FRAMES		0xd313
-#define MDIO_C22EXT_STAT_SGMII_TX_BAD_FRAMES		0xd315
-#define MDIO_C22EXT_STAT_SGMII_TX_FALSE_CARRIER		0xd317
-#define MDIO_C22EXT_STAT_SGMII_TX_COLLISIONS		0xd318
-#define MDIO_C22EXT_STAT_SGMII_TX_LINE_COLLISIONS	0xd319
-#define MDIO_C22EXT_STAT_SGMII_TX_FRAME_ALIGN_ERR	0xd31a
-#define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
-
 /* Sleep and timeout for checking if the Processor-Intensive
  * MDIO operation is finished
  */
 #define AQR107_OP_IN_PROG_SLEEP		1000
 #define AQR107_OP_IN_PROG_TIMEOUT	100000
 
-struct aqr107_hw_stat {
-	const char *name;
-	int reg;
-	int size;
-};
-
-#define SGMII_STAT(n, r, s) { n, MDIO_C22EXT_STAT_SGMII_ ## r, s }
-static const struct aqr107_hw_stat aqr107_hw_stats[] = {
-	SGMII_STAT("sgmii_rx_good_frames",	    RX_GOOD_FRAMES,	26),
-	SGMII_STAT("sgmii_rx_bad_frames",	    RX_BAD_FRAMES,	26),
-	SGMII_STAT("sgmii_rx_false_carrier_events", RX_FALSE_CARRIER,	 8),
-	SGMII_STAT("sgmii_tx_good_frames",	    TX_GOOD_FRAMES,	26),
-	SGMII_STAT("sgmii_tx_bad_frames",	    TX_BAD_FRAMES,	26),
-	SGMII_STAT("sgmii_tx_false_carrier_events", TX_FALSE_CARRIER,	 8),
-	SGMII_STAT("sgmii_tx_collisions",	    TX_COLLISIONS,	 8),
-	SGMII_STAT("sgmii_tx_line_collisions",	    TX_LINE_COLLISIONS,	 8),
-	SGMII_STAT("sgmii_tx_frame_alignment_err",  TX_FRAME_ALIGN_ERR,	16),
-	SGMII_STAT("sgmii_tx_runt_frames",	    TX_RUNT_FRAMES,	22),
-};
-#define AQR107_SGMII_STAT_SZ ARRAY_SIZE(aqr107_hw_stats)
-
-struct aqr107_priv {
-	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
-};
-
 static int aqr107_get_sset_count(struct phy_device *phydev)
 {
 	return AQR107_SGMII_STAT_SZ;
-- 
2.43.0


