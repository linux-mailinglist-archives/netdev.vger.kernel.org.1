Return-Path: <netdev+bounces-129142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCF97DCE6
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CB31C20CC6
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF166170A23;
	Sat, 21 Sep 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="yPV30bCF"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1A16F265
	for <netdev@vger.kernel.org>; Sat, 21 Sep 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726916298; cv=none; b=ALSqIn+qB3es7GUkpkC7oDMsEtAxsJJC1V2iuIntdZv6pXTDSgUzmnaFI/3J5t+reRIP4N6bl9tIq64Ih6E1jeFo3gWfR8xwRPeyZ0XJaQClZIkfmLKMMsYdOKcrZc0KcyZhGK47U7CIt5rNpQItZREHmFc7DuvmYZBDXCjq90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726916298; c=relaxed/simple;
	bh=6DytPRepuAFtfREdgJHtSfpL67wp9UNks05nCyVEjvo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhYfRKUxTQiCVFANW+tzZ3sT4ad0mqakJ8rTYscre4yDnjI6kxbkktsTeoZIvSiqqyl+v3oTUhLfUpkIFsCtM5BPSesH3ZxmpKqUt0BLD79MtDLGVXgb0om6T1cS5HszscqeIkm+kRlxGxtlV6O78lCd0Ou3M9X7WS8llBUeg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=yPV30bCF; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 31593 invoked from network); 21 Sep 2024 12:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1726916288; bh=32KhWmLHTbTL0dsjFslltW8qKhUav4u+ZuqYRNoHd7A=;
          h=From:To:Subject;
          b=yPV30bCFgWWAIstvFgTt81gP7VlCBZEpPCc289/dROUfA9+yb5pohIfsCcfgNaWUn
           hXJ4Ef4BQnYuTK9/5BzOhBdx0lceK8rhO1zrQ/w2yH/R5Z5dMCPJLtGEPMCnIfH5ip
           p7qk9xkdR6STkCjRu52Mi0fQ+4jBMwF9K7y62kVE=
Received: from 83.24.122.130.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.122.130])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 21 Sep 2024 12:58:08 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	jacob.e.keller@intel.com,
	andrew@lunn.ch,
	horms@kernel.org,
	john@phrozen.org,
	ralph.hempel@lantiq.com,
	ralf@linux-mips.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/1] net: ethernet: lantiq_etop: fix memory disclosure
Date: Sat, 21 Sep 2024 12:58:01 +0200
Message-Id: <20240921105801.14578-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240921105801.14578-1-olek2@wp.pl>
References: <20240921105801.14578-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: d4d8c02e9dbe75db9f4d264d33a426b7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [geIw]                               

When applying padding, the buffer is not zeroed, which results in memory
disclosure. The mentioned data is observed on the wire. This patch uses
skb_put_padto() to pad Ethernet frames properly. The mentioned function
zeroes the expanded buffer.

In case the packet cannot be padded it is silently dropped. Statistics
are also not incremented. This driver does not support statistics in the
old 32-bit format or the new 64-bit format. These will be added in the
future. In its current form, the patch should be easily backported to
stable versions.

Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
in hardware, so software padding must be applied.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 3c289bfe0a09..36f1e3c93ca5 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -477,11 +477,11 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
 	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
-	int len;
 	unsigned long flags;
 	u32 byte_offset;
 
-	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
 
 	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
 		netdev_err(dev, "tx ring full\n");
@@ -496,12 +496,13 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	netif_trans_update(dev);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	desc->addr = ((unsigned int)dma_map_single(&priv->pdev->dev, skb->data, len,
-						DMA_TO_DEVICE)) - byte_offset;
+	desc->addr = ((unsigned int)dma_map_single(&priv->pdev->dev, skb->data,
+						   skb->len, DMA_TO_DEVICE)) -
+						   byte_offset;
 	/* Make sure the address is written before we give it to HW */
 	wmb();
 	desc->ctl = LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_EOP |
-		LTQ_DMA_TX_OFFSET(byte_offset) | (len & LTQ_DMA_SIZE_MASK);
+		LTQ_DMA_TX_OFFSET(byte_offset) | (skb->len & LTQ_DMA_SIZE_MASK);
 	ch->dma.desc++;
 	ch->dma.desc %= LTQ_DESC_NUM;
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.39.5


