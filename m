Return-Path: <netdev+bounces-226605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A5BA2D7E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D467A72A3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FCE2874FC;
	Fri, 26 Sep 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oqZrgIa8"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416D28724C
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872497; cv=none; b=AtWbyouhotQ0Av+Az8dN+9HakdnRy9StIBinF39vQYbrHqzrdxqHehOvhyMEAzOBJu1lvZmwklJ+lARTqOR4q++kF0QWZd/8BM0BBZrpWR6a6SpiQ3x/YgfKVOUVPqi0ha7+iLg4GAP3Grik9Or0KQ79bDsG2/khAA+Csa+keug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872497; c=relaxed/simple;
	bh=z54J7IGZwbaq89V3MtbkWW9kJ+KdZ2FSjnd8NDKMEak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qi3PeVbYQY9E8dsfrbC3lOzO8UuJrhqCIGmRxrjSYLCiJHuvNhFthh+8FH+FUxSoprGKpi/3QlUQukeidc2x7PDlg8Qw8yQq1vXynKfurxH3Q2ehut6Y9bjuDXRnnBgXQSfIce8HDOi08Rg/w5IyLzslV+aDaeyDR3SBdZ5sLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oqZrgIa8; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758872493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TESBl5zoUY/MzgnymC1k0ZH+31XZPacA8yk+AIRCd8=;
	b=oqZrgIa8bXXnbGmV7Pm63urfJxSS6ADIF+1G2JVAeXnuQFXd9eE/cy5yeDXiB2IztIJ61b
	vrSPyj9WqrbBouj7FP8mB35BSwFdRQ7xYAfoK7HuNrfMUdNx7Edj1gKm6C6c9braIZN4Jr
	wWI+r4CM7eKRdQ5FCCOaFMp90Jy43pM=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
Date: Fri, 26 Sep 2025 15:40:31 +0800
Message-Id: <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Add two functions to atomically replace RCU-protected hlist_nulls entries.

Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
mentioned in the patch below:
commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
rculist_nulls")
commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
hlist_nulls")

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..c26cb83ca071 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
+/**
+ * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
+ * @node: element of the list.
+ */
+#define hlist_nulls_pprev_rcu(node) \
+	(*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
+
 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
@@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
 }
 
+/**
+ * hlist_nulls_replace_rcu - replace an old entry by a new one
+ * @old: the element to be replaced
+ * @new: the new element to insert
+ *
+ * Description:
+ * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
+ * permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list.  However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
+					   struct hlist_nulls_node *new)
+{
+	struct hlist_nulls_node *next = old->next;
+
+	WRITE_ONCE(new->next, next);
+	WRITE_ONCE(new->pprev, old->pprev);
+	rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
+	if (!is_a_nulls(next))
+		WRITE_ONCE(next->pprev, &new->next);
+}
+
+/**
+ * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
+ * initialize the old
+ * @old: the element to be replaced
+ * @new: the new element to insert
+ *
+ * Description:
+ * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
+ * permitting racing traversals, and reinitialize the old entry.
+ *
+ * Note: @old must be hashed.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list. However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
+						struct hlist_nulls_node *new)
+{
+	hlist_nulls_replace_rcu(old, new);
+	WRITE_ONCE(old->pprev, NULL);
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
-- 
2.25.1


