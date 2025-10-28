Return-Path: <netdev+bounces-233570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D490AC159B5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1E0E541AA5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84986347FEC;
	Tue, 28 Oct 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="b1J6mFwY"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238C3451C8;
	Tue, 28 Oct 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666325; cv=none; b=BX3TsRowIVQeOqnDKB1b5nBzoWjakt19H9sbywgwEtKtqY1GabxwJY+MSC/25bSpteIRqE2nn5MXgGvHAghsVJm+Xd0mc8d1oubhbYfohW7fAScCCfPR2w8T16kqwyRQCOEBh6lRw6qqBw1exMryaSNh4OKYlauVZlQd9duAyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666325; c=relaxed/simple;
	bh=+3Inzpf1mG0SJMoSxelog+i63O9kJIZxuw8kRM1j/nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc/vJz/1EfD1xGdZSwp6Wku7Y5rYYxp+1cNxBZ/GPVxHHuG1ddBikHBQxQR8FGja+r8ZpDshXFtxnQtJNiAi4Q7HkD9WikGRZsH3GPGkM+Xjou7OtxCeagOUqkPxITZOnQLDNvrKmPFloXHWemuiUu9pmepV2rKYgXgB8yL+0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=b1J6mFwY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4130D22F3A;
	Tue, 28 Oct 2025 16:45:22 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEOBRD312jZF; Tue, 28 Oct 2025 16:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761666321; bh=+3Inzpf1mG0SJMoSxelog+i63O9kJIZxuw8kRM1j/nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1J6mFwYWAnGe2UnNr2ZvdTizOW4HgR/VxnmUahyRDew8vDK+/spVyWgpjhPJy1Sg
	 LXWYwSod0EmIFibhXBKDIDZSx0WnWhtCnziALI4iSW8nFcvP3lbMSiTsjfdwhVdhbq
	 /lmMBdVGEsBGyrEVY0L6+5SXH642yIe4mWVdaA5kR++cLRQBbSNoengKoXuxYpkvJc
	 JObhfJNOLp/UO72ZeH1ubbxlmx9xAidoVtGujDPMJiPyb5vycWzhB0cNLL5Z1ecHC3
	 ivX99mxZkUUHFiX2oqpwUGR5qvmnmPY5/lRHGKdekWdx8B/Lfwj3RM5CdSfcS9BZl0
	 vKcrzPe7ZGnNw==
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
Subject: [PATCH net-next 3/3] net: stmmac: pci: Use generic PCI suspend/resume routines
Date: Tue, 28 Oct 2025 15:43:32 +0000
Message-ID: <20251028154332.59118-4-ziyao@disroot.org>
In-Reply-To: <20251028154332.59118-1-ziyao@disroot.org>
References: <20251028154332.59118-1-ziyao@disroot.org>
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
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 35 ++-----------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 94b3a3b27270..9e48e9b0016e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -139,37 +139,6 @@ static const struct stmmac_pci_info snps_gmac5_pci_info = {
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
@@ -249,8 +218,8 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	plat->safety_feat_cfg->prtyen = 1;
 	plat->safety_feat_cfg->tmouten = 1;
 
-	plat->suspend = stmmac_pci_suspend;
-	plat->resume = stmmac_pci_resume;
+	plat->suspend = stmmac_pci_plat_suspend;
+	plat->resume = stmmac_pci_plat_resume;
 
 	return stmmac_dvr_probe(&pdev->dev, plat, &res);
 }
-- 
2.50.1


