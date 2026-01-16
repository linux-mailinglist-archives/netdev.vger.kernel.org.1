Return-Path: <netdev+bounces-250587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529CD383FD
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D27300B80F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13CA397AC2;
	Fri, 16 Jan 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr/JNKbS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284352773D4
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585193; cv=none; b=AZfWrRDaWw4yM41tCFgjwHAuRk+oLCm/zlDVwDnvoezQRoLJhjKh2CGNTnDYgRj8tuIv1GnvosyvWcZy1bhm0TsJiZlAgKZKBBOpEhXLnWXDp06csnKrvNeM7JKOabQ+CJV0N1aCisPqIJA+M4V/+EB7nDmW4fDGhHqpQo8/4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585193; c=relaxed/simple;
	bh=0Ns5ry8nPIDuy0pKT9Vc2M8gL3gUutY5ASi4rgvUaFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmyZMtAoyLpr5R35oA1S6ZmOe6G4f+6aFW6zddnIShw5BdCd4H52SSy4g2bb4BTFaMY1gqF6mb+uw73uaWDxXVRoYNQOZO0LDJE/zqUmKcOO2mCLxQPYjU9F1WuwyjxQ9RyWPXrNaA3RpktnJT/kuSRJfl07HKFePH2z/jXCUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr/JNKbS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d21c411so7134035e9.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768585190; x=1769189990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdI0PuE/iOsfeLaDsQK/kzo1vrL+LEMsS6pxFXXCD08=;
        b=Gr/JNKbSqKUrhCuaOcOUBComsuj9EfMgOZChDkrCNlnzClyQWqg+Smfse92+6kw804
         qVHFYI24u90r8FXq3YYXWNQWs8GqIrdOMkmJ0wN/xwqp/AwUL3cdRrIogLaJ8ml6xd2H
         780w4sfKQu1TwdxMPq2fwthF/puIOa1MoltgObi0lpxAt5GQS6haHIG8UjREUS63PoDf
         fw8y5DSLabI41FOe6rJ/j50UC6SPHFm2n8i0rzLSq+mY//FQcEJ86VA6Zw4AhWGS7Ckd
         9aKCeT3m5J83sPuwAIjW2jF196mZ/ee5RHRVgwDhY3D44Wy+lCRMP8AA/hwqEq6gBfwa
         anWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768585190; x=1769189990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdI0PuE/iOsfeLaDsQK/kzo1vrL+LEMsS6pxFXXCD08=;
        b=JQaM2YZa//i4lGg6WJJxm20OL+pz1HBQzuLz3giJEQ5H6bXaZqOBLBDk3QgT5heyf+
         ZKb92VwmqrhPBp+3OjiVDq4Jd1OICg1+dmperDg9TZpXIGUwBiyHchbnGY4K6B+Rtd9W
         7o3sXCImW70ao7XriAM4dkz2/KqtkGXBtpavaXYb3fqjFDFrYghad2AzwCB/mtdKqGax
         7R0U3o+9cOuvWRdcvhxLiS0RUL9CdbnoJsCw48v64jd68FpCBMCFHLILQrcSA2pnX42g
         ugyU66SyQ0MOpcI/G9HQ3RW7fyHXag8bQMigNUMrTpuTMtCY+iK4hLQPFtmcP7WV2L8y
         30Hw==
X-Gm-Message-State: AOJu0YyFSulmuCEFM1FZO4dfqXZwUrSPfz03oy3G9dMRUzHtpTXPJM6o
	OOg0TuV8Vm6KDacI8QK8TKccQd1/f/H+cmrrVCwAUhcqDMn/RrSh4HPJE+aHJQ==
X-Gm-Gg: AY/fxX40FfitrTIv3ipbeOD42AL5w2RHlXtXejN8uk+aIZevhiaC6poW02aUc/6Tjpc
	dH9JmlXuv1rsNi7nEOZi6aiSBuEhoCjb4JFC9fMlgNxrbCnhz7whqfB1DifAj74/E1FibwFUTbP
	5Z9isvRgQu9LejR24NxxPBVIoC/W1LRKAxZd+pipGJz89cUDsCnwHYtwtmCfxXbEBo6v/bSLJrK
	GLnm4wbdBsO6P0DoGwzVBjnSwY++o456BeiTZkfaNQB83e+JnjuIfZvrIU1s58AIIu0eRHTXX4d
	8E9CD9zKl5L/vZms7hRtN9PjMaGngz7mo7jufgT2XQLaLqNSpdCJ+sD99b5UGKz4qnO7Xhprecq
	xNCFQJMKHS6SKwgRo70Nf/O0ozF410Pql8CynXq95YuPS4hNvTz7i4zDgXJQlw4qBLn2AuKwdHf
	Bfp+jjqaS5isM=
