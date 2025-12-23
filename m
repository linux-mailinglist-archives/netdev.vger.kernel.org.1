Return-Path: <netdev+bounces-245829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC1CD8BE5
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1AD300ACDC
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2836C0CC;
	Tue, 23 Dec 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUxVQ26Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F436C0C4
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484785; cv=none; b=HhpusR+ZW7OqXbCIygIySLLC5A/X/1GjOlHXpB8tlQyjTG5gys7l3soLvmL98RyGmAXb8vpKx0p3dSODUGIkGF2OeiGJNVd1WXImN8r0Rk6E3qkP8tjrk4dhvI+sAiqXseFg3IRJSRSYt6ZHIVA6I7uf/tkngnzTeVXe2/+y07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484785; c=relaxed/simple;
	bh=A9NT9+ObFVURRY5DrjmPg5SlXTK2iGfpCBkIhmcwnOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5uTp8vPypJ8rO+GwidobFR2M+gmP27O6IPvzGkZMCrZxx1a1IGPcSNbYBfeRJN+szNG+TG2hli5a0YyA+H83IWDXLJzQ2KJ1PzvlEohaoBDD4h4Qwkt05MhmLZ5YLpF0Z/n5PP5/iIGpx/a4vZrijlHyt0FMf1uKtGPTNCZJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUxVQ26Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so3206303f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766484781; x=1767089581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGMtlDyyRbCcoNhJtD681fIKSx7Hpi6HHJrHp091fTU=;
        b=EUxVQ26QPNHgQh2nsEQCmrty5yMsnXT0DvtoxZeKBaL9aRQTzyuaXkOYmuX5U2xwCr
         1waj15lnXlG3754rQkmfgQ8+IxHHyodZez1YrlByvn2g8PWcFCL+asGoqjEau0y6RO5s
         w1w3VP6YQziB8CNIldDaLxsWr9wZQlJq6SGns9leRH8PMpgNnNWqSBzcmxAI37R4ng1H
         znKqunYPclYyTBSQ8oy0EoImb1k1WbGzAi9bUaPu97LmVP8G9p0nsDVmhncf53dWR9V1
         oWeAp5F+reH3J/DL1pUzuX6IbQfns7QwE1o+7OKttu1oRkN3pBUamEsEI5DzRK/mKQL9
         W4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766484781; x=1767089581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGMtlDyyRbCcoNhJtD681fIKSx7Hpi6HHJrHp091fTU=;
        b=UPyFTY4kIzOv5IHbKksuHv9n4S0dfZ8g9cD3sCPMxzIn1iFUdp1mtkeovc8yRej/ar
         9FzQo0An11AwSg8QDDjKVu8ADmakGZhntqtAyiAOJFTnESG2UfrHyWp1WLV0Vq0UsMvr
         gCK/oZVqmopKVhTkWWeS46syQbIYhuxKUXKZfclmIPP334hO5WFthn5wFvnNhJTNaC2g
         O5geOamVg/JhUBPSsA6Gx/+M2rvFA2a0uiZoZx9XVkAz9IjD7wSQnqt5eaAVfLYpu8xH
         fSNeJBoi0CL3X5sd53bmrbnoCjgqOxB53rWQk8Y6G9LOJl/ZIeiJzWOcRJ8Pcgbf1mBJ
         2iTw==
X-Gm-Message-State: AOJu0YzB2X5R8H16+tew9RxBbYEh6jpxDCTk40BN4tSmt9+aZbMSLPpx
	01oujTUErOmfaaSzpYo5jXunb/MXNphlPZWegC8cxwlQpR7DC3PEARJ7
X-Gm-Gg: AY/fxX5zmAVAyNpiAuvtTjsUMiSlqn5lwhi2NKo7OuBpcE4rCE8eqcVh77sNq9tpQ3M
	vpSTzZ/juUL6ZQORFHP37RvDELB1QKUUb+iiyQy80ork7AazBJ5IrHehNLOYKpHi+6tZi7ZvTrK
	wmu2rVTuSAaDK32JgYHFFNCckvpYbx4U79FSyJx/Zc2HfUdlDZlwsATURmxrjoBK66bKX6MDmtp
	YaK2YuZTE+kfvP/o56l2Eigbbc3s1Drfc0aGuso6Wxq7IgcMI9F0NLNuoKd47fUU3cRRbikZDLT
	MiEQ4eKVOfu5qh36eZoj6dCrZZLCnSxHlKS38UMqZTTTjC/+d687UOB2Rr7s9cwpCtsUiedzzXT
	R2RcyhlB0OGI0c2YJqROHCDAM0JD9RTefFJW9IwMbbNYfNqIN7lFt/Y4zs+COYeD3j5vb6yyXPD
	IN1j+Fj3pjCi0JIHjTSL79cepIHA==
