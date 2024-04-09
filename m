Return-Path: <netdev+bounces-86261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F689E434
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DFD1C21C5B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5F157E79;
	Tue,  9 Apr 2024 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oix8zb5a"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3421581E6
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693524; cv=none; b=WOse4KV1vMgWWScY14fwhsMJme3bYcWoiyTbXhUMoqZJe8IflIo/bPJCn1TD1MB+t1lFWRpcs4Ne6FroVViz3TjrhoRwMYHnwdpiJnYcTd7ZaE7xhc+3ubgHkHAatg9bnz0C0N4patSY8F+vBQxb/R4KOqEwW/EAf6owtQUhT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693524; c=relaxed/simple;
	bh=S6kNxgeQ441DPUc2s5JY4j62c0ZhniBmCQKYyiSY1Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lwr7Ls3dmBRlMiLmTQJWRQ4zVbAsRV7aZUBvRfw7g5YaJonBvBi1QPHr1ZYaJXeceRrRjpoSc4bWtf9GAivWHUA1TQcnb/7+Omj/3Bv7EF3dfBCYD3QBwCvIQWZuDlJ9vRHiI6vMEs49k0IhlkGMo6VNoSGCjfEjX3c/l7OVSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oix8zb5a; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ruHoq-00Eoxe-D0; Tue, 09 Apr 2024 22:11:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=+QsVcOoPiFBtxzHKM9rCzcD3HHQF9MKmYCtBXAxZHRA=; b=oix8zb5arHNu7
	2qXyF6pQrp3w/eHFE45uCkOQ9MjueDPunkOha3yjXvzrlIDH9Uk21+om7NmfUfZShoMmeQxpYoqgY
	AnhstvOlegQoFG3sFqzoIWgUWvZesqUkBmuQwm7OVy84B8VyNQ0P1KalpSQ4QB6cWgwT/7xCyOC7b
	0+Mnz3dCtqS86c9uYs1YRThro2gtpsXQ+boCswP263OAZuEIY/+DcrbO3e/EhPplRo6Yj7+dVk24J
	anaUs8W7osiicrRmXo+kYT/c35s3G9AcezAxHgNKMxf36CALLcHpth9a1kcffY8LwTI6uPJx1P2x+
	QGL+suD4IlB3LM8Hk7IVA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ruHop-0005eq-Hp; Tue, 09 Apr 2024 22:11:47 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ruHoj-003gOm-6p; Tue, 09 Apr 2024 22:11:41 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2] af_unix: Fix garbage collector racing against connect()
Date: Tue,  9 Apr 2024 22:09:39 +0200
Message-ID: <20240409201047.1032217-1-mhal@rbox.co>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Garbage collector does not take into account the risk of embryo getting
enqueued during the garbage collection. If such embryo has a peer that
carries SCM_RIGHTS, two consecutive passes of scan_children() may see a
different set of children. Leading to an incorrectly elevated inflight
count, and then a dangling pointer within the gc_inflight_list.

sockets are AF_UNIX/SOCK_STREAM
S is an unconnected socket
L is a listening in-flight socket bound to addr, not in fdtable
V's fd will be passed via sendmsg(), gets inflight count bumped

connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
----------------	-------------------------	-----------

NS = unix_create1()
skb1 = sock_wmalloc(NS)
L = unix_find_other(addr)
unix_state_lock(L)
unix_peer(S) = NS
			// V count=1 inflight=0

 			NS = unix_peer(S)
 			skb2 = sock_alloc()
			skb_queue_tail(NS, skb2[V])

			// V became in-flight
			// V count=2 inflight=1

			close(V)

			// V count=1 inflight=1
			// GC candidate condition met

						for u in gc_inflight_list:
						  if (total_refs == inflight_refs)
						    add u to gc_candidates

						// gc_candidates={L, V}

						for u in gc_candidates:
						  scan_children(u, dec_inflight)

						// embryo (skb1) was not
						// reachable from L yet, so V's
						// inflight remains unchanged
__skb_queue_tail(L, skb1)
unix_state_unlock(L)
						for u in gc_candidates:
						  if (u.inflight)
						    scan_children(u, inc_inflight_move_tail)

						// V count=1 inflight=2 (!)

If there is a GC-candidate listening socket, lock/unlock its state. This
makes GC wait until the end of any ongoing connect() to that socket. After
flipping the lock, a possibly SCM-laden embryo is already enqueued. And if
there is another embryo coming, it can not possibly carry SCM_RIGHTS. At
this point, unix_inflight() can not happen because unix_gc_lock is already
taken. Inflight graph remains unaffected.

Fixes: 1fd05ba5a2f2 ("[AF_UNIX]: Rewrite garbage collector, fixes race.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
v2:
  - Adhere to reverse xmas tree variable ordering
  - Expand commit message
  - Drop the reproducer

v1: https://lore.kernel.org/netdev/20240408161336.612064-1-mhal@rbox.co/

 net/unix/garbage.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index fa39b6265238..6433a414acf8 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -274,11 +274,22 @@ static void __unix_gc(struct work_struct *work)
 	 * receive queues.  Other, non candidate sockets _can_ be
 	 * added to queue, so we must make sure only to touch
 	 * candidates.
+	 *
+	 * Embryos, though never candidates themselves, affect which
+	 * candidates are reachable by the garbage collector.  Before
+	 * being added to a listener's queue, an embryo may already
+	 * receive data carrying SCM_RIGHTS, potentially making the
+	 * passed socket a candidate that is not yet reachable by the
+	 * collector.  It becomes reachable once the embryo is
+	 * enqueued.  Therefore, we must ensure that no SCM-laden
+	 * embryo appears in a (candidate) listener's queue between
+	 * consecutive scan_children() calls.
 	 */
 	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
+		struct sock *sk = &u->sk;
 		long total_refs;
 
-		total_refs = file_count(u->sk.sk_socket->file);
+		total_refs = file_count(sk->sk_socket->file);
 
 		WARN_ON_ONCE(!u->inflight);
 		WARN_ON_ONCE(total_refs < u->inflight);
@@ -286,6 +297,11 @@ static void __unix_gc(struct work_struct *work)
 			list_move_tail(&u->link, &gc_candidates);
 			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
+
+			if (sk->sk_state == TCP_LISTEN) {
+				unix_state_lock(sk);
+				unix_state_unlock(sk);
+			}
 		}
 	}
 
-- 
2.44.0


