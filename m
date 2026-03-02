Return-Path: <netdev+bounces-262910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDanOswRpmnlJgAAu9opvQ
	(envelope-from <netdev+bounces-262910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:40:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CC1E5C6F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A023C3678057
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87163914E2;
	Mon,  2 Mar 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mz4CC1d8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5B391518
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484931; cv=none; b=BVUcZo5w+Qmtbfk2DZMRxTUit4HxuKZhjFG+Y5r8kBjng51/Mn5d5YruegcptvUyboaUmKWsRUQ0uyJRYGUF7ae3Lih4s0fQnFWOgibX/nSF1D04bmOidaI2KAef5irnI5GSevtHN4BlbjKeIqNM1DSGsMUfbzf6ZgAq+AfTwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484931; c=relaxed/simple;
	bh=3TanzTFSf0EhG0O97MKX/knuCoPY4f5BlJ5XXvcdDvY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rpq9F3Mq2HgthttwXMJfcNT2C4tXELzjzKBVG7Omb+1K8OdVLFNwARYYBR9y9OMjsIu4dmT3aGLJVVu3hTZ1vp2ZzbqDg+bDnqAQ5r6f59uI1CfvDuFodOaQCu9Sq1Y+eqPaIj2TkJIuqMV8np6nMbuQWC/sPMPJHTxcfgepJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mz4CC1d8; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89502dfd7b4so405413726d6.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772484929; x=1773089729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXVl/0YjzXl6cbzLWlFf3Yyf/ADv9iemTwa61jeSjpc=;
        b=mz4CC1d8UJf7dx0rEsNT8VHe+Bal32a745C6n3hqpcsY2N8hlL17srz8zNPMV4ELZN
         y66NJhpZW+rVytAmXvGenNKg6RCL+jXB8FzKr+bJt3UG6gGvUkMiV+k4jfPWwNA3/wwP
         kQxp3AS2cJXuT4Q2kUU5TFE/XUaHBIMSuNhtZ/21Ym7SrZa0243OMyuSHKtb/IzkB7n5
         iE6jfoie+F8oOyay9Cs48Yjue+oMqg1D3NCXD5fKXM+/bXOWSfhgO8va9lvZIryNQ31Z
         5rkkRVGndYpuKIRhdFSvKjZgcGDpMpNmSTyY8NYLRGbWO7gsBNjbYOOf5+15MqQN9KsN
         q3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484929; x=1773089729;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXVl/0YjzXl6cbzLWlFf3Yyf/ADv9iemTwa61jeSjpc=;
        b=rcZUC4WvwoVeJoqbg4zrXcrq8zqEkyez7ctJoXCk6QC9XakDmTzaoIjtvCGPlwNO8O
         gMrQ2Uw9D+SXVNLAhArQZr4q624U+SvzClKeYqCU2w7dpRK7rnllMKxqT6L4MGTIMynZ
         xVNJq7Qu47FuQ5mELXcccQ+Z43Na66s9R8fBPjAuZBoCu1nR6N0bNYr8Ae5vXt2Q4wUB
         4cb5rkJtkEjM3f7K/BWV1Dflb1WFoPgLPO5dimkIM2cdP5F40aTvmL+NPUrJ7czrrMnw
         PLHo0xAgsgWr9GktB12i1OhwZ8oEOAMMWL2E76A8HjAJNofJ2vOVO8mTp5aILiUZ/KUL
         2UIw==
X-Forwarded-Encrypted: i=1; AJvYcCVggWPVtTX7Y3v6tElPhojhwSP/rBeV7QaVhel00k1oIyX+fwN3b+/3XAqWrWHYx/a2t5tNPsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdwXSxcPpHxYKG02t8KKVSpenixqtN6B02pg4IQCm+TxOOBN2
	fLSmjkQ9PohoPm0cw7dEmZ7r43caKAPERGBGr8y02RKx8V+SxMci7EwLBTyuMDx2B8q5oT5+tPN
	TY4J3w10ZLqTkqQ==
X-Received: from qvkj15.prod.google.com ([2002:a0c:e00f:0:b0:899:ffb0:b32f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:574c:0:b0:899:c555:9e67 with SMTP id 6a1803df08f44-899d1e31837mr216871866d6.40.1772484928761;
 Mon, 02 Mar 2026 12:55:28 -0800 (PST)
Date: Mon,  2 Mar 2026 20:55:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302205527.1982836-1-edumazet@google.com>
Subject: [PATCH net] tcp: secure_seq: add back ports to TS offset
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Zhouyan Deng <dengzhouyan_nwpu@163.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 512CC1E5C6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com,strlen.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")

tcp_tw_recycle went away in 2017.

Zhouyan Deng reported off-path TCP source port leakage via
SYN cookie side-channel that can be fixed in multiple ways.

One of them is to bring back TCP ports in TS offset randomization.

As a bonus, we perform a single siphash() computation
to provide both an ISN and a TS offset.

Fixes: 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")
Reported-by: Zhouyan Deng <dengzhouyan_nwpu@163.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
---
 include/net/secure_seq.h | 45 ++++++++++++++++++----
 include/net/tcp.h        |  6 ++-
 net/core/secure_seq.c    | 80 +++++++++++++++-------------------------
 net/ipv4/syncookies.c    | 11 ++++--
 net/ipv4/tcp_input.c     |  8 +++-
 net/ipv4/tcp_ipv4.c      | 37 +++++++++----------
 net/ipv6/syncookies.c    | 11 ++++--
 net/ipv6/tcp_ipv6.c      | 37 +++++++++----------
 8 files changed, 127 insertions(+), 108 deletions(-)

diff --git a/include/net/secure_seq.h b/include/net/secure_seq.h
index cddebafb9f779ebd5d9c02e8ff26c13b5697c7d1..6f996229167b3c3f7861b2d5693ef81b5eed0d74 100644
--- a/include/net/secure_seq.h
+++ b/include/net/secure_seq.h
@@ -5,16 +5,47 @@
 #include <linux/types.h>
 
 struct net;
+extern struct net init_net;
+
+union tcp_seq_and_ts_off {
+	struct {
+		u32 seq;
+		u32 ts_off;
+	};
+	u64 hash64;
+};
 
 u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport);
 u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 			       __be16 dport);
-u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
-		   __be16 sport, __be16 dport);
-u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr);
-u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
-		     __be16 sport, __be16 dport);
-u32 secure_tcpv6_ts_off(const struct net *net,
-			const __be32 *saddr, const __be32 *daddr);
+union tcp_seq_and_ts_off
+secure_tcp_seq_and_ts_off(const struct net *net, __be32 saddr, __be32 daddr,
+			  __be16 sport, __be16 dport);
+
+static inline u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
+				 __be16 sport, __be16 dport)
+{
+	union tcp_seq_and_ts_off ts;
+
+	ts = secure_tcp_seq_and_ts_off(&init_net, saddr, daddr,
+				       sport, dport);
+
+	return ts.seq;
+}
+
+union tcp_seq_and_ts_off
+secure_tcpv6_seq_and_ts_off(const struct net *net, const __be32 *saddr,
+			    const __be32 *daddr,
+			    __be16 sport, __be16 dport);
+
+static inline u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
+				   __be16 sport, __be16 dport)
+{
+	union tcp_seq_and_ts_off ts;
+
+	ts = secure_tcpv6_seq_and_ts_off(&init_net, saddr, daddr,
+					 sport, dport);
 
+	return ts.seq;
+}
 #endif /* _NET_SECURE_SEQ */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index eb8bf63fdafc3243469f293fd06aef0ce086c5a4..978eea2d5df04f378dceb251025bee3101120f69 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -43,6 +43,7 @@
 #include <net/dst.h>
 #include <net/mptcp.h>
 #include <net/xfrm.h>
