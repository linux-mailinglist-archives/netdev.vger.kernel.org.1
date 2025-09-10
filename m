Return-Path: <netdev+bounces-221844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEAFB520D2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 21:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13A224E230F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E12D6636;
	Wed, 10 Sep 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3Hz7mOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334592D5927
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532065; cv=none; b=lFn1qznj9s+46/iHHd5VRv3nP8NT/vAYjVgLtGcn3g8OQePBvk7rgop2bTIAK04yfkaIzh6ysr3TfSO3Gd3QIpiDsJ3gSBa+ibPcjaBoUUdMDnuBDstA/nnodG+KljdRwuwYwgOkEv6SwD6btRKkGqWfyoe64npEvo12zEnNqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532065; c=relaxed/simple;
	bh=v3w2SS7Kkrv52T8FXm7oOh2uz/3H5kSOug5YVI7wCT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8PkfCCe6k/9lSHYd4reH7hLcO3ojqGb5psEf64j7+6xR19teG9ihxN1LUa1Pkm/CL7DJ1JFRSdGoa5JgJhJStnKWWMaDIFrmzdcZF05E4pWUv6hlzfsFgTOM0QPoOSu98UiC351KkV1xNUH9TlxbbgzlKl3yRxatBXC9D1v/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3Hz7mOP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32dd4de0510so22123a91.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757532063; x=1758136863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=B3Hz7mOProSZagSt8jrhLR0hVBEWlC4tx/iKgeyhSJJL594NLKpLf5BhHsQn50wAFZ
         CkJ+8OOCTACkDk9mKQnKtgMobYPP8yDvWAvpuItS1eg2wqD7SpLmvx+F83ZfTBptWm20
         alMgxbstbXumayn74FGdGH0bGfaFt6N8CAq5QaNOg0fVivix0Uk2NFQHHQH7a8H4USym
         vrQUHzD0l9J7MmcazqV/tbS78VJSt9CdFXp7UUCGHAo8/peNIZ18uLr8Ayo7ZdM47ePq
         LOxvWPHyHwSMjnSNsR0Mh69Qu04Wd2kUiPaCqV18iF/8sskyceMogrlYBn5jwBC22T7o
         k6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532063; x=1758136863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=r69shAdaMwFzie5ra+tqcPtxUL78Rl8qvwB+r1u0NvXlJ5qfcQv+cDOGXhcHG0Itrq
         z6zq7vfwsUZZBLtGb3KxMQ9zzpMtxBqpF11AdWd7kbiNiy/YDoQuazqDG0whkLcf0ptp
         Z8TImhzlz0RajBb8pDiviEkJNbPWh2meoV84jfZjQvEbtc+ooZDyxPtIHkaDvYLEsu/D
         JY0To8tel3SMKKYN18BwQgGgsORhZk5FDaqFiKa7ZeR7otQLk9vpJDzXP+9xa3Y6PDLD
         MXI7a986yAcv3//cJA1Np+mrhcZ1696Hcbk2fqUEvuBLrTpdQoIl7ndxoLZKyadWznkq
         /ryw==
X-Forwarded-Encrypted: i=1; AJvYcCUbz+i6hG0HFmY75wcuKAUiE1XqhO1R6MrYVcmkuGU3lSJ3SVLi7RwHsF/nV1Ajf34rWKxl0ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTMkTOslqOwCNhrpbu63lyCi0bFjn8X6WzKRyYJBnn7qVaKfb
	aJUeI6KXnmwz/LdfHiRajkxVnRtP7Etpnn76OD6Im9LZX4J+VC8P7pMEihZN7IxWjxtdv5JRRR9
	I9DElVQ==
X-Google-Smtp-Source: AGHT+IEmdBpzxU3WojpaskD2/ZwSSvaHPOxSFAZiWaQBw/fTIUa/CJTIqVsRYUzTyyIrPadhEkbU6TGW9GE=
X-Received: from pjv13.prod.google.com ([2002:a17:90b:564d:b0:32b:5ea2:778])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4d:b0:32b:7d03:96c5
 with SMTP id 98e67ed59e1d1-32d43f81ae9mr17891879a91.28.1757532063508; Wed, 10
 Sep 2025 12:21:03 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:28 +0000
In-Reply-To: <20250910192057.1045711-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910192057.1045711-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910192057.1045711-2-kuniyu@google.com>
Subject: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
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

Note that SCTP somehow allocates a new socket by sk_alloc() in
sk->sk_prot->accept() and clones fields manually, instead of using
sk_clone_lock().

mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
so I added the protocol check in __inet_accept(), but this can be
removed once SCTP uses sk_clone_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
v3: Don't split if blocks
---
 net/ipv4/af_inet.c              | 23 +++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..d42757f74c6e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -753,6 +753,29 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
+	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
+		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+
+		mem_cgroup_sk_alloc(newsk);
+
+		if (mem_cgroup_from_sk(newsk)) {
+			int amt;
+
+			/* The socket has not been accepted yet, no need
+			 * to look at newsk->sk_wmem_queued.
+			 */
+			amt = sk_mem_pages(newsk->sk_forward_alloc +
+					   atomic_read(&newsk->sk_rmem_alloc));
+			if (amt)
+				mem_cgroup_sk_charge(newsk, amt, gfp);
+		}
+
+		kmem_cache_charge(newsk, gfp);
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
2.51.0.384.g4c02a37b29-goog


