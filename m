Return-Path: <netdev+bounces-94203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D078BE992
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E621C1F24ABB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7621779BC;
	Tue,  7 May 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p61l+Wbd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFB16D304
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100104; cv=none; b=eyMruAK8FXW3TGaePx2mnk6rz2rCjjI82xwxnvTSKABxRWdAui5m65tjx1aeiMmiaW+bL9AP94MZrJMurjy8ImQU6Hv/B/tDKFSRz4Vv/rk0cN7tk7LZTFU+/rbT750NJK3auq7WwPenDoJepD7kOr62aDKm2TcjzaSjDC6Zxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100104; c=relaxed/simple;
	bh=g9RdJJdQr5+ypb4bqHVtLuMWeVuxUx1tLhAm9Lz7Hsg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l7RRrEm+dG85VBaO/AR2+hQZqjDFbNpGu6/p2yrenGoD6VNklYb1cyC+TPQpK+z/yq5/V8i5wlMQTc0lgWi/uB8ay89ghfhVXaLaVdctFi5a9ELFRnhaeEuqBX+JBbU8XPNNxmeJNTE7jKp50n/fdHElt5J7M0PU5fKjgqCeUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p61l+Wbd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be452c62bso56637827b3.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715100102; x=1715704902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V4JZlOG3KMdumm/hECnSPokzLRwFpE5xEeiTZ8xFU9s=;
        b=p61l+WbdFJ7YyHfFPindJ7GbjXGCap9sTX5r5bKX1Mf2+3ZtqlgN/Q3RSNzJGovcSx
         /g6ZHYcjHkRJiqb3Zel7+3k73qCkfIsvuBo4rPH/YcsB87bKDbCSgQqVRGL5v8+ryhLm
         TANst38PyWWtaunFvPPcWqyNe3fmJhgbUp4vT09Hys2vjjf7OH6o2AnISX5/B4lCRq+x
         P7qi8CX1/6B5sw/N3T/VD5g8n4KWYuqqGC9qbog0wIdcqxZLjtRUY83yGRV3p3ax53I1
         dmSz3A6kdT5T9KC/u/3VM1Lw6YQ7RiHf7uhyapXI27HT6WlSGWEwzjSyBCR9eHkoQrQz
         2iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100102; x=1715704902;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4JZlOG3KMdumm/hECnSPokzLRwFpE5xEeiTZ8xFU9s=;
        b=YMz3tPFfjtP+6YXbvGFwvhOOHshcaRSnwE3lqLy39sV9kd3lnmPBCkodgDxRnEe/hy
         dt2HX7hmKKVoL4JtfmRYKVfkYibIimbuO32FEH5U5oZw4Wa9MHB3Ha+6cDmc3Jxju7ue
         aeVxnudeOoa8te392RlWc9EyXmk2ysJVmBBkiJVZzCDygayFNFhR9T0VGr2kPmXRzxsz
         mnvG3pgsq26jqVOFseaTiKZSflBV15CFcNyCaekyoHI/RR20kXiJ+ynS7KyrciU+vxuC
         9I2442PmSoxDIlLx/a+MBXt7/YCsS3DsYop1wMbfKkDo0AZpLFzOFoz6gIf7sOwI3aIV
         M0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXSlN+UzdhHCgKlzO1Dq0nq2uGOOWjkCdCajMdpqKZai2Q/QUkaWQnnT3L0iUNEsE/1Y2mTr+i3C9bZsRQEJYlHLJM9x3KD
X-Gm-Message-State: AOJu0YzYAlJiW18QTVz8vylVDFm8mwl9ButCuswBbcauIJi04u/e71Ma
	wIyTMWFGEFqNcQ0Z+eWdeilNpMzbFwhIc82g5Wz91rlK29uPUMK2OFldC8Wx3DM2ON2Rf8te7v0
	F6Kmj5gie2Q==
X-Google-Smtp-Source: AGHT+IFE2uqLfM7shSgItIq5UFMNH0R8ihc9A1bjG32pBkSR8c827Qta2VLKJ4823FLk9POI6MY59vS1ZdlHPg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100e:b0:de5:3003:4b64 with SMTP
 id 3f1490d57ef6-debb9cd89d9mr17225276.1.1715100102016; Tue, 07 May 2024
 09:41:42 -0700 (PDT)
