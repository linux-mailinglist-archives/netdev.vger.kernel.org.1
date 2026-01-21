Return-Path: <netdev+bounces-251787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JoVOPt8cGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:15:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460C52AC0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7DE94EFDAB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839144DB97;
	Wed, 21 Jan 2026 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX2PIPL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8444D68C
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979630; cv=none; b=DT0LbmlnuxGVyCTt638cbF0Mf0PeuvFUqYvRvn+OQ7aNYc035H4EQ6XVYejuuGPfZIaUq+dt4huZ7MeX9vIZNBl2t80HZXlbqFyCMrwA0RHPqZIAphZtira8dZjhrgT0e/xhH62o50yONjGZDQWqI4+F0JyTOuq3Ap/LlC7chnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979630; c=relaxed/simple;
	bh=22KVXf7BsLEd9shoPoNSDYsXDbTxIem3O0CTDWMSsqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkzUtR5qwg4RarCX8WCH9X9ofpF6TrRXPEJM6YFpAmmrYoWbWZCAi3oo4Fo2uPAmX2DJ99lWsyA46nGWsLFh21WnR3PybhIpbkDFCB9nTR8Xr41Oj5AlEwhbuhjkXT+mwETxrZnIXQeeUdl5fm68YaVKlGqaKpeuSq4ZUmd9Be8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX2PIPL3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1232d9f25e9so39954c88.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768979620; x=1769584420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5QOmoL1No8TYm8M5X91IziuCiWq9EqJU0I5uGvwg5k=;
        b=jX2PIPL3ax1v9A+WrUmC4CdT4rpelCWV0R9ZPotBly4ccgt93cNVXN2u34guT/fNkF
         N2EIPzys58e7ZvkYQkMsQWYMCQgg72kbccESGUn0cCrIL8pnoNl1D3qp7jLJGzvkOG8u
         dgPO/DQLXxJB3cNlNocf/dNW6GQa9xDv5C/XTITgrIWM6KWPm5zMo6dIEQspcFvGPVqR
         vR6tZ2yBwYugKWGrFpf3UCGKoWE0LdzWzYQnG4Ud5O0Ujb0hX1T1JkRjGLGnNplZp1ip
         ViVxKnHjufoC1+BVDBrZyu61CLD0OxfvrnyZ6GutLz3K6izDNc+Yo0VJXWYgIwnEbV9Y
         qFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768979620; x=1769584420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5QOmoL1No8TYm8M5X91IziuCiWq9EqJU0I5uGvwg5k=;
        b=PMZuYLkalZ38JhCgj+zZWffsRsGGUMCw9w+qXiKjLC8hheZJnth/YEXNpczJTuJ43w
         QQu+PtiiTFdwX6KvKL2cwalAbyArBftBQdMdI2hxyu0nzhHgF+2GeIE8cAIIHYBlHgsz
         L0loWMKuomItqFIVRP8Vs90Wx/HjdYo9Ws73aVWbRPgGrF8GnE66UP519hN4sQsMCzIu
         Ll5zKjnHH/iR02bJWyXENfmJ+LERR3ZlRmBCY448njjo0h7iu9lDcPMclJf9fvY2wBvr
         w2PUJs+Jb7+ivfNXug06qKYKvdEAPglO4+VaLh+vk6ogL4jGzlc/+63H+y74gLnRe3GC
         +Shw==
X-Gm-Message-State: AOJu0Yx90+dluuuKujrhvbsYqCFmZBbQJ011DEVyZteYwy6PU+ZE1kE9
	vJ3zYJz2fZbLpfW/tAy3JCwZ4TZOPbZNvqsINsK3A5bmlDxJzNx8kAZe
X-Gm-Gg: AZuq6aLncCTQdL/IPKxVM75HTahoWBbOw5FHcSSVrKBTEsYZYjTxsYmH0a7zDeQCFPi
	r6gFd+wyYnJWFWWRdtiTo/Ql/vJvi4+Mj9d6XbFCfWahLZlpDjAJxnfe1yBtepdl5/+C18KSX/q
	I6Fv7GUHi5TVXmunLhRTQ5L8O0JFrEWsLhPRrSXKC/j9ep8virVAiYyJrTFpXOrwdIOXBdOMZ5W
	uJavNXxmW8BD0U9jlN+cEGu5ukMU5gCVYBg+VKFuWdyKh3LRxZBUyeOXHLZ81QogEe3VJ+bV415
	NXWntKhhoMXe2ahcwXQ/l2CJF/mwTx61zqo6q4qXvstosl2S39FSLaOBsv31ycyB211WWDl7Nwb
	oT3H9zw7a6krtPBZVf1m5j9d7kKVpnmTTPDOOSPQShA4UKt+F3XivYIyh8Nq+CDWDDkIj6Jqh9b
	6KjL2fvg+nUg==
