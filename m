Return-Path: <netdev+bounces-221408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18AB50764
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087945E7AE1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E135CEDA;
	Tue,  9 Sep 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blJ2OhOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E81F3D58
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450800; cv=none; b=Hj05tk2SYIRAbSAWani7aptc1hFByili9renQsGe+t6WKICTFwPx661lrUOgSqy3wQNFxCF0i+FVDcXMsgVO/Sh7P9CeWdNOxuIl99p1oNaSOGTRHkmBtWgZsSs6Oee5bUMluV4VDFIUQkqTpIRjG1IpBZStqBHQwMcm9OWtrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450800; c=relaxed/simple;
	bh=v3w2SS7Kkrv52T8FXm7oOh2uz/3H5kSOug5YVI7wCT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgMnnV8bbSDTSZOtQJKroSqpmbrY8O78zMBz54/AfyBobU2uKlB+g3812vM/SjO4sdCn3tJJhPyg1kGzqALMXkmpnps8w/FLm1QUyEErPzqHL5eC3uP2xoSMkEijz1aT7LmMFlCNERBBHa1fS55OCL6BnugEuMlY6b6fiiLlP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blJ2OhOK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7722ef6c864so5657479b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450798; x=1758055598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=blJ2OhOKZAyvvKoozaTBpz0xv0v2BiFuSSkKZZYRVLP56X9hYc0ZaK+yR/JupHAo2c
         ffz2+SWA8j3sfWiEWiW7cKkiYzkS2rvjV7758TnbIZ4Faj3K9GqgpKDyP4jM/Ht45j/a
         L8DHQItX1BhUHqfzMahQywNd/BPDMvShaIBw9I4e8iZQnjLuStBuOnNBrTdKbuPSFpMa
         x5n1MkUGaXVpb+EyJmb13acb6CJ5UM+frVb46awJbMFdcQI8YO4SUgmR530tY51z9o9X
         RYjS9nVHHDC8UwSS4V0fP1RMBUm9A6/cHM44keWCsARwR78Am/CWYer0UjxciNc4WxC+
         vFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450798; x=1758055598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=rkcRAxStzX+2XQhcMOb3xMneH7qcOMlHGq0Qnj4UNuQBG1LtHddQA7RBVBJn8d1NSA
         M4E2qgysbuyoT2vgvrLpQ9ruUvKBkvvNIfp6d0vaS5JVvGm6I1szqC8Eev/m/dfOMqJw
         gMxI5gwVpDJH+MGnm+PD3YYpK6OiFATmlrc+GQNIu6wzAsL6DSbErFVTM5d+BKBGUo39
         wcWXhMXoyOqAOafMLpMJzzKuceUpV7bB9fRU2ZSE14v7dMgyV9gtWcpYQeOfgFc1HoZC
         iNkIxMEsxaQ8papWxGTDU8rn05yNe1+IcXgifAHYuG4I/jazzGw97+IZD3k6+gm0f25g
         Dz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBzKlsUVo6GLLR1l7+Bi4AXGCeaU2IFcKbc6yMUUOl8dCWEyqWOJdMGczKhJMJpTMv8ZDALR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGP6QuUXaw00GQI7EilqKbmkQCjRPgjrhyzdualC3ER/H6cge
	jlUbzqmkD+1UK1cjG8++LvTkFo629TXNZqZ1CjyzIdUp+LpZmDgd45mrUNk/fXr2TeKRyux7nB6
	ocWDqPA==
X-Google-Smtp-Source: AGHT+IF/YIcLf2+3AzZZZdpFcU8J1LDxv3YGeOA4xweV2ZaPU+2Gx0EG3ASHt15Ha5z8ID2ydEeU9jp9PGQ=
X-Received: from pgcv18.prod.google.com ([2002:a05:6a02:5312:b0:b4a:fba1:5765])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a4:b0:24b:954e:387a
 with SMTP id adf61e73a8af0-2533f7c90d2mr17446390637.16.1757450797854; Tue, 09
 Sep 2025 13:46:37 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:31 +0000
In-Reply-To: <20250909204632.3994767-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909204632.3994767-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-2-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
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


