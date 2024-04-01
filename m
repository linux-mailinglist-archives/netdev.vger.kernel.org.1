Return-Path: <netdev+bounces-83795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E11894459
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E51C2131C
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17593481BF;
	Mon,  1 Apr 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="scdquVFc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E93EA68
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992764; cv=none; b=flTVgVKlf8341MhuPv9jJseIk34j8RIb4icLBLo0qQjzB75ghE/aXM8V2kYpWfskkxX2qQ9qaG0QQRipt6XRG3fA4E8GQwSzb1LmNdFfDb6kxw1MpJ8xJLbkZvxOz22ujpwBAzdU2JG2WHqggzOXspeLTUNa7oA/xzytBa5Avv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992764; c=relaxed/simple;
	bh=Wg37/YISO61lXe1dDH0ZVS28MSUe8UGvGxQ7lRnVddU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdHG9jGDXrjyQlRFBWO1nwyl9kzM/Y4lW/PVQxyXBbcDK+5bc46y5QrBJ+9fB/48152EkljDYwMb9ypp4v+e+Pgv5Ief9icKbLEjlnGcFcT1uAWnb74meUsBViwY756g2o9i/9oIaD6miQjToKW4fZKWPX4Ks1T/DHEYv4Gq1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=scdquVFc; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711992762; x=1743528762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IsraToyvJ3wKbhsnudYX2b95chOr3a1EfVG7EmU/13g=;
  b=scdquVFc52rW2pU31JhI0rJabXb2A04p8705ueNOdzxa3VTcCXWtN3gI
   bW/sMzxogJcFgiV9eR2L6YqpVjF8/jOVNXefyAzE3VUKLBiCkmFgwNe6M
   cdmJql69G8rjD7j/H0W4N1JW3mhmRZTT7jjvJBpcfb1b1priY+MQgOUOL
   g=;
X-IronPort-AV: E=Sophos;i="6.07,172,1708387200"; 
   d="scan'208";a="408233549"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 17:32:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:37342]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.22:2525] with esmtp (Farcaster)
 id e8d4679a-2140-4105-9ba5-cfff4616553c; Mon, 1 Apr 2024 17:32:34 +0000 (UTC)
X-Farcaster-Flow-ID: e8d4679a-2140-4105-9ba5-cfff4616553c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 17:32:31 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 17:32:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/2] af_unix: Remove lock dance in unix_peek_fds().
Date: Mon, 1 Apr 2024 10:31:25 -0700
Message-ID: <20240401173125.92184-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240401173125.92184-1-kuniyu@amazon.com>
References: <20240401173125.92184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In the previous GC implementation, the shape of the inflight socket
graph was not expected to change while GC was in progress.

MSG_PEEK was tricky because it could install inflight fd silently
and transform the graph.

Let's say we peeked a fd, which was a listening socket, and accept()ed
some embryo sockets from it.  The garbage collection algorithm would
have been confused because the set of sockets visited in scan_inflight()
would change within the same GC invocation.

That's why we placed spin_lock(&unix_gc_lock) and spin_unlock() in
unix_peek_fds() with a fat comment.

In the new GC implementation, we no longer garbage-collect the socket
if it exists in another queue, that is, if it has a bridge to another
SCC.  Also, accept() will require the lock if it has edges.

Thus, we need not do the complicated lock dance.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/af_unix.c    | 42 ------------------------------------------
 net/unix/garbage.c    |  2 +-
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 226a8da2cbe3..7311b77edfc7 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,7 +17,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
-extern spinlock_t unix_gc_lock;
 extern unsigned int unix_tot_inflight;
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 78be8b520cef..61ecfa9c9c6b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1814,48 +1814,6 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
-
-	/*
-	 * Garbage collection of unix sockets starts by selecting a set of
-	 * candidate sockets which have reference only from being in flight
-	 * (total_refs == inflight_refs).  This condition is checked once during
-	 * the candidate collection phase, and candidates are marked as such, so
-	 * that non-candidates can later be ignored.  While inflight_refs is
-	 * protected by unix_gc_lock, total_refs (file count) is not, hence this
-	 * is an instantaneous decision.
-	 *
-	 * Once a candidate, however, the socket must not be reinstalled into a
-	 * file descriptor while the garbage collection is in progress.
-	 *
-	 * If the above conditions are met, then the directed graph of
-	 * candidates (*) does not change while unix_gc_lock is held.
-	 *
-	 * Any operations that changes the file count through file descriptors
-	 * (dup, close, sendmsg) does not change the graph since candidates are
-	 * not installed in fds.
-	 *
-	 * Dequeing a candidate via recvmsg would install it into an fd, but
-	 * that takes unix_gc_lock to decrement the inflight count, so it's
-	 * serialized with garbage collection.
-	 *
-	 * MSG_PEEK is special in that it does not change the inflight count,
-	 * yet does install the socket into an fd.  The following lock/unlock
-	 * pair is to ensure serialization with garbage collection.  It must be
-	 * done between incrementing the file count and installing the file into
-	 * an fd.
-	 *
-	 * If garbage collection starts after the barrier provided by the
-	 * lock/unlock, then it will see the elevated refcount and not mark this
-	 * as a candidate.  If a garbage collection is already in progress
-	 * before the file count was incremented, then the lock/unlock pair will
-	 * ensure that garbage collection is finished before progressing to
-	 * installing the fd.
-	 *
-	 * (*) A -> B where B is on the queue of A or B is on the queue of C
-	 * which is on the queue of listening socket A.
-	 */
-	spin_lock(&unix_gc_lock);
-	spin_unlock(&unix_gc_lock);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 89ea71d9297b..12a4ec27e0d4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -183,7 +183,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 	}
 }
 
-DEFINE_SPINLOCK(unix_gc_lock);
+static DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
-- 
2.30.2


