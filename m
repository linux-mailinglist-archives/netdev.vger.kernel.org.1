Return-Path: <netdev+bounces-64280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFA832061
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 21:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207ABB26600
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878692E638;
	Thu, 18 Jan 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nq5S6O+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B32D03C
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609072; cv=none; b=CKLiCDZ51QeBnwkTQECRwk0QTs+MvQyV+qTvCSfoj8tzTaA6uqTvCT76YGCgnYPXbD9axMlJXQHB4WIrqUiOOTG0TiEVn4798tZRZ5OM4mq7NJfOmE0WfliAdIZVPO2E4BTNDKoOjU0LTz1I9eg980awrFDfmAy68lc/C/nalqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609072; c=relaxed/simple;
	bh=5udNc07x8UUFxKf9PSDuFszjoq9tPYzhmPViHE1Iu2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sx+pp21azvlQFSwhxEjLZN7tpsWaeMIRPLaSFQdhxRn3UwpCtCnzaEKqXRvpiHxplGJKT+MdEQBfZbC1z9GBqW0hIbDkJJf3xp1VlUrcC4Y4MNqsCPV8nf05tSm78OApuUX4GcuVVvmgO5l7JkqQgrF6Wi+w1QRclAuzwDn0Gts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nq5S6O+x; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so147112276.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705609070; x=1706213870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=boMQ51/G1MYlXFQCVrBHi7rzH+CB0TUeOtvkq8gtsmI=;
        b=Nq5S6O+xDDL9Ge54HQuGj7cl3hbSXVxSznf7LwTFeVVKoFH/+ugqQYwTk/QH0apYlC
         e1aCb28642Dg0NhYvfPkRxMfY7+vUbpL7mPdrs9LKNWvBkXVUOaIt6nkjBtbke2aDKp5
         N7PaPGLF38FgCQvJhRUuQ71QReOPuIxRNs7Csv+XZpJ3PqkYFiWHnrd5IAj4SuWMqdJ8
         v0diJMZOtoeJ1rwobHfVuHpFjPQcwCs5UUMDRQYQyVCBcZxGWRybzHgLdzmMro2COsGT
         763Z4mXzTgmH5bKOY1BzELgjTFQtkuPJfw9TsxPfvTsiRlWQQuDi+Z7ftfS+18APcd5n
         ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609070; x=1706213870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boMQ51/G1MYlXFQCVrBHi7rzH+CB0TUeOtvkq8gtsmI=;
        b=OZ2Wdl8RFa6kPdWQR4ClL4eWypaJM42iwli9nQ6D3MChOy4JC7mkmP+3yhD9F6WzK3
         L2FZlFnzK045EO70d3O6PE8veu9u5Ks8H202OtoN1FbxTXe0k1U4HXrp+lhlhOIDsLmo
         6nLR5YMBYUrD/IZ/2S9lz9NlULyPoPmnEtovMJWiJA0ZgKl830N9o/IhB8gQK62KL402
         /vttzfYRaL3FDKQK1BOGEmtubyq+5A36Nc/680YSpcCSflM0QRFGGPohXj12C+F1uWQi
         DWCsW8fn6ClzI+cO6vXK2vnt6g0tNAgRcET6/OupUn/z2JhlJXcgwTU3r7u9qsYn8t50
         tl3w==
X-Gm-Message-State: AOJu0YwKLREucIBNdyv/x99GESdnv/nOLNYLE/RmHooGRRV2D+htsG2b
	/Olv9jl9cXq6wTNnaVEDodAPDrTtISv49PgfnuQtQfuFxx7bYu0PdXUO874obO9buJNQhO9Q50d
	HXUPfGrARJQ==
X-Google-Smtp-Source: AGHT+IGz18aWruGQm73JytWD5pYDOYRB2ZUN8TRUkLyebnXVgkslo2IjkTO21TDwSQJAi64icOpPAOhD9qYWtw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2683:0:b0:dbe:49ca:eb03 with SMTP id
 m125-20020a252683000000b00dbe49caeb03mr649182ybm.5.1705609070047; Thu, 18 Jan
 2024 12:17:50 -0800 (PST)
Date: Thu, 18 Jan 2024 20:17:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118201749.4148681-1-edumazet@google.com>
Subject: [PATCH v3 net] udp: fix busy polling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
for presence of packets.

Problem is that for UDP sockets after blamed commit, some packets
could be present in another queue: udp_sk(sk)->reader_queue

In some cases, a busy poller could spin until timeout expiration,
even if some packets are available in udp_sk(sk)->reader_queue.

v3: - make sk_busy_loop_end() nicer (Willem)

v2: - add a READ_ONCE(sk->sk_family) in sk_is_inet() to avoid KCSAN splats.
    - add a sk_is_inet() check in sk_is_udp() (Willem feedback)
    - add a sk_is_inet() check in sk_is_tcp().

Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/skmsg.h   |  6 ------
 include/net/inet_sock.h |  5 -----
 include/net/sock.h      | 18 +++++++++++++++++-
 net/core/sock.c         | 11 +++++++++--
 4 files changed, 26 insertions(+), 14 deletions(-)

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
index 158dbdebce6a3693deb63e557e856d9cdd7500ae..0a7f46c37f0cfc169e11377107c8342c229da0de 100644
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
@@ -4144,8 +4145,14 @@ bool sk_busy_loop_end(void *p, unsigned long start_time)
 {
 	struct sock *sk = p;
 
-	return !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
-	       sk_busy_loop_timeout(sk, start_time);
+	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
+		return true;
+
+	if (sk_is_udp(sk) &&
+	    !skb_queue_empty_lockless(&udp_sk(sk)->reader_queue))
+		return true;
+
+	return sk_busy_loop_timeout(sk, start_time);
 }
 EXPORT_SYMBOL(sk_busy_loop_end);
 #endif /* CONFIG_NET_RX_BUSY_POLL */
-- 
2.43.0.429.g432eaa2c6b-goog


