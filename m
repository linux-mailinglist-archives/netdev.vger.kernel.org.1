Return-Path: <netdev+bounces-73622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F985D641
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EE52816B9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7A405F2;
	Wed, 21 Feb 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5Zmy8t4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2B3FB04
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513171; cv=none; b=Mx46f7lb/5CDg0qRNQMLAutAmtGeyxRUI1YGwajqvraraD3fm/dPoc1h7jTpeabqEOijKGO4NFtMi1e38iOiiUyRT41ijEOX54dfB+qOnXo3MEyHEmQ6kLUKRKeh93E4pEqKX7lJO0DUrbh1de/nPebLFv+1T8IE80FdVQO+0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513171; c=relaxed/simple;
	bh=nCuYZd7o+W/CijPHV0VcFE4wcigToPMealSKepNiOQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KpESStJT90sTGFvNuXfwWWkIbXN5GG6Y412XeGaL5K3onx6+A+U0YzD29grTyW03/IZmKWL0QbsSPKNq7kk1c6iErt3PvseUDLlOwkhoZaCKqoSlUziyjkfOUI2ADdUMBlt1STkG7y/8Xv1vDX5klZK4TSOIiScnhbrfb4FcPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5Zmy8t4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso9572645276.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513169; x=1709117969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeWkXNVOW+RqvvZKmExoyAcEnUoOPThnUsGw/ke4bto=;
        b=C5Zmy8t4vOWbykMU2aUJDd3gVvKfuHgIcx1y55M7iKuhbGoqwZsUJPtfVa4dvmDLxt
         tD3LpxW3l27mfcDauc4sHX0FO8/V4X9DEnOTrqf5gqxMtrkbcJ6CQtzf8V7V2Us6y1Wf
         PPXeHJqkRrGUa7rMTCfDQgE+9TfSR8xC+iS9+5ZpQYeDbggUj2B4oq1mzcwAzSvzp3Qq
         1Ocp1YwtWZn0/VQAj8TzcsFFXxm3n85y48HlSz7OqA903lXOVcIzuce2Xfx/gNcHJe3l
         K8QGkLSd2pq/Tus/2JC5VfDc9Y3iMGifGqVk7CC2TI9FL3ixUCLSAaclQUKwoCu47hSb
         K/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513169; x=1709117969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeWkXNVOW+RqvvZKmExoyAcEnUoOPThnUsGw/ke4bto=;
        b=KmXVjFa2y62+eYo/qc860Rw0LOz369TNE0Fcq38o3j2G8qFqo/SULoRWqv0FVyQCb+
         W8rYe99bqh31hSH79vWrCUa6o/my2YnksiH/RK0xCrspbsyUhFv2fT49EPQdSrzsToMD
         4Uy8UofZc781dLsJyi8GlQzzo29kgTA6jUWpO+IZlEyM13Id2NHEptU4PH3ArcWq3MeP
         PGiusjD3XiFzqS3MRxgRDz/yzVbNe9RV9I79hWdFuTdvesdUG5N+uqVxKd9F4APkC/84
         O+X7aGdtCpzo6M/I1jnkjh9C6vdPLZaNt6faYc+j4il09xZWPmyR/A7uNYtM4r2eVZIU
         jkpg==
X-Gm-Message-State: AOJu0YzNlXK3LRR8QFcstRJXJ3g4K0MSHJh6qEkrpFz+0uRLp598S53W
	S4Zaodjua6sM35zyIQiMRPciViUqXtyMr/Wc0rmo2D2a7dBg7OgBC+y2X3k9S6EnDuzOBcc13a+
	UNXa1YK+TMA==
X-Google-Smtp-Source: AGHT+IEnPL68KiQgx5Q2g96kq5ZyMBaLVSkX283CKEa3GJgKinyIOeji3+WFGGb8LdSAgor+GuWsBD1x4ykmOQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a447:0:b0:dcc:41ad:fb3b with SMTP id
 f65-20020a25a447000000b00dcc41adfb3bmr619633ybi.10.1708513168889; Wed, 21 Feb
 2024 02:59:28 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:09 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-8-edumazet@google.com>
