Return-Path: <netdev+bounces-229018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 329ECBD7132
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 406294F43DB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE263043C0;
	Tue, 14 Oct 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IkmDwok/"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667C3043B8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408903; cv=none; b=Lh8cvXfI6/FzGDa590a6PJ9A7fAwGTTgoVQdUSfQmYPv4kMyPRH/aY1+9VPpFsAD4YWDFPcfRK37/69zh6J6zafyw5MBiW87bBQ652+P0dqpz/AV67xg6nAxPOk2PaDxKERXKP1o95oUlxNE+4XWIv3lGxUe0qz9i/v/I5SOr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408903; c=relaxed/simple;
	bh=AY5Mnf8bL64hhYHUH2jNynaZAVaW7iM+0ezI1gCItw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/75ReTmMVMnFCirS9Gpj7QIw82jYivmo0Lt1Qh78Dj5MklfeXT8gJgsEyV8yx7/yeRcLiLmDza90huCJuFfMyLh7hpcC9hI2ltMc8gLsKfVAVLIXCl6Mj9uesACNbyftcLJ98EMIPZjbX6yRVptOQ3FE1OvI8Z31WZZux8vTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IkmDwok/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760408899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLVPodE7oh/QCBPyjLUCyrReaVws2Cv/HQ34vyYFglU=;
	b=IkmDwok/uNe+cUxmlPl/JRR649N+Oi4qUq76qr/pe9zWzhDcifbXpQgZTr8ENxVMbm2qbI
	yQOgvPeKwOdW0LoiZzSOTX0RQC3PBR4L3ErVzVe1hkzZc4dfqD7WaZ7tWYlS1X44W8JH14
	GFLDIUzyMFVutz4br/a4tgw93oznRAI=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiayuan.chen@linux.dev,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [RESEND PATCH net-next v7 2/3] inet: Avoid ehash lookup race in inet_ehash_insert()
Date: Tue, 14 Oct 2025 10:27:02 +0800
Message-Id: <20251014022703.1387794-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20251014022703.1387794-1-xuanqiang.luo@linux.dev>
References: <20251014022703.1387794-1-xuanqiang.luo@linux.dev>
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
introduces a new sk_nulls_replace_node_init_rcu() helper functions to
implement atomic replacement.

Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/net/sock.h         | 14 ++++++++++++++
 net/ipv4/inet_hashtables.c |  8 ++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..5d299a954859 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -858,6 +858,20 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
 	return rc;
 }
 
+static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
+						  struct sock *new)
+{
+	if (sk_hashed(old)) {
+		hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
+					     &new->sk_nulls_node);
+		DEBUG_NET_WARN_ON_ONCE(refcount_read(&old->sk_refcnt) == 1);
+		__sock_put(old);
+		return true;
+	}
+
+	return false;
+}
+
 static inline void __sk_add_node(struct sock *sk, struct hlist_head *list)
 {
 	hlist_add_head(&sk->sk_node, list);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index b7024e3d9ac3..f5826ec4bcaa 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -720,8 +720,11 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_nulls_del_node_init_rcu(osk);
-	} else if (found_dup_sk) {
+		ret = sk_nulls_replace_node_init_rcu(osk, sk);
+		goto unlock;
+	}
+
+	if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -730,6 +733,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
+unlock:
 	spin_unlock(lock);
 
 	return ret;
-- 
2.25.1


