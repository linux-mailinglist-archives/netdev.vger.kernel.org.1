Return-Path: <netdev+bounces-99602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCA8D5757
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103D12837E0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC7187566;
	Fri, 31 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T//8XGxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60815139E;
	Fri, 31 May 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116638; cv=none; b=BW7TmrunjeJvuWxqBDdD3kmWXiZR6IYtIPPNsTpLn5ZXGiFZ+3/HH4G+GkkeHQ1/w80YTLkGLI1dAJaghdBSLC3fOXuIlMpGxmvZuZDmTcHfPS3x4HqBS3d4O9GU8iYnXys5t08CUrhZNBsTVmjxeGBwOd5zRqrcAwgxcv3bjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116638; c=relaxed/simple;
	bh=I2euR1rg97urE6SjnpaHdDD1hdP1+v1K5hV2TTGSHho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XsYM45Z2dX643QlmUNZ5W+R8yAGQbMkGa9KhcffS6GlVSGhSAKsAh4bxFN52Vxvj+fnOeh3WIKVYZiVZGxIRaxAWwdlZuAzJS7BmxoVnY4IKMj4hv7+Q0qhHL+jgE8n6Tv04RwuQKpW+AvNT9FuHU6eow16m7vXdAaclWdK3A0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T//8XGxm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so15040285e9.2;
        Thu, 30 May 2024 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717116635; x=1717721435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW2qvjJrTnZwL1/2NhmaAVU1+pTJQnQOA3xzWTN0ygQ=;
        b=T//8XGxmcTmpPCXEk+Jka3VAf5MpDKPQqdeuKmsPZucebmbH3EKvBSMYvpuoBvfY7h
         CkHlqmXFcu+ZbMBqR+1PzeAFWoAxzBf96bjRpUeUaVYorq2m8lVfapkEpSVCRmwLrDCQ
         IAeKYPnupRFAuiJzHEheCcZ26XJ5QNWt9tXY9OoRP4uBSPGgIYFpeeWBtChLMNbzc1f9
         aGPaZ1P9R0kbZcBB3DcCxUBSavSPi4Bsgo4LyktrP7nJkSQA4vGKRX88H2qJFu1ukgy7
         PZNTelfMQJocTnDsdSjRAN4PpAhvDNebF4xTX5ntAIL1mjsUMxjtHodl8zMpVC9Unr69
         Y2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717116635; x=1717721435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW2qvjJrTnZwL1/2NhmaAVU1+pTJQnQOA3xzWTN0ygQ=;
        b=SIdwg52t6gyfYvBHLkLYTLCS0q0n6312h9HpAxpdGss/FWypaKkzkCP9OzvZbjpKYx
         dhUlqQeMjWjnkbqnUe85QhGsLnrx20VraLRpoXUjnQOY1XIeNJjp9n6UVXjh62Sg8yF5
         lMNk+EfDRFLUCVfPEq7ieAbg6XpqnWib6jY8BgRxC8swLCtA+NeC2jXUZljJwrNzzB1x
         t/Jawxm8VsJkDfn7cEFrE0H4UyI1KbZtmSNsjQfO+ZP+NkA6lX7kjOG8zxXrBdmYg1jR
         5PCRq/Y7X1DWI9fPpwrstAWiwV7OMq14p0zq2h5HsP0gtCvTZvas/EC93k4+dhS9F2se
         Vdzw==
X-Forwarded-Encrypted: i=1; AJvYcCV293HEQnGkI0Rad2zTaoof7pl0f4FU9tpSZTfLyQf1whymHVGMXj88zQLCbS2cn1QY+oUWRkNmwsJeDreRejnV7zfmMIOlEtHwJJcRwM3YaO9Zferq8zSAK6KClMW0W6gxYINN
X-Gm-Message-State: AOJu0Yw2lfHeqMY99E+29v0uRrdxA5b5tJDNwnmPxtaeybtzFVIhu8Yp
	nVj7PH4udMSMHYzRst2FvAcSRl65Ggf8SiSIx3NaMkXYMoRTVDkX
X-Google-Smtp-Source: AGHT+IFhd2N0k+tJSPr0uL+nZCOndK+x01yAJnXVrV/k8DfyEKemPtmiV+kefL7KO3NN+NphcbN1jg==
X-Received: by 2002:a05:600c:45cb:b0:41f:fca0:8c04 with SMTP id 5b1f17b1804b1-4212e04998fmr2654045e9.11.1717116634417;
        Thu, 30 May 2024 17:50:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212279b4c7sm64327125e9.0.2024.05.30.17.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:50:33 -0700 (PDT)
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
Subject: [net-next PATCH v2 1/2] net: phy: aquantia: move priv and hw stat to header
Date: Thu, 30 May 2024 23:20:30 +0200
Message-ID: <20240530212043.9006-1-ansuelsmth@gmail.com>
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


