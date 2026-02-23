Return-Path: <netdev+bounces-259979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IRdITMonGl1AAQAu9opvQ
	(envelope-from <netdev+bounces-259979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:13:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8160174A27
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFA6B309EF55
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9A35C1AE;
	Mon, 23 Feb 2026 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYcade2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3ED35C185
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841258; cv=none; b=XA+3YeLWh2F8qZ2MJSX6PDQGQcsGAUyhhW5P+NuzTLH8luuRa9p5CTJa4DFbBFV2bYePZ4EyZTOzp/cwU4JnKb28N8rzpT9GZhGwoQj+ez/TUn4vMyWYsXWUafM+IWtvN8k3zPXLnvdaLY0mcppdA2uZSEzCiZTyu96+dxSgXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841258; c=relaxed/simple;
	bh=ugTPgja9S9ctMQVsW44A2VGzNVIdoTA6Hd6fGQAmuRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ODsXx8uVs+cy9QGlU8UD2uQTXpwxwTTbOq6CcMSR8f6AKn2XEv0tciLpPCaEsqRWV3BR1sR53mkSLC4A1Dj5BniBxBrgleQ8pNvIXEJjChGC9hm4LShf4ZoegJfxT/tFsUjxTXuZdmFTRm7iEzTo38qXpFJ7uIJZTn5NxWs/s8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYcade2l; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71304beb4so3113575585a.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841256; x=1772446056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdbNBJE8YD/kyedakFdKleGGGqWugQY4nzEmx5zA6RA=;
        b=WYcade2lKam29RK7Zf8J+hgQeEx83dRrzAGFbH9zTzJnSw1wzWZ1kr4rRGIFpgrvEq
         akkFUhiGon0Aw61Lk+XGAiLduc16L/B8wk5uBR/iPW6w7nxKOPxVjC34YVDfYGpdGjVG
         RMGkg676m9Cn+FY6LOW4lr2H1oN+tH4JU1fu5n46MoDzLIcqBy7Nu3YjZzjvxzis2qFU
         9WQLZ8cKWcZd/PYj05AGvduWTSWDYn3O93vMVyYJM8YhtXROV2q7FO3NMtsBJFwaR8HE
         k/PWojk7RAdepMZqh4BwBBESWndqBbiDvQKIz6c2H1XsWMZrZkJQEz+8jMhRqQAZHmcn
         wnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841256; x=1772446056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdbNBJE8YD/kyedakFdKleGGGqWugQY4nzEmx5zA6RA=;
        b=h95ZoGI5o023o3Mr36dfzq3KPhh33IWkvqta3gYN4jl9MCTlba9Rf5EoUjjf1yU7hJ
         aeME1Y8lwBXj6NW+Gc0h1qSQRH0BaBNcsfWF1PHt9nqwsKLaLEnTqtmSu2+HkRoUFkVf
         1KCtln7ofZ7gO+kWH1ocYuao7wL8QcOI98fK+f4EY85s/wfDJzPAcVb4PhE+47ewmo8H
         wBEgz5Wveh+zFtw/loYIhKlqZKHMojKvIbz15+JfKALlUGb1KveU1ChDEcAQImfBv2m7
         hDMt5Qoj7cVCtWw4SDof+ao3SSrn4Y+Duy3FqriKn2pMwUjU44rQGrdBJec4Wp6D0Swm
         zI3g==
X-Forwarded-Encrypted: i=1; AJvYcCV9H3DbIpDwsczMmwuSok7hGvYFGWe4Ajc7wXKR5Hz1ByHdq9/PClU8YQN1SUEjvs08FM2an0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwO8ZrVOE09x9lluqKtU4L0wwzILNfTA70tp+AlIoc+wU6cpD
	liiqM4lJqQAuaVfVNyyIj9Fpc4fBJtGDDwxbJVsoZs6zW4UMFjGWQgblglRde/4Ntb7WrzZStav
	PnHyg6lYWPufa5Q==
X-Received: from qkbd18.prod.google.com ([2002:a05:620a:31f2:b0:8c5:335b:fbe3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a23:b0:8b2:e666:70d with SMTP id af79cd13be357-8cb8ca65b2cmr902955285a.43.1771841255770;
 Mon, 23 Feb 2026 02:07:35 -0800 (PST)
Date: Mon, 23 Feb 2026 10:07:29 +0000
In-Reply-To: <20260223100729.3761597-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223100729.3761597-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223100729.3761597-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259979-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8160174A27
X-Rspamd-Action: no action

tcp_v{4,6}_send_check() are only called from tcp_output.c
and should be made static so that the compiler does not need
to put an out of line copy of them.

Remove (struct inet_connection_sock_af_ops) send_check field
and use instead @net_header_len.

Move @net_header_len close to @queue_xmit for data locality
as both are used in TCP tx fast path.

$ scripts/bloat-o-meter -t vmlinux.2 vmlinux.3
add/remove: 0/2 grow/shrink: 0/3 up/down: 0/-172 (-172)
Function                                     old     new   delta
__tcp_transmit_skb                          3426    3423      -3
tcp_v4_send_check                            136     132      -4
mptcp_subflow_init                           777     763     -14
__pfx_tcp_v6_send_check                       16       -     -16
tcp_v6_send_check                            135       -    -135
Total: Before=25143196, After=25143024, chg -0.00%

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
index feaddce9d80523a9e7bd9db4c691736859c48c91..dfcd38089f113389b82d90e5f45a54a618f2d590 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -531,7 +531,6 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
  *	TCP v4 functions exported for the inet6 API
  */
 
-void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb);
 void tcp_v4_mtu_reduced(struct sock *sk);
 void tcp_req_err(struct sock *sk, u32 seq, bool abort);
 void tcp_ld_RTO_revert(struct sock *sk, u32 seq);
@@ -1132,8 +1131,6 @@ static inline int tcp_v6_sdif(const struct sk_buff *skb)
 
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 
-void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb);
-
 INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *skb));
 void tcp_v6_early_demux(struct sk_buff *skb);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index da708aff06230615bdc9cc19fcd8b2bd91462eff..bd613e401d4865dcb658409b7a54d1a77e1e065c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2405,7 +2405,6 @@ EXPORT_IPV6_MOD(inet_sk_rx_dst_set);
 
 const struct inet_connection_sock_af_ops ipv4_specific = {
 	.queue_xmit	   = ip_queue_xmit,
-	.send_check	   = tcp_v4_send_check,
 	.rebuild_header	   = inet_sk_rebuild_header,
 	.sk_rx_dst_set	   = inet_sk_rx_dst_set,
 	.conn_request	   = tcp_v4_conn_request,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fdddb16630a5108607496bfdc4d603baa43de621..1ef419c66a0ebad6422be73a57afaba044467148 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1498,22 +1498,20 @@ INDIRECT_CALLABLE_DECLARE(int ip_queue_xmit(struct sock *sk, struct sk_buff *skb
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
@@ -1678,7 +1676,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (likely(icsk->icsk_af_ops->send_check == tcp_v6_send_check))
+	if (likely(icsk->icsk_af_ops->net_header_len == sizeof(struct ipv6hdr)))
 		tcp_v6_send_check(sk, skb);
 	else
 #endif
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 306ca0585b4a60fcaafcbc9656a5fe36ad21d1b2..f17da56b449ef30675469e033e0173059791443f 100644
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
index f66129f1e649248e00215d254c925f66c3fffa6a..dd79c5b37a6b62750b62443d911c9fedd67d9d17 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2190,7 +2190,6 @@ void __init mptcp_subflow_init(void)
 
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
2.53.0.345.g96ddfc5eaa-goog


