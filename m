Return-Path: <netdev+bounces-261755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KGDFAFPoWkfsAQAu9opvQ
	(envelope-from <netdev+bounces-261755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:00:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AA1B430D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C18B303A8E3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8236C0B1;
	Fri, 27 Feb 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncrApLmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883953603C7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179079; cv=none; b=Qzh55CS8Snb+TJptxN5RdTxDkr9H8E9snX7N8M/yGMIp2MVz0bhUv34a4WVj47o06XggEn9IPoGqAS3UpBz7r3POzaGMT07+U8PzTU44TWjWMhnie2oHcH4SE7bO67uPD5YRxyLxx0cqw05og1/WQI9TYa2pd7F7Y6aZTdysPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179079; c=relaxed/simple;
	bh=cJmuaHpRFasO4c39CCQM9qC+UZIlc1JGn9k+mbjF/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcyrXxfhjsvWVkWJvDtxwcmclqL4cY4YmZL2a/i9xmLPB8jcJsJgwaYMvPt23pQbw4rGUbYtxfNezveaV4F0Q58E7uVgMdsyEfqm5GmTq9+3KnAOSLEfmnmSIHoLWX/XvZzhjjx9zg3Qw8QcE/vXxW5hREKUV0HzmhRNNO6FnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncrApLmx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a9296b3926so14069695ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 23:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772179076; x=1772783876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUNULMmwdum00iUKyIYcf0vAicviTulyJEtlt3p+XxI=;
        b=ncrApLmxM7Fj5G+/L1oRkMa34W4Q6vUt309PFvdvq4rIIIXLrezWcntUHYy+6BCCGA
         vcGAG4xNUOaMDT7nDmzXhX3/t0uF382W1AoxcpcrANhA37J4HpfPqywXKsMKod4hZnCB
         vl6e4aOm/5VsT+iIJakqWrAE+i/fnyJ477XhHoKbGUlOycyggokEUJnP+KkNwUMxzaUI
         FQabW6/vsttZi4D91NKpOFgvjLXc8AHmf/tucnfBO6n1a0vnyedqyWHaDG1Jh3TUZ/BL
         saDhN1D+d1Qj28VkNbq22+tkiinoVF+wEL3Rimn3LewjEgnr8mD/SNcHEY7aAYU9wpHV
         fCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772179076; x=1772783876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUNULMmwdum00iUKyIYcf0vAicviTulyJEtlt3p+XxI=;
        b=LUuvu4hqx+epBuodszq4oTLlTFTBY+bsEPr7ZQi4KioOsD/fhpinlZ0LxoHWCewGam
         gZo9Kexhc4lP1SlHgvvGCcD+AzRQ2EBVyWogHhCrZeDJtCH8j81jtRGYj4R3Bn6z+o+N
         Khr1RuCQ430+IH/QSm+HcPCJ6K58ERNU92x25nj2D04lB9TajyyXgGKkUvkSr0QDkVEk
         cBTyWhdaZnqJEb1hQinkZFWTt4X7JTOvBvnLcpng5o1EkSUMOJd4yb1HwoDjec8RPhZU
         TWa/lacXqCLV+M0rTgctbe5wzy58KpfoEhzZPxCA7WI1ys+1ahswXTQQ2fH7CVfzSzet
         S1Og==
X-Gm-Message-State: AOJu0YwbtuHAruP3b4XXqfFJh77TcVCybZw/9ctmD3RWwdCrQeERP7W2
	Rn+IZVnBq4Jd9hemaxv5NL5Hb4tL/YmhFVQkNxq/gJtsyk9fbF+U16ge
X-Gm-Gg: ATEYQzxZZK1foGHesAptZDtrFuS3I1g0L2hGj0kB+ANeuJ2U1yIKCrA4SkrIU3SDNl/
	rBlNFShlQx9H073jj3PU/07XHxW6Rl5l0V6i4AH5TT3oXYhnfXdngWRZBXLllQ85V6qaMz2NNQ7
	NgCdi2SsjYwzGkIS6k7MYdCTXSvGs8w9xa8yTA9stc1cIsgCzlnJL3Eqcjzmb1JIHLKvRsHt5FS
	/baEb1RC2qs7zv67EOeZM4HYSe31gw4kL316z5N9b90FKzyV5AGm3osQdUld3gfb5ljsxeBlpau
	KWhkiccd9FfYhoQUtzkHYFtJl+QfaCmrcPXSLJVaYQABHgYHHlU0TZyuvXprAYWm0BH54dlVgrN
	JxBsA/tX9xT49+63VJ3cpEI5ISnXnQsgB8FMmQ4N8JF61xiEzPdi2dNIZskyxTCwN0XtQYP/Vtg
	7uC7PyM6G/iAqOnm/X5BTyhw==
X-Received: by 2002:a17:903:15c7:b0:2aa:f098:f9d6 with SMTP id d9443c01a7336-2ae2e3f7634mr19168775ad.43.1772179075793;
        Thu, 26 Feb 2026 23:57:55 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b3889sm50080525ad.16.2026.02.26.23.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:57:55 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <me@ziyao.cc>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Spacemit K3 SoC
Date: Fri, 27 Feb 2026 15:57:17 +0800
Message-ID: <20260227075718.2243818-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227075718.2243818-1-inochiama@gmail.com>
References: <20260227075718.2243818-1-inochiama@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261755-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,linux.intel.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D3AA1B430D
X-Rspamd-Action: no action

The ethernet controller on Spacemit K3 SoC is Synopsys DesignWare
MAC (version 5.40a), with the following special points:
1. The rate of the tx clock line is auto changed when the mac speed
   rate is changed, and no need for changing the input tx clock.
2. This controller require a extra syscon device to configure the
   interface type, enable wake up interrupt and delay configuration
   if needed.

Add Spacemit dwmac driver support on the Spacemit K3 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 226 ++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 07088d03dbab..d3a6ab7383fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -216,6 +216,18 @@ config DWMAC_SOPHGO
 	  for the stmmac device driver. This driver is used for the
 	  ethernet controllers on various Sophgo SoCs.
 
+config DWMAC_SPACEMIT
+	tristate "Spacemit dwmac support"
+	depends on OF && (ARCH_SPACEMIT || COMPILE_TEST)
+	select MFD_SYSCON
+	default m if ARCH_SPACEMIT
+	help
+	  Support for ethernet controllers on Spacemit RISC-V SoCs
+
+	  This selects the Spacemit platform specific glue layer support
+	  for the stmmac device driver. This driver is used for the
+	  Spacemit K3 ethernet controllers.
+
 config DWMAC_STARFIVE
 	tristate "StarFive dwmac support"
 	depends on OF && (ARCH_STARFIVE || COMPILE_TEST)
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c9263987ef8d..945c5354eced 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
 obj-$(CONFIG_DWMAC_S32)		+= dwmac-s32.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
 obj-$(CONFIG_DWMAC_SOPHGO)	+= dwmac-sophgo.o
+obj-$(CONFIG_DWMAC_SPACEMIT)	+= dwmac-spacemit.o
 obj-$(CONFIG_DWMAC_STARFIVE)	+= dwmac-starfive.o
 obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
 obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
new file mode 100644
index 000000000000..a12fb3cbd1bc
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Spacemit DWMAC platform driver
+ *
+ * Copyright (C) 2026 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include "stmmac_platform.h"
+
+/* ctrl register bits */
+#define CTRL_PHY_INTF_RGMII		BIT(3)
+#define CTRL_PHY_INTF_MII		BIT(4)
+#define CTRL_WAKE_IRQ_EN		BIT(9)
+#define CTRL_PHY_IRQ_EN			BIT(12)
+
+/* dline register bits */
+#define RGMII_RX_DLINE_EN		BIT(0)
+#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
+#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
+#define RGMII_TX_DLINE_EN		BIT(16)
+#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
+#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
+
+#define MAX_DLINE_DELAY_CODE		0xff
+#define MAX_WORKED_DELAY		2800
+/* Note: the delay step value is at 0.1ps */
+#define K3_DELAY_STEP			367
+
+struct spacmit_dwmac {
+	struct regmap *apmu;
+	unsigned int ctrl_offset;
+	unsigned int dline_offset;
+};
+
+static int spacemit_dwmac_set_delay(struct spacmit_dwmac* dwmac,
+				    unsigned int tx_code, unsigned int rx_code)
+{
+	unsigned int mask, val;
+
+	mask = RGMII_TX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
+	       RGMII_RX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
+
+	/*
+	 * Since the delay step provided by config 0 is small enough, and
+	 * it can cover the range of the valid delay, so there is no needed
+	 * to use other step config.
+	 */
+	val = FIELD_PREP(RGMII_TX_DLINE_STEP, 0) |
+	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
+	      FIELD_PREP(RGMII_RX_DLINE_STEP, 0) |
+	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
+
+	return regmap_update_bits(dwmac->apmu, dwmac->dline_offset,
+				  mask, val);
+}
+
+static int spacemit_dwmac_detected_delay_value(unsigned int delay)
+{
+	if (delay == 0)
+		return 0;
+
+	if (delay > MAX_WORKED_DELAY)
+		return -EINVAL;
+
+	/*
+	 * Note K3 require a specific factor for calculate
+	 * the delay, in this scenario it is 0.9. So the
+	 * formula is code * step / 10 * 0.9
+	 */
+	return DIV_ROUND_CLOSEST(delay * 10 * 10, K3_DELAY_STEP * 9);
+}
+
+static int spacemit_dwmac_fix_delay(struct spacmit_dwmac* dwmac,
+				    struct plat_stmmacenet_data *plat_dat,
+				    unsigned int tx_delay,
+				    unsigned int rx_delay)
+{
+	int rx_code;
+	int tx_code;
+
+	rx_code = spacemit_dwmac_detected_delay_value(rx_delay);
+	if (rx_code < 0)
+		return rx_code;
+
+	tx_code = spacemit_dwmac_detected_delay_value(tx_delay);
+	if (tx_code < 0)
+		return tx_code;
+
+	return spacemit_dwmac_set_delay(dwmac, tx_code, rx_code);
+}
+
+static int spacemit_dwmac_update_irq_config(struct spacmit_dwmac *dwmac,
+					    struct stmmac_resources *stmmac_res)
+{
+	unsigned int mask = CTRL_WAKE_IRQ_EN;
+	unsigned int val = stmmac_res->wol_irq >= 0 ? CTRL_WAKE_IRQ_EN : 0;
+
+	return regmap_update_bits(dwmac->apmu, dwmac->ctrl_offset,
+				  mask, val);
+}
+
+static void spacemit_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
+				    unsigned long *interfaces)
+{
+	__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+	__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
+	phy_interface_set_rgmii(interfaces);
+}
+
+static int spacemit_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
+{
+	struct spacmit_dwmac *dwmac = bsp_priv;
+	unsigned int mask = CTRL_PHY_INTF_MII | CTRL_PHY_INTF_RGMII;
+	unsigned int val = 0;
+
+	switch (phy_intf_sel) {
+	case PHY_INTF_SEL_GMII_MII:
+		val = CTRL_PHY_INTF_MII;
+		break;
+
+	case PHY_INTF_SEL_RMII:
+		break;
+
+	case PHY_INTF_SEL_RGMII:
+		val = CTRL_PHY_INTF_RGMII;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(dwmac->apmu, dwmac->ctrl_offset,
+				  mask, val);
+}
+
+static int spacemit_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	struct spacmit_dwmac *dwmac;
+	unsigned int offset[2];
+	struct regmap *apmu;
+	struct clk *clk_tx;
+	u32 rx_delay = 0;
+	u32 tx_delay = 0;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get platform resources\n");
+
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
+	if (!dwmac)
+		return -ENOMEM;
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "failed to parse DT parameters\n");
+
+	clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
+	if (IS_ERR(clk_tx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk_tx),
+				     "failed to get tx clock\n");
+
+	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node, "spacemit,apmu", 2, offset);
+	if (IS_ERR(apmu))
+		return dev_err_probe(dev, PTR_ERR(apmu),
+				"Failed to get apmu regmap\n");
+
+	dwmac->apmu = apmu;
+	dwmac->ctrl_offset = offset[0];
+	dwmac->dline_offset = offset[1];
+
+	ret = spacemit_dwmac_update_irq_config(dwmac, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure irq config\n");
+
+	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps",
+			     &tx_delay);
+	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps",
+			     &rx_delay);
+
+	plat_dat->get_interfaces = spacemit_get_interfaces;
+	plat_dat->set_phy_intf_sel = spacemit_set_phy_intf_sel;
+	plat_dat->bsp_priv = dwmac;
+
+	ret = spacemit_dwmac_fix_delay(dwmac, plat_dat, tx_delay, rx_delay);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure delay\n");
+
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id spacemit_dwmac_match[] = {
+	{ .compatible = "spacemit,k3-dwmac" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spacemit_dwmac_match);
+
+static struct platform_driver spacemit_dwmac_driver = {
+	.probe  = spacemit_dwmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name = "spacemit-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = spacemit_dwmac_match,
+	},
+};
+module_platform_driver(spacemit_dwmac_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@gmail.com>");
+MODULE_DESCRIPTION("Spacemit DWMAC platform driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0


