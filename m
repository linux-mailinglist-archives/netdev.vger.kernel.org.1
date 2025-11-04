Return-Path: <netdev+bounces-235517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6335DC31CB8
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF7E189B7D7
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BDB239E97;
	Tue,  4 Nov 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WrpeAfoi"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19B202C5C;
	Tue,  4 Nov 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269450; cv=none; b=PxuOOWZXzqc7FTa0c8NfNFHLKYE6SaYpdLH+oRHv5BHC+nSwLgRtE6QRIUiUnOC7Ciyp94LfPUVd22eDFJcm+TT4wBIGnOqybCfjSiwl3o+WrHKuGL07lFaMyp6OqQFQf22/q6yNmhwmcti1NPjXS4gvz/Umb+Fdw/n+A3JUnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269450; c=relaxed/simple;
	bh=X1/6Xk+r37L1BEB0kWKL8MILdGHdA0/JEUGijrIi0KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+I3ifjaJUXX75H0/NOxBgCk9GNjx1z/5kaqk6cXmnO1HgnOQ57UdhEAm+mxhsskQG+APpXgX853H0RIouea9VS3nGDT0rwXOivO12Mbx1mIyzhQKSrL6WevVD9igZ1/lz8KR+ExW9mawSrnIMMxns2ogIDoktLzpaqKmqb0g24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WrpeAfoi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4CE2F2624C;
	Tue,  4 Nov 2025 16:17:26 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9cin3ma4C6I; Tue,  4 Nov 2025 16:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762269445; bh=X1/6Xk+r37L1BEB0kWKL8MILdGHdA0/JEUGijrIi0KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrpeAfois28NdLClwidKC7UF6OyolitvwoUD9UenIFXZpFuUkU4uNmt6LwuMg6Jj/
	 JXtBVwHuSnaN+ZkVSLYDdOYYzdx9QdHO4UyGwUqXhxqWoB+4kH+V4LEBtD/vH36L6y
	 3IPINS+iyujPnGyThUvyJJUcGIn/0t5754IrySC12HjiYgxhCEoKk5Qj4P6/lH5IJj
	 yOyPjL+jMLHKeNNd3EHQ9bDGC2W5mf6FKAEb2BLqVBZbNQ3Sk9Q7jjAKuxD/Z4wQv1
	 jlWXmiPv4jVyDu9Mk9L1ubD4Mok+Es/t8jBSY+IlSumi/YIzJNQPD5zcffYe71QjCf
	 xfo8Z43Y4mNyg==
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
Subject: [PATCH net-next v3 1/3] net: stmmac: Add generic suspend/resume helper for PCI-based controllers
Date: Tue,  4 Nov 2025 15:16:45 +0000
Message-ID: <20251104151647.3125-2-ziyao@disroot.org>
In-Reply-To: <20251104151647.3125-1-ziyao@disroot.org>
References: <20251104151647.3125-1-ziyao@disroot.org>
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