+#include <net/secure_seq.h>
 
 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
@@ -2464,8 +2465,9 @@ struct tcp_request_sock_ops {
 				       struct flowi *fl,
 				       struct request_sock *req,
 				       u32 tw_isn);
-	u32 (*init_seq)(const struct sk_buff *skb);
-	u32 (*init_ts_off)(const struct net *net, const struct sk_buff *skb);
+	union tcp_seq_and_ts_off (*init_seq_and_ts_off)(
+					const struct net *net,
+					const struct sk_buff *skb);
 	int (*send_synack)(const struct sock *sk, struct dst_entry *dst,
 			   struct flowi *fl, struct request_sock *req,
 			   struct tcp_fastopen_cookie *foc,
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index 9a39656804513dcef0888d280d8289913ef27eea..6a6f2cda5aaef82074718439920c75a75592e967 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -20,7 +20,6 @@
 #include <net/tcp.h>
 
 static siphash_aligned_key_t net_secret;
-static siphash_aligned_key_t ts_secret;
 
 #define EPHEMERAL_PORT_SHUFFLE_PERIOD (10 * HZ)
 
@@ -28,11 +27,6 @@ static __always_inline void net_secret_init(void)
 {
 	net_get_random_once(&net_secret, sizeof(net_secret));
 }
-
-static __always_inline void ts_secret_init(void)
-{
-	net_get_random_once(&ts_secret, sizeof(ts_secret));
-}
 #endif
 
 #ifdef CONFIG_INET
@@ -53,28 +47,9 @@ static u32 seq_scale(u32 seq)
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-u32 secure_tcpv6_ts_off(const struct net *net,
-			const __be32 *saddr, const __be32 *daddr)
-{
-	const struct {
-		struct in6_addr saddr;
-		struct in6_addr daddr;
-	} __aligned(SIPHASH_ALIGNMENT) combined = {
-		.saddr = *(struct in6_addr *)saddr,
-		.daddr = *(struct in6_addr *)daddr,
-	};
-
-	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
-		return 0;
-
-	ts_secret_init();
-	return siphash(&combined, offsetofend(typeof(combined), daddr),
-		       &ts_secret);
-}
-EXPORT_IPV6_MOD(secure_tcpv6_ts_off);
-
-u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
-		     __be16 sport, __be16 dport)
+union tcp_seq_and_ts_off
+secure_tcpv6_seq_and_ts_off(const struct net *net, const __be32 *saddr,
+			    const __be32 *daddr, __be16 sport, __be16 dport)
 {
 	const struct {
 		struct in6_addr saddr;
@@ -87,14 +62,20 @@ u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
 		.sport = sport,
 		.dport = dport
 	};
-	u32 hash;
+	union tcp_seq_and_ts_off st;
 
 	net_secret_init();
-	hash = siphash(&combined, offsetofend(typeof(combined), dport),
-		       &net_secret);
-	return seq_scale(hash);
+
+	st.hash64 = siphash(&combined, offsetofend(typeof(combined), dport),
+			    &net_secret);
+
+	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
+		st.ts_off = 0;
+
+	st.seq = seq_scale(st.seq);
+	return st;
 }
