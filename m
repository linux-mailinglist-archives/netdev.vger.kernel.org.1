Return-Path: <netdev+bounces-65245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D9A839B92
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F0B288FCA
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0795E48CCC;
	Tue, 23 Jan 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFChOyfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5224A987
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047038; cv=none; b=sfQoZzsMzgnP2QKV/WsA88sNlIGG4SCLOND/OX27WzFWxLmz86VvoNCp/jK7uRDmXVnuTlh8MKKfq/6lbrbiVsl7/jfldDiQ1elkJ+l4Hr+WG45K/dmOkr63KH7iWE3DiQPjGnfzHnIfKwM+jQu3GUAxE33rzVniXE8knOImbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047038; c=relaxed/simple;
	bh=NNoKHD0txK9XjZJh4xAMvaK9JGPuX0fSNDrccFFMa5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLN9Cxn/Fv4E9wyhSIhpc22Sv+5Esu7pCuc/L56R9fIx8vGVFViEjDkx4/RO6tWo56kZbL8TX7Nc6rSxZdKFRRiSDZJL2ZvCZBOWOrwToAcskHA2EgOD7xOl18y55pdlFVVvAE1UhswLbnXbdVNTnoayzj5EHDBIYzhUKOVfAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFChOyfl; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so3571884fac.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047035; x=1706651835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcTmuPDVM8skyCnFNVXCfMdNDXeWIVyP1PNNN8ZLF/c=;
        b=ZFChOyflsoTKBCZlD6h7LgrbcFDvG/XNNS9Ka/4BNipckAshGQUq3zhcKEQV+qc+8K
         cycj+BVOuV2tctz9JJRNkts00VCjBy4Fg665UCXVRRUWBnXUhqCOKpMJaQPY4Kh0O5mG
         s8AMjqW47HgCIHDi3DbB2HugpxqF43NUaM18Jg2t2hZw+vpsGl752FcGUvlkCzDOTpOG
         H2CK0MR36Tx8kJGpIPZ5Z8NcVoMA12gnmf7MDeEYMNKMPgn5G3DKI28IZQ4a8e5CEZ9H
         6EpiGk3KeK7sL633/11QNYTWNTkC0YMXtTH/xY8qJ/loBhs+Ibn4iA+0B0JVYn9KsIox
         /IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047035; x=1706651835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcTmuPDVM8skyCnFNVXCfMdNDXeWIVyP1PNNN8ZLF/c=;
        b=l2fu6dvlLU20/lydjk8286euQazRvG3rjMiTXBH168X89vGB1BFM+rm3B/LWUkj5hC
         eE9XpPje47GyudTUXF38nhL17wYooLLxlGvShhVtpFUO48OBaTIZJJOb61QUpgu0WGOo
         SLacsFfcRIcNEgtmv3ceeMvWUjZNqedj15jRrdg52amzash+qMRe8eRXYUCSNLLKa9KV
         oazm7q0MCMPXA/y4ODaypq5ty8zsP/31O9V+CjZ4/SOdjU+0McduAJZINHceVd1/Nbq8
         k4TVNIs5VnxxlyAe67jaxu9ba7EJ7JxhS1MYWMmBzkEYnlInaYM9JxbHyi/UiQcpHG/s
         vskA==
X-Gm-Message-State: AOJu0YzQu0jqzWs8b3uFl0GxF67TTm9qKz3bKepxEWG2Hb+1yqqbDytk
	69Jihhb9h5GZTC/6I9YQcsz5/sXZKgG10qn0ZoZVhufWyxTtv9wvRF9KDPSQwfg=
X-Google-Smtp-Source: AGHT+IEWyYuqrkP4MdtFab8m7Hop6ZGiRrssswsvtgR7wxJbqPuxMBKrZEygVAjKb064jtnAXwR8Dg==
X-Received: by 2002:a05:6870:2a48:b0:214:2972:f268 with SMTP id jd8-20020a0568702a4800b002142972f268mr2610423oab.45.1706047035483;
        Tue, 23 Jan 2024 13:57:15 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:57:14 -0800 (PST)
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
Subject: [PATCH net-next v4 06/11] net: dsa: realtek: merge rtl83xx and interface modules into realtek-dsa
Date: Tue, 23 Jan 2024 18:55:58 -0300
Message-ID: <20240123215606.26716-7-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123215606.26716-1-luizluca@gmail.com>
References: <20240123215606.26716-1-luizluca@gmail.com>
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


