Return-Path: <netdev+bounces-234269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B15C1E585
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49FB3A6A41
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DD2E1EEE;
	Thu, 30 Oct 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PcX4/nya"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF92DE71C;
	Thu, 30 Oct 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798079; cv=none; b=XwLjGtE0pxKig8GgB/bSKXXN4umQ0Tj2vLu7AsH7v/SEaI6suXEt3cziA+5VSKmESSkjjIJtyflpTb4aUeRq9BK83ofxGzzmr2EZw9Y3agMR51E3etC9cvLRi509/bppzj99SJmu7vK1mUwvDNBxYuaxicMkzBz5yzR1xPNqvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798079; c=relaxed/simple;
	bh=1vIFpVbedqamb3ASDWpY+TrxMjREjHQZhgAacjsYZ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ2t8IWi4ZK2JoCa2qMNhB0I8ox5WaWlf6RmnVoBDdip2aZAf66TU4K95Ua+GpFOHyNUWvut1DVI/putBqqj+OEH65tljIXfq0JeZB12fJjDs8IZSHVi2mKjqTBdAXCbNEVRek5cxjmiV3t96Oo97zC1/jze4JFSoeBTaeV3FpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PcX4/nya; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1947E25DB3;
	Thu, 30 Oct 2025 05:21:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lg8HJ_cZthlt; Thu, 30 Oct 2025 05:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761798075; bh=1vIFpVbedqamb3ASDWpY+TrxMjREjHQZhgAacjsYZ4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcX4/nya2QcIqiqZGEB0LMqN4+S1FbX0w/PiSAFFdF2PsJ4x9UN67P76SccsHD00I
	 ptaahRXYhVITKszZQvA1I+DycaBN6ExvYXFuaGQlGIKr14Yq6Fg+Jth3QXR1S4JUxm
	 V4ZmTcLCRYXV63fYxr0gfjA54ocb850f/X5rj2juIYed8vnpgrE0KbKBJXuz+fwpiB
	 pv3gC1CbcWff46i59+YH3JW00WizZq6DP4Owu0N7XIA8duUayIjK+liy1w9S+ubz47
	 O7Rf5qkEGq1DK9kVt1SeNFHA9AHgmxLZgQTPdAJujyIvG0fQAOvT6rkRBmW+ggjwcR
	 zT3M9Jd19UH7Q==
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
Subject: [PATCH net-next v2 3/3] net: stmmac: pci: Use generic PCI suspend/resume routines
Date: Thu, 30 Oct 2025 04:19:16 +0000
Message-ID: <20251030041916.19905-4-ziyao@disroot.org>
In-Reply-To: <20251030041916.19905-1-ziyao@disroot.org>
References: <20251030041916.19905-1-ziyao@disroot.org>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++-----------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 4b6911c62e6f..eec81f674857 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -382,6 +382,7 @@ config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
 	depends on STMMAC_ETH && PCI
 	depends on COMMON_CLK
+	depends on STMMAC_LIBPCI
 	help
 	  This selects the platform specific bus support for the stmmac driver.
 	  This driver was tested on XLINX XC2V3000 FF1152AMT0221
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


