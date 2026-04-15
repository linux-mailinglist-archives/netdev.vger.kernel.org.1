Return-Path: <netdev+bounces-278858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHLyDofd32nXZgAAu9opvQ
	(envelope-from <netdev+bounces-278858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:48:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD77407328
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC8033052A0F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470E23370F;
	Wed, 15 Apr 2026 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSDwCSV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0823183C
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278915; cv=none; b=I6ck9bqgPRsCwO05NOf5rZj2jAOv7bqtMc1a+lzD23rMoZPJRbwQg6O3xUSo7utpEKrDMDlUqDQEqk1OmIDUIB1CU9EyVRZ1JNzw2XcHb19RiyLhUNZ0gIjPxQL8kTMHjERx+0MB6hDzoGSNM1OL3gIDRO7q6LfB/3RuRDVLQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278915; c=relaxed/simple;
	bh=Oj05CR0fHPuTy12jHwCFxOBYaZ7CaH7GrVcWCur7+DI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J2gDFfq1YkdrIguAuTexyX5E47Yb8H83Iwz8TVKklnB6nWpR9NZchYnkGIW2oYlONeIZKkm0xfEiff+hJHrooyziBQ6murLBDDzHKudei8OQa5+QPitmOvTlDlKzVDGVb/r9h9rDTi0UpXDx5URxGHk9jqrFVfGdNIJOPUjwurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSDwCSV+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso11333106a12.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776278913; x=1776883713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jgZv4CWzvjEAcoRq48P/scg8M4eth+ffJ7+2amUVGX4=;
        b=bSDwCSV+joxtiH5EoVOkmvWwUmBrZAe325Amy4W0Sd0ub7tVOQx9LCQ5iwpPHrE2aP
         rYhCje+GxEnNPX3qAC2QeyGS1fNkFp+o7S9D9ac4wHAcQLL6Mt9bQYEYZigvFCNcHlL7
         u0DUln/v8136xSZFrT6J6keO+5K/8my15q/n5BmIsXCxs7VbwHV2j1lOUgAIhurriSoq
         OWqKCn5+yFiz9jD//yqiQuGe0gRbCIh9BBIv1VvAxDECcQ8YFze5G/+sjDe3TxioTGIY
         EQiIMSXgu88pGTqNoRUAzhGMTh80uxT8FiBlEk1VpE6avSDYSdrgvgHgWmhIGxi5cGkk
         eknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278913; x=1776883713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgZv4CWzvjEAcoRq48P/scg8M4eth+ffJ7+2amUVGX4=;
        b=FJhA6x6EFeRM3kEb4uUJee0vRRjY4LKemC3xV5/3HVi4n2s9OFzm0t3C67SQoalmlD
         bWJx0yYf5OyePvnw6UGP08aKWuFrvbrP1Lg4AF+Cp7enyAWTEBbbk3//OHlEBDKwzBUO
         +ImC4gCf9a7vnigMQHFYoGdoICpz9QhGjMy5aP2d1ghjKw5i1CbJQ5pMFFSwfPHNZW3+
         x4/9+FC8HrNjGUO7qqda4KFf4I01nKzYOHQNgT+kVxfBe/BsK31Qcj22LG8d7Vfqw5lv
         Nt7v9QdC+lQSExGAv2vH16yKTn6U6z5UsaXMDc2391F+ksGM/HQgjn10QL39G7bciuEU
         bbyA==
X-Forwarded-Encrypted: i=1; AFNElJ9xAOVYxkbFSw+gWMiXMinhG2heQtfaTbyP3F7B1u3Jw8YIvZuk06rIxHRXPTFhO6iw88VV8N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrgic9qA5L6BxGACywDORxAh9v0X9jxgMR3PciEdq6aztsUHqB
	RPW+D4Ka7jTK1z6IdvgWjayYrIMaXG1qdbkOOYhPDI3TMc5cIAehkHJ3w0Ltp2Z+6woNp2ydnAS
	I7McT5A==
X-Received: from pfmm8.prod.google.com ([2002:a05:6a00:2488:b0:82f:3774:4736])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a10e:b0:3a0:13a2:a7d7
 with SMTP id adf61e73a8af0-3a013a2a823mr13538042637.31.1776278913100; Wed, 15
 Apr 2026 11:48:33 -0700 (PDT)
Date: Wed, 15 Apr 2026 18:48:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260415184830.3988432-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Drop all SCM attributes for SOCKMAP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Jiang Wang <jiang.wang@bytedance.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Xingyu Jin <xingyuj@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278858-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,bytedance.com,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDD77407328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SOCKMAP can hide inflight fd from AF_UNIX GC.

When a socket in SOCKMAP receives skb with inflight fd,
sk_psock_verdict_data_ready() looks up the mapped socket and
enqueue skb to its psock->ingress_skb.

Since neither the old nor the new GC can inspect the psock
queue, the hidden skb leaks the inflight sockets.  Note that
this cannot be detected via kmemleak because inflight sockets
are linked to a global list.

In addition, SOCKMAP redirect breaks the Tarjan-based GC's
assumption that unix_edge.successor is always alive, which
is no longer true once skb is redirected, resulting in
use-after-free below. [0]

Moreover, SOCKMAP does not call scm_stat_del() properly,
so unix_show_fdinfo() could report an incorrect fd count.

sk_msg_recvmsg() does not support any SCM attributes in the
first place.

Let's drop all SCM attributes before passing skb to the
SOCKMAP layer.

[0]:
BUG: KASAN: slab-use-after-free in unix_del_edges (net/unix/garbage.c:118 net/unix/garbage.c:181 net/unix/garbage.c:251)
Read of size 8 at addr ffff888125362670 by task kworker/56:1/496

CPU: 56 UID: 0 PID: 496 Comm: kworker/56:1 Not tainted 7.0.0-rc7-00263-gb9d8b856689d #3 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Workqueue: events sk_psock_backlog
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:122)
 print_report (mm/kasan/report.c:379)
 kasan_report (mm/kasan/report.c:597)
 unix_del_edges (net/unix/garbage.c:118 net/unix/garbage.c:181 net/unix/garbage.c:251)
 unix_destroy_fpl (net/unix/garbage.c:317)
 unix_destruct_scm (./include/net/scm.h:80 ./include/net/scm.h:86 net/unix/af_unix.c:1976)
 sk_psock_backlog (./include/linux/skbuff.h:?)
 process_scheduled_works (kernel/workqueue.c:?)
 worker_thread (kernel/workqueue.c:?)
 kthread (kernel/kthread.c:438)
 ret_from_fork (arch/x86/kernel/process.c:164)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
 </TASK>

