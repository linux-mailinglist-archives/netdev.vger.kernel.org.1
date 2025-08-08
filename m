Return-Path: <netdev+bounces-212201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E36B1EAD9
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B391891FA6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712928506E;
	Fri,  8 Aug 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlRWUihk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BA284B58;
	Fri,  8 Aug 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664826; cv=none; b=JfxmreYuMBP1QkF17XwHKSCU1M4aiWLWOtd2QV6FjMaA/f4SAJroloSrs4wJkLdznz1kMqnxDsM6vTelvJ5m5yORaQuNyMr19iydV79jr5tIhNaxxcrtoyhd4hbaycsleL4bPvgFEH/EC9zfsyDbfP9LE4iQrrDB674I0WmlRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664826; c=relaxed/simple;
	bh=8AuugD7u6Os9V9xHHyUWuEC+AJTO0va3/Wiv1hV7VKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/86FL9xVD8JpHTu9ITdn6YuK5SSQr5+SNWHii0s3eWABL1pgO7dpAJHaY+eRMP6kywg1xMu2h3dAzUoX8hmHsq7iM5iDmAxxoVgKAaGARTM9wk0LMAJJw+fX26XdxeTU/dw4i8LBJq8siERmmg7mT3vG0UcE5Pk/BAUk2xthSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlRWUihk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so13056735e9.2;
        Fri, 08 Aug 2025 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664823; x=1755269623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63xAygkwf//ATk/Q/oVaQFbEFKUgcZEDqhwnsvHDxJ4=;
        b=hlRWUihkVylCU/EU4Sw5I6xahekfwO00trTZvNMIrX8+13XOYaL3gg2zB4HThObQ+G
         NCiySd2MkAqv0zhBbXxE/rdb+NBekQ2k/Y/SjJwfOA3uzDhw/oQ7PEN1uVbm99tq2jJx
         Vf4iFcV/khYv3AV3tBaKjopUSMIbwnED0uNbWsYGFhC+/NjU9sno3OC9t/sxEsmv5hgW
         ea4zWEKouM4dbfODQfNP/VnpnGvPgtRENX1eFW0IhlTIDtjSO7ZxBE3Zc5pJPss1uFUb
         mOAoRDxLiWxk7cjAIPvOsZBHCzgJRj4DJ5xNwaDfnO+jZTgnnGBgjg0U2i7XcO+7UXDW
         h+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664823; x=1755269623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63xAygkwf//ATk/Q/oVaQFbEFKUgcZEDqhwnsvHDxJ4=;
        b=QdflT1gUU52+z1t9LiMPFtPEtRRoG+dDqlp9jcBkpGhO9ltMgrW8yj/zCg+E61v1ie
         MPDvmBJ3tP0+3zAoUqRhsQ0+B1BvK+WACDrIZKCFTYt/a9rvybfST5aeK1TqIAxY3S0n
         b2+r06Bsz9XXy8JrTrID9RKVmvnbDTiMEmArJmsCw7M2e18/iFRg5rQapTQx6p4nruxM
         KQV+V7d3YI9xiWnq85UELr2lzDHN2zElRtOlfuW/MnFYfD5Cb4VCuHGW+azAueAGnb83
         AORHv4LNZQD462wk285YdkGL0nq4CT2DNSLVaZRU4foEWDHziT/Yq5PQBadJ0PLQq6nI
         amoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRZXxi5HrXqJhc1y+chI2479Fe/XtJnjOK4j7fWQOMEaABo+PjDVWcP58uOqIHPjC0kz239zS0oY0eMIM=@vger.kernel.org, AJvYcCWt0R76HqY6wDE6l5989DRKTfTGHOKUkwFPkPdhmPieER1xRUhldZ4IQieYFuAOedhWDS59+nSD@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUMgALxefmSZEiioTWFp+qHvFh5LWCLTCAQ+L5ZOt1YNUeqKz
	mZFIx9umnSMJIMWCQ8OgHrZQA4NwkLew7OKQBYj3DNB3G8wnGsA/TyFW
X-Gm-Gg: ASbGnctL87dKcIM/Kfkm2x95jx22FzuR9cnFmhVvEx0dYXW4gadiaYv7+iOqC81g+cs
	/7w1FX2nwigv2KfQ0s0UTMG2ZvHJpDBhnnU+gpF4hOQhKj4zCuiKpTqe1t0ul/U0gF4JK02HBii
	H+ShpqANOBhkOBIJ3UoEA3KlWX0OZ4+rRSkXrRtVn/g06R25N2UGsXH4faIdr8kSGWW3QD99t6h
	brSJhzLQEhHOv0Ez9kxIX1QeizEgNioRwXwh6vO30PFNszxmOtMmrYT9BhnRvjl/13x5JCK0jvV
	WG3yYf+0nMDgzqA/cZBj4NI9zF9vWQa+Bf6wIp7Kx4gz9b7gzSvEibxphpwgxLyJqIBNjkyfbz4
	xZRPCPA==
X-Google-Smtp-Source: AGHT+IHDNumAFn1S4he3FqucoQUqx+a6D7ePiLpnKlXz7dt8WLYPGcMLu+iZklYPsF82FyQ1RPXZRw==
X-Received: by 2002:a05:600c:190c:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-459f4f5292fmr32203115e9.10.1754664822771;
        Fri, 08 Aug 2025 07:53:42 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:42 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 08/24] eth: bnxt: set page pool page order based on rx_page_size
Date: Fri,  8 Aug 2025 15:54:31 +0100
Message-ID: <ab19a69b57617b89201a1442c3ae8c5db498313b.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
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
[pavel: calculate adjust max_len]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d35e9a8869b..869c15d4dc34 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3818,12 +3818,14 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
+
+	pp.order = get_order(bp->rx_page_size);
 	pp.nid = numa_node;
 	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
 		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 	pp.queue_idx = rxr->bnapi->index;
@@ -3834,7 +3836,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
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


