Return-Path: <netdev+bounces-49862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0C17F3B5A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B8282809
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8FE1FAE;
	Wed, 22 Nov 2023 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nfGa44L8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C50DD
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700617057; x=1732153057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QokYwN05t6Vk0khFodJPOoiRdPVEPQxOO01sxU3HNys=;
  b=nfGa44L8W51pXWH6Q1FnkjeVylKO3OVUSfrRv5MUWmg/JnJa8Yd1O7HQ
   1+sHGnmEt44zCRYQMuOEh680yiA8giHInToNby0WpT16bDfNAKigoed0K
   BK+6H3dALf2hIoFw4VloEK+EUsGmAHizF03d6q7c72odq0Op/Gtq9JLCw
   g=;
X-IronPort-AV: E=Sophos;i="6.04,217,1695686400"; 
   d="scan'208";a="167658332"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:37:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 6926780421;
	Wed, 22 Nov 2023 01:37:33 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:25357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id 75b41c23-8fdd-4049-a264-4644cde9c913; Wed, 22 Nov 2023 01:37:32 +0000 (UTC)
X-Farcaster-Flow-ID: 75b41c23-8fdd-4049-a264-4644cde9c913
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 22 Nov 2023 01:37:32 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 22 Nov 2023 01:37:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v1 net-next 2/4] af_unix: Return struct unix_sock from unix_get_socket().
Date: Tue, 21 Nov 2023 17:36:27 -0800
Message-ID: <20231122013629.28554-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231122013629.28554-1-kuniyu@amazon.com>
References: <20231122013629.28554-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Currently, unix_get_socket() returns struct sock, but after calling
it, we always cast it to unix_sk().

Let's return struct unix_sock from unix_get_socket().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring.h |  4 ++--
 include/net/af_unix.h    |  2 +-
 io_uring/io_uring.c      |  5 +++--
 net/unix/garbage.c       | 19 +++++++------------
 net/unix/scm.c           | 26 +++++++++++---------------
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 106cdc55ff3b..53170ecca396 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -46,7 +46,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
 			unsigned issue_flags);
-struct sock *io_uring_get_socket(struct file *file);
+struct unix_sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
@@ -100,7 +100,7 @@ static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
 {
 }
-static inline struct sock *io_uring_get_socket(struct file *file)
+static inline struct unix_sock *io_uring_get_socket(struct file *file)
 {
 	return NULL;
 }
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 5a8a670b1920..c628d30ceb19 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,7 +14,7 @@ void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(void);
-struct sock *unix_get_socket(struct file *filp);
+struct unix_sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8d1bc6cdfe71..e93431c0ec97 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -175,13 +175,14 @@ static struct ctl_table kernel_io_uring_disabled_table[] = {
 };
 #endif
 
-struct sock *io_uring_get_socket(struct file *file)
+struct unix_sock *io_uring_get_socket(struct file *file)
 {
 #if defined(CONFIG_UNIX)
 	if (io_is_uring_fops(file)) {
 		struct io_ring_ctx *ctx = file->private_data;
 
-		return ctx->ring_sock->sk;
+		if (ctx->ring_sock->sk)
+			return unix_sk(ctx->ring_sock->sk);
 	}
 #endif
 	return NULL;
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index db1bb99bb793..4d634f5f6a55 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -105,20 +105,15 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
-				struct sock *sk = unix_get_socket(*fp++);
+				struct unix_sock *u = unix_get_socket(*fp++);
 
-				if (sk) {
-					struct unix_sock *u = unix_sk(sk);
+				/* Ignore non-candidates, they could have been added
+				 * to the queues after starting the garbage collection
+				 */
+				if (u && test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
+					hit = true;
 
-					/* Ignore non-candidates, they could
-					 * have been added to the queues after
-					 * starting the garbage collection
-					 */
-					if (test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
-						hit = true;
-
-						func(u);
-					}
+					func(u);
 				}
 			}
 			if (hit && hitlist != NULL) {
diff --git a/net/unix/scm.c b/net/unix/scm.c
index 4b3979272a81..36ce8fed9acc 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -21,9 +21,8 @@ EXPORT_SYMBOL(gc_inflight_list);
 DEFINE_SPINLOCK(unix_gc_lock);
 EXPORT_SYMBOL(unix_gc_lock);
 
-struct sock *unix_get_socket(struct file *filp)
+struct unix_sock *unix_get_socket(struct file *filp)
 {
-	struct sock *u_sock = NULL;
 	struct inode *inode = file_inode(filp);
 
 	/* Socket ? */
@@ -34,12 +33,13 @@ struct sock *unix_get_socket(struct file *filp)
 
 		/* PF_UNIX ? */
 		if (s && ops && ops->family == PF_UNIX)
-			u_sock = s;
-	} else {
-		/* Could be an io_uring instance */
-		u_sock = io_uring_get_socket(filp);
+			return unix_sk(s);
+
+		return NULL;
 	}
-	return u_sock;
+
+	/* Could be an io_uring instance */
+	return io_uring_get_socket(filp);
 }
 EXPORT_SYMBOL(unix_get_socket);
 
@@ -48,13 +48,11 @@ EXPORT_SYMBOL(unix_get_socket);
  */
 void unix_inflight(struct user_struct *user, struct file *fp)
 {
-	struct sock *s = unix_get_socket(fp);
+	struct unix_sock *u = unix_get_socket(fp);
 
 	spin_lock(&unix_gc_lock);
 
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
+	if (u) {
 		if (!u->inflight) {
 			BUG_ON(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
@@ -71,13 +69,11 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
 void unix_notinflight(struct user_struct *user, struct file *fp)
 {
-	struct sock *s = unix_get_socket(fp);
+	struct unix_sock *u = unix_get_socket(fp);
 
 	spin_lock(&unix_gc_lock);
 
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
+	if (u) {
 		BUG_ON(!u->inflight);
 		BUG_ON(list_empty(&u->link));
 
-- 
2.30.2


