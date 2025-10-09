Return-Path: <netdev+bounces-228321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946CBC78D0
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 08:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BD33A147B
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFA25A355;
	Thu,  9 Oct 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0aAP3sc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37522A7E9
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991423; cv=none; b=exIbGE4KJJI8qlTZeB5V531VxBb3xO2LwAlsKLeZIcNcrd0y9tbpU8Xxs6yROv796zEhrdMaqwZehAqFruUZNGM+dc0BhsoOqJRkIMOekz7rBVen8h366SUNLQ6uBYClM4/+8lILycthwgP3Pa0VVqRmf1cOAUaxangXY1Dk36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991423; c=relaxed/simple;
	bh=iixDKVyiVVp7+8PaX5CJIKm90MRovONR4rKXMm7l76g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uNeT/xCMllnd2w0gK4+1VtNi4DrQaOf/+kYDxaZCJlNJfWWZVIl+0gKBPUL6O6PBFzL6GCpU9GwkZ+zczUnVLkA0Sa4AIYXv55ZNirldX0XUMOAb5Uh8KMp02DA/AuVDHmgIZC5jmyJS9t2L2sfcz2iB8nBjvfgY99VImRL/p9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0aAP3sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5798CC4CEE7;
	Thu,  9 Oct 2025 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759991422;
	bh=iixDKVyiVVp7+8PaX5CJIKm90MRovONR4rKXMm7l76g=;
	h=From:Date:Subject:To:Cc:From;
	b=a0aAP3sczWi62YXdnte+kBjE8NFpslFYjYlv0AQ6YNrHz35BUmioYW00WUS7t5kB2
	 kZM8Ag8pBWplicYBjgg47lxvsTGJ1u/V58J4OSH4UxxB47j/vh+pANO/KtEWwIQCfy
	 +Wc0kZn3hesiGQ2A7JQBK8ANmuPYTmhE+V62Wz9P7VFVan4afD/LZ+D0eQlA8Udk9V
	 1Dgj0X3/OnySckPMBQlBERIZ07jlCOSu8gwz6JJ7qBaxRL/2cBwhczeXJ4+3vo5OZe
	 Z+ZRZpCrxcUNImyoqsomOITm/mHXbWXvSXGuhsrcDEYW7vQhjIDMYtZFSVMvdexjPk
	 giDsMNFUqDtVw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 09 Oct 2025 08:29:34 +0200
Subject: [PATCH net v2] net: mtk: wed: add dma mask limitation and
 GFP_DMA32 for device with more than 4GB DRAM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-wed-4g-ram-limitation-v2-1-c0ca75b26a29@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE1W52gC/3WNzQ6CMBCEX4Xs2TVt+dF68j0MB2IX2Ait2TaoI
 by7lbuZ08xkvlkhkjBFuBQrCC0cOfhszKGA+9j5gZBd9mCUqZUtFb7IYTWgdDNOPHPqUl5gU1l
 FJ3LWlRby9inU83vn3sBTgjaHI8cU5LN/LXqvflit1PkPdtGY1fRU16Sdqsz1QeJpOgYZoN227
 QvjgTr1wAAAAA==
X-Change-ID: 20250930-wed-4g-ram-limitation-6490e7ed9d39
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Daniel Pawlik <pawlik.dan@gmail.com>, Matteo Croce <teknoraver@meta.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

Limit tx/rx buffer address to 32-bit address space for board with more
than 4GB DRAM.

Fixes: 804775dfc2885 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
Fixes: 6757d345dd7db ("net: ethernet: mtk_wed: introduce hw_rro support for MT7988")
Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
Tested-by: Matteo Croce <teknoraver@meta.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Add missing Fixes tags
- Avoid possible deadlock if dma_set_mask_and_coherent fails
- Link to v1: https://lore.kernel.org/r/20251008-wed-4g-ram-limitation-v1-1-16fe55e1d042@kernel.org
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 3dbb113b792cf00fb4f89ab20f7e7fa72ecac260..1ed1f88dd7f8bc69bf4cb2803b907c8d7776ae20 100644
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
+		goto out;
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


