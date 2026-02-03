Return-Path: <netdev+bounces-256322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBamHYEKgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:47:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D9DAC71
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379263149582
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F83AA1BB;
	Tue,  3 Feb 2026 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8AtN9lu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800F3AA1B5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129661; cv=none; b=reyE0wBaKiC16G7fFwuMJynhGh1z/DDRJV/+wDbJmKWSPog2wO+WS43k53WFngpSOaBYTSlkNiec8ZEkpnO48LhKdAg7yM4AbfEKQEhz6KxqxR7yAS++PSwG/zOfBP/FQCIbXM8KVp86vMxLR0QcsTASUdqfdbtsfwjjILqqnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129661; c=relaxed/simple;
	bh=coUoXZJnE6ffCOFz9Icl7l95uCWaI+u9je3tRSPTPXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XILUHcmbaQNEejEHny/8zPp/6zg8iJrib/hMS4lPyUyeJDomjxe1k4gZH5Zbtuq1FPGyIR+Cf6cIaaq9vWWq4jzfJW8hNzHeWdUzxEMSbbC3y5XE59VV4Rf72axnwVNWzfRb+1PvLy9Wmx2wJoMWyQ6Bbl0sQw0QI+tvzW/jUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8AtN9lu; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8887c0d3074so200581566d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770129659; x=1770734459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nt2ovJNDJVp9Y6GN5oLeB1IY2VdDkg7axWt7utphJQI=;
        b=Z8AtN9lukzjLF/YCvXIp2g2KxXaFeLtYIhy2WZYjGLFkazEZf0ReslMTYbUVXsMbqC
         vHjtZqaa8cGhtHtbhgl1CeeUanJbm1oYVOCnEUGlbFvPK74RAYHZKdUMPg90y0Hgl/Jd
         3xIsQv8BQ33u5/x+7UzboxMZk0+7PZg2FBz9dNv19FDLGanGbxl5pA8EmmY+BHbEALG2
         X8dVafZ1b1i/I1vIwr9ZdYn6q5LVaLnczR0EHbgWAeKhPfG/nLhSMJ2dANEEH/Hu8eMI
         S6KqHbsN6XdKVMPxQ8FEshnoIPCp4Ux7PeVG5tI6Mk3FaDSXQcuzVVLCiyNiE6DEPg3X
         toAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129659; x=1770734459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nt2ovJNDJVp9Y6GN5oLeB1IY2VdDkg7axWt7utphJQI=;
        b=uv+sWBiLIxOrnkmKHkwamoMJ5nYUjxAVQqQ02WaiMay0+fFEpg7QfIa+k5705JQVmC
         G6DY3/tLGMXck2xjcGVUUUcqk3Lc5uqlrfJUhwQo871DdsUlX/5pSgKqcBqGyN4vuYe2
         AEe7/Al705CM/G42LBwg1zPBaGN1WzlXf78kjk1H2qoT8+VJDZCq8G9jJ2cq6b89DCkN
         iWD4HPc69O4NBm0Qig73FAE3vj49Bo6RDNlMnuySnoukKqK6tYaC2ULQNcHNC+M8uud5
         V5IV/5UnWxiSObeZrh2sNrGfeTOVvpdO15f2ea6V0ZSz7Qx3d+lKAaQcOkyap0tEpnaG
         JbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdYobhe+GjVasBqRrAVS02BMetHkKY4cfPAM/6nyeYchbykqZM9yWnBFuR4mJqFlKoI4u4Peg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3xTne4Ogi7XUSm/n6o5TB4roMkolaU5tQg2k/bZRk/lPHeLP
	h1QuYNyVQJ+2zXjbBNjBCkihc4EOe9kYSj5cfQKt5ydDRZp23sMw2kl45I+thYd1r5auF02O7OX
	uieOcNZVl8fT7Vw==
