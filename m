Return-Path: <netdev+bounces-258031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iId7C5zBimkeNgAAu9opvQ
	(envelope-from <netdev+bounces-258031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:26:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA617117173
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F2C3063A05
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 05:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20132BF35;
	Tue, 10 Feb 2026 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLmjeen5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1A32B9BD
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700971; cv=none; b=h/WYUuQXTNSKLwJPLOlOzqZLaVcTS9oIT9PgGgNwygcuV3PaIoY2ZHSsGKTv0/jTQCtOMxZpfymAnme30egX4a75SnilQQZjzm+7EQryySg2Tk9vbPlNMA9pzs9AaYGqDEK3Lo8n1nsnU773LvJRc1k7iuPx6y7FO1L0fcMDdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700971; c=relaxed/simple;
	bh=2HvgA8+pZQSuwHH1gevRSa2+HkQi7niGFLgwQQs3vdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeBY9deaRbIQn/Zt54ZstYo/lzo51VbWcLJyvr6PAW1MnM3vNvPYkRAFXqmxpvhARuiBrjTtd/KHbzl4bWqVLKyKMnZ4MUVPcjt5gh/Hu6OhCqEdkFr8WrymSQoKaCfU/uieo3LB8pei0i5FjxYw3LPXqtNMOm3DoUZxgApaum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLmjeen5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso2032535ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 21:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770700970; x=1771305770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzFwESZOkwxx17CXvSjDYHHBJkKja6bTAjzp0iWKbyI=;
        b=NLmjeen5GjO2hlsc64rrIPAp3MVyV9fVHE5HXQk7hm4VOKqUCBUOFoZOqOLdfhww1H
         6exWN4F1QinfGA4Wq1T+UqsyGclOmCkIbIA2J/CsEQLLfs0ITyBo/vdwVIxSEcaimrFK
         mgub7mxmM+eI9Fb0yWERH97iRz95Iwve9dxscYKAwaEIdaM+oOywGZMs4vEPBy+FI4eV
         oBGsn2+rLRG3FKN8PWwoGJa87knNZxi12tFqr+SWy7wO2JS7/oF5zW0uXytJG201uz2F
         jGfsn7ecVDUez9nBOZZWmdN3f7x6088v/cUV7r+gylaCO4tew8fb4393Bh2zw/+XCEY2
         R/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770700970; x=1771305770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzFwESZOkwxx17CXvSjDYHHBJkKja6bTAjzp0iWKbyI=;
        b=qRXPN6erdjZSbb/rSD9hPTI6PaSaTRKyDNeJcOequ921S3MOTw+B9dLTSJksFY5yif
         7MSg4629FUf/OnUIgXtKk9iFqj142zI58eGemwG8Dc9HsTOhr4hrjaJFzuZRY7kiWZ3l
         FzSO2X4H2RKWPogccPa3EhwqSrQoq1eq+sfk6An/mu3trwMGPJe5NrqpEkXP64ZxvMLm
         /u8lBHurJd8FhQzcjg58zUyrUIb/5zBMqn8kUUzbY7SeeqZVyVBxuKVv8ujzCJGFu1rS
         BEj/pktSUBoT/dIMH+RGJWo5qtXFl0T4WBMEyOhWYKSKpH+UE9dB1se0plxLmHUzH65m
         AEng==
X-Forwarded-Encrypted: i=1; AJvYcCW/0Twce+8xpu4FJWbfyCUrNBFe7cWQPIPxyYMKu15nTAHJEyN5h0r9PyTQSqHH2c+ZO2OQfO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDWJkoITCc6dMPjEoZMF3NA3I5zavvIzjhjeW0Nob/unltm5+
	GHeb9VcpXEk4LgLAc4XclPTDEzNS8J/pkTpIs+hLiarFaED7bR/91NDJ
X-Gm-Gg: AZuq6aJy02e3MmZRlNzYlMuV5DkbqZxopzIOZ+cgOaA4gdH+5N60SaarPRIEDgvRyyj
	GHQ0OpPCEzaUUs2nTcLgW0tuV6gwyCwQWVvHFY7iB8KsNbPi0HGpHq2zwtFNc7c/3Iz0Pr5p7aQ
	nwL+X0mxOrpKifItyKHmG8R0RQBkRyOs9AaM/qP0NJv8Joms4I//hGR0n7XTZi/Vwc0dbkf32Vj
	Y8NAAZN6w4Drc5s7m2I2Zts7U5QcImHsTtoZzBqovdfWkO7SjKHtXL668s/M1Ar69bsZGM2+4b9
	HbOZVDuNCF0bMsgPDFCQGi+6hmXzZ9z8IbKD/XNjy2mS0vxflCIuWCuyKDv2gDsyo8HGrMAvB/y
	vroVuKXavE2yBsX3ffTpuJcYvSOr+OcCmoQSMhClDn1AXObT+qhUFyxm2rNzJWRffmxSDL68xe5
	Vu+/RpFeUhicgV7ali9dKrvkoztJfQuh0AyGyinR1m50p1HIKAykqWqXoLMLhc8RE0ArFjsasMl
	zNHP0beQIQo
X-Received: by 2002:a17:902:d509:b0:2aa:f798:8c7f with SMTP id d9443c01a7336-2aaf798af92mr52504575ad.54.1770700969732;
        Mon, 09 Feb 2026 21:22:49 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951ca59f4sm122114275ad.43.2026.02.09.21.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:22:49 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v12 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
Date: Tue, 10 Feb 2026 13:22:26 +0800
Message-ID: <20260210052226.3005666-4-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210052226.3005666-1-a0987203069@gmail.com>
References: <20260210052226.3005666-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com,lunn.ch];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA617117173
X-Rspamd-Action: no action

Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 139 ++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 07088d03dbab..861f1c6c14f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -132,6 +132,18 @@ config DWMAC_MESON
 	  the stmmac device driver. This driver is used for Meson6,
 	  Meson8, Meson8b and GXBB SoCs.
 
