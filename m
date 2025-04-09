Return-Path: <netdev+bounces-180826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30EEA829BC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B562C7B78A3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3D267B0A;
	Wed,  9 Apr 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF1Yq1aX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00888267734;
	Wed,  9 Apr 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211392; cv=none; b=Zr9N6RBlnThogZTNGFPpxtGG+A98w+PLH9rzKcAvZ0ZzPB771Ud9zJNQcbj8hcGpAZV8npLcWKl04T13pyyKb/UOsilFwbxz48cAAWVePxt7Xb0esZzxC4t+4dORv0NFkI9rAzarkwcM8XisRcd7pyGX7EjR3+8tXxGfpqJO1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211392; c=relaxed/simple;
	bh=vdppM8d0ErL/ETCZvsFANbRA3p6PjXQ2zYGfKhb7umU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0eVYnSUSoEgvXpDhzO9k/3uY461uvgHwLeocw86FQUeJ2B663PxMTiQ4DvnRxzPvzq4APtaxFEPgSKhx7vm5c+YU5juUvItFHyVyECJlc4ReSemYSPTXzRt+zKZbYeev/f2HoOfy1s5Z2ifDB1ltSgIBjdq57+8Wj1pa7yjxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF1Yq1aX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bb647eb23so528152b3a.0;
        Wed, 09 Apr 2025 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744211390; x=1744816190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrhjGmovgh/xIKQ/o/j6ahrmcFyr6axBEkfxzGvYCyc=;
        b=NF1Yq1aXNz8PnJaUidx4qqKFbMdnsw7eQJIQ68rgk53AJf/pj81i1X4W47g20/K04P
         Zgs6SONQ4pgYMcpWXtQg2kEqSjjr58ACQzfvowPy5c2iwuUD8IVl+XpRD0xye8sgOFx3
         JRT1zYHQPAULTVFmm/2uWbpxTRPJoOXan02twtD/gknFZHhKQHyvAv9A6lJdM1eZk7fu
         nzZhiov4g15uMQmzO074tZ+aNmGAG4H1N5AckwySPjtoOJZz21oa8P94YcLGNmXVHs2r
         u5pQ32D7OGVa9lrfvsrqCu1BG/ecNG4uHTfUUBvBqJaWUWJOPj363VS4O7KdvgoiZnd6
         jlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744211390; x=1744816190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrhjGmovgh/xIKQ/o/j6ahrmcFyr6axBEkfxzGvYCyc=;
        b=CQxA9plgVUNalLA2vILQO7EiVze9XdzI4cizcHHpU7he2JX/I7UVfkR/UyeFILGbl0
         MS3GYYe7rjiuCLts5FHL0Ei+a9wINQpMdDPJmmgkdqJeqZdWsMkHjGlQxyUO5+HySOQ3
         uKwt4TeovGKuBSR4ortQP7x0BF98z8+LDkr02KP6iQF4dKbeEU1SWUc0gIXYl+gbgrGc
         +3rSV4Rqz5FlKNnoJi5lOE7R3HcFJPc49v9fH9ToD9ilS8Q5Elj3egxFkASJct/D11OE
         mBiSZbD3cQnLLzUaf7V/den7eYxApaQ0Xls0AlzJKqrK0AonS9vNYTPtVGWzox6XE9D2
         qR9g==
X-Forwarded-Encrypted: i=1; AJvYcCVJKfowE6Fr0JRooq7w5CCYPg9NGkqhuu0RXVxK5txxXXqGRPvdiKe9drWbMLbyOGVvfSbOwot88E1EfXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUqm4zHdyeJAN54OnEkC3FW15S2asESsjHuidMD5c6lt365/4
	4hS6E/C14y5MqTIgP1FcK9bKYvtPt82jcTgVdUzs4nSNyfYUVLwLSFKwCBQ=
