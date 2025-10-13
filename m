Return-Path: <netdev+bounces-228789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D0BD3DD4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BE7188329A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648633112A3;
	Mon, 13 Oct 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFVHgG6J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9183101AD
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367223; cv=none; b=u6PyJsBEpe2qwkRSiP+FNdsxbTCOFUb6twxzGIYxAblrXaiJcl6wMssRZyoRAttWYyt9+TmxLltbhCQ7c0e9sBO0kW2tTb7u0xv2t2hiDd2MORiAbtVhCJwjtrIF8uZdkOQ4M057YzxFH3oRmlOVLZRfykr4yptf+NWHH6T+ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367223; c=relaxed/simple;
	bh=kYq0RQ8YrvfPuA2ch2Lr96zLv/LgeMZHSYJ35zuO0Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw0TmYxsDo1Vij94tNA/i/obs+AKabFHt+jkYX/6xsG5eFelItidhwEO/hQDKrXa77IawqYKSRW2doV+BYLtQX+DvIkb7vmSIj3C5K1DTUX6H218T546hZ4NLOgFzYauvUgrznR0FkGkHcxWXP3I1EKiteHucIwTm0ChRmSH0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFVHgG6J; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f44000626bso3087276f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367218; x=1760972018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSdm7MHpJ+vjaDQLZoXmd6BHbOT4QBiIczgwCkXiEjY=;
        b=gFVHgG6J93eClI/ZIex9xvVEdr8050jQpjnhPYM8mn3NgFH8qg/9+PR4DR6l4ZjH7M
         f2Fi4GF4nzqZG9j+g1ckiUzhqsBO1Syfy5CRBebDGu2nxq+kLw4UltxeJ8wEUXQS27Lh
         53WWBdcxD+yyQ/sLN/OMPzBk2l5UbrhOKfGerp4WDwR33RZUaQX1ugo+UVZBVS3wOb9b
         r5jz+sNcGj7Ga6F/EI4cBrleA2WYwRCnQtDiPowCtGrwFeOQJaRpBsdC67w+oeq4XLqB
         ItXWXX45h/dINsZSY0r25MtUpQvOr7poZqEfV+IEFSVvFyT3rq976kwUer5S24TmWd2H
         1cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367218; x=1760972018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSdm7MHpJ+vjaDQLZoXmd6BHbOT4QBiIczgwCkXiEjY=;
        b=R4t+S9uxSvs2ZSbVG9v01L8K3ziBX85z1Po00COcAOZidE0mLeFarNH9mieN3moujn
         sCUcTR9aav51ZPH+YM6G5XErQfIkx2S6MRrcdxkVU7zXQ0vU61QTHAoU7jeCmyq2XQff
         +1AZAKSfIXbXluWYChg7ZWAgF0nP3gHVg15cO3VHbvenHwaYx/yI3CCIp0ndKEbbfYKN
         yJ/+SaACK0ePKiZIpPWHhOV8j+EgrFk30VdSs18KaL2Ia4Zt3NqrhwFmdXVMabjPofLq
         RF9W/y5UGWA745NKkM9YLu4DepmEOz2tVEEQIWWwFEqwImYYqGQRJf+wpSEi5cWOyuyY
         ciCA==
X-Gm-Message-State: AOJu0YylrVh4zXKB8HGS2IRmZrEvxaP2nD+UeZvp8aoRlYIOx2sbAkhk
	xw9R6+3Dn5d3NBRZBm57SmvbROMTwOuZsDIG3/R+WnK/YBc0y0wwr4kqwfoPMldz
X-Gm-Gg: ASbGncsHaPB3nCXPFZXqSPmvwr17+OBK+JjvZZIxR2b/BT0a8qZ024ivCRwDJocRMps
	P08ZMzzxL6VwNCw/NKq+NDsWk1xUVI79DDgh2MVSiC4OB1mzr1rDyTnImbaieIL0oPYkHwKuPBI
	1WEkwWSeBuriZXmLynBX7DOeQpju/gxPcMAVie9W9fXDBHqLEcE0956isUO0o6a2rAbTw08yepb
	E6lU4127LLmHF/be30pq0e9FJz8Kdp5dZlC6+SQ7k9RB/vyQyu6PegI+gzbZ6ZqPfVwSdJB+I/N
	cfRGNyv5K33JIv0R3mZKsT4FCTtJQKlnyIywa9uczqcfMquwEq57aJ0s+Yw//IaTQVj32re2Vu8
	s6GNGMDjSlClfY7jEzLJOC+SItvou6E7vmLs=
X-Google-Smtp-Source: AGHT+IED3GRiP+h7v/FeCyojCF1RwIXSpzaWATh3pEDXx0dXFBUhT/YkmwA0d8YAYemw1uBFEREaKA==
X-Received: by 2002:a5d:5d08:0:b0:425:7ce6:fd50 with SMTP id ffacd0b85a97d-4266e8db473mr14976457f8f.53.1760367218044;
        Mon, 13 Oct 2025 07:53:38 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 09/24] eth: bnxt: set page pool page order based on rx_page_size
Date: Mon, 13 Oct 2025 15:54:11 +0100
Message-ID: <df0727b497d5aebf7c2746f0fb8b0f07c482feae.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

If user decides to increase the buffer size for agg ring
we need to ask the page pool for higher order pages.
There is no need to use larger pages for header frags,
if user increase the size of agg ring buffers switch
to separate header page automatically.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: adjust max_len]
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 13286f4a2fa7..5c57b2a5c51c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3829,11 +3829,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
+
+	pp.order = get_order(bp->rx_page_size);
 	pp.nid = numa_node;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
 		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 	pp.queue_idx = rxr->bnapi->index;
@@ -3844,7 +3846,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	rxr->page_pool = pool;
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	rxr->need_head_pool |= !!pp.order;
 	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
+		pp.max_len = PAGE_SIZE;
 		pp.pool_size = min(bp->rx_ring_size / rx_size_fac, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
-- 
2.49.0