-EXPORT_SYMBOL(secure_tcpv6_seq);
+EXPORT_SYMBOL(secure_tcpv6_seq_and_ts_off);
 
 u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 			       __be16 dport)
@@ -118,33 +99,30 @@ EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
 #endif
 
 #ifdef CONFIG_INET
-u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr)
-{
-	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
-		return 0;
-
-	ts_secret_init();
-	return siphash_2u32((__force u32)saddr, (__force u32)daddr,
-			    &ts_secret);
-}
-
 /* secure_tcp_seq_and_tsoff(a, b, 0, d) == secure_ipv4_port_ephemeral(a, b, d),
  * but fortunately, `sport' cannot be 0 in any circumstances. If this changes,
  * it would be easy enough to have the former function use siphash_4u32, passing
  * the arguments as separate u32.
  */
-u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
-		   __be16 sport, __be16 dport)
+union tcp_seq_and_ts_off
+secure_tcp_seq_and_ts_off(const struct net *net, __be32 saddr, __be32 daddr,
+			  __be16 sport, __be16 dport)
 {
-	u32 hash;
+	u32 ports = (__force u32)sport << 16 | (__force u32)dport;
+	union tcp_seq_and_ts_off st;
 
 	net_secret_init();
-	hash = siphash_3u32((__force u32)saddr, (__force u32)daddr,
-			    (__force u32)sport << 16 | (__force u32)dport,
-			    &net_secret);
-	return seq_scale(hash);
+
+	st.hash64 = siphash_3u32((__force u32)saddr, (__force u32)daddr,
+				 ports, &net_secret);
+
+	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
+		st.ts_off = 0;
+
+	st.seq = seq_scale(st.seq);
+	return st;
 }
