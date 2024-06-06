Return-Path: <netdev+bounces-101206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5FB8FDBCF
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF5A284DC2
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AC1DFEF;
	Thu,  6 Jun 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHB8IF3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78C11CB8;
	Thu,  6 Jun 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635511; cv=none; b=JRYoIuf2EAm5z6BCP1v2fZeTtNzCShVjrHjBjbnTmY9NfHFGXakQN6kNeCCyQljnaCTsL3msgdHh/yDE8F4jKubNAyL0ExvlUkPo+3Igdr5pgO52SEx++eU+NL6cgAxV3zLd/dfTc1jF3CqhQnb3hji+l8iC+cMfZJc9suov168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635511; c=relaxed/simple;
	bh=ePdLoiccSiQWmg3JmOyMBhhmfnzW5G+Dcs6pWQ1gWBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzclyUTTjswA5O556JSwyqfAnsMAtdgjkXOxEGQMSQCy7UtQoRIfQyrRfpbcB1zVUchNXiTxCSB1jvqDE99G9jZw697W8YVWWFNwj9Hwcd0G5hkwJRolf8RoX8DFY7JWDPrdFQ04YjWDZ0DKE2MR9V+I48lNORvYQbf14y/YUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHB8IF3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E273CC4AF15;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635510;
	bh=ePdLoiccSiQWmg3JmOyMBhhmfnzW5G+Dcs6pWQ1gWBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dHB8IF3qqbtRTJvNaiB1rqsgkpvzAhFSbj4JbudMAj4FinvEcR+d8pooWswHaFJw8
	 +kyjYT2aaiIZBTW9c/AzE2Mrp6R6nnzHpZIdA630iiTlUiFxyYNn0Lf1LgPijZ0w0Z
	 F32gCXCMUJUyTA6ru6Ho/oB5kr20R5x8YcwX2Wiv5g7nOXkLGuAp6b1VrmgPjXJw9o
	 NvsJcTj30KanNQxsVxQ1khottviNaBEKUlMQ8lfi3+N+Nd1BIBqj9fxyF8KxsOeucF
	 IJOZcQELzT4j/NfNnYDzh8B2xH19ZKDVMS4qxhJtj6tNWHn2DeKNKQB97KRVQTkb+/
	 dkoblU3hAR9Gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3812C27C5F;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 06 Jun 2024 01:58:22 +0100
Subject: [PATCH net-next v3 5/6] net/tcp: Remove tcp_hash_fail()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tcp_ao-tracepoints-v3-5-13621988c09f@gmail.com>
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717635508; l=6884;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=XI7M8UxlijNn0LpHYS39+USk6l9LLXrSMmapXEmiV+g=;
 b=fFR9oaS8dfFyMrJPef2EYJLKwisXLZZuI/+pcMtMxV+8BqNDEhSoa5MgsE9J7doyb+q/uOiaWNWa
 84JTEnudDWB51Ezx/n5WFJUTOujWdjyO717f5O6Rn5tWhjSF1MRm
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Now there are tracepoints, that cover all functionality of
tcp_hash_fail(), but also wire up missing places
They are also faster, can be disabled and provide filtering.

This potentially may create a regression if a userspace depends on dmesg
logs. Fingers crossed, let's see if anyone complains in reality.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp_ao.h | 37 -------------------------------------
 net/ipv4/tcp.c       | 25 -------------------------
 net/ipv4/tcp_ao.c    |  9 ---------
 3 files changed, 71 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 6501ed1dfa1e..ebc6d4e3c073 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -148,43 +148,6 @@ extern struct static_key_false_deferred tcp_ao_needed;
 #define static_branch_tcp_ao()	false
 #endif
 
