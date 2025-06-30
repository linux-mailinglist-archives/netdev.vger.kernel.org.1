Return-Path: <netdev+bounces-202538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DEAAEE2EE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE2C3BDB33
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828AE28D837;
	Mon, 30 Jun 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQlrVEFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D828CF44;
	Mon, 30 Jun 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298156; cv=none; b=JlS97Haji5lzANPqCTOBYD/tTKJWRrRbw9Xd8u3Uu8MZZdepgRRAK5JGowWtzQjyZIwiobjawg2MeHrriWqERNeRHyINlR+Y8RkOudrt4/6o54rzmy6ZIrguav+SK85y/j2OzjZKZ8ir0xW62iJYOmTcm9s4iVLTsUwiGovqHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298156; c=relaxed/simple;
	bh=knYjtLOHXdJT6nJWX+qsugu1uDsrhkZbrnkbl4efHyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7aikkH0BJsDLbS9ZdPACVPQdBG96mLO7efnKu/ygLcdwGGE6bB6j2l24MBf1NukiLSSJY5K+LWRn2qqxl6iEqF5A4eCbFPITKpyQQtxgXKn6uBeTq1EIcCKEnr0l1TcEZnd/RaCMbGczgqI7GDFEf7svmhkIprfpq6nx0Pt/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQlrVEFu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso4048712b3a.2;
        Mon, 30 Jun 2025 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751298154; x=1751902954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILQiAgdOcE9A+uJSEd47pqfeN69RUFK36yivEx4Yj5E=;
        b=dQlrVEFuGv0Zs5UlEk5dtvF8YFofflj2HOhNlwZNNxsLMOb7z46w9EqGoXZvdogLTP
         3CtVlNtzVTJUohjqP94tEz2dYmzMAtDLP51wM7Na+02HoxP2i9Gmxv89eFAgBSYmjmEv
         e/ohheuFq9gvtboIG9WEop7UUh4VYRwtQQCIXfFHt1myKGswA4ODIc4qNebVZpdAakeX
         KFah286uQjdwvj41T0Me5iBETiotTTvHCKJNLEgoWrpDBG3BSd4BRRf3i1UBXuFRtine
         rno16YSTlyLtI6mylB8dzrMrMcICSGvrh6GKPBEwddzSgAHmOr3ZhpsfJi41znSVEeRe
         BSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751298154; x=1751902954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILQiAgdOcE9A+uJSEd47pqfeN69RUFK36yivEx4Yj5E=;
        b=kUbOiNAWcVI+K6KK9vOIovJWjGO9yRb4pFiCUfgyjd11BO3e3IpFYI9QvhvMP07SVV
         G7jr7xZQGLctHso3cK76RvwWbHghOqxd40LW98LkAYeccxv1YslwbzcCdNsAlkQSXTJX
         7ozUx0bYUcqEVCKUsX6aU6oq65z0d5IVksMmb+xTe/a1HKj7LKFR7nFxI2IITw+aKyNH
         W0TEC23b8Gyz9JGN2C4ZGYkraLdS65lS5XU3G9tEZjsvZ+1GKxH7RCwyKDJ7TIIFsD6Z
         5hkydUTi0YwJMjG98Mt4C0E87MZPyMfiNRIIUSNRaVeIYdNgjaPbpMfejow4mOMeqecK
         tn0w==
X-Forwarded-Encrypted: i=1; AJvYcCXoXfiIRTzaIyAQhW62H7zKTWs+DWAQDmpdeE9rgApcborzUPRl2YF/gCiDKtuvSq6dv6dW5kjwN9hCtNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03xgZGlg7bslbxG/EI5YJBupN/7E8A1H1t1ApMCguMTsspw5d
	IgATE1sRbTZxKZxmlmGSeNiECT/1JSeBNwn4DHzzTcIuikn2cV5hCi/R34pvPg==
X-Gm-Gg: ASbGncvkcXwGjah0VmwlsIw4b0HU7FgrgaA69gHtxpoyXmBOahghPPt4BZjWf4hN7mB
	8sEZSQuqxCDv6wEcNvpcbPRFqjZAAkbqX1ABk1NZPQvS4/TrOmffVod/xPeAqpVgCBFerOJl9yZ
	Y+JRw2lQi2CUhUTVup2oKE4ONaaAGA0yXVM1To3L6vmpJEYZBhri0Prc2ezTOlb4y/2U2wt5zi5
	QW9OcMAvu45yZvMJyvBY2Nc9CD4uxz2TzspjeN6xGom0SmL2pwTl7SpV01dONAjnTHXI201I1Sr
	W+j3QbhqMyMX7rwmJZda/x2jGiJbU60XmdoO4lidFwoYsRsOUr9WU5nnAeVYbv8hxhLgR843fAd
	nDRFRBd1CrTr8Mban0b0FoMhup0R1pYfzI4nUV5K31gdQmLh7fP7LLrZi6w==
