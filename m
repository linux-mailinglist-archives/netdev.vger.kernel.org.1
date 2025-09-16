Return-Path: <netdev+bounces-223457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27521B593D8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9C3189903C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF53054D0;
	Tue, 16 Sep 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xew6trH3"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE930597B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018676; cv=none; b=pH2c4RVKfTveGQIX1chXqNBLzvJJKeowJg3pDnx1CDpY4NMya+p5hBepyKAqW2lD5AyaYkir74moZ0tUg7Rh+7B7gMbO9UbY9iGgs641m+C3Qsfw8gHWcm0Ql46ytDfL50y4712nDRHcVQzoVwJjf7ARxb3ko3OPZpEpQDjRowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018676; c=relaxed/simple;
	bh=e2Och8MCNRVJ2HqPs7A28h0GKMf4Vc3xffz2+8mv0e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EH+Jk5YWR31E+vdFp1L+F7ftGy10mSvPtwBuPOZTWsOiPmQIWQKPsqmf+pb2lG0k1xMace7S6IDcayHgvHLJJFfZ+GoRkAm5cZfCM5Lqn/8CpnhdCHmxVWF/mW2+3/lYq4tdHp/sh6CAet/JR88QRM2dO0HHLuicQ4PQH+M7slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xew6trH3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758018672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8uH/d61lIzsXarIEdO6A+UL33AK9E0ycEfJKcpiYbk=;
	b=xew6trH3P6W5jabzfWDFLUOOTigKgkIv2MVq80BJ3St6TFWTcExeE+GFk4/pIoC7NfeDWa
	Vcw8A1EhrE+y14PHXkisV79kKD41kA1rNWl+ED4BhBp9mTuYP0sATzrqy2r8z0ALIlkibG
	6DL9MHJsFbRr5gKDhKnI+qa4P0oCGbU=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v3 1/3] rculist: Add __hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
Date: Tue, 16 Sep 2025 18:30:52 +0800
Message-Id: <20250916103054.719584-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
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

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..8ed604f65a3e 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
 }
 
+/**
+ * __hlist_nulls_replace_rcu - replace an old entry by a new one
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
+static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
+					     struct hlist_nulls_node *new)
+{
+	struct hlist_nulls_node *next = old->next;
+
+	new->next = next;
+	WRITE_ONCE(new->pprev, old->pprev);
+	rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev, new);
+	if (!is_a_nulls(next))
+		WRITE_ONCE(new->next->pprev, &new->next);
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
+ * Return: true if the old entry was hashed and was replaced successfully, false
+ * otherwise.
+ *
+ * Note: hlist_nulls_unhashed() on the old node returns true after this.
+ * It is useful for RCU based read lockfree traversal if the writer side must
+ * know if the list entry is still hashed or already unhashed.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list. However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline bool hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
+						struct hlist_nulls_node *new)
+{
+	if (!hlist_nulls_unhashed(old)) {
+		__hlist_nulls_replace_rcu(old, new);
+		WRITE_ONCE(old->pprev, NULL);
+		return true;
+	}
+	return false;
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
-- 
2.25.1


