Return-Path: <netdev+bounces-223375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C0B58E9C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5158A1BC28B5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C932C2345;
	Tue, 16 Sep 2025 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jdBVFSIM"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19422DE71E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005234; cv=none; b=uJHZ+jaoRr4aOG5iC47M6Lyobq/M3OTwTtgEXei0+ASN69u5aMWT0VHNQhrOiZqMspVXCxxktw02DuXOP19oJcRGpSF7EVY0j9rlblcgAS92vbDg4A6ZcVxdZ263K3vYZLanayGLgf0lyCKNC8yx5sWmgra1tt4JGtGeb6XS4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005234; c=relaxed/simple;
	bh=Ne7KFDL6EDPqx8ky8DFQ8DIZuEf533r/GOb9ZyuUHWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEP024pfuc1hKI2etJEkSkq4/y0ncpn43B+NkDgCIHYSj2f6q5e4CLpNSvtLzOz1lxqd4q5jWldQx9DB7fX7LjAn6jWAn7O5S5agw6180EmUuJhWi8wSRoJFyYgOumTZbyzosSy9xajIZ0PdvsgHPN8zVvyAZPZ/80Sz9rVBWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jdBVFSIM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758005231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1qo6SSpiCkzaaoLehYJkP/HE8qJEUpd70j8glnvUa4=;
	b=jdBVFSIMsgY+4lVO3V0SWF0G9XAkkMS414F4ScXazrM5KAJw6Qe6SZf9XYXazvjhLsXxcZ
	njAZhIwpB67PsDWan9mTdLUf8sJtnmew740cLZ9fv//Yk4bQdKBToWU7OC2HppN52VIQt+
	50CxRcWiq1h/uup+60SCVdfLZILJlWc=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v2 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
Date: Tue, 16 Sep 2025 14:46:13 +0800
Message-Id: <20250916064614.605075-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
References: <20250916064614.605075-1-xuanqiang.luo@linux.dev>
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


