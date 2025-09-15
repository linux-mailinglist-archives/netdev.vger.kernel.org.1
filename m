Return-Path: <netdev+bounces-222934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A0B570D1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2173B71D9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F5272E42;
	Mon, 15 Sep 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="duQEfujy"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6622FF37
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919883; cv=none; b=MtWWiO7Kml62iaxjCulfCaqdHfUk9U8pTarBci0FWGaLAZYZUOo4p12Mp94bkvEIEQAfjiZvphzE0BQ+R8XxkoRS44TPKNFRzvyAnwWi4RxorsLasPMpjCyX8ZzySsLjJU8L5ZsyeGImuk/SmcYtl46/l2mLDRdPBWRYfqWAkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919883; c=relaxed/simple;
	bh=9tmbizvd3x3zgfYXbHCTme2UM8dFsrYh7j1ISIbqrVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AaK4v1R/Qsox4PeethOpMwM9T6j+0Yv804q70taBHUKcyZ4SDCLjAIdU7Y/ujHZqB8o2c1OwQSd3s1oiSLqRXKBYeBV/qbnHF4weGhwtXprl/D1rz5uP1tQ+6239o/p3di6EahGCtsA4d9UYq3yjaygyZ+KtoWqE/diXtyCixdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=duQEfujy; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757919880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfozPfc1eevuoUhgc+vd7XRDfq/CRFp3IU/IO4+d5ko=;
	b=duQEfujyuFRtKi/MwimR0lZo5jCq6yGFSMC+pBjFtM3JFjfZvKPUCZUubmX9uoSJUITHzW
	oK4deuOlIgHe8iYLOmWOUGMG7maPlQNnIfy0oD1vCqTB4IdeZ1E66wWlCtl+FyJCiw5Soi
	hLeiBWi7fpu9jft+pT3iNjPfnzui6CY=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
Date: Mon, 15 Sep 2025 15:03:07 +0800
Message-Id: <20250915070308.111816-3-xuanqiang.luo@linux.dev>
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

If sk_nulls_replace_node_init_rcu() fails, it indicates osk is either
hlist_unhashed or hlist_nulls_unhashed. The former returns false; the
latter performs insertion without deletion.

Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/net/sock.h         | 23 +++++++++++++++++++++++
 net/ipv4/inet_hashtables.c |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 896bec2d2176..26dacf7bc93e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -859,6 +859,29 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
 	return rc;
 }
 
+static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
+						    struct sock *new)
+{
+	if (sk_hashed(old) &&
+	    hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
+					 &new->sk_nulls_node))
+		return true;
+
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
index ef4ccfd46ff6..7803fd3cc8e9 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -685,6 +685,12 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
+		/* Since osk and sk should be in the same ehash bucket, try
+		 * direct replacement to avoid lookup gaps. On failure, no
+		 * changes. sk_nulls_del_node_init_rcu() will handle the rest.
+		 */
+		if (sk_nulls_replace_node_init_rcu(osk, sk))
+			goto unlock;
 		ret = sk_nulls_del_node_init_rcu(osk);
 	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
@@ -695,6 +701,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
+unlock:
 	spin_unlock(lock);
 
 	return ret;
-- 
2.27.0


