Return-Path: <netdev+bounces-131536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654E98EC99
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB7B1F21953
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE11494CE;
	Thu,  3 Oct 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S8W7STG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CB84E0D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949701; cv=none; b=PvcTiVLRWmvSaFoyiQl9FhCjnp7I0bbQN7JnlKyxuMODJnMEcHVvCvtvMDJIgtdBd8eOrXov3jS2Eyj4oPaP3/9591fy5koWdT9+mYIpvAgSVYyXSwS8wiBIXYSTajnMZZJ+RE5HbYWngxnwO0m8EOeLWXFD9setJM6hgmT8Wv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949701; c=relaxed/simple;
	bh=xNNRMcgxw0XnMFb9mjbxwrdVGDL8ABRbmnSv3jIADGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCobHOEE5YkQ5EmPtP/IAZpvEEDTVi8PIoL7/b4IBQLhHNGJ6uabcy5RKZoH/X+sQtLncxJKPGJIgmERAMwE7h07LTN1+oPjwIPeys88+EqUAkyBKyrsFSEI/Qx97i754y/NsxQOoTgTFSGgdKf5slt7DSa0cXbXWseTa9Tn8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S8W7STG9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so648741f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727949697; x=1728554497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2txx6H0P20iYIDkqmL6FS5W2PZp5dN6XvC5lzQWcAE=;
        b=S8W7STG9jZFzRicZlLHFNgIb4s9ZOtb06YkKKi68cAzkbFyEe9ENVTwq08S1aS7bg5
         ZC7uQ7BzklXQe34mIIh20bjkAb+Pfn1JktHhCdMy2OqM/jM7fnEozsnPizDfZ+WFJ2n+
         xpmafWpviD3jl2RYKaL4ubAees2wJzg6Yt6zNVtIF+AwueA3pka1Lb6haPlaV/HeZkPJ
         We9VaWupxjawX/EJB18W3NcwUJ1SknwnMSsGnovgXpvQBbcny6Ei3IPcUc+4YCcecDkQ
         lsrkQuqg7LmzSCeDk6RToWzVg2XuLZSZMPktwx+JeBhuaeRTLXKOFRbKy7RfRWerotl9
         Z2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949697; x=1728554497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2txx6H0P20iYIDkqmL6FS5W2PZp5dN6XvC5lzQWcAE=;
        b=boeL79KC0LV4PzciMzXATx70W0iQNZhDbkDFykF5+xmSUcMROp0mGETeN0eGLqi6Qf
         uXPi4ugg/0Y0AV47Ca2YZSdrnW0uQ0bsd3j9CwNRkFhFWJ4FG+gzgHUJ8UeMbPT/ylyR
         /tByvn97HZG4MbqaXrPpHMbsGrQcx7NXOG8Bx2BOdWBtxxNlCDD8oSU5kA9/DL0ecKiP
         tzqKf6QWHHmxaPgLQggHKxN3suNcvoBAzgWgbQQkJSGmcOBnHBCDlZIJImdCMOCqSsqF
         CTawWH/URI6pfxkahDpsqFXzPWGGoCSV16mq58iIoFBrYH7yxiXRwQ96XRQRZ/Fxn10U
         s/CA==
X-Gm-Message-State: AOJu0Yw2dvX5v3aEnd9lvqx+cOyA7wyJc9cKe4VxNVCnJXmew/DKHKCJ
	YL2nLITyx5YFixz1BnAXQAkckugCOQssDPj9RFJT+0EH46+0oy5i/s4278O8TgM=
X-Google-Smtp-Source: AGHT+IGhrtZTCK4LBBA3NkcHQGNwewMJq+MTf9wrmK9kPYET4MiBsPZJtx00+jZ25+e32LXHqvqLGg==
X-Received: by 2002:a5d:60c2:0:b0:374:c911:7749 with SMTP id ffacd0b85a97d-37cfba121ccmr3413116f8f.49.1727949696917;
        Thu, 03 Oct 2024 03:01:36 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6bdfsm910744f8f.86.2024.10.03.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:01:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: dsa: Switch back to struct platform_driver::remove()
