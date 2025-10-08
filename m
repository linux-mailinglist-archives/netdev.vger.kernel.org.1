Return-Path: <netdev+bounces-228199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CABC46F3
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D99188B357
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2712F3609;
	Wed,  8 Oct 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh27gp3r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50852EC09B
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920515; cv=none; b=Z2bI1I0SzTug8P7Roza9hkZT6cH96F+SAI3wPYfCecolVULMMyRZ+ZHWf0QOiRZUSdf87FmyeiKuK/EWfqn7xXmNnzWXd3LkKrPlY6eHTLutqMnXxHnmtLaB/3gpbV1vL41WgMamCZU/LDCh6mB604dr2XVLZbDPcCDj6r/hIvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920515; c=relaxed/simple;
	bh=r8JHW7S9t8XtUom2huYwx+1JK/cKzVt5jAQ2jApdSJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R1M59zoB1QxhjKtDLD6WeU6/PNrjO5xmVuP0Emw4PwJbFk15jR+mVqJcqVJBGYOlHleHlsEu7AaYDlxE5e279xOlH/I7xOHbytt+OTctkORBMWQ5yz1cvoPaJp6+JwRqEOvLrEXbTjkJKmY/J9Xa1GU+fytXvu6QRgz/WKoHaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh27gp3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA2C4CEF4;
	Wed,  8 Oct 2025 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759920515;
	bh=r8JHW7S9t8XtUom2huYwx+1JK/cKzVt5jAQ2jApdSJ4=;
	h=From:Date:Subject:To:Cc:From;
	b=jh27gp3rw022a1h/WWr+t1wM0U5EPs25PS24UudRsvMvW7VuFNgttsy1GgDnKTtOE
	 fJy2IBNDNmHfBsGgVXOuQhiY/2uVhdRXyxjViLozWaO5OtoeEKYnQVCKAyogH5fWkw
	 O4L4XaH2//EYfNKzmkmT7znzYUWq5PFSUH2X7hz7TGr0wdeHvdbfqdhH0q/0TXB6M5
	 Px2bnP5mAsnm0130NIgU98b6Of7kZyGZ1FB0Td96nq92zEog71n0wX8Xg26Oll+B1F
	 NzioWB/ah65ZPpHNtDTd9tUPpR1QacxVqKJXSdnZ+uFtCkDGtA83RymnbEOHYZhEIn
	 /BZqFWAU1f/HA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Oct 2025 12:48:05 +0200
Subject: [PATCH net] net: mtk: wed: add dma mask limitation and GFP_DMA32
 for device with more than 4GB DRAM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-wed-4g-ram-limitation-v1-1-16fe55e1d042@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGRB5mgC/x3MQQrDIBBG4avIrDtgE5Ngr1KykPonGYi2qCSF4
 N0rXb7F9y7KSIJMD3VRwiFZ3rHF/abotbm4gsW3pk53g7a95hOezcrJBd4lSHGlCR6N1Zjgre8
 tNftJWOT7/z4potBc6w9l4YGwbAAAAA==
X-Change-ID: 20250930-wed-4g-ram-limitation-6490e7ed9d39
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Daniel Pawlik <pawlik.dan@gmail.com>, Matteo Croce <teknoraver@meta.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

Limit tx/rx buffer address to 32-bit address space for board with more
than 4GB DRAM.

Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
Tested-by: Matteo Croce <teknoraver@meta.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 3dbb113b792cf00fb4f89ab20f7e7fa72ecac260..cc3f3380a9980a6525921205dc7adaf321a099ae 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -677,7 +677,7 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 		void *buf;
 		int s;
 
-		page = __dev_alloc_page(GFP_KERNEL);
+		page = __dev_alloc_page(GFP_KERNEL | GFP_DMA32);
 		if (!page)
 			return -ENOMEM;
 
@@ -800,7 +800,7 @@ mtk_wed_hwrro_buffer_alloc(struct mtk_wed_device *dev)
 		struct page *page;
 		int s;
 
-		page = __dev_alloc_page(GFP_KERNEL);
+		page = __dev_alloc_page(GFP_KERNEL | GFP_DMA32);
 		if (!page)
 			return -ENOMEM;
 
@@ -2426,6 +2426,10 @@ mtk_wed_attach(struct mtk_wed_device *dev)
 	dev->version = hw->version;
 	dev->hw->pcie_base = mtk_wed_get_pcie_base(dev);
 
+	ret = dma_set_mask_and_coherent(hw->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	if (hw->eth->dma_dev == hw->eth->dev &&
 	    of_dma_is_coherent(hw->eth->dev->of_node))
 		mtk_eth_set_dma_device(hw->eth, hw->dev);

---
base-commit: 07fdad3a93756b872da7b53647715c48d0f4a2d0
change-id: 20250930-wed-4g-ram-limitation-6490e7ed9d39

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


