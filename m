Return-Path: <netdev+bounces-284667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCPPMxOl+mm7QwMAu9opvQ
	(envelope-from <netdev+bounces-284667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A964D59B9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726D230451E8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA328B4FA;
	Wed,  6 May 2026 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Z/iuD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A270282F1E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033935; cv=none; b=Rc4qwBQHe4zDDytoPndJG7jpfa8eiJTf+DGFOyCan4I9Jr8Z8pTNef6rxZ9JPTUTHNo5Tqceb69vnQq06oOeDPtuAibJz8nQkdVtFdQfFlwj8mbOyxTdS8JlJMJPm2XnhF0cJfNHKJuAkBimO6rGrgzr6NN2ZYBbVgh/OhKdjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033935; c=relaxed/simple;
	bh=nYGUtFmrE7NFnwEteDS0bxvruck9Gt4KBftRooMcZlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoHl1+GDARMEHyXY4Ih+WfsV7yfwWRq7Bvi8lP1xjRwnyiJx2OmKXWqd/Rjb7/zLPLICWsS9ALg6r5AtYfquSX5ue8zUcxF3GnRT2adD1QONDch0Jc3ZfbFgs5nAqfBq4az6Rix1kC7uSZrBYbsWVOQv4zAF+jybQPvjAsyArss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Z/iuD6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1952539a12.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 19:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033933; x=1778638733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNPyJA5HM8VYEeeR34CvWajirDL/QwxofztcaoCL5/I=;
        b=Y4Z/iuD6qms7uqQsYakbyYRTE7XPYf9vpGpysUVWDHGe+Ld8WAmAkRVnkzMBCKLhis
         FECwrVZdb0f07HvnQHXnCtXOyZXLqz3BDQcbMH6b53H6wYCHEDGd6TvLlnAhNzkuWVVO
         LdrjgXxmOBdSD8lf3CHXeS7Ygq9AOSFlrvz9l73tcNbYMli9FAmPJbZIgJCzqHcuskKa
         VOgsq8FjSZw96VWKcsmsUlpjnxKY7E4rZE5ZKc1D/K/GFwfuW27HPyPP9dS93gkKOw2k
         8Sw+qgP29l0O2rvKgL7iK4nSznbj2Ph7D32eExw1nb/xQ9SZtdbZWhO9pScbfvtxySlo
         6lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033933; x=1778638733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNPyJA5HM8VYEeeR34CvWajirDL/QwxofztcaoCL5/I=;
        b=ZbeBFRtLjDoWTTZ1+n7pb/Y/3kdbNXryXfTuS9J6Zhgtl5qxgOUlpYEJnLR4Af4HLj
         pArdm8FZMjVm6s5A+LIXydoidKBdm7iL/5/lF0ym+7X4sG064J7mXa7va1Jrt3NQeJ/0
         ZNiybbhIsmmh70nxVvhxYN6EGNSg9FJIAnMYTwnI7kqvaDLo0EvM2YefPsTO3jc1MKYb
         yZKwm1lpIcXdzv2+TfmxZ0MOIP2p7nvqu9D5yzXr471k+uWfNhZWq9lLUvoibzuIEuug
         21pWFVKuboG+qMb7fStO+3Ro16vL3WGyCKi+IznE6H3+PBq4aH0DEvuZxcSb+4mYM7FP
         LuHg==
X-Gm-Message-State: AOJu0Yzd6WWb2RC3Ptv5e78wl6IhCB4/K1kogGXKc7BPrLPlQS6UF/FJ
	w6uqquYBjjTZNuE37gL08r8PFhiix+ncneZhegCsd8STjAcajn0Pg53VbnKjldn6
X-Gm-Gg: AeBDietqb1/w7Nr+BA8zYARGKJnl21ARVAVylkIaFhI0OLIjupKjDZnxu76C2DVDf/M
	61ROXdLlkH1+hBh9HCghKB0T+FU32QLWLmwf2mnHA30+qMs5UKvTSdbr31/aqdSVTtsvdg6KCl7
	UI7cMWZfxkGYczvDX/59hAJa7m+yLt/BMej6vav+X8cKmJ+MS7ziQDPAlnMMRJGMrfp/TD1NAmI
	fHo2+wEadJKLHd28GBY3u08MRLz/5otF//xvE6o6AfHshm05dIA+NEaCJOTgGeu5oQsVVLGLjph
	zg7e/oLOQUAiidK2HNNCX3u4b5rtANJ+nQDFAeh9p8CBPb4Yvp3qMCoOWB9Xew2EIImM4XAmgkx
	UMHEwE8mFwj4+Np1NnhkFdjEfUQVaahwD+4a7N1pU0kIQGQ7Yxd7ktgaSsFoDB1DzaRw3eT4b9s
	+07swZCjnn24cxGnZyxIonOeapWOUgMgW0+Ozce7rW10bWgNfmk/P0Rv8Qul/jmCdM
X-Received: by 2002:a17:902:f650:b0:2b0:917c:bc4 with SMTP id d9443c01a7336-2ba78f50041mr14256185ad.4.1778033933226;
        Tue, 05 May 2026 19:18:53 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1ac6sm6319525ad.42.2026.05.05.19.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:18:52 -0700 (PDT)
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
Subject: [PATCH 1/2] net: phy: motorcomm: use device properties for firmware tuning
Date: Wed,  6 May 2026 10:18:12 +0800
Message-Id: <20260506021813.3658669-2-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506021813.3658669-1-linchunzhi0@gmail.com>
References: <20260506021813.3658669-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81A964D59B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


