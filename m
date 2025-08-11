Return-Path: <netdev+bounces-212580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471AB214EC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0C21A231BB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586F2E2DCD;
	Mon, 11 Aug 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i+dwIOA2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9842E2DC8
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938318; cv=none; b=Q+mHtY+C1qycA4SFSnK0cvW2dIdLzjuaALLQGm0K0vq4ipUOursrIvaS3eauDQBr676zROvW3NQ50DdLiJJ3OKUeYsAV3SYVuBLM+QLQ0uc48EWlBRTu3DMre5pRXfzaf3m8QubBQmftpFoYEh1qWMPCNaFyjNNdLFzj/cFMt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938318; c=relaxed/simple;
	bh=+8hKBgrpSDl210c6qhk5K8B26tvCznaX2QF5AcVepr4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=sNpIsfn/+UTiGpiZqGRj3U4E4np9/UgUzKIS2KAYDLoYCE1RSfbZNQe3y0LAMPgtAB2td/5g1wKd79+uK3AK2iUD9cT1yWRtct6Y3aBvErJcnZlkhmaL2FtpcnJwWovnCB7AiGTTdxqlHEnj8Jta5eUupNHZjGAQUXQv8PVVYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i+dwIOA2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O+ZWjlAiVXaiMSqihZGqMuzI69Y869sPCzWPUrdL1jM=; b=i+dwIOA2KDyihbulA8F6anitXB
	sfqlks2vOIC857Xg/6Kani+onWeW78iXcjgnIhgXQSUlUeVI0MQQqx5z1EnJ+lc4G04vku/hs8a8M
	/eM4ZNa0yp7hn5k7zd57tBPVqaR6oNBXjzdnyv0RtzYQdOTrUbATuTbvAJVXO9Uied0JaFi90CsRP
	Tan9z4iTsyv4hXIglxTNtPoE2gcr+75ChSM0DGVWOIG7arVDshxhVrAEd1VPSE1yj8k0yb+Qs5rN8
	AJ/X42IWzEbR8BjHob4VktXGZNnucJdoz0PNHBE7Ya056I8v/pNdKNVHUiMISkuXPxgqR/OjGOSS9
	MgmSFqfA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41016 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ulXcW-0003bD-1Q;
	Mon, 11 Aug 2025 19:51:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ulXbm-008gqs-P9; Mon, 11 Aug 2025 19:50:58 +0100
In-Reply-To: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
References: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/9] net: stmmac: intel: convert to
 suspend()/resume() methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ulXbm-008gqs-P9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Aug 2025 19:50:58 +0100

Convert intel to use the new suspend() and resume() methods rather
than implementing these in custom wrappers around the main driver's
suspend/resume methods. This allows this driver to use the stmmac
simple PM ops structure.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 74 +++++++++----------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ea33ae39be6b..3fac3945cbfa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1231,6 +1231,37 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 	return 0;
 }
 
+static int intel_eth_pci_suspend(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	ret = pci_save_state(pdev);
+	if (ret)
+		return ret;
+
+	pci_wake_from_d3(pdev, true);
+	pci_set_power_state(pdev, PCI_D3hot);
+	return 0;
+}
+
+static int intel_eth_pci_resume(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	pci_restore_state(pdev);
+	pci_set_power_state(pdev, PCI_D0);
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
 /**
  * intel_eth_pci_probe
  *
@@ -1292,6 +1323,9 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	plat->bsp_priv = intel_priv;
+	plat->suspend = intel_eth_pci_suspend;
+	plat->resume = intel_eth_pci_resume;
+
 	intel_priv->mdio_adhoc_addr = INTEL_MGBE_ADHOC_ADDR;
 	intel_priv->crossts_adj = 1;
 
@@ -1355,44 +1389,6 @@ static void intel_eth_pci_remove(struct pci_dev *pdev)
 	clk_unregister_fixed_rate(priv->plat->stmmac_clk);
 }
 
-static int __maybe_unused intel_eth_pci_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-
-	ret = stmmac_suspend(dev);
-	if (ret)
-		return ret;
-
-	ret = pci_save_state(pdev);
-	if (ret)
-		return ret;
-
-	pci_wake_from_d3(pdev, true);
-	pci_set_power_state(pdev, PCI_D3hot);
-	return 0;
-}
-
-static int __maybe_unused intel_eth_pci_resume(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-
-	pci_restore_state(pdev);
-	pci_set_power_state(pdev, PCI_D0);
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	pci_set_master(pdev);
-
-	return stmmac_resume(dev);
-}
-
-static SIMPLE_DEV_PM_OPS(intel_eth_pm_ops, intel_eth_pci_suspend,
-			 intel_eth_pci_resume);
-
 #define PCI_DEVICE_ID_INTEL_QUARK		0x0937
 #define PCI_DEVICE_ID_INTEL_EHL_RGMII1G		0x4b30
 #define PCI_DEVICE_ID_INTEL_EHL_SGMII1G		0x4b31
@@ -1442,7 +1438,7 @@ static struct pci_driver intel_eth_pci_driver = {
 	.probe = intel_eth_pci_probe,
 	.remove = intel_eth_pci_remove,
 	.driver         = {
-		.pm     = &intel_eth_pm_ops,
+		.pm     = &stmmac_simple_pm_ops,
 	},
 };
 
-- 
2.30.2


