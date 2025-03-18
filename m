Return-Path: <netdev+bounces-175737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B96A67531
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D678819A656E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87320CCFF;
	Tue, 18 Mar 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkqIFrRA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866D20CCED;
	Tue, 18 Mar 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304754; cv=none; b=NhbQdg866CUlQbYI8epYejBIfhHNlL84fbxNJsUq74vmLzRctNgxMhXGKOCuSmGDMCFVrQlkOrDXzWIv8YUhlH4YZT4xBhn0VoUL3SZw1slRhrHd/Fzh4TKFa2K17QlzGQqZpMtUho0bk+yRumT/uLSE5P6uyvnauPzZNfftn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304754; c=relaxed/simple;
	bh=atZyZBDaKu8zgIvWhjv6QkvBeza+jB3VmH5MdFx9o3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/ZDrzEm0u6mOF0kB+7XkDzd9z5GuxSRhgMLvc8zLHnVMr6oLq34dl+RRgfGkthISP5F9E/9msIIST+XRiQXcQpezz2gPuPkFaghZncnsfsJDW3P2kdXHRAXs3LVkW2RUmp/j16mRidk4YikM9eVFeaqyyVK0RHoEX2w3FLsgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkqIFrRA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so6133342a91.2;
        Tue, 18 Mar 2025 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742304752; x=1742909552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiGEccXl9Y/5xx8hXRp6JuAdI46/d2pVYeRgnwqo7io=;
        b=KkqIFrRAcCobzCT24oifF0SarhfeDW3ySTjfnDF+zjEdr8Di9ETB6AaVGvutWTJDh9
         cUclInMZ505XXw7oeffHKfb0A3ebRRXtLB2KL3UELVd+FRi3Lr2jdqwlmMZmvn73SU1c
         WRi/cSdZ9ilZwzRth186l1jK8fMUew5wGk7cXL6i5KsL/ZN5dmbWJVu8wSB5Sg4Bdl0Z
         +6wdV94ONXKe6AQtbj+2wouBb8f1r+x5F6LOp0tZ5nJDkxfxCIji5hHob1Xw6BSrX0Is
         gBxLF4HYpK0Qr3ECOXdOH6eC4dtAiQMJGyNgW3XqS5JXnM0hNUdIBgBP4GAHHent9B4y
         DnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304752; x=1742909552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiGEccXl9Y/5xx8hXRp6JuAdI46/d2pVYeRgnwqo7io=;
        b=cRpHz19TL6cRebO9NB0ISbwtGRmwgJMEAZSYUYYIOTpZ2ipUOITuBT//22omUYdpuV
         R3+HjBGm0OvSBdxzqRdfLuPixfIOK62BvnUuxE+ksacTqBXDw8j1pBtv7t3Q/tpeMj6o
         crMZA+SD5smgCUbzGbB2RkzaloBU8g71lD8ogV5fT5+jKNALatxr42bfGHv6CGK+vZE9
         gSFCnmk1iNwa0snH35ZtBWpyMwHXAoSGlZuK1nd2rR7B7ggh1kkdHpbDvVybdHP9LCyn
         xhZGzsRe0sOPqoN5NgO7Hm4dDpB0K0pV/EcIvGw0Ax8nC2qxt57kr+RUp9nK197LryrG
         9tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfqk6GzNk+YYGHPRlaP+NZMEIoD6Q7HRLKkXy3sIyPADgoWooqTaqhjC6WHzJYCtRxJQjKDKADLnHYagg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JRu7s8xbMW+Rtvrx56ZFsnVg0PXAk2DGUcvSvsipBnCKW9gS
	Ek9N84hCEARe1ARtCUTzHmWFWudHBKI1sRrbCmwyVHTUJn8GJBjSZPrr1pI=
X-Gm-Gg: ASbGncu5eMw6Afw+Pdy0HXPA/ctvS+BOgxkVsoq8oerTImqJYRSKmaxuVBLWxXw2dbu
	AiHuHUrGD1uX1yV+nNRKy9ukYhcndsN9jOgWmm+fJ1HCjuNzYQxyW4223PEgc/yHHVAhns2tHK1
	PWZn1+6d04peGpBk71G3jfihIrlyMeQtLJK5QlQQwfO7efJUtwHwV0qNcd7uBkVpJvw3KJtcu8r
	mUhYB6Doydt1kXcJve19wEO+wJ6AYgqfNUurz4XRm1LnLqCMmB4SD8AWh8vNOdeD2PQbrM0VILq
	m2m10t21BTSrz+nH2XMnV2vIjemRQNGnrF9IUCDtI7Esmm7DbnmTLyWoVWt7PMh8+LfHweMLE0a
	K8y1+nDgKcPhJbwe7sTK+M80nmyBdh8xUvRaQVg==
