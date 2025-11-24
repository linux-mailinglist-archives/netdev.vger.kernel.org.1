Return-Path: <netdev+bounces-241203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B0C817C9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8145D4E74EE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1F315794;
	Mon, 24 Nov 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YuIvooqa"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A6313E37;
	Mon, 24 Nov 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000304; cv=none; b=nHFHVoMkB4PL8mTdyv+RgDc3ShHntoqZe2mW1WlqOFifRTnvZOI9YEPhKoEDlOv5oi/SFx6iFNfZgYZf2FEq9VYT5nZ0wRilYosHBjTafudDlagZovKj2/unM6TInm9a2THtbMNWXwEojmHwz8dKlPcKtWAvSO0g57UgZJjMs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000304; c=relaxed/simple;
	bh=KQ83MtFw7xXJmqjMZ4xm2jPserq3Dxyy1D566eYnZHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzSHhqhDPrhktTdl1rbhXZ5XzBhs1CMOcQYVAb/UfCPHn8U1uus4zLCqkb1E0cQ/JIR5NI0KvO3g58EMM/zlbFNbl3imlCPPnV6YyuzQM0Guxh/+ihY/nD5LJ9Yctr5nq0flh7b/mqRc+HMmVBelPlFqry7MrNchPSPAR0BgvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YuIvooqa; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7B55625F35;
	Mon, 24 Nov 2025 17:05:00 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xXmwFRLpA9q; Mon, 24 Nov 2025 17:04:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764000299; bh=KQ83MtFw7xXJmqjMZ4xm2jPserq3Dxyy1D566eYnZHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YuIvooqa4fgx+NFjVvFnZO72uh5gIlGD9LnRaWPRPmmKul7lh4YnO5xhXaQtx0B9Q
	 zeKPQJuJlO+kl6CEThPmMDw36VL97W0/A8DRIm4LhjHPYaU34Xb1S4Asrpe/40sOc6
	 e9utquRZBxdYFsr5KF/fFHxJF0BXaBGEQt8WOivjjV1sJ80tAKFo8eSGg7otW6mLwA
	 0b4tMPlWJKN4JJS31ExomjHD5JFw6C+y0hnP12UY2n4CNnPg8IxiXH6/ny70wiWZYQ
	 0th2nIXCzokbV9gFKBxdQbn86ZwKsejHMG1oJrXx2P8TNNj6fv8u1/sWn3P17KP8Z4
	 O9aQ6Z/WSiovQ==
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
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>
Subject: [PATCH net-next v5 2/3] net: stmmac: loongson: Use generic PCI suspend/resume routines
Date: Mon, 24 Nov 2025 16:04:16 +0000
Message-ID: <20251124160417.51514-3-ziyao@disroot.org>
In-Reply-To: <20251124160417.51514-1-ziyao@disroot.org>
References: <20251124160417.51514-1-ziyao@disroot.org>
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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Acked-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  3 +-
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 15ed5c1d071a..ad7ae3618099 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -367,8 +367,9 @@ config DWMAC_INTEL
 config DWMAC_LOONGSON
 	tristate "Loongson PCI DWMAC support"
 	default MACH_LOONGSON64
-	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
+	depends on (MACH_LOONGSON64 || COMPILE_TEST) && PCI
 	depends on COMMON_CLK
+	select STMMAC_LIBPCI
 	help
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 5f9472f47e35..107a7c84ace8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/of_irq.h>
 #include "stmmac.h"
+#include "stmmac_libpci.h"
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
@@ -502,37 +503,6 @@ static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioad
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
@@ -577,8 +547,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	plat->bsp_priv = ld;
 	plat->mac_setup = loongson_dwmac_setup;
 	plat->fix_soc_reset = loongson_dwmac_fix_reset;
-	plat->suspend = loongson_dwmac_suspend;
-	plat->resume = loongson_dwmac_resume;
+	plat->suspend = stmmac_pci_plat_suspend;
+	plat->resume = stmmac_pci_plat_resume;
 	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 
-- 
2.51.2


