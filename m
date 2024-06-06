Return-Path: <netdev+bounces-101203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA778FDBC3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E91C22B6C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807CF1094E;
	Thu,  6 Jun 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udf6S3Rj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436511373;
	Thu,  6 Jun 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635511; cv=none; b=A1UNsQwahz7+7ZS7Uk9nCMHvvI0o7BgWq40pZb34cHfebK6d4PeHI96TdGbWGJJq/xv7QbBPk7rIlUqHEP/K2B+kqrgobNBK5uYj7khHALgrcTPwuHol71ksHgmtuzhjERdQrvqNa+S+8UPNc4A6CLHRMm9/O/MR5jirRZAfjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635511; c=relaxed/simple;
	bh=4SJ+OGabkMBGLtrxzVeQ/JjlanvgaI6vKjVVtW4vNbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgYcKjwMkY/XS5zmTlxwz9QWOXAyGajbL++wJI24oH9L+Idbjz29eEljlpPclcRf8Mqa5zc9ZHPSAiV5PxOJhfb4iCqealjYiYmQFKzclNuJtoGwpw9Zn35e82IvLGeJ7BRLGAEP0i5SSPYP6iDA914vHbX6tsTM0PqyYcEj8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udf6S3Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4AB3C4AF0E;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635510;
	bh=4SJ+OGabkMBGLtrxzVeQ/JjlanvgaI6vKjVVtW4vNbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Udf6S3RjhsvBwv8iA0LLS27AXXdDa01TZWmgE21j/aiiyQju52EEELG3ahwhU3diZ
	 96tanTvO2/uH+JPL6NPFTC8kuC3ueGf2JX7U9MjjIvxAw4KpkrH68aYwM6xJLbo8ho
	 bZ+Mwk9iN95COA0H3Guzn5elSc9QhnDh0FltCypZFfxJ8/LRmBguQAdtrknB+zVu27
	 0h+urPBgKte61Ui937jX5GUrNJiufRPSxJcaUsOFwTmjf4GGiMOH7542ljtgaj6nIK
	 zLHA0WiFVf8lWZtX6PIyU/d3J9j58YKdqZAxvTLZGrxF8CncwfB8S68czwGVKT6Hav
	 Fblc6tpdyMFnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4382C27C5E;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 06 Jun 2024 01:58:21 +0100
Subject: [PATCH net-next v3 4/6] net/tcp: Add tcp-md5 and tcp-ao
 tracepoints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tcp_ao-tracepoints-v3-4-13621988c09f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717635508; l=17474;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=rV9tLJXAFL5IlhTVGNtEYzweFa3DIUSi711qAWreDlE=;
 b=wt2JwTIKSb6JegB89N3jfeDFK3AfN6uNQKPEMJDz4EtcDu29GR8wUsguuqiBH6DfdPFlFgevsEan
 Yldd/dfwB/+hlirIG+Sm18lNIcmg/Z8ixAcjXIAHecYBaRqU2PHT
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Instead of forcing userspace to parse dmesg (that's what currently is
happening, at least in codebase of my current company), provide a better
way, that can be enabled/disabled in runtime.

Currently, there are already tcp events, add hashing related ones there,
too. Rasdaemon currently exercises net_dev_xmit_timeout,
devlink_health_report, but it'll be trivial to teach it to deal with
failed hashes. Otherwise, BGP may trace/log them itself. Especially
exciting for possible investigations is key rotation (RNext_key
requests).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/trace/events/tcp.h | 317 +++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c             |  17 +++
 net/ipv4/tcp_ao.c          |  13 ++
 net/ipv4/tcp_input.c       |   8 +-
 net/ipv4/tcp_output.c      |   2 +
 5 files changed, 355 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 49b5ee091cf6..1c8bd8e186b8 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -411,6 +411,323 @@ TRACE_EVENT(tcp_cong_state_set,
 		  __entry->cong_state)
 );
 
