Return-Path: <netdev+bounces-296540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1a7FAgm+JmqJcAIAu9opvQ
	(envelope-from <netdev+bounces-296540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:05:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B16566BF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CkYmGqRA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296540-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296540-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57550303ADF4
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DBD2C21C3;
	Mon,  8 Jun 2026 12:59:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579429E0FD
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:59:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923558; cv=none; b=bsloDtGyvWQ9m1n5xGfZcoVQ7MK3Q7X1mkqz2hrywLQnAvR1Kx99uhJRz8/bIU1M+KfXA5gdWOSjIJDF8wHJynW7UeaUUeOg5FRdyPFUoNsD3VfL3Qa+6ehUkH1g/2okSjVYDEDvnsC7JCCv2uSYG8VMVqRkARYec4ps6eHguiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923558; c=relaxed/simple;
	bh=TGqy07e0KYWbqiUT34j9FgI4+mqzg0Sk7pj9Hp1mx78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSQf1VL5Dcu5ZKURekhqTPPozOkjzi9RzV4IaS+uIjLkQnjdpBx2Wi1mVOiVVp1XjDHj5KWyBwloLjWmg0jvmYhvEUxRCEKZvlrPaVkCMOkn1RuM7EsrtJnkNLjrUfyOrw4Op7Wyc82pZd7oRifMWzMeveMQCGRbYmbM2CeQREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CkYmGqRA; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780923555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z9lruv/1Ak6FgR3qictfE2wiKZjsqaHqmY33SqWS/c=;
	b=CkYmGqRA5zperjGEMNE9HW8CqVdhDBCq1zGzFLJLqt/tJiOTzkyvquzaYie+4468oMEEWt
	jb0Dgn5K4ttBntNblWwlvirAjKP8zOA8NVmUsdpQiv1vBxceKAoGirq5sC+STcQDP5H7+Y
	9J7TXZq4Yq2tgDxU6Kw9GIsyqLPe7bI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Joe Stringer <joe@wand.net.nz>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for BPF-assigned sockets
Date: Mon,  8 Jun 2026 20:58:27 +0800
Message-ID: <20260608125846.157004-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260608125846.157004-1-jiayuan.chen@linux.dev>
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296540-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,wand.net.nz,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 561B16566BF

bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
causing a panic when the skb enters the wrong L4 receive path [1].
An initial attempt tried to fix this in the BPF helper by checking
iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
this check via a TOCTOU attack by modifying iph->protocol around the
call:

    iph->protocol = IPPROTO_TCP;
    bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
    iph->protocol = IPPROTO_UDP;

Furthermore, bpf_sk_assign() has had the same class of vulnerability
since its introduction — it can assign any socket type to any skb
without protocol validation.  Since the BPF helper check alone cannot
prevent a malicious BPF program from crashing the kernel, add protocol
validation in skb_steal_sock() to reject mismatched sockets regardless
of how they were assigned.

The check is applied to all prefetched sockets.  Early demux paths
already only assign matching protocols (e.g., UDP early demux only
assigns UDP sockets to UDP skbs), so they pass the check naturally and
the extra branch is negligible.

Pass the expected protocol from callers rather than extracting it from
the IP header.  For IPv6, walking extension headers to find the L4
protocol is complex and unnecessary since each caller already knows
the protocol it handles.

[1] https://lore.kernel.org/bpf/20260403015851.148209-1-jiayuan.chen@linux.dev/
[2] https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40linux.dev

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/inet6_hashtables.h |  7 ++++---
 include/net/inet_hashtables.h  |  7 ++++---
 include/net/request_sock.h     | 16 +++++++++++++++-
 net/ipv4/udp.c                 |  2 +-
 net/ipv6/udp.c                 |  2 +-
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 2cc5d416bbb5a..218498373a9c1 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -106,12 +106,13 @@ static inline
 struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			      const struct in6_addr *saddr, const __be16 sport,
 			      const struct in6_addr *daddr, const __be16 dport,
-			      bool *refcounted, inet6_ehashfn_t *ehashfn)
+			      bool *refcounted, inet6_ehashfn_t *ehashfn,
+			      int protocol)
 {
 	struct sock *sk, *reuse_sk;
 	bool prefetched;
 
-	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	sk = skb_steal_sock(skb, refcounted, &prefetched, protocol);
 	if (!sk)
 		return NULL;
 
@@ -153,7 +154,7 @@ static inline struct sock *__inet6_lookup_skb(struct sk_buff *skb, int doff,
 	struct sock *sk;
 
 	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
-			      refcounted, inet6_ehashfn);
+			      refcounted, inet6_ehashfn, IPPROTO_TCP);
 	if (IS_ERR(sk))
 		return NULL;
 	if (sk)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 6e2fe186d0dcb..a2a044f93cc4b 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -446,12 +446,13 @@ static inline
 struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			     const __be32 saddr, const __be16 sport,
 			     const __be32 daddr, const __be16 dport,
-			     bool *refcounted, inet_ehashfn_t *ehashfn)
+			     bool *refcounted, inet_ehashfn_t *ehashfn,
+			     int protocol)
 {
 	struct sock *sk, *reuse_sk;
 	bool prefetched;
 
-	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	sk = skb_steal_sock(skb, refcounted, &prefetched, protocol);
 	if (!sk)
 		return NULL;
 
@@ -494,7 +495,7 @@ static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
 	struct sock *sk;
 
 	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
-			     refcounted, inet_ehashfn);
+			     refcounted, inet_ehashfn, IPPROTO_TCP);
 	if (IS_ERR(sk))
 		return NULL;
 	if (sk)
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 5a9c826a7092d..c2b8c6350b624 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -89,9 +89,11 @@ static inline struct sock *req_to_sk(struct request_sock *req)
  * @skb: sk_buff to steal the socket from
  * @refcounted: is set to true if the socket is reference-counted
  * @prefetched: is set to true if the socket was assigned from bpf
+ * @protocol: expected L4 protocol
  */
 static inline struct sock *skb_steal_sock(struct sk_buff *skb,
-					  bool *refcounted, bool *prefetched)
+					  bool *refcounted, bool *prefetched,
+					  int protocol)
 {
 	struct sock *sk = skb->sk;
 
@@ -103,6 +105,18 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 
 	*prefetched = skb_sk_is_prefetched(skb);
 	if (*prefetched) {
+		/* A non-full socket here is either a reqsk or a
+		 * timewait sock, both only contain sock_common and
+		 * lack sk_protocol. Since both can only be TCP,
+		 * use IPPROTO_TCP as the protocol.
+		 */
+		if (unlikely(((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) != protocol))) {
+			skb_orphan(skb);
+			*prefetched = false;
+			*refcounted = false;
+			return NULL;
+		}
+
 #if IS_ENABLED(CONFIG_SYN_COOKIES)
 		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
 			struct request_sock *req = inet_reqsk(sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759b..ceb4d29a64aca 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2618,7 +2618,7 @@ int udp_rcv(struct sk_buff *skb)
 		goto csum_error;
 
 	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			     &refcounted, udp_ehashfn);
+			     &refcounted, udp_ehashfn, IPPROTO_UDP);
 	if (IS_ERR(sk))
 		goto no_sk;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194eccc..d9c12cce5acef 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1106,7 +1106,7 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 
 	/* Check if the socket is already available, e.g. due to early demux */
 	sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			      &refcounted, udp6_ehashfn);
+			      &refcounted, udp6_ehashfn, IPPROTO_UDP);
 	if (IS_ERR(sk))
 		goto no_sk;
 
-- 
2.43.0


