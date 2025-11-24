Return-Path: <netdev+bounces-241202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE739C817C3
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6C7E34799B
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40637314B9D;
	Mon, 24 Nov 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IBwXedlT"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC8314B76;
	Mon, 24 Nov 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000303; cv=none; b=ZDdHwlDsEY/i4yWI/OIJdj9GEzIocs5YR8Jbgve9sYB7qINdT0DfKrN1BB8WSPKZ1E/i3uw15c06I/AOD9+KWBAYWJWmNufSB4nlOY7jDbwpMbQHW6fJkGe0I9yt1B+Eqglww2W6lKdap/EpsYx6D9VWoSHzgwcNJCwyElir7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000303; c=relaxed/simple;
	bh=lDiopGaJl8p8QgZVRajjL9Iy+vuq5EkNHhpIHS0SlTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDrS6yGy1Boy4BSC/ZEr3RCEbkF/T8kEC3tFufJxU4UpP1c1/O0Od2BshdpceIUCy3neY7XfnhgVGpZG0XoLkRSnN3KJjoxRiAe2FHYnocWQ+FNSXloawXlDZXvu6BtrftRDUmSM9Hby/QwXpoL7jvEI43va28reUYeftkCiXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IBwXedlT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 705082603F;
	Mon, 24 Nov 2025 17:04:58 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_bhM_6Na8oz; Mon, 24 Nov 2025 17:04:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764000289; bh=lDiopGaJl8p8QgZVRajjL9Iy+vuq5EkNHhpIHS0SlTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBwXedlTHZ0dNoRIYHJ8ZmE06xoF4ettZwGGmYaA8eGz3Bf7d9HEwd+NEQKQezFl4
	 yji/QMWT/m40omcbSSgSCoj3IzS1dbA9w/LUidg2VGIsdWeJ2IppUa1+bSLvOD442S
	 YTZZKZFsUM2dlnQM1olYwn+Nnj67d94kaaAiTfSJltFArL1vGnCDU+9ACLlIJnWbzL
	 oZfEhLTwHVBlHsksh4e6VWaVN1NukVFRkhmzcUH/aySed+sInzHuD/mEEIrkQ9vxs4
	 FaO4ixTgAcC0SxvoO5S6forZyMdjca8OVCaJgEGUkwAtDLkv9OU2P7atg4Hl7pNKv7
	 vyO3RLdwXpYhA==
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
	linux-kernel@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: [PATCH net-next v5 1/3] net: stmmac: Add generic suspend/resume helper for PCI-based controllers
Date: Mon, 24 Nov 2025 16:04:15 +0000
Message-ID: <20251124160417.51514-2-ziyao@disroot.org>
In-Reply-To: <20251124160417.51514-1-ziyao@disroot.org>
References: <20251124160417.51514-1-ziyao@disroot.org>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  5 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 4 files changed, 66 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 87c5bea6c2a2..15ed5c1d071a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -349,6 +349,11 @@ config DWMAC_VISCONTI
 
 endif
 
+config STMMAC_LIBPCI
+	tristate
+	help
+	  This option enables the PCI bus helpers for the stmmac driver.
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


