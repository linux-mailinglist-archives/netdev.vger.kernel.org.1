Return-Path: <netdev+bounces-219676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C9B42965
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5998068215B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADA36809C;
	Wed,  3 Sep 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COc8r5SU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427942D9494
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926166; cv=none; b=q/aqXgnNEBPmcvpfWHDxQRdB/TJiQSLvYDBpJTuL0SrsjspLVHktEaz0w6nZHUKNlmCF5d5po8faEGl9SsGDjsQPoBHhoBvXdqhpyfbGWU9yP4PB2e83Ir1AdrM4avLefGkaaF3oQiDhAI8wSx5+4ZEROQ+k460I61/K0eEeX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926166; c=relaxed/simple;
	bh=msexKRoOWWu708vhFOv15aCp2yq6WClH6MFmNCnrAB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rgm6B+ps/aNX5jcZQ4ireRnAOOvsrUX9Z3WD5cJZCwdkCIgkqPsCbubIACCcxJiK6BJe53xPn22qvDsHwVoFin2AmohhD7PoOhvASZ3JQkiOvgn1reMMHLlc2CFEciJa+KrQBLPpsf2DaRQn+Cf7QX/GD6lhtDp168t8eD6FfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COc8r5SU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329e3db861eso131938a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756926164; x=1757530964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHPGfsvlVgGO5d2N3Xpt2aHuFaG1f8adEH+NiEv9Hao=;
        b=COc8r5SUWOr2hICVqVf4wvk51ttgpVt9tvWng5QhpePcO3j0rDfAhVROMWh6/3eatT
         wgqx4q4+4//Spbeo/2nyhjjw8Ui6dmmC3upc0QZ9cA7dRf/c5CnJYwy7orETF7KBUjqd
         l2fkiQr6qlA0tLZ/+QqbPfPYix4OhzyRn3sgVd4WFg9solJNggaPSpYU8FwdilUs+y4V
         AQwDicrPjCfP1iNVHsPJy6r8fGtl928HzT2LQYBRe5sVYhfOTjAb8I6mdZgp5u5simP/
         cQfS8Pn191h1QLcdFEjDkycgwYbKly1cB6vA3NFOI6SWXioQeOn/mZOuRqBJx4dvAmZk
         LLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926164; x=1757530964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHPGfsvlVgGO5d2N3Xpt2aHuFaG1f8adEH+NiEv9Hao=;
        b=tBkw6Guj73iHQit7BMhA3EYpzZPx8gEWfmDIU9HpAanp/UiFUz+UwP7bgSy9rHK75G
         Sl1++Ui8fHwx4Tcf/IV/hsywgWxneOPbS2nYbCPjdtsSXYiQYpABYxvYlTy2ow35jdyZ
         QNTd06+6KO/LRR6VKlaSYjR0JmfA2zcYvKlDo5SZ4iP6crsgcozqAy8xnzoxiRDVdZNQ
         EYsEmrVPWKgcBajOYfdqK+UNHGNkZqrn+F9XONH6QoCyFihC46EfmdQqUrxh6hYdPhb9
         hvA8lXftf22paDyWxSV2tNxP7+UPDOm7JHy1qbeeiFAMS+uvKF9PkeNq2a4KEcqeQ6n8
         eJyw==
X-Forwarded-Encrypted: i=1; AJvYcCVOFzTSU9QRDEV5rFCGoPDTHoH+GpDo78N6Jff5I19ba1QKVzmuf/F/FeLPvSqF3hC9QzEO/cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiynMPOmuR0iTvWEOVC5DLUxjy1JJgK8lSSTG5biDU9OFOUwP
	LMLa5N8Ug0OpJ+JNZkDjbiPs9pxxbb0sR4oMqfU6bev/nLz7jocTP8gXdzBAgZSE+KnblQwpeuc
	zzwN3Ug==
X-Google-Smtp-Source: AGHT+IFISbwiCDDNVkXjyASXAuvIp7wDi1cJn/o15BknQV0z4/pa2CGp5M1tmE3lZpHJhlz1Dip9HCEkve4=
X-Received: from pjbsg10.prod.google.com ([2002:a17:90b:520a:b0:329:e390:e996])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d503:b0:24c:ba8a:6f23
 with SMTP id d9443c01a7336-24cba8a7245mr7401065ad.35.1756926164419; Wed, 03
 Sep 2025 12:02:44 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:02:01 +0000
In-Reply-To: <20250903190238.2511885-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903190238.2511885-3-kuniyu@google.com>
Subject: [PATCH v5 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will store a flag in sk->sk_memcg by bpf_setsockopt() at the
BPF_CGROUP_INET_SOCK_CREATE hook.

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Also, bpf_getsockopt() will be necessary for a cgroup with multiple
bpf progs running.

Let's add new bpf_setsockopt() and bpf_getsockopt() variants for
BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock() and has the same
semantics with bpf_lsm_unlocked_sockopt_hooks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5: Rename new variants to bpf_sock_create_{get,set}sockopt().
v4:
  * Use __bpf_setsockopt() instead of _bpf_setsockopt()
  * Add getsockopt() for a cgroup with multiple bpf progs running
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..31b259f02ee9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,6 +5723,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
+	.func		= bpf_sock_create_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
+	.func		= bpf_sock_create_getsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
@@ -8051,6 +8085,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.338.gd7d06c2dae-goog


