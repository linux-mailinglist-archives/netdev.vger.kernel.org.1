Return-Path: <netdev+bounces-85861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C389C9CA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1331928A778
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E71442F6;
	Mon,  8 Apr 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="uM8BOtN+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440271428F3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594166; cv=none; b=QWJ2Eukzd4XDiGtvMKOULyD3rE8GXZxYY6Pq9gV60RlxUuV1R4zH0fL4jYilPS0B6UORHmQL9YivWEsiOiedfWPALoVt0NPLGX9zX+9/fXICgXfDjZIjGfHV845s7gSUmYTnkJ3ItnC71mdcikYzh/7j4hOqmJdcS4s/QS0KfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594166; c=relaxed/simple;
	bh=esAnk1Vn14FCnu6g/w0wJeTpOQksVERHL7TgFeuI0h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCzgLVHuz7rC9seHD0yT0AqJ1TCBmVWqCY4z8DB89mu7FjN2yv/lwbGF3ogd2Kai3C5qR2nn3qy20WGpywBMhoGDOjpfBKGWLOuux2dBSqPLsv8h0NfkKNnipTYhYSVhGrJIS0lBSjuK/+WOYJpBHXWZIVyqVyaWzyibJXYFVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=uM8BOtN+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1rtrdK-00BfbF-DX; Mon, 08 Apr 2024 18:14:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=ZpTjFZsxP951y4tEj8jhDilkxjajyebiLobmoA6+dpo=; b=uM8BOtN+/bkeAWeOudiFMvmriw
	wGKf+5Cs3AvOCqLoj0m6NY+OOBWFbe8i1kgVpPYZDFF3VASckR51eCMWJVT3CbRHXnSKEtrdJ+kL5
	Mt9Im87K2vlWF2AMnoEwD4bh7l7cT6uKCBLYNbWvFAxgNOA65iRo2wYd8oQq/f+u/+kZR+qJf6aem
	+wOlS6pSRL6jHGSseTXTTMSgm02dXn1lo3fg6BfYK5BAnA6IWtO1SnTxq7+rCsCI4DdBY/kSHP7PT
	2MWvJTJdYHQiqpkmY4539GNUpygsZbeixNSiR6JbGbDqZT2C6/N1KYa+WHqOccWWUlMpKPlq/PzJV
	BjlTNvLg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1rtrdJ-0006ea-H4; Mon, 08 Apr 2024 18:14:10 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1rtrd3-00Gq8Q-Df; Mon, 08 Apr 2024 18:13:53 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 1/2] af_unix: Fix garbage collector racing against connect()
Date: Mon,  8 Apr 2024 17:58:45 +0200
Message-ID: <20240408161336.612064-2-mhal@rbox.co>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408161336.612064-1-mhal@rbox.co>
References: <20240408161336.612064-1-mhal@rbox.co>
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
there is another connect() coming, its embryo won't carry SCM_RIGHTS as we
already took the unix_gc_lock.

Fixes: 1fd05ba5a2f2 ("[AF_UNIX]: Rewrite garbage collector, fixes race.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/garbage.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index fa39b6265238..cd3e8585ceb2 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -274,11 +274,20 @@ static void __unix_gc(struct work_struct *work)
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
-		long total_refs;
-
-		total_refs = file_count(u->sk.sk_socket->file);
+		struct sock *sk = &u->sk;
+		long total_refs = file_count(sk->sk_socket->file);
 
 		WARN_ON_ONCE(!u->inflight);
 		WARN_ON_ONCE(total_refs < u->inflight);
@@ -286,6 +295,11 @@ static void __unix_gc(struct work_struct *work)
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


