Return-Path: <netdev+bounces-228043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE99BBFD5F
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 02:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B72718979C6
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 00:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA770808;
	Tue,  7 Oct 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+STMnCR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905D23741
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795887; cv=none; b=H0XXSoQYc51Kv8nB86xMOvCxaXAbICPIyE4fTI1g7VcFdDqDXvhinzLOoVDDLCx2ZX0NyuECqz8kd+bjMpzaKyKk/i2djL2QQJoZDaQVAlDNcjtxMwaj/gfvX+D93efPZTHMpFF4wGstQO2E86XpWp235YmnmfFY8g6jkcOXmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795887; c=relaxed/simple;
	bh=O4ZEGD7/59+D/8VuS9k0QGg2Ty5Tov/fvRw1sr/ZEtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLLhhhe2ldd12nmKulYy6Z0DORU75AP2D5ePpOdrePm2fJsBiaU/Vga5tfzxNmnHjPZs747Z7wOf932hNG6bfsk4JKgaXLiHlQs1W9foEiDqZMNSj5fpVMd/oM8bx3/JeJ1HX9637mzsDdfwIxXue6UUiK17S0WvdqBcJQc5UtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+STMnCR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7810af03a63so9332488b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795886; x=1760400686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EX5x6uLUTzmafV6+LZwQZYP6YPI6JFOv8NjtpW+0cHU=;
        b=p+STMnCRLhzlYTrLLxkVVBeZeGt+h7p033uKwe6oQKZtKnvdWAR/0V9uUF2IxGx5Sl
         ggEq8jyLyeZfppE7jBXsnWMWn2h0irqR1SejtzbuhX351VUwHZBEcVejK0WiWPLABG+A
         WSs1iVNB8wBCeXNReGZhuM3/Rb2x5ugOeRzvuS92jG8vESgeanDxBLHOfTYgOmK75cbw
         zQ3rnkaSEV4cnnI8MmV0SIjF7zNGr0k0L/AhArn+WFv0nCTpoeLytmv3Xyz9QuKemb9w
         ggai3TK4icNYg3utfFKAbOsi0yaBwyrBJVvsGQ65939XYlnau9wB8g5uQu8ORMqKd19n
         H1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795886; x=1760400686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX5x6uLUTzmafV6+LZwQZYP6YPI6JFOv8NjtpW+0cHU=;
        b=d4o7RFrrtZoX6Jm4S18F94BuTPRcqlefW8CdS6IFV+nj3ovZA6dTNJ77YkDHAfPbpe
         RGm5n6IrBoernSPFuTGhuv5cdVvj93EI1g1rDTXWlokSuiLeDFRu1OFGO5LTVU3Sr7iC
         LgFI65eNz9hqfWxu1RpbzECNV6mrc1pvll9f2HZk04OxaCy5tjSEl7eZob4GmZeZKyuN
         2wdt/ETjsUEbC3FGXLpCcTw8gxsxH6Q2CNala3pb0TaCBMOGNBDxRlJAO8FX072YO2fY
         KR6fYvVutAa4blu7J3SzbQzIeC2Ka9XWWz6A/aJ6bDxoI27scTbXlaf7quyxufOJUM+h
         O/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU1H9iGrzwLvXBiu7zNePWH7/FHE4yY3MRAXOd9/I+/CUznaxPC1uycGPqMul6oaeUbUjLClQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4QWFuZTvft69n4hDzkYiaOvAmnqNgXpopqAeyaBSvTrdWGof
	8JE5pn6gpI+xKkl/FaB3wjrmipK2MweIX8DbtdMnCodI8RKsunSdMlMNisQSIAK0jBbof+nzLaX
	mqbGxkw==
X-Google-Smtp-Source: AGHT+IGruikuvKrWzcw2ZvVWVz+a2gtajF015OaFAfb9CVMhnIH8i8stXgDKS5qzY1Fh3CUX92V/p5Ie6D0=
X-Received: from pfbhd5.prod.google.com ([2002:a05:6a00:6585:b0:77f:3341:eef2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3991:b0:781:2290:e7e7
 with SMTP id d2e1a72fcca58-78c98cad84bmr19717737b3a.18.1759795885681; Mon, 06
 Oct 2025 17:11:25 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:26 +0000
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-2-kuniyu@google.com>
Subject: [PATCH bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
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
 net/ipv4/af_inet.c              | 22 ++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3109c5ec38f3..e8771faa5bbf 100644
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
index cdd1e12aac8c..3b83b66b2284 100644
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
2.51.0.710.ga91ca5db03-goog


