Return-Path: <netdev+bounces-177210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C839FA6E48D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E5D3A7DA1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA31DB34C;
	Mon, 24 Mar 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9W1qJ/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3371DB127
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848582; cv=none; b=ekgShLYGXyIjnnIsxkAiveQnWks9bY5r+5G55VagVD+WXxcoqbkNbtykBIRsB7Kvpe/mupVAfFJQiNPWvlzasQZCIA02MQqBuCvouDTibv9ajrPCVP1WhMoYkzYbX9LPlZVkd6pAbPAZL5wmOBaxT37lENDhtuhy2T+m/QnaGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848582; c=relaxed/simple;
	bh=0S47eo2U6y8wfyvoreMicDR4R4XoeCQRc+kQUDsahqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=grhBm0cMRjWs/rZqb27NehB9LVojlt4EzpT0yLv/Pl3JeVYObvDGCU75qp3lS0HjlBe7bSw1Dia1CCw2Rov1YWFKSu4tzbwU8nuO4CdTOwTXumUQJcCvyMugR4Vq1Y9HtpZlHcRPwQIqE4xIOYV3VYapFgVKlwudGyOmGhjKtBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9W1qJ/W; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4766e03b92bso83029161cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742848580; x=1743453380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K45qXyuC8+T4ImgoY3b8Gag6Bf97dsn4RbIlR6t2s1U=;
        b=s9W1qJ/WgKJuss9oiiXkierCPNczePBAGZbxPbSREXVBC4Ppzx7GjSZuUywZGNnuhi
         sPUk2eEPbta4EFzNMjpr3Xb/28j80LqVf3iBbdHi6C1KbfLp68WQVDAfCLWk1OMIMqaH
         g/hZTTpAsWdNLvbAugh1VFmmwiDYvyu+SWKEgvTDpNXdjEILeHt2lHwglbPtVOWQHhha
         yFUR/AyjkPaMkyaECaGgD7PQrggwYPFmlxdqA1b8OoM3mCYBwVYMhgsN8BfO+ZB2GEwA
         P+fbEfph4DmgEnWJx7WkoLw/qKzgLC7s4/BgLckGIp4Vzn3EB3Jnq84wNXD9gJpOCEbh
         ym6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848580; x=1743453380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K45qXyuC8+T4ImgoY3b8Gag6Bf97dsn4RbIlR6t2s1U=;
        b=r+h7/Yr9qt6Q4E6kfRVZzQguNNbQIIfLl5SfpUdRy6LaZKaGUVdCxH7HrqblQNhE26
         fjOU0OzfhvdNDmyncizxIC3K+USRxm/KABwMbngQ5skcfZ2E2O0hLB9Ipq+tqLIQ5BW3
         PutrmVd88p7uwNSzuOhtTUBjEtGWTnnnQje1fF+CG2llYEDgs+sVrrEBi7jBkmT2lC9u
         OhdE1TlYjUGYLi7iUMIvVkydnZgbAbwqQbqzjsI4KgOl4Y2NYsAg/PK9+rIpYi1UWk6k
         31ey4Cgnuc4wFVtnvSJFY9hRVLxvx8ctxnNishSzotS6U2EzfPYi2bXzmGTPosdIuTh5
         cgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAR5QHrGAxEwfPfLdjwoa9ewxrzFpEFyc/BgsOHluhx5UFKOya1tXfWatgQrSRAQGYUqcs4Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw4/Wy1mXkgjZE1vjDYejO41fwOGIFxEx1+go8KlV4XzwTArb
	2LMxozO1t++LCcDsmPnXfs0bWG5AUGv8Xc8woPajGk4bkQ+p02l5I34s8421J0RTqgo8XyvntRf
	xwnt9IRTEPQ==
