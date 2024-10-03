Return-Path: <netdev+bounces-131538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA298EC9B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A931F22067
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA514AD02;
	Thu,  3 Oct 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sy1Q3omi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D01494A6
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949703; cv=none; b=kS2/2O5g+Lox1In5ZxeqYyhEX1EviYRbnlaQYj+q6wZWxGcZ0u1uNlsKkYQUBvwNd8jYzDdb3i+xbNR9DhQJ8tlC+PxS5XzFOC8lRrPjqYeDwYSPtxLzS5ig2E31J6pObJbnnbHXsO3Iwr0Zkz+BFjv3jtoftNSB3NCF9Y2vuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949703; c=relaxed/simple;
	bh=z7LlLyPAfrIOtOmbP7SBNa6SQC5kQdCF5y4EmqhCM1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB4J/4z6zH91fqC8qZjc6yLOHeU7s/48Bx6OLlzrd/tam/cUurvdczESrtMf8ypyhqX9gEbcR/Z9xyKRDpfetqaUNo0uUh59uZ4Y2k/UA20PtDbcFOPjcq71RKHal4gGc2o1z1mUYY2yrnVy5c35DT5f5fUeOEK4snyPEdbaX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sy1Q3omi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cfa129074so600452f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727949699; x=1728554499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEhUE1xIhhgNgHkKjmv6khHEADkJWuBa5fZybV2E8ps=;
        b=Sy1Q3omihijTaMfLrpsbhOgFHYSXjgjHR1qB3Vq0lCnvS1U/fcBSsjpbQevsuXugCT
         RxZF12/OfMBgan9HhHrAQeBDQOI4AtH8P8QDJuHKZcU8j15QTFTCkVHXmz+Rzw80J/jn
         OxCECHEtbBkPEhT8900LCqAje5OqAmFcRtcv7qobWSSHzEq28/g3ypBt6cwaZR2yHgAz
         3xDg+zCo9PHMZWG63A961ij5tNR6SrdjxfAOMe9yVUh1f1NlneEiRfJndXpoNj5S19DD
         suE/Ds5C9BXKAD8FBnrXsVzAqOyoqbkvdljo7vdtqfCMdMPp1G+6f8aGlEzhQX8EuUz6
         EMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949699; x=1728554499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEhUE1xIhhgNgHkKjmv6khHEADkJWuBa5fZybV2E8ps=;
        b=BkuE0n+LLwwxR8sKMvnTjCNDkiNfxOBR8aYY81FJu8/Os13XySMni5ns/J5r12+L4r
         RydIFAk+lCNkaoeRuJaXICv1Hk4J5g4516R+08CMRVZtXXK+XnFnnfJuAt/2cey8Uf2A
         PDI+sbgrjxjhxBsylcTYPidTJ/FYv6bPlHPTu/pvgOyE/+CbXJi3DQ0xdLlb0aicNd9O
         NR59tShfPPwDvGjx8ppPVuD6V6sMi+sc2dgjKVIfokKdSH4CLrn8rqrdgcErro31qZAC
         +SMJwatw5207Mc4CO0GWEzUKFyrfM7bqeZIDdUYXvyiG65ksddK11yZ3//jpQ9HX8w/E
         Do4g==
X-Forwarded-Encrypted: i=1; AJvYcCVYaCryRadI7PO35XgAlJkZ9Q1N8rtCyaK0DOE6x7vAAG7S9Lb3CP6xi5jQKHO30OyukGvF/eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyMojsNPucgdrdpzOCB20JDpey+JEKnV0ORPShei8On/FxxzP
	/eZ9zyVucn5WxLZU8zecEyb4fjqTKCL2a3G0MYRGxcFvk5BA7UOmGfUkudGeccZjZFAn4JLSNCt
	8
X-Google-Smtp-Source: AGHT+IEXuqmTuFZ4b+3SUYkSyRB+kdnvOgfbqf/tc3iFpVKXn67QDYAZlJ3gpeuzT8zJhSaONfNieQ==
X-Received: by 2002:adf:fb46:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37cfba07899mr3989295f8f.43.1727949699132;
        Thu, 03 Oct 2024 03:01:39 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6df3sm904591f8f.115.2024.10.03.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:01:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: mdio: Switch back to struct platform_driver::remove()