-static inline bool tcp_hash_should_produce_warnings(void)
-{
-	return static_branch_tcp_md5() || static_branch_tcp_ao();
-}
-
-#define tcp_hash_fail(msg, family, skb, fmt, ...)			\
-do {									\
-	const struct tcphdr *th = tcp_hdr(skb);				\
-	char hdr_flags[6];						\
-	char *f = hdr_flags;						\
-									\
-	if (!tcp_hash_should_produce_warnings())			\
-		break;							\
-	if (th->fin)							\
-		*f++ = 'F';						\
-	if (th->syn)							\
-		*f++ = 'S';						\
-	if (th->rst)							\
-		*f++ = 'R';						\
-	if (th->psh)							\
-		*f++ = 'P';						\
-	if (th->ack)							\
-		*f++ = '.';						\
-	*f = 0;								\
-	if ((family) == AF_INET) {					\
-		net_info_ratelimited("%s for %pI4.%d->%pI4.%d [%s] " fmt "\n", \
-				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
-				&ip_hdr(skb)->daddr, ntohs(th->dest),	\
-				hdr_flags, ##__VA_ARGS__);		\
-	} else {							\
-		net_info_ratelimited("%s for [%pI6c].%d->[%pI6c].%d [%s]" fmt "\n", \
-				msg, &ipv6_hdr(skb)->saddr, ntohs(th->source), \
-				&ipv6_hdr(skb)->daddr, ntohs(th->dest),	\
-				hdr_flags, ##__VA_ARGS__);		\
-	}								\
-} while (0)
-
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
 struct tcp4_ao_context {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cf097a73e42b..49feb1d6e29b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4477,7 +4477,6 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
-		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
 		trace_tcp_hash_md5_unexpected(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
@@ -4493,21 +4492,6 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 							 NULL, skb);
 	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
-		if (family == AF_INET) {
-			tcp_hash_fail("MD5 Hash failed", AF_INET, skb, "%s L3 index %d",
-				      genhash ? "tcp_v4_calc_md5_hash failed"
-				      : "", l3index);
-		} else {
-			if (genhash) {
-				tcp_hash_fail("MD5 Hash failed",
-					      AF_INET6, skb, "L3 index %d",
-					      l3index);
-			} else {
-				tcp_hash_fail("MD5 Hash mismatch",
-					      AF_INET6, skb, "L3 index %d",
-					      l3index);
-			}
-		}
 		trace_tcp_hash_md5_mismatch(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
@@ -4530,8 +4514,6 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 
 	/* Invalid option or two times meet any of auth options */
 	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
-		tcp_hash_fail("TCP segment has incorrect auth options set",
-			      family, skb, "");
 		trace_tcp_hash_bad_header(sk, skb);
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 	}
@@ -4549,9 +4531,6 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 			}
 
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
-			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
-				      family, skb, "%s",
-				      !aoh ? "missing AO" : "AO signed");
 			trace_tcp_ao_handshake_failure(sk, skb, keyid, rnext, maclen);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
 		}
@@ -4570,15 +4549,11 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * always at least one current_key.
 		 */
 		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
-			tcp_hash_fail("AO hash is required, but not found",
-				      family, skb, "L3 index %d", l3index);
 			trace_tcp_hash_ao_required(sk, skb);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-			tcp_hash_fail("MD5 Hash not found",
-				      family, skb, "L3 index %d", l3index);
 			trace_tcp_hash_md5_required(sk, skb);
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 87c5d39dc105..f0f4203fdfed 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -893,9 +893,6 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash wrong length", family, skb,
-			      "%u != %d L3index: %d", maclen,
-			      tcp_ao_maclen(key), l3index);
 		trace_tcp_ao_wrong_maclen(sk, skb, aoh->keyid,
 					  aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
@@ -912,8 +909,6 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash mismatch", family, skb,
-			      "L3index: %d", l3index);
 		trace_tcp_ao_mismatch(sk, skb, aoh->keyid,
 				      aoh->rnext_keyid, maclen);
 		kfree(hash_buf);
@@ -944,8 +939,6 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
 	if (!info) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
-		tcp_hash_fail("AO key not found", family, skb,
-			      "keyid: %u L3index: %d", aoh->keyid, l3index);
 		trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
 					   aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
@@ -1052,8 +1045,6 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 key_not_found:
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 	atomic64_inc(&info->counters.key_not_found);
-	tcp_hash_fail("Requested by the peer AO key id not found",
-		      family, skb, "L3index: %d", l3index);
 	trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
 				   aoh->rnext_keyid, maclen);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;

-- 
2.42.0



