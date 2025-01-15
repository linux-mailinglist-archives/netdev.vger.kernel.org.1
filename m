Return-Path: <netdev+bounces-158362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F5A117C8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DAA3A4975
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8CD22F169;
	Wed, 15 Jan 2025 03:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2PRtBKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CB22F146;
	Wed, 15 Jan 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911654; cv=none; b=J4zvbhxoX5BUdsYkQZd3+VVIrMp4qwY3M3JkKH/sblkxIaUBR0KlMkiBiHCG62trcnVC0pR69YL2oB6ZWem3xj4ixsFlf+EiskbDxMVuCM1zapAWl1E2PBUTZTFWPehoeVNNeNUgod1lYc0CCiLR0+9QStlHwXLXxoHG3wDG5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911654; c=relaxed/simple;
	bh=dCcIgnHXNICdJy+lWeTRtb9bU/MYBis3hGx1McIK2ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjkTJeU50SIFWHHWbddIcjqjzVv9clniZOlUmNHnxkOubw6EB368R7BhasUEzdUYVCgrMLy+faRBZJqC0F57gnxyO16sSvFwKoB7nIe9Gk+rIgeBw5UJzxhgqRu5wQkRiUsGmQ6tLAsHJZ8ec4vneadz96MBLkt7tyyu3qAONzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2PRtBKz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21634338cfdso104953145ad.2;
        Tue, 14 Jan 2025 19:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736911652; x=1737516452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRq1k9DQ7dcpFSRaoKAokYKGtHAonMVK3g5kkcieDXA=;
        b=j2PRtBKzQZWNgwIXsV62VvziCGXP0EW1uVr6pIn1dghPSrJxtudgqfvudq9NzihvZv
         0e8HexD/DVOJ0I0lt4o+6tqEpYNb7Gcm9NEWKiWJ5XABSArcAMss198sE9DOGoesAS+x
         knbSz9nFn/p79JIX8KfQQn6gJy77T2KmZcq9VVBJpgv3C2wEbKn9qz9ixMaj31irEaBF
         i2/Ou6F3/8WsWuee8fIYyie11eBnmYspbGTlQcFRXjaTyexEc52FDOSH7M9NpZkhkLf+
         zlO+PJz3TUiwjyJowmZk+jhh+RX0vUbfwoJCUI6UTnp2gqrhOAX4YCMDAmuOlx+jkaA8
         G3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736911652; x=1737516452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRq1k9DQ7dcpFSRaoKAokYKGtHAonMVK3g5kkcieDXA=;
        b=FaYx0Ge4ob1yBt3mjgbFzxY3KFvrMUj4inB9DOnVQX/TUXBrHCBUYE+40lXCb8tbVY
         Oxl4peFOdtYATYnwFLfTu3IJtgqHet9SRuI2RYgfXOnvSydmTwj4SCHrfoCwXkRsOvDD
         OjjA3bwiFf6oCaEDJIV5velquL8/S4BAv74vkcVkc6UQoBv+jt/EZT+WUF3dHEinlURg
         GUNIvyEc23dxme/oNsTCQSHNznrge8jmlcTp9zUdCdsoxnRXhYhJ+vZd9RtYO6g0Ws/p
         8zVmf9QPowr0OH7TxNXOiwbnpyxtnWNXR/Xon/9OBPkU5uS3nmS6o38C0R6URMvKN6V5
         eh4A==
X-Forwarded-Encrypted: i=1; AJvYcCVqcAykcYYeWRFnZr1mYVe0ZRI6Wo5FsPCspxGsxyS7+lxGQPAiCAHBkCp23v+BDHjfYNut3E0kHWUT0Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhqPO1oU/GwOpCLMXYbOLxCHBkLBZ6StBSzQQlsPGl7csw1DVL
	CYKe9oFh7rQRJDwWCAW12JTU76uSFEOJSW3B8ianED5svKjAuswdgnWp5g==