X-Google-Smtp-Source: AGHT+IF124JS2MdhpZjf1TMYrsPH257VrjQkig6YeV8oLbH0gwsCZ9JZh80WwMIDBpQqEXJxo2HcOZfsgGodRA==
X-Received: from qtbfh14.prod.google.com ([2002:a05:622a:588e:b0:476:dfe4:e68a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5e17:b0:477:cb9:13b0 with SMTP id d75a77b69052e-4771dd5c6cemr198135111cf.7.1742848579865;
 Mon, 24 Mar 2025 13:36:19 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:36:07 +0000
In-Reply-To: <20250324203607.703850-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324203607.703850-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324203607.703850-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_ack.timeout can be replaced by icsk->csk_delack_timer.expires

This saves 8 bytes in TCP/DCCP sockets and helps for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 .../net_cachelines/inet_connection_sock.rst          |  1 -
 include/net/inet_connection_sock.h                   | 12 ++++++++----
 net/dccp/output.c                                    |  5 ++---
 net/dccp/timer.c                                     |  4 ++--
 net/ipv4/tcp_output.c                                |  7 +++----
 net/ipv4/tcp_timer.c                                 |  5 +++--
 net/mptcp/options.c                                  |  1 -
 net/mptcp/protocol.c                                 |  1 -
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index 5fb0dd70c9af76ca68b3406ce76d4b61957c7da9..8fae85ebb773085b249c606ce37872e0566b70b4 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -38,7 +38,6 @@ struct icsk_ack_u8                  quick                  read_write          w
 struct icsk_ack_u8                  pingpong
 struct icsk_ack_u8                  retry                  write_mostly        read_write          inet_csk_clear_xmit_timer,tcp_rearm_rto,tcp_event_new_data_sent,tcp_write_xmit,__tcp_send_ack,tcp_send_ack,
 struct icsk_ack_u8                  ato                    read_mostly         write_mostly        tcp_dec_quickack_mode,tcp_event_ack_sent,__tcp_transmit_skb,__tcp_send_ack,tcp_send_ack
-struct icsk_ack_unsigned_long       timeout                read_write          read_write          inet_csk_reset_xmit_timer,tcp_connect
 struct icsk_ack_u32                 lrcvtime               read_write                              tcp_finish_connect,tcp_connect,tcp_event_data_sent,__tcp_transmit_skb
 struct icsk_ack_u16                 rcv_mss                write_mostly        read_mostly         __tcp_select_window,__tcp_cleanup_rbuf,tcp_initialize_rcv_mss,tcp_connect_init
 struct icsk_mtup_int                search_high            read_write                              tcp_mtup_init,tcp_sync_mss,tcp_connect_init,tcp_mtu_check_reprobe,tcp_write_xmit
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 6dca0ac6fbc6f50be447e2a554593c77bd9cf1b6..1735db332aab56173e45e8754c8d17b21e7e77c5 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -113,7 +113,6 @@ struct inet_connection_sock {
 				  lrcv_flowlabel:20, /* last received ipv6 flowlabel	   */
 				  dst_quick_ack:1, /* cache dst RTAX_QUICKACK		   */
 				  unused:3;
-		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
 		__u16		  last_seg_size; /* Size of last incoming segment	   */
 		__u16		  rcv_mss;	 /* MSS used for delayed ACK decisions	   */
@@ -191,6 +190,12 @@ icsk_timeout(const struct inet_connection_sock *icsk)
 	return READ_ONCE(icsk->icsk_retransmit_timer.expires);
 }
 
+static inline unsigned long
+icsk_delack_timeout(const struct inet_connection_sock *icsk)
+{
+	return READ_ONCE(icsk->icsk_delack_timer.expires);
+}
+
 static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -226,16 +231,15 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 		when = max_when;
 	}
 
+	when += jiffies;
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0 ||
 	    what == ICSK_TIME_LOSS_PROBE || what == ICSK_TIME_REO_TIMEOUT) {
 		smp_store_release(&icsk->icsk_pending, what);
-		when += jiffies;
 		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, when);
 	} else if (what == ICSK_TIME_DACK) {
 		smp_store_release(&icsk->icsk_ack.pending,
 				  icsk->icsk_ack.pending | ICSK_ACK_TIMER);
-		icsk->icsk_ack.timeout = jiffies + when;
-		sk_reset_timer(sk, &icsk->icsk_delack_timer, icsk->icsk_ack.timeout);
+		sk_reset_timer(sk, &icsk->icsk_delack_timer, when);
 	} else {
 		pr_debug("inet_csk BUG: unknown timer value\n");
 	}
