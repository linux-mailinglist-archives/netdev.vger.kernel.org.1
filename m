Return-Path: <netdev+bounces-217644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D5B3969B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C313A437A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B62DC32A;
	Thu, 28 Aug 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi5f4q9c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312033EC;
	Thu, 28 Aug 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368919; cv=none; b=OWr2dA7xpumlpU7C2xRbnjbJdPM6b9z8VrkZjDAZEtxpByTyCOIm7p9mjTIR6XjK/ry9zlbuRLTmf8FcEznT7M7JMxHucGvvzgzRjehURrkuyPZE5raActASW5jBrvTji3XvbYbfKxEiP/wSn7miD5sKOrQIkTk0iiREQRtGKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368919; c=relaxed/simple;
	bh=gtVahfqi/v95sTAw61hhd2jUEZD6ASyw3hrpRfq1iaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogt6PdlNQQ6sYDimyHz9oS1g0yjM2AlLcyUdDv9Q4tDpFyPuedR2EofdU7Cy1WXwoxDlRN86yQeH3MDceubbtWcrp0wPweKFm2stRIIAjK8/x4f5g82ZzmleJfmWfDpWsIh4/WKmVLz+E/BBiQzJvK8xk/pxV5pieaBC9TqXLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi5f4q9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC33DC4CEF5;
	Thu, 28 Aug 2025 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756368919;
	bh=gtVahfqi/v95sTAw61hhd2jUEZD6ASyw3hrpRfq1iaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zi5f4q9ciQzXrCpMYyvzOLsngIAbpDDNWMwkUZBqfZQ/AWrPj+btL8votDdp3fQFC
	 JqTsBoWmRh0Dzm6a2mjGM/TviL41z9LCsijkCbz2mvRHWdPfvs6NfnZOKgCsfxLSRI
	 ERA2zWnKp0qCr0vbn+DlcC7YxEquipmimtd1WXtYru8zoexZ6Q4Aq1hFRPqO1pG8TT
	 Sx6xU3TDaxoMJyEdSVYTR10j/bBHF04XlKisqhNpto+yB9CqRlgv0ewuVYeBFOrSai
	 QxvFnWAxi/7hSOrIn1dFFb+XzjLIv/sIr2ZqDrHZR/LnPPAscvAGyLSNkitoOjTib7
	 5/2yK8aigb9AQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD955CA0FF2;
	Thu, 28 Aug 2025 08:15:18 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Thu, 28 Aug 2025 09:14:55 +0100
Subject: [PATCH net-next v2 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-1-653099bea5c1@arista.com>
References: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com>
In-Reply-To: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756368907; l=8535;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=Amw2qJVt49vPCrLLJ/WmZrJE/wh/xf/SqxJB4wfljtE=;
 b=zsD1h1+XoRdcJ3FSe8F6gk9DViAq3LA38OpM/a5yHwpqThBuuNP0LJQDWI79JXiYMl+JoPQh9
 NIpz1lMnZNbBvJp3+MsLAcDN4cPqXNXiMIcA9kgdnlEGE+4NhG8DeHo
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

From: Dmitry Safonov <dima@arista.com>

Currently there are a couple of minor issues with destroying the keys
tcp_v4_destroy_sock():

1. The socket is yet in TCP bind buckets, making it reachable for
   incoming segments [on another CPU core], potentially available to send
   late FIN/ACK/RST replies.

2. There is at least one code path, where tcp_done() is called before
   sending RST [kudos to Bob for investigation]. This is a case of
   a server, that finished sending its data and just called close().

   The socket is in TCP_FIN_WAIT2 and has RCV_SHUTDOWN (set by
   __tcp_close())

   tcp_v4_do_rcv()/tcp_v6_do_rcv()
     tcp_rcv_state_process()            /* LINUX_MIB_TCPABORTONDATA */
       tcp_reset()
         tcp_done_with_error()
           tcp_done()
             inet_csk_destroy_sock()    /* Destroys AO/MD5 keys */
     /* tcp_rcv_state_process() returns SKB_DROP_REASON_TCP_ABORT_ON_DATA */
   tcp_v4_send_reset()                  /* Sends an unsigned RST segment */

   tcpdump:
> 22:53:15.399377 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 33929, offset 0, flags [DF], proto TCP (6), length 60)
>     1.0.0.1.34567 > 1.0.0.2.49848: Flags [F.], seq 2185658590, ack 3969644355, win 502, options [nop,nop,md5 valid], length 0
> 22:53:15.399396 00:00:01:01:00:00 > 00:00:b2:1f:00:00, ethertype IPv4 (0x0800), length 86: (tos 0x0, ttl 64, id 51951, offset 0, flags [DF], proto TCP (6), length 72)
>     1.0.0.2.49848 > 1.0.0.1.34567: Flags [.], seq 3969644375, ack 2185658591, win 128, options [nop,nop,md5 valid,nop,nop,sack 1 {2185658590:2185658591}], length 0
> 22:53:16.429588 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 60: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 40)
>     1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658590, win 0, length 0
> 22:53:16.664725 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 60)
>     1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, options [nop,nop,md5 valid], length 0
> 22:53:17.289832 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 60)
>     1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, options [nop,nop,md5 valid], length 0

  Note the signed RSTs later in the dump - those are sent by the server
  when the fin-wait socket gets removed from hash buckets, by
  the listener socket.

Instead of destroying AO/MD5 info and their keys in inet_csk_destroy_sock(),
slightly delay it until the actual socket .sk_destruct(). As shutdown'ed
socket can yet send non-data replies, they should be signed in order for
the peer to process them. Now it also matches how AO/MD5 gets destructed
for TIME-WAIT sockets (in tcp_twsk_destructor()).

