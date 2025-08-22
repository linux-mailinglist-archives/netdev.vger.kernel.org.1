Return-Path: <netdev+bounces-216155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13166B324F0
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE3A626D86
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 22:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A32C21E1;
	Fri, 22 Aug 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8XyrWa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFAA27CB0A
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901133; cv=none; b=aF+fSlB0RlxNZZZ3sde8E3WIaeXq79fSLqVZ3mAkcsfEarQWHTiAWMb+1Fya1SeIVcYJtwGfeV+zyMFc42DJA7vuukiTKO5igG80fpwEDEyOEERahX5McGZd5ZApgIiMPAcKzWOavMee9KXpKDjS2Mg/SONfpYOeQvkUkXUgzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901133; c=relaxed/simple;
	bh=E69RHrwIAU6ed8MZqhL+3rFmKU9NK99mZIKH8smRTfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DLNWjhlMy7dgaWX492wzg5daqpdRZBORXiJUtqyJCVAxGoT9rfoKSlmttRAlZWlgw2cgEMCl+WxDpov6adHph4w8BTck1hxM88+xRqVnEG+tgsu4x/SN5yEc83+tQ4aVLSLDdpCFCCEG9YgcjxTSSVikftZT2LRQEdBuL6mVW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8XyrWa8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e41e946eso4839063a91.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901131; x=1756505931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLxKU1w6/ZW+DVLt6dz4n1ylz4VXltq7OpSWiOdrqm8=;
        b=C8XyrWa8NK0pEFBpH30W4FW3o/qK/RaZgujqGSpvKpKHIs/Flx3I+PljX5L/CfoEV5
         tRojaS5M9datVF7jTGxZwO7wBS1632igtCClm8lC6+NdcZVGTNKcSUoIM0SYsSukdi5R
         3MkIgz/l/6a5aLAog81FO+hFfjI+UVAmm2PdXAsvzRm/9PQ8QWk7G2GNV1ylhufP9FYT
         b42zb9VYdpYfdg9z4l0GpF87ufzWP9b3d89M9JhG5Il8ToCQz1gjIoaB3oIbua1V/ZpD
         Yzyntd6cTZ7p8RccPi3nkgVx0n0tyqAil9AMvNLdsvvKo2HL7r1xwQxnfN2nwLEoCMTg
         YYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901131; x=1756505931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLxKU1w6/ZW+DVLt6dz4n1ylz4VXltq7OpSWiOdrqm8=;
        b=FUZjkAj3HqAnEggCcbh6KxkDZI1H1eH6tuiYILlr2+40/zeKY92cMxIYmJpYEKIiyh
         og0rhrkV91SxwsqgJ2Ut68cmjMEjZM5+QwVIO35Q/k4fb+yhW0LecBfQANVg3vd3Xaqd
         TY3bSjFdh5o3ywzy0T3XwASPai/EaBDMzc9fMIQRCuxWhbD1ZObzq47to9sPPjromjds
         vSqURrCOl/mJSHCRGuUgPB2iJ8fe31auFmgfKbkQLbmp4aQCNrZVyjW1HVpgx93xcFf0
         WxWl7gOmLnSnR2pOa1sqJZqVwalgqLVIPNwcbZrtBpDi75IA6zjP91HobZbUqtMAoUKN
         zcmg==
X-Forwarded-Encrypted: i=1; AJvYcCWvasWmmu/F46ixfVweIfQ5wjWAHNN2MsAT1bqirufIuX6uNYBABR2pABOK1rej8oF/SwFMIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytfaX+3xXKu+EZDTYrunOY1zENcb1LlkBssN428Yx1sUJgPVnh
	/FCvfhrC3k/1k/li8bg5ADx3QJNQUEmlWrNXrv4f/sSsX6rDKH9TXXobNIwzADJrAldriQih4g+
	NqDkIdg==
X-Google-Smtp-Source: AGHT+IEspOn7Lkp87SIvsDSkX/Ekf05WNqQa3WA2C/+tFZTykkeB8cSBhpldbcLwNtsk/bHq6gdFmaWEVsI=
X-Received: from pjboh11.prod.google.com ([2002:a17:90b:3a4b:b0:312:e914:4548])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8b:b0:31f:16ee:5dcc
 with SMTP id 98e67ed59e1d1-32515e527b3mr6481311a91.14.1755901131295; Fri, 22
 Aug 2025 15:18:51 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:56 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-2-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 1/8] tcp: Save lock_sock() for memcg in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If memcg is enabled, accept() acquires lock_sock() twice for each new
TCP/MPTCP socket in inet_csk_accept() and __inet_accept().

Let's move memcg operations from inet_csk_accept() to __inet_accept().

This makes easier to add a BPF hook that covers sk_prot.memory_allocated
users (TCP, MPTCP, SCTP) in a single place.

Two notes:

1)
SCTP somehow allocates a new socket by sk_alloc() in sk->sk_prot->accept()
and clones fields manually, instead of using sk_clone_lock().

For SCTP, mem_cgroup_sk_alloc() has been called before __inet_accept(),
so I added the protocol tests in __inet_accept(), but this can be removed
once SCTP uses sk_clone_lock().

2)
The single if block is separated into two because we will add a new bpf
hook between the blocks, where a bpf prog can add a flag in sk->sk_memcg.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/af_inet.c              | 22 ++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..ae83ecda3983 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -753,6 +753,28 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
+	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
+		mem_cgroup_sk_alloc(newsk);
+		kmem_cache_charge(newsk, gfp);
+	}
+
+	if (mem_cgroup_sk_enabled(newsk)) {
+		int amt;
+
+		/* The socket has not been accepted yet, no need
+		 * to look at newsk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(newsk->sk_forward_alloc +
+				   atomic_read(&newsk->sk_rmem_alloc));
+		if (amt)
+			mem_cgroup_sk_charge(newsk, amt, gfp);
+	}
+
 	sock_rps_record_flow(newsk);
 	WARN_ON(!((1 << newsk->sk_state) &
 		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0ef1eacd539d..ed10b959a906 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -708,31 +708,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 	release_sock(sk);
 
-	if (mem_cgroup_sockets_enabled) {
-		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-		int amt = 0;
-
-		/* atomically get the memory usage, set and charge the
-		 * newsk->sk_memcg.
-		 */
-		lock_sock(newsk);
-
-		mem_cgroup_sk_alloc(newsk);
-		if (mem_cgroup_from_sk(newsk)) {
-			/* The socket has not been accepted yet, no need
-			 * to look at newsk->sk_wmem_queued.
-			 */
-			amt = sk_mem_pages(newsk->sk_forward_alloc +
-					   atomic_read(&newsk->sk_rmem_alloc));
-		}
-
-		if (amt)
-			mem_cgroup_sk_charge(newsk, amt, gfp);
-		kmem_cache_charge(newsk, gfp);
-
-		release_sock(newsk);
-	}
-
 	if (req)
 		reqsk_put(req);
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


