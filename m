Return-Path: <netdev+bounces-234267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD295C1E576
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F46189BB2F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A42D3750;
	Thu, 30 Oct 2025 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kySlEFHe"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A02C21E8;
	Thu, 30 Oct 2025 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798025; cv=none; b=E93uG2eUVsZmKk2dy0aTlkdvl2pyXjiJnOcMUkAOc30LdFQZZuDnZ/RxquxI0ZGGWy036y3062sWsc6JPnMOvANNaheNGJ9sDkJsv/HsIENWuJXBhmHYYZUtFJpTFmzu2fVzIOv5HbyJzJDFG9AKZ/UKtl1womC7JWgO2rYiuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798025; c=relaxed/simple;
	bh=ecanBVZbeQeqsoKmcHaVdA4jHY+biqa4WJT8mJV1324=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcr/MCJxgn7FOmumReyfB1cqZWCJWFiWtFQQYBoZN9LQFubJsMiUr46eM82jEqIxshMcpXGLqJBzH+kAzMht79+I1W5sU73GPJ9hGgeyuNG7jhFJlVmop2sfSavdN1hqJWH15nB+xgI46GUNcC5YJPsmlSXvFmxXJ5nolhfIBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kySlEFHe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9D69925D25;
	Thu, 30 Oct 2025 05:20:21 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89qqx2VHsHf0; Thu, 30 Oct 2025 05:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761798021; bh=ecanBVZbeQeqsoKmcHaVdA4jHY+biqa4WJT8mJV1324=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kySlEFHeZT1I7AWj5ee50sW1B36cXrXGCUx1phKt+9V3mll+Ucl4tvDeeCqsdvh2m
	 AVq+JeVxulACFO8yOtVIw31VmWsu0i6lyWLQBBXoXrYAhd9IGNLupjS/Pg/MI78vAq
	 WBw5sqeX5B1Efo+VgMVm0btCV+7JCZtPElKgcKCK8ebnIybhIGWg6PTZaXpAEHRyEp
	 189B0IYfjRFrFuArONgUbNrXscnquD4YZkc9HpSmwahy5401q1os810KZsb4Vgjxge
	 L8fqx1sXfQedpzApMC7OTLvsIbDDCSMmlA3ZTHEdhmfMloNrkAsBhfro4d1C1q808n
	 vCdjUCMnN6hGw==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: stmmac: Add generic suspend/resume helper for PCI-based controllers
Date: Thu, 30 Oct 2025 04:19:14 +0000
Message-ID: <20251030041916.19905-2-ziyao@disroot.org>
In-Reply-To: <20251030041916.19905-1-ziyao@disroot.org>
References: <20251030041916.19905-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most glue driver for PCI-based DWMAC controllers utilize similar
platform suspend/resume routines. Add a generic implementation to reduce
duplicated code.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  9 ++++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 4 files changed, 70 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 87c5bea6c2a2..598bc56edd8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -349,6 +349,15 @@ config DWMAC_VISCONTI
 
 endif
 
+config STMMAC_LIBPCI
+	tristate "STMMAC PCI helper library"
+	depends on PCI
+	depends on STMMAC_ETH
+	default y
+	help
+	  This selects the PCI bus helpers for the stmmac driver. If you
+	  have a controller with PCI interface, say Y or M here.
+
 config DWMAC_INTEL
 	tristate "Intel GMAC support"
 	default X86
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 1681a8a28313..7bf528731034 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_DWMAC_VISCONTI)	+= dwmac-visconti.o
 stmmac-platform-objs:= stmmac_platform.o
 dwmac-altr-socfpga-objs := dwmac-socfpga.o
 
+obj-$(CONFIG_STMMAC_LIBPCI)	+= stmmac_libpci.o
 obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
 obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
 obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
new file mode 100644
index 000000000000..5c5dd502f79a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCI bus helpers for STMMAC driver
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#include <linux/device.h>
+#include <linux/pci.h>
+
+#include "stmmac_libpci.h"
+
+int stmmac_pci_plat_suspend(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	ret = pci_save_state(pdev);
+	if (ret)
+		return ret;
+
+	pci_disable_device(pdev);
+	pci_wake_from_d3(pdev, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stmmac_pci_plat_suspend);
+
+int stmmac_pci_plat_resume(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	pci_restore_state(pdev);
+	pci_set_power_state(pdev, PCI_D0);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stmmac_pci_plat_resume);
+
+MODULE_DESCRIPTION("STMMAC PCI helper library");
+MODULE_AUTHOR("Yao Zi <ziyao@disroot.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h
new file mode 100644
index 000000000000..71553184f982
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#ifndef __STMMAC_LIBPCI_H__
+#define __STMMAC_LIBPCI_H__
+
+int stmmac_pci_plat_suspend(struct device *dev, void *bsp_priv);
+int stmmac_pci_plat_resume(struct device *dev, void *bsp_priv);
+
+#endif /* __STMMAC_LIBPCI_H__ */
-- 
2.51.2