diff --git a/net/dccp/output.c b/net/dccp/output.c
index 5c2e24f3c39b7ff4ee1d5d96d5e406c96609a022..39cf3430177ac597b0a9fd40bf0d8dfbff5fd92d 100644
--- a/net/dccp/output.c
+++ b/net/dccp/output.c
@@ -627,11 +627,10 @@ void dccp_send_delayed_ack(struct sock *sk)
 			return;
 		}
 
-		if (!time_before(timeout, icsk->icsk_ack.timeout))
-			timeout = icsk->icsk_ack.timeout;
+		if (!time_before(timeout, icsk_delack_timeout(icsk)))
+			timeout = icsk_delack_timeout(icsk);
 	}
 	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
-	icsk->icsk_ack.timeout = timeout;
 	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
 }
 #endif
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index 9fd14a3361893d5f2d9f0ad18a65cff963cc7e22..232ac4ae0a73ff31beca730c14d8b02107aeb926 100644
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -185,9 +185,9 @@ static void dccp_delack_timer(struct timer_list *t)
 	if (sk->sk_state == DCCP_CLOSED ||
 	    !(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
 		goto out;
-	if (time_after(icsk->icsk_ack.timeout, jiffies)) {
+	if (time_after(icsk_delack_timeout(icsk), jiffies)) {
 		sk_reset_timer(sk, &icsk->icsk_delack_timer,
-			       icsk->icsk_ack.timeout);
+			       icsk_delack_timeout(icsk));
 		goto out;
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e0a4e5432399a3874e471f2d908bf976350f2696..c29e689d966097fabb83876f21d54201989b444d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4225,17 +4225,16 @@ void tcp_send_delayed_ack(struct sock *sk)
 	/* Use new timeout only if there wasn't a older one earlier. */
 	if (icsk->icsk_ack.pending & ICSK_ACK_TIMER) {
 		/* If delack timer is about to expire, send ACK now. */
-		if (time_before_eq(icsk->icsk_ack.timeout, jiffies + (ato >> 2))) {
+		if (time_before_eq(icsk_delack_timeout(icsk), jiffies + (ato >> 2))) {
 			tcp_send_ack(sk);
 			return;
 		}
 
-		if (!time_before(timeout, icsk->icsk_ack.timeout))
-			timeout = icsk->icsk_ack.timeout;
+		if (!time_before(timeout, icsk_delack_timeout(icsk)))
+			timeout = icsk_delack_timeout(icsk);
 	}
 	smp_store_release(&icsk->icsk_ack.pending,
 			  icsk->icsk_ack.pending | ICSK_ACK_SCHED | ICSK_ACK_TIMER);
-	icsk->icsk_ack.timeout = timeout;
 	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
 }
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d828b74c3e73d75cdae777645e8e8856c0751201..d64383b06a295affb735f60edd4dfd64ad5fb1c8 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -322,8 +322,9 @@ void tcp_delack_timer_handler(struct sock *sk)
 	if (!(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
 		return;
 
-	if (time_after(icsk->icsk_ack.timeout, jiffies)) {
-		sk_reset_timer(sk, &icsk->icsk_delack_timer, icsk->icsk_ack.timeout);
+	if (time_after(icsk_delack_timeout(icsk), jiffies)) {
+		sk_reset_timer(sk, &icsk->icsk_delack_timer,
+			       icsk_delack_timeout(icsk));
 		return;
 	}
 	icsk->icsk_ack.pending &= ~ICSK_ACK_TIMER;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 23949ae2a3a8db19d05c5c8373f45c885c3523ad..421ced0312890b98dde560932b5f9437a15c4030 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -432,7 +432,6 @@ static void clear_3rdack_retransmission(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
-	icsk->icsk_ack.timeout = 0;
 	icsk->icsk_ack.ato = 0;
 	icsk->icsk_ack.pending &= ~(ICSK_ACK_SCHED | ICSK_ACK_TIMER);
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ac378ba1d67cd17449ab6c4b4793b65d520ec44..44f7ab463d7550ad728651bad2b1aeb4cd4dea05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3420,7 +3420,6 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
 	smp_store_release(&icsk->icsk_ack.pending,
 			  icsk->icsk_ack.pending | ICSK_ACK_SCHED | ICSK_ACK_TIMER);
-	icsk->icsk_ack.timeout = timeout;
 	sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
 }
 
-- 
2.49.0.395.g12beb8f557-goog


