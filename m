Return-Path: <netdev+bounces-213497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8EB255CF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F2F9A3535
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF292F39D8;
	Wed, 13 Aug 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1qd+VyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E662F39A3
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121396; cv=none; b=uNRKTd123jPUSq0xZoghIRpy8V/+rOJH+bH/qb0dcjPwnNyqbGJSD3IbN9oryz5KKXvrO20UMfq+0w21Q2LfeixEFc4IgKEhwcF4UgP/0EOmzq3M8RYrQ69qe9NGV5h0Rza8m/h3ACzaoexwWX/uX2CHeEtkAhoia4AAF//g1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121396; c=relaxed/simple;
	bh=ZV4mp/JpsFPNhTFwJr+B/94pXmy9uhFvcwwZB7PCvDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=estNSr/HYjXy1lhyjhPrg33+0PwNWEStJMolPIqp5c+Y/VaRczvDVw2Z6y8Lm+axx3bAJE7DwHi7aBkzh/kF0XdnqeIlLV6SBCF+hTyJyrgOsvYFBHcwPQeuX/CqiX4fnoBh9FTA2ftBkITu0fGJSa2yFMDxZl3ntWbtpEnDRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1qd+VyY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55ce526ac04so242842e87.2
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121392; x=1755726192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqxq3FXc7gnBDDCb2sYWXHZ4Cl59gRTrFdQIp90EmMg=;
        b=K1qd+VyYgWuuAscabdzriD0Btfl+oPj18T2MHBKNHsk9P9P5xgcV8lFigCd1uorjz6
         WZaQhsjK0oOcDEQRcLGesfCZ6neswGXI3pUQRLThW4BxS2S2sb01IPBYOc1wvIYbm/Fz
         ATK3Ko/Q+6iMLwb0uUWgOpyIY0w51qufdIRcI5gjnPOJJmEiOQwLOSM0l1AAREwW5ak6
         gSEIqPoM6Dk3WMmWmmCEgfJzYHraP4rXAxBuk6uvGxexsVor6ZyCkN7lzE+V4jX7NqPh
         qHjnJd2pVyurJSHaF4opu6g8917MqrfalueFan3OTo0X79wfxOh8IXUcrzYsdEjusEu1
         +apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121392; x=1755726192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqxq3FXc7gnBDDCb2sYWXHZ4Cl59gRTrFdQIp90EmMg=;
        b=nsCftfo/j/w5OuXFR0P5TwJKjFCtasYoi/IoOuzJVAJT0kvT/x/3vKdC4HeMX7MLlX
         HGRdvViA8v5C9Bo+kAYtunaJR/KnG6vinWIIrxRdVrJqw2FdQ7zjf9rByMS1rn7TgXQ2
         4nQPwjo32i88xHXLHMDUIXhiIVJut7INSer3t/efjXBBCmkjdsG+GTIYKG4vPTu5KFCv
         m9LiH1JoVxmJ5f4XztKMRUeSJ6JOeDiqI6T2JxGrjpVSTgj+RtodEieEE7WpPkJy2pjs
         cBvdgdaoswOwkUG0dAiU8hXUwkPaDqZGjdGB4XLe7YSKXIsRYs9nLqxsBc+pa6FZemGn
         Qlng==
X-Gm-Message-State: AOJu0Yxn52dA9Sw50raHdK4IBoMx6c/38qAKUwGkO7i6zDXV1BMWlFi7
	6ZayPnVOVdOcbli8bIeqymb2nFnpTOQbBNnsJWZcvUgd5JgKWrDlA7v0pUv2zIqaZV4=
