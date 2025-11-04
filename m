Return-Path: <netdev+bounces-235518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97391C31CD6
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1B8420B53
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0524888A;
	Tue,  4 Nov 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="W5+ISS6B"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AA239E97;
	Tue,  4 Nov 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269458; cv=none; b=czGafy45iKUF1SlpAoyvVuOcbplRepCa/kS78BNNmanzNCskIX7d8O3vMu9CEvGb6ubz5+YHMXNtWDOztuTMgxo/PiK23Eum1ATNoQ+x+VI7iKWTFi1vXBWuZcPmyk0mrcK7UyPvvCWAg/YnJzxFa6ajw9tRi2geCxyThaEga4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269458; c=relaxed/simple;
	bh=HFWNC322p9MDNILlse/9+tk0gmWbj3GRTnHZZzpy53c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYtXtskvGCS7x3/oL3J5WWroY/R7Pq+1dSUWvP2D6p7ExoyoAJbuoFck7tV4CfCFCZepFURCfUbSxt7L+FZz/oQkqQmVxo/uVl2TqkZfdlINU+PdJtJgbhsbYXRfjvQS314lXSHO7/2+ALkhLAt0wxHqEnmQAP0sGuP5gnZaQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=W5+ISS6B; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 82FB420EF2;
	Tue,  4 Nov 2025 16:17:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tb92WTFfUfMD; Tue,  4 Nov 2025 16:17:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762269454; bh=HFWNC322p9MDNILlse/9+tk0gmWbj3GRTnHZZzpy53c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W5+ISS6Bb/sAD6fKIM3QYmL6uvkSBeM1y0XhLd4W5Xrbg5RGkOfzX2OVqvbGBuULb
	 ML1NVrapw+QesEQ5/kbTWiHb4fC5bU5lOLT3llkTghVrCWhVJKTRRxQL64B1PD7Rbu
	 WgUAWz6hK103nl2/L46a0iSb7iaa25CucvwzaBWQftPQpXjc/N+bpLJLUZDBtciu0j
	 vUshUkkIB3Qe8ZHWpwrjcNZlZrZEF8UIp4ZvEltKzfPUgXW273sKRgpZUROujVFbs7
	 He+ea4kuzVKFmXbwLrrAxm2CYkO3fyFcpFCzd/CmkX8z+N5RzjIEfbwdcA+Cc0ANo4
	 ikqu8XFh0D0+g==
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
Subject: [PATCH net-next v3 2/3] net: stmmac: loongson: Use generic PCI suspend/resume routines
Date: Tue,  4 Nov 2025 15:16:46 +0000
Message-ID: <20251104151647.3125-3-ziyao@disroot.org>
In-Reply-To: <20251104151647.3125-1-ziyao@disroot.org>
References: <20251104151647.3125-1-ziyao@disroot.org>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  4 +++
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
 2 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 1350f16f7138..7ec7c7630c41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -367,6 +367,8 @@ config DWMAC_INTEL
 	  This selects the Intel platform specific bus support for the
 	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
 
+if STMMAC_LIBPCI
+
 config DWMAC_LOONGSON
 	tristate "Loongson PCI DWMAC support"
 	default MACH_LOONGSON64
@@ -376,6 +378,8 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
+endif
+
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
 	depends on STMMAC_ETH && PCI
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


