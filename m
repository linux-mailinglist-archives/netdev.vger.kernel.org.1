Return-Path: <netdev+bounces-267050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH7lCS+2smmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:48:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4CA271FD6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DD58300F110
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A41DF26E;
	Thu, 12 Mar 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C17PRAjV"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E8286D57
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319723; cv=none; b=K4eXyRdLQ1jrLLjKgCC1oh4qtVyb9Bh6KnBgGiZAZ2oQMQe90CeZbtkeRrEW64s9sdTCYyf87lIPCzCdVKYdk1NITAn8E5ODMKXjOgkznFVx3rBkDVUrsZXi8P7LFLyPvwkvvVuwbHlP5+BCeH+MAabnQLEVkkuK/2KlgVHyO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319723; c=relaxed/simple;
	bh=DqyrX0jzjSnAv4nvDlX0KV9J5mdZoV6WJSm2RMlPy2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUDXaWodeMjVheMuPtJydNk4wDthJjNfoAgLpaVbzgmsqbUQFtGf15OioW7sOa+gnmgl0L+zx0ODUtNzFHBnlnmDs5pCmEViTn68/Ex+wc99hBcyVm47E6TZEasPQ8sHn9uThmkyAde2xHGObKdQq2cvNsAFQyWDSmKfXrnwJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C17PRAjV; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773319709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DxC3T2vZotQIwHfuvMRzjvgydJ1z+FABP6OfVopqphY=;
	b=C17PRAjVnnwzB1xwomthP960p0r2HOxqrFAZrle8A/wbF9DGx7Z+9mTOaRQvIO/IRN9eRm
	X8TyPwVlnWca4E5sg3vSwwH/3d5iwGMMnWg4pr/CbBlmr7KdM/hImrWdymsaYIjRvVtiWM
	hCBypba0S1zymW32KXWM9VKfKNMw5bc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] tcp: remove redundant memset in hot paths with CONFIG_INIT_STACK_ALL_ZERO
Date: Thu, 12 Mar 2026 20:48:06 +0800
Message-ID: <20260312124807.186341-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267050-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD4CA271FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Modern compilers with CONFIG_INIT_STACK_ALL_ZERO enabled
(-ftrivial-auto-var-init=zero) automatically zero-initialize all stack
variables via `rep stos` in the function prologue. However, the compiler
cannot eliminate explicit memset() calls on those same variables,
resulting in redundant zeroing of the same memory region.

Replace explicit memset() with `= {0}` initializers for stack variables
in TCP hot path functions. With `= {0}`, the compiler recognizes a single
initialization and generates only one zeroing sequence, whereas a
separate memset() after declaration always produces a second `rep stos`.

scripts/bloat-o-meter -t ../vmlinux.old vmlinux

  add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-148 (-148)
  Function                                     old     new   delta
  __tcp_transmit_skb                          5256    5247      -9
  tcp_v6_send_response                        2629    2612     -17
  tcp_make_synack                             3106    3089     -17
  tcp_v4_send_ack                             1465    1428     -37
  tcp_v4_send_reset                           3269    3201     -68
  Total: Before=30075907, After=30075759, chg -0.00%

No functional change intended.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/tcp_ipv4.c   | 13 ++++---------
 net/ipv4/tcp_output.c |  6 ++----
 net/ipv6/tcp_ipv6.c   |  3 +--
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2ea8253b737a..1a413ca0e3bf 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -726,10 +726,10 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	struct {
 		struct tcphdr th;
 		__be32 opt[REPLY_OPTIONS_LEN];
-	} rep;
+	} rep = {0};
 	const __u8 *md5_hash_location = NULL;
 	const struct tcp_ao_hdr *aoh;
-	struct ip_reply_arg arg;
+	struct ip_reply_arg arg = {0};
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key *key = NULL;
 	unsigned char newhash[16];
@@ -751,7 +751,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 		return;
 
 	/* Swap the send and the receive. */
-	memset(&rep, 0, sizeof(rep));
 	rep.th.dest   = th->source;
 	rep.th.source = th->dest;
 	rep.th.doff   = sizeof(struct tcphdr) / 4;
@@ -765,7 +764,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 				       skb->len - (th->doff << 2));
 	}
 
-	memset(&arg, 0, sizeof(arg));
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
@@ -921,15 +919,12 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	struct {
 		struct tcphdr th;
 		__be32 opt[(MAX_TCP_OPTION_SPACE  >> 2)];
-	} rep;
+	} rep = {0};
 	struct net *net = sock_net(sk);
-	struct ip_reply_arg arg;
+	struct ip_reply_arg arg = {0};
 	struct sock *ctl_sk;
 	u64 transmit_time;
 
-	memset(&rep.th, 0, sizeof(struct tcphdr));
-	memset(&arg, 0, sizeof(arg));
-
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 	if (tsecr) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 34a25ef61006..a0d5bed59f44 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1533,7 +1533,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	struct inet_sock *inet;
 	struct tcp_sock *tp;
 	struct tcp_skb_cb *tcb;
-	struct tcp_out_options opts;
+	struct tcp_out_options opts = {0};
 	unsigned int tcp_options_size, tcp_header_size;
 	struct sk_buff *oskb = NULL;
 	struct tcp_key key;
@@ -1566,7 +1566,6 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 	inet = inet_sk(sk);
 	tcb = TCP_SKB_CB(skb);
-	memset(&opts.cleared, 0, sizeof(opts.cleared));
 
 	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
@@ -3934,7 +3933,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct tcp_out_options opts;
+	struct tcp_out_options opts = {0};
 	struct tcp_key key = {};
 	struct sk_buff *skb;
 	int tcp_header_size;
@@ -3972,7 +3971,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
 
-	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(synack_type == TCP_SYNACK_COOKIE && ireq->tstamp_ok))
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8dc3874e8b92..e801927a8ce3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -847,7 +847,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	struct dst_entry *dst;
 	struct sk_buff *buff;
 	struct tcphdr *t1;
-	struct flowi6 fl6;
+	struct flowi6 fl6 = {0};
 	u32 mark = 0;
 
 	if (tsecr)
@@ -922,7 +922,6 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	}
 #endif
 
-	memset(&fl6, 0, sizeof(fl6));
 	fl6.daddr = ipv6_hdr(skb)->saddr;
 	fl6.saddr = ipv6_hdr(skb)->daddr;
 	fl6.flowlabel = label;
-- 
2.43.0


