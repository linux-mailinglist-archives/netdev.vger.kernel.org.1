Return-Path: <netdev+bounces-131539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB598EC9C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F81C21043
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3F1494A6;
	Thu,  3 Oct 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qFmD3zqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4814A604
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949705; cv=none; b=BC3AyVTk1hrEttkNYjz+zTRcLdrymcsjc3Iy6Wr55q7uGUa+Jgrui1CINEr2M7X8fced1C/yrhpNUGbcypQtEX4ybz5ETsNwaTq+glheYTRkxMA2jlBVPOwacASDBDG4m/bqH0ZRDY1d9EmFfJWCjWtAltfrUUt6pLwuOOwIn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949705; c=relaxed/simple;
	bh=g4ytOYyvo4PYrBkqSVRneSzcAZkXG+cl6zY/jR/Wbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoFxevhHayFHH/KXp4NO7nJatktu6TMfHaj7zUeGmrB5phryeCc7dtpWO+B/5lfN1UtRK+DFJsGlDLPHY+KXABQliCMHSWsYBmQfkDXcaHlRYomr8cAC/BYQuMrBTzbOeDS4r64AZtaM+kyH5GmSJodTMjou1ni5DAnPrE39NxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qFmD3zqm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so9813385e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727949701; x=1728554501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07qYz3vJ3LBs6hljDu1iC7wgJzUjfX/ESzurkb1Cw2o=;
        b=qFmD3zqmQXOxj/ah/TOZvYtYhDE1Z9H3g6KQ0E/46moLUyMvbB9MY2Zu+OuruNq5Mq
         LFJOVQTljzhRfWw+m2W66H+ZyB37fJXBHFvtI/22Crb7jVNzsJ/9MBDNbi/li3PYKrk9
         Qldod4ho3pw4uZhYYIoiQ6Z4MrJ7PDFBF4xPCYGtt+VDmYnpTBAOwDy9dZAxPIWK2xfp
         iw1/rra7CRoXspL3ezS53lRtsRPQzbJVAkYFbLdItXnGdRZP6E+u5owc0BpU5WqjtKov
         bOG9npT67fCCvGnfk1uVzj1SUy7CtcGDPROKfHmyca7355OM0LUB2Zqo6EFAa1CAK55b
         Bfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949701; x=1728554501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07qYz3vJ3LBs6hljDu1iC7wgJzUjfX/ESzurkb1Cw2o=;
        b=CwyYXBIEg+ELcMkDpbUD1donjUGJNS2B6xUDQS4p7AOi5U+b5WO4perMQ+f+kOr9Cj
         lVRyeX+qI1s12A4nBTEC+hHvqklQbbcDvQ6NczRryjfQ6Krr/q8dtlb7CvViixMPGEth
         OMCpTFc00E4TiZiwMoLVBaU4DnsL71CLSQBKzHNJRugMUUFKirVoWnT7rUaw09tQRrFD
         BHcZZrnTEA0aE1B4eAlnqUf9qUCFd/IBno9exsFtBt/yvh5HbujPL4otjIbqZMaNBDSx
         4Znr1VmsgtaUQe4UXE+rYrSHfzarwQ5ttAqsDihCa4kf0iAF8rpfV+1Z6lFB/a4N3xJN
         RpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkKPaF5fhot3a2TFPhiGpoXP/0q9jAYg2hMhxr3OCQ3zt6rlDz3PpHcC6tMq+K+L6ycEV3Cx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwOoJAeS2ZYae/1vN3d554ntI2VFhoX1UHw9xau8YLCm0/YSP
	Oc9FXy2F7X2DefbD5X6QwVv3rr3eQ+H16hkF7nn64L0WpTHejkkNHU5ct+RzUgE=
X-Google-Smtp-Source: AGHT+IFwkCUvkbuz+MHpJSkn0QoNZJZWEG1EoxKplhPunVN0UV5Y+QCkNvIaTF+YedDKZ8xcSecgkw==
X-Received: by 2002:a5d:67ca:0:b0:37c:c4c0:9b78 with SMTP id ffacd0b85a97d-37cfba18588mr5420136f8f.48.1727949701427;
        Thu, 03 Oct 2024 03:01:41 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6dfesm910216f8f.117.2024.10.03.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:01:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: Switch back to struct platform_driver::remove()
