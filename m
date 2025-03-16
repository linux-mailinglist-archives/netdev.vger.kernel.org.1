Return-Path: <netdev+bounces-175124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C63A6360F
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 15:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE611891852
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD871AA795;
	Sun, 16 Mar 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3PVDUIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64FA1F941;
	Sun, 16 Mar 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742134804; cv=none; b=q/BoHdLHRIlGyBoEjIhL0LFT3V/Es9df61Jxni7RDGCvAlaCCmcXo8PNN4qloF7DRVTuwNYoHvutEPM5nJQhyaz+it4jfvhuGClRKeEkCaQqp/Rlc0TXixz/cAXxI8ZfQu2r8l0LIu0kUYkWXsG3nhrZrMDWMOf1d18IvzS5ZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742134804; c=relaxed/simple;
	bh=SM9sVUEo6LLFEorZIojkx26q2P18H2FzZgNAy/r5RiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLgfnfqaEVExYrGffmOgb+5GYcB/YhRbbqexZ8YMfqOL8KbyodiFwJ4eRRb8TSBx4K8oJ9W8zgMXCstiM0oeA9exoDmOJp4rjQGyigiNEmbFh/pIXgiP9HMkrR0iVEZXw8EahEyYhsuVhmC6enquSMwCE7W0PL/gqHABm7yJ9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3PVDUIX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso153165ad.0;
        Sun, 16 Mar 2025 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742134802; x=1742739602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Osx6qrHXrN5QGo/98Mcul05sdcRwgeDonPsp/lg3Azs=;
        b=Z3PVDUIXcEtnip+ddv1A5+mZpoMalxMrdtzNG+g9tTd2B4FdJJOZCQAZoUAF0MtzVa
         XQbo6d7nVRf36kkv64FW9WRMZy35gmEuyJ0I19twpW+t2zZBnEhUkW6HtLZM3gmcS82O
         VT7KDb9txaHdhMPP1jR5fdqU6evUT6LmlLvV9af2EXF3D2F/0C6lrCQwfawzDGtsd5N3
         R2hav/WkdxKp8Tmhj6/SB6DkUfN9o46VUT/VxlrhPYNYYFfftXbaZ0ySbP9CriHEbp+m
         mzP1uIx3EfHHQe/fpfTa2wjC0zOaezGGGlQwT+KLUtVBgGnHI9MNzE1hZA/bio90TbQo
         z/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742134802; x=1742739602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Osx6qrHXrN5QGo/98Mcul05sdcRwgeDonPsp/lg3Azs=;
        b=P4jmzq4lXZq04reYuS+gGR2UZ/vQTYGhPyM3aDyDq/hUmZLbZ4yIg+d1GODV4fcTSe
         GH2LcPRwVMFQvAg4KJqEyVSdiAMAEANou0fXjlNXzQxhzFxeSK2BLy+rVPpeNWVvio0f
         YoPgUA7JOmZORsywn+bkVUupkiluFR4iHFuKOfSKo4Tlc+ra53jzqzw+0XB8V11sBKpI
         5h4dWiPPzgOGFK/i+zpWVGciXbFsov+bIaCunmXP2mr+yXabsx5KdRACXlnUUhaQc0xE
         lZJ66JIJILEzGc7bev4lCEZlO1Mm7mNdwsl9/eTOThywpCrGY0btOO5dN9qRRnQdYa7P
         zDSg==
X-Forwarded-Encrypted: i=1; AJvYcCXus7Jlr7Wlt49YWPqjgEl/JfdllXxLa5qONHvm6Vq79YLxPf5YZLEMpz9gk1sFbM1uaftRcVsWoUnUxb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Nv4DbuJH2z0BphxXebiJXdg6MdWhGo2Aht/ryF5yoBnQ4M37
	0NMYi6Y7/X+PHZhsnYz8b7sr5gKk5gE+XrsW5RHWHgqxXLQTpfk=
X-Gm-Gg: ASbGncv/unTqeE4QBX5Tbf/30cl9drJebOLC1Ew7kXbK/fR4MC2WrB9q4T74vFqY1Ut
	QK91KQrSzNTvfsQgmqdycLCkj4Uw23cu+t5NHqZ2KJF72Vc16Xsg8DI6sERAbvt2u9IWf2SdthM
	WaBHakGIKhOHRrHF+rd4NODsjWj2hDqmGX2XTQPQdPGatFWcWP5NRlnB10Xou7zMommPQGwZADK
	yBpvfnIqS+qjKkqew03oK4bptPYcdFNgeiM2zyKEgkmdOeXHd6ZrtIKTOVb2MoUsrtjcSW1sfQN
	+QERSM3pQpJ3nLPQyWlswbFDvYs80TQ8av+GIFUMPiXfr+86LKt2Jw35LPwVM20a84L773vcmiZ
	H0ZOPmXn+j/DqGLBRSZtcG1z257sNt08GIaFiJw==
X-Google-Smtp-Source: AGHT+IHBdthJFV/bk0R/+kwiTPBqhBwpwvDmqoyHB851NtSzxYA7oJyLsL1dUz0pKL+DOG9QCji5Qw==
X-Received: by 2002:a05:6a20:9c92:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-1f5c1126c3bmr12182271637.4.1742134802043;
        Sun, 16 Mar 2025 07:20:02 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116954aasm6014734b3a.135.2025.03.16.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:20:01 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
X-Google-Original-From: "Lucien.Jheng" <lucienX123@gmail.com>
To: andrew@lunn.ch,
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
Subject: [PATCH v3 net-next PATCH 1/1] net: phy: air_en8811h: Add clk provider for CKO pin
Date: Sun, 16 Mar 2025 22:19:00 +0800
Message-Id: <20250316141900.50991-2-lucienX123@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250316141900.50991-1-lucienX123@gmail.com>
References: <20250316141900.50991-1-lucienX123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EN8811H generates 25MHz or 50MHz clocks on its CKO pin, selected by GPIO3 hardware trap.
Register 0xcf914, read via buckpbus API, shows the frequency with bit 12: 0 for 25MHz, 1 for 50MHz.
CKO clock output is active from power-up through md32 firmware loading.

Signed-off-by: Lucien.Jheng <lucienX123@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e9fd24cb7270..ed90ccefe842 100644
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
 
+#define to_en8811h_priv(_hw)			\
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
+	struct en8811h_priv *priv = to_en8811h_priv(hw);
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
+	struct en8811h_priv *priv = to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, EN8811H_CLK_CGM_CKO);
+}
+
+static void en8811h_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, 0);
+}
+
+static int en8811h_is_enabled(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = to_en8811h_priv(hw);
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
+	init.name =  devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
+				    fwnode_get_name(dev_fwnode(dev)));
+	if (!init.name)
+		return -ENOMEM;
+
+	init.ops = &en8811h_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
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
+	/* Co-Clock */
+	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
+	if (ret)
+		return ret;
+
 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
 				      EN8811H_GPIO_OUTPUT_345,
-- 
2.34.1