+DECLARE_EVENT_CLASS(tcp_hash_event,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+
+	TP_ARGS(sk, skb),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(int, l3index)
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(bool, fin)
+		__field(bool, syn)
+		__field(bool, rst)
+		__field(bool, psh)
+		__field(bool, ack)
+	),
+
+	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS_SKB(skb, th, __entry->saddr, __entry->daddr);
+		__entry->l3index = inet_sdif(skb) ? inet_iif(skb) : 0;
+
+		/* For filtering use */
+		__entry->sport = ntohs(th->source);
+		__entry->dport = ntohs(th->dest);
+		__entry->family = sk->sk_family;
+
+		__entry->fin = th->fin;
+		__entry->syn = th->syn;
+		__entry->rst = th->rst;
+		__entry->psh = th->psh;
+		__entry->ack = th->ack;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc L3index=%d [%c%c%c%c%c]",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->l3index,
+		  __entry->fin ? 'F' : ' ',
+		  __entry->syn ? 'S' : ' ',
+		  __entry->rst ? 'R' : ' ',
+		  __entry->psh ? 'P' : ' ',
+		  __entry->ack ? '.' : ' ')
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_bad_header,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_md5_required,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_md5_unexpected,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_md5_mismatch,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_ao_required,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DECLARE_EVENT_CLASS(tcp_ao_event,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+
+	TP_ARGS(sk, skb, keyid, rnext, maclen),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(int, l3index)
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(bool, fin)
+		__field(bool, syn)
+		__field(bool, rst)
+		__field(bool, psh)
+		__field(bool, ack)
+
+		__field(__u8, keyid)
+		__field(__u8, rnext)
+		__field(__u8, maclen)
+	),
+
+	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS_SKB(skb, th, __entry->saddr, __entry->daddr);
+		__entry->l3index = inet_sdif(skb) ? inet_iif(skb) : 0;
+
+		/* For filtering use */
+		__entry->sport = ntohs(th->source);
+		__entry->dport = ntohs(th->dest);
+		__entry->family = sk->sk_family;
+
+		__entry->fin = th->fin;
+		__entry->syn = th->syn;
+		__entry->rst = th->rst;
+		__entry->psh = th->psh;
+		__entry->ack = th->ack;
+
+		__entry->keyid = keyid;
+		__entry->rnext = rnext;
+		__entry->maclen = maclen;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc L3index=%d [%c%c%c%c%c] keyid=%u rnext=%u maclen=%u",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->l3index,
+		  __entry->fin ? 'F' : ' ',
+		  __entry->syn ? 'S' : ' ',
+		  __entry->rst ? 'R' : ' ',
+		  __entry->psh ? 'P' : ' ',
+		  __entry->ack ? '.' : ' ',
+		  __entry->keyid, __entry->rnext, __entry->maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_handshake_failure,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_wrong_maclen,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_mismatch,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_key_not_found,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_rnext_request,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DECLARE_EVENT_CLASS(tcp_ao_event_sk,
+
+	TP_PROTO(const struct sock *sk, const __u8 keyid, const __u8 rnext),
+
+	TP_ARGS(sk, keyid, rnext),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(__u8, keyid)
+		__field(__u8, rnext)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
+		/* For filtering use */
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		__entry->keyid = keyid;
+		__entry->rnext = rnext;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc keyid=%u rnext=%u",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->keyid, __entry->rnext)
+);
+
+DEFINE_EVENT(tcp_ao_event_sk, tcp_ao_synack_no_key,
+	TP_PROTO(const struct sock *sk, const __u8 keyid, const __u8 rnext),
+	TP_ARGS(sk, keyid, rnext)
+);
+
+DECLARE_EVENT_CLASS(tcp_ao_event_sne,
+
+	TP_PROTO(const struct sock *sk, __u32 new_sne),
+
+	TP_ARGS(sk, new_sne),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(__u32, new_sne)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
+		/* For filtering use */
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		__entry->new_sne = new_sne;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc sne=%u",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->new_sne)
+);
+
+DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_snd_sne_update,
+	TP_PROTO(const struct sock *sk, __u32 new_sne),
+	TP_ARGS(sk, new_sne)
+);
+
+DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_rcv_sne_update,
+	TP_PROTO(const struct sock *sk, __u32 new_sne),
+	TP_ARGS(sk, new_sne)
+);
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 80ed5c099f11..cf097a73e42b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -282,6 +282,7 @@
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
 #include <net/hotdata.h>
+#include <trace/events/tcp.h>
 #include <net/rps.h>
 
 /* Track pending CMSGs. */
@@ -4477,6 +4478,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
 		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
+		trace_tcp_hash_md5_unexpected(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
 
@@ -4506,6 +4508,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 					      l3index);
 			}
 		}
+		trace_tcp_hash_md5_mismatch(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
 	return SKB_NOT_DROPPED_YET;
@@ -4529,15 +4532,27 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
 		tcp_hash_fail("TCP segment has incorrect auth options set",
 			      family, skb, "");
+		trace_tcp_hash_bad_header(sk, skb);
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 	}
 
 	if (req) {
 		if (tcp_rsk_used_ao(req) != !!aoh) {
+			u8 keyid, rnext, maclen;
+
+			if (aoh) {
+				keyid = aoh->keyid;
+				rnext = aoh->rnext_keyid;
+				maclen = tcp_ao_hdr_maclen(aoh);
+			} else {
+				keyid = rnext = maclen = 0;
+			}
+
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
 				      family, skb, "%s",
 				      !aoh ? "missing AO" : "AO signed");
+			trace_tcp_ao_handshake_failure(sk, skb, keyid, rnext, maclen);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
 		}
 	}
