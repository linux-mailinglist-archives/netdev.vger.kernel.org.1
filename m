Return-Path: <netdev+bounces-219675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E61B42963
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414953BE0E6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB6198A11;
	Wed,  3 Sep 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opNKHDMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42E2C2AA2
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926165; cv=none; b=a62DCO+3VmpuN69ZCzdiYHGQNZP+YsLfsJfNm2Yl0zI8CrYs5z92CZl1MH1vvrVfC/5/VU4NPSD7ohWTiv89NxeqWN3aBTJi0ARQdIN4OKnU/CWOg9wKwbNho/ngzlQ1qge1haxyTzbMM5f3CmOiqC1QkXaArWqYNmU+Em2CyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926165; c=relaxed/simple;
	bh=7D7bMi8SSZYNWcJKyOwJUyeDl/e9zbUO3SKA2T9Bpnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9pYZlSl12JAXuS29WvhIaEnEI4enVFb1jwWmkedWVLu7J2m25O3TJSoNYLXjBOC/p+6FBMmqSTI0F9/KVUskZOiGwcwGTV6qGuaHz6HP3rAphjmENAPaYoziSLHTTWkLJbbQ45cJ62p4WIvqmkaIAO9V+n6nw7MxjOn6owHG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opNKHDMG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so174608a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756926163; x=1757530963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+NfU6GKTz93dEkYl4pL3zEIP00thpC/peM3VLRO6Xus=;
        b=opNKHDMGfosc0OWOetjTcStOGcSppgxky2DmFONrUUi78W7pShC9HCkSGgiWMJ1Qlo
         rSUtrueYlyxfAyZjHdAohxGKaj8F/MVaw8YPcE2Q3cf0IVKFZZ4BaxCfDHXtJ/CsMD5c
         KjgjmusHthceLLuUgx2k1YyT3fLHvKZL9orhxerwssRmh72hl/P73C29dM6n116Ke7s9
         DU/3jSgFl+VSSljyjTd+JbIpPzGHccUErjVejfvJppPz5QCkSxZz89qKX5uEy/v0+gg0
         hGzauFaicFZG+1CSRk6RJ0MnJ5FmXYhWduItDcZvzBRRPDm6+AayDwULV3SCOdj6VBuN
         aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926163; x=1757530963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NfU6GKTz93dEkYl4pL3zEIP00thpC/peM3VLRO6Xus=;
        b=eKfIRjR7xkt5dvP1rts7EWmZOG1X89N9iguqZ3Bnw69ayabrhvnEUA702f0DbROeCY
         bIWAdULzOu0h6ACkoLA0z75saPyM2RhpHyn5pfbxvsHHdi1eDtCVvq05UeNKYYx0/LCq
         yBbKLabW5gF3dfHb2Gi8wPZnq17bQdKLsXgQqkD28LMFa07/JGYg+dIj4zfOnt6F+xYJ
         DW6a6KhQWGWwb0NBbBH7c2WvIlFSkYDldj8zZEiiR67HCG6sn9Gp9ljV1opjps4YM5z0
         fjySl9N+qc3N7iwf5gXauOnFL972WeHOLDUKAyHLN3Hx6aW9yodTlpvs3+WGsAnINF8B
         wo7g==
X-Forwarded-Encrypted: i=1; AJvYcCUac7kuTabuvD4YGwTkREbb7bX0luiYcZohcXTJPlDvzMUxYfsRzB8mb5GGrWJfhT0DsPX1bkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5InPlEF4L0ybGurIrZSrd7WLWvssxgurqxK7XuJrlaRH/QXKq
	SEeYyKQSIiAVo4L7vZEbQTepgIKiseqrcvdczVgJgGfVp0lzvjdsg/Nhy4qaI4lm2mzMHDimki1
	Voyqpnw==
X-Google-Smtp-Source: AGHT+IGfYahHkjh0geWywJoGTcwXYKTJi4HfLIpSfqfr+0Kw2gtf6nzSUDWzSQJ2vf4ta8HqTcx5uqBo5Pc=
X-Received: from pjex8.prod.google.com ([2002:a17:90a:1648:b0:329:6ac4:ea2e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c5:b0:327:e34e:eb16
 with SMTP id 98e67ed59e1d1-32815412a34mr19304111a91.1.1756926162896; Wed, 03
 Sep 2025 12:02:42 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:02:00 +0000
In-Reply-To: <20250903190238.2511885-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903190238.2511885-2-kuniyu@google.com>
Subject: [PATCH v5 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in inet_csk_accept().
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
2.51.0.338.gd7d06c2dae-goog


