Return-Path: <netdev+bounces-65161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191C83960A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DE51C289BE
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77437FBA8;
	Tue, 23 Jan 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ru+UsbUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF217F7F6
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029854; cv=none; b=eOnaWMkgtGQ3j3a1vCXARandX0i//oRsQCJJ1l7SRygwMgUBYMzi/0crylI7+LAzlPI79DvRflC+ZGQyA2mB8L+rYlnpvMntoBiUkwNgS0C9zSqdVGrIai8qkZDjGAB9iNjwSRctYXmnZK6KGXWmlF2UfznhKhjTG7UWeXiC894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029854; c=relaxed/simple;
	bh=Ska4ZBQtnGBWOLRSNz/TESKyqfehp3tOgwAMrQGfttw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gofkw0VpbBtTpLPJOT99y9HOppaP8sODa9B6THZ9el577pBn2so3sXOhxzPFqpg35KOqhqn8eacXzneSu6Uh7oRLKrBvVCD17lhm8cG5U6CkgHpXqM1D82keqi8ZGhXw67p7oSv9ObAZ/ifVXKxAHsAaF9mDCunND7YE4GhpSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ru+UsbUf; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706029854; x=1737565854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RP1WTOsoR94ZzYfTc4cy0gtjX0UaEsBXk+0SXuldg9Q=;
  b=ru+UsbUfM/GjKZClftptvAyzr6eD35vg2Anqc9S9UBPdlzLgQ7uoc6lb
   yLft3OgaftxEx2OIWFhZ5RIdLyh02HXwx4yJKZV9+iqsTlrfWmdgemE7y
   Pbr1JiKxw1NXGYyCgSeLWyDtaLjzdE6U3UFKG4RAQKOW06SX8dUGJEUy8
   s=;
X-IronPort-AV: E=Sophos;i="6.05,214,1701129600"; 
   d="scan'208";a="391941030"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:10:53 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 194B288A13;
	Tue, 23 Jan 2024 17:10:52 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:64635]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.126:2525] with esmtp (Farcaster)
 id 345ad896-b424-4fef-83fd-941820b2fd6d; Tue, 23 Jan 2024 17:10:51 +0000 (UTC)
X-Farcaster-Flow-ID: 345ad896-b424-4fef-83fd-941820b2fd6d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:10:47 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:10:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 4/5] af_unix: Run GC on only one CPU.
Date: Tue, 23 Jan 2024 09:08:55 -0800
Message-ID: <20240123170856.41348-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist and the garbage
collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
Also, they wait for unix_gc() to complete.

In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
and more if they are the GC candidate.  Thus, sendmsg() significantly
slows down with too many inflight AF_UNIX sockets.

There is a small window to invoke multiple unix_gc() instances, which
will then be blocked by the same spinlock except for one.

Let's convert unix_gc() to use struct work so that it will not consume
CPUs unnecessarily.

Note WRITE_ONCE(gc_in_progress, true) is moved before running GC.
If we leave the WRITE_ONCE() as is and use the following test to
call flush_work(), a process might not call it.

    CPU 0                                     CPU 1
    ---                                       ---
                                              start work and call __unix_gc()
    if (work_pending(&unix_gc_work) ||        <-- false
        READ_ONCE(gc_in_progress))            <-- false
            flush_work();                     <-- missed!
	                                      WRITE_ONCE(gc_in_progress, true)

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d5ef46a75f1f..3f599db59f9d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -86,7 +86,6 @@
 /* Internal data structures and random procedures: */
 
 static LIST_HEAD(gc_candidates);
-static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
@@ -182,23 +181,8 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 }
 
 static bool gc_in_progress;
-#define UNIX_INFLIGHT_TRIGGER_GC 16000
-
-void wait_for_unix_gc(void)
-{
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
-	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
-}
 
-/* The external entry point: unix_gc() */
-void unix_gc(void)
+static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff *next_skb, *skb;
 	struct unix_sock *u;
@@ -209,13 +193,6 @@ void unix_gc(void)
 
 	spin_lock(&unix_gc_lock);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
-
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
-
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
@@ -322,8 +299,31 @@ void unix_gc(void)
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-	wake_up(&unix_gc_wait);
-
- out:
 	spin_unlock(&unix_gc_lock);
 }
+
+static DECLARE_WORK(unix_gc_work, __unix_gc);
+
+void unix_gc(void)
+{
+	WRITE_ONCE(gc_in_progress, true);
+	queue_work(system_unbound_wq, &unix_gc_work);
+}
+
+#define UNIX_INFLIGHT_TRIGGER_GC 16000
+
+void wait_for_unix_gc(void)
+{
+	/* If number of inflight sockets is insane,
+	 * force a garbage collect right now.
+	 *
+	 * Paired with the WRITE_ONCE() in unix_inflight(),
+	 * unix_notinflight(), and __unix_gc().
+	 */
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
+	    !READ_ONCE(gc_in_progress))
+		unix_gc();
+
+	if (READ_ONCE(gc_in_progress))
+		flush_work(&unix_gc_work);
+}
-- 
2.30.2