@@ -4557,12 +4572,14 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
 			tcp_hash_fail("AO hash is required, but not found",
 				      family, skb, "L3 index %d", l3index);
+			trace_tcp_hash_ao_required(sk, skb);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
 			tcp_hash_fail("MD5 Hash not found",
 				      family, skb, "L3 index %d", l3index);
+			trace_tcp_hash_md5_required(sk, skb);
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
 		return SKB_NOT_DROPPED_YET;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 7c9e90e531e3..87c5d39dc105 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -16,6 +16,7 @@
 #include <net/tcp.h>
 #include <net/ipv6.h>
 #include <net/icmp.h>
+#include <trace/events/tcp.h>
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
 
@@ -895,6 +896,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		tcp_hash_fail("AO hash wrong length", family, skb,
 			      "%u != %d L3index: %d", maclen,
 			      tcp_ao_maclen(key), l3index);
+		trace_tcp_ao_wrong_maclen(sk, skb, aoh->keyid,
+					  aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 
@@ -911,6 +914,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		atomic64_inc(&key->pkt_bad);
 		tcp_hash_fail("AO hash mismatch", family, skb,
 			      "L3index: %d", l3index);
+		trace_tcp_ao_mismatch(sk, skb, aoh->keyid,
+				      aoh->rnext_keyid, maclen);
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -927,6 +932,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		    int l3index, const struct tcp_ao_hdr *aoh)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
+	u8 maclen = tcp_ao_hdr_maclen(aoh);
 	u8 *phash = (u8 *)(aoh + 1); /* hash goes just after the header */
 	struct tcp_ao_info *info;
 	enum skb_drop_reason ret;
@@ -940,6 +946,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 		tcp_hash_fail("AO key not found", family, skb,
 			      "keyid: %u L3index: %d", aoh->keyid, l3index);
+		trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
+					   aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 	}
 
@@ -979,6 +987,9 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		current_key = READ_ONCE(info->current_key);
 		/* Key rotation: the peer asks us to use new key (RNext) */
 		if (unlikely(aoh->rnext_keyid != current_key->sndid)) {
+			trace_tcp_ao_rnext_request(sk, skb, current_key->sndid,
+						   aoh->rnext_keyid,
+						   tcp_ao_hdr_maclen(aoh));
 			/* If the key is not found we do nothing. */
 			key = tcp_ao_established_key(info, aoh->rnext_keyid, -1);
 			if (key)
@@ -1043,6 +1054,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	atomic64_inc(&info->counters.key_not_found);
 	tcp_hash_fail("Requested by the peer AO key id not found",
 		      family, skb, "L3index: %d", l3index);
+	trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
+				   aoh->rnext_keyid, maclen);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 212b6fd0caf7..8281ec710240 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3578,8 +3578,10 @@ static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && ack < tp->snd_una)
+	if (ao && ack < tp->snd_una) {
 		ao->snd_sne++;
+		trace_tcp_ao_snd_sne_update((struct sock *)tp, ao->snd_sne);
+	}
 #endif
 }
 
@@ -3604,8 +3606,10 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && seq < tp->rcv_nxt)
+	if (ao && seq < tp->rcv_nxt) {
 		ao->rcv_sne++;
+		trace_tcp_ao_rcv_sne_update((struct sock *)tp, ao->rcv_sne);
+	}
 #endif
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 090fb0c24599..16c48df8df4c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3768,6 +3768,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 #ifdef CONFIG_TCP_AO
 		struct tcp_ao_key *ao_key = NULL;
 		u8 keyid = tcp_rsk(req)->ao_keyid;
+		u8 rnext = tcp_rsk(req)->ao_rcv_next;
 
 		ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
 							    keyid, -1);
@@ -3777,6 +3778,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 		 * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
 		 */
 		if (unlikely(!ao_key)) {
+			trace_tcp_ao_synack_no_key(sk, keyid, rnext);
 			rcu_read_unlock();
 			kfree_skb(skb);
 			net_warn_ratelimited("TCP-AO: the keyid %u from SYN packet is not present - not sending SYNACK\n",

-- 
2.42.0



