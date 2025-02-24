Return-Path: <netdev+bounces-169029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F63A42240
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8306617FED5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6C25A2D4;
	Mon, 24 Feb 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BabkrY7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FB25A2C8;
	Mon, 24 Feb 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405226; cv=none; b=ND89GHdgAS4H9XI5WfnK5XX/tR3HQUoc+K5sNxUMDJ2x0Wr60gWnTT2RzTZi0j7Eu/mDX7JEWD0r2i0kQ6K0XDPDCmBxgA13hLOZVIGs9/WdaIXTDsGop9r4kylnYZK7yrYyS9mJg1LMHOAk3Fc1erA2WEt49EisnphYUhWyAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405226; c=relaxed/simple;
	bh=66R0uz0/FSUUTTAMJEGB0eXAz2y8U/eK6OaaeBiTLhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmXblAAAOv2/EA5hKfVrYZuiaYfVlL7TkT/ylnaarvbdlz7l6OVgxiNI5N70EYhKhEyEu8XG+4mDpqdsDZy9ne9WfIMl/r+FmaOaBEaqk+O8O48EFBzCBV5sXsQNtPVRgk7NoaLwvb0pAZhKFVA8Z2gEKIhjl0RIvYYMuo1Thrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BabkrY7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C4C4CED6;
	Mon, 24 Feb 2025 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405225;
	bh=66R0uz0/FSUUTTAMJEGB0eXAz2y8U/eK6OaaeBiTLhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BabkrY7JjObyWNDIIff76h4ZfpwKhiL7zqmu2SsH/j5AYNEodCBdx3wlhrR6trQEX
	 zgagR7JRS+zNZb1oDhAi+ew4G8o7tnt7YOleGM2TQmzIysMykrD1hlbvRb/JEY3oob
	 KfDHeD69kjHMRg0zcf0qmI2Hlk29vvMxsQrb7TSGtUrJqJVojEP3p7Pb/iZ1pn+Jt7
	 WvQQm/XhLmrcxtXhJi8VqZWYVDcTfDeD6MCx9XoSEz6wMSaiZQYshjcQSs1kGXp9Vi
	 6F+tMUvOkF1nGT93xcQBmRxPMpIxCKjtXA09hZwgEYEaCc6X5t5t8DQByCk4L2Ne5W
	 0NnN7hPHbriCg==
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
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH net-next v3 3/4] stmmac: Remove pcim_* functions for driver detach
Date: Mon, 24 Feb 2025 14:53:21 +0100
Message-ID: <20250224135321.36603-5-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224135321.36603-2-phasta@kernel.org>
References: <20250224135321.36603-2-phasta@kernel.org>
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
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  7 -------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     | 10 ----------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index e3cacd085b3f..f3ea6016be68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -614,13 +614,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
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
index 352b01678c22..91ff6c15f977 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -227,20 +227,10 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
  *
  * @pdev: platform device pointer
  * Description: this function calls the main to free the net resources
- * and releases the PCI resources.
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


