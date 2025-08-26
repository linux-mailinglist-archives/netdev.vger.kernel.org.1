Return-Path: <netdev+bounces-216917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11AB35FAD
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53857C596C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB41547CC;
	Tue, 26 Aug 2025 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X18mQadT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF971DEFE7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212645; cv=none; b=Rt2aChuwBMVqoR4LzuCgI1J1iGZGHcKl0ttWtfba9vAT93SpEycXNNXFW/kK7Ql843HHIxuyTY31lZ+1Vm9mY/aVWn6OXejxGGqwMphwVmoAOMEBRJyeMq0axLhK3MwllVW6BFGIIFFe+PmNqrecTqpoxR7HRBNYI2Wr9Avz1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212645; c=relaxed/simple;
	bh=ZOtL0ZPoqBe5ux9EPaLNsds3WG0mkUjKe9oYh8qGvKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4ctVR1uiddlyFnisMCeCN0AjGbfT0WZyFgCOmCNbIPpRGKU8wGZLXUT0AmSVV059XCKJ6nazYBVzLS5WnPAyo/Bf8JtWvHnFVdPh2VB8ww4DjDJAiYDqBq837fV41vR249GyyGZhtiakM9RAx0OxE/fcZu/JKUzV+wTDBBXmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X18mQadT; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b109bccebaso155722441cf.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756212641; x=1756817441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYprzfNrVX6u0XYu21Gxqs3ZWUo8HdoXzhyU/xjkBdQ=;
        b=X18mQadT/epFFPeq/K5KO1StDCSzbXbDwepgPoFq+T1weTUXsZSwRwBvZlJHukp0/9
         pHj/4Cb397c7P7jRW7UnRLhw466+tsraNpKVycj+vqAZT5igEcO3p6aWRptTMdtoUXd8
         Ju70sVFD+tmslPB5uU/Swvz0NY7CrSGinDGb3iMr1bWSuxB2w8kh3x0GQs/OvDYEffls
         yqb8TGrS/aaHBdPevIvaS90bxzlxypYsxdY3a6QDiU02HtM0kGgTEDCtE965CCEYBzDb
         A1ZnMzHcBdzXiqaKflJHhmmtbSW2BF87hZo7yk5uwR42RSCocUiENXW15kUHtczkm2iM
         OObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212641; x=1756817441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYprzfNrVX6u0XYu21Gxqs3ZWUo8HdoXzhyU/xjkBdQ=;
        b=OrvOfsmP0BpQktcbxT2CD4HZYnNVOmaN9tZiO1pVkLQYC21Hio+POAl68hkVmjBQpA
         1myTrpfUhFvVaiOlBuhIAK7Pe1YxcZ+h0Q5XX/B4lsOwI4rcBLhSobD5HjhM5BdlA+t9
         qKSPLqaTIFEdryC9snqo0iBRZgFqt8pSjEsqbBkiTNM69918lE0juwEUMa33KlcOpkNH
         oSsItjJWxH3mKlHlJvsIEmxlcHscb5jCXsw4+L2zntRT7O+cqmuq4nNU/TU6k5eZUxPg
         sEgdRzoRO06GUATMXfScoXa/dGl3l57YYD6BQcdJyDwbfuPXgQwlvbyUGM1zf7bp94R+
         Q+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVB1G85nlJSGNNeMJEshrFl1/xkxOiF7x82/AWBMB64Hzdv19THgHWHQc2fR3GiTDHB+gRS0gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVMe6PoCRQ3YDiCJxj2ztDjWw0G0KxoBldzMdOCOW0pePdoo/
	l8H0qwATAsYhmM67ked+4BbYFqxRzgkfT9kH2BVcHCj9IFT7S0ctPzlMjaf181PFfzq6bQPSnqz
	NZ9/T0ykPon/VpQ==
