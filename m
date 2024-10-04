Return-Path: <netdev+bounces-132071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96199904D7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAD282CF5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA692101BC;
	Fri,  4 Oct 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRBFuVhh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B000156678
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049922; cv=none; b=c5/HrhoXG4oHBk6FHYFPq9skLjznKcRws9JGJbAhvIINqz+/loCOinAo77rolGenc7feof4NyGTjb8aBQ1uMcG3Oqm3xzdcQ7uXeEvhtNQoqXn8h98M3NUSJrzd+45T2id6/M+YoEqJ+Ab3bGtoaNB9fn5g7EUU8sRYv33rYiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049922; c=relaxed/simple;
	bh=+SdP+HtNZw0N9Fp+9zSIv3zF1fEXSQajW7KJQerTMnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cltcZu3DiDNQRJRsSIPcjMzAcNk44/23rFgctjn+sxy6B27eH34SmXn5KEgLzcyv5TUxLQp1Kfe7Mv6kC33YQ9NGMYbM/B53EsPrDv2VEEcfIfoozItcZHKUvdwdAUj5aeU0kC0feMi9zzXUUSU3bBkFnq3MuRu92a8+ExvXbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRBFuVhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EDC4CEC6;
	Fri,  4 Oct 2024 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049922;
	bh=+SdP+HtNZw0N9Fp+9zSIv3zF1fEXSQajW7KJQerTMnU=;
	h=From:Date:Subject:To:Cc:From;
	b=PRBFuVhhMUH39YrvBGNlcWQ5hC0z+ZgnAZXKZvA89WljcdvE2HhgwtT23ZZTiWl6A
	 Z4XMUp5VCLqft1GVnDtr5KUeq9BHc5N869GCVQ0i7G22tnr1QRcLSFi3Nnr1M8jLxu
	 WWYCw350ZWeeTNMWkwnGBe/QlQmQcx84TY/f1bzUKhBXiTjztD5b6LkQj7f5R50GrR
	 CxBRQc4ei9QHuMipeDFcFGMOR0h7M4Yfpqc21yaeOGWcPjQzjsMLI04UL+ng2SnWk4
	 izSl5Y0lc/MR+QnZQe50sc8uA0Lk9ZNuutBXjaQm9+X8mtoghpUYt/JJl/EwsUeBlx
	 IdJ9+aUScadYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Oct 2024 15:51:26 +0200
Subject: [PATCH net] net: airoha: Update tx cpu dma ring idx at the end of
 xmit loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-airoha-eth-7581-mapping-fix-v1-1-8e4279ab1812@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN3y/2YC/x3MPQqAMAxA4atIZgONVvy5ijhUjTaDtbQiQvHuF
 sfvDS9B5CAcYSgSBL4lyukyqCxgscbtjLJmQ6UqTUppNBJOa5Avi23TER7Ge3E7bvJgT73uaJn
 nWivIBx845/8+Tu/7ASxmv7xtAAAA
X-Change-ID: 20241004-airoha-eth-7581-mapping-fix-919481cbb340
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Move the tx cpu dma ring index update out of transmit loop of
airoha_dev_xmit routine in order to not start transmitting the packet
before it is fully DMA mapped (e.g. fragmented skbs).

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Reported-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 930f180688e5caf1175481a43d243812bc07be07..2c26eb185283725ff50803437dac5143d7884b5a 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2471,10 +2471,6 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		e->dma_addr = addr;
 		e->dma_len = len;
 
-		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
-				TX_RING_CPU_IDX_MASK,
-				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
-
 		data = skb_frag_address(frag);
 		len = skb_frag_size(frag);
 	}
@@ -2483,6 +2479,11 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	q->queued += i;
 
 	skb_tx_timestamp(skb);
+	if (!netdev_xmit_more())
+		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
+				TX_RING_CPU_IDX_MASK,
+				FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
+
 	if (q->ndesc - q->queued < q->free_thr)
 		netif_tx_stop_queue(txq);
 

---
base-commit: 096c0fa42afa92b6ffa4e441c4c72a2f805c5a88
change-id: 20241004-airoha-eth-7581-mapping-fix-919481cbb340

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


