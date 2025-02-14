Return-Path: <netdev+bounces-166340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C9A3598F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E3D188F1EF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB622A4D2;
	Fri, 14 Feb 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQdxnliv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D42163A5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523601; cv=none; b=KgXiU+qSKuWBaZenHDe1z59clIJUhcl8EYioATcccaacSokcGDD5+o0XuF1rjK7CGbU7R8syZdlzxw+jcPnBwdIS+lBT/b/4N+V7IMJgCJ5Xzm6Oa3hkjjbSlDl/yWz6FiPo0RIYWgom11hFcBss0QQzchr9fUS354+IJ1SdM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523601; c=relaxed/simple;
	bh=bemAx3WMNbgP3FxymWle05ipgd9iJo+PSFLbpqhlPv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HNF19PUHwamGItnzkMkyeufKPfR3RUl1Q5tpQCTTU1h8L0cgDUXSRJs/3f6zSrvTOkKqmO+6pGuDbeESiB2ChM6MMMsWxQoSY8R+6ZiI3iov6wY9nxIfdwR3n4bpDuggeBK4Yos7yPVMGKZ3NeuBeelNIgNSWqlURSHlSLg8sjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQdxnliv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a04so18958801fa.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739523597; x=1740128397; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqCpvNWFQh7AZG2eQXSbMYV8oCWBg2k7mFLCRW4f4Mc=;
        b=BQdxnlivAH60LUatNFyyPdSvG/BjfoPN+GIW4ZgZN+ricBxihHjycjwl2OSnr+E7yZ
         xpWd8Gb9DYXsH5DRIcnVOXB2HXZdjj6PZnLMg0RPbGQ8otbFLIsv2qkQQ2/F4+gxSupO
         WNbEi2EISCDVqB8Zj5lpNGiZePhp6+d4VLYVQGgo3cF0qoYmMyZ3Sk8St6Ynei18MTZQ
         1bW/IlDC41hTOMunlM093Pb1oZdL5+jOOTWpvokc0OZgBEnO1ZyWqo5BQLq7UYSRZ06I
         wj/Q/Y4vWvMkVj3FtEIZaHG4FKikQ9g1NA3aOPJyVgI5SXi9EKOWenNy4f70MwHSAxwF
         qwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523597; x=1740128397;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqCpvNWFQh7AZG2eQXSbMYV8oCWBg2k7mFLCRW4f4Mc=;
        b=XfL4VXWAjonFjiKqfUG9KsbxrMP4DbI8RKEEkB9/jfykNpjaJDprydGqwrUDewYj7B
         75QJAnIYa+BWy+CeFp4pyYjl+xya2U9ng7BzMdv8yDEH18mZZu+ONY7gmkQvLbys924U
         iFedVecBeKDVmdb3jYq+35goM5vKedGhLlJkxMwxTkPsBVusM3FNqnv2pIdi2sZQcGq2
         xbTWH3UzeDZtXbi/DsSd5UQrjac6IsIIhHRuOaI9yRLRLs2G2LoWajlRdGobmHl5VeXE
         TwFhyAudDg0vzNiLFBBXgV46t3XNaQKClvcxOXa2mgbRn0wTa3vO6e86LO+xawJZulBf
         plCw==
X-Gm-Message-State: AOJu0YxreglSCgvr+TNmVyVQfkqI+EvY5XyCrL+QysOBN3rVsrW/5AqM
	46yibHEGVuf7c2iLr/bM60U01YbW5YbgFIbkaMAHF/0F/rDjIGMlCnA7X2pAXak164zZXnky1LK
	H
X-Gm-Gg: ASbGncsdqJDri2fJ134YUplCOTsTqBa8AVsZ39oRiKqxR6RgTf1tuX8tozDaw6V5dVE
	f8r5bV290yEkQVB5VRaX9gRTM/Xv/TSDX2tT20vvDvvpiJrR+072NKFqoH7pkN0hz8nKZ8NZwMI
	9oRKFquhetB/YGyQTxbQI8CHCXnSj6IWas4Z1y/sawLTJqzTrPfMot4Os+pxbYfXfetrx554phu
	HtZGdglaKfJUPCvCndN4tKx9yKkg83E8LZtEyZ0wzJ0Uhsn+r2RfeRj8nqcOyGVxGEbnrA69tlQ
	JuRV56EwCXrUy4KqIL1HvJPHjA==