Date: Thu,  3 Oct 2024 12:01:06 +0200
Message-ID:  <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6313; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=g4ytOYyvo4PYrBkqSVRneSzcAZkXG+cl6zY/jR/Wbo8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm/mtu36uNzBKdU0ttC1myXEuPlVLVr0JUfKCP0 eFGnRXFe/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZv5rbgAKCRCPgPtYfRL+ TqebB/9K0AGyQRUXCAt2A03ch+Fh5CLOS/6Kw1VEmnRL2HFtVs3iXc4t3nZZXrP6+MGULonILTj wCIqVUND1cIdvolLGbXWsKzhZf11cqgLS3AHsKEJoREe8E13/zVTPoK32rv8AnyrOGrY36lb8HQ 1XDQu9IE1qsxZcfvxKKYKij/vGf0OBMuKUzMQngHpF603qKBoBnKbEJDX5oyjvjbUZ+JW9fT0a8 a6HrtzRLvv1DnhWdyx7KXN91QfZi84flaPWL6a9YqYySt1nHrMS9J67imQDP8KE8uuVGpUHf+q2 RMeHvEFkcRzYWkmQK3j3SYVqZ+1PX8aYF1gGVD5+rccULRcl
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/net after the previous
conversion commits apart from the wireless drivers to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/fjes/fjes_main.c             | 2 +-
 drivers/net/ieee802154/fakelb.c          | 2 +-
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 drivers/net/ipa/ipa_main.c               | 2 +-
 drivers/net/pcs/pcs-rzn1-miic.c          | 2 +-
 drivers/net/phy/sfp.c                    | 2 +-
 drivers/net/wan/framer/pef2256/pef2256.c | 2 +-
 drivers/net/wan/fsl_qmc_hdlc.c           | 2 +-
 drivers/net/wan/fsl_ucc_hdlc.c           | 2 +-
 drivers/net/wan/ixp4xx_hss.c             | 2 +-
 drivers/net/wwan/qcom_bam_dmux.c         | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index fad5b6564464..4a4ed2ccf72f 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1466,7 +1466,7 @@ static struct platform_driver fjes_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = fjes_probe,
-	.remove_new = fjes_remove,
+	.remove = fjes_remove,
 };
 
 static acpi_status
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 2930141d7dd2..e11d8eda85ea 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -235,7 +235,7 @@ static struct platform_device *ieee802154fake_dev;
 
 static struct platform_driver ieee802154fake_driver = {
 	.probe = fakelb_probe,
-	.remove_new = fakelb_remove,
+	.remove = fakelb_remove,
 	.driver = {
 			.name = "ieee802154fakelb",
 	},
diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 2c2483bbe780..1cab20b5a885 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -1047,7 +1047,7 @@ static void hwsim_remove(struct platform_device *pdev)
 
 static struct platform_driver mac802154hwsim_driver = {
 	.probe = hwsim_probe,
-	.remove_new = hwsim_remove,
+	.remove = hwsim_remove,
 	.driver = {
 			.name = "mac802154_hwsim",
 	},
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 5f3dd5a2dcf4..f25f6e2cf58c 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -1012,7 +1012,7 @@ static const struct attribute_group *ipa_attribute_groups[] = {
 
 static struct platform_driver ipa_driver = {
 	.probe		= ipa_probe,
-	.remove_new	= ipa_remove,
+	.remove		= ipa_remove,
 	.shutdown	= ipa_remove,
 	.driver	= {
 		.name		= "ipa",
diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index d0a722d43368..61944574d087 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -552,7 +552,7 @@ static struct platform_driver miic_driver = {
 		.of_match_table = miic_of_mtable,
 	},
 	.probe = miic_probe,
-	.remove_new = miic_remove,
+	.remove = miic_remove,
 };
 module_platform_driver(miic_driver);
 
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a5684ef5884b..7851bfad3572 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -3146,7 +3146,7 @@ static void sfp_shutdown(struct platform_device *pdev)
 
 static struct platform_driver sfp_driver = {
 	.probe = sfp_probe,
-	.remove_new = sfp_remove,
+	.remove = sfp_remove,
 	.shutdown = sfp_shutdown,
 	.driver = {
 		.name = "sfp",
diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 413a3c1d15bb..1e4c8e85d598 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -863,7 +863,7 @@ static struct platform_driver pef2256_driver = {
 		.of_match_table = pef2256_id_table,
 	},
 	.probe = pef2256_probe,
-	.remove_new = pef2256_remove,
+	.remove = pef2256_remove,
 };
 module_platform_driver(pef2256_driver);
 
diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 8fcfbde31a1c..8976dea8e17e 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -799,7 +799,7 @@ static struct platform_driver qmc_hdlc_driver = {
 		.of_match_table = qmc_hdlc_id_table,
 	},
 	.probe = qmc_hdlc_probe,
-	.remove_new = qmc_hdlc_remove,
+	.remove = qmc_hdlc_remove,
 };
 module_platform_driver(qmc_hdlc_driver);
 
diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 605e70f7baac..f999798a5612 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1290,7 +1290,7 @@ MODULE_DEVICE_TABLE(of, fsl_ucc_hdlc_of_match);
 
 static struct platform_driver ucc_hdlc_driver = {
 	.probe	= ucc_hdlc_probe,
-	.remove_new = ucc_hdlc_remove,
+	.remove = ucc_hdlc_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.pm		= HDLC_PM_OPS,
diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 931c5ca79ea5..720c5dc889ea 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1534,7 +1534,7 @@ static void ixp4xx_hss_remove(struct platform_device *pdev)
 static struct platform_driver ixp4xx_hss_driver = {
 	.driver.name	= DRV_NAME,
 	.probe		= ixp4xx_hss_probe,
-	.remove_new	= ixp4xx_hss_remove,
+	.remove		= ixp4xx_hss_remove,
 };
 module_platform_driver(ixp4xx_hss_driver);
 
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index 26ca719fa0de..5a525133956d 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -891,7 +891,7 @@ MODULE_DEVICE_TABLE(of, bam_dmux_of_match);
 
 static struct platform_driver bam_dmux_driver = {
 	.probe = bam_dmux_probe,
-	.remove_new = bam_dmux_remove,
+	.remove = bam_dmux_remove,
 	.driver = {
 		.name = "bam-dmux",
 		.pm = &bam_dmux_pm_ops,
-- 
2.45.2


