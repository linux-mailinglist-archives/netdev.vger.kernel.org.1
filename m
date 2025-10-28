Return-Path: <netdev+bounces-233569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C9C1599D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67F25508E30
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80173342C8F;
	Tue, 28 Oct 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WHjS9+GJ"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27A332EC9;
	Tue, 28 Oct 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666275; cv=none; b=NgUqG31Bn1rWGtKE5uQYVtHHcDrKOT26aY3BLGFwfx0FjcZ5NozPUJmGEuYRuTNTCeWizc6zDxJdpJ5YUzqIL3xWxFCq2rRksJa0kO8NIlrBtc0ZcZrFQVfCNCCWt7uZ7DKPtDtJELRdJFSWAupGSVm98pXQDeaXa/JtlRaGz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666275; c=relaxed/simple;
	bh=k5bALUyYVX+hk1lKr/Cg++6TmDGqsUOe1Hy5ZWqvfXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJh5X+ErPiMQG6ZGDbHJqytS5nUS8irLwj329Pfj4GhHIyogsja+v645ueHkpoh+ket/l5phppuH4A9QngG1Tp3NCAHKpwSqV7xChjZS0vfAPGTZdycY8GNkdGMddbhD5A86eIU50i3U8lwa415iNrA+KXEl0YDoTfne+a0BS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WHjS9+GJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9DBB525CCA;
	Tue, 28 Oct 2025 16:44:31 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhUiMD66JAMt; Tue, 28 Oct 2025 16:44:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761666271; bh=k5bALUyYVX+hk1lKr/Cg++6TmDGqsUOe1Hy5ZWqvfXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHjS9+GJz0AdXxMmjv32drQM6bg8pSc95LqZV/jql+1AIJZZvKjr7Megcf88FJLLF
	 +paqFb7KPlys1gzWIWbpwIrMQhc4C4zZo/YY13wwAAUR4EpHGjN5QI6f5t2O/OLqiy
	 i3lkZkkMysEMd9fVOcSdkxFU/Gbdhwg0GuOJaTRbkc5H/UXEJAPnTb+Y7rra70L3M3
	 eGDKqUHABm8nMjWvn43lj2QyLAWI8TvypnOUPPI+1MAZ64NlQUn/uq0wQHwCNW4TR/
	 ut6vbyV8rWCqrFIyctYNAdzQi0yF8U890jpOS5HD6eoWaMXCQ1hb7jZVnzA0x2iHi7
	 GHum9VGkx+xQA==
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
Subject: [PATCH net-next 2/3] net: stmmac: loongson: Use generic PCI suspend/resume routines
Date: Tue, 28 Oct 2025 15:43:31 +0000
Message-ID: <20251028154332.59118-3-ziyao@disroot.org>
In-Reply-To: <20251028154332.59118-1-ziyao@disroot.org>
References: <20251028154332.59118-1-ziyao@disroot.org>
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
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 35 ++-----------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2a3ac0136cdb..cf4c12d2de0b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -525,37 +525,6 @@ static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioad
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
@@ -600,8 +569,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
2.50.1