Date: Tue,  7 May 2024 16:41:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507164140.940547-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: get rid of twsk_unique()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

DCCP is going away soon, and had no twsk_unique() method.

We can directly call tcp_twsk_unique() for TCP sockets.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/timewait_sock.h | 9 ---------
 net/ipv4/inet_hashtables.c  | 3 ++-
 net/ipv4/tcp_ipv4.c         | 1 -
 net/ipv6/inet6_hashtables.c | 4 +++-
 net/ipv6/tcp_ipv6.c         | 1 -
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/net/timewait_sock.h b/include/net/timewait_sock.h
index 74d2b463cc95e61baced94ff3e6aea3913b506ee..62b3e9f2aed404ba818f4b57d7f2d3acb8ef73f2 100644
--- a/include/net/timewait_sock.h
+++ b/include/net/timewait_sock.h
@@ -15,18 +15,9 @@ struct timewait_sock_ops {
 	struct kmem_cache	*twsk_slab;
 	char		*twsk_slab_name;
 	unsigned int	twsk_obj_size;
-	int		(*twsk_unique)(struct sock *sk,
-				       struct sock *sktw, void *twp);
 	void		(*twsk_destructor)(struct sock *sk);
 };
 
-static inline int twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
-{
-	if (sk->sk_prot->twsk_prot->twsk_unique != NULL)
-		return sk->sk_prot->twsk_prot->twsk_unique(sk, sktw, twp);
-	return 0;
-}
-
 static inline void twsk_destructor(struct sock *sk)
 {
 	if (sk->sk_prot->twsk_prot->twsk_destructor != NULL)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index cf88eca5f1b40563e177c6d84dd59416c62c30e5..48d0d494185b19a5e7282ffb6b33051604c28c9f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -565,7 +565,8 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 		if (likely(inet_match(net, sk2, acookie, ports, dif, sdif))) {
 			if (sk2->sk_state == TCP_TIME_WAIT) {
 				tw = inet_twsk(sk2);
-				if (twsk_unique(sk, sk2, twp))
+				if (sk->sk_protocol == IPPROTO_TCP &&
+				    tcp_twsk_unique(sk, sk2, twp))
 					break;
 			}
 			goto not_unique;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0427deca3e0eb9239558aa124a41a1525df62a04..be0f64fec6840cee3d1734b932ba7c8b1e9bfad2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2431,7 +2431,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 static struct timewait_sock_ops tcp_timewait_sock_ops = {
 	.twsk_obj_size	= sizeof(struct tcp_timewait_sock),
-	.twsk_unique	= tcp_twsk_unique,
 	.twsk_destructor= tcp_twsk_destructor,
 };
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 2e81383b663b71b95719a295fd9629f1193e4225..6db71bb1cd300a9a3d91a8d771db4521978bc5d6 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -21,6 +21,7 @@
 #include <net/secure_seq.h>
 #include <net/ip.h>
 #include <net/sock_reuseport.h>
+#include <net/tcp.h>
 
 u32 inet6_ehashfn(const struct net *net,
 		  const struct in6_addr *laddr, const u16 lport,
@@ -289,7 +290,8 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 				       dif, sdif))) {
 			if (sk2->sk_state == TCP_TIME_WAIT) {
 				tw = inet_twsk(sk2);
-				if (twsk_unique(sk, sk2, twp))
+				if (sk->sk_protocol == IPPROTO_TCP &&
+				    tcp_twsk_unique(sk, sk2, twp))
 					break;
 			}
 			goto not_unique;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 37201c4fb3931d1eb93fcd6868de7167977bf0a1..7f6693e794bd011371a8a794f703192f400546e5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2049,7 +2049,6 @@ void tcp_v6_early_demux(struct sk_buff *skb)
 
 static struct timewait_sock_ops tcp6_timewait_sock_ops = {
 	.twsk_obj_size	= sizeof(struct tcp6_timewait_sock),
-	.twsk_unique	= tcp_twsk_unique,
 	.twsk_destructor = tcp_twsk_destructor,
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


