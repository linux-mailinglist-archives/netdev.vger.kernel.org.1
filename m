Return-Path: <netdev+bounces-237542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D59C4CF95
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCBEC4FA5D4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289033893D;
	Tue, 11 Nov 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KDpXooBR"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAB2FA0F2;
	Tue, 11 Nov 2025 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855939; cv=none; b=pvXpVtO8ockjGktpEMQEiPSg9Qi4VYm4Q6yLSszKcIUnj91zRb6+2i80kOg6myL9sf0ofwCqfupg4fSJJ4Ez6ILh2R9Q1H2WdCXB2jf4gG+ROZr3xb+4qyFGaMxA6MaQqzR4kJqtW/TlJupvXYfEQtvqcYlGIH2btu1wVY71or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855939; c=relaxed/simple;
	bh=LCHX/wfRe9CKcFsuz7Pu8s850EnCtc98c9jrQFPMvAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfgchCqCp+uljfFBDIzZWUeM/Y/8Bfrr08YZuu3I2v9PGmbJmrc7ZByTSYb2+y4tiYEeXZFXuCrn/N+6G4gj/ZmQVS0ycKzbmDnTQEpgKgLmja8Pjg639mQmSU3b2pyxNbRVb4KtfrBFL0Q9b3Ro+q/EsDyYd/K3ABQGKpG09EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KDpXooBR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6646B20F5E;
	Tue, 11 Nov 2025 11:12:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4BEx6DDM4Qj; Tue, 11 Nov 2025 11:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762855935; bh=LCHX/wfRe9CKcFsuz7Pu8s850EnCtc98c9jrQFPMvAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KDpXooBRT56ng1Z2cMYOwY2SyurI0f0MspfeuAMlwOZlm/L6YiAO1tZWwP4JkVSHR
	 2boVGtLLW1vuC/OdB/F2mC+7ZMltattdbrDLbUIAOwPXyZxO86HHPy/pNNJGrzmCWm
	 goVss1N0Sp5Mt1MjwjUddaUehz467EX6ApN2VvQgCvdAWbm5XvFyC+e2auLa6mRFvX
	 lQdvcIcT6Du+6lnq8+/vs3gwrwp5hHBKZctRFJFKQbKW9OhqcLLUzfUzN2JNmf7a9J
	 3+ZP2G+Hok02F3+I0zbPlDqLD0me4vE9830x1LwA0XyGKAYrf/T11d8kAt4pWsbziP
	 lYvgv2Aa9defg==
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
Subject: [PATCH net-next v4 3/3] net: stmmac: pci: Use generic PCI suspend/resume routines
Date: Tue, 11 Nov 2025 10:11:58 +0000
Message-ID: <20251111101158.15630-1-ziyao@disroot.org>
In-Reply-To: <20251111100727.15560-2-ziyao@disroot.org>
References: <20251111100727.15560-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert STMMAC PCI glue driver to use the generic platform
suspend/resume routines for PCI controllers, instead of implementing its
own one.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++-----------------
 2 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index d2bff28fe409..00df980fd4e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -378,11 +378,8 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
-endif
-
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
-	depends on STMMAC_ETH && PCI
 	depends on COMMON_CLK
 	help
 	  This selects the platform specific bus support for the stmmac driver.
@@ -392,4 +389,7 @@ config STMMAC_PCI
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
+
+endif
+
 endif
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 94b3a3b27270..fa92be672c54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 
 #include "stmmac.h"
+#include "stmmac_libpci.h"
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
@@ -139,37 +140,6 @@ static const struct stmmac_pci_info snps_gmac5_pci_info = {
 	.setup = snps_gmac5_default_data,
 };
 
-static int stmmac_pci_suspend(struct device *dev, void *bsp_priv)
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
-static int stmmac_pci_resume(struct device *dev, void *bsp_priv)
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
 /**
  * stmmac_pci_probe
  *
@@ -249,8 +219,8 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	plat->safety_feat_cfg->prtyen = 1;
 	plat->safety_feat_cfg->tmouten = 1;
 
-	plat->suspend = stmmac_pci_suspend;
-	plat->resume = stmmac_pci_resume;
+	plat->suspend = stmmac_pci_plat_suspend;
+	plat->resume = stmmac_pci_plat_resume;
 
 	return stmmac_dvr_probe(&pdev->dev, plat, &res);
 }
-- 
2.51.2


