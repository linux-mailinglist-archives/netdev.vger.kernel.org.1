Return-Path: <netdev+bounces-65159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D606839607
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B0D1C28844
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312237FBA2;
	Tue, 23 Jan 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ibx5C/XD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846557F7FE
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029810; cv=none; b=rrcgxDjii4zU8PONJ4RQd3+in+vf7uPWr5XnTRI52ueP4MHcB7aOPJPxT34XDbKCRh3oFqXKUrPcN61b+eZQLSbncY/fqnUJ8nVPxbmxwN7pkYRAyp0O7s9XyTYJO/NK1Kk/zR1bARKwJJTy4i33pqvLoSYAEN+IReJ1EvSXfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029810; c=relaxed/simple;
	bh=9sgFH+aH8RduL/oXfJ/9OV54gAnbI/ZBn6/OfZqRv1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc4Qsg5C/tNDAwkeuXGhQaY9ulW4oHolpFb8klwRvauR1kCTjNdRmMHUzVv1c45ipOYWrwRf+zIgDDkmBCTKOZF4Ab/7+49VQVEPI0JA5RjYDect7T9/Qucj0b/dDWk0Ih8zL7SdoMJz/9KAYOwnxBVD33RiN0+/8s3M2J7hZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ibx5C/XD; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706029808; x=1737565808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QE2AKlODdTRlFW2cSNI6tMVU434EabDijFACQ59lqzQ=;
  b=ibx5C/XDRYVxqLUYpsuk5+YSgvzwelW+vtCuTMrFoslJOBv5NF/6hmjb
   E8ALDiFecRzzCO5hLb2DN4m6anigdvexKVqU1kPlBj/NkO/eBlhVcTcD5
   ftEaLab0q844wMfgV3ho+zB6G8F/vdP82Fqkhz2tiqezRj2z6rzhCqLaM
   A=;
X-IronPort-AV: E=Sophos;i="6.05,214,1701129600"; 
   d="scan'208";a="323010690"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:10:02 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 2505A49DF0;
	Tue, 23 Jan 2024 17:09:59 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:21354]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.26:2525] with esmtp (Farcaster)
 id dacce65c-fb27-4cd0-bd9c-315c647b0a3c; Tue, 23 Jan 2024 17:09:59 +0000 (UTC)
X-Farcaster-Flow-ID: dacce65c-fb27-4cd0-bd9c-315c647b0a3c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:09:58 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:09:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v5 net-next 2/5] af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
Date: Tue, 23 Jan 2024 09:08:53 -0800
Message-ID: <20240123170856.41348-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240123170856.41348-1-kuniyu@amazon.com>
References: <20240123170856.41348-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

When touching unix_sk(sk)->inflight, we are always under
spin_lock(&unix_gc_lock).

Let's convert unix_sk(sk)->inflight to the normal unsigned long.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/af_unix.h |  2 +-
 net/unix/af_unix.c    |  4 ++--
 net/unix/garbage.c    | 17 ++++++++---------
 net/unix/scm.c        |  8 +++++---
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 49c4640027d8..ac38b63db554 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -61,7 +61,7 @@ struct unix_sock {
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
 	struct list_head	link;
-	atomic_long_t		inflight;
+	unsigned long		inflight;
 	spinlock_t		lock;
 	unsigned long		gc_flags;
 #define UNIX_GC_CANDIDATE	0
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ac1f2bc18fc9..1e9378036dcc 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -993,11 +993,11 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_write_space	= unix_write_space;
 	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
 	sk->sk_destruct		= unix_sock_destructor;
-	u	  = unix_sk(sk);
+	u = unix_sk(sk);
+	u->inflight = 0;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
-	atomic_long_set(&u->inflight, 0);
 	INIT_LIST_HEAD(&u->link);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index af3d2221cf6a..051f96a3ab02 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -166,17 +166,18 @@ static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
 
 static void dec_inflight(struct unix_sock *usk)
 {
-	atomic_long_dec(&usk->inflight);
+	usk->inflight--;
 }
 
 static void inc_inflight(struct unix_sock *usk)
 {
-	atomic_long_inc(&usk->inflight);
+	usk->inflight++;
 }
 
 static void inc_inflight_move_tail(struct unix_sock *u)
 {
-	atomic_long_inc(&u->inflight);
+	u->inflight++;
+
 	/* If this still might be part of a cycle, move it to the end
 	 * of the list, so that it's checked even if it was already
 	 * passed over
@@ -237,14 +238,12 @@ void unix_gc(void)
 	 */
 	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
 		long total_refs;
-		long inflight_refs;
 
 		total_refs = file_count(u->sk.sk_socket->file);
-		inflight_refs = atomic_long_read(&u->inflight);
 
-		BUG_ON(inflight_refs < 1);
-		BUG_ON(total_refs < inflight_refs);
-		if (total_refs == inflight_refs) {
+		BUG_ON(!u->inflight);
+		BUG_ON(total_refs < u->inflight);
+		if (total_refs == u->inflight) {
 			list_move_tail(&u->link, &gc_candidates);
 			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
@@ -271,7 +270,7 @@ void unix_gc(void)
 		/* Move cursor to after the current position. */
 		list_move(&cursor, &u->link);
 
-		if (atomic_long_read(&u->inflight) > 0) {
+		if (u->inflight) {
 			list_move_tail(&u->link, &not_cycle_list);
 			__clear_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 			scan_children(&u->sk, inc_inflight_move_tail, NULL);
diff --git a/net/unix/scm.c b/net/unix/scm.c
index 822ce0d0d791..e92f2fad6410 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -53,12 +53,13 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 	if (s) {
 		struct unix_sock *u = unix_sk(s);
 
-		if (atomic_long_inc_return(&u->inflight) == 1) {
+		if (!u->inflight) {
 			BUG_ON(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
 		} else {
 			BUG_ON(list_empty(&u->link));
 		}
+		u->inflight++;
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
@@ -75,10 +76,11 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 	if (s) {
 		struct unix_sock *u = unix_sk(s);
 
-		BUG_ON(!atomic_long_read(&u->inflight));
+		BUG_ON(!u->inflight);
 		BUG_ON(list_empty(&u->link));
 
-		if (atomic_long_dec_and_test(&u->inflight))
+		u->inflight--;
+		if (!u->inflight)
 			list_del_init(&u->link);
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
-- 
2.30.2


