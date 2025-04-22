Return-Path: <netdev+bounces-184648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899EEA96BFC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A126E17A112
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43230281520;
	Tue, 22 Apr 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eLIK4u4f"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C9280CFD;
	Tue, 22 Apr 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327091; cv=none; b=PpC4WnDKc7av9J5SbnTZvSODp4WB0vpC/Dn64ddhlXkfUCcTAzZFaNKRbkXfVryuuyT4sM/FidFirmTLYQC2PAfXNndRFdCnPFFZin2DYsl+hEVmHvn+3MIywefEiwDN5gponzh2ZAAPN7WgDpNIebW3Vt5xw4iStvW7qZwa0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327091; c=relaxed/simple;
	bh=VicifB7VK+9MAEZJZiYpDrTf/SXS78yQinhMpvll6nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxMEPVCj3+on1m5T8Ly53kkw5RXnuEgEWKK7Y4rNjjwt1IQE8ObfoJ0cSO29/0CdhszRWKb1mj6cC7IBUTZzxlcV1OTm0NbGNnbQ3MTpUD/1aVMNQQuFdVLxkjK46M2ndTuZ+0AOM96VJa+s1/N+vYMnpjKpQfQW5QPSzNiqr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eLIK4u4f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745327082;
	bh=VicifB7VK+9MAEZJZiYpDrTf/SXS78yQinhMpvll6nE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eLIK4u4fy9xYuK2GLzl0Xy+K9/gX1SpsRVVlDTSJYRg0MWkwAV0LKDaPATkupHB40
	 R2ZHe9J5EhbfTeshuJrqqYa6Br052zAwP1qWG4ktMUahvzGAYNOdbCTg8xjPJYDsbv
	 lWnzPdKO9/MZxHyL3vpPzrZ0pgybMvyg2OwSB4cVAFUxTEGmimr5fbeIdc1YDGYhr+
	 j6S00hVbZCfgexsd1BFiRBFimnUpbi7NzqUg3Zz6+v92I+wcV6wvbA1ZX692XjQ08Q
	 YPeOfbHw2jDGR9wZ+rHmszhRyXGZ248Npw97uMD5flnTo5vht9qDFToVxTtD7ZXKHz
	 vuO3b8klEqdSA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 445C717E35E8;
	Tue, 22 Apr 2025 15:04:41 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 22 Apr 2025 15:03:39 +0200
Subject: [PATCH 2/2] net: ethernet: mtk-star-emac: rearm interrupts in
 rx_poll only when advised
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-2-1e94ea430360@collabora.com>
References: <20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-0-1e94ea430360@collabora.com>
In-Reply-To: <20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-0-1e94ea430360@collabora.com>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Yinghua Pan <ot_yinghua.pan@mediatek.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745327078; l=1312;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=VicifB7VK+9MAEZJZiYpDrTf/SXS78yQinhMpvll6nE=;
 b=h+C8WOIsNCCwo9YNFF/mpsmLgIGPv9dYOw9qMsKPfUUl7/JCKwmHtEcr/3tBvI+PgqUYsYk/W
 ucvmmuAEK3HCs2K/PKTAdMxINxC4OYISaELdqnXTRFhUv87KCtqQF8P
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In mtk_star_rx_poll function, on event processing completion, the
mtk_star_emac driver calls napi_complete_done but ignores its return
code and enable RX DMA interrupts inconditionally. This return code
gives the info if a device should avoid rearming its interrupts or not,
so fix this behaviour by taking it into account.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 41d6af31027f4d827dbfdfecdb7de44326bb3de1..b0ffe9b926c3d8dfaea3e11accae6d01e3ea2c4a 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1348,8 +1348,7 @@ static int mtk_star_rx_poll(struct napi_struct *napi, int budget)
 	priv = container_of(napi, struct mtk_star_priv, rx_napi);
 
 	work_done = mtk_star_rx(priv, budget);
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		spin_lock_irqsave(&priv->lock, flags);
 		mtk_star_enable_dma_irq(priv, true, false);
 		spin_unlock_irqrestore(&priv->lock, flags);

-- 
2.49.0