X-Received: by 2002:a05:600c:354a:b0:479:3a86:dc1f with SMTP id 5b1f17b1804b1-4801e3503c2mr40520235e9.37.1768585189887;
        Fri, 16 Jan 2026 09:39:49 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b26764fsm108902105e9.12.2026.01.16.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:39:49 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: netdev@vger.kernel.org
Cc: Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH 1/2] net: phy: realtek: add RTL8224 pair swap support
Date: Fri, 16 Jan 2026 18:39:19 +0100
Message-ID: <20260116173920.371523-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8224 has a register to configure a pair swap (from ABCD order to
DCBA) providing PCB designers more flexbility when wiring the chip. The
swap parameter has to be set correctly for each of the 4 ports before
the chip can detect a link.

After a reset, this register is (unfortunately) left in a random state,
thus it has to be initialized. On most of the devices the bootloader
does it once for all and we can rely on the value set, on some other it
is not and the kernel has to do it.

The MDI pair swap can be set in the device tree using the property
realtek,mdi-pair-swap. The property is set to "off" to disable the pair
swap, "on" to enable it, or "keep"/unset to keep the current
configuration.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 .../bindings/net/realtek,rtl82xx.yaml         | 13 ++++
 drivers/net/phy/realtek/Kconfig               |  1 +
 drivers/net/phy/realtek/realtek_main.c        | 74 +++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5d..2d04d90f8b97 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -55,6 +55,18 @@ properties:
     description:
       Enable Wake-on-LAN support for the RTL8211F PHY.
 
+  realtek,mdi-pair-swap:
+    description:
+      Enable or disable the swap of the ethernet pairs (from ABCD to DCBA).
+      The "keep" setting will keep the pair configuration at whatever its
+      current state is.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - keep
+      - on
+      - off
+    default: keep
+
 unevaluatedProperties: false
 
 allOf:
@@ -79,5 +91,6 @@ examples:
                 reg = <1>;
                 realtek,clkout-disable;
                 realtek,aldps-enable;
+                realtek,mdi-pair-swap = "on";
         };
     };
diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index b05c2a1e9024..a741b34d193e 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config REALTEK_PHY
 	tristate "Realtek PHYs"
+	select PHY_PACKAGE
 	help
 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
 
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 6ff0385201a5..e01bfad37cf5 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/string_choices.h>
 
+#include "../phylib.h"
 #include "realtek.h"
 
 #define RTL8201F_IER				0x13
@@ -162,6 +163,8 @@
 
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
+#define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -208,6 +211,16 @@ struct rtl821x_priv {
 	u16 iner;
 };
 
+enum pair_swap_state {
+	PAIR_SWAP_KEEP = 0,
+	PAIR_SWAP_OFF = 1,
+	PAIR_SWAP_ON = 2,
+};
+
+struct rtl8224_priv {
+	enum pair_swap_state pair_swap;
+};
+
 static int rtl821x_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, RTL821x_PAGE_SELECT);
@@ -1683,6 +1696,65 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static void rtl8224_mdi_pair_swap(struct phy_device *phydev, bool swap)
+{
+	u32 val;
+	u8 port_offset;
+
+	port_offset = phydev->mdio.addr & 3;
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_PAIR_SWAP);
+	if (swap)
+		val |= (1 << port_offset);
+	else
+		val &= ~(1 << port_offset);
+
+	__phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				RTL8224_VND1_MDI_PAIR_SWAP, val);
+}
+
+static int rtl8224_config_init(struct phy_device *phydev)
+{
+	struct rtl8224_priv *priv = phydev->priv;
+
+	if (priv->pair_swap != PAIR_SWAP_KEEP)
+		rtl8224_mdi_pair_swap(phydev, priv->pair_swap == PAIR_SWAP_ON);
+
+	return 0;
+}
+
+static enum pair_swap_state rtlgen_pair_swap_state_get(const struct device_node *np)
+{
+	const char *state = NULL;
+
+	if (!of_property_read_string(np, "realtek,mdi-pair-swap", &state)) {
+		if (!strcmp(state, "off"))
+			return PAIR_SWAP_OFF;
+		if (!strcmp(state, "on"))
+			return PAIR_SWAP_ON;
+	}
+
+	return PAIR_SWAP_KEEP;
+}
+
+static int rtl8224_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct rtl8224_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	phydev->priv = priv;
+
+	priv->pair_swap = rtlgen_pair_swap_state_get(dev->of_node);
+
+	/* Device has 4 ports */
+	devm_phy_package_join(dev, phydev, phydev->mdio.addr & (~3), 0);
+
+	return 0;
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -2212,6 +2284,8 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.probe		= rtl8224_probe,
+		.config_init	= rtl8224_config_init,
 		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,

base-commit: 983d014aafb14ee5e4915465bf8948e8f3a723b5
-- 
2.47.3


