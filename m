Return-Path: <netdev+bounces-109755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9D929DBC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4391C2847A4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF015589B;
	Mon,  8 Jul 2024 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p5ZIgrUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB5481B4
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425037; cv=none; b=fK4UWZyv7RsZdE0yrfdbTA31si+CyM/JFEGBQI1og3+6semjM6hdKYydARpPDLB3vNm58C1XWfJZsmGgNeH7pLXwtmCgRfoIAXkssgTpkWAtjf+3oWJ9U7cSWoZ+UqByG6hEkoO00CGLRqXAeb324jfwmKKgNn+c5q36n+0CdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425037; c=relaxed/simple;
	bh=aWRGwjNl141O0N2eu4pMGXstKpSbZTAZRRlvToIsLls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql0A+tv0vCltZGx9CXS50XFDG6o7jLzCmjhaWXZPyNnjn5Q4xTE8cvWHcvX4K2O6hwbAC3DoL7Y4fn76X+Yv8Nr2OmnKFGuLNVPQjJsvdBQz2ZPYfKXR+0VgrDU8Uz0wwV96UdFhNM8i6uiy913vJbNpRTICa1rz9ZdK28lZGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p5ZIgrUZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367a23462e6so2162785f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425034; x=1721029834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqzfRYx/eBkp9k5OzF2pgC0wEOIaJNu82fson6xrplE=;
        b=p5ZIgrUZ+uadygfMxSy17GGXlCI2oeCEjVCrAw61Ydf7rSPc98lXSLPGwyO1ue++Dw
         28xKFrb97PBRVAsOpk2SFw1R0rpoZo8b+0wmVebIMaLui4g1xCFNODyydsuiFj29xyIC
         J8w6AEII6KlxdEQdVUUpiRIwGRoGRxNi/tOh0j0XlgAA58JQlAna2BLQCHqg6KiYlaYh
         N5UvlAyvp/115pDhvYnHr6qE3SAzwKFc7NoTfmknO+OplHIs+0YaLhQ2nIQ4FAelKI7O
         t0jTkmOaJs4DHu0eFz9+/5V9Uefet6oOmgmhV1k++7ALvudSvxlRTyDhenz1xuIg+2Sz
         GkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425034; x=1721029834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqzfRYx/eBkp9k5OzF2pgC0wEOIaJNu82fson6xrplE=;
        b=v3BINYlsbetKeKw51xd/4+O5XSXz7ZxOUyBjNmHpMQ5pUd2hD7MZ7H18SuK3MGm+DT
         En1Ba57c3GrCOJ8/IEnwN9s++QLuDNDd4jsTuGz9ohjaI8YT8iETKJyHkq13d4aOz9oS
         VgLNyefRD3aYaMx0ak0ZIS3ptbVkUZSapVrL70LZC/aSx7bc0DeLnGU3Mqj2cAhJvYnw
         SxAwE5La/746penRX1uSj0+7gq1E3AmHjiihVHl72l7HGYx9fELalTYh6ao9VWe5v9Z6
         UL4t/5v33jfi4zxCFdM/O7+OjULRq7udLa6V6yNt5X7tJI82q6kc4gR2kefVqYta6h6e
         bFcA==
X-Gm-Message-State: AOJu0YyCpqJWsV5TDI6zqH6zoop9sL6HhlcE/Y7J6gaKKT+IPscMVvCe
	weVWwIOYtusIJsYrdPWJXqwdkbOZuO8uXDK7gxr3fXYvNeMwsBz4ei01WoMBu/m0lyGGiPOduuD
	F
X-Google-Smtp-Source: AGHT+IHCdYtJ5gdajf8bIJppL3jAkrIqdYM6almNmdUFQezuZItVtFtLkoeiiigNoVNNGUV5o239kQ==
X-Received: by 2002:adf:8bde:0:b0:35f:f58:38fc with SMTP id ffacd0b85a97d-3679dd29745mr8013567f8f.26.1720425034553;
        Mon, 08 Jul 2024 00:50:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH net-next v3 4/4] net: phy: aquantia: add support for aqr115c
Date: Mon,  8 Jul 2024 09:50:23 +0200
Message-ID: <20240708075023.14893-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708075023.14893-1-brgl@bgdev.pl>
References: <20240708075023.14893-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for a new model to the Aquantia driver. This PHY supports
2.5 gigabit speeds. The PHY mode is referred to by the manufacturer as
Overclocked SGMII (OCSGMII) but this actually is just 2500BASEX without
in-band signalling so reuse the existing mode to avoid changing the
uAPI.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 2c8ba2725a91..d12e35374231 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -29,6 +29,7 @@
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 #define PHY_ID_AQR114C	0x31c31c22
+#define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -1005,6 +1006,30 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
+	.name           = "Aquantia AQR115C",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr113c_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
 	.name		= "Aquantia AQR813",
@@ -1048,6 +1073,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
-- 
2.43.0


