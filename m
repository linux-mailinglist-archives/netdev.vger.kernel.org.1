Return-Path: <netdev+bounces-235519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27342C31D36
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B8D44F907D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AAF2405ED;
	Tue,  4 Nov 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iF/gu8yS"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519119644B;
	Tue,  4 Nov 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269519; cv=none; b=m2+ZjpnrvrUGtLqlfrVNQDkykxZz6dFSpcC7Lpks9v7UHp/PVtdDPIu8PfVrRd3wS4NiQA61UYAR6oeYwRIgbuAuteI0P3Plzbk8rzHUCKRs6fYa4HwIqaAPR+ojnd5esnMRjS4Hce3oD+qGEcoHZ5WW2JyYaKYA/9HrEAjEfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269519; c=relaxed/simple;
	bh=d999Gw2gebQ4f4VMTPEHK+xcUWBQzBf0MbaJId6XIGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkvRa5xgBBsn6tv8laS7h+mZIH/MgCZW/x02oU1WfR4aDCvlkBiaz+J83x8Wq448JTZtxAonBwF3k9BIaCkTGzmvBG5PMhob5SJmyB/KD0VGZIbG61pkK6b3Ag/wmstcqYCluK6SMju9+36Agvl9urfZMf8/iWK/3l59bR/YGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iF/gu8yS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 778752626F;
	Tue,  4 Nov 2025 16:18:36 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlOfxSJXBXVb; Tue,  4 Nov 2025 16:18:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762269515; bh=d999Gw2gebQ4f4VMTPEHK+xcUWBQzBf0MbaJId6XIGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iF/gu8ySs67ScCnyuf+9o3Gh0+Yi83OpdMTKoyNmRcsUAzv0ukoEBTlLv0j/pFWn+
	 TnIEHKrxa2BXYMSkcTWy/ipJiX4nuZs9aJ4MOJEQCYZKm7REoc99ITUXPzCvGMp0e7
	 aTHEZptH2lmoCLSUyhZ4SCWhwLBwVM8HHQxsbRohaG5fnwTmNfMt6xtKepv1adkn0l
	 IGT7/nAR4mV4hFz1OrOVl/krpJOlTcpeAMcYPP0JAzqlf3fTFLf19/zB716jTskjj2
	 1omfYI4Q8szn1qUjpvV2tAPeaWLikGA/B1s2jGb/uoA1ZP/znvjRA2sI5XjoQWJC6r
	 MXQAOa3VK3sCA==
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
Subject: [PATCH net-next v3 3/3] net: stmmac: pci: Use generic PCI suspend/resume routines
Date: Tue,  4 Nov 2025 15:16:47 +0000
Message-ID: <20251104151647.3125-4-ziyao@disroot.org>
In-Reply-To: <20251104151647.3125-1-ziyao@disroot.org>
References: <20251104151647.3125-1-ziyao@disroot.org>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  5 +--
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++-----------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 7ec7c7630c41..59aa04e71aab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -378,8 +378,6 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
-endif
-
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
 	depends on STMMAC_ETH && PCI
@@ -392,4 +390,7 @@ config STMMAC_PCI
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