X-Google-Smtp-Source: AGHT+IFEiM2GyTkOf1eXiAL7ca57A+c9fKOJm0ySemduFZyd0cd+nGQVNgdc5qW9JvT0MSOsAatwJQ==
X-Received: by 2002:a05:6a21:1343:b0:21f:994e:7355 with SMTP id adf61e73a8af0-220a16ca7e3mr24573088637.36.1751298153915;
        Mon, 30 Jun 2025 08:42:33 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3214d9esm8305046a12.71.2025.06.30.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:42:33 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: linux-clk@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com,
	wenshin.chung@airoha.com,
	lucien.jheng@airoha.com,
	albert-al.lee@airoha.com,
	"Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v2 net-next PATCH 1/1] net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
Date: Mon, 30 Jun 2025 23:41:47 +0800
Message-Id: <20250630154147.80388-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user reinitializes the network interface, the PHY will reinitialize,
and the CKO settings will revert to their initial configuration(be enabled).
To prevent CKO from being re-enabled,
en8811h_clk_restore_context and en8811h_resume were added
to ensure the CKO settings remain correct.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
Change in PATCH v2:
air_en8811h.c:
 * Fix: build errors about using __ functions.
 * Add clk_save_context to handle CKO state.
 * Add cko_is_enabled to track CKO state.

 drivers/net/phy/air_en8811h.c | 45 +++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 57fbd8df9438..badd65f0ccee 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2023 Airoha Technology Corp.
  */

+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/phy.h>
 #include <linux/firmware.h>
@@ -157,6 +158,7 @@ struct en8811h_priv {
 	struct led		led[EN8811H_LED_COUNT];
 	struct clk_hw		hw;
 	struct phy_device	*phydev;
+	unsigned int		cko_is_enabled;
 };

 enum {
@@ -865,11 +867,30 @@ static int en8811h_clk_is_enabled(struct clk_hw *hw)
 	return (pbus_value & EN8811H_CLK_CGM_CKO);
 }

+static int en8811h_clk_save_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	priv->cko_is_enabled = en8811h_clk_is_enabled(hw);
+
+	return 0;
+}
+
+static void en8811h_clk_restore_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	if (!priv->cko_is_enabled)
+		en8811h_clk_disable(hw);
+}
+
 static const struct clk_ops en8811h_clk_ops = {
-	.recalc_rate	= en8811h_clk_recalc_rate,
-	.enable		= en8811h_clk_enable,
-	.disable	= en8811h_clk_disable,
-	.is_enabled	= en8811h_clk_is_enabled,
+	.recalc_rate		= en8811h_clk_recalc_rate,
+	.enable			= en8811h_clk_enable,
+	.disable		= en8811h_clk_disable,
+	.is_enabled		= en8811h_clk_is_enabled,
+	.save_context		= en8811h_clk_save_context,
+	.restore_context	= en8811h_clk_restore_context,
 };

 static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
@@ -1149,6 +1170,20 @@ static irqreturn_t en8811h_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }

+static int en8811h_resume(struct phy_device *phydev)
+{
+	clk_restore_context();
+
+	return genphy_resume(phydev);
+}
+
+static int en8811h_suspend(struct phy_device *phydev)
+{
+	clk_save_context();
+
+	return genphy_suspend(phydev);
+}
+
 static struct phy_driver en8811h_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
@@ -1159,6 +1194,8 @@ static struct phy_driver en8811h_driver[] = {
 	.get_rate_matching	= en8811h_get_rate_matching,
 	.config_aneg		= en8811h_config_aneg,
 	.read_status		= en8811h_read_status,
+	.resume			= en8811h_resume,
+	.suspend		= en8811h_suspend,
 	.config_intr		= en8811h_clear_intr,
 	.handle_interrupt	= en8811h_handle_interrupt,
 	.led_hw_is_supported	= en8811h_led_hw_is_supported,
--
2.34.1