X-Google-Smtp-Source: AGHT+IHixjUVUYLqjhfRWVBmqUM/ipRSgIxln26DeFTmdKzliiNr5fZqzFn3TO03lkHrzx5Fyqvn8g==
X-Received: by 2002:a05:6512:ad2:b0:545:2c2c:5802 with SMTP id 2adb3069b0e04-5452c2c58a6mr279601e87.48.1739523597434;
        Fri, 14 Feb 2025 00:59:57 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545287271b7sm135219e87.123.2025.02.14.00.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 00:59:57 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 09:59:57 +0100
Subject: [PATCH] net: dsa: rtl8366rb: Fix compilation problem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAwGr2cC/x3MTQqEMAxA4atI1hOoLYrMVQYXY5pqoP6QOIMg3
 t3i8oPHO8FYhQ3e1QnKfzFZl4L6VQFN32VklFgM3vnG+Tqg7rkLbasDZo6GtM6b5FKZ/RgjRU+
 BGpc4QVlsykmOZ//pr+sGpLv3G24AAAA=
X-Change-ID: 20250213-rtl8366rb-leds-compile-issue-dcd2c3c50fef
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

When the kernel is compiled without LED framework support the
rtl8366rb fails to build like this:

rtl8366rb.o: in function `rtl8366rb_setup_led':
rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
  undefined reference to `led_init_default_state_get'
rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
  undefined reference to `devm_led_classdev_register_ext'

As this is constantly coming up in different randconfig builds,
bite the bullet and add some nasty ifdefs to rid this issue.

Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502070525.xMUImayb-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 53 +++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 4c4a95d4380ce2a8a88a6d564cc16eab5a82dbc8..b914bb288f864ed211ff0b799d4f1938474199a7 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -372,12 +372,14 @@ enum rtl8366_ledgroup_mode {
 	__RTL8366RB_LEDGROUP_MODE_MAX
 };
 
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 struct rtl8366rb_led {
 	u8 port_num;
 	u8 led_group;
 	struct realtek_priv *priv;
 	struct led_classdev cdev;
 };
+#endif
 
 /**
  * struct rtl8366rb - RTL8366RB-specific data
@@ -388,7 +390,9 @@ struct rtl8366rb_led {
 struct rtl8366rb {
 	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
 	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
+#endif
 };
 
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
@@ -831,6 +835,7 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
+/* This code is used also with LEDs disabled */
 static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
 				      u8 led_group,
 				      enum rtl8366_ledgroup_mode mode)
@@ -850,6 +855,7 @@ static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
 {
 	switch (led_group) {
@@ -988,26 +994,6 @@ static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
 	return 0;
 }
 
-static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
-{
-	int ret = 0;
-	int i;
-
-	regmap_update_bits(priv->map,
-			   RTL8366RB_INTERRUPT_CONTROL_REG,
-			   RTL8366RB_P4_RGMII_LED,
-			   0);
-
-	for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
-		ret = rb8366rb_set_ledgroup_mode(priv, i,
-						 RTL8366RB_LEDGROUP_OFF);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
 static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
@@ -1039,6 +1025,33 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 	}
 	return 0;
 }
+#else
+static int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	return 0;
+}
+#endif
+
+/* This code is used also with LEDs disabled */
+static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
+{
+	int ret = 0;
+	int i;
+
+	regmap_update_bits(priv->map,
+			   RTL8366RB_INTERRUPT_CONTROL_REG,
+			   RTL8366RB_P4_RGMII_LED,
+			   0);
+
+	for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
+		ret = rb8366rb_set_ledgroup_mode(priv, i,
+						 RTL8366RB_LEDGROUP_OFF);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
 
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-rtl8366rb-leds-compile-issue-dcd2c3c50fef

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


