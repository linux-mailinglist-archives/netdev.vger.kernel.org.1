Return-Path: <netdev+bounces-112163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A19372FD
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 06:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C868B2170E
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 04:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C80208BA;
	Fri, 19 Jul 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+15aOVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AA3236
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721362768; cv=none; b=YRlPslNO35627aYq5CLRvFsNNNKtrKeltvj5055geSvkUS5t3p4hep/3CgLsyXpZzVxMhfGL8yeRBib/1JxhT6V/0gn8D4WnNQCnPiV/YoaIj2II9c2UTShOLq+JIRAR7wa5VA58ddMgS2LrqSHMt05YeRjrP96QpwXPCXnEI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721362768; c=relaxed/simple;
	bh=rayf3ltXbMBE84lbu2Hs6KG23jvrSSO3USRzEbCCOu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkSEqMM2cDbpfmML2ktlUHq9wW3z6jCro43avBDiaXsydrzQGIWQmGvC3xm0rn63An81XKgTYRb8IFLm4oENQY3yL6f29JJLuRDc6aT5i5KR1JgkCUxPfL0ktN5ObmVO/qKsPRmgVR+u2hl4AzNGIvm2pPM+I/VkzBH/6z/Sp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+15aOVZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso725253a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721362767; x=1721967567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzzDdJbYzzvlTfbiOCs3k5jV/Uot05o3QbGXp8DdQd0=;
        b=D+15aOVZ+CIWMF4Jt8ZO6C8OUIC0f3N8KbBjJNC3w991Wr86uOxl/r/4V9Xcnmd7CN
         mBvA2uYtBnH0JGUVD/uQZOdsEM0s6IBOki38QdBKkRsPyf8JdzEVVuoSFVwcUSz0HtPS
         wLMcZkjWOOuQ/kJzZ7l1gYKgi2JGAvszhx1KvO09ETcR21tXkyEcb/wyNpbyCxBNJSKv
         5X60TI6vG3/3dEEUeLnPWKfvjRYYpxzlmyRncAzrAFYfp3VEpe8xBUqo0UG9E9FmpR2Z
         vqlYlkdLo0rjDxPUY3kbAapNxAzDgB8v6C2gB8K7A7VDTDKaAeid0Qp2WJOFybrRHS2k
         1S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721362767; x=1721967567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzzDdJbYzzvlTfbiOCs3k5jV/Uot05o3QbGXp8DdQd0=;
        b=Q7uwhzr/GCzWp8AeMrfihR2JXym78fHUaN6g150n0JTAGOusralyEFblA0e5VUhmaW
         UnNfTQJmTmXwjzDKy2M+78tPZqPylk+Rd0J9r8Bsg2qoeeW8qDnT/rT0qtaNWUghVlrX
         jvZDK/RVhHMQ7CaQ4CNQLVG0Oa5g163XBqMtkqzVJAWNI8vrH5ns7DRhPwBFOXCcw21y
         A/JwzPUyGYU1heijlqr5wsBahghR8ffMF+S7HJs1yTg+ZbaVLRVHG5BAcxpPjnnAOlR6
         B1mRYmsmDvT/9yH31jf6Xx8fDQ4eY4i5NcorLC+fW8K7kCwuk6KfZjLBfIBI/j3Bf6KR
         wduQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyr8/BWdVJk+vi6i4ydTgtDAFq6r6J0QMBGNJVQToOujZQtKC+Y6y2yRytJD3+Zxp7WuqGAVA0wZ8UAn56f0uRwmjojBgB
X-Gm-Message-State: AOJu0YwEVOQ2soInoyLjM9fTmMu0DUHMSjGf7e1uLP7fBZxuTT/cIBgM
	8cuqp5zn7Z76OU0t8E+I9Y+4BJR5Bt23S884lbvq9RQ38haEuznDq0ZMLGwa
X-Google-Smtp-Source: AGHT+IEha0COo+WzghjWEvoLNOWm+Gu5uJgK6DjQw8gNHXRhGZnnT6p9En0G+4zRebOf4itmaKEjeQ==
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id 98e67ed59e1d1-2cb52927e76mr6001588a91.29.1721362766575;
        Thu, 18 Jul 2024 21:19:26 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77540a84sm1609875a91.52.2024.07.18.21.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 21:19:25 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org
Subject: [PATCH net] bnxt_en: update xdp_rxq_info in queue restart logic
Date: Fri, 19 Jul 2024 04:19:11 +0000
Message-Id: <20240719041911.533320-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
updates(creates and deletes) a page_pool.
But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
connected to an old page_pool.
So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.

An old page_pool is no longer used so it is supposed to be
deleted by page_pool_destroy() but it isn't.
Because the xdp_rxq_info is holding the reference count for it and the
xdp_rxq_info is not updated, an old page_pool will not be deleted in
the queue restart logic.

Before restarting 1 queue:
./tools/net/ynl/samples/page-pool
enp10s0f1np1[6] page pools: 4 (zombies: 0)
	refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
	recycling: 0.0% (alloc: 128:8048 recycle: 0:0)

After restarting 1 queue:
./tools/net/ynl/samples/page-pool
enp10s0f1np1[6] page pools: 5 (zombies: 0)
	refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
	recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)

Before restarting queues, an interface has 4 page_pools.
After restarting one queue, an interface has 5 page_pools, but it
should be 4, not 5.
The reason is that queue restarting logic creates a new page_pool and
an old page_pool is not deleted due to the absence of an update of
xdp_rxq_info logic.

Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bb3be33c1bbd..11d8459376a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
 
 	rxr->page_pool->p.napi = NULL;
 	rxr->page_pool = NULL;
+	memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
 
 	ring = &rxr->rx_ring_struct;
 	rmem = &ring->ring_mem;
@@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	if (rc)
 		return rc;
 
+	rc = xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
+	if (rc < 0)
+		goto err_page_pool_destroy;
+
+	rc = xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
+					MEM_TYPE_PAGE_POOL,
+					clone->page_pool);
+	if (rc)
+		goto err_rxq_info_unreg;
+
 	ring = &clone->rx_ring_struct;
 	rc = bnxt_alloc_ring(bp, &ring->ring_mem);
 	if (rc)
@@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
 err_free_rx_ring:
 	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
+err_rxq_info_unreg:
+	xdp_rxq_info_unreg(&clone->xdp_rxq);
+err_page_pool_destroy:
 	clone->page_pool->p.napi = NULL;
 	page_pool_destroy(clone->page_pool);
 	clone->page_pool = NULL;
@@ -15065,6 +15079,8 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	page_pool_destroy(rxr->page_pool);
 	rxr->page_pool = NULL;
 
+	xdp_rxq_info_unreg(&rxr->xdp_rxq);
+
 	ring = &rxr->rx_ring_struct;
 	bnxt_free_ring(bp, &ring->ring_mem);
 
@@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
 	rxr->rx_next_cons = clone->rx_next_cons;
 	rxr->page_pool = clone->page_pool;
+	memcpy(&rxr->xdp_rxq, &clone->xdp_rxq, sizeof(struct xdp_rxq_info));
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
-- 
2.34.1


