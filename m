Return-Path: <netdev+bounces-113766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B354B93FD5C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60111C22052
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90E187336;
	Mon, 29 Jul 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNq+R43x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D947603A;
	Mon, 29 Jul 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277872; cv=none; b=u6tjNPkqfG8/CWvS039i5PjYQEklrm2tkynW587CwYzEAbWrlfHddm8ZqYLXOqlPPUpx5A5FW7yFfgEjtwcmtmUKMW4KhiaP3cf0zI2CFbMKjFQ/dgRmoN/tUEpabCFEHFcK/6kusShaTPV0+sdRBUdgaA+rVplHp7MfWnUNoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277872; c=relaxed/simple;
	bh=zd+MCEbMO6JeXdw0qJmG2+Ky+bWx5/+j7mPhuUe1J7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/r8PIukBkhDhJVt/7leNrYW/HcDoDsIYGM3vs6we+19bVrXCSssnDYWjZdjDUNidSTiKqiROfJmhee5oucKQRRNLjQnz5kQthENrPpYiZ4zo2E2+iIednD8nC/ri/4YqIxeR6cu+JtSsAm//Pca8bp+f3bHpdQ8VeaPI3flAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNq+R43x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3685a564bafso1635038f8f.3;
        Mon, 29 Jul 2024 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722277869; x=1722882669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3HZPjGWY4VRrAKXTzpvY38O5iWIBdVGuavEILhUuRQ=;
        b=FNq+R43xfoz9flhyp1PcuTZV6m9fWnNoE5RE0kExN3NnLUUeBgMQ4ehL6EGkImIm2Z
         6KkPPcOrCmHPgzoIk92+uAhu2SJanyHdY8w/SBdjKi/65KTWUxNycy/jZltP4t+87NQ7
         Nq/T4yt8yLkxkWrJ+W/SWML0u6htW61VEAYPoUH53EZ2fZIj3b2hrMFRllvSj4Zu4tql
         IifmCCAo7QWr1rcg1B56mZNr3klFIsB7UNPfuhBHipvlitFDMHSbI8RJ1XjMnhbrTeOV
         i2Q/Y2eQj5H2o+B+/F7jnkwDabZfZrkWoTrn559gYO8gZC2cCFsM/jYAOrIh6qWrbDP3
         Z7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277869; x=1722882669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3HZPjGWY4VRrAKXTzpvY38O5iWIBdVGuavEILhUuRQ=;
        b=TJjsK5N/EIoO73kUcFlPVYrTypZXxPulgxUggForftv7ZaDm3EOs89BYtGYjoubb6N
         JKEziNzvEpAO4yzgTHSf3EuxhMiDvpMX1b8awqGaCiGSFECgJ4ELofUlbsbBzlJ4epYt
         73syuHmWtzlEinQ3T7FnrduXBdPUPcEBOWBdVV+1CdNSRpf33tvEUiNnC6qvIlSjKf2X
         /Ijs1O3SpgxRvQmnzRerjKy4nGOLvZKxoNju/Bx+Rpe59lGoonI5CtftDOxSX05WmOKx
         itjah+KF/18oyzdJHNnDTDwOIx/UBC9zqNcBmKeK9RjUAsOPkblH8Gr4q4Fy0lPcnB1w
         h1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUEzODbapoLah0qCOg5bobpbiSq/gn6/tJBHaAierV02z70FssEm/+SdnMEobBWLoi6VQvLqrCiwAVbxPTfnoTrZdn+BUbeWdSJ8k+E6cGTr5cCr3U98FaKmj2lbT6PE+guKXqm
X-Gm-Message-State: AOJu0YzuXtghLkLZLeLbt7vkDg3BMomvMO3C10Jkt9q2PB728/9e7W5H
	VKbmvI9/PjSF1gPrnSOYJAFHS86C2LB4AbcUvGJjGcM0HlXrpEr1
X-Google-Smtp-Source: AGHT+IGqZxgSP4lsPbAxAppqsr2GefFixDAdbJfCPlCS9IEnJzJghfslCrcUrnOqBBH8tG5Kr1hq0g==
X-Received: by 2002:adf:ec0f:0:b0:368:6620:20ec with SMTP id ffacd0b85a97d-36b5d08b948mr5667615f8f.43.1722277869212;
        Mon, 29 Jul 2024 11:31:09 -0700 (PDT)
Received: from yifee.lan ([176.230.105.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0aa1sm12800165f8f.21.2024.07.29.11.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:31:09 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Elad Yifee <eladwf@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch methods
Date: Mon, 29 Jul 2024 21:29:54 +0300
Message-ID: <20240729183038.1959-2-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729183038.1959-1-eladwf@gmail.com>
References: <20240729183038.1959-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize kernel prefetch methods for faster cache line access.
This change boosts driver performance,
allowing the CPU to handle about 5% more packets/sec.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
Changes in v2:
	- use net_prefetchw as suggested by Joe Damato
	- add (NET_SKB_PAD + eth->ip_align) offset to prefetched data
	- use eth->ip_align instead of NET_IP_ALIGN as it could be 0,
	depending on the platform 
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..4d0052dbe3f4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1963,6 +1963,7 @@ static u32 mtk_xdp_run(struct mtk_eth *eth, struct mtk_rx_ring *ring,
 	if (!prog)
 		goto out;
 
+	net_prefetchw(xdp->data_hard_start);
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -2038,6 +2039,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
 		rxd = ring->dma + idx * eth->soc->rx.desc_size;
+		prefetch(rxd);
 		data = ring->data[idx];
 
 		if (!mtk_rx_get_desc(eth, &trxd, rxd))
@@ -2105,6 +2107,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			if (ret != XDP_PASS)
 				goto skip_rx;
 
+			net_prefetch(xdp.data_meta);
 			skb = build_skb(data, PAGE_SIZE);
 			if (unlikely(!skb)) {
 				page_pool_put_full_page(ring->page_pool,
@@ -2113,6 +2116,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 				goto skip_rx;
 			}
 
+			net_prefetchw(skb->data);
 			skb_reserve(skb, xdp.data - xdp.data_hard_start);
 			skb_put(skb, xdp.data_end - xdp.data);
 			skb_mark_for_recycle(skb);
@@ -2143,6 +2147,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
 					 ring->buf_size, DMA_FROM_DEVICE);
 
+			net_prefetch(data + NET_SKB_PAD + eth->ip_align);
 			skb = build_skb(data, ring->frag_size);
 			if (unlikely(!skb)) {
 				netdev->stats.rx_dropped++;
@@ -2150,7 +2155,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 				goto skip_rx;
 			}
 
-			skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
+			net_prefetchw(skb->data);
+			skb_reserve(skb, NET_SKB_PAD + eth->ip_align);
 			skb_put(skb, pktlen);
 		}
 
-- 
2.45.2


