Return-Path: <netdev+bounces-237540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3857C4CF4F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADC1D50088C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F033506C;
	Tue, 11 Nov 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PaPwpcvc"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FF320CD5;
	Tue, 11 Nov 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855784; cv=none; b=A3wbyCmjrYQqy55aB8lVeeKz6fYICcTS1/VFMg/kUbcT5jApa5KGWyzJstnI7UHGPPsPqMZKQM8OPatW4baawCGgky2kCBeMDIWcVluH012QmQljMmerS02MsBTAJ427E0HvRMDzUzTBxtZNucvqBAcwV2vVYAVzd/QR2ahtA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855784; c=relaxed/simple;
	bh=K8I2ed2sAJQRkbFMVe0WhFXDLLsmiiJi3ICw/89lxHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGf/fZLbF3gyQxS+0GcwmAnPDT+D7ZmCaNqKcYOzn2oXK9uwOo0weJFUcGNEpBaw/3drwmZFaGiZhuSGbgFCPCr1TimOGWTAzksE1nOpZchrytOX2NvrMUnIVpiKpK8qKN3ozTSa5+p8pY9VrJ1H0T7gaLKFORlFB4kZ/xseZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PaPwpcvc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DEB4922D5C;
	Tue, 11 Nov 2025 11:09:39 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4o2i52sTXEOt; Tue, 11 Nov 2025 11:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762855779; bh=K8I2ed2sAJQRkbFMVe0WhFXDLLsmiiJi3ICw/89lxHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PaPwpcvc5iztxYWFUDUg4p4n4aE/2/3FAAFTtrqkOZXc1VrvW1RSFeeHhWjVaYfbi
	 3lttzcS7Kdt1eU7epRbsihFQwYI/qcKxXkD8m2yptAR9jrKQUhn6fwRnyuYIwIrt9t
	 EdjnpTQY6/CUVFckZRY7R5d/7ll9Q8QXsl2vH8oPnvyO2zuxOkP7HSaBVGkqnBzNtg
	 h2HNfS73zCVXDsf6wstxy1Rab/9qzYGbkcVBf/IHVrTrIw7Xf7dxTM1uBM39jzhgG6
	 gAIzPXlVfQfjc4ecTZ7ETZsMDjZboO4UmDO5ACeFtEyDw+ZV3BiVxGoYn0drhDQp00
	 KpscxAZ3GODnw==
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
Subject: [PATCH net-next v4 1/3] net: stmmac: Add generic suspend/resume helper for PCI-based controllers
Date: Tue, 11 Nov 2025 10:07:26 +0000
Message-ID: <20251111100727.15560-3-ziyao@disroot.org>
In-Reply-To: <20251111100727.15560-2-ziyao@disroot.org>
References: <20251111100727.15560-2-ziyao@disroot.org>
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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  8 ++++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 4 files changed, 69 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 87c5bea6c2a2..1350f16f7138 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -349,6 +349,14 @@ config DWMAC_VISCONTI
 
 endif
 
+config STMMAC_LIBPCI
+	tristate "STMMAC PCI helper library"
+	depends on PCI
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