X-Google-Smtp-Source: AGHT+IGF0o0X3T9TPemtGA4iv5QpXYtSLA5891eQonPhGoJJdeHdYF9/vi2taBPYEXsT/bnOH7uFfA==
X-Received: by 2002:a05:6000:188e:b0:430:fb26:3409 with SMTP id ffacd0b85a97d-4324e703d95mr14723855f8f.63.1766484780377;
        Tue, 23 Dec 2025 02:13:00 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:db87:3fd:1ea8:b6eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa0908sm26759247f8f.31.2025.12.23.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:13:00 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH net-next v2] net: stmmac: dwmac: Add a fixup for the Micrel KSZ9131 PHY
Date: Tue, 23 Dec 2025 11:10:59 +0100
Message-ID: <20251223101240.10634-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a fixup to the stmmac driver to keep the preamble before the SFD
(Start Frame Delimiter) on the Micrel KSZ9131 PHY when the driver is
used on an NXP i.MX8MP SoC.

This allows to workaround errata ERR050694 of the NXP i.MX8MP that
states:
ENET_QOS: MAC incorrectly discards the received packets when Preamble
Byte does not precede SFD or SMD.

The bit which disables this feature is not documented in the datasheet
from Micrel, but has been found by NXP and Micrel following this
discussion:
https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032

It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
10MBit. Without bit 2 being set in the remote loopback register, no
packets are received. With the bit set, reception works fine.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
Changes in v2:
- Use phy_register_fixup_for_uid() instead of adding a new device tree
  property
- I will send the conversion of the micrel.txt binding as a separate
  patch series
- Link to v1: https://lore.kernel.org/all/20251212084657.29239-1-eichest@gmail.com/

 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index db288fbd5a4df..23bc917d3f0bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/stmmac.h>
+#include <linux/micrel_phy.h>
 
 #include "stmmac_platform.h"
 
@@ -39,6 +40,12 @@
 #define RMII_RESET_SPEED		(0x3 << 14)
 #define CTRL_SPEED_MASK			GENMASK(15, 14)
 
+/* Undocumented bit of the KSZ9131RNX in the remote loopback register to keep
+ * the preamble before sfd. It was reported by NXP in cooperation with Micrel.
+ */
+#define KSZ9x31_REMOTE_LOOPBACK			0x11
+#define KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE	BIT(2)
+
 struct imx_priv_data;
 
 struct imx_dwmac_ops {
@@ -282,6 +289,30 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	return err;
 }
 
+static int imx8mp_dwmac_phy_micrel_fixup(struct phy_device *phydev)
+{
+	struct device *mdio_bus_dev = phydev->mdio.dev.parent;
+	struct device_node *mac_node;
+
+	if (!mdio_bus_dev || !mdio_bus_dev->parent)
+		return 0;
+
+	mac_node = mdio_bus_dev->parent->of_node;
+	if (!mac_node)
+		return 0;
+
+	if (!of_device_is_compatible(mac_node, "nxp,imx8mp-dwmac-eqos"))
+		return 0;
+
+	/* Keep the preamble before the SFD (Start Frame Delimiter) for the
+	 * Micrel KSZ9131. This is required on the i.MX8MP because of errata
+	 * ERR050694.
+	 */
+	return phy_modify_changed(phydev, KSZ9x31_REMOTE_LOOPBACK,
+				  KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE,
+				  KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE);
+}
+
 static int imx_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -389,7 +420,30 @@ static struct platform_driver imx_dwmac_driver = {
 		.of_match_table = imx_dwmac_match,
 	},
 };
-module_platform_driver(imx_dwmac_driver);
+
+static int __init imx_dwmac_init(void)
+{
+	int ret;
+
+	if (of_machine_is_compatible("fsl,imx8mp")) {
+		ret = phy_register_fixup_for_uid(PHY_ID_KSZ9131, MICREL_PHY_ID_MASK,
+						 imx8mp_dwmac_phy_micrel_fixup);
+		if (ret)
+			return ret;
+	}
+
+	return platform_driver_register(&imx_dwmac_driver);
+}
+module_init(imx_dwmac_init);
+
+static void __exit imx_dwmac_exit(void)
+{
+	if (of_machine_is_compatible("fsl,imx8mp"))
+		phy_unregister_fixup_for_uid(PHY_ID_KSZ9131, MICREL_PHY_ID_MASK);
+
+	platform_driver_unregister(&imx_dwmac_driver);
+}
+module_exit(imx_dwmac_exit);
 
 MODULE_AUTHOR("NXP");
 MODULE_DESCRIPTION("NXP imx8 DWMAC Specific Glue layer");
-- 
2.51.0


