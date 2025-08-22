Return-Path: <netdev+bounces-215913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228EB30DC1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17F74E1837
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB922271447;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T49yxcaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F577405A;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838568; cv=none; b=fr3XEFqU4iVXk/qSykmeJH2IV/xbOLsOokMUX6gS+gR7JevVu3gyOiI0mWBKv/kCaJG75jWh+EetEAmO12DE5n62SOzUxN1RmgywoCYafQzFi4kq6AQoPiEakUSEeWiPpzRJ5StKhaPfDfUUR9MGlCB8iz+JccXHcVarNHc1A/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838568; c=relaxed/simple;
	bh=C0HjdWTfGl+YL75dV+5AtN/89cGtlHQAYQE0uY6HrKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0+PSAAOiATxCtqkVnGuhutGV1OfMlQ+QvmCqWHwLPauRt3+elCMxo/5W2+mZlakrurd5GT2TMbZA0CLfgKSZhpPpzkUxuznjL/Vwmi5FaJP4I938iwE7EXsmSvAO+inpw49atQUiiiwWxTK3QAmMEqVGstA8fYgb8onknSMJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T49yxcaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48383C113D0;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755838568;
	bh=C0HjdWTfGl+YL75dV+5AtN/89cGtlHQAYQE0uY6HrKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T49yxcaGKITVJHsJPYObhtxco0B9wesCsOjwCdlJ/Ok9t0c1nqbaoO01Yl2q0osvI
	 lJ9BcTG76K1tacRUuP70PTmIqGT1D4CrM7wTvoTbH0R1l8uHUDBzVu3HWYaGjxfKYm
	 yJOsL/oc/nowb8pMhLo12BsEzBTkFQCq2y+nouuZZD+OgoduA9+fLfzjovDvumiXni
	 qV2es+U3yOXvPN18BlNDi5MHe4Wt1QbNxhXt99RQBoWjMZ92YOz7GFc/KhyRS72wJF
	 UsaL2JiJPOYsHAHoKagOuGmW8VKavt1LQ/PsevMOrNBfWV/47YSR4o0y/gdlkKJfIX
	 uknUbvXXtn8IQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38887CA0EED;
	Fri, 22 Aug 2025 04:56:08 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Fri, 22 Aug 2025 05:55:36 +0100
Subject: [PATCH net-next 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb@arista.com>
References: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com>
In-Reply-To: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755838557; l=6665;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=HqMPEN35ULZE014Z8tFG1ylMsDxBsN5cdcxh3D93Eec=;
 b=leTJLkPb0oAxUbaWe8syqJprpZS01zHtTN5Ug86KqiWvg2MrCR9D8ilx/gefqy+42mdvvTHlV
 bgMWlB6iKCCA8whgMjF5HbNbZMEsJ1szjTSPumKum/lVFf6aCH/4rxv
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
 net/ipv4/tcp.c      | 31 +++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c | 25 -------------------------
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc5533224ee00e792de2cfdccd4d40aa..4e996e937e8e5f0e75764caa24240e25006deece 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -412,6 +412,36 @@ static u64 tcp_compute_delivery_rate(const struct tcp_sock *tp)
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
+#endif
+
+static void tcp_destruct_sock(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+#ifdef CONFIG_TCP_MD5SIG
+	if (tp->md5sig_info) {
+		struct tcp_md5sig_info *md5sig;
+
+		md5sig = rcu_dereference_protected(tp->md5sig_info, 1);
+		tcp_clear_md5_list(sk);
+		call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
+		rcu_assign_pointer(tp->md5sig_info, NULL);
+	}
+#endif
+	tcp_ao_destroy_sock(sk, false);
+	inet_sock_destruct(sk);
+}
+
 /* Address-family independent initialization for a tcp_sock.
  *
  * NOTE: A lot of things set to zero explicitly by call to
@@ -464,6 +494,7 @@ void tcp_init_sock(struct sock *sk)
 	tp->tsoffset = 0;
 	tp->rack.reo_wnd_steps = 1;
 
+	sk->sk_destruct = tcp_destruct_sock;
 	sk->sk_write_space = sk_stream_write_space;
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 84d3d556ed8062d07fe7019bc0dadd90d3b80d96..32814f205fdfdcbd4be4765a4e127c8f175d3b14 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2521,18 +2521,6 @@ static int tcp_v4_init_sock(struct sock *sk)
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
@@ -2569,19 +2557,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
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

-- 
2.42.2



