Return-Path: <netdev+bounces-211378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CFB186B6
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7CBA856EC
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879FB26B75B;
	Fri,  1 Aug 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzS92CN2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1B264A83
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069415; cv=none; b=giwOmLgW5+o911kNMGPCUtybfWU1pDiWWcA/LAHX2ddNi464jpn5Z8Ork/el3wllnEzNF1A4ABFmRPsQKgQjFsyC5VlbecK2mPb7dMhXmD+u8o0estJcCMZNVhn/MVMSu2qR7kUnBpHyIrJtJ14GW4gPtLtA4B9V9vI8+nB+tSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069415; c=relaxed/simple;
	bh=xM18SgSax23k4i4TIOOrQe19XuENYDNg5Jk+gKDDVus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDVFyakNMKQNPPXcUecJVKTZQcOgkoaBcMWwDfuQJiMGP+UWuc4GXYBy2t7OzpHfLdm8GqAnZ9MTI3pTAnZXX65lzZHQn/EmewsuLK+B+75BkAQ0N5DhNnZ6NzdBq34Jwp2Ey/3gqsVwshBH67Fp0x8cKcjwABOb/ceji3+GYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzS92CN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8037EC4CEE7;
	Fri,  1 Aug 2025 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069414;
	bh=xM18SgSax23k4i4TIOOrQe19XuENYDNg5Jk+gKDDVus=;
	h=From:To:Cc:Subject:Date:From;
	b=KzS92CN2NmogsGUgYjc08tuj0eDerh5GCYgyGOtz2oBLRRCgocBy6r83eRCC2plzi
	 sXf1xrPwjMX2nS01pX2jx7E+Kwqpa1JsiOzLGs8XJEMbjXdsD+9aHYJdNqEUuGz3mv
	 AKzmoYZHwMKfvRzHouJoycew+uoGyHo+7A57zMnbv8QJwXvoc+PPoQ59DmX5WJv1v/
	 s+aCiGglZiOfEqMQGpPcePPnLpgW2vRjrAapgn0rGno1vlV+Lbe/xwcykLL5xjq96v
	 7Zp2cK9CAuhH/xGvMLU2nnKtct6PdO4RABYKLCNNqv3P21FdxeQSeEoVEHSk1BN6h9
	 bH4g9NlLtTqSQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	David Wei <dw@davidwei.uk>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	almasrymina@google.com,
	sdf@fomichev.me
Subject: [PATCH net] net: page_pool: allow enabling recycling late, fix false positive warning
Date: Fri,  1 Aug 2025 10:30:11 -0700
Message-ID: <20250801173011.2454447-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page pool can have pages "directly" (locklessly) recycled to it,
if the NAPI that owns the page pool is scheduled to run on the same CPU.
To make this safe we check that the NAPI is disabled while we destroy
the page pool. In most cases NAPI and page pool lifetimes are tied
together so this happens naturally.

The queue API expects the following order of calls:
 -> mem_alloc
    alloc new pp
 -> stop
    napi_disable
 -> start
    napi_enable
 -> mem_free
    free old pp

Here we allocate the page pool in ->mem_alloc and free in ->mem_free.
But the NAPIs are only stopped between ->stop and ->start. We created
page_pool_disable_direct_recycling() to safely shut down the recycling
in ->stop. This way the page_pool_destroy() call in ->mem_free doesn't
have to worry about recycling any more.

Unfortunately, the page_pool_disable_direct_recycling() is not enough
to deal with failures which necessitate freeing the _new_ page pool.
If we hit a failure in ->mem_alloc or ->stop the new page pool has
to be freed while the NAPI is active (assuming driver attaches the
page pool to an existing NAPI instance and doesn't reallocate NAPIs).

Freeing the new page pool is technically safe because it hasn't been
used for any packets, yet, so there can be no recycling. But the check
in napi_assert_will_not_race() has no way of knowing that. We could
check if page pool is empty but that'd make the check much less likely
to trigger during development.

Add page_pool_enable_direct_recycling(), pairing with
page_pool_disable_direct_recycling(). It will allow us to create the new
page pools in "disabled" state and only enable recycling when we know
the reconfig operation will not fail.

Coincidentally it will also let us re-enable the recycling for the old
pool, if the reconfig failed:

 -> mem_alloc (new)
 -> stop (old)
    # disables direct recycling for old
 -> start (new)
    # fail!!
 -> start (old)
    # go back to old pp but direct recycling is lost :(
 -> mem_free (new)

Fixes: 40eca00ae605 ("bnxt_en: unlink page pool when stopping Rx queue")
Tested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Thanks to David Wei for confirming the problem on bnxt and testing
the fix. I hit this writing the fbnic support for ZC, TBH.
Any driver where NAPI instance gets reused and not reallocated on each
queue restart may have this problem. netdevsim doesn't 'cause the
callbacks can't fail in funny ways there.

CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: dw@davidwei.uk
CC: almasrymina@google.com
CC: sdf@fomichev.me
---
 include/net/page_pool/types.h             |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++++++++-
 net/core/page_pool.c                      | 13 +++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 431b593de709..1509a536cb85 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -265,6 +265,8 @@ struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 struct xdp_mem_info;
 
 #ifdef CONFIG_PAGE_POOL
+void page_pool_enable_direct_recycling(struct page_pool *pool,
+				       struct napi_struct *napi);
 void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..76a4c5ae8000 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3819,7 +3819,6 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 	pp.nid = numa_node;
-	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
@@ -3851,6 +3850,12 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	return PTR_ERR(pool);
 }
 
+static void bnxt_enable_rx_page_pool(struct bnxt_rx_ring_info *rxr)
+{
+	page_pool_enable_direct_recycling(rxr->head_pool, &rxr->bnapi->napi);
+	page_pool_enable_direct_recycling(rxr->page_pool, &rxr->bnapi->napi);
+}
+
 static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
 	u16 mem_size;
@@ -3889,6 +3894,7 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 		rc = bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
 		if (rc)
 			return rc;
+		bnxt_enable_rx_page_pool(rxr);
 
 		rc = xdp_rxq_info_reg(&rxr->xdp_rxq, bp->dev, i, 0);
 		if (rc < 0)
@@ -16031,6 +16037,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 			goto err_reset;
 	}
 
+	bnxt_enable_rx_page_pool(rxr);
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 05e2e22a8f7c..c0ff1d0e0a7a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1201,6 +1201,19 @@ void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 	pool->xdp_mem_id = mem->id;
 }
 
+void page_pool_enable_direct_recycling(struct page_pool *pool,
+				       struct napi_struct *napi)
+{
+	if (READ_ONCE(pool->p.napi) == napi)
+		return;
+	WARN_ON_ONCE(!napi || pool->p.napi);
+
+	mutex_lock(&page_pools_lock);
+	WRITE_ONCE(pool->p.napi, napi);
+	mutex_unlock(&page_pools_lock);
+}
+EXPORT_SYMBOL(page_pool_enable_direct_recycling);
+
 void page_pool_disable_direct_recycling(struct page_pool *pool)
 {
 	/* Disable direct recycling based on pool->cpuid.
-- 
2.50.1


