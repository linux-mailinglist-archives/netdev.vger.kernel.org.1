Return-Path: <netdev+bounces-59145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9338D8197C8
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5136F2847C4
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE82BE76;
	Wed, 20 Dec 2023 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI20Wv5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A7D312
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6da579e6858so3586248a34.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046428; x=1703651228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWz4Xu102Nlcd7/SSWTHxAc5RvkndIFP65cWGZBX+Ck=;
        b=jI20Wv5BwjobNxoFzOyD9eWJEdq1C+Q+4RQ8QH/4iqu9kTqTJxQG+wLf52BJv7Mlig
         iRwn/H2If19AA6k4qItK8Q0uUBYgj1ND1+WoqidQ1+DeB/R+QsYiy1vCZyR0QPuxLHNF
         Gbv+C/+6htZ2s/68K/JAksQv1J+H1yReX0FWP7G5E2t6UMUcDyO4JbF9aBpONsgGrFNe
         seBEg9sK59T53Wk5+T/DkjUD+5/qwFlPOl4piLtaxXWlVpW1hh8uT3iMekxJvqPqVqtS
         rrOnX+l2E+g2bgjeH/5cATJ8Bc8npNhoBTNi7XZ9zGB1swPUxIQlw+5O1triUmZV6AhZ
         jgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046428; x=1703651228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWz4Xu102Nlcd7/SSWTHxAc5RvkndIFP65cWGZBX+Ck=;
        b=OYpq2PEw5eQldVwixjDuFNajEzM+m0qC7OCqV5O2yywhzu7wxhb3rk3bZIcWc7JLOd
         IpFQtuVEuBBGqANIqPZOb7UG2WfstzTurIjGUcYjrHo0Od2+ppyljcCcgifVzt8CCKfg
         3IhH92vBvW12bcl2z1+hr2YItlKN95WSAZkRaACvS5zdQqFvoXHVnT4iu3yN32PLfZGM
         kYhFB/cNgbD747mVzWUMx9hlOzR7qD7AATWsLqvNO1m9kjzlkgR0uaHWUfCjSgQ3QEKP
         d/tQiFLF5xzFlDW9p3JCUgWfCDsVA5f/C3feN7xIPObi5o8gkyEXLsd/JCPI8unIjuvQ
         9d6g==
X-Gm-Message-State: AOJu0YxjJ6wGuM5GlRGU7JjIjYod0ta4duVd4r60dzuj3TChNcKsx35O
	1lGqMNeL0BSlGo6eyIUaZIQKeYlYwjQ8RQ70
X-Google-Smtp-Source: AGHT+IEvG+qfJ7CjShDF5aH+dxdWEQ/TbZpr2NhRj4kVegldF68n/Gbcp5T5weKMbZRd915rnfihrA==
X-Received: by 2002:a9d:6e86:0:b0:6d8:7937:876a with SMTP id a6-20020a9d6e86000000b006d87937876amr19881602otr.17.1703046428193;
        Tue, 19 Dec 2023 20:27:08 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:27:07 -0800 (PST)
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
Subject: [PATCH net-next v2 4/7] net: dsa: realtek: merge common and interface modules into realtek-dsa
Date: Wed, 20 Dec 2023 01:24:27 -0300
Message-ID: <20231220042632.26825-5-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>
References: <20231220042632.26825-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since realtek-common and realtek-{smi,mdio} are always loaded together,
we can optimize resource usage by consolidating them into a single
module.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Kconfig          | 4 ++--
 drivers/net/dsa/realtek/Makefile         | 7 ++++---
 drivers/net/dsa/realtek/realtek-common.c | 1 +
 drivers/net/dsa/realtek/realtek-mdio.c   | 4 ----
 drivers/net/dsa/realtek/realtek-smi.c    | 4 ----
 5 files changed, 7 insertions(+), 13 deletions(-)

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
index f4f9c6340d5f..cea0e761d20f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
-realtek-dsa-objs			:= realtek-common.o
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+realtek-dsa-objs-y			:= realtek-common.o
+realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
+realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
+realtek-dsa-objs			:= $(realtek-dsa-objs-y)
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index c7507b6cdcdd..bf3933a99072 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -133,5 +133,6 @@ void realtek_common_remove(struct realtek_priv *priv)
 EXPORT_SYMBOL(realtek_common_remove);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 1eed09ab3aa1..967f6c1e8df0 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -177,7 +177,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 EXPORT_SYMBOL_GPL(realtek_mdio_shutdown);
-
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index fc54190839cf..2b2c6e34bae5 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -456,7 +456,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 EXPORT_SYMBOL_GPL(realtek_smi_shutdown);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
-- 
2.43.0


