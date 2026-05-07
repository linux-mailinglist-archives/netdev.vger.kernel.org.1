Return-Path: <netdev+bounces-285142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAbCBt8O/GnsKgAAu9opvQ
	(envelope-from <netdev+bounces-285142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:02:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A51AE4E2C0F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 154EF3009CFE
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65033148C2;
	Thu,  7 May 2026 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKMIJp4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB713B58C
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126557; cv=none; b=irqNQWzyiNq1eRlgsIsUbgkg9ielYzTn+IMzeLTHGhustdIpWE07RkeZq/Rjy9Xpmh/DHi1Si0a+g09nxcESbal6mze0beSN6fdZKZqa6vbLtpg6Sk3LWcGzv7k1TRhqP1hxwMhCo9Y6nzSwu9X9oaexwuALCy4Jxy1mCKX/cMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126557; c=relaxed/simple;
	bh=8CirshOPoZFEoSaKPkqozU0UN5cm29drPAGUaxskDy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdaKGhQ8M0i1TDtGFY3Fs0vICVmtzip+EtxxWIWttU/vHsls/iGp1aSswKhKQ0F7rxDb6050o9dNeQejoJQki+hLcSPpH5wJMumx28ml5tbv/OS2GWuvdm1gt/+xFcWAcMbkyxvSnozIAK/taRbq83EhLaeY2I+UrXuJdp0XiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKMIJp4Z; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366139223e4so69391a91.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778126554; x=1778731354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybWyM/GBCblqVoOsGBZoPNIvLTsiHHbsxa3USXRuJU0=;
        b=EKMIJp4ZijPlK/QmXaOp+gg7QobbRTla+WqYwLjNpI8zc0gsYAi0gtYm+I7VKMilgt
         U8KKpjiug5iXBGo5rTdubzy8JW637Mvlk9B8XZBkCwG7gMBXPvVg9eQDCKNroh2/R3Sq
         inVMIsxitVUV7IePTlibdl84dSZRBdvhF4I1QO1H2d3iCur63UOl7cWO1dniEEfv11oV
         WBjZMao7cVxkPNz95HCFLd9QAlNLVgtUV4Ht3C3SZLW60uhyk+51dyjcuGPQXka4NOgM
         o4BLhHEJpD5gA86j4TtFptFKgTj3esAEYOmamlZoPKb425LO85ln7des9zmsIsi7R9T/
         xTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778126554; x=1778731354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybWyM/GBCblqVoOsGBZoPNIvLTsiHHbsxa3USXRuJU0=;
        b=a0k4RX8xNTzHZHmougmoFyFwcz6/BYHjkbU0+Nj3HXlJB1azIuA+VXY41sGZ1DvtyL
         sz1VEm3Dnw7q4B91iol4obiztetVoImZzfwh0Rr5CxMOiV289fFJlb42d0sFYy956N3G
         En/bzY767qNs6GDPX+M7UDQmf6r7nZl6YgUoO2r42BhZar0r3arrkxAQmyINgDSw1o+U
         f0MIhz1vwAjYGxUGY09QjoylCO5gsE7vmj6FPVVgs3B4oeeJj6L3J55mIOYckNm/cRi9
         GfE+GwvkGDjV9n9jFzvvxZO6D9e7aRHykp3B385GonCGp5Ob1nq8K/2kXJ7J4OedBy5B
         5gxg==
X-Gm-Message-State: AOJu0Yz9Kr+lv0rnLU0QacNhQFxOQQHAOXcyN7wR7CHYcqRLN7v0gvqo
	t6GG/ECz6u6X4e8yYmvcQ09u6Al8+zMBtJK9VhRaerHqh6/Ym9SMevTHJTJj9s2E
X-Gm-Gg: AeBDieuphLYjXxmcyXaxpT+IILekR2a/ZuVrAMxl3wOWRufRv9Yv7YHm9Zm1sYQpDfn
	BHgrtch0zNzBwYGW53fMn6wQiYhLESEtkfIiCHKrg+cPs9J/pfMKgfYv8k2a/RzFb+SU1FHk8In
	Xhikud1Y8MoH6F5XlxfluSVqtHRWIBY1vYBQU3ZWGH0tJI/iQoEHakRDoj6bPROVlMtoekiCHGo
	PlS1RhdzoPKvQkSZ8V0YJwMmx/AKYdf+MYknfuu7MpwZ7hvDGZ1+INlOKpsVYXDeq9rTln6hP1k
	Lw1G8xOmTapMeCkBqESeDwCIcXYFQiVZ/Vjj/IQ/g5kfiLNa/RnUNR52xxBSx7wB7FoP94Kd+Dx
	iMxdZGqv+vh2AY0K/GrubJmR3oIOVeYL6H53sS4kxiarniniTu5vhTIf8t4TpKPUCHO8H+se7JI
	c31BKrikJR8DIpzj4vsFKp0fZRJZE7y6416C51nfcMzGiahsGf7xxaEw==
X-Received: by 2002:a17:90b:1b4b:b0:35f:c1e1:a263 with SMTP id 98e67ed59e1d1-365ac27a3bbmr5975819a91.19.1778126554003;
        Wed, 06 May 2026 21:02:34 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365d8e3dad8sm2536182a91.1.2026.05.06.21.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 21:02:33 -0700 (PDT)
From: "chunzhi.lin" <linchunzhi0@gmail.com>
To: netdev@vger.kernel.org
Cc: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	"chunzhi.lin" <linchunzhi0@gmail.com>
Subject: [PATCH v2 1/2] net: phy: motorcomm: use device properties for firmware tuning
Date: Thu,  7 May 2026 12:02:20 +0800
Message-Id: <20260507040221.3679454-2-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507040221.3679454-1-linchunzhi0@gmail.com>
References: <20260507040221.3679454-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A51AE4E2C0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285142-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linchunzhi0@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


