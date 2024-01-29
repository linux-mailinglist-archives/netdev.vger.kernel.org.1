Return-Path: <netdev+bounces-66852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6DB841309
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664D91F2277E
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A82E3E3;
	Mon, 29 Jan 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ANrcFkDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0876C85
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555150; cv=none; b=KOyy8VWxktgqcFAf3+DBdQfCOwKXBe03Ve70wlHKys70H9oUFP5Cp/1902s+4WGPyXyZk2IeZyjNBzTloL6sx6j9S56+ayvl0ORiOKcumnCl06rrJ2c9EXjkTzq1T4UIwjt0wBQlkImsQWYkiyLeNxHaN9cIBqDfU4aOeoctJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555150; c=relaxed/simple;
	bh=lfIzQBfocld2Zl4x3a30qNN0oQQqlBJd2tTFEu/7Bus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxBUl7vLUic53Ms1Z4kvjGhMGTF0vSLjM7a+6FnEbT21EorsZRdVY16+Usr7vmR6sErO8xpgGkkl5tv5Mu15PrRh0tm1vCtoGGP/D1eTCl0qmOTuNQta6RhRsrD5CxM9obnVZSMUj1DgJRlIWVm5PsEtoaFccFQ0GV0UlVTXgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ANrcFkDD; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706555148; x=1738091148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFvxGBTL3wjc9vMclwZn7ujdW+JaxgDbyC6BUDWCIHc=;
  b=ANrcFkDDHvo3uAQKejrkSf8jbnitLEXoeFCnH/OzH8dV4M9D2Gl08Wt9
   UE1U0/WeqonoQADD+3YUhoV4e0pyQhgpQHXmMzSS5T18XhFms7vcM1m4L
   VaLbBYCsRmYskYjYZkkmHHo3gycMVe3zloLpEAcvlEWhw414HpmdvrIaJ
   I=;
X-IronPort-AV: E=Sophos;i="6.05,227,1701129600"; 
   d="scan'208";a="62008226"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:05:48 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id DCEAB1DDE4B;
	Mon, 29 Jan 2024 19:05:45 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:35570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id 832542a9-ec19-429d-bd19-38001a335a7c; Mon, 29 Jan 2024 19:05:45 +0000 (UTC)
X-Farcaster-Flow-ID: 832542a9-ec19-429d-bd19-38001a335a7c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 19:05:38 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 19:05:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/3] af_unix: Remove io_uring code for GC.
Date: Mon, 29 Jan 2024 11:04:34 -0800
Message-ID: <20240129190435.57228-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240129190435.57228-1-kuniyu@amazon.com>
References: <20240129190435.57228-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Since commit 705318a99a13 ("io_uring/af_unix: disable sending
io_uring over sockets"), io_uring's unix socket cannot be passed
via SCM_RIGHTS, so it does not contribute to cyclic reference and
no longer be candidate for garbage collection.

Also, commit 6e5e6d274956 ("io_uring: drop any code related to
SCM_RIGHTS") cleaned up SCM_RIGHTS code in io_uring.

Let's do it in AF_UNIX as well by reverting commit 0091bfc81741
("io_uring/af_unix: defer registered files gc to io_uring release")
and commit 10369080454d ("net: reclaim skb->scm_io_uring bit").

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/garbage.c    | 25 ++-----------------------
 net/unix/scm.c        |  6 ------
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index f045bbd9017d..9e39b2ec4524 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -20,7 +20,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
-void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index af676bb8fb67..ce5b5f87b16e 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -184,12 +184,10 @@ static bool gc_in_progress;
 
 static void __unix_gc(struct work_struct *work)
 {
-	struct sk_buff *next_skb, *skb;
-	struct unix_sock *u;
-	struct unix_sock *next;
 	struct sk_buff_head hitlist;
-	struct list_head cursor;
+	struct unix_sock *u, *next;
 	LIST_HEAD(not_cycle_list);
+	struct list_head cursor;
 
 	spin_lock(&unix_gc_lock);
 
@@ -269,30 +267,11 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_unlock(&unix_gc_lock);
 
-	/* We need io_uring to clean its registered files, ignore all io_uring
-	 * originated skbs. It's fine as io_uring doesn't keep references to
-	 * other io_uring instances and so killing all other files in the cycle
-	 * will put all io_uring references forcing it to go through normal
-	 * release.path eventually putting registered files.
-	 */
-	skb_queue_walk_safe(&hitlist, skb, next_skb) {
-		if (skb->destructor == io_uring_destruct_scm) {
-			__skb_unlink(skb, &hitlist);
-			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
-		}
-	}
-
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
 	spin_lock(&unix_gc_lock);
 
-	/* There could be io_uring registered files, just push them back to
-	 * the inflight list
-	 */
-	list_for_each_entry_safe(u, next, &gc_candidates, link)
-		list_move_tail(&u->link, &gc_inflight_list);
-
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
 
diff --git a/net/unix/scm.c b/net/unix/scm.c
index 505e56cf02a2..db65b0ab5947 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -148,9 +148,3 @@ void unix_destruct_scm(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 EXPORT_SYMBOL(unix_destruct_scm);
-
-void io_uring_destruct_scm(struct sk_buff *skb)
-{
-	unix_destruct_scm(skb);
-}
-EXPORT_SYMBOL(io_uring_destruct_scm);
-- 
2.30.2


