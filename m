Return-Path: <netdev+bounces-215111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E1FB2D21C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329471C22690
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D32566DF;
	Wed, 20 Aug 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTNwT3Jd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992824A05B
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658632; cv=none; b=JSkYl3RztZCxb84AJV88VqpZySs6BMtcf92Z9skjG4Vw874AXHgpkaBfSAmNwU1XFpvuo7zZVUqgJu9Ii2z3QljkqYCKVtZKD6OV7Hy/ruCvDpeYo5Z+psogUgiSmduviRg4XxRdA5yiidv4+Kk1lDrp8e8OcsJUNc43EcQBgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658632; c=relaxed/simple;
	bh=zuhaasXURnKo/anDuZ/xcPhAxz4Pzf/zHMfqGa4zp24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoWlUPazwH1iZ7bw/27Jj+1hhdb53NYh/y0uBNe1AkBEKFBhHQ0pSVlIa/KS73bhTZ9WxEQ1YAPtd6qYNWfEy6cvRgCM+qBDbNXcrZk+iWNeCntAigInKWZ1gMO8WiUcL/236rAojoaUvjnovfPsr2F6vUgoEba5CDidVCFa8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTNwT3Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23351C16AAE;
	Wed, 20 Aug 2025 02:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658631;
	bh=zuhaasXURnKo/anDuZ/xcPhAxz4Pzf/zHMfqGa4zp24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTNwT3JdSrHdRJhF7ubdUeaypISRkgyQva0mFkENfhUV8Hfuq0MrdU9SFDZCjVx4G
	 gGzWJVWFQPN13uipuLycqULj6FnQoTLiPm86XWWiCNof/MNrBEpxTnYHWMiHhg0Ryk
	 4p1GXl4BuMXl3di0OY95Gsu8fwBNUI8NqMkLotyYW5rwskNM/GIrrSv3aMbe5SymRM
	 FkPF/XItPoZ2z8TbkXSh34GizaeJ6c3IlvAbtkbz1+4uySHyEmBGzcgp/nr7h5VFwY
	 BFdnqdKUH/T0o+ZcoOboUM7cPGj+sW2ktg9pn7FRdLTQd/eVXf4HRQ+rL6pEodzsJp
	 gSQzLITYMho1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/15] net: page_pool: add page_pool_get()
Date: Tue, 19 Aug 2025 19:56:50 -0700
Message-ID: <20250820025704.166248-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
References: <20250820025704.166248-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a page_pool_put() function but no get equivalent.
Having multiple references to a page pool is quite useful.
It avoids branching in create / destroy paths in drivers
which support memory providers.

Use the new helper in bnxt.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/helpers.h           |  5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index db180626be06..aa3719f28216 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -489,6 +489,11 @@ page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
 				     offset, dma_sync_size);
 }
 
+static inline void page_pool_get(struct page_pool *pool)
+{
+	refcount_inc(&pool->user_cnt);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2d4fdf5a0dc5..1a571a90e6be 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3797,8 +3797,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		if (bnxt_separate_head_pool(rxr))
-			page_pool_destroy(rxr->head_pool);
+		page_pool_destroy(rxr->head_pool);
 		rxr->page_pool = rxr->head_pool = NULL;
 
 		kfree(rxr->rx_agg_bmap);
@@ -3845,6 +3844,8 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 		pool = page_pool_create(&pp);
 		if (IS_ERR(pool))
 			goto err_destroy_pp;
+	} else {
+		page_pool_get(pool);
 	}
 	rxr->head_pool = pool;
 
@@ -15900,8 +15901,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
 	page_pool_destroy(clone->page_pool);
-	if (bnxt_separate_head_pool(clone))
-		page_pool_destroy(clone->head_pool);
+	page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
 	clone->head_pool = NULL;
 	return rc;
@@ -15919,8 +15919,7 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
-	if (bnxt_separate_head_pool(rxr))
-		page_pool_destroy(rxr->head_pool);
+	page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
 	rxr->head_pool = NULL;
 
-- 
2.50.1


