Return-Path: <netdev+bounces-55180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E99809B32
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52EEB20D33
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36775221;
	Fri,  8 Dec 2023 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVRINDQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1946F1720
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:52:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so942089b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 20:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011119; x=1702615919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpH6jZQ9zwuKUS/xyDafAoPM/JI3TSc6VKYkKHHLkJc=;
        b=NVRINDQ99SbELl2yxIUHUrIY/EphkpLID8EVVN1Y4qw+A1QD6Bzsp7cKFmgyYffgI5
         0+fJDhVvlunElwKNtB493PCpnR2jofcgmhwuBvNppsBh3ioSR2KhGR08+E2pPyDt431+
         ZGdbrGkhCPBuyrN3c3pKgSlEWrctK2fNHp2rJfRuT9DOjoX9/qUJt+yh+Ft9+2KbbHlF
         70rDwL6jeNBoyhf5pJW7eApiBce1KrEk4+gKvMrUtiAPY61H2NLn3KbZq0DhDp97uS3S
         P5csgjZeLfEewhSODmDQOKRMRfvRW6WbP3FJFeIJ5WURhQ3EIMPrwdC1qtt15jSJ5PRT
         WGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011119; x=1702615919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpH6jZQ9zwuKUS/xyDafAoPM/JI3TSc6VKYkKHHLkJc=;
        b=WekmV+AmYa5tMbAAXM5h3Py7rP+0QH7MjmO+DO0gs10s7Qyuj2LfXj91H8mB/IHlPK
         LpaeWHAVFofPWID3VuwNPbg4ABqOLpVII8AehUEkxMlzf1ci+K9VRlwgYmKoj9fh0MEK
         nrZH9ROPnTQcxEcQrm6pP75p0PVdNBK0gtiQkwMNysVU3kri83IhAtzXhjwiJP73i5cJ
         dXYOLwk75oxhPGqEarQo6wSaF2BrE6x0JoIiDvJYQAfKkjmt6jyuJRw+waEuj8FgDuOr
         sTltGCucS1CEOKjvAGDtpoV5vYHIQGfOLU1Qk3xC8bS+selG9JoL74x6zkqLPGvusGhn
         Esrg==
X-Gm-Message-State: AOJu0YwvVtmBnZnF0uaom8pHLTccOUFOriLF5Qr0U8EAe0331fuwLGAW
	yRlTvIOlEebcC+BkgAxDgsud6tBWUyE+vOMS
X-Google-Smtp-Source: AGHT+IEgA7gOazd6nwVESsBj+HX5jRK1MDRamGL65Eqm+w5rlMthhXQYsw6skLnUnpViYZNgIs2sjw==
X-Received: by 2002:a05:6a21:a5a2:b0:18b:826d:1e89 with SMTP id gd34-20020a056a21a5a200b0018b826d1e89mr444470pzc.12.1702011119655;
        Thu, 07 Dec 2023 20:51:59 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b006cbae51f335sm657865pfe.144.2023.12.07.20.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:51:59 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next 5/7] net: dsa: realtek: merge interface modules into common
Date: Fri,  8 Dec 2023 01:41:41 -0300
Message-ID: <20231208045054.27966-6-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208045054.27966-1-luizluca@gmail.com>
References: <20231208045054.27966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As both realtek-common and realtek-{smi,mdio} must always be loaded
together, we can save some resources merging them into a single module.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Kconfig          | 4 ++--
 drivers/net/dsa/realtek/Makefile         | 8 +++++---
 drivers/net/dsa/realtek/realtek-common.c | 1 +
 drivers/net/dsa/realtek/realtek-mdio.c   | 4 ----
 drivers/net/dsa/realtek/realtek-smi.c    | 4 ----
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 9d182fde11b4..6989972eebc3 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -16,14 +16,14 @@ menuconfig NET_DSA_REALTEK
 if NET_DSA_REALTEK
 
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface support"
+	bool "Realtek MDIO interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface support"
+	bool "Realtek SMI interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches connected
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 5e0c1ef200a3..88f6652f9850 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-common.o
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek_common.o
+realtek_common-objs-y			:= realtek-common.o
+realtek_common-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
+realtek_common-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
+realtek_common-objs			:= $(realtek_common-objs-y)
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 75b6aa071990..73c25d114dd3 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -132,5 +132,6 @@ void realtek_common_remove(struct realtek_priv *priv)
 EXPORT_SYMBOL(realtek_common_remove);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 4c9a744b72f8..bb5bff719ae9 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -168,7 +168,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 EXPORT_SYMBOL_GPL(realtek_mdio_shutdown);
-
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 246024eec3bd..1ca2aa784d24 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -443,7 +443,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 EXPORT_SYMBOL_GPL(realtek_smi_shutdown);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
-- 
2.43.0


