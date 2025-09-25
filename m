Return-Path: <netdev+bounces-226360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9AB9F717
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED54386961
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814382101AE;
	Thu, 25 Sep 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FQR7fv2h"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AC1C8611
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805885; cv=none; b=OQDGRBZ6MQWKUuA/tSSdaI9GIRnstjq6+aORLwBH+HqACFH7K8LifalzikKyfO6qQJsPS767u+1KR/StvtjA3GdFnYJaGyAY/XgBvg+naXnL8HZQEzMMJevDL4OlWTSTJmoAlysrFci5m8VwUFm0TuIKr7vOI5GQGa1l3K9vy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805885; c=relaxed/simple;
	bh=WJv5Eq0qCMWoipcJUgsMu7XSZzVR3ArKXOoPCDu7V80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAvXiUE+JvVdpi/EpLmz/DnBWkzGnlzSHoSDCnYKYNM2ODzcxDOt7Sg85HoGteFY9XmSmu901Vmg1HxkQQQtC4GFQYmoCnJCLmH9pXfrSsIfp0p9n5pii8MMuCi4PjZdnX0Kb93SB7gfzwyi6IdV5u42nT2VwgnosFzz4OdDTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FQR7fv2h; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758805871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ue6d9AWosO538ctf573qTQxzGRvZd0EoaQR7srTD63g=;
	b=FQR7fv2h4f/vZyJoJDJy2hsyKkMzo6fh3ummxVaj07VMKKpr8Kc/z9L/j5zhTw+EU+Vflu
	s87Hb4Ep9Ju6vFbCekKhXhqP4lTEiggauWpAMe8SeUnnGzzCDFqts9bEmKUDzX1T6U7VHp
	5YwBO9HbRiMDSA1Sj2vmtm41Xyv/rf8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] tcp: fix spurious RST during three-way handshake
Date: Thu, 25 Sep 2025 21:11:00 +0800
Message-ID: <20250925131102.386488-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the server receives the final ACK of the three-way handshake,
tcp_v4_syn_recv_sock::inet_ehash_nolisten::inet_ehash_insert() first
removes the request_sock from the ehash bucket and then inserts the
newly created child sock. This creates a race window where the first
incoming data packet from the client can fail to find either an
ESTABLISHED or SYN_RECV socket, causing the server to send a spurious RST.

The root cause is the lockless lookup in __inet_lookup_established(). A
concurrent lookup operation may not find any valid socket during the brief
period between the removal of the request_sock and the insertion of the
child sock.

To fix this and keep lockless lookup, we need:
1. Insert the child sock into the ehash bucket first.
2. Then remove the request_sock.

This ensures the bucket is never left empty during the transition.

The original inet_ehash_insert() logic first attempted to remove osk,
inserting sk only upon successful removal. We changed this to:
check for osk's existence first. If present, insert sk before removing osk
(ensuring the bucket isn't empty). If osk is absent, take no action. This
maintains the original function's intent while eliminating the window where
the hashtable bucket is empty.

Both sockets briefly coexist in the bucket. During this short window, new
lookups correctly find the child socket. For a packet that has already
started its lookup and finds the lingering request_sock, this is also safe
because inet_csk_complete_hashdance() contains the necessary checks to
prevent the creation of multiple child sockets for the same connection.

Fixes: 079096f103fac ("tcp/dccp: install syn_recv requests into ehash table")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/inet_hashtables.h   |  5 +++--
 net/ipv4/inet_connection_sock.c |  4 ++--
 net/ipv4/inet_hashtables.c      | 31 ++++++++++++++++++++++++++-----
 net/ipv4/tcp_ipv4.c             |  2 +-
 net/ipv6/tcp_ipv6.c             |  2 +-
 5 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ac05a52d9e13..e70415a74ebc 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -288,9 +288,10 @@ void inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 			 unsigned long high_limit);
 int inet_hashinfo2_init_mod(struct inet_hashinfo *h);
 
-bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk);
+bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk,
+		       bool add_first);
 bool inet_ehash_nolisten(struct sock *sk, struct sock *osk,
-			 bool *found_dup_sk);
+			 bool *found_dup_sk, bool add_first);
 int inet_hash(struct sock *sk);
 void inet_unhash(struct sock *sk);
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index cdd1e12aac8c..b52797ab5cea 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1135,7 +1135,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 		if (!nreq)
 			return;
 
-		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
+		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL, false)) {
 			/* delete timer */
 			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
 			goto no_ownership;
@@ -1172,7 +1172,7 @@ static bool reqsk_queue_hash_req(struct request_sock *req,
 {
 	bool found_dup_sk = false;
 
-	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
+	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk, false))
 		return false;
 
 	/* The timer needs to be setup after a successful insertion. */
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index b7024e3d9ac3..2c3baba5c9f4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -702,7 +702,7 @@ static bool inet_ehash_lookup_by_sk(struct sock *sk,
  * If an existing socket already exists, socket sk is not inserted,
  * and sets found_dup_sk parameter to true.
  */
-bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
+bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk, bool add_first)
 {
 	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 	struct inet_ehash_bucket *head;
@@ -720,6 +720,26 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
+
+		if (add_first) {
+			ret = false;
+			if (sk_hashed(osk)) {
+				/* Add the sk to the hashtable before removing
+				 * osk to prevent a transient empty state in
+				 * the hash table during the TCP state
+				 * transition from SYN_RECV to ESTABLISHED.
+				 */
+				__sk_nulls_add_node_rcu(sk, list);
+				ret = sk_nulls_del_node_init_rcu(osk);
+				WARN_ON_ONCE(!ret);
+			}
+			/* If osk is unhashed, it means two requests are
+			 * holding the same osk and another thread has
+			 * successfully inserted its sk into ehash. We do
+			 * nothing and the caller will free the sk.
+			 */
+			goto unlock;
+		}
 		ret = sk_nulls_del_node_init_rcu(osk);
 	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
@@ -730,14 +750,15 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
+unlock:
 	spin_unlock(lock);
 
 	return ret;
 }
 
-bool inet_ehash_nolisten(struct sock *sk, struct sock *osk, bool *found_dup_sk)
+bool inet_ehash_nolisten(struct sock *sk, struct sock *osk, bool *found_dup_sk, bool add_first)
 {
-	bool ok = inet_ehash_insert(sk, osk, found_dup_sk);
+	bool ok = inet_ehash_insert(sk, osk, found_dup_sk, add_first);
 
 	if (ok) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -785,7 +806,7 @@ int inet_hash(struct sock *sk)
 
 	if (sk->sk_state != TCP_LISTEN) {
 		local_bh_disable();
-		inet_ehash_nolisten(sk, NULL, NULL);
+		inet_ehash_nolisten(sk, NULL, NULL, false);
 		local_bh_enable();
 		return 0;
 	}
@@ -1177,7 +1198,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	if (sk_unhashed(sk)) {
 		inet_sk(sk)->inet_sport = htons(port);
-		inet_ehash_nolisten(sk, (struct sock *)tw, NULL);
+		inet_ehash_nolisten(sk, (struct sock *)tw, NULL, false);
 	}
 	if (tw)
 		inet_twsk_bind_unhash(tw, hinfo);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b1fcf3e4e1ce..b8448d8e50a6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1834,7 +1834,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
-				       &found_dup_sk);
+				       &found_dup_sk, true);
 	if (likely(*own_req)) {
 		tcp_move_syn(newtp, req);
 		ireq->ireq_opt = NULL;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9622c2776ade..a5bec9dd5844 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1540,7 +1540,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
-				       &found_dup_sk);
+				       &found_dup_sk, true);
 	if (*own_req) {
 		tcp_move_syn(newtp, req);
 
-- 
2.43.0


