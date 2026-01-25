Return-Path: <netdev+bounces-253197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIG1KQR3dmnqQwEAu9opvQ
	(envelope-from <netdev+bounces-253197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:03:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14085824BE
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 210B93008531
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B62FFF9F;
	Sun, 25 Jan 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hljpeDQI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3592F2613
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371388; cv=none; b=e7n3eo1SacKWdmJKYXR0p5QWaqstNvktgwvUAeLSvc4cPeWbSUUbVhudMmYRJ31I385bkvcW711ddFvfWCS5QKPk5xVujoJx+A0IIoyFcec31zf/x2KXZ87sJbsQiu5SchkHacQwWnfZsZABQqycvwQlBBkP9SfjuTimWRcrdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371388; c=relaxed/simple;
	bh=zX0hvxkuGDXQOHT/dO0h+VlGuaLocZjx0MrL6MxaSPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYnH2mbij3NwA3IJCTfxfPRGUgpqpy1BShwLhULcNkYaVqjHq3s6w/4fhzcVQOQXxGnIexmh7T95MtPC0w5ilnYgpK77RkgVCiWOBGOCtA4FRXIGtM9/1mUeB1JKq0KEF49zA8ikNOskyvc/U1AfhQ7RNurPkWbcfQbNifiTomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hljpeDQI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c96215so3494216f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371385; x=1769976185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4+ulA35JyJCbjFvyxZuNovtvFtG6lbRB2yZddCZVz8=;
        b=hljpeDQIk5u/vWjCpOzGGQp0w0D8vSxPefZEAZZQ/WNnLuksqyRXOWsPu6i+0KxfUm
         IV7arwFsP02P0rAK7omYPzeK8jxE+59AsU9MVwWevPXjyOT/1TYUjZaRtsyjCsUt26j4
         DfMCZ9dSvdnfV1cp3ISf1RXRguiJbtlIidbW2Dszj7kSXxuXht5FEKH00jV/nD4tvo/o
         nOPmFhgY/gL1yTW/RU+qWMvPcQjfmUHCgZIoR4xWWZ6sb/6Pl2efUGo8IfU79DteGtE/
         UjC3QEGQrSnIqopxVnzbcQ/wjFgQsE1K6/+M45t6rx9erCrxGSELo6OrRXHczyb08XpH
         YuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371385; x=1769976185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4+ulA35JyJCbjFvyxZuNovtvFtG6lbRB2yZddCZVz8=;
        b=TCGiHw0Y+RvcbOk3ztBbux9W1UQCJgTfy+mlc+Rfrb340Oqmzbf1zCxjsElLW8ipLL
         LlDJ/rxBkyAoVMPAzeIyLE+w61dwMLL1UJ0jUvqHkDvo8/BedFKhiI1UyJujWAYygShd
         wnyppbeiLFTX+nn2mzL+G7rxovoE0yU2BhEH31JVA/D7xc+d2yJ0JxqfGf6BihV4KuyG
         8jTVUoNbAwAWvStKQoaO2KDd0qu+PTDKq46+fvAzd3oovAVnzMFJ5JIOFaJEjx8qHa2k
         xocTdZqLV6vQehElTS9hTHP25x+jadBJKyaZxDVvWoznj1InPp56pVUzpAZ9emSJYhLw
         V5gQ==
X-Gm-Message-State: AOJu0YyeSEWNLXnuLPPC0QXnHrs9I2HP4WRknxG/Js5e+V6U5tgG2VfL
	YJnPwijd4bx/LNG9hUq8JgvNSvEPrcnkmvQkOb6+BREAcdp4Me29ZyH6
X-Gm-Gg: AZuq6aKtbTKbPRMWBLJ7kgbCU52vAAYwQ58KlaO/sLuW6ANw6XIq2vOBnZ0S9U2L1P1
	hpIFV+09Lghzlu0wCQ6DkWLpBUeBG8Ld+wO3IO+QSeQQ0AvAWI3n46wHBdbSknSYOP7EYlpBFiB
	r8R31W2ZniU7nVXVGBMqiAAZde2E08R385yHVtNJOwFbtGwXdGDHowZ7hBLyIKtSa5H6CxXyGm9
	OAZw9eISeVRiltS876QPEoDvCV6kP06aiKUxKt6dvWDSujmd4AZi6LbwrO9xCLMasqUqok2Krky
	VkdQyl2bnKXMvezRDrG/tPE8mCvdDhbmmKfrm2aMUoQfqjwvSI3V1iAVuCc977ukUYCTriIUm0b
	ysoat2VoCX92jgeP3a24QQT3yGz91dknupX6YrcF4Yb2PVirCdkISWHRC8KhkE3/R6nAe89o8wk
	Z8vYEZArE+UkzDKe6by4QOUw==
X-Received: by 2002:a05:6000:4025:b0:431:c60:c600 with SMTP id ffacd0b85a97d-435ca193b14mr3988486f8f.35.1769371384555;
        Sun, 25 Jan 2026 12:03:04 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c269sm24418036f8f.43.2026.01.25.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 12:03:04 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v3 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Sun, 25 Jan 2026 21:02:57 +0100
Message-ID: <20260125200259.2903271-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125200259.2903271-1-dam.dejean@gmail.com>
References: <20260125200259.2903271-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-253197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14085824BE
X-Rspamd-Action: no action

The RTL8224 has a register to configure a pair swap (from ABCD order to
DCBA) providing PCB designers more flexbility when wiring the chip. The
swap parameter has to be set correctly for each of the 4 ports before
the chip can detect a link.

After a reset, this register is (unfortunately) left in a random state,
thus it has to be initialized. On most of the devices the bootloader
does it once for all and we can rely on the value set, on some other it
is not and the kernel has to do it.

The MDI pair swap can be set in the device tree using the property
enet-phy-lane-order. The property is set to 0 to keep the default order
(ABCD), or 1 to reverse the pairs (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/Kconfig        |  1 +
 drivers/net/phy/realtek/realtek_main.c | 50 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
index 6ff0385201a5..9c149b05c767 100644
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
 
@@ -1683,6 +1686,51 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_mdi_config_order(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 order = 0;
+	int ret, val;
+
+	ret = of_property_read_u32(np, "enet-phy-lane-order", &order);
+
+	/* Do nothing in case the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (order & ~1)
+		return -EINVAL;
+
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_PAIR_SWAP);
+	if (val < 0)
+		return val;
+
+	if (order)
+		val |= (1 << port_offset);
+	else
+		val &= ~(1 << port_offset);
+
+	return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				       RTL8224_VND1_MDI_PAIR_SWAP, val);
+}
+
+static int rtl8224_config_init(struct phy_device *phydev)
+{
+	return rtl8224_mdi_config_order(phydev);
+}
+
+static int rtl8224_probe(struct phy_device *phydev)
+{
+	/* Chip exposes 4 ports, join all of them in the same package */
+	return devm_phy_package_join(&phydev->mdio.dev, phydev,
+				     phydev->mdio.addr & ~3, 0);
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -2212,6 +2260,8 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.probe		= rtl8224_probe,
+		.config_init	= rtl8224_config_init,
 		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,
-- 
2.47.3


