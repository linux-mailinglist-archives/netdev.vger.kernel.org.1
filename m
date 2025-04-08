Return-Path: <netdev+bounces-180323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E3A80F2D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65FF17124F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4C22A1E9;
	Tue,  8 Apr 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3qLX6E1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0F22A4CD;
	Tue,  8 Apr 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124529; cv=none; b=aQ3H5W2N3o+YlbHTobP8N0we7SYmMMaWlolAmypzpVr143SPSdpaPXpOii/JT9tlsmQRDdIkCwHSvDB0H04rUf8tKiltvpKszxVUZIPeF1u/WANVgaVDMs1t+AYa+VALcLoxFCUHJCEQ6Lh+su5+0eiQH4a5Gp9SUki6vlSBGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124529; c=relaxed/simple;
	bh=1V5LM9FxXrHI2YXdgpBEILLpN6lC29GjKLDmdnWD7xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMrPq6x/f12wzRy7j6tUT4GJO1zD4+zTKPP5lvQ4ZKPRAd8vrHW71KzTPSpBzPkXtx0Sr4hkjMovTPviC8c+qrd7KqCSRppoHktJN2BRnhX3fHnSWRfA/NyPZPvbGZkQBKUareW4ErycMOBYjRB4HGyve9gpfbYEddjVVF4nLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3qLX6E1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224341bbc1dso50523355ad.3;
        Tue, 08 Apr 2025 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124527; x=1744729327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lanYKRHOAVQmad7jWC9R3BwXl4xuzrXPK59buSE8nEg=;
        b=f3qLX6E1QGYZCsp88hOUx9ZT+pi0JQx8Uldqk/iEhVZkdTt114ZED5vJBVvi53Opbl
         GZjRGZO0z11moHP7NuXTAlu8xCa3YNUO8GSLVieyQIFpiU2/CNQWRrFl1dOhHB3x56qz
         tHC3q6wbmpkOKWTUektsCpvl25A/XU4iWCK2jG7dcyCd4F2r7x742iYKGJu2rCrwbtLj
         ib8Dy6kiszifQAPa32hmeNyEn5PIp2ha/mCbASjV1+AiuiojgXxtDcg4ccN1ihBBNSQo
         n4u+WiUySDmMpRlbC7pbBx9sQCZDMJ9AlWK8kXrZKA7gsbKqmgC2inxFrEqYQdght2Rc
         j2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124527; x=1744729327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lanYKRHOAVQmad7jWC9R3BwXl4xuzrXPK59buSE8nEg=;
        b=jj0v82aZL/oPO3l+bsJPeoMSOdGgCHlMq0K/Zszu31RetOAN57Eg4OMD2HOckHkQzV
         4FZGlTne+fDXFtesaW1NzrkBEpL0UJaNoWQalz6M/93RMnPkiaGBC2PLv9uzjVy5xshj
         NIz2fQD/b2f+th4aNVq8GYJne/mj+CKmN+dMmOHGrThavPknKlBhMy+FD6Rkn4G9bM1Q
         Wlv8IM3urTpbuRZdzUN3R2tbbsF0plw/LEYlzuEW932DtSkt7FRFIvhhCdn9WpRv8LNG
         TF3hPwJeDDkFdPOjBkmKO9AW/+sww17d/BYHi6FZfncnX/M4woOewYvAUWLVm4NEJT3J
         8vxg==
X-Forwarded-Encrypted: i=1; AJvYcCW5VDq/5C2FR7ZBP3QauTj8lGKFTEtw/+QyeW8unVFxnVCMt30pzgkVFX4AvrnTffNepiLt7ejAdwaWs2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYeZ8VmDmM8YKjNQ/sR7pXpgUOrrFL19b4mW+Ztjxs8b76azg
	lCEs1xNWZtCGMW6EdtE5Kmlh+cezLJB4Q0TmHAUaJuHVvX1lizOOx64cpUA=
X-Gm-Gg: ASbGncum6nYFC+Xs0tUfKTh7BKPNI8HuPUXYo0ZoC5Mv81HT3mhEz/tcxHrS3YfLwOA
	DfSo6tqtAFetD2hbRpYhknXPCqcuoWr9gyrNbRDg0sVHsZqVYnF+QAO/dJORJTRkl6gXUFkUaw7
	64CG8/uhIcwTLn9NqeI3a43GptOCxVqOW0pSUH8vjgHbMRLzuFJMYPHiokyDAPy1/zhm5kppU1j
	VlKdbP08KHljtWxtbU/g6n5sfBrxd3o9u7VmcuR5hur26uGnDT7FCx+N2xCqVfDLdZGv0gOK8hz
	X4X2NVQml5uTMdU5bn705g6OgAPk29AtIsK6hXmEmjs9U5NOWZqTgEhSwqaJFRbAgUi+XKSAwlS
	rd7Bq40dLTmDeXxIEvT8zdZjemN3hBsdXwcRR2g==
X-Google-Smtp-Source: AGHT+IFimZU9V8rdI+tpXInlH/fG10dMMdd9u4/e8prqHcREMC6o2Lmc33zvP2/ddotsXlYb4KuXmg==
X-Received: by 2002:a17:902:d485:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22a95529550mr210976505ad.12.1744124526610;
        Tue, 08 Apr 2025 08:02:06 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978777259sm101092365ad.251.2025.04.08.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:02:06 -0700 (PDT)
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
Subject: [PATCH v7 net-next PATCH 1/1] net: phy: air_en8811h: Add clk provider for CKO pin
Date: Tue,  8 Apr 2025 23:01:18 +0800
Message-Id: <20250408150118.54478-1-lucienx123@gmail.com>
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
Change in PATCH v7:
air_en8811h.c:
 * Fix: Correct various code style inconsistencies and remove unnecessary initialization.

 drivers/net/phy/air_en8811h.c | 103 +++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e9fd24cb7270..4eebc6e24ce5 100644
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

+#define EN8811H_CLK_CGM		0xcf958
+#define   EN8811H_CLK_CGM_CKO		BIT(26)
+#define EN8811H_HWTRAP1		0xcf914
+#define   EN8811H_HWTRAP1_CKO		BIT(12)
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
+	int ret;
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