X-Gm-Gg: ASbGnctqCD1uXyJOBA9nNgXRusSkcxxcxNkZvuGVvN55PwpEtyFDi+myevP989w0rOb
	MnLh+lq5VAbKg269QwNMpERw8KJHM/Ww1I/Hg7SIu6kgO0inasOjB97LOcw2GLrbXnNO5SYV6Ag
	6ZKEwSqjuXtPSzqWsU+LnkPeP2hcBtCj9cDIrFb0uYtkBlBRebU6/bsf4ACXcv9jww2aGz18I4p
	PSXVQ3qmG3jvulYeYdrQis8cdbB+U6j05VNrTPl0yNZ5VD8qeMEIi/9B7ku+FJElBp8t01P8hYq
	4Nl581U73zfox9SFWPaNE/Fhpr0+s59jP3xqTfD/DBsk+Og6KJXcYeHUJ3UgdkXhZFkKALt18Pd
	T0xuUnsMkYJMx7Ixbwk1n9BRe/iPCRFZnq9dr8Q==
X-Google-Smtp-Source: AGHT+IE2oKz/PzDY7B2m3zEncqnsdmwXMQo6uEBSLPJxvafdvm1F1QxuBogIhB+84YFfbOkUWc3cIA==
X-Received: by 2002:a05:6512:1382:b0:55b:7c51:cc66 with SMTP id 2adb3069b0e04-55ce6316ce4mr85574e87.32.1755121392397;
        Wed, 13 Aug 2025 14:43:12 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b95a105d4sm4732918e87.160.2025.08.13.14.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:43:11 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:43:03 +0200
Subject: [PATCH net-next 1/4] net: dsa: Move KS8995 to the DSA subsystem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ks8995-to-dsa-v1-1-75c359ede3a5@linaro.org>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
In-Reply-To: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

By reading the datasheets for the KS8995 it is obvious that this
is a 100 Mbit DSA switch.

Let us start the refactoring by moving it to the DSA subsystem to
preserve development history.

Verified that the chip still probes the same after this patch
provided CONFIG_HAVE_NET_DSA, CONFIG_NET_DSA and CONFIG_DSA_KS8995
are selected.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/Kconfig                        | 7 +++++++
 drivers/net/dsa/Makefile                       | 1 +
 drivers/net/{phy/spi_ks8995.c => dsa/ks8995.c} | 0
 drivers/net/phy/Kconfig                        | 4 ----
 drivers/net/phy/Makefile                       | 1 -
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index ec759f8cb0e2e042ec011204e9b8a22aeb5aae14..49326a9a0cffcb55da2068d8463c614cf6465243 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -99,6 +99,13 @@ config NET_DSA_RZN1_A5PSW
 	  This driver supports the A5PSW switch, which is embedded in Renesas
 	  RZ/N1 SoC.
 
+config NET_DSA_KS8995
+	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
+	depends on SPI
+	help
+	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
+	  switches, managed over SPI.
+
 config NET_DSA_SMSC_LAN9303
 	tristate
 	select NET_DSA_TAG_LAN9303
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index cb9a97340e5803c3e1899606a814a99ebb77e7fa..23dbdf1a36a8af6842e8c0e7fb12ee24a0dd36d8 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
 ifdef CONFIG_NET_DSA_LOOP
 obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
 endif
+obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o
 obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/dsa/ks8995.c
similarity index 100%
rename from drivers/net/phy/spi_ks8995.c
rename to drivers/net/dsa/ks8995.c
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 28acc6392cfc897bfbdbd0d3434963a1ac1ff5b7..a7fb1d7cae94b242cde2af4f0e883d550b5eabde 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -465,7 +465,3 @@ config XILINX_GMII2RGMII
 	  Ethernet physical media devices and the Gigabit Ethernet controller.
 
 endif # PHYLIB
-
-config MICREL_KS8995MA
-	tristate "Micrel KS8995MA 5-ports 10/100 managed Ethernet switch"
-	depends on SPI
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index b4795aaf9c1ce2e1947b07752574533cd2be69b6..402a33d559de6a1b1332e20b4afaaf34c2b61cfb 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -72,7 +72,6 @@ obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
 obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
-obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
 obj-$(CONFIG_MICROCHIP_PHY_RDS_PTP)	+= microchip_rds_ptp.o

-- 
2.50.1


