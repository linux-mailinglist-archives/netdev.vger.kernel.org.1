Return-Path: <netdev+bounces-169751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C884A458FE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340AF1630B1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35E224245;
	Wed, 26 Feb 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTowQrOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF720DD7A;
	Wed, 26 Feb 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559949; cv=none; b=k6mscV2SicBs3T9cLYDcmwLl95O1sXV9Nv4YyJ9k0wkicKMJB46AlAdkERcmRvbfEV6r/I66SWPwJixgPGLSAqFuNwEGLEpk49k2qntjkgscortlBILKLD0YioJbTzdfBZto/LQDTFZdyebFZG7OHBTzmNfl5CdOXk44ZTd5Gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559949; c=relaxed/simple;
	bh=lIHNdIK6hPFeIvlmwhxstmnP1ls57wGiXfAx3JVAMPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SncpIRBhVDRfESdx9SUpd1Z2uc+ixEav146X1/cA2jwbnJUHI0+T7z97PhHEIk8wVeFJaNJyJn5o6VDGYGfd9UKVrRo/9RaKNh3wNaxX10vLsscuSn/s9UK4ARe5oJFtIAMkQWDW68nJHwm1mBis8BsNmYcj12MYMCwN6jtDxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTowQrOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F16C4CEE7;
	Wed, 26 Feb 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559948;
	bh=lIHNdIK6hPFeIvlmwhxstmnP1ls57wGiXfAx3JVAMPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTowQrOCigkrCNEJ5MDYX1TfpdKJ7irp6D2SLGUimP7EB2DjqC7qTbvC6zHn4rxHk
	 RV19+A7GI2mMdDQkBp+7lzM0p6WVpS9bOD3qG6Z9GKvrKjVguv9I8XsCGRAW9wkkDl
	 AcVCmDTWJviFwngRasFTH6OnLXQqr3Nbp4/ohqCAoTuh0jiYEIFLHo3ugM0Gdy0gME
	 cT1tdRfMOVMo6eeWmuELYJTv4yX5OSgbmR3Ca29QAif/ibjrYV3HZq2g87/8SDfzn/
	 k588T+6J+wTzvACZyu0kPuFjRzfv7nsQoHLsmjSA1UiCVKeBez2s7d8BYHIScSni3n
	 80oSu7NeH49/A==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Henry Chen <chenx97@aosc.io>
Subject: [PATCH net-next v4 3/4] stmmac: Remove pcim_* functions for driver detach
Date: Wed, 26 Feb 2025 09:52:07 +0100
Message-ID: <20250226085208.97891-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226085208.97891-1-phasta@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions prefixed with "pcim_" are managed devres functions which
perform automatic cleanup once the driver unloads. It is, thus, not
necessary to call any cleanup functions in remove() callbacks.

Remove the pcim_ cleanup function calls in the remove() callbacks.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Tested-by: Henry Chen <chenx97@aosc.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  8 --------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     | 12 +-----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index e2959ac5c1ca..5d7746d787ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -603,7 +603,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct loongson_data *ld;
-	int i;
 
 	ld = priv->plat->bsp_priv;
 	stmmac_dvr_remove(&pdev->dev);
@@ -614,13 +613,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
 		loongson_dwmac_msi_clear(pdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		pcim_iounmap_regions(pdev, BIT(i));
-		break;
-	}
-
 	pci_disable_device(pdev);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 352b01678c22..1637c8139b9d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -226,21 +226,11 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
  * stmmac_pci_remove
  *
  * @pdev: platform device pointer
- * Description: this function calls the main to free the net resources
- * and releases the PCI resources.
+ * Description: this function calls the main to free the net resources.
  */
 static void stmmac_pci_remove(struct pci_dev *pdev)
 {
-	int i;
-
 	stmmac_dvr_remove(&pdev->dev);
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		pcim_iounmap_regions(pdev, BIT(i));
-		break;
-	}
 }
 
 static int __maybe_unused stmmac_pci_suspend(struct device *dev)
-- 
2.48.1


