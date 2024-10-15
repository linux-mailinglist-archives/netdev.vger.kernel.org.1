Return-Path: <netdev+bounces-135603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39399E534
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824862833E4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC811EABCC;
	Tue, 15 Oct 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Ja3YFPd0"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD21E884C;
	Tue, 15 Oct 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990595; cv=none; b=urDq2i8d8tiDQt/NNtv0ZbPAgpUfceJEx2aJ0hoJNI5qqTsN0YNjP0eG8gdmqxwnTnIDM75LtGPu1WlWVnLipTrbXSw1eFPsZbElgjr/Ixobf1wRPymQoOLOWbwn69pDF7zwpLaFLufXN1GIVA/RW58HMW5YYwVY0eOsu0VusW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990595; c=relaxed/simple;
	bh=ZukZnUD2gGsbjcBYvKatcQPnYD3cI5+xyfoADgxdxKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z38RTwQOkpHxanNjcrtaW2tKE6sggiCfGUcfmdFS6zZ0bdiM+A7UNj4hX7Jfzjutz4K+kqkwSK6pSoxbnPnklKdzFe1snOQq3qLJvPsEAY8XFEmh5HxSgtXfEAXx8ak9GWA/bpWxXLy6KkVqljUQGvTpF9WcCz8/tI3tN9Yw7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Ja3YFPd0; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/mrBSUlA65UftkpATPLrRQIlIiwqBHNpOsskKA65gcc=; b=Ja3YFPd0tLHgX6PRBueMkS+dNx
	l3dbc091tXL2lZ84yyHZpccPr7mZ9aKtHnGVTgh/lQe6ge3CFl33L0u1Uz0RzJh16UKyroGu8V6Qq
	a+X/uWsrhfmfkMtbdu18El3J0IrjHaz+2zqI/JF/8CgnIvzkdUg52JJ2FQRGQG3F+w5Y=;
Received: from p54ae9bfc.dip0.t-ipconnect.de ([84.174.155.252] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1t0fQr-0096bC-38;
	Tue, 15 Oct 2024 13:09:42 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 2/4] net: ethernet: mtk_eth_soc: use napi_build_skb()
Date: Tue, 15 Oct 2024 13:09:36 +0200
Message-ID: <20241015110940.63702-2-nbd@nbd.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015110940.63702-1-nbd@nbd.name>
References: <20241015110940.63702-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The napi_build_skb() can reuse the skb in skb cache per CPU or
can allocate skbs in bulk, which helps improve the performance.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 4a9cf06bdff5..4e4ece5e257a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2137,7 +2137,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			if (ret != XDP_PASS)
 				goto skip_rx;
 
-			skb = build_skb(data, PAGE_SIZE);
+			skb = napi_build_skb(data, PAGE_SIZE);
 			if (unlikely(!skb)) {
 				page_pool_put_full_page(ring->page_pool,
 							page, true);
@@ -2175,7 +2175,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
 					 ring->buf_size, DMA_FROM_DEVICE);
 
-			skb = build_skb(data, ring->frag_size);
+			skb = napi_build_skb(data, ring->frag_size);
 			if (unlikely(!skb)) {
 				netdev->stats.rx_dropped++;
 				skb_free_frag(data);
-- 
2.47.0