Date: Thu,  3 Oct 2024 12:01:05 +0200
Message-ID:  <0b60d8bfc45a3de8193f953794dda241e11032a9.1727949050.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11175; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=z7LlLyPAfrIOtOmbP7SBNa6SQC5kQdCF5y4EmqhCM1M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm/mtqlYCi3J9LdCCzbCdbXwcXv94QWyYuU5Xwb s0z2rjTebyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZv5ragAKCRCPgPtYfRL+ TvOJB/0bIsmjrr02+DGAQAGy38+4Tw2vJ9XqmYJzZKq8geHOOicOJJWe6mmRqJ1wlxzDW8oznh9 dYRnLgII1HLfDCxYlBGsaLYvoHHOP8WbKVGa/hEzchp7u0pdiDDn30Z3Du3gqnHjdHyCd44BZ1T mqfYrQ8GkhK96gp1fggWvx3upY7rvGE+LfMeruP4zmEhubB4i8K6VmlSQAIagoiWlhPK3GNGQj5 9XrJ5T2c+dWygk3bs2hIT5wFVychnlOJBX12xW35Zu/BhODbW+gDBV+AA2LwmF4CWIWSRsAAuGn KXfYIzRdilCFJt2lZ6rIw6smeD5y8+aUtS/Tsqh6UMoPy1Oe
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/net/mdio to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/mdio/mdio-aspeed.c          | 2 +-
 drivers/net/mdio/mdio-bcm-iproc.c       | 2 +-
 drivers/net/mdio/mdio-bcm-unimac.c      | 2 +-
 drivers/net/mdio/mdio-gpio.c            | 2 +-
 drivers/net/mdio/mdio-hisi-femac.c      | 2 +-
 drivers/net/mdio/mdio-ipq4019.c         | 2 +-
 drivers/net/mdio/mdio-ipq8064.c         | 2 +-
 drivers/net/mdio/mdio-moxart.c          | 2 +-
 drivers/net/mdio/mdio-mscc-miim.c       | 2 +-
 drivers/net/mdio/mdio-mux-bcm-iproc.c   | 2 +-
 drivers/net/mdio/mdio-mux-bcm6368.c     | 2 +-
 drivers/net/mdio/mdio-mux-gpio.c        | 2 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c  | 2 +-
 drivers/net/mdio/mdio-mux-meson-gxl.c   | 2 +-
 drivers/net/mdio/mdio-mux-mmioreg.c     | 2 +-
 drivers/net/mdio/mdio-mux-multiplexer.c | 2 +-
 drivers/net/mdio/mdio-octeon.c          | 2 +-
 drivers/net/mdio/mdio-sun4i.c           | 2 +-
 drivers/net/mdio/mdio-xgene.c           | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index c2170650415c..e55be6dc9ae7 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -198,7 +198,7 @@ static struct platform_driver aspeed_mdio_driver = {
 		.of_match_table = aspeed_mdio_of_match,
 	},
 	.probe = aspeed_mdio_probe,
-	.remove_new = aspeed_mdio_remove,
+	.remove = aspeed_mdio_remove,
 };
 
 module_platform_driver(aspeed_mdio_driver);
diff --git a/drivers/net/mdio/mdio-bcm-iproc.c b/drivers/net/mdio/mdio-bcm-iproc.c
index 5a2d26c6afdc..91690b496793 100644
--- a/drivers/net/mdio/mdio-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-bcm-iproc.c
@@ -208,7 +208,7 @@ static struct platform_driver iproc_mdio_driver = {
 #endif
 	},
 	.probe = iproc_mdio_probe,
-	.remove_new = iproc_mdio_remove,
+	.remove = iproc_mdio_remove,
 };
 
 module_platform_driver(iproc_mdio_driver);
diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index f40eb50bb978..f93e41f5fefb 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -354,7 +354,7 @@ static struct platform_driver unimac_mdio_driver = {
 		.pm = &unimac_mdio_pm_ops,
 	},
 	.probe	= unimac_mdio_probe,
-	.remove_new = unimac_mdio_remove,
+	.remove = unimac_mdio_remove,
 };
 module_platform_driver(unimac_mdio_driver);
 
diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 82088741debd..1cfd538b5105 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -207,7 +207,7 @@ MODULE_DEVICE_TABLE(of, mdio_gpio_of_match);
 
 static struct platform_driver mdio_gpio_driver = {
 	.probe = mdio_gpio_probe,
-	.remove_new = mdio_gpio_remove,
+	.remove = mdio_gpio_remove,
 	.driver		= {
 		.name	= "mdio-gpio",
 		.of_match_table = mdio_gpio_of_match,
diff --git a/drivers/net/mdio/mdio-hisi-femac.c b/drivers/net/mdio/mdio-hisi-femac.c
index 6703f626ee83..d78a1dc36cfd 100644
--- a/drivers/net/mdio/mdio-hisi-femac.c
+++ b/drivers/net/mdio/mdio-hisi-femac.c
@@ -136,7 +136,7 @@ MODULE_DEVICE_TABLE(of, hisi_femac_mdio_dt_ids);
 
 static struct platform_driver hisi_femac_mdio_driver = {
 	.probe = hisi_femac_mdio_probe,
-	.remove_new = hisi_femac_mdio_remove,
+	.remove = hisi_femac_mdio_remove,
 	.driver = {
 		.name = "hisi-femac-mdio",
 		.of_match_table = hisi_femac_mdio_dt_ids,
diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 9d8f43b28aac..dd3ed2d6430b 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -391,7 +391,7 @@ MODULE_DEVICE_TABLE(of, ipq4019_mdio_dt_ids);
 
 static struct platform_driver ipq4019_mdio_driver = {
 	.probe = ipq4019_mdio_probe,
-	.remove_new = ipq4019_mdio_remove,
+	.remove = ipq4019_mdio_remove,
 	.driver = {
 		.name = "ipq4019-mdio",
 		.of_match_table = ipq4019_mdio_dt_ids,
diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ipq8064.c
index f71b6e1c66e4..6253a9ab8b69 100644
--- a/drivers/net/mdio/mdio-ipq8064.c
+++ b/drivers/net/mdio/mdio-ipq8064.c
@@ -162,7 +162,7 @@ MODULE_DEVICE_TABLE(of, ipq8064_mdio_dt_ids);
 
 static struct platform_driver ipq8064_mdio_driver = {
 	.probe = ipq8064_mdio_probe,
-	.remove_new = ipq8064_mdio_remove,
+	.remove = ipq8064_mdio_remove,
 	.driver = {
 		.name = "ipq8064-mdio",
 		.of_match_table = ipq8064_mdio_dt_ids,
diff --git a/drivers/net/mdio/mdio-moxart.c b/drivers/net/mdio/mdio-moxart.c
index d35af8cd7c4d..9853be6f0f22 100644
--- a/drivers/net/mdio/mdio-moxart.c
+++ b/drivers/net/mdio/mdio-moxart.c
@@ -171,7 +171,7 @@ MODULE_DEVICE_TABLE(of, moxart_mdio_dt_ids);
 
 static struct platform_driver moxart_mdio_driver = {
 	.probe = moxart_mdio_probe,
-	.remove_new = moxart_mdio_remove,
+	.remove = moxart_mdio_remove,
 	.driver = {
 		.name = "moxart-mdio",
 		.of_match_table = moxart_mdio_dt_ids,
diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index 62c47e0dd142..944efd33da6d 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -377,7 +377,7 @@ MODULE_DEVICE_TABLE(of, mscc_miim_match);
 
 static struct platform_driver mscc_miim_driver = {
 	.probe = mscc_miim_probe,
-	.remove_new = mscc_miim_remove,
+	.remove = mscc_miim_remove,
 	.driver = {
 		.name = "mscc-miim",
 		.of_match_table = mscc_miim_match,
diff --git a/drivers/net/mdio/mdio-mux-bcm-iproc.c b/drivers/net/mdio/mdio-mux-bcm-iproc.c
index 1ce7d67ba72e..8ba0917a930a 100644
--- a/drivers/net/mdio/mdio-mux-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-mux-bcm-iproc.c
@@ -342,7 +342,7 @@ static struct platform_driver mdiomux_iproc_driver = {
 		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
-	.remove_new	= mdio_mux_iproc_remove,
+	.remove		= mdio_mux_iproc_remove,
 };
 
 module_platform_driver(mdiomux_iproc_driver);
diff --git a/drivers/net/mdio/mdio-mux-bcm6368.c b/drivers/net/mdio/mdio-mux-bcm6368.c
index 1b77e0e3e6e1..476f8b72d020 100644
--- a/drivers/net/mdio/mdio-mux-bcm6368.c
+++ b/drivers/net/mdio/mdio-mux-bcm6368.c
@@ -173,7 +173,7 @@ static struct platform_driver bcm6368_mdiomux_driver = {
 		.of_match_table = bcm6368_mdiomux_ids,
 	},
 	.probe	= bcm6368_mdiomux_probe,
-	.remove_new = bcm6368_mdiomux_remove,
+	.remove = bcm6368_mdiomux_remove,
 };
 module_platform_driver(bcm6368_mdiomux_driver);
 
diff --git a/drivers/net/mdio/mdio-mux-gpio.c b/drivers/net/mdio/mdio-mux-gpio.c
index 38fb031f8979..ef77bd1abae9 100644
--- a/drivers/net/mdio/mdio-mux-gpio.c
+++ b/drivers/net/mdio/mdio-mux-gpio.c
@@ -86,7 +86,7 @@ static struct platform_driver mdio_mux_gpio_driver = {
 		.of_match_table = mdio_mux_gpio_match,
 	},
 	.probe		= mdio_mux_gpio_probe,
-	.remove_new	= mdio_mux_gpio_remove,
+	.remove		= mdio_mux_gpio_remove,
 };
 
 module_platform_driver(mdio_mux_gpio_driver);
diff --git a/drivers/net/mdio/mdio-mux-meson-g12a.c b/drivers/net/mdio/mdio-mux-meson-g12a.c
index 754b0f2cf15b..08d6a6c93fb8 100644
--- a/drivers/net/mdio/mdio-mux-meson-g12a.c
+++ b/drivers/net/mdio/mdio-mux-meson-g12a.c
@@ -348,7 +348,7 @@ static void g12a_mdio_mux_remove(struct platform_device *pdev)
 
 static struct platform_driver g12a_mdio_mux_driver = {
 	.probe		= g12a_mdio_mux_probe,
-	.remove_new	= g12a_mdio_mux_remove,
+	.remove		= g12a_mdio_mux_remove,
 	.driver		= {
 		.name	= "g12a-mdio_mux",
 		.of_match_table = g12a_mdio_mux_match,
diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 89554021b5cc..00c66240136b 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -149,7 +149,7 @@ static void gxl_mdio_mux_remove(struct platform_device *pdev)
 
 static struct platform_driver gxl_mdio_mux_driver = {
 	.probe		= gxl_mdio_mux_probe,
-	.remove_new	= gxl_mdio_mux_remove,
+	.remove		= gxl_mdio_mux_remove,
 	.driver		= {
 		.name	= "gxl-mdio-mux",
 		.of_match_table = gxl_mdio_mux_match,
diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
index b70e6d1ad429..9c4b1efd0d53 100644
--- a/drivers/net/mdio/mdio-mux-mmioreg.c
+++ b/drivers/net/mdio/mdio-mux-mmioreg.c
@@ -180,7 +180,7 @@ static struct platform_driver mdio_mux_mmioreg_driver = {
 		.of_match_table = mdio_mux_mmioreg_match,
 	},
 	.probe		= mdio_mux_mmioreg_probe,
-	.remove_new	= mdio_mux_mmioreg_remove,
+	.remove		= mdio_mux_mmioreg_remove,
 };
 
 module_platform_driver(mdio_mux_mmioreg_driver);
diff --git a/drivers/net/mdio/mdio-mux-multiplexer.c b/drivers/net/mdio/mdio-mux-multiplexer.c
index 569b13383191..8e11960fc539 100644
--- a/drivers/net/mdio/mdio-mux-multiplexer.c
+++ b/drivers/net/mdio/mdio-mux-multiplexer.c
@@ -107,7 +107,7 @@ static struct platform_driver mdio_mux_multiplexer_driver = {
 		.of_match_table	= mdio_mux_multiplexer_match,
 	},
 	.probe		= mdio_mux_multiplexer_probe,
-	.remove_new	= mdio_mux_multiplexer_remove,
+	.remove		= mdio_mux_multiplexer_remove,
 };
 
 module_platform_driver(mdio_mux_multiplexer_driver);
diff --git a/drivers/net/mdio/mdio-octeon.c b/drivers/net/mdio/mdio-octeon.c
index 037a38cfed56..2beb83154d39 100644
--- a/drivers/net/mdio/mdio-octeon.c
+++ b/drivers/net/mdio/mdio-octeon.c
@@ -104,7 +104,7 @@ static struct platform_driver octeon_mdiobus_driver = {
 		.of_match_table = octeon_mdiobus_match,
 	},
 	.probe		= octeon_mdiobus_probe,
-	.remove_new	= octeon_mdiobus_remove,
+	.remove		= octeon_mdiobus_remove,
 };
 
 module_platform_driver(octeon_mdiobus_driver);
diff --git a/drivers/net/mdio/mdio-sun4i.c b/drivers/net/mdio/mdio-sun4i.c
index 4511bcc73b36..ad1edadc5a08 100644
--- a/drivers/net/mdio/mdio-sun4i.c
+++ b/drivers/net/mdio/mdio-sun4i.c
@@ -164,7 +164,7 @@ MODULE_DEVICE_TABLE(of, sun4i_mdio_dt_ids);
 
 static struct platform_driver sun4i_mdio_driver = {
 	.probe = sun4i_mdio_probe,
-	.remove_new = sun4i_mdio_remove,
+	.remove = sun4i_mdio_remove,
 	.driver = {
 		.name = "sun4i-mdio",
 		.of_match_table = sun4i_mdio_dt_ids,
diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 2772a3098543..a8f91a4b7fed 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -441,7 +441,7 @@ static struct platform_driver xgene_mdio_driver = {
 		.acpi_match_table = ACPI_PTR(xgene_mdio_acpi_match),
 	},
 	.probe = xgene_mdio_probe,
-	.remove_new = xgene_mdio_remove,
+	.remove = xgene_mdio_remove,
 };
 
 module_platform_driver(xgene_mdio_driver);
-- 
2.45.2


