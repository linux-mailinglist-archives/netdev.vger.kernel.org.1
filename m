Return-Path: <netdev+bounces-134882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83B99B7EA
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 03:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D02BB21AA7
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6C1849;
	Sun, 13 Oct 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="FnwmDu39"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E517C9;
	Sun, 13 Oct 2024 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728783003; cv=none; b=pmzjE8b+AAJmT/HaIDJFocETGV4wcw9p3WP2pMsf3LjRqL13JX1NK50/JwrETAjr/SJ44p6+H6SaPg1ZSidXcsbEitPkYfuNCY5c0JdtWKjIqCrbU2mx7jtr9UTPXHParTST5t/Z9ZxNsZuyPqrisxorJZJwtM+5zpAQI7WRqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728783003; c=relaxed/simple;
	bh=B+G1ePAoG6zIOvr2BdtmD3pf5geReJjQGtNTzBr1aKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9e/lWy661S9Lp+R+xCpCKrKsA/cEMcvHoDAn82W/0/66nmAd8wtakMgvI1qJQRPe5KsYQ5ZN3PdQXItlcro61IQvAQ59dhqD7/2f6LSA6Zqz1Pu36brgOK6cVxQb7YK09CT0FpNPFNRM/2qkEaBnKeYHGWwmWy0Mgk8dURrfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=FnwmDu39; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=fO53weLP+Aw4ySdODx/4ElwMlhKm+tjgTNBZRL+OdFA=; b=FnwmDu39IlX8Br5U
	BzCHEjquG6BL45N9Y+vaxtNHime5RvvyHnsuZPEhynjH3RjVU+S1gDuDGXwB/Hvi+4xnarmrXTNhq
	g4HzhYJuePkhem+1AhStaEcBUppFl1lchKUivW0cgL9yBTL9PHt070CidzGvfPglq0cnOVRTuqDZX
	CHRv3jP5o/cFcaTc6UoBHupmXuyeCqGjBvQdH4Gk3uiaKcezFo2D92Z3ytsLxelJPZNW7IaSSgNe6
	yuy5z4GpFRbXk//sjN74zV1GH5jlAg/HRA7MpysNjgIcaZY5ldPFJoNA651RLJDUa2gZvHpQFQr3t
	LJFVqIfc7JKJUVFWlg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sznQY-00Ajk1-2u;
	Sun, 13 Oct 2024 01:29:46 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: cxgb3: Remove stid deadcode
Date: Sun, 13 Oct 2024 02:29:46 +0100
Message-ID: <20241013012946.284721-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cxgb3_alloc_stid() and cxgb3_free_stid() have been unused since
commit 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module
from kernel")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../ethernet/chelsio/cxgb3/cxgb3_offload.c    | 39 -------------------
 .../ethernet/chelsio/cxgb3/cxgb3_offload.h    |  3 --
 2 files changed, 42 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
index 89256b866840..5a9f6925e1fa 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
@@ -515,23 +515,6 @@ void *cxgb3_free_atid(struct t3cdev *tdev, int atid)
 
 EXPORT_SYMBOL(cxgb3_free_atid);
 
-/*
- * Free a server TID and return it to the free pool.
- */
-void cxgb3_free_stid(struct t3cdev *tdev, int stid)
-{
-	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
-	union listen_entry *p = stid2entry(t, stid);
-
-	spin_lock_bh(&t->stid_lock);
-	p->next = t->sfree;
-	t->sfree = p;
-	t->stids_in_use--;
-	spin_unlock_bh(&t->stid_lock);
-}
-
-EXPORT_SYMBOL(cxgb3_free_stid);
-
 void cxgb3_insert_tid(struct t3cdev *tdev, struct cxgb3_client *client,
 		      void *ctx, unsigned int tid)
 {
@@ -671,28 +654,6 @@ int cxgb3_alloc_atid(struct t3cdev *tdev, struct cxgb3_client *client,
 
 EXPORT_SYMBOL(cxgb3_alloc_atid);
 
-int cxgb3_alloc_stid(struct t3cdev *tdev, struct cxgb3_client *client,
-		     void *ctx)
-{
-	int stid = -1;
-	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
-
-	spin_lock_bh(&t->stid_lock);
-	if (t->sfree) {
-		union listen_entry *p = t->sfree;
-
-		stid = (p - t->stid_tab) + t->stid_base;
-		t->sfree = p->next;
-		p->t3c_tid.ctx = ctx;
-		p->t3c_tid.client = client;
-		t->stids_in_use++;
-	}
-	spin_unlock_bh(&t->stid_lock);
-	return stid;
-}
-
-EXPORT_SYMBOL(cxgb3_alloc_stid);
-
 /* Get the t3cdev associated with a net_device */
 struct t3cdev *dev2t3cdev(struct net_device *dev)
 {
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.h b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.h
index 929c298115ca..7419824f9926 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.h
@@ -95,10 +95,7 @@ struct cxgb3_client {
  */
 int cxgb3_alloc_atid(struct t3cdev *dev, struct cxgb3_client *client,
 		     void *ctx);
-int cxgb3_alloc_stid(struct t3cdev *dev, struct cxgb3_client *client,
-		     void *ctx);
 void *cxgb3_free_atid(struct t3cdev *dev, int atid);
-void cxgb3_free_stid(struct t3cdev *dev, int stid);
 void cxgb3_insert_tid(struct t3cdev *dev, struct cxgb3_client *client,
 		      void *ctx, unsigned int tid);
 void cxgb3_queue_tid_release(struct t3cdev *dev, unsigned int tid);
-- 
2.47.0


