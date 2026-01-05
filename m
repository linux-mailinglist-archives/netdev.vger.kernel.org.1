Return-Path: <netdev+bounces-246963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFACF2E6C
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61C173041568
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577827990A;
	Mon,  5 Jan 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6F06+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3991DF27D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607376; cv=none; b=nI4mMfj7ZnN2e7XBGtRM7nWfHFJi5Y7lHjw5romvAnPZ3ZocgdLFgZpHJqc3i2oGe3eObD0b95zkuqkZRvZHnY1dMgSkokpOKhS2NheS5NAGic/mPbRtxxU1yC5Ajq5KWd5QhDeCjYb5wWltt8MBydhXlR8mogiUNEwhycODFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607376; c=relaxed/simple;
	bh=A9NT9+ObFVURRY5DrjmPg5SlXTK2iGfpCBkIhmcwnOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbqCkvhYCTsGQD+4mgf0fxbL4ZKPRtPFEso4FfnFOCTq8Hn4cCYn/bPbp5Ak0WXy8KZ21cy3yuvKz2xJW2lcXh65drDv0y35DQdwUV9LVlWajgI4Uut7H6/H/PIAmMJTwE4tkSfG4rxscQTn3AvKrHxK4kuVASwh+2uK9WC0Ejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6F06+P; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432777da980so4061054f8f.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767607372; x=1768212172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGMtlDyyRbCcoNhJtD681fIKSx7Hpi6HHJrHp091fTU=;
        b=Ud6F06+PiwJ+LQz8ELV9UCeM9VDBw5G0ExF7jzkP/M3yfUOfj/xlQnDJ97qxn/dmsK
         qMpPIvnCmhjSMbm3B6QXteTrA1ss55pXhhE9sSXtefq9jTgpy0UPD7msFQCW1WXgx316
         t8Q10tu+FGDPfjo2qGQnvUdzNulbqHdR3xHbOu53oaLMIWoPjsSibiXmMI0CHf9CY/Qn
         aBnglONH0dA6KDCJDiC3GLV/OP5tmqHDsyX/zZAreIhaklxejQMyR2ME3xX/YkLBebhx
         xrrfbVAGmAiFRWebFaPdBdowuPvENJZdgFxMgDlOWOxS10QfXMak1WzG9RRuerz9H/V1
         SNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767607372; x=1768212172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGMtlDyyRbCcoNhJtD681fIKSx7Hpi6HHJrHp091fTU=;
        b=EpRsED9L8U6H91fF1/cJdTX9yyA5AAp5PSRgsWIkCi7Y33w2cTJveJ3UGnN2NQbScA
         Ikhj5beGZ3fh4LLULQAp1uObMMEFniwhbK9QWhZXBlcTOKHBSKSdvsIFKMwf8ALyNbJh
         vbx2Rj2pArTatcbDdt2h6KF5u0pzuNnVd9bhAzv9orLdxHEmid9AIChZ8sZNKrraFeUc
         87Kq43EAvUGXMJwN4mLUutB0JmJHLj+eW9lOhSE4zU99Vu5sDoeTD/hThS3fpRleFNtc
         noBVT4BqDUTmq88t3NVvX0/ZRJwPSXGgR5oap8zLXJP7dRPLD1l6JjcK1Mq4y21pLGG8
         8Ciw==
X-Gm-Message-State: AOJu0YzybawvV2wpVKN7iRfFQqmkys9le8mLRM58rAo/1ACJ8rcFzoaa
	dnwsgswsaDxcqISj7TG985Gp36jzI39axhbALu50++v8qnV7cCHuSUMM
X-Gm-Gg: AY/fxX4obVRCkeofJtpPej0EdE8oO29Ck8aYWp19GqeruwvT2uMilmq2966csD2kp3d
	7UiSN7TW3ZBHBaiUP5RObTX9oa1kZS2/IUQYCgJeWWC8EDHiaGRPocuZz8lv0ekYdczvs+/8tEl
	95baqdLnO0hkpDhOo3zmAfkeZbaJqxhu79ZLO32amaUcBLJkXyIqsagNYGFNqRwxWmIDaA5FhOI
	ix5iLZwqtaa9rf3jQ7lOh7aIBIUFHuOMdo1mHSCv8Oe13qQD90HF4Zegr/4F69FUQ7lNSiMN+Dp
	lkyl9s57G+0MDEMfmIBcLMuY4fe4ilcsBH2Qd5gPrikNKNWjctPgX4DGtwd+AxfX5E/yh4+Yynp
	77MLSsGecU0QLYG5djfKrAm3c5Od0/kMRHcg5GEhGJHKTHMN3qEtYiKIikuJOI/g1KQ2ttllKb1
	gOLgWfs3Yd+mscWWdSDzBBxW42
X-Google-Smtp-Source: AGHT+IFKkMH1ZSx5o/rB6BTbeL4h1LkJTSLLqMkYzmB0QdI0255AUuWQv6qVkyZaadRtjHotP2jJUg==
X-Received: by 2002:a5d:5d87:0:b0:432:8651:4071 with SMTP id ffacd0b85a97d-4328651421amr32457140f8f.18.1767607371844;
        Mon, 05 Jan 2026 02:02:51 -0800 (PST)
Received: from eichest-laptop.gad.local ([2a02:168:af72:0:20bb:19ed:fbb2:7e2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm99270630f8f.5.2026.01.05.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:02:51 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for the Micrel KSZ9131 PHY
Date: Mon,  5 Jan 2026 11:02:23 +0100
Message-ID: <20260105100245.19317-1-eichest@gmail.com>
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