This seems optimal for TCP-MD5, while for TCP-AO it seems to have an
open problem: once RST get sent and socket gets actually destructed,
there is no information on the initial sequence numbers. So, in case
this last RST gets lost in the network, the server's listener socket
won't be able to properly sign another RST. Nothing in RFC 1122
prescribes keeping any local state after non-graceful reset.
Luckily, BGP are known to use keep alive(s).

While the issue is quite minor/cosmetic, these days monitoring network
counters is a common practice and getting invalid signed segments from
a trusted BGP peer can get customers worried.

Investigated-by: Bob Gilligan <gilligan@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp.h   |  4 ++++
 net/ipv4/tcp.c      | 27 +++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c | 33 ++++++++-------------------------
 net/ipv6/tcp_ipv6.c |  8 ++++++++
 4 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2936b8175950faa777f81f3c6b7230bcc375d772..0009c26241964b54aa93bc1b86158050d96c2c98 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1931,6 +1931,7 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
 }
 
 #define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
+void tcp_md5_destruct_sock(struct sock *sk);
 #else
 static inline struct tcp_md5sig_key *
 tcp_md5_do_lookup(const struct sock *sk, int l3index,
@@ -1947,6 +1948,9 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
 }
 
 #define tcp_twsk_md5_key(twsk)	NULL
+static inline void tcp_md5_destruct_sock(struct sock *sk)
+{
+}
 #endif
 
 int tcp_md5_alloc_sigpool(void);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9bc8317e92b7952871f07ae11a9c2eaa7d3a9e65..927233ee7500e0568782ae4a3860af56d1476acd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -412,6 +412,33 @@ static u64 tcp_compute_delivery_rate(const struct tcp_sock *tp)
 	return rate64;
 }
 
+#ifdef CONFIG_TCP_MD5SIG
+static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
+{
+	struct tcp_md5sig_info *md5sig;
+
+	md5sig = container_of(head, struct tcp_md5sig_info, rcu);
+	kfree(md5sig);
+	static_branch_slow_dec_deferred(&tcp_md5_needed);
+	tcp_md5_release_sigpool();
+}
+
+void tcp_md5_destruct_sock(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (tp->md5sig_info) {
+		struct tcp_md5sig_info *md5sig;
+
+		md5sig = rcu_dereference_protected(tp->md5sig_info, 1);
+		tcp_clear_md5_list(sk);
+		call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
+		rcu_assign_pointer(tp->md5sig_info, NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(tcp_md5_destruct_sock);
+#endif
+
 /* Address-family independent initialization for a tcp_sock.
  *
  * NOTE: A lot of things set to zero explicitly by call to
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a0c93b24c6e0ca2eb477686e477d164b0b132e7a..158b366a55bfd198ffeba13a426d993c3b02528e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2494,6 +2494,13 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 	.ao_calc_key_sk		= tcp_v4_ao_calc_key_sk,
 #endif
 };
+
+static void tcp4_destruct_sock(struct sock *sk)
+{
+	tcp_md5_destruct_sock(sk);
+	tcp_ao_destroy_sock(sk, false);
+	inet_sock_destruct(sk);
+}
 #endif
 
 /* NOTE: A lot of things set to zero explicitly by call to
@@ -2509,23 +2516,12 @@ static int tcp_v4_init_sock(struct sock *sk)
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	tcp_sk(sk)->af_specific = &tcp_sock_ipv4_specific;
+	sk->sk_destruct = tcp4_destruct_sock;
 #endif
 
 	return 0;
 }
 
-#ifdef CONFIG_TCP_MD5SIG
-static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
-{
-	struct tcp_md5sig_info *md5sig;
-
-	md5sig = container_of(head, struct tcp_md5sig_info, rcu);
-	kfree(md5sig);
-	static_branch_slow_dec_deferred(&tcp_md5_needed);
-	tcp_md5_release_sigpool();
-}
-#endif
-
 static void tcp_release_user_frags(struct sock *sk)
 {
 #ifdef CONFIG_PAGE_POOL
@@ -2562,19 +2558,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
 	/* Cleans up our, hopefully empty, out_of_order_queue. */
 	skb_rbtree_purge(&tp->out_of_order_queue);
 
-#ifdef CONFIG_TCP_MD5SIG
-	/* Clean up the MD5 key list, if any */
-	if (tp->md5sig_info) {
-		struct tcp_md5sig_info *md5sig;
-
-		md5sig = rcu_dereference_protected(tp->md5sig_info, 1);
-		tcp_clear_md5_list(sk);
-		call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
-		rcu_assign_pointer(tp->md5sig_info, NULL);
-	}
-#endif
-	tcp_ao_destroy_sock(sk, false);
-
 	/* Clean up a referenced TCP bind bucket. */
 	if (inet_csk(sk)->icsk_bind_hash)
 		inet_put_port(sk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8b2e7b7afbd847b5d94b30ab27779e4dc705710d..5b328aa7b550f8fe9dd4c17128c88d952d81a06d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2112,6 +2112,13 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific = {
 	.ao_calc_key_sk	=	tcp_v4_ao_calc_key_sk,
 #endif
 };
+
+static void tcp6_destruct_sock(struct sock *sk)
+{
+	tcp_md5_destruct_sock(sk);
+	tcp_ao_destroy_sock(sk, false);
+	inet6_sock_destruct(sk);
+}
 #endif
 
 /* NOTE: A lot of things set to zero explicitly by call to
@@ -2127,6 +2134,7 @@ static int tcp_v6_init_sock(struct sock *sk)
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	tcp_sk(sk)->af_specific = &tcp_sock_ipv6_specific;
+	sk->sk_destruct = tcp6_destruct_sock;
 #endif
 
 	return 0;

-- 
2.42.2



