Return-Path: <netdev+bounces-224977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB7B8C661
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767541B2508E
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F52FB081;
	Sat, 20 Sep 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHjSruuy"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160ED2FB97B
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366040; cv=none; b=Pq1Beh6yezeYWgceLtsnqMS8h5ozgoOPlVFMYCcajfEfao6Ja8QD9+f7uh2uqU9lIwL93SYrS5RzQ/hbcx0xxqITxdKQ98o0yPzNP/n267Sr4w4xOk05K2vIZWogK9HhQuIEmlfzVs3i1uayJztdv4wfmp/6iBHIAiHVEGDHtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366040; c=relaxed/simple;
	bh=Ne7KFDL6EDPqx8ky8DFQ8DIZuEf533r/GOb9ZyuUHWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiEE1qQ12heiYcXfMWN/FY3weggRrhqdrA16EYZNoq6LWD4lt7pJKSQVwvRikpD14ryKpdsy7tkg9aZBX7pESNa9OL4akdFnCxTgDN4LTmah0sEc+1/u2uhNi/5OLAkikjQQME4GYUIpzABLTkgfGJ7jf/8bd+mDRAGKHa26UDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHjSruuy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758366036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1qo6SSpiCkzaaoLehYJkP/HE8qJEUpd70j8glnvUa4=;
	b=SHjSruuypwLbpSgd2qhSXFemuZr6pFeungovr/kJuO5tmSdBLL0/yErDkW//R88H/xVdRO
	OGXDcKMgBrA8yD2Sl/NxCgmXmxDHlVdkeBhsiE9CzNY5g1oi+tclspM/0muAYti0vDgFzt
	+YKKswjxmf0unhFANA65Rn9CEA45ntk=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v4 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
Date: Sat, 20 Sep 2025 18:59:44 +0800
Message-Id: <20250920105945.538042-3-xuanqiang.luo@linux.dev>
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