Allocated by task 955:
 kasan_save_track (mm/kasan/common.c:58 mm/kasan/common.c:78)
 __kasan_slab_alloc (mm/kasan/common.c:369)
 kmem_cache_alloc_noprof (mm/slub.c:4539)
 sk_prot_alloc (net/core/sock.c:2240)
 sk_alloc (net/core/sock.c:2301)
 unix_create1 (net/unix/af_unix.c:1099)
 unix_create (net/unix/af_unix.c:1169)
 __sock_create (net/socket.c:1606)
 __sys_socketpair (net/socket.c:1811)
 __x64_sys_socketpair (net/socket.c:1863 net/socket.c:1860 net/socket.c:1860)
 do_syscall_64 (arch/x86/entry/syscall_64.c:?)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Freed by task 496:
 kasan_save_track (mm/kasan/common.c:58 mm/kasan/common.c:78)
 kasan_save_free_info (mm/kasan/generic.c:587)
 __kasan_slab_free (mm/kasan/common.c:287)
 kmem_cache_free (mm/slub.c:6165)
 __sk_destruct (net/core/sock.c:2282 net/core/sock.c:2384)
 sk_psock_destroy (./include/net/sock.h:?)
 process_scheduled_works (kernel/workqueue.c:?)
 worker_thread (kernel/workqueue.c:?)
 kthread (kernel/kthread.c:438)
 ret_from_fork (arch/x86/kernel/process.c:164)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:258)

Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Fixes: 77462de14a43 ("af_unix: Add read_sock for stream socket types")
Reported-by: Xingyu Jin <xingyuj@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b23c33df8b46..91a03c8a4281 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1964,16 +1964,19 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 
 static void unix_destruct_scm(struct sk_buff *skb)
 {
-	struct scm_cookie scm;
+	struct scm_cookie scm = {};
+
+	swap(scm.pid, UNIXCB(skb).pid);
 
-	memset(&scm, 0, sizeof(scm));
-	scm.pid = UNIXCB(skb).pid;
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
 
-	/* Alas, it calls VFS */
-	/* So fscking what? fput() had been SMP-safe since the last Summer */
 	scm_destroy(&scm);
+}
+
+static void unix_wfree(struct sk_buff *skb)
+{
+	unix_destruct_scm(skb);
 	sock_wfree(skb);
 }
 
@@ -1989,7 +1992,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	if (scm->fp && send_fds)
 		err = unix_attach_fds(scm, skb);
 
-	skb->destructor = unix_destruct_scm;
+	skb->destructor = unix_wfree;
 	return err;
 }
 
@@ -2066,6 +2069,13 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
+static void unix_orphan_scm(struct sock *sk, struct sk_buff *skb)
+{
+	scm_stat_del(sk, skb);
+	unix_destruct_scm(skb);
+	skb->destructor = sock_wfree;
+}
+
 /*
  *	Send AF_UNIX data.
  */
@@ -2679,10 +2689,16 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	int err;
 
 	mutex_lock(&u->iolock);
+
 	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
-	mutex_unlock(&u->iolock);
-	if (!skb)
+	if (!skb) {
+		mutex_unlock(&u->iolock);
 		return err;
+	}
+
+	unix_orphan_scm(sk, skb);
+
+	mutex_unlock(&u->iolock);
 
 	return recv_actor(sk, skb);
 }
@@ -2882,6 +2898,9 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 #endif
 
 	spin_unlock(&queue->lock);
+
+	unix_orphan_scm(sk, skb);
+
 	mutex_unlock(&u->iolock);
 
 	return recv_actor(sk, skb);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


