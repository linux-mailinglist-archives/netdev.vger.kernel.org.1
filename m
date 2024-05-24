Return-Path: <netdev+bounces-98034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2178CEB8C
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E45D1F22812
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C0130AFD;
	Fri, 24 May 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVXT5RPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC634130E26;
	Fri, 24 May 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584055; cv=none; b=fM1+00+/IXv+Ha+rQJgIf97G3oYnkzEazUIN7KD68SwdTi7kjlSur96As22Q7e/SJH0Nvs7h+BuZtw/OANC6QBG95m5hs6zJpxl2SKKjxr4njMLvn6b2n6gmzzQA+0EAo2D24IayrkpC0PcXQ4xDg2yNlou5NRixN8ZU39MOp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584055; c=relaxed/simple;
	bh=Ve7X6dyEMERtZnZM16/JR6dn1SwSIRT0GeLiibot1wM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oI5eXd5lTO4DXMo8qq5U33LPn4dgm2PsTguZgZT0aFYvnxTotDq4saiJHZl4Uuh19HaFJUKIyVvlnJ9RYyLrEQMD/6xsD+mwooYPtn7VHEznWwChAO7Porj6I9uLdZZFsyMNu1QCi4NU+ZGiKidjdmDituEdHVMi4gdG37bso4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVXT5RPU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b5897so33375365e9.3;
        Fri, 24 May 2024 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716584052; x=1717188852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWRTTdI4Emy4KPvUWY+g9XFXaK4zGbMUIGkTkuZ3J94=;
        b=mVXT5RPUR18cihQ+SnrHsMynZDqQV+rozHmTjb9YYjmVEis6/sS9kt7mvb8DpzDDDQ
         uMcr7mnsS7oKCeJUuw0MyzpxW+BOQ/t4k5EbJd0kaVlXh9T3onaualkGCGLAaVUVHVbj
         5kYeb5IgtiSoCwZ7o3ADqrCoTdDaBD/Zgb/k3qlRNezCtOatptkkxMGMjzSpp+dZPoBn
         fL2gncjv+BuoL+Zs6XPFleiyPL3LWkz2bCCZEhEHJqqcypYSZH9bYesyIMWGmaWNt+6N
         wA27PI3WOi0gYT0xp9JiCku5MAYJAW3rzPCXL+emJzxB2/nYP7CnPoP02SE2hmEswrFn
         4Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716584052; x=1717188852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWRTTdI4Emy4KPvUWY+g9XFXaK4zGbMUIGkTkuZ3J94=;
        b=BdXlJCaJQW+s0QNFOmtaEPDp5cOqMcdhbrZc2MLwAJAOdULGc7b7WthkhpmDhAu67W
         zN4inmQ6g5LwgyFxGt40t00Xg19cNPyNO2dElIP/rAkdbie/dhUMW4aF/kflYRpOYBWR
         lNzw0SFjIzsz6GMx7Gpd07RHytl0cA9UXIFnQaU86GR1ZAIxCGwxhwtPWDNMfzkEDKGC
         MxlIHvl9MHWKjzV8KSJo9xZEqK0O1I6vq5+rgEDuieXAdpwsnNu7oo2dG2h/pK8mN3mF
         pw8DV9uIOMFyn8NnBLfhDMvp1VgEMq9spzyG8bwPn4W3fUVNhZsOl/mWbQwZIBQH/w75
         fJHg==
X-Forwarded-Encrypted: i=1; AJvYcCVYwZYi/ApRU6BqU5cyIMOoozUNdtry2fH/0ieV0HtB1zzYjOVKih7iTTZIzpM7uinh2aCOOw5lKdhJMbmtPSNhqSE9NJb/fkH3KcC+/jK91LZEqLK6dEcV142PKNbB4DWdceWs
X-Gm-Message-State: AOJu0Ywh4HP9NdlN5vfdn71mIsjeZhxNt5yzsIenKRl4P5/trpiv++86
	QO3QYRxt2hJ4j8jWbcdtsrAuRJFKmC/YaQ+2AWoO7vrlbuRaRW0Y
X-Google-Smtp-Source: AGHT+IHz67D/PKHB/qAFQ99/xKvzocO2qTCa9eD8A9d7Zruwfd5cyIbJUgCkkDN+xzgZAGtdfdkibQ==
X-Received: by 2002:a05:600c:19cf:b0:416:88f9:f5ea with SMTP id 5b1f17b1804b1-42108a0b891mr28044335e9.34.1716584051785;
        Fri, 24 May 2024 13:54:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-420fc82eeb4sm44332315e9.0.2024.05.24.13.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:54:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH net-next 1/2] net: phy: aquantia: move priv and hw stat to header
Date: Fri, 24 May 2024 22:53:43 +0200
Message-ID: <20240524205346.20960-1-ansuelsmth@gmail.com>
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