X-Gm-Gg: ASbGncuQqAQzGNnAsQvGbGYDdjZhbrSFIiViOwEc5zNhAU2oDcxNy0a3DxZLPN4ycLy
	FprA2wVKR0Ndep+cd5z+Tm9becEiK97oKC+NnzH3lgYgAp9MF2vRxqktAKCY4zCbZQ6Z8UgU+/n
	MK8gd6oxiIeIuV0e6thYnHn4y+rBGhfTvX/PTmhBDa89cO+de/Ce6gLo9sqqd+TQyiqgPmTX2Gq
	tdTBdghS7gXTC+NHcaIURImrZy1Zy5see/O3SaDabrhF+1Ie4pRSegJljxVtRqtrjUK5g==
X-Google-Smtp-Source: AGHT+IG7F3H2v0kSliTabXyeox9qkdn3NF3T6JxmOyvChSMJeeHU3yFa4THc3jIhecOqrdwKMRxkVA==
X-Received: by 2002:a05:6a00:35c7:b0:725:ef4d:c1bd with SMTP id d2e1a72fcca58-72d21fcec0fmr43073016b3a.19.1736911651509;
        Tue, 14 Jan 2025 19:27:31 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d405493basm8166452b3a.27.2025.01.14.19.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:27:31 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in non-XDP RX path
Date: Wed, 15 Jan 2025 11:27:02 +0800
Message-Id: <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736910454.git.0x1207@gmail.com>
References: <cover.1736910454.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid memcpy in non-XDP RX path by marking all allocated SKBs to
be recycled in the upper network stack.

This patch brings ~11.5% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, from 2.18 Gbits/sec increased to 2.43 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 ++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index e8dbce20129c..f05cae103d83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -126,6 +126,7 @@ struct stmmac_rx_queue {
 	unsigned int cur_rx;
 	unsigned int dirty_rx;
 	unsigned int buf_alloc_num;
+	unsigned int napi_skb_frag_size;
 	dma_addr_t dma_rx_phy;
 	u32 rx_tail_addr;
 	unsigned int state_saved;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index acd6994c1764..1d98a5e8c98c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1341,7 +1341,7 @@ static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
 	if (stmmac_xdp_is_enabled(priv))
 		return XDP_PACKET_HEADROOM;
 
-	return 0;
+	return NET_SKB_PAD;
 }
 
 static int stmmac_set_bfsize(int mtu, int bufsize)
@@ -2040,17 +2040,21 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	struct stmmac_channel *ch = &priv->channel[queue];
 	bool xdp_prog = stmmac_xdp_is_enabled(priv);
 	struct page_pool_params pp_params = { 0 };
-	unsigned int num_pages;
+	unsigned int dma_buf_sz_pad, num_pages;
 	unsigned int napi_id;
 	int ret;
 
+	dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
+			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
+
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
+	rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
 
 	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = dma_conf->dma_rx_size;
-	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
-	pp_params.order = ilog2(num_pages);
+	pp_params.order = order_base_2(num_pages);
 	pp_params.nid = dev_to_node(priv->device);
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
@@ -5582,22 +5586,26 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		}
 
 		if (!skb) {
+			unsigned int head_pad_len;
+
 			/* XDP program may expand or reduce tail */
 			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
 
-			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
+			skb = napi_build_skb(page_address(buf->page),
+					     rx_q->napi_skb_frag_size);
 			if (!skb) {
+				page_pool_recycle_direct(rx_q->page_pool,
+							 buf->page);
 				rx_dropped++;
 				count++;
 				goto drain_data;
 			}
 
 			/* XDP program may adjust header */
-			skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
+			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
+			skb_reserve(skb, head_pad_len);
 			skb_put(skb, buf1_len);
-
-			/* Data payload copied into SKB, page ready for recycle */
-			page_pool_recycle_direct(rx_q->page_pool, buf->page);
+			skb_mark_for_recycle(skb);
 			buf->page = NULL;
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
-- 
2.34.1


