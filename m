Return-Path: <netdev+bounces-241204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF548C817CF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32C5E342BB6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F830314B9D;
	Mon, 24 Nov 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="i/uR/N1r"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2D30FF1C;
	Mon, 24 Nov 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000363; cv=none; b=WpWLrwGDEusZhXmziHIHPFd0J2X+6dAtD3nqeXjthNjyAlf5IOSrVr2lCRP9p0wwVQXxtJjzlyjhZ26Raj5z738KMwVWhVKu49gb6VgRenf85hcKVRESehi4N0g06K4xQ7oKfqLApRqY8zgr7EoafIfmN7/ONKrGWuLCDQYpkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000363; c=relaxed/simple;
	bh=tVGA3qkz7Jn3pFsnWVBSvJRfpOJhIduZOIwHA2N9N7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqoq28sSHJ/lYF/MWNQDS7GSG8/RuqJqaNfkLqyxxFxwiLGCtdBLzK+bvxVCaqDKS+NVPi2bccwgVuBnjq67PM+6ma1akwimvupJh5ndJ/Bh8lBT7qU3Aag19bA77bmAiZ42D9Om6mzdibcRS9l9hyF2qhXjmKJuUXBaNrAQHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=i/uR/N1r; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5304C22F71;
	Mon, 24 Nov 2025 17:06:00 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMQpHf2NTp7J; Mon, 24 Nov 2025 17:05:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764000351; bh=tVGA3qkz7Jn3pFsnWVBSvJRfpOJhIduZOIwHA2N9N7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i/uR/N1r6RVrndde0GpFFQVYpW569G6uBJfViOPC+XGrcbLVCKC6CPmcMw8zByR50
	 8fY+97d9+V9FJagF2DyGck6pHQSoBynmpcSxngMNtRLYen13nclgUf9syCetMyOQpz
	 SvlLFkGBFZCZ3zx4rxBzGa/u+J3Qn4/9Qhj9ySt3PvI0yfkaaTrgxLzNPBlbvPnYlB
	 Dun1EFr3X14/PvTiATHkuf5iklGoLNhMxqwn1kJGJPyGGQsJnJHGOdjBVe5yRxDDaQ
	 m0enm0sSlQltZJjAxtMXi1/s/jDgLZJbINqQdpMsVnn6nLleA68wCAmUjyiuFdLnnj
	 SO5AW+/g3fX/Q==
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
Subject: [PATCH net-next v5 3/3] net: stmmac: pci: Use generic PCI suspend/resume routines
Date: Mon, 24 Nov 2025 16:04:17 +0000
Message-ID: <20251124160417.51514-4-ziyao@disroot.org>
In-Reply-To: <20251124160417.51514-1-ziyao@disroot.org>
References: <20251124160417.51514-1-ziyao@disroot.org>
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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++-----------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index ad7ae3618099..907fe2e927f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -376,8 +376,9 @@ config DWMAC_LOONGSON
 
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
-	depends on STMMAC_ETH && PCI
+	depends on PCI
 	depends on COMMON_CLK
+	select STMMAC_LIBPCI
 	help
 	  This selects the platform specific bus support for the stmmac driver.
 	  This driver was tested on XLINX XC2V3000 FF1152AMT0221
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index afb1c53ca6f8..270ad066ced3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 
 #include "stmmac.h"
+#include "stmmac_libpci.h"
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
@@ -102,37 +103,6 @@ static const struct stmmac_pci_info snps_gmac5_pci_info = {
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
@@ -212,8 +182,8 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
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


