Return-Path: <netdev+bounces-224976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CECDB8C668
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5067C78A0
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB62FB630;
	Sat, 20 Sep 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGkbRl8N"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7E2FB081
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366036; cv=none; b=UElnInoYTJj7Oib+UhAnAnonLSHGoJCWXF7wACd+OSiK08is3r2U+tHrPc7DhoramYZE+49NBD0egRnUARMlElPrNALZ/C5r3DjQJmL49h65HuS/8ZcaoIRn4NpH5uJT0P8jnZzYnuD9L3H1WmCzcL717rRGlQrdHhm0RWdGCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366036; c=relaxed/simple;
	bh=/XMSjictOBgg582eI3BE8xwZ4/2QciaBNjl3jbfV/Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/K/Nh4HmKf2jWk4GLuqCY075z9NUTl5AgaT8Xx2Inmgr+bBrOSospqOcPKJr65zs98yHSdqncXQe6a/A/gUF4W1i0pA5ipPIMj/z293hkKNEYghp1VvkgSsN1MGywtLfY9Vb66BF+Ya41tmXGUWpPfASc2BQn5PcMdAIEea/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGkbRl8N; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758366032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I/FicWToQ7Vtn+zNVYEIskS32QQ4uRRthzz4WyJizA=;
	b=vGkbRl8NRIAcdnm2rkTH/toOwvTTgzW9QFGz2dGGiav5P/1qqJrKtljOZZ6zY+RoFedGCh
	ftvNjPe1PX/B+O0RGbLGLb8pDyNdSaP8WzdXCiJwXpjkKIdhiYfve2NiaWs0J3OxGHB+25
	npe83gMQy7a3tFxIZuqo0mu1lQiHDn4=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v4 1/3] rculist: Add __hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
Date: Sat, 20 Sep 2025 18:59:43 +0800
Message-Id: <20250920105945.538042-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
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

Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as mentioned in
the patch below:
efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")
860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for hlist_nulls")

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..d86331ce22c4 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -152,6 +152,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
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
+	WRITE_ONCE(new->next, next);
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
+ * Note: @old should be hashed.
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
+	__hlist_nulls_replace_rcu(old, new);
+	WRITE_ONCE(old->pprev, NULL);
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
-- 
2.25.1


