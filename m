Return-Path: <netdev+bounces-107227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376D91A551
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D844C1F25035
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F3155743;
	Thu, 27 Jun 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NqgSWjlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE974154BE8
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487833; cv=none; b=MyXggjnWu3pHM6upq6CiwnvXDY+oSCPXT9Jr0fbGoIAsl82tyxI/MKEGGniqyW+rrU9jYsof7g+u192Iry7iP6FG2+Sc2/u2ryIeZZEJ3Ost/nfT0XduSXVtaZ044Eplj4o4gV/G+7d15AOELYssP3yIPP3+f+Xw1FyHS8S3XSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487833; c=relaxed/simple;
	bh=+dkNGrY8iUBtOuIAm905KbG4l4iftKZC0lmNmQHFM9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvOcGK4Ec2C6Av8D5seUDW5C1k8br1RNlDSzx+NTnWr89N1oMVBiBs/O5n2w12gFbqnA3gKtX8g/FxlSNqO3PTJnRg/J3B8B8DT8LQZkjqrV8K4X2uB/o5FFF3csv3i93nU52VnvlnYigMgOe9pv8MIeTmw3FFSy9DyE9F0fTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NqgSWjlQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso21182765e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719487830; x=1720092630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BN1xhZxrLr5nolBCZpgMsAlPUqMYeOtqezwGGeoYo0=;
        b=NqgSWjlQtiVg9hJhTPcdl01U8RR3YdWqo+T/hSXdheMZuxJG82RXQAQruMXHej1sfg
         oajji3wldwaTKOG+KK9XSH7TfFm7JOaCV9GCBCDpYnEdvPTppQ8H3NyBTQ6vbWuuWS/o
         +tMQGvw475pqzfIGF4OZxDghXfesa78M/vlip8GqmuquZ0ZtWsjUlOd3VE9SMDfErsuY
         dST+Wj/sK3n0gAhe69iftieE/j07H+6TfliPzw3EwU6cLayJ+fpYcM7wiby9gnHEn8Ik
         yrJTZDZvymxjyTY1+NWibl5TQJ2UKLK03Bpbq/igRv6FRPSastzYekGxnZq8ASbNruBp
         RjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487830; x=1720092630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BN1xhZxrLr5nolBCZpgMsAlPUqMYeOtqezwGGeoYo0=;
        b=dXPb42Fm5ocFWkRfdkuD9MQw2MBsLIhXrrm850jHC1DgxQ1f8Geas9AxSUb2unnBkd
         /37KoajXBsPBM0YW8ZbZoJ7f2nCUpO+7Izg6iDEzIonrGWPyPI2XbyWbXTY90x4KrnXT
         jJfKDRhNtwH8GSSv6eGJT8NHtQc9K9sQVd9mGWISRPWkpTd3++yJKPAoz5IGjjti6GzW
         rRhSElgg7peDFj7Ogyma28vRtWEZQ43XE50yf+8ptGuY6AxCtyXpRcQlfsFctCHjEqbm
         Cr9Cx4NkhmreLNisJVYY8BL2S59nDOvQ/hgsVQjL6uw71H1seawddm8OJIpH+Kc8CtK3
         8EqA==
X-Gm-Message-State: AOJu0YwQ1TCvM/RNe/vI2YprPJWYqoXVYWEOmfuloNaq4aYEQaHidXw9
	t87V02luWnm0ibEQgvs4qySFbqzAP8lmw2JeRoS8TvdfgAj9PSea2YSHZ0uCkoc=
X-Google-Smtp-Source: AGHT+IEspJ5tpQhEcaFkouMsqw9DA/rsVOiSsLgs+WQRpheU7yQxhWLnKxJTMUL6UGdqoDGHD8y8EA==
X-Received: by 2002:a05:6000:4594:b0:362:c7b3:7649 with SMTP id ffacd0b85a97d-366e95eaeedmr10121351f8f.56.1719487830020;
        Thu, 27 Jun 2024 04:30:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699ae0sm1504111f8f.66.2024.06.27.04.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:30:29 -0700 (PDT)
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
Subject: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for aqr115c
Date: Thu, 27 Jun 2024 13:30:17 +0200
Message-ID: <20240627113018.25083-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113018.25083-1-brgl@bgdev.pl>
References: <20240627113018.25083-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for a new model to the Aquantia driver. This PHY supports
Overlocked SGMII mode with 2.5G speeds.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 974795bd0860..98ccefd355d5 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -29,6 +29,7 @@
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 #define PHY_ID_AQR114C	0x31c31c22
+#define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -111,7 +112,6 @@ static u64 aqr107_get_stat(struct phy_device *phydev, int index)
 	int len_h = stat->size - len_l;
 	u64 ret;
 	int val;
-
 	val = phy_read_mmd(phydev, MDIO_MMD_C22EXT, stat->reg);
 	if (val < 0)
 		return U64_MAX;
@@ -721,6 +721,18 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	return aqr107_fill_interface_modes(phydev);
 }
 
+static int aqr115c_config_init(struct phy_device *phydev)
+{
+	/* Check that the PHY interface type is compatible */
+	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
+		return -ENODEV;
+
+	phy_set_max_speed(phydev, SPEED_2500);
+
+	return 0;
+}
+
 static int aqr107_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -999,6 +1011,30 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
+	.name           = "Aquantia AQR115C",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr115c_config_init,
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
@@ -1042,6 +1078,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
-- 
2.43.0


