Return-Path: <netdev+bounces-142190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5300F9BDB76
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A451F23948
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743118B463;
	Wed,  6 Nov 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIMniBq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E226BFCA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857963; cv=none; b=UmoX9UNhLEZ8HvhhaGLEkRRA769HzFEuM3r4BSN43ylRh4FbUB3kqf75YrliVkqO7BNUNZ1UBsPMzUcV/gNqgm0epsR2Yu0sBFxSwWcF07qPi5VUNnXCHpo0maqYVeGas/9vsYZW0ES1HQ2fWkEUtfPRpggTiQ5oVScY5/6z5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857963; c=relaxed/simple;
	bh=aYYju73Ju1+FVIz0sAm0ETBgz8kJZeJQREO4Kj0isFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKt9++OCyjWvPBhYm42JVI2QimLe2lXi8E6ZmkF7nXsw/Tp8PXftU1wy5WfbrS4QP1rCgiANcEUXMCSCE5T8HH0iwpJIXZxnb4F1Uw6iSWdpyYLROghvOmf4VrMwuV4A0xNiQaoln7GBvIjcc+AbqKRcFFlIvw0VGJeucZCc7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIMniBq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D484C4CECF;
	Wed,  6 Nov 2024 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857962;
	bh=aYYju73Ju1+FVIz0sAm0ETBgz8kJZeJQREO4Kj0isFs=;
	h=From:To:Cc:Subject:Date:From;
	b=kIMniBq0IJv8F3b9zjbG3PDB6fdVXWkpgn3v5A4LNgdkmPnldbvFJR6WvGLVmquAK
	 KMZhA/GYd4UIRCv/L2QueqWQ8qaHLifp0bn7eK8ektDkzgkX6DPt8bp4qK/ZB6/OxC
	 hNJ2fjFr2/nSf5rKfu6Uxh5EKMgzqeeexj3Idnt7JZUbnzn2NQTFCVQlWLPFVprTc7
	 Pl5HTNjS7aSdnZMdbUkPU/MgXO3i3ycRtwWgFaVh9sH43vb6Y6Od495nBGFKCVTK4v
	 0VOw19TrRQp/xnzX6tdADbt910qx/Cgru9luwvi/aKoE8npy1cBpDb4mf2kslLvvmT
	 p9hubcQz5COQA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes@sipsolutions.net,
	pablo@netfilter.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net v2 1/2] netlink: terminate outstanding dump on socket close
Date: Tue,  5 Nov 2024 17:52:34 -0800
Message-ID: <20241106015235.2458807-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink supports iterative dumping of data. It provides the families
the following ops:
 - start - (optional) kicks off the dumping process
 - dump  - actual dump helper, keeps getting called until it returns 0
 - done  - (optional) pairs with .start, can be used for cleanup
The whole process is asynchronous and the repeated calls to .dump
don't actually happen in a tight loop, but rather are triggered
in response to recvmsg() on the socket.

This gives the user full control over the dump, but also means that
the user can close the socket without getting to the end of the dump.
To make sure .start is always paired with .done we check if there
is an ongoing dump before freeing the socket, and if so call .done.

The complication is that sockets can get freed from BH and .done
is allowed to sleep. So we use a workqueue to defer the call, when
needed.

Unfortunately this does not work correctly. What we defer is not
the cleanup but rather releasing a reference on the socket.
We have no guarantee that we own the last reference, if someone
else holds the socket they may release it in BH and we're back
to square one.

The whole dance, however, appears to be unnecessary. Only the user
can interact with dumps, so we can clean up when socket is closed.
And close always happens in process context. Some async code may
still access the socket after close, queue notification skbs to it etc.
but no dumps can start, end or otherwise make progress.

Delete the workqueue and flush the dump state directly from the release
handler. Note that further cleanup is possible in -next, for instance
we now always call .done before releasing the main module reference,
so dump doesn't have to take a reference of its own.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: ed5d7788a934 ("netlink: Do not schedule work from sk_destruct")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - change reported tag
v1: https://lore.kernel.org/20241105010347.2079981-1-kuba@kernel.org
---
 net/netlink/af_netlink.c | 31 ++++++++-----------------------
 net/netlink/af_netlink.h |  2 --
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47..f84aad420d44 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -393,15 +393,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 
 static void netlink_sock_destruct(struct sock *sk)
 {
-	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (nlk->cb_running) {
-		if (nlk->cb.done)
-			nlk->cb.done(&nlk->cb);
-		module_put(nlk->cb.module);
-		kfree_skb(nlk->cb.skb);
-	}
-
 	skb_queue_purge(&sk->sk_receive_queue);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
@@ -414,14 +405,6 @@ static void netlink_sock_destruct(struct sock *sk)
 	WARN_ON(nlk_sk(sk)->groups);
 }
 
-static void netlink_sock_destruct_work(struct work_struct *work)
-{
-	struct netlink_sock *nlk = container_of(work, struct netlink_sock,
-						work);
-
-	sk_free(&nlk->sk);
-}
-
 /* This lock without WQ_FLAG_EXCLUSIVE is good on UP and it is _very_ bad on
  * SMP. Look, when several writers sleep and reader wakes them up, all but one
  * immediately hit write lock and grab all the cpus. Exclusive sleep solves
@@ -731,12 +714,6 @@ static void deferred_put_nlk_sk(struct rcu_head *head)
 	if (!refcount_dec_and_test(&sk->sk_refcnt))
 		return;
 
-	if (nlk->cb_running && nlk->cb.done) {
-		INIT_WORK(&nlk->work, netlink_sock_destruct_work);
-		schedule_work(&nlk->work);
-		return;
-	}
-
 	sk_free(sk);
 }
 
@@ -788,6 +765,14 @@ static int netlink_release(struct socket *sock)
 				NETLINK_URELEASE, &n);
 	}
 
+	/* Terminate any outstanding dump */
+	if (nlk->cb_running) {
+		if (nlk->cb.done)
+			nlk->cb.done(&nlk->cb);
+		module_put(nlk->cb.module);
+		kfree_skb(nlk->cb.skb);
+	}
+
 	module_put(nlk->module);
 
 	if (netlink_is_kernel(sk)) {
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 5b0e4e62ab8b..778a3809361f 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -4,7 +4,6 @@
 
 #include <linux/rhashtable.h>
 #include <linux/atomic.h>
-#include <linux/workqueue.h>
 #include <net/sock.h>
 
 /* flags */
@@ -50,7 +49,6 @@ struct netlink_sock {
 
 	struct rhash_head	node;
 	struct rcu_head		rcu;
-	struct work_struct	work;
 };
 
 static inline struct netlink_sock *nlk_sk(struct sock *sk)
-- 
2.47.0


