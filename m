Return-Path: <netdev+bounces-229414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E581BDBD67
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913C419275E8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97B2EC0B2;
	Tue, 14 Oct 2025 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soFqo+Ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3152BE7A6
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486171; cv=none; b=n6WdL8uWFjOSBup6OfkizulWMdVYCfTFsx8Y/xU49QaimilHIY/GEs7SVEqdXaNg8D7MHXEFirnjnouLxOq6h92rwc/mIMAKWN2HSWF7UuDUEe++gkYpW4OH3tvKO4se4R+QrT3y6F2Phr7Tc3o8FrWzczoO9mPGP+LrH51qeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486171; c=relaxed/simple;
	bh=MRGpKykJxOpTlzndR3QGSRcL1wBXhTwFuH2YVz+eOBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPmPAH6uabhi3H64nZlBCY6H+rXUUWwuAzjIGQPrN54P5kRQsQhTbAOOpA6UYi/HnthoG0unM0vAb6pGEr+nlEfUOtc6Q+Sx1GHabd3P/7uBv6xhfROQ7x9jzrQM+MGOOv8YgMZr0hgeNuXziIkzTJglH6p7UibFSNqpZYDkj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soFqo+Ci; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso6584710b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486169; x=1761090969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob2YpgXK89qud9yI7+fPx6sALJDXvpuhZCZOK6qu6oo=;
        b=soFqo+CiS5CCw0j6odBqe+pmQeAtc+sZ+JcsoiNg0GbQ9ngUe4FhkxS6aTzsgNKXEX
         TrNBag+ReOlwcio71ZqirByby2Psx53br6+1FbUhzh12S+OHcFVsmg1azlb9XWy4Vifn
         +48oqaO7tiqdG7uydFsDLa0F9Zh2AtjoSOdSX5JuljMn4Nd5Zvj4blWQRcxNB10axxc0
         ZUP17/FsHzwJ6d3N0saID4WmQ0FuwGRXS+ILHrrRt9hTEg0Z8NpBSh4v8WPavoSLJRxq
         XCuz0Uc0j9QiBXSAPI7bj+hagjlvTA4ev5FOgr6yNgQUdSTpXIgj6pGqfVGmANEbxEcy
         w0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486169; x=1761090969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob2YpgXK89qud9yI7+fPx6sALJDXvpuhZCZOK6qu6oo=;
        b=cZqb4PwBOPMh9c0kSDXeJymKTLdPo7Cj9cjsBbx1BCc7BBtfy9cyObM1tEiq/vLLfd
         Zrnlg/kZ/AWyCqAIua0l0SlJXakdectNcrM9XuU+wOe3kJdEsvwm8/wwgpxBn1wQcXFl
         9v1gk8iSyAasjrlZjIalkxSVpTKEvI4mhNMrce5n00ybHp4OC+WRtSkAK3UQv1oRUsC+
         P3Wm3fms6AAF83wfdsSTVN7CnvEWMp+m6qx5G1ouFon4iC8cYagr5cwZJu/PZwP3Y7BZ
         RuTNYiRPuZcJ+MdPpfCqDfic1Z2Z0mN0o7hCfsYQ2AJTPFg2ugHF/cXFS2cxGLHgJSK7
         7VzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb7+Ra81S/32/jN7KTzWEcI+Y1Imqh7PRqQSe6RM91cFpdB1UFi9xwyL9PVN4Lzh8jKSCn2Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+2viItuyU0qWgQec472tvZoiYN3x8Nyz1ylpR5UdjNS4oklL
	FPXk1TzO2GSKHCX0iuqpCh/Hi6OZKxl5lu6msBPwpgUDkJpNDkT1Yz0jzu/iPxFHDX+RTFpZFUQ
	A8aYkNw==
X-Google-Smtp-Source: AGHT+IFhFt4sdvKgBJbACG84ZSkCiCL+FOvevB4G641zJgNbUcJh1yaPlhDNOS8U9sgQYl0Fjqj1lWzP/HY=
X-Received: from pfbfc13.prod.google.com ([2002:a05:6a00:2e0d:b0:77f:61e8:fabd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b8b:b0:79a:fd01:dfa9
 with SMTP id d2e1a72fcca58-79afd01f231mr13158691b3a.6.1760486168845; Tue, 14
 Oct 2025 16:56:08 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:54 +0000
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-2-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/af_inet.c              | 22 ++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3109c5ec38f39..e8771faa5bbfd 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -755,6 +755,28 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) || sk_is_tcp(newsk))) {
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
index cdd1e12aac8c0..3b83b66b2284c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -712,31 +712,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
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
2.51.0.788.g6d19910ace-goog


