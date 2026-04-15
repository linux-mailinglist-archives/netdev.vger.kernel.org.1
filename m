Return-Path: <netdev+bounces-278773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +sfvLt6P32nMVwAAu9opvQ
	(envelope-from <netdev+bounces-278773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:17:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05062404B72
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C946D30078FC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF323B28D;
	Wed, 15 Apr 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4D2y3zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBA396582
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258902; cv=none; b=CdmfjDHsEOGGIyThFckFzq7t7yJrhCWcruKNG302CwICByhg0Vizeg2exqzbU95yZvE+3+vXLKJBhHvnTH0QPkYekj4mbqCmuE/UXWJIsiyJum6DZzqCWdnVmcXjQB92rIMpETuD1Rdk1EcmC6PNfyTQxvUP4w/6Fmm1ev+FO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258902; c=relaxed/simple;
	bh=nYGUtFmrE7NFnwEteDS0bxvruck9Gt4KBftRooMcZlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyXm3NDF0lnitgwc7SqlNWd5UXd2jKobl6b06N/aAIEt0vqJrO8AJlecgdsxGGWpG30QrtfmAoVBmjiaG7Mql0VKuJ3Xzk7GZOebElwtWqL+LyryV5rnzadmMxt1p+ywr3N8Gdw2VqAQYPz+SDDhELvYk01jMu7tPMD/r0RVEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4D2y3zt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so3901508a91.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776258900; x=1776863700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNPyJA5HM8VYEeeR34CvWajirDL/QwxofztcaoCL5/I=;
        b=a4D2y3zt04LM0iX9VSW3xxwqKv05h3PNmQiAgSWHgdfDDwXw4qQnkxFpgLzPBPX24f
         W5UE9ZQFjcNV37KsUEzYRyXXs25Rx8lLsKgaVjViJSwFv0SXM2JxW8zd+23VLF841MeQ
         QnRzBvYL/aexaz0/AOAWd8srz4szpfnGYw8vZRQPIsIuCTkEJKuFEUCPq3qUUMuzb4TU
         DQkGIojOtV3Bwy8vn9lFq/aw7h3ovFGzRvysuiAtj8kemJBudKb6onsxwqNp2Nlfar9M
         8BkSbaDSseeWhWOfefWhWoMgm57qCkLBk0s66SyXYJyw/Ozftr/xkp/EsFhA2GFiTZbe
         qmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258900; x=1776863700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNPyJA5HM8VYEeeR34CvWajirDL/QwxofztcaoCL5/I=;
        b=iMrzSLfeKIX0qUkqdcXWiRUbfIu4sfTFT0er2ijfDCgNNLE6GTUzHkAv5Ju4gy4FBs
         Lc/QBeHUtqYsvn4ffZPu/C+p0+0yS5AP/sX/JsS7NvHPaKeyA0n3HeTX13jBKzwALOJ+
         6cPtl7AkkRYdjg+0KMAjRjOng1H4/r+gG/SAX5Kv+Ow+joLV2XrnXVTrdIp6dhAXdvId
         fiiPtc3i9d+NtEY9gm8VS6BeE+m07lQKG0muRGIR//VIFxZHyE1c6LOAkT5BbEIc3TrP
         IdjRdRynU/L9BCDu3zScAoCBlFYQUy7eyTvliFVgQJs5kiItsZMMsPh/JgTcvVedkQkl
         8L/g==
X-Forwarded-Encrypted: i=1; AFNElJ/JwpqQP9MNkTcQbw/fa6R5LY8WASxHc6aKVQjo8ixKCZ0EUH8X2LWu5rArf0hfAf4S2bm6A2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqqUMJkMPOZlwYLSz04xXxpx2rRQlq0PFde7GMypc5S+uwTlN
	3pVfswGrpqj07pvI44DFiKwTOFBjZ+oM6L+mk0bbVnuQZvhlU9iRMxWa
X-Gm-Gg: AeBDievmAmSKwOrJAWwiiruwxBXC6Etd3BqD6mXzWxBMk/PvTotpa5OEFYsSK2mLkVK
	veGAmlBs2ifcjMyNfIerBVIaXpkwqLLh1yql8WoTw9CfRj7pQrI144lS9zzRd7b125QuJhscoaQ
	dCrfCTWt/3zioOAG5f/dpLPZKcG1P8hzW7/YclbAhgqQotOLIshaTFajrSehm+tYpZWlI7/MJH0
	4I24YywvMCKSAm2AFqEGDNdyqI7D8RhKd51XYOIg6EJnxEuLBxQAGEW2Ip4mBGHDTFB5vnj9waJ
	EqhNnA/1N7mbJ0TJ50lV/Insv8E/Ff2xS9VgNfGpihWgZdsVtPHkW3nLp6v7v+Q2Nl4yVtToWMR
	Gznnes0EzVlKsXRHS0ANyXJch0uEGUB873NQKKU6cqZyHY7nbkAVgRw8Unagat4cVRM5SZQTPaG
	38dbgK9GX6TxLb96nES4HZ/qi27Wm/zRMoW8WBQ32bQbc=
X-Received: by 2002:a17:90b:3d01:b0:35f:b4c1:91f6 with SMTP id 98e67ed59e1d1-35fb4c19544mr12015375a91.10.1776258899959;
        Wed, 15 Apr 2026 06:14:59 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957eeaabesm1774118a12.10.2026.04.15.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:14:59 -0700 (PDT)
From: "chunzhi.lin" <linchunzhi0@gmail.com>
To: Frank.Sae@motor-comm.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chunzhi.lin@sophgo.com,
	"chunzhi.lin" <linchunzhi0@gmail.com>
Subject: [PATCH net] net: phy: motorcomm: use device properties for firmware tuning
Date: Wed, 15 Apr 2026 21:14:52 +0800
Message-Id: <20260415131452.3492671-1-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,sophgo.com];
	TAGGED_FROM(0.00)[bounces-278773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linchunzhi0@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05062404B72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Motorcomm PHY driver reads optional firmware properties via
of_property_read_*() from phydev->mdio.dev.of_node. This works for
Device Tree based systems, but causes ACPI platforms to ignore the same
properties when they are supplied through _DSD.

As a result, ACPI-described Motorcomm PHY devices fall back to default
settings instead of applying firmware-provided tuning such as
rx/tx internal delay, drive strength, clock output frequency, and
optional boolean controls like auto-sleep-disabled,
keep-pll-enabled, and tx clock inversion.

Switch these lookups to device_property_read_*() so the driver uses the
generic firmware node interface and can consume the same property names
from either Device Tree or ACPI.

This keeps the existing DT behavior unchanged while allowing ACPI
platforms to honor PHY configuration from firmware.

We have completed testing on Sophgo RISC-V architecture server SD3-10.
This server has a 64-core Thead C920 CPU whose DWMAC is connected to
Motorcomm's PHY YT8531. This server supports UEFI boot and it would like
to use the ACPI table.

Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>
---
 drivers/net/phy/motorcomm.c | 41 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d62f7b36212..708491bc198a 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
-#include <linux/of.h>
+#include <linux/property.h>
 
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
@@ -843,12 +843,12 @@ static u32 ytphy_get_delay_reg_value(struct phy_device *phydev,
 				     u16 *rxc_dly_en,
 				     u32 dflt)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	int tb_size_half = tb_size / 2;
 	u32 val;
 	int i;
 
-	if (of_property_read_u32(node, prop_name, &val))
+	if (device_property_read_u32(dev, prop_name, &val))
 		goto err_dts_val;
 
 	/* when rxc_dly_en is NULL, it is get the delay for tx, only half of
@@ -996,12 +996,12 @@ static int yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
 
 static int yt8531_set_ds(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	u32 ds_field_low, ds_field_hi, val;
 	int ret, ds;
 
 	/* set rgmii rx clk driver strength */
-	if (!of_property_read_u32(node, "motorcomm,rx-clk-drv-microamp", &val)) {
+	if (!device_property_read_u32(dev, "motorcomm,rx-clk-drv-microamp", &val)) {
 		ds = yt8531_get_ds_map(phydev, val);
 		if (ds < 0)
 			return dev_err_probe(&phydev->mdio.dev, ds,
@@ -1018,7 +1018,7 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		return ret;
 
 	/* set rgmii rx data driver strength */
-	if (!of_property_read_u32(node, "motorcomm,rx-data-drv-microamp", &val)) {
+	if (!device_property_read_u32(dev, "motorcomm,rx-data-drv-microamp", &val)) {
 		ds = yt8531_get_ds_map(phydev, val);
 		if (ds < 0)
 			return dev_err_probe(&phydev->mdio.dev, ds,
@@ -1051,7 +1051,6 @@ static int yt8531_set_ds(struct phy_device *phydev)
  */
 static int yt8521_probe(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
 	struct device *dev = &phydev->mdio.dev;
 	struct yt8521_priv *priv;
 	int chip_config;
@@ -1101,7 +1100,7 @@ static int yt8521_probe(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (of_property_read_u32(node, "motorcomm,clk-out-frequency-hz", &freq))
+	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 
 	if (phydev->drv->phy_id == PHY_ID_YT8521) {
@@ -1169,11 +1168,11 @@ static int yt8521_probe(struct phy_device *phydev)
 
 static int yt8531_probe(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	u16 mask, val;
 	u32 freq;
 
-	if (of_property_read_u32(node, "motorcomm,clk-out-frequency-hz", &freq))
+	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 
 	switch (freq) {
@@ -1665,7 +1664,7 @@ static int yt8521_resume(struct phy_device *phydev)
  */
 static int yt8521_config_init(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	int old_page;
 	int ret = 0;
 
@@ -1680,7 +1679,7 @@ static int yt8521_config_init(struct phy_device *phydev)
 			goto err_restore_page;
 	}
 
-	if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
+	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
 		/* disable auto sleep */
 		ret = ytphy_modify_ext(phydev, YT8521_EXTREG_SLEEP_CONTROL1_REG,
 				       YT8521_ESC1R_SLEEP_SW, 0);
@@ -1688,7 +1687,7 @@ static int yt8521_config_init(struct phy_device *phydev)
 			goto err_restore_page;
 	}
 
-	if (of_property_read_bool(node, "motorcomm,keep-pll-enabled")) {
+	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled")) {
 		/* enable RXC clock when no wire plug */
 		ret = ytphy_modify_ext(phydev, YT8521_CLOCK_GATING_REG,
 				       YT8521_CGR_RX_CLK_EN, 0);
@@ -1801,14 +1800,14 @@ static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
 
 static int yt8531_config_init(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	int ret;
 
 	ret = ytphy_rgmii_clk_delay_config_with_lock(phydev);
 	if (ret < 0)
 		return ret;
 
-	if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
+	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
 		/* disable auto sleep */
 		ret = ytphy_modify_ext_with_lock(phydev,
 						 YT8521_EXTREG_SLEEP_CONTROL1_REG,
@@ -1817,7 +1816,7 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (of_property_read_bool(node, "motorcomm,keep-pll-enabled")) {
+	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled")) {
 		/* enable RXC clock when no wire plug */
 		ret = ytphy_modify_ext_with_lock(phydev,
 						 YT8521_CLOCK_GATING_REG,
@@ -1844,7 +1843,7 @@ static int yt8531_config_init(struct phy_device *phydev)
  */
 static void yt8531_link_change_notify(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	bool tx_clk_1000_inverted = false;
 	bool tx_clk_100_inverted = false;
 	bool tx_clk_10_inverted = false;
@@ -1852,17 +1851,17 @@ static void yt8531_link_change_notify(struct phy_device *phydev)
 	u16 val = 0;
 	int ret;
 
-	if (of_property_read_bool(node, "motorcomm,tx-clk-adj-enabled"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-adj-enabled"))
 		tx_clk_adj_enabled = true;
 
 	if (!tx_clk_adj_enabled)
 		return;
 
-	if (of_property_read_bool(node, "motorcomm,tx-clk-10-inverted"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-10-inverted"))
 		tx_clk_10_inverted = true;
-	if (of_property_read_bool(node, "motorcomm,tx-clk-100-inverted"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-100-inverted"))
 		tx_clk_100_inverted = true;
-	if (of_property_read_bool(node, "motorcomm,tx-clk-1000-inverted"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-1000-inverted"))
 		tx_clk_1000_inverted = true;
 
 	if (phydev->speed < 0)
-- 
2.34.1


