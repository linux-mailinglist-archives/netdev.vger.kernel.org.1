Return-Path: <netdev+bounces-223458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC401B593C4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AF32A4E0E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57894305E2F;
	Tue, 16 Sep 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UgwPsBCX"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECF30597B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018680; cv=none; b=CsvYO2b5NZlLfSTqbP9mS0ttf/fOyfjQvHYct0wKJVwK3DfeV6CspPa3oqsNiZjgvqQ26SlnwmLLQlqdXpwGY8rFxqrOstMFVlw4j7Qlg8xDqGZnphK78a7dt8CBTuvNz/sFIVYWm6ULQY8mlJP4slNODKGXwYbsOnqfn1LfoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018680; c=relaxed/simple;
	bh=Ne7KFDL6EDPqx8ky8DFQ8DIZuEf533r/GOb9ZyuUHWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmSD6oi4Bu7NVwbyObtTuE+i5KwNfNeZDqtZse91he221QFIWokiBWDOynDV2nwGaWRKsVcuib0tWlkKdsWM0aRJQY+O/JKPD39veccMRSKBIz1mN1xNCPtK2OnCTJ+FjkUmNQ5L3R1By+1GF2jfePLaCgPcqsHCt/ikFpOjgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UgwPsBCX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758018676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1qo6SSpiCkzaaoLehYJkP/HE8qJEUpd70j8glnvUa4=;
	b=UgwPsBCX1VwFxbW+9vOmVbWuBV5YlMPnmTR7ICcFrkxxqO6X9iQE6uhJh45vrLwOeZ6CCo
	z2OEDKhtNECuazoqqPHPgJmmIyGl68wdAiFfSKSmTA3xXYA6iRyEik6F+dEfzz/MWAWkRR
	df1D66Nyq/7csEj/Ie/PwFs+SAc40rc=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v3 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
Date: Tue, 16 Sep 2025 18:30:53 +0800
Message-Id: <20250916103054.719584-3-xuanqiang.luo@linux.dev>
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

Since ehash lookups are lockless, if one CPU performs a lookup while
another concurrently deletes and inserts (removing reqsk and inserting sk),
the lookup may fail to find the socket, an RST may be sent.

The call trace map is drawn as follows:
   CPU 0                           CPU 1
   -----                           -----
				inet_ehash_insert()
                                spin_lock()
                                sk_nulls_del_node_init_rcu(osk)
__inet_lookup_established()
	(lookup failed)
                                __sk_nulls_add_node_rcu(sk, list)
                                spin_unlock()

As both deletion and insertion operate on the same ehash chain, this patch
introduces two new sk_nulls_replace_* helper functions to implement atomic
replacement.

Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/net/sock.h         | 23 +++++++++++++++++++++++
 net/ipv4/inet_hashtables.c |  4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0fd465935334..e709376eaf0a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -854,6 +854,29 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
 	return rc;
 }
 
+static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
+						    struct sock *new)
+{
+	if (sk_hashed(old)) {
+		hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
+					     &new->sk_nulls_node);
+		return true;
+	}
+	return false;
+}
+
+static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
+						  struct sock *new)
+{
+	bool rc = __sk_nulls_replace_node_init_rcu(old, new);
+
+	if (rc) {
+		WARN_ON(refcount_read(&old->sk_refcnt) == 1);
+		__sock_put(old);
+	}
+	return rc;
+}
+
 static inline void __sk_add_node(struct sock *sk, struct hlist_head *list)
 {
 	hlist_add_head(&sk->sk_node, list);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ef4ccfd46ff6..83c9ec625419 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -685,7 +685,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_nulls_del_node_init_rcu(osk);
+		ret = sk_nulls_replace_node_init_rcu(osk, sk);
+		goto unlock;
 	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
@@ -695,6 +696,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
+unlock:
 	spin_unlock(lock);
 
 	return ret;
-- 
2.25.1