-EXPORT_SYMBOL_GPL(secure_tcp_seq);
+EXPORT_SYMBOL_GPL(secure_tcp_seq_and_ts_off);
 
 u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
 {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 061751aabc8e16c5d536a19f7b920d1bca2b0f4f..fc3affd9c8014b1d4e9f161421a7753717cdcd73 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -378,9 +378,14 @@ static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
 	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcp_ts_off(net,
-					  ip_hdr(skb)->daddr,
-					  ip_hdr(skb)->saddr);
+		union tcp_seq_and_ts_off st;
+
+		st = secure_tcp_seq_and_ts_off(net,
+					       ip_hdr(skb)->daddr,
+					       ip_hdr(skb)->saddr,
+					       tcp_hdr(skb)->dest,
+					       tcp_hdr(skb)->source);
+		tsoff = st.ts_off;
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7b03f2460751f366dd6cf15505e49ae26cd6466e..cba89733d1216bc2663758b4bda21984835e6055 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7646,6 +7646,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct sock *fastopen_sk = NULL;
+	union tcp_seq_and_ts_off st;
 	struct request_sock *req;
 	bool want_cookie = false;
 	struct dst_entry *dst;
@@ -7715,9 +7716,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	if (!dst)
 		goto drop_and_free;
 
+	if (tmp_opt.tstamp_ok || (!want_cookie && !isn))
+		st = af_ops->init_seq_and_ts_off(net, skb);
+
 	if (tmp_opt.tstamp_ok) {
 		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
-		tcp_rsk(req)->ts_off = af_ops->init_ts_off(net, skb);
+		tcp_rsk(req)->ts_off = st.ts_off;
 	}
 	if (!want_cookie && !isn) {
 		int max_syn_backlog = READ_ONCE(net->ipv4.sysctl_max_syn_backlog);
@@ -7739,7 +7743,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			goto drop_and_release;
 		}
 
-		isn = af_ops->init_seq(skb);
+		isn = st.seq;
 	}
 
 	tcp_ecn_create_request(req, skb, sk, dst);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d53d39be291a5750af3ab2a160b35f0f8a28ff9d..56c0db955177edd3fdd04d26d6cd07b5e379e7bc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -104,17 +104,14 @@ static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
 
 static DEFINE_MUTEX(tcp_exit_batch_mutex);
 
-static u32 tcp_v4_init_seq(const struct sk_buff *skb)
+static union tcp_seq_and_ts_off
+tcp_v4_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcp_seq(ip_hdr(skb)->daddr,
-			      ip_hdr(skb)->saddr,
-			      tcp_hdr(skb)->dest,
-			      tcp_hdr(skb)->source);
-}
-
-static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
-{
-	return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
+	return secure_tcp_seq_and_ts_off(net,
+					 ip_hdr(skb)->daddr,
+					 ip_hdr(skb)->saddr,
+					 tcp_hdr(skb)->dest,
+					 tcp_hdr(skb)->source);
 }
 
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
@@ -326,15 +323,16 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len
 	rt = NULL;
 
 	if (likely(!tp->repair)) {
+		union tcp_seq_and_ts_off st;
+
+		st = secure_tcp_seq_and_ts_off(net,
+					       inet->inet_saddr,
+					       inet->inet_daddr,
+					       inet->inet_sport,
+					       usin->sin_port);
 		if (!tp->write_seq)
-			WRITE_ONCE(tp->write_seq,
-				   secure_tcp_seq(inet->inet_saddr,
-						  inet->inet_daddr,
-						  inet->inet_sport,
-						  usin->sin_port));
-		WRITE_ONCE(tp->tsoffset,
-			   secure_tcp_ts_off(net, inet->inet_saddr,
-					     inet->inet_daddr));
+			WRITE_ONCE(tp->write_seq, st.seq);
+		WRITE_ONCE(tp->tsoffset, st.ts_off);
 	}
 
 	atomic_set(&inet->inet_id, get_random_u16());
