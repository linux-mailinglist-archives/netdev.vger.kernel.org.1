Return-Path: <netdev+bounces-104992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1690F663
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9ED01F24ABD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323315B0EC;
	Wed, 19 Jun 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H/4iIgVF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A57159911
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822770; cv=none; b=keWIojo3hYBntYxUKe8Tb0yo0NJ0b8b23wnU4lahgbzh+/OHqEXd9lNAsI0/X7xdMX3gC/idoVOFUTNpD/xEzfxqM+i89QrnPikHb9LlpvQtXoKV3tVCelqlhEw/aPyvk855y0tjMswaurtjZYjiwNp0F1PTKukav4Pd2OzTExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822770; c=relaxed/simple;
	bh=Z42Tj4eFx4jXVdlHNjeT3uH2cP3RYjlyUFGU2X7iXHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUDVquXG55qnjLKAQywKNeqwcrkCPX9uuVqWp2K+pp5COBSUG9LT2jK3n0hjqYMYMX+GiRg981OFn1BYkolR1WM1kxyRGcJgyUhzGjFKgOeEAIJQe6NYefkBv/UhM1iGBigBud3Mf6TP6JNmmvkDKRJiFqgBBePhJVJfL+ZdhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H/4iIgVF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3621ac606e1so814352f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822767; x=1719427567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8OMC48GmXgiPxob9K29Y+tXmIST97gKgb0MYszQ6f4=;
        b=H/4iIgVFdRaP2fd5+airGbRvBampN1nNczHbZFjCehyyn8XX9TmbKH0VEHflzh0NnR
         wqET2K+BeoftJXbc/U6L/7rgk+7KSYdwSqbGPJP2vU41qoGu4zFzPgh/QkJf5PP0bGZP
         LcbtsQ5ewIcYRnthGv06tRlTfKPEQFpHgWkqKkXhAr2onyRfMFT/cT0D5Q//Zg4cP3EM
         ey4W2ZQik/UcfNWJUn00+bAk9ska9rYrWkDMbi8ggTN/NCUmUYL+/8yX2R4kD4I/svZM
         WDk07/WtGsG2kIuLoQsO0UVjlN6EZu140k+Wy2GbO7LOiP+0hLsHa0hZ9EegmquYjbA+
         jk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822767; x=1719427567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8OMC48GmXgiPxob9K29Y+tXmIST97gKgb0MYszQ6f4=;
        b=jw5wqGBWu+8A7BQCz1xR3xQE9Kp4d9MHgl1p03hF9XDEOTaNDaGgXevjzXiDcXAU8B
         D8faYwYExLfDFgh7dDp6heeXknlhAc8XJT2JTNOsHB65OZFqHA6w+t9ZOGodY2zBQgJh
         NPce5rGw8JimocTBfysBmrZr46DlYyOT8z+Je09U8V+qg0nakmKn+Tf6JI0Derxz8t7a
         1pWgz/+tT3+dcQX+kqmFEqQDqYegAKTnHfdA9ruKNUK1hI9B1AOtcwSOCa7bul2S4cYr
         SusFqXB5R9Kxx5lXq/Sw+6427EoYj//LNBEl65Tp5g6H7LtDW7DNIOhC0obvdqm+CySs
         godA==
X-Gm-Message-State: AOJu0YxHsd35dVrConUbfuKy2zJdrSsFn83xBuqnxv4nhgfiq0khIoga
	G/Rgo6YiJeuoWbaEiALQsvyLphoF6fyEI2EYtbdZW9g6f1mVYQQkLJLYknurejY=
X-Google-Smtp-Source: AGHT+IHPbftWUm712EVMDPWc9/FAfLxNDa5SAVUKIsk+n79gLzuNi7krxSeOn0v4Ewzob/JdZzx81g==
X-Received: by 2002:a5d:6d4c:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-3609ea6c58emr6800607f8f.15.1718822767356;
        Wed, 19 Jun 2024 11:46:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 5/8] net: phy: aquantia: wait for FW reset before checking the vendor ID
Date: Wed, 19 Jun 2024 20:45:46 +0200
Message-ID: <20240619184550.34524-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619184550.34524-1-brgl@bgdev.pl>
References: <20240619184550.34524-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Checking the firmware register before it boots makes no sense, it will
report 0 even if FW is loaded. Always wait for FW to boot before
continuing.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia.h          | 1 +
 drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
 drivers/net/phy/aquantia/aquantia_main.c     | 6 +++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index b8502793962e..2465345081f8 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -201,5 +201,6 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
 			     unsigned long modes);
+int aqr_wait_reset_complete(struct phy_device *phydev);
 
 #endif /* AQUANTIA_H */
diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index 0c9640ef153b..524627a36c6f 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = aqr_wait_reset_complete(phydev);
+	if (ret)
+		return ret;
+
 	/* Check if the firmware is not already loaded by pooling
 	 * the current version returned by the PHY. If 0 is returned,
 	 * no firmware is loaded.
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 11da460698b0..eab779db225c 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -441,7 +441,7 @@ static int aqr107_set_tunable(struct phy_device *phydev,
  * The chip also provides a "reset completed" bit, but it's cleared after
  * read. Therefore function would time out if called again.
  */
-static int aqr107_wait_reset_complete(struct phy_device *phydev)
+int aqr_wait_reset_complete(struct phy_device *phydev)
 {
 	int val;
 
@@ -494,7 +494,7 @@ static int aqr107_config_init(struct phy_device *phydev)
 	WARN(phydev->interface == PHY_INTERFACE_MODE_XGMII,
 	     "Your devicetree is out of date, please update it. The AQR107 family doesn't support XGMII, maybe you mean USXGMII.\n");
 
-	ret = aqr107_wait_reset_complete(phydev);
+	ret = aqr_wait_reset_complete(phydev);
 	if (!ret)
 		aqr107_chip_info(phydev);
 
@@ -522,7 +522,7 @@ static int aqcs109_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
 		return -ENODEV;
 
-	ret = aqr107_wait_reset_complete(phydev);
+	ret = aqr_wait_reset_complete(phydev);
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-- 
2.43.0


