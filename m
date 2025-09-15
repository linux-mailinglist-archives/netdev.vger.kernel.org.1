Return-Path: <netdev+bounces-222933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D6B570D0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9438F189C1B8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495A1448D5;
	Mon, 15 Sep 2025 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="msrFDgNz"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054B291864
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919880; cv=none; b=WIDFOT/P/PpwyVHE9bmUXXFu+3LxtOjetZ8VrQD7u7zffXT7Lq9si0yvKtFnUxwQ2OIHllrkOb4r0jEE9/CkRWQWFETFhnlcgOWqvhBtm2S/cGQ7PcZA3KxARVJrlOL2MX3cF/ALDhetfmXP9PVnvJvUx93Hj4iOYzhZF9AWlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919880; c=relaxed/simple;
	bh=6hRIW2n3YfaeDIRNS3eXyJ1uJAwKSKAnO6U2tSfJ800=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKtq/ykE8SE21BFIQZbunVT9eNWZbZtOHeQko5c2+8nFY3mJNT2KMFe5f82AD6T9pxE7rdDHk4vpL81S1f+71nTG0BHXhvQn+nQyJkhEmj3SbLOK1uPwJHspOOmOTh21bq/VWQGS5u5dKUvCdQKsw6iNiF5Z2X/C9cjybeQhiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=msrFDgNz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757919876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRYnTdnA8T9QaIuYD6NO+PFVntrdCJrTGiQjdKxSgpA=;
	b=msrFDgNzyxC7Jgg8ptTLzfSz+H9KKT0f1ltz2ZMS/hN05wHqHMMAmxTOOdxaH8wsfWjTIa
	Z04kgk5kkZ4xs1LcsNhVA+NTcRTSPJD0NA80pXgU/jW1wrFPOBbk+mVx4UrYMkmOq/2Rt0
	CPLQqKJdY5NrCX7VgHhXZvxEuAKsKGI=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 1/3] rculist: Add __hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
Date: Mon, 15 Sep 2025 15:03:06 +0800
Message-Id: <20250915070308.111816-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
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
 include/linux/rculist_nulls.h | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..eaa3a0d2f206 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -152,6 +152,68 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
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
+		old->pprev = NULL;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
-- 
2.27.0


