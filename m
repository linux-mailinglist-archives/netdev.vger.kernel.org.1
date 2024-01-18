Return-Path: <netdev+bounces-64259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56462831F15
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93993B219F4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4AD2D60E;
	Thu, 18 Jan 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="humdrzCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67D2D058
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602520; cv=none; b=fZ+H4sXO+TPgXc8whKM6UwHZD/wHkpP4ktzAx3BVp45CWdszr/0XDUcgjwm4aiSrLg9jB8gewP+BX2e0wdUK0NKKJXLWTHli6qIT/5pbK65qc5RMiXKUJKYeqKC4FEM5MQL8F3cHLh8JQi5jrGTH7j8KQgSRE+8EVb5du3lscO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602520; c=relaxed/simple;
	bh=g5VW2Ncl6zjfB8+iGXC5CFAvWf2qMsQkIAXsL5twGDY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a/N5ATGNHt0bkpmhZyiuTN0D4GXPcH6VjB9eo64e4zzviPwU511a7bpo/iIWjm558jJEHvwFB5LoMsJ3hSt4X1e044YyS5JK+5ofl6E5ck3h50PS9yDg6q1fh2LXyZOapZ2f2rR6GmcnxONKFIIN9BkO2mUEqM8o6GWHMUHL8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=humdrzCo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9dacc912so15371532276.2
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705602517; x=1706207317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajeUSjDhT8l0EIa8Du8HOJ84v1TOHcQuUNighYk82cg=;
        b=humdrzCobQYO3G91KfWsUHSGqAwI9qirV69MTlreaT67nzGqP6Hdd8OFQgCsTW2Ycp
         6Mi3QE4eihLPACbL6pKvmZzBe7DiYY9SlR0zZYPM6DCBQY8/NQgN9dL+U6CcBkNfK5lv
         Ff2RmmxFuUyAPIc9l/wiBe2AqOmju9dnShUjvIy1OQ4H87nKnqmNfEcJX5qP9ygIhOuq
         ckOFLpPewZKEHiKlk9/8MvnazR7f9OZhUDbQMG/X3TzIzojKVPug9KyxKzGFxGqrGrlk
         UaugvtJTPp0GSP1fN79Ldxw+amqVJJEFiBTL7gzOcwYUaUPDX3UPdIZMwjXEatouKkCs
         nODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602517; x=1706207317;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajeUSjDhT8l0EIa8Du8HOJ84v1TOHcQuUNighYk82cg=;
        b=fywtbWaNMF470X0/O7OJUE4YnLFlKBCxvPzver+HVOelgsc/eNPLbZKEOCPw7ULfux
         GYAmh2zvVhAy6wyBMEvkeG/17A6iKL9ge3hnezTJw0DRvPoTFVeBQZWjgAD43gcJckts
         3cMfJz0ElNVNI8OmfSqNNGivRZrosKsTXiswTEpqo37lH4fd8KbfdAMNYnDn+DGi1uth
         zXqkBCykUxVZsvonuMv40Gi+zB2k08Z8fyRaP6YEcp9hpDnpuXj1ziN70SXmqEowMCnx
         GveS0JHOjdH04HPpQG4po+kBImvwC24M/zmjHI6AP+opP21O1mLMcsouutCpsvsnbro4
         H9nA==
X-Gm-Message-State: AOJu0YyljrlR2CGh7Virz8zPa88AWrsn8qG5ha2gt5BjPxPBZ839vrq0
	Pyswz4u7gb7AmV36TdJmJCSU/LdPVi+igfMAm8B2MgMZZU3G7LG8enamN31ZprQqLh6zGdbRNCt
	lfXPW/pVTWA==
X-Google-Smtp-Source: AGHT+IEZlTyDRD4xuG+RhUcCMrBQswTHPnQSpY3ZL5jlNYk8YggoUMmfh/xu7peQZNergPIO8BZhUjprxEDymA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:602:b0:dc2:260b:64d9 with SMTP
 id d2-20020a056902060200b00dc2260b64d9mr78056ybt.10.1705602517635; Thu, 18
 Jan 2024 10:28:37 -0800 (PST)
