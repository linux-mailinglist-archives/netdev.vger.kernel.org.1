Return-Path: <netdev+bounces-110954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A625892F1B7
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E39EB22D79
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738521A073B;
	Thu, 11 Jul 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0QhqwlH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEAA1A0734
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735643; cv=none; b=sgCrZ9ANXvZv0gBFRQaMGS1MeGFhR6TGyHWVNlqZExtJVxCYXdOQ+SlXyVWCsU6LgdmQ72iooK9gujOEej4ZBJg1GZ8NzCBbP34dJdRE6+8S6MN/dAaambTIFcX8yZAZbYomdpCGT5ZsRUWZc2dX6S9fj18wkmrpWPW0qFRKmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735643; c=relaxed/simple;
	bh=UIuVffc927VdQxejsKwsvnznN1vtwo8nBC75VMqH35E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtllmXIkFQc5EYnDhAuXWpLmTUCrBiKLaGHJO+N113fcMmXvbVhITYIUkXlSCDSVj1aYzF9pQuvmnTl2hun5rFFZKYbkph/Wy0GYd2bzxhJbNafZrkvNP8TTnXq8qYqwHxb2f/TPgGxMsoZ0ib9LJlge4tZtBPsijGi8uAP3Rus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0QhqwlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D111C4AF0C;
	Thu, 11 Jul 2024 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735643;
	bh=UIuVffc927VdQxejsKwsvnznN1vtwo8nBC75VMqH35E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0QhqwlHmZuQAvgXlExf3rz7hFzdWtZS7tqMKohGd7UxBDzYqwWAhsnTmgywPnS8R
	 FNhWTSFuTBhUGdSptOGvt3Hrxx+2XWvd3toAEdNCz+y+6FxZy8WTLsXlX4ViJavbXq
	 UYG7IQtZ0GajJTlO6T5ExDFPUypmPKgRpejTN4DtOwsKig4zoiHhZuAIY1AorUG3J2
	 tNCJBiRui0wK52X0fyZuZq6+uCJkdwEwxk/KuP4z6D3pQazm/U1AaqBOSwhPXGIjo0
	 FiUNyvJ05FlVyMBQMcjVaNC3yw3moFHD/ChjMTAFTDy+B8LNYTGmaJFJVI0CQQ4K5R
	 hbaeFrcROvHqg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/11] eth: bnxt: remove rss_ctx_bmap
Date: Thu, 11 Jul 2024 15:07:07 -0700
Message-ID: <20240711220713.283778-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
References: <20240711220713.283778-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core will allocate IDs for the driver, from the range
[1, BNXT_MAX_ETH_RSS_CTX], no need to track the allocations.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 13 ++-----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  2 --
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 -----
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bd087c85af5c..026ceaa0b329 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10239,7 +10239,6 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	kfree(rss_ctx->rss_indir_tbl);
 	list_del(&rss_ctx->list);
 	bp->num_rss_ctx--;
-	clear_bit(rss_ctx->index, bp->rss_ctx_bmap);
 	kfree(rss_ctx);
 }
 
@@ -10281,20 +10280,12 @@ void bnxt_clear_rss_ctxs(struct bnxt *bp, bool all)
 
 	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
 		bnxt_del_one_rss_ctx(bp, rss_ctx, all);
-
-	if (all)
-		bitmap_free(bp->rss_ctx_bmap);
 }
 
 static void bnxt_init_multi_rss_ctx(struct bnxt *bp)
 {
-	bp->rss_ctx_bmap = bitmap_zalloc(BNXT_RSS_CTX_BMAP_LEN, GFP_KERNEL);
-	if (bp->rss_ctx_bmap) {
-		/* burn index 0 since we cannot have context 0 */
-		__set_bit(0, bp->rss_ctx_bmap);
-		INIT_LIST_HEAD(&bp->rss_ctx_list);
-		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
-	}
+	INIT_LIST_HEAD(&bp->rss_ctx_list);
+	bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 }
 
 /* Allow PF, trusted VFs and VFs with default VLAN to be in promiscuous mode */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3c8826875ceb..9b0c6656ce27 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1298,7 +1298,6 @@ struct bnxt_rss_ctx {
 };
 
 #define BNXT_MAX_ETH_RSS_CTX	32
-#define BNXT_RSS_CTX_BMAP_LEN	(BNXT_MAX_ETH_RSS_CTX + 1)
 #define BNXT_VNIC_ID_INVALID	0xffffffff
 
 struct bnxt_hw_rings {
@@ -2332,7 +2331,6 @@ struct bnxt {
 	struct bnxt_ring_grp_info	*grp_info;
 	struct bnxt_vnic_info	*vnic_info;
 	struct list_head	rss_ctx_list;
-	unsigned long		*rss_ctx_bmap;
 	u32			num_rss_ctx;
 	int			nr_vnics;
 	u16			*rss_indir_tbl;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index afbb7546ee14..04855846b5f6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1902,11 +1902,6 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (test_and_set_bit(rxfh->rss_context, bp->rss_ctx_bmap)) {
-		NL_SET_ERR_MSG_MOD(extack, "Context ID conflict");
-		return -EINVAL;
-	}
-
 	if (!bnxt_rfs_capable(bp, true)) {
 		NL_SET_ERR_MSG_MOD(extack, "Out hardware resources");
 		return -ENOMEM;
-- 
2.45.2