X-Received: from qvvv23.prod.google.com ([2002:a05:6214:8097:b0:895:1d69:348e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e8c:b0:882:5078:8da1 with SMTP id 6a1803df08f44-894ea0e654fmr220385166d6.64.1770129659341;
 Tue, 03 Feb 2026 06:40:59 -0800 (PST)
Date: Tue,  3 Feb 2026 14:40:53 +0000
In-Reply-To: <20260203144053.83193-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203144053.83193-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203144053.83193-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256322-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C02D9DAC71
X-Rspamd-Action: no action

tcp_v{4,6}_send_check() are only called from tcp_output.c
and should be made static so that the compiler does not need
to put an out of line copy of them.

Remove (struct inet_connection_sock_af_ops) send_check field
and use instead @net_header_len.

Move @net_header_len close to @queue_xmit for data locality
as both are used in TCP tx fast path.

$ scripts/bloat-o-meter -t vmlinux.2 vmlinux.3
add/remove: 0/4 grow/shrink: 0/2 up/down: 0/-320 (-320)
Function                                     old     new   delta
__tcp_transmit_skb                          3075    3072      -3
mptcp_subflow_init                           777     763     -14
__pfx_tcp_v6_send_check                       16       -     -16
__pfx_tcp_v4_send_check                       16       -     -16
tcp_v6_send_check                            135       -    -135
tcp_v4_send_check                            136       -    -136
Total: Before=24893840, After=24893520, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h | 3 +--
 include/net/tcp.h                  | 3 ---
 net/ipv4/tcp_ipv4.c                | 1 -
 net/ipv4/tcp_output.c              | 8 +++-----
 net/ipv6/tcp_ipv6.c                | 2 --
 net/mptcp/subflow.c                | 1 -
 net/tls/tls_device_fallback.c      | 3 ---
 7 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ecb362025c4e5183ec78aef4b45c249da87c19ea..bbc9355871c767b51e3d1a4d2436022a8556416c 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -34,7 +34,7 @@ struct tcp_congestion_ops;
  */
 struct inet_connection_sock_af_ops {
 	int	    (*queue_xmit)(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
-	void	    (*send_check)(struct sock *sk, struct sk_buff *skb);
+	u16	    net_header_len;
 	int	    (*rebuild_header)(struct sock *sk);
 	void	    (*sk_rx_dst_set)(struct sock *sk, const struct sk_buff *skb);
 	int	    (*conn_request)(struct sock *sk, struct sk_buff *skb);
@@ -43,7 +43,6 @@ struct inet_connection_sock_af_ops {
 				      struct dst_entry *dst,
 				      struct request_sock *req_unhash,
 				      bool *own_req);
-	u16	    net_header_len;
 	int	    (*setsockopt)(struct sock *sk, int level, int optname,
 				  sockptr_t optval, unsigned int optlen);
 	int	    (*getsockopt)(struct sock *sk, int level, int optname,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b9bebf5df4aa6ecf6f421400fb93cefb4104e5aa..339378be8276af2d293f7f52d1aa506e369c5f8d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -531,7 +531,6 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
  *	TCP v4 functions exported for the inet6 API
  */
 
-void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb);
 void tcp_v4_mtu_reduced(struct sock *sk);
 void tcp_req_err(struct sock *sk, u32 seq, bool abort);
 void tcp_ld_RTO_revert(struct sock *sk, u32 seq);
@@ -1124,8 +1123,6 @@ static inline int tcp_v6_sdif(const struct sk_buff *skb)
 
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 
-void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb);
-
 INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *skb));
 void tcp_v6_early_demux(struct sk_buff *skb);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7537adf0846f4fe7e0a1dd1cdec559a982329cc1..c7dcacf418380a70d37e3c6005c2202495c74f8e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2413,7 +2413,6 @@ EXPORT_IPV6_MOD(inet_sk_rx_dst_set);
 
 const struct inet_connection_sock_af_ops ipv4_specific = {
 	.queue_xmit	   = ip_queue_xmit,
-	.send_check	   = tcp_v4_send_check,
 	.rebuild_header	   = inet_sk_rebuild_header,
 	.sk_rx_dst_set	   = inet_sk_rx_dst_set,
 	.conn_request	   = tcp_v4_conn_request,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8c1731b544f42cfa1e7629dde128e969b60d2343..7748cee03e87d74b1bf40e60c6458717c6225a36 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1479,22 +1479,20 @@ INDIRECT_CALLABLE_DECLARE(int ip_queue_xmit(struct sock *sk, struct sk_buff *skb
 INDIRECT_CALLABLE_DECLARE(int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl));
 
 /* This routine computes an IPv4 TCP checksum. */
-void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 
 	__tcp_v4_send_check(skb, inet->inet_saddr, inet->inet_daddr);
 }
-EXPORT_IPV6_MOD(tcp_v4_send_check);
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_checksum.h>
 
-void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
 {
 	__tcp_v6_send_check(skb, &sk->sk_v6_rcv_saddr, &sk->sk_v6_daddr);
 }
-EXPORT_IPV6_MOD(tcp_v6_send_check);
 #endif
 
 /* This routine actually transmits TCP packets queued in by
@@ -1659,7 +1657,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (likely(icsk->icsk_af_ops->send_check == tcp_v6_send_check))
+	if (likely(icsk->icsk_af_ops->net_header_len == sizeof(struct ipv6hdr)))
 		tcp_v6_send_check(sk, skb);
 	else
 #else
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ca01b11c0ac959e4ee18dd388c3d17e8a4c88761..11a055f4863a383df5105303cb181e11614b262d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2017,7 +2017,6 @@ static struct timewait_sock_ops tcp6_timewait_sock_ops = {
 
 const struct inet_connection_sock_af_ops ipv6_specific = {
 	.queue_xmit	   = inet6_csk_xmit,
-	.send_check	   = tcp_v6_send_check,
 	.rebuild_header	   = inet6_sk_rebuild_header,
 	.sk_rx_dst_set	   = inet6_sk_rx_dst_set,
 	.conn_request	   = tcp_v6_conn_request,
@@ -2049,7 +2048,6 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_specific = {
  */
 static const struct inet_connection_sock_af_ops ipv6_mapped = {
 	.queue_xmit	   = ip_queue_xmit,
-	.send_check	   = tcp_v4_send_check,
 	.rebuild_header	   = inet_sk_rebuild_header,
 	.sk_rx_dst_set	   = inet_sk_rx_dst_set,
 	.conn_request	   = tcp_v6_conn_request,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 96d54cb2cd93f447e0e04c53d8eaceaa7de3e9c8..e9f91ce43ffc1f5b76f9042a3b20fa34e5b0b453 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2192,7 +2192,6 @@ void __init mptcp_subflow_init(void)
 
 	subflow_v6m_specific = subflow_v6_specific;
 	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
-	subflow_v6m_specific.send_check = ipv4_specific.send_check;
 	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
 	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
 	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 03d508a45aaee9218bb2deed542534785f2019d6..de7d86bdd7ec99df5be4215ff79dbd5e86e49934 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -149,9 +149,6 @@ static int tls_enc_records(struct aead_request *aead_req,
 	return rc;
 }
 
-/* Can't use icsk->icsk_af_ops->send_check here because the ip addresses
- * might have been changed by NAT.
- */
 static void update_chksum(struct sk_buff *skb, int headln)
 {
 	struct tcphdr *th = tcp_hdr(skb);
-- 
2.53.0.rc1.225.gd81095ad13-goog