X-Google-Smtp-Source: AGHT+IFTYgks3wCbm/LKR6tnFOucALP6TdgPu1KuK06Ot4kIfRAKywxIEGhgqkW1wMm3I/r/KWjMpnYuaKCAWg==
X-Received: from qtjw6.prod.google.com ([2002:ac8:7e86:0:b0:4b0:7502:bc38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5445:b0:4b2:d0a5:c3c1 with SMTP id d75a77b69052e-4b2d0a5c6b5mr60625141cf.56.1756212641232;
 Tue, 26 Aug 2025 05:50:41 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:50:29 +0000
In-Reply-To: <20250826125031.1578842-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826125031.1578842-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/5] net: add sk->sk_drop_counters
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some sockets suffer from heavy false sharing on sk->sk_drops,
and fields in the same cache line.

Add sk->sk_drop_counters to:

- move the drop counter(s) to dedicated cache lines.
- Add basic NUMA awareness to these drop counter(s).

Following patches will use this infrastructure for UDP and RAW sockets.

sk_clone_lock() is not yet ready, it would need to properly
set newsk->sk_drop_counters if we plan to use this for TCP sockets.

v2: used Paolo suggestion from https://lore.kernel.org/netdev/8f09830a-d83d-43c9-b36b-88ba0a23e9b2@redhat.com/

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 32 +++++++++++++++++++++++++++++++-
 net/core/sock.c    |  2 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 9edb42ff06224cb8a1dd4f84af25bc22d1803ca9..73cd3316e288bde912dd96637e52d226575c2ffd 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -102,6 +102,11 @@ struct net;
 typedef __u32 __bitwise __portpair;
 typedef __u64 __bitwise __addrpair;
 
+struct socket_drop_counters {
+	atomic_t	drops0 ____cacheline_aligned_in_smp;
+	atomic_t	drops1 ____cacheline_aligned_in_smp;
+};
+
 /**
  *	struct sock_common - minimal network layer representation of sockets
  *	@skc_daddr: Foreign IPv4 addr
@@ -282,6 +287,7 @@ struct sk_filter;
   *	@sk_err_soft: errors that don't cause failure but are the cause of a
   *		      persistent failure not just 'timed out'
   *	@sk_drops: raw/udp drops counter
+  *	@sk_drop_counters: optional pointer to socket_drop_counters
   *	@sk_ack_backlog: current listen backlog
   *	@sk_max_ack_backlog: listen backlog set in listen()
   *	@sk_uid: user id of owner
@@ -449,6 +455,7 @@ struct sock {
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
+	struct socket_drop_counters *sk_drop_counters;
 	__cacheline_group_end(sock_read_rxtx);
 
 	__cacheline_group_begin(sock_write_rxtx);
@@ -2684,7 +2691,18 @@ struct sock_skb_cb {
 
 static inline void sk_drops_add(struct sock *sk, int segs)
 {
-	atomic_add(segs, &sk->sk_drops);
+	struct socket_drop_counters *sdc = sk->sk_drop_counters;
+
+	if (sdc) {
+		int n = numa_node_id() % 2;
+
+		if (n)
+			atomic_add(segs, &sdc->drops1);
+		else
+			atomic_add(segs, &sdc->drops0);
+	} else {
+		atomic_add(segs, &sk->sk_drops);
+	}
 }
 
 static inline void sk_drops_inc(struct sock *sk)
@@ -2694,11 +2712,23 @@ static inline void sk_drops_inc(struct sock *sk)
 
 static inline int sk_drops_read(const struct sock *sk)
 {
+	const struct socket_drop_counters *sdc = sk->sk_drop_counters;
+
+	if (sdc) {
+		DEBUG_NET_WARN_ON_ONCE(atomic_read(&sk->sk_drops));
+		return atomic_read(&sdc->drops0) + atomic_read(&sdc->drops1);
+	}
 	return atomic_read(&sk->sk_drops);
 }
 
 static inline void sk_drops_reset(struct sock *sk)
 {
+	struct socket_drop_counters *sdc = sk->sk_drop_counters;
+
+	if (sdc) {
+		atomic_set(&sdc->drops0, 0);
+		atomic_set(&sdc->drops1, 0);
+	}
 	atomic_set(&sk->sk_drops, 0);
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 75368823969a7992a55a6f40d87ffb8886de2f39..e66ad1ec3a2d969b71835a492806563519459749 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2505,6 +2505,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	newsk->sk_wmem_queued	= 0;
 	newsk->sk_forward_alloc = 0;
 	newsk->sk_reserved_mem  = 0;
+	DEBUG_NET_WARN_ON_ONCE(newsk->sk_drop_counters);
 	sk_drops_reset(newsk);
 	newsk->sk_send_head	= NULL;
 	newsk->sk_userlocks	= sk->sk_userlocks & ~SOCK_BINDPORT_LOCK;
@@ -4457,6 +4458,7 @@ static int __init sock_struct_check(void)
 #ifdef CONFIG_MEMCG
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
 #endif
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_drop_counters);
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
-- 
2.51.0.261.g7ce5a0a67e-goog