Date: Thu,  3 Oct 2024 12:01:04 +0200
Message-ID:  <36da477cb9fa0bffec32d50c2cf3d18e94a0e7e3.1727949050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8704; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xNNRMcgxw0XnMFb9mjbxwrdVGDL8ABRbmnSv3jIADGk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm/mtn+Ji6inxXux+iCP/YwBenovZXayIRXZXYv OdPTst/99GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZv5rZwAKCRCPgPtYfRL+ TupjB/kBb262FadV2GsZ/iJqEIiRNuTXh9h0jRGOze4ISU5eZ/NJBIg9d6qErVDPZZXie9O+ecz 7Yqacj9YxFJmOVzwiu740uf27KJw9c52WZZLTU2kD5wtrMwjcja47UFpDBjz8nu6WT4XLqQt5KD N1Jr9rN+/EtMbq8IsiJbeY0Lt/tQnaRZpv0MELjdMWPMjQwq2rpXd4hr9lL6BKHX5L9AGRXYv8D 9rIRtsRFu/ue46RtGX36Y9lIfsWByN2obl6HK966ITW3OFVwK8/79GQGefvVmy2CUmgsu46yJee CPK/zLqnLLK+7xHXs7qmgj2Lsi9JFakM3QjoUdKVlB6mZgCi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/net/dsa to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/dsa/b53/b53_mmap.c             | 2 +-
 drivers/net/dsa/b53/b53_srab.c             | 2 +-
 drivers/net/dsa/bcm_sf2.c                  | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.c     | 2 +-
 drivers/net/dsa/lantiq_gswip.c             | 2 +-
 drivers/net/dsa/mt7530-mmio.c              | 2 +-
 drivers/net/dsa/ocelot/ocelot_ext.c        | 2 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c   | 2 +-
 drivers/net/dsa/realtek/realtek-mdio.c     | 2 +-
 drivers/net/dsa/realtek/realtek-smi.c      | 2 +-
 drivers/net/dsa/realtek/rtl8365mb.c        | 2 +-
 drivers/net/dsa/realtek/rtl8366rb.c        | 2 +-
 drivers/net/dsa/rzn1_a5psw.c               | 2 +-
 drivers/net/dsa/vitesse-vsc73xx-platform.c | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 3a89349dc918..c687360a5b7f 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -370,7 +370,7 @@ MODULE_DEVICE_TABLE(of, b53_mmap_of_table);
 
 static struct platform_driver b53_mmap_driver = {
 	.probe = b53_mmap_probe,
-	.remove_new = b53_mmap_remove,
+	.remove = b53_mmap_remove,
 	.shutdown = b53_mmap_shutdown,
 	.driver = {
 		.name = "b53-switch",
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index f3f95332ff17..b9939bbd2cd5 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -682,7 +682,7 @@ static void b53_srab_shutdown(struct platform_device *pdev)
 
 static struct platform_driver b53_srab_driver = {
 	.probe = b53_srab_probe,
-	.remove_new = b53_srab_remove,
+	.remove = b53_srab_remove,
 	.shutdown = b53_srab_shutdown,
 	.driver = {
 		.name = "b53-srab-switch",
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 0e663ec0c12a..9f2db4091886 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1620,7 +1620,7 @@ static SIMPLE_DEV_PM_OPS(bcm_sf2_pm_ops,
 
 static struct platform_driver bcm_sf2_driver = {
 	.probe	= bcm_sf2_sw_probe,
-	.remove_new = bcm_sf2_sw_remove,
+	.remove = bcm_sf2_sw_remove,
 	.shutdown = bcm_sf2_sw_shutdown,
 	.driver = {
 		.name = "brcm-sf2",
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index beda1e9d350f..d798f17cf7ea 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -2105,7 +2105,7 @@ MODULE_DEVICE_TABLE(of, hellcreek_of_match);
 
 static struct platform_driver hellcreek_driver = {
 	.probe	= hellcreek_probe,
-	.remove_new = hellcreek_remove,
+	.remove = hellcreek_remove,
 	.shutdown = hellcreek_shutdown,
 	.driver = {
 		.name = "hellcreek",
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index fcd4505f4925..6eb3140d4044 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -2249,7 +2249,7 @@ MODULE_DEVICE_TABLE(of, gswip_of_match);
 
 static struct platform_driver gswip_driver = {
 	.probe = gswip_probe,
-	.remove_new = gswip_remove,
+	.remove = gswip_remove,
 	.shutdown = gswip_shutdown,
 	.driver = {
 		.name = "gswip",
diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 10dc49961f15..5f2db4317dd3 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -86,7 +86,7 @@ static void mt7988_shutdown(struct platform_device *pdev)
 
 static struct platform_driver mt7988_platform_driver = {
 	.probe  = mt7988_probe,
-	.remove_new = mt7988_remove,
+	.remove = mt7988_remove,
 	.shutdown = mt7988_shutdown,
 	.driver = {
 		.name = "mt7530-mmio",
diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index 5632a7248cd4..450bda18ef37 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -102,7 +102,7 @@ static struct platform_driver ocelot_ext_switch_driver = {
 		.of_match_table = ocelot_ext_switch_of_match,
 	},
 	.probe = ocelot_ext_probe,
-	.remove_new = ocelot_ext_remove,
+	.remove = ocelot_ext_remove,
 	.shutdown = ocelot_ext_shutdown,
 };
 module_platform_driver(ocelot_ext_switch_driver);
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 70782649c395..eb3944ba2a72 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -1014,7 +1014,7 @@ MODULE_DEVICE_TABLE(of, seville_of_match);
 
 static struct platform_driver seville_vsc9953_driver = {
 	.probe		= seville_probe,
-	.remove_new	= seville_remove,
+	.remove		= seville_remove,
 	.shutdown	= seville_shutdown,
 	.driver = {
 		.name		= "mscc_seville",
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 04b758e5a680..5f545dda702b 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -146,7 +146,7 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_probe, REALTEK_DSA);
  * realtek_mdio_remove() - Remove the driver of an MDIO-connected switch
  * @mdiodev: mdio_device to be removed.
  *
- * This function should be used as the .remove_new in an mdio_driver. First
+ * This function should be used as the .remove in an mdio_driver. First
  * it unregisters the DSA switch and then it calls the common remove function.
  *
  * Context: Can sleep.
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 88590ae95a75..d750bddf27b4 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
  * realtek_smi_remove() - Remove the driver of a SMI-connected switch
  * @pdev: platform_device to be removed.
  *
- * This function should be used as the .remove_new in a platform_driver. First
+ * This function should be used as the .remove in a platform_driver. First
  * it unregisters the DSA switch and then it calls the common remove function.
  *
  * Context: Can sleep.
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index ad7044b295ec..6b9dbdb00941 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2164,7 +2164,7 @@ static struct platform_driver rtl8365mb_smi_driver = {
 		.of_match_table = rtl8365mb_of_match,
 	},
 	.probe  = realtek_smi_probe,
-	.remove_new = realtek_smi_remove,
+	.remove = realtek_smi_remove,
 	.shutdown = realtek_smi_shutdown,
 };
 
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index c7a8cd060587..6ba03f81c882 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -2102,7 +2102,7 @@ static struct platform_driver rtl8366rb_smi_driver = {
 		.of_match_table = rtl8366rb_of_match,
 	},
 	.probe  = realtek_smi_probe,
-	.remove_new = realtek_smi_remove,
+	.remove = realtek_smi_remove,
 	.shutdown = realtek_smi_shutdown,
 };
 
diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 92e032972b34..1135a32e4b7e 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1324,7 +1324,7 @@ static struct platform_driver a5psw_driver = {
 		.of_match_table = a5psw_of_mtable,
 	},
 	.probe = a5psw_probe,
-	.remove_new = a5psw_remove,
+	.remove = a5psw_remove,
 	.shutdown = a5psw_shutdown,
 };
 module_platform_driver(a5psw_driver);
diff --git a/drivers/net/dsa/vitesse-vsc73xx-platform.c b/drivers/net/dsa/vitesse-vsc73xx-platform.c
index 755b7895a15a..7a2e0a619b85 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-platform.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-platform.c
@@ -158,7 +158,7 @@ MODULE_DEVICE_TABLE(of, vsc73xx_of_match);
 
 static struct platform_driver vsc73xx_platform_driver = {
 	.probe = vsc73xx_platform_probe,
-	.remove_new = vsc73xx_platform_remove,
+	.remove = vsc73xx_platform_remove,
 	.shutdown = vsc73xx_platform_shutdown,
 	.driver = {
 		.name = "vsc73xx-platform",
-- 
2.45.2


