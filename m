Return-Path: <netdev+bounces-234268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC2C1E579
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A9B189BA55
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7252F39CC;
	Thu, 30 Oct 2025 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="T4tZDlWH"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236992ECEAE;
	Thu, 30 Oct 2025 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798031; cv=none; b=GmvJZmQ4IJorN8w8LzMLfjrkxIFv87fYmsGGiaONIvc1nT1SRZzJw7IqUPJ1nH9qQt1w2B8SUYWW+wQ7zESETFZTXCUIffdGCXA3IXAwut+zz7Zi4zfHmAw8zsR3s1scBrdOvU85Mh9srwdjLe6VZ1Dk2EJfm52w8RXN5xPcinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798031; c=relaxed/simple;
	bh=44Zt9W/bC9x5iLI09BjyMHjk9QtDms/2NPbHRbAgGqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9vZfxuOoMjPdUcjx66r0y6hZoekZKd/S2MSwu4Vb58n4OR7S3WxWYwG8N1yfRpNG9NUK6jd1D4Ex/uGl5qS7rM+ayJMjW4Id++HEE+RSehOSJfFyC8AIKnTTK3j7lcFr/+tgJE9HwoAzbVmAPbEkkEboswk0pf1wdonjfH+gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=T4tZDlWH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 97F6725DC2;
	Thu, 30 Oct 2025 05:20:27 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TIPh9HpXZRR8; Thu, 30 Oct 2025 05:20:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761798027; bh=44Zt9W/bC9x5iLI09BjyMHjk9QtDms/2NPbHRbAgGqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4tZDlWHEls7KUmbSDupeH6YpvlQYq5mcauHAZI3eGG+T5qLzJbooBLEczuvQgoF2
	 47NX3FoWkZo1EDHuzK/Mdf5l/ZCqazpSfu2PHESdDsUW9xreBXL2tw7BdufFD55Iuj
	 xC34EyUJvGqe2y4/jsnpwQ9zCzCjIIkb2qUuBl6EAIfd4EELpp8o75sSCed9r40cjO
	 ucGnUHsk238hOazuZKVHrRkeQNMwUcHnlb1ruImEUTYMqSnlkwCje5WNU4ekE0+9Os
	 lbET+m6JGgvtTFEEAOWjrnBq9agmwmkB7gJAKljY4svt4HbsfRfCPMvw0QXVHJ4tZS
	 OIuKt4Uwt3fMw==
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
Subject: [PATCH net-next v2 2/3] net: stmmac: loongson: Use generic PCI suspend/resume routines
Date: Thu, 30 Oct 2025 04:19:15 +0000
Message-ID: <20251030041916.19905-3-ziyao@disroot.org>
In-Reply-To: <20251030041916.19905-1-ziyao@disroot.org>
References: <20251030041916.19905-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert glue driver for Loongson DWMAC controller to use the generic
platform suspend/resume routines for PCI controllers, instead of
implementing its own one.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 598bc56edd8d..4b6911c62e6f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -373,6 +373,7 @@ config DWMAC_LOONGSON
 	default MACH_LOONGSON64
 	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
 	depends on COMMON_CLK
+	depends on STMMAC_LIBPCI
 	help
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2a3ac0136cdb..584dc4ff8320 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/of_irq.h>
 #include "stmmac.h"
+#include "stmmac_libpci.h"
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
@@ -525,37 +526,6 @@ static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioad
 				  10000, 2000000);
 }
 
-static int loongson_dwmac_suspend(struct device *dev, void *bsp_priv)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-
-	ret = pci_save_state(pdev);
-	if (ret)
-		return ret;
-
-	pci_disable_device(pdev);
-	pci_wake_from_d3(pdev, true);
-	return 0;
-}
-
-static int loongson_dwmac_resume(struct device *dev, void *bsp_priv)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-
-	pci_restore_state(pdev);
-	pci_set_power_state(pdev, PCI_D0);
-
-	ret = pci_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	pci_set_master(pdev);
-
-	return 0;
-}
-
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
@@ -600,8 +570,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
 	plat->fix_soc_reset = loongson_dwmac_fix_reset;
-	plat->suspend = loongson_dwmac_suspend;
-	plat->resume = loongson_dwmac_resume;
+	plat->suspend = stmmac_pci_plat_suspend;
+	plat->resume = stmmac_pci_plat_resume;
 	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 
-- 
2.51.2