Date: Thu, 18 Jan 2024 18:28:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118182835.4004788-1-edumazet@google.com>
Subject: [PATCH v2 net] udp: fix busy polling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
for presence of packets.

Problem is that for UDP sockets after blamed commit, some packets
could be present in another queue: udp_sk(sk)->reader_queue

In some cases, a busy poller could spin until timeout expiration,
even if some packets are available in udp_sk(sk)->reader_queue.

v2:
   - add a READ_ONCE(sk->sk_family) in sk_is_inet() to avoid KCSAN splats.
   - add a sk_is_inet() check in sk_is_udp() (Willem feedback)
   - add a sk_is_inet() check in sk_is_tcp().

Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/skmsg.h   |  6 ------
 include/net/inet_sock.h |  5 -----
 include/net/sock.h      | 18 +++++++++++++++++-
 net/core/sock.c         | 10 +++++++++-
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 888a4b217829fd4d6baf52f784ce35e9ad6bd0ed..e65ec3fd27998a5b82fc2c4597c575125e653056 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -505,12 +505,6 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
 	return !!psock->saved_data_ready;
 }
 
-static inline bool sk_is_udp(const struct sock *sk)
-{
-	return sk->sk_type == SOCK_DGRAM &&
-	       sk->sk_protocol == IPPROTO_UDP;
-}
-
 #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
 
 #define BPF_F_STRPARSER	(1UL << 1)
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index aa86453f6b9ba367f772570a7b783bb098be6236..d94c242eb3ed20b2c5b2e5ceea3953cf96341fb7 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -307,11 +307,6 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
 #define inet_assign_bit(nr, sk, val)		\
 	assign_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags, val)
 
-static inline bool sk_is_inet(struct sock *sk)
-{
-	return sk->sk_family == AF_INET || sk->sk_family == AF_INET6;
-}
-
 /**
  * sk_to_full_sk - Access to a full socket
  * @sk: pointer to a socket
diff --git a/include/net/sock.h b/include/net/sock.h
index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..54ca8dcbfb4335d657b5cea323aa7d8c4316d49e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2765,9 +2765,25 @@ static inline void skb_setup_tx_timestamp(struct sk_buff *skb, __u16 tsflags)
 			   &skb_shinfo(skb)->tskey);
 }
 
+static inline bool sk_is_inet(const struct sock *sk)
+{
+	int family = READ_ONCE(sk->sk_family);
+
+	return family == AF_INET || family == AF_INET6;
+}
+
 static inline bool sk_is_tcp(const struct sock *sk)
 {
-	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_STREAM &&
+	       sk->sk_protocol == IPPROTO_TCP;
+}
+
+static inline bool sk_is_udp(const struct sock *sk)
+{
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_DGRAM &&
+	       sk->sk_protocol == IPPROTO_UDP;
 }
 
 static inline bool sk_is_stream_unix(const struct sock *sk)
diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a3693deb63e557e856d9cdd7500ae..e7e2435ed28681772bf3637b96ddd9334e6a639e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -107,6 +107,7 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/user_namespace.h>
@@ -4143,8 +4144,15 @@ subsys_initcall(proto_init);
 bool sk_busy_loop_end(void *p, unsigned long start_time)
 {
 	struct sock *sk = p;
+	bool packet_ready;
 
-	return !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
+	packet_ready = !skb_queue_empty_lockless(&sk->sk_receive_queue);
+	if (!packet_ready && sk_is_udp(sk)) {
+		struct sk_buff_head *reader_queue = &udp_sk(sk)->reader_queue;
+
+		packet_ready = !skb_queue_empty_lockless(reader_queue);
+	}
+	return packet_ready ||
 	       sk_busy_loop_timeout(sk, start_time);
 }
 EXPORT_SYMBOL(sk_busy_loop_end);
-- 
2.43.0.429.g432eaa2c6b-goog