X-Google-Smtp-Source: AGHT+IGXhfnisLMrxeiE9MJU0p7Lq3D8DFd7wT1rb1S7PwypIfPgi9Pn5QlpBKKPkeupVyQoxCjvoA==
X-Received: by 2002:a05:6a20:7f9e:b0:1f5:769a:a4c2 with SMTP id adf61e73a8af0-1f5c127ad1amr21646425637.22.1742304751930;
        Tue, 18 Mar 2025 06:32:31 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea94891sm8936161a12.67.2025.03.18.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:32:31 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
X-Google-Original-From: "Lucien.Jheng" <lucienX123@gmail.com>
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
	"Lucien.Jheng" <lucienX123@gmail.com>
Subject: [PATCH v5 net-next PATCH 1/1] net: phy: air_en8811h: Add clk provider for CKO pin
Date: Tue, 18 Mar 2025 21:31:05 +0800
Message-Id: <20250318133105.28801-2-lucienX123@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318133105.28801-1-lucienX123@gmail.com>
References: <20250318133105.28801-1-lucienX123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
CKO clock operates continuously from power-up through md32 loading.
Implement clk provider driver so we can disable the clock output in case
it isn't needed, which also helps to reduce EMF noise

Signed-off-by: Lucien.Jheng <lucienX123@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e9fd24cb7270..47ace7fac1d3 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/wordpart.h>
 #include <linux/unaligned.h>
+#include <linux/clk-provider.h>
 
 #define EN8811H_PHY_ID		0x03a2a411
 
@@ -112,6 +113,11 @@
 #define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
 #define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
 
+#define EN8811H_CLK_CGM     0xcf958
+#define EN8811H_CLK_CGM_CKO     BIT(26)
+#define EN8811H_HWTRAP1     0xcf914
+#define EN8811H_HWTRAP1_CKO     BIT(12)
+
 #define EN8811H_GPIO_OUTPUT		0xcf8b8
 #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
 
@@ -142,10 +148,15 @@ struct led {
 	unsigned long state;
 };
 
+#define clk_hw_to_en8811h_priv(_hw)			\
+	container_of(_hw, struct en8811h_priv, hw)
+
 struct en8811h_priv {
 	u32		firmware_version;
 	bool		mcu_needs_restart;
 	struct led	led[EN8811H_LED_COUNT];
+	struct clk_hw        hw;
+	struct phy_device *phydev;
 };
 
 enum {
@@ -806,6 +817,84 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	return 0;
 };
 
+static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw, unsigned long parent)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_HWTRAP1, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & EN8811H_HWTRAP1_CKO) ? 50000000 : 25000000;
+}
+
+static int en8811h_clk_enable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, EN8811H_CLK_CGM_CKO);
+}
+
+static void en8811h_clk_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, 0);
+}
+
+static int en8811h_clk_is_enabled(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	int ret = 0;
+	u32 pbus_value;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_CLK_CGM, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & EN8811H_CLK_CGM_CKO);
+}
+
+static const struct clk_ops en8811h_clk_ops = {
+	.recalc_rate = en8811h_clk_recalc_rate,
+	.enable = en8811h_clk_enable,
+	.disable = en8811h_clk_disable,
+	.is_enabled	= en8811h_clk_is_enabled,
+};
+
+static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
+{
+	struct clk_init_data init;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name =  devm_kasprintf(dev, GFP_KERNEL, "%s-cko",
+				    fwnode_get_name(dev_fwnode(dev)));
+	if (!init.name)
+		return -ENOMEM;
+
+	init.ops = &en8811h_clk_ops;
+	init.flags = 0;
+	init.num_parents = 0;
+	hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static int en8811h_probe(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv;
@@ -838,6 +927,12 @@ static int en8811h_probe(struct phy_device *phydev)
 		return ret;
 	}
 
+	priv->phydev = phydev;
+	/* Co-Clock Output */
+	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
+	if (ret)
+		return ret;
+
 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
 				      EN8811H_GPIO_OUTPUT_345,
-- 
2.34.1


