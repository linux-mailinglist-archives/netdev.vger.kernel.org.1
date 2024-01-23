Return-Path: <netdev+bounces-65231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11035839B54
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AFD1F2481D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34F3FB09;
	Tue, 23 Jan 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ5RTaxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F738F9E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046296; cv=none; b=QmkJjREiMq0U9gmJoyxVexJefb+tyRhfWNfVJIBLt4xFB6TUMmd1VYsQ/BBROgsqnmW9q1qZCYOl6CV//Z6FtL8qpd26gD2VuVl50Sawv1gd209ij8JyQLU8yopqwS4QEwf1C9a2E8EKqg5qyrfivNaT2K+Z2O1UyTYyxjV6vB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046296; c=relaxed/simple;
	bh=NNoKHD0txK9XjZJh4xAMvaK9JGPuX0fSNDrccFFMa5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QghqidaLLWdbI+uQfYt4hViiIR8AxsP3OqwLYI6wrPpg+CPfRL+c98+JhncMUmjHZJtfEO3GQu4f1sm9nNEigB6VTiRjHBH08Zz9yNN+tK4yV5ch6ZAY0Q167LbtgzW2B6P0cx+YxkXyBGHUeDo84A707/6vJrijVFEAnH6hFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ5RTaxV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d51ba18e1bso43069445ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046293; x=1706651093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcTmuPDVM8skyCnFNVXCfMdNDXeWIVyP1PNNN8ZLF/c=;
        b=OJ5RTaxVdKCdKlkg57c3CdHcTbOD1KyTfPiP6Y2jOKmBxbYCO789OAn4WHqJBOe3iF
         v6xFi/yZD2BMfZY1i7w/L6zZQGhvDnE3BgtMlMSL8tDjfNdyVKqWo7JbmK/H+/hOi30s
         i1goA9iskxYMD0VrFPyTRuPwcD2qUzr/8BQK8g9Q+3EK8JMbKTtbRRFhjn7gizh8hiis
         m1whssWWG7Zgcvc68vRxWcmHk+S2Qy4R1JGGs27Y1sA0GaVKl3v3fof39A3cdPInbGT9
         QkJv2Zo+7MIGrsEqGXAuH9YJdyFJ+nrBZ+7zlhwY1G3CUMe0/XirAugJCBrHA3tCSGAq
         S7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046293; x=1706651093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcTmuPDVM8skyCnFNVXCfMdNDXeWIVyP1PNNN8ZLF/c=;
        b=kaFcyPIM1lS9vuTzpIYuXdU5j2iMhM7SebE0Kwa2YQo0eCzw7mj+UFR0qNkhuaeAv7
         2ByzQ9g0+xk4edSl/id89O8iLIY2KRGTLtj76aqFq0KVQsRJZzxeZWYYsjxlJNCIStOG
         9Y9DdFoM2OdLuxuTiQad2SrFHJ3hefdwnEXi0HBA62j0iAYjKZw0ocf3ILqJC+KuYqeV
         TzCwnJYb4Llc5EsIFcSxvtsLh0ZqBkcDQTShFOgGYuG0/BkicPDiyQwKxhawVmiN5pKl
         E4K3IPK1dLU9ATuBaHKryVF656xJnLu3ia5wTM3EdVlCk/1+Cxd1dBopwxDhmBFOYfNg
         xxaA==
X-Gm-Message-State: AOJu0YydgWuATyxyemAtPPGmMGYS+Eg9GTprHs3lHuNGFADPFmLGOj6S
	2SdN4Vj9ATFmwkmTWN2qdKIDh/cLGusDPLPtHH4Se4aAtnDiFQN3J0r/tDIcXGY=
X-Google-Smtp-Source: AGHT+IG6C4BJoncPprjUeLhl9nwImNIKhB9Hh2onBAqzw0pXyTBpa3IsJt8Kv4Sf9GIOizVTsNj9UQ==
X-Received: by 2002:a17:902:9893:b0:1d4:cd41:e44b with SMTP id s19-20020a170902989300b001d4cd41e44bmr7157678plp.124.1706046293427;
        Tue, 23 Jan 2024 13:44:53 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:52 -0800 (PST)
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
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH 06/11] net: dsa: realtek: merge rtl83xx and interface modules into realtek-dsa
Date: Tue, 23 Jan 2024 18:44:14 -0300
Message-ID: <20240123214420.25716-7-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since rtl83xx and realtek-{smi,mdio} are always loaded together,
we can optimize resource usage by consolidating them into a single
module.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Kconfig        |  4 ++--
 drivers/net/dsa/realtek/Makefile       | 11 +++++++++--
 drivers/net/dsa/realtek/realtek-mdio.c |  5 -----
 drivers/net/dsa/realtek/realtek-smi.c  |  5 -----
 drivers/net/dsa/realtek/rtl83xx.c      |  1 +
 5 files changed, 12 insertions(+), 14 deletions(-)

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
index 67b5ee1c43a9..6ed6b4598d2e 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
 realtek-dsa-objs			:= rtl83xx.o
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+
+ifdef CONFIG_NET_DSA_REALTEK_MDIO
+realtek-dsa-objs += realtek-mdio.o
+endif
+
+ifdef CONFIG_NET_DSA_REALTEK_SMI
+realtek-dsa-objs += realtek-smi.o
+endif
+
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 26b8371ecc87..0171185ec665 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -191,8 +191,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
 
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
-
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 840b1a835d07..5533b79d67f5 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -470,8 +470,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
 
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
-
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 57d185226b03..3d07c5662fa4 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -197,5 +197,6 @@ void rtl83xx_remove(struct realtek_priv *priv)
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
 MODULE_LICENSE("GPL");
-- 
2.43.0