@@ -1676,8 +1674,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 	.cookie_init_seq =	cookie_v4_init_sequence,
 #endif
 	.route_req	=	tcp_v4_route_req,
-	.init_seq	=	tcp_v4_init_seq,
-	.init_ts_off	=	tcp_v4_init_ts_off,
+	.init_seq_and_ts_off	=	tcp_v4_init_seq_and_ts_off,
 	.send_synack	=	tcp_v4_send_synack,
 };
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 7e007f013ec827c99bcab4ceb85eb35e9242b439..4f6f0d751d6c533231ca0397319935dc90ba4dba 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -151,9 +151,14 @@ static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
 	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcpv6_ts_off(net,
-					    ipv6_hdr(skb)->daddr.s6_addr32,
-					    ipv6_hdr(skb)->saddr.s6_addr32);
+		union tcp_seq_and_ts_off st;
+
+		st = secure_tcpv6_seq_and_ts_off(net,
+						 ipv6_hdr(skb)->daddr.s6_addr32,
+						 ipv6_hdr(skb)->saddr.s6_addr32,
+						 tcp_hdr(skb)->dest,
+						 tcp_hdr(skb)->source);
+		tsoff = st.ts_off;
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e46a0efae01235ae7430ed268b92cb47309b8d28..5d95f9ab86973777c29399348adcc4b07e98d2b4 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -104,18 +104,14 @@ static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static u32 tcp_v6_init_seq(const struct sk_buff *skb)
+static union tcp_seq_and_ts_off
+tcp_v6_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcpv6_seq(ipv6_hdr(skb)->daddr.s6_addr32,
-				ipv6_hdr(skb)->saddr.s6_addr32,
-				tcp_hdr(skb)->dest,
-				tcp_hdr(skb)->source);
-}
-
-static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buff *skb)
-{
-	return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->daddr.s6_addr32,
-				   ipv6_hdr(skb)->saddr.s6_addr32);
+	return secure_tcpv6_seq_and_ts_off(net,
+					   ipv6_hdr(skb)->daddr.s6_addr32,
+					   ipv6_hdr(skb)->saddr.s6_addr32,
+					   tcp_hdr(skb)->dest,
+					   tcp_hdr(skb)->source);
 }
 
 static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
@@ -319,14 +315,16 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	sk_set_txhash(sk);
 
 	if (likely(!tp->repair)) {
+		union tcp_seq_and_ts_off st;
+
+		st = secure_tcpv6_seq_and_ts_off(net,
+						 np->saddr.s6_addr32,
+						 sk->sk_v6_daddr.s6_addr32,
+						 inet->inet_sport,
+						 inet->inet_dport);
 		if (!tp->write_seq)
-			WRITE_ONCE(tp->write_seq,
-				   secure_tcpv6_seq(np->saddr.s6_addr32,
-						    sk->sk_v6_daddr.s6_addr32,
-						    inet->inet_sport,
-						    inet->inet_dport));
-		tp->tsoffset = secure_tcpv6_ts_off(net, np->saddr.s6_addr32,
-						   sk->sk_v6_daddr.s6_addr32);
+			WRITE_ONCE(tp->write_seq, st.seq);
+		tp->tsoffset = st.ts_off;
 	}
 
 	if (tcp_fastopen_defer_connect(sk, &err))
@@ -816,8 +814,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 	.cookie_init_seq =	cookie_v6_init_sequence,
 #endif
 	.route_req	=	tcp_v6_route_req,
-	.init_seq	=	tcp_v6_init_seq,
-	.init_ts_off	=	tcp_v6_init_ts_off,
+	.init_seq_and_ts_off	= tcp_v6_init_seq_and_ts_off,
 	.send_synack	=	tcp_v6_send_synack,
 };
 
-- 
2.53.0.473.g4a7958ca14-goog


