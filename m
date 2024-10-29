Return-Path: <netdev+bounces-139795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC49B429A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 07:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350BA1C21954
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C920125C;
	Tue, 29 Oct 2024 06:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DF28E7;
	Tue, 29 Oct 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184864; cv=none; b=rBYjmd1TON7BfJDqNk05POkT2KqEzpl0dkI7xfztunNbcs+NTo5EMbLmQzUgHNPdzpDT9iMAlQGuB3fmlXomF1ZJ8HEwTdF92c86hW36VJUjnP5b9SWOChyPXZoPoNmXfZqaCpc51YOgUSpv7pnR9k/Xb8dTKGqaTG5KVN7g6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184864; c=relaxed/simple;
	bh=ac7i+WSWlNHFVbuWBcf7pw+gZj8RycgBGSILsV7Dq2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9DPJAdE517y+LB86AJjPqq1T8ZKQPDWXZFX8jaP43Y7KBwYTpzcn6OeakHRJI0GSJs5wUal0kKjA5q5TBNtHTM9t7AkmvmKMEBRgHQ5wrJJRrvIZFr3ShY+7lMCC7oK82iofcwO4aLDDF3tq8ZmLj+SXsDwFm9KgROoku8y4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xd18b18yVz1HLll;
	Tue, 29 Oct 2024 14:49:51 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 683B714037D;
	Tue, 29 Oct 2024 14:54:18 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Oct
 2024 14:54:17 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
Subject: [PATCH] net/smc: Optimize the search method of reused buf_desc
Date: Tue, 29 Oct 2024 14:54:15 +0800
Message-ID: <20241029065415.1070-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200001.china.huawei.com (7.202.181.227)

We create a lock-less link list for the currently 
idle reusable smc_buf_desc.

When the 'used' filed mark to 0, it is added to 
the lock-less linked list. 

When a new connection is established, a suitable 
element is obtained directly, which eliminates the 
need for traversal and search, and does not require 
locking resource.

A lock-free linked list is a linked list that uses 
atomic operations to optimize the producer-consumer model.

Signed-off-by: liqiang <liqiang64@huawei.com>
---
 net/smc/smc_core.c | 46 ++++++++++++++++++++++++++++------------------
 net/smc/smc_core.h |  4 ++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3b95828d9976..ac120f62313b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/mutex.h>
+#include <linux/llist.h>
 #include <linux/list.h>
 #include <linux/smc.h>
 #include <net/tcp.h>
@@ -872,6 +873,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
 		INIT_LIST_HEAD(&lgr->rmbs[i]);
+		init_llist_head(&lgr->rmbs_free[i]);
+		init_llist_head(&lgr->sndbufs_free[i]);
 	}
 	lgr->next_link_id = 0;
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
@@ -1146,6 +1149,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		/* memzero_explicit provides potential memory barrier semantics */
 		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
 		WRITE_ONCE(buf_desc->used, 0);
+		if (is_rmb)
+			llist_add(&buf_desc->llist, &lgr->rmbs_free[buf_desc->bufsiz_comp]);
+		else
+			llist_add(&buf_desc->llist, &lgr->sndbufs_free[buf_desc->bufsiz_comp]);
 	}
 }
 
@@ -1172,6 +1179,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		} else {
 			memzero_explicit(conn->sndbuf_desc->cpu_addr, conn->sndbuf_desc->len);
 			WRITE_ONCE(conn->sndbuf_desc->used, 0);
+			llist_add(&conn->sndbuf_desc->llist,
+				  &lgr->sndbufs_free[conn->sndbuf_desc->bufsiz_comp]);
 		}
 	}
 	if (conn->rmb_desc) {
@@ -1181,6 +1190,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 			memzero_explicit(conn->rmb_desc->cpu_addr,
 					 conn->rmb_desc->len + sizeof(struct smcd_cdc_msg));
 			WRITE_ONCE(conn->rmb_desc->used, 0);
+			llist_add(&conn->rmb_desc->llist,
+				  &lgr->rmbs_free[conn->rmb_desc->bufsiz_comp]);
 		}
 	}
 }
@@ -2042,24 +2053,19 @@ int smc_uncompress_bufsize(u8 compressed)
 	return (int)size;
 }
 
-/* try to reuse a sndbuf or rmb description slot for a certain
- * buffer size; if not available, return NULL
- */
-static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     struct rw_semaphore *lock,
-					     struct list_head *buf_list)
+/* use lock less list to save and find reuse buf desc */
+static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
 {
-	struct smc_buf_desc *buf_slot;
+	struct smc_buf_desc *buf_free;
+	struct llist_node *llnode;
 
-	down_read(lock);
-	list_for_each_entry(buf_slot, buf_list, list) {
-		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
-			up_read(lock);
-			return buf_slot;
-		}
-	}
-	up_read(lock);
-	return NULL;
+	if (llist_empty(buf_llist))
+		return NULL;
+	// lock-less link list don't need an lock
+	llnode = llist_del_first(buf_llist);
+	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
+	WRITE_ONCE(buf_free->used, 1);
+	return buf_free;
 }
 
 /* one of the conditions for announcing a receiver's current window size is
@@ -2364,6 +2370,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
+	struct llist_head *buf_llist;
 	int bufsize, bufsize_comp;
 	struct rw_semaphore *lock;	/* lock buffer list */
 	bool is_dgraded = false;
@@ -2379,15 +2386,17 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
+			buf_llist = &lgr->rmbs_free[bufsize_comp];
 			buf_list = &lgr->rmbs[bufsize_comp];
 		} else {
 			lock = &lgr->sndbufs_lock;
+			buf_llist = &lgr->sndbufs_free[bufsize_comp];
 			buf_list = &lgr->sndbufs[bufsize_comp];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_comp);
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
+		buf_desc = smc_buf_get_slot_free(buf_llist);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
 			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
@@ -2412,7 +2421,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
-		buf_desc->used = 1;
+		WRITE_ONCE(buf_desc->used, 1);
+		WRITE_ONCE(buf_desc->bufsiz_comp, bufsize_comp);
 		down_write(lock);
 		list_add(&buf_desc->list, buf_list);
 		up_write(lock);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d93cf51dbd7c..32ff6a5f076c 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -188,10 +188,12 @@ struct smc_link {
 /* tx/rx buffer list element for sndbufs list and rmbs list of a lgr */
 struct smc_buf_desc {
 	struct list_head	list;
+	struct llist_node	llist;
 	void			*cpu_addr;	/* virtual address of buffer */
 	struct page		*pages;
 	int			len;		/* length of buffer */
 	u32			used;		/* currently used / unused */
+	int			bufsiz_comp;
 	union {
 		struct { /* SMC-R */
 			struct sg_table	sgt[SMC_LINKS_PER_LGR_MAX];
@@ -278,8 +280,10 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
+	struct llist_head	sndbufs_free[SMC_RMBE_SIZES]; /* tx buffer free list */
 	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
+	struct llist_head	rmbs_free[SMC_RMBE_SIZES]; /* rx buffer free list */
 	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
-- 
2.43.0