Subject: [PATCH net-next 07/13] rtnetlink: change nlk->cb_mutex role
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit af65bdfce98d ("[NETLINK]: Switch cb_lock spinlock
to mutex and allow to override it"), Patrick McHardy used
a common mutex to protect both nlk->cb and the dump() operations.

The override is used for rtnl dumps, registered with
rntl_register() and rntl_register_module().

We want to be able to opt-out some dump() operations
to not acquire RTNL, so we need to protect nlk->cb
with a per socket mutex.

This patch renames nlk->cb_def_mutex to nlk->nl_cb_mutex

The optional pointer to the mutex used to protect dump()
call is stored in nlk->dump_cb_mutex

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 32 ++++++++++++++++++--------------
 net/netlink/af_netlink.h |  5 +++--
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 94f3860526bfaa5793e8b3917250ec0e751687b5..84cad7be6d4335bfb5301ef49f84af8e7b3bc842 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -636,7 +636,7 @@ static struct proto netlink_proto = {
 };
 
 static int __netlink_create(struct net *net, struct socket *sock,
-			    struct mutex *cb_mutex, int protocol,
+			    struct mutex *dump_cb_mutex, int protocol,
 			    int kern)
 {
 	struct sock *sk;
@@ -651,15 +651,11 @@ static int __netlink_create(struct net *net, struct socket *sock,
 	sock_init_data(sock, sk);
 
 	nlk = nlk_sk(sk);
-	if (cb_mutex) {
-		nlk->cb_mutex = cb_mutex;
-	} else {
-		nlk->cb_mutex = &nlk->cb_def_mutex;
-		mutex_init(nlk->cb_mutex);
-		lockdep_set_class_and_name(nlk->cb_mutex,
+	mutex_init(&nlk->nl_cb_mutex);
+	lockdep_set_class_and_name(&nlk->nl_cb_mutex,
 					   nlk_cb_mutex_keys + protocol,
 					   nlk_cb_mutex_key_strings[protocol]);
-	}
+	nlk->dump_cb_mutex = dump_cb_mutex;
 	init_waitqueue_head(&nlk->wait);
 
 	sk->sk_destruct = netlink_sock_destruct;
@@ -2209,7 +2205,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	int alloc_size;
 
 	if (!lock_taken)
-		mutex_lock(nlk->cb_mutex);
+		mutex_lock(&nlk->nl_cb_mutex);
 	if (!nlk->cb_running) {
 		err = -EINVAL;
 		goto errout_skb;
@@ -2261,14 +2257,22 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0) {
+		struct mutex *extra_mutex = nlk->dump_cb_mutex;
+
 		cb->extack = &extack;
+
+		if (extra_mutex)
+			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
+		if (extra_mutex)
+			mutex_unlock(extra_mutex);
+
 		cb->extack = NULL;
 	}
 
 	if (nlk->dump_done_errno > 0 ||
 	    skb_tailroom(skb) < nlmsg_total_size(sizeof(nlk->dump_done_errno))) {
-		mutex_unlock(nlk->cb_mutex);
+		mutex_unlock(&nlk->nl_cb_mutex);
 
 		if (sk_filter(sk, skb))
 			kfree_skb(skb);
@@ -2302,13 +2306,13 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
-	mutex_unlock(nlk->cb_mutex);
+	mutex_unlock(&nlk->nl_cb_mutex);
 	module_put(module);
 	consume_skb(skb);
 	return 0;
 
 errout_skb:
-	mutex_unlock(nlk->cb_mutex);
+	mutex_unlock(&nlk->nl_cb_mutex);
 	kfree_skb(skb);
 	return err;
 }
@@ -2331,7 +2335,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	}
 
 	nlk = nlk_sk(sk);
-	mutex_lock(nlk->cb_mutex);
+	mutex_lock(&nlk->nl_cb_mutex);
 	/* A dump is in progress... */
 	if (nlk->cb_running) {
 		ret = -EBUSY;
@@ -2382,7 +2386,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	module_put(control->module);
 error_unlock:
 	sock_put(sk);
-	mutex_unlock(nlk->cb_mutex);
+	mutex_unlock(&nlk->nl_cb_mutex);
 error_free:
 	kfree_skb(skb);
 	return ret;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 2145979b9986a0331b34b6ba2fda867f23d0d71c..9751e29d4bbb9ad9cb7900e2cfaedbe7ab138cf4 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -39,8 +39,9 @@ struct netlink_sock {
 	bool			cb_running;
 	int			dump_done_errno;
 	struct netlink_callback	cb;
-	struct mutex		*cb_mutex;
-	struct mutex		cb_def_mutex;
+	struct mutex		nl_cb_mutex;
+
+	struct mutex		*dump_cb_mutex;
 	void			(*netlink_rcv)(struct sk_buff *skb);
 	int			(*netlink_bind)(struct net *net, int group);
 	void			(*netlink_unbind)(struct net *net, int group);
-- 
2.44.0.rc0.258.g7320e95886-goog