X-Gm-Gg: ASbGnctkg1k60jxg+ovh0GLhD7zsF07NVZldSA9IuAzVBcXjLHb1fd3gZ2Z2wdDSJO+
	5scOTpbWEKvnOsHwyBP3t+1kJDt6AjXtdiLi2nBHCtCzjrNdxFV6jTaAv3PpbWKZh7zPQWA+fYO
	ZWL4phutuYRVa7tAF2i+N8qGd7mg3UkGb9qK9EvelnrynJ1mB2v5EqC9Rj3wfpgHWjxZjmte5ft
	wEgqD2MDvCxeKtvmcQsq/97Y8ld2KSyIGhbjzlobgFlkiKH5tizxlg1h2xZgSmTNLKjyGZmMGB7
	0U+VjwiV0AkP3u6Sk0w60MHZs72xPtDKAAxhXJxoIHhgDwA/uuAa7vHJ7iZxpegRdtCFSrmMu9j
	Hhy4y01/ToX+WNlYXLyXlakQ+szhWDI5qfA==
X-Google-Smtp-Source: AGHT+IEIV1TLo6IjW7UX9fiLk7WZ/GDX3g7tYEHzjwBt+yjiWaho+mHufK8BtbWBlnDd3P8oi+X+ZA==
X-Received: by 2002:a05:6a00:ad6:b0:736:7a00:e522 with SMTP id d2e1a72fcca58-73bafbc6364mr3867472b3a.2.1744211389732;
        Wed, 09 Apr 2025 08:09:49 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d469a3sm1499249b3a.66.2025.04.09.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:09:49 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
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
	"Lucien.Jheng" <lucienx123@gmail.com>
Subject: [PATCH v8 net-next PATCH 1/1] net: phy: air_en8811h: Add clk provider for CKO pin
Date: Wed,  9 Apr 2025 23:09:02 +0800
Message-Id: <20250409150902.3596-1-lucienx123@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Lucien.Jheng <lucienx123@gmail.com>
---
Change in PATCH v8:
air_en8811h.c:
 * Fix: Correct various code style inconsistencies.

 drivers/net/phy/air_en8811h.c | 103 +++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e9fd24cb7270..57fbd8df9438 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2023 Airoha Technology Corp.
  */

+#include <linux/clk-provider.h>
 #include <linux/phy.h>
 #include <linux/firmware.h>
 #include <linux/property.h>
@@ -115,6 +116,11 @@
 #define EN8811H_GPIO_OUTPUT		0xcf8b8
 #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))

+#define EN8811H_HWTRAP1			0xcf914
+#define   EN8811H_HWTRAP1_CKO			BIT(12)
+#define EN8811H_CLK_CGM			0xcf958
+#define   EN8811H_CLK_CGM_CKO			BIT(26)
+
 #define EN8811H_FW_CTRL_1		0x0f0018
 #define   EN8811H_FW_CTRL_1_START		0x0
 #define   EN8811H_FW_CTRL_1_FINISH		0x1
@@ -142,10 +148,15 @@ struct led {
 	unsigned long state;
 };

+#define clk_hw_to_en8811h_priv(_hw)			\
+	container_of(_hw, struct en8811h_priv, hw)
+
 struct en8811h_priv {
-	u32		firmware_version;
-	bool		mcu_needs_restart;
-	struct led	led[EN8811H_LED_COUNT];
+	u32			firmware_version;
+	bool			mcu_needs_restart;
+	struct led		led[EN8811H_LED_COUNT];
+	struct clk_hw		hw;
+	struct phy_device	*phydev;
 };

 enum {
@@ -806,6 +817,86 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	return 0;
 };

+static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent)
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
+				       EN8811H_CLK_CGM_CKO,
+				       EN8811H_CLK_CGM_CKO);
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
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_CLK_CGM, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & EN8811H_CLK_CGM_CKO);
+}
+
+static const struct clk_ops en8811h_clk_ops = {
+	.recalc_rate	= en8811h_clk_recalc_rate,
+	.enable		= en8811h_clk_enable,
+	.disable	= en8811h_clk_disable,
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
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s-cko",
+				   fwnode_get_name(dev_fwnode(dev)));
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
@@ -838,6 +929,12 @@ static int en8811h_probe(struct phy_device *phydev)
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