X-Received: by 2002:a05:7022:6b86:b0:11a:fe6f:806a with SMTP id a92af1059eb24-1244a769e0emr11872529c88.31.1768979620027;
        Tue, 20 Jan 2026 23:13:40 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm25240654c88.10.2026.01.20.23.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:13:39 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <ziyao@disroot.org>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
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
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 3/3] net: stmmac: Add glue layer for Spacemit K3 SoC
Date: Wed, 21 Jan 2026 15:13:11 +0800
Message-ID: <20260121071315.940130-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121071315.940130-1-inochiama@gmail.com>
References: <20260121071315.940130-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251787-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,disroot.org,cqsoftware.com.cn,nxp.com,bp.renesas.com,linux.intel.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9460C52AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The etherenet controller on Spacemit K3 SoC is Synopsys DesignWare
MAC (version 5.40a), with the following special point:
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
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 221 ++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 907fe2e927f0..583a4692f5da 100644
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
index 7bf528731034..9e32045631d8 100644
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
index 000000000000..ca600c068aaa
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -0,0 +1,221 @@
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
+#define PHY_INTF_RGMII			BIT(3)
+#define PHY_INTF_MII			BIT(4)
+
+#define WAKE_IRQ_EN			BIT(9)
+#define PHY_IRQ_EN			BIT(12)
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
+
+/* Note: the delay step value is at 0.1ps */
+static const unsigned int k3_delay_step_10x[4] = {
+	367, 493, 559, 685
+};
+
+static int spacemit_dwmac_set_delay(struct regmap *apmu,
+				    unsigned int dline_offset,
+				    unsigned int tx_code, unsigned int tx_config,
+				    unsigned int rx_code, unsigned int rx_config)
+{
+	unsigned int mask, val;
+
+	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
+	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
+	val = FIELD_PREP(RGMII_TX_DLINE_STEP, tx_config) |
+	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
+	      FIELD_PREP(RGMII_RX_DLINE_STEP, rx_config) |
+	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
+
+	return regmap_update_bits(apmu, dline_offset, mask, val);
+}
+
+static int spacemit_dwmac_detected_delay_value(unsigned int delay,
+					       unsigned int *config)
+{
+	unsigned int best_delay = 0;
+	unsigned int best_config = 0;
+	int best_code = 0;
+	int i;
+
+	if (delay == 0)
+		return 0;
+
+	if (delay > MAX_WORKED_DELAY)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
+		unsigned int step = k3_delay_step_10x[i];
+		int code = DIV_ROUND_CLOSEST(delay * 10 * 10, step * 9);
+		unsigned int tmp = code * step * 9 / 10 / 10;
+
+		if (abs(tmp - delay) < abs(best_delay - delay)) {
+			best_code = code;
+			best_delay = tmp;
+			best_config = i;
+		}
+	}
+
+	*config = best_config;
+
+	return best_code;
+}
+
+static int spacemit_dwmac_fix_delay(struct plat_stmmacenet_data *plat_dat,
+				    struct regmap *apmu,
+				    unsigned int dline_offset,
+				    unsigned int tx_delay, unsigned int rx_delay)
+{
+	bool mac_rxid = rx_delay != 0;
+	bool mac_txid = tx_delay != 0;
+	unsigned int rx_config = 0;
+	unsigned int tx_config = 0;
+	int rx_code;
+	int tx_code;
+
+	plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+								  mac_txid,
+								  mac_rxid);
+
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+		return -EINVAL;
+
+	rx_code = spacemit_dwmac_detected_delay_value(rx_delay, &rx_config);
+	if (rx_code < 0)
+		return rx_code;
+
+	tx_code = spacemit_dwmac_detected_delay_value(tx_delay, &tx_config);
+	if (tx_code < 0)
+		return tx_code;
+
+	return spacemit_dwmac_set_delay(apmu, dline_offset,
+					tx_code, tx_config,
+					rx_code, rx_config);
+}
+
+static int spacemit_dwmac_update_ifconfig(struct plat_stmmacenet_data *plat_dat,
+					  struct stmmac_resources *stmmac_res,
+					  struct regmap *apmu,
+					  unsigned int ctrl_offset)
+{
+	unsigned int mask = PHY_INTF_MII | PHY_INTF_RGMII | WAKE_IRQ_EN;
+	unsigned int val = 0;
+
+	switch (plat_dat->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		val = PHY_INTF_MII;
+		break;
+
+	case PHY_INTERFACE_MODE_RMII:
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = PHY_INTF_RGMII;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (stmmac_res->wol_irq >= 0)
+		val |= WAKE_IRQ_EN;
+
+	return regmap_update_bits(apmu, ctrl_offset, mask, val);
+}
+
+static int spacemit_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	unsigned int offset[2];
+	struct regmap *apmu;
+	u32 rx_delay = 0;
+	u32 tx_delay = 0;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get platform resources\n");
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "failed to parse DT parameters\n");
+
+	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
+	if (IS_ERR(plat_dat->clk_tx_i))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
+				     "failed to get tx clock\n");
+
+	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node, "spacemit,apmu", 2, offset);
+	if (IS_ERR(apmu))
+		return dev_err_probe(dev, PTR_ERR(apmu),
+				"Failed to get apmu regmap\n");
+
+	ret = spacemit_dwmac_update_ifconfig(plat_dat, &stmmac_res,
+					     apmu, offset[0]);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure ifconfig\n");
+
+	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps", &tx_delay);
+	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps", &rx_delay);
+
+	ret = spacemit_dwmac_fix_delay(plat_dat, apmu, offset[1], tx_delay, rx_delay);
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
2.52.0


