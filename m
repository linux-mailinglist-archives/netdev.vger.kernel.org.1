Return-Path: <netdev+bounces-175334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD565A653A2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865553A527F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFFF2405E9;
	Mon, 17 Mar 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9VDRgMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840323F401;
	Mon, 17 Mar 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221938; cv=none; b=IjzItn/7KHvsTc+UY6U37VFg7xWubOLe6mwgcLGgslxQgS+gVZr7U5PKttFTC5/E0/0wvbZqEqTvR6y5gRhw6XCq8bg3hydfKykRel9zAKfKwIME/GD2xDfamXjkBbjGV3uUrZIFkKSXcWUZSHPi3eI2UCoud8N6tYafdUxloOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221938; c=relaxed/simple;
	bh=herKpa2IkJjNHU1PgoJjzm1RKCPFlsOJSpst31PrWMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d3HF7ObhrryDm/6QXVG2ilBQcoBbQAf0B3BUJIv2cd7043az6lMDxHc/1FWDdyydF+jB4fKq9Qz+an4AJbZBmUVhUsXYlCSwgLQXA0zDKxnuTv5KDS9HQTS//651VZsJsbFdoWgwBz2jwRTqpoiD+YZEUDFoNcnuxGh545GHBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9VDRgMa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2243803b776so38168325ad.0;
        Mon, 17 Mar 2025 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221935; x=1742826735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QShWfKeXB5flxGPwyFee/7W6zwcpUiEOR04VZFOgFbc=;
        b=k9VDRgMa7jVYYwmehSIsKSdlIcheSv85eZIBWwf2C0f13T2+mGIvIwP/RXTegddTj3
         KClYP/ZBdLUalEFyqDPs1qvcCgwTMwf9NVK9RhqrlCCVnkdXyNkptzOuXkGJZXlfG85y
         SvpXY98s4D/53bMH9zsYTakPYbZYl1ZeSAsr+4MF99lqw7biQnec7kWmkAV7vhJp2/qu
         /5/VDspffysU1oJQnSENedMp1Our1l0dUmKTGfn66GOdYQASKuanMaKzzYfac64oQR9e
         oioPoDyp74kixRhzdGYSalvO+dHbC5BuirGFJo22rF+4mMD7nTperqYhF2g9Y0mKIL/5
         b0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221935; x=1742826735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QShWfKeXB5flxGPwyFee/7W6zwcpUiEOR04VZFOgFbc=;
        b=rJabR4/p8Zn9acHxIR/Gu7+41bcUx1yW9UWqjeT05xQH+G0OUNAtcR8hTUJcO4bnH1
         mWTrpKm4+c+1b7dlgXwixMfG6kCsVqeXKb2blxKBJ3hstZ4Ng2sETauDRHByvKIKYqJz
         U46sbIM8gMmUJZy5P0B7hlvTfvPhP3rE5jez0ArUiUxBcpcw3pm6HsuJH/G42AwdCBWe
         0ILYArT0bI3WnC9qj/HmamR5vrwClA9CwQW/vsPP3uWwXWn6PUONi/WBYxhV3WEze0D3
         k3xJwzciVq/dWZ0hVPImHDbhtL7ztjf7mUwPrSIkDdn551rfcFHx7RO/HvK9GKdaw3gS
         Zt+A==
X-Forwarded-Encrypted: i=1; AJvYcCVPIfrWO+RpGqG9lz/XRHLJJBzDUXZ9z4+Ke7Wp03zzlMX9Th/Atk+/XhxZ1uQyBXor5it+ibAQ6RwwxfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNuDSLz93y9gjVH2VR7rbtp0Dss0cTU4zm/pVZxNy41oTUvmw
	NmXHDq8dG0JyPS/4hewZ8druIi4higf4jLN0BaANeGYALECOkzOq+7BR/Cg=
X-Gm-Gg: ASbGnct72R6GFuW5hWFI9K4EES9llgo9CVtXZdEDlhjfuNK39XSNU4B6vtQ1bEJbCtf
	v39clvcO3ERG5lCgE6JBNr+EU1Hi9Q5zWH2GYYsQLuDNauXm/7VKOw+mSC1FyzG4Pe7/rFP+xa2
	DqRO10hdmujKw00WGOb3ZmLCJvn+WfflrUHsdk2NPMZb5wsxMtdxSMKanAup4a2WPVepp9nOVPn
	6juR477U/OkWIWOgcw8pPkrF0DJXjHMAQfmqTqi7Ln3B7LSnrLnttnt8aCxSFq0wBBLT2GFosWS
	aupPcf32G5N5wx9LG9LDClAUvnztR9PE82GEAukr4U2MKr3M6ogRhdRSYn73nDCF4uERz/gHQU+
	Ay/622BMr49/gLp0EjgQIsh7XXrZ+KF96LIVxmg==
X-Google-Smtp-Source: AGHT+IEoybxuOWwvkhUpeweyH8+pOfe5e1seKQhwXRRFowH6w5Dm71hgoI1K+QKk4dvzKVgCXgXrLw==
X-Received: by 2002:a17:902:c952:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-225e0ae70d3mr148361275ad.33.1742221935514;
        Mon, 17 Mar 2025 07:32:15 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688856fsm76058925ad.14.2025.03.17.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:32:15 -0700 (PDT)
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
	"Lucien.Jheng" <lucienX123@gmail.com>
Subject: [PATCH v4 net-next PATCH 1/1] net: phy: air_en8811h: Add clk provider for CKO pin
Date: Mon, 17 Mar 2025 22:31:11 +0800
Message-Id: <20250317143111.28824-2-lucienX123@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317143111.28824-1-lucienX123@gmail.com>
References: <20250317143111.28824-1-lucienX123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
CKO clock activates on power-up and continues through md32 firmware loading.

Signed-off-by: Lucien.Jheng <lucienX123@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e9fd24cb7270..eb349b4ff327 100644
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
 
+static unsigned long en8811h_recalc_rate(struct clk_hw *hw, unsigned long parent)
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
+static int en8811h_enable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, EN8811H_CLK_CGM_CKO);
+}
+
+static void en8811h_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, 0);
+}
+
+static int en8811h_is_enabled(struct clk_hw *hw)
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
+	.recalc_rate = en8811h_recalc_rate,
+	.enable = en8811h_enable,
+	.disable = en8811h_disable,
+	.is_enabled	= en8811h_is_enabled,
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