+config DWMAC_NUVOTON
+	tristate "Nuvoton MA35 dwmac support"
+	default ARCH_MA35
+	depends on OF && (ARCH_MA35 || COMPILE_TEST)
+	select MFD_SYSCON
+	help
+	  Support for Ethernet controller on Nuvoton MA35 series SoC.
+
+	  This selects the Nuvoton MA35 series SoC glue layer support
+	  for the stmmac device driver. The nuvoton-dwmac driver is
+	  used for MA35 series SoCs.
+
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c9263987ef8d..4ade030b634f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
 obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
 obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
+obj-$(CONFIG_DWMAC_NUVOTON)	+= dwmac-nuvoton.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_RENESAS_GBETH) += dwmac-renesas-gbeth.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
new file mode 100644
index 000000000000..29d15f41b244
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Nuvoton DWMAC specific glue layer
+ *
+ * Copyright (C) 2025 Nuvoton Technology Corp.
+ *
+ * Author: Joey Lu <a0987203069@gmail.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/stmmac.h>
+
+#include "stmmac.h"
+#include "stmmac_platform.h"
+
+#define NVT_REG_SYS_GMAC0MISCR  0x108
+#define NVT_REG_SYS_GMAC1MISCR  0x10C
+
+#define NVT_MISCR_RMII          BIT(0)
+
+/* Two thousand picoseconds are evenly mapped to a 4-bit field,
+ * resulting in each step being 2000/15 picoseconds.
+ */
+#define NVT_PATH_DELAY_STEP     134
+#define NVT_TX_DELAY_MASK       GENMASK(19, 16)
+#define NVT_RX_DELAY_MASK       GENMASK(23, 20)
+
+static int nvt_gmac_get_delay(struct device *dev, const char *property)
+{
+	u32 arg;
+
+	if (of_property_read_u32(dev->of_node, property, &arg))
+		return 0;
+
+	if (arg > 2000) {
+		dev_err(dev, "Invalid %s argument.\n", property);
+		return -EINVAL;
+	}
+
+	if (arg == 2000)
+		return 15;
+
+	return arg / NVT_PATH_DELAY_STEP;
+}
+
+static int nvt_gmac_setup(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	phy_interface_t phy_mode;
+	struct regmap *regmap;
+	u32 macid, miscr, reg;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
+	if (IS_ERR(regmap))
+		ret = dev_err_probe(dev, PTR_ERR(regmap), "Failed to get sys register\n");
+
+	if (macid > 1)
+		ret = dev_err_probe(dev, -EINVAL, "Invalid sys arguments\n");
+
+	if (of_get_phy_mode(pdev->dev.of_node, &phy_mode))
+		ret = dev_err_probe(dev, -EINVAL, "Missing phy mode property\n");
+
+	miscr = (macid == 0) ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		ret = nvt_gmac_get_delay(dev, "rx-internal-delay-ps");
+		if (ret < 0)
+			return ret;
+		reg = FIELD_PREP(NVT_RX_DELAY_MASK, ret);
+
+		ret = nvt_gmac_get_delay(dev, "tx-internal-delay-ps");
+		if (ret < 0)
+			return ret;
+		reg |= FIELD_PREP(NVT_TX_DELAY_MASK, ret);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		reg = NVT_MISCR_RMII;
+			break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unsupported phy-mode (%d)\n", phy_mode);
+	}
+
+	regmap_update_bits(regmap, miscr,
+			   NVT_RX_DELAY_MASK | NVT_TX_DELAY_MASK | NVT_MISCR_RMII, reg);
+
+	return 0;
+}
+
+static int nvt_gmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get platform resources\n");
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(dev, PTR_ERR(plat_dat), "Failed to get platform data\n");
+
+	ret = nvt_gmac_setup(pdev);
+	if (ret)
+		return ret;
+
+	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id nvt_dwmac_match[] = {
+	{ .compatible = "nuvoton,ma35d1-dwmac"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nvt_dwmac_match);
+
+static struct platform_driver nvt_dwmac_driver = {
+	.probe  = nvt_gmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name           = "nuvoton-dwmac",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = nvt_dwmac_match,
+	},
+};
+module_platform_driver(nvt_dwmac_driver);
+
+MODULE_AUTHOR("Joey Lu <a0987203069@gmail.com>");
+MODULE_DESCRIPTION("Nuvoton DWMAC specific glue layer");
+MODULE_LICENSE("GPL");
-- 
2.43.0


