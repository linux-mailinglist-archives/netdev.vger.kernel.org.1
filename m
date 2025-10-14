Return-Path: <netdev+bounces-229417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D69BDBD78
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033311925F10
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6442F8BC0;
	Tue, 14 Oct 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Os7JnQOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC212F5A2B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486176; cv=none; b=mGHETkORTm0+98Uamg7mpBfs8ZALSLgOIOUBBcS5rSHHYu13kNwTSairUvP/1nx15+9T8j+KtS5IKl3vsymaf58RouOQ5YPv3FDgRVdnhg6p0rQ7nUKCV7FahH5YsHvaEQW2oEtQAR3m74CuH87NU4zq4GVKCjMZy1lRG1mIFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486176; c=relaxed/simple;
	bh=Wx3oonPnxTQAfbSYtCzb3IA6bDpF1UtjNCV0U7bhOy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIUHdY6B65WqW/QnmT7VT5TwN4pxJrBdtTjo/5xG62rHNtLUGTWxHMbpNhR5+rSL8mKWqxt1Pns3HpJXaT07V0iSw4MhLB+VaAWdjg2P5D5C1+AXR6p3AWwqfNFgnX56kV1aNCb+ourIDGqt8t80JJkj2bE8ZLeXaFYpWmRuhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Os7JnQOl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a144677fd9so947956b3a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486174; x=1761090974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/RCVCGaPK6LjlPKGEvZncrbwe4KtV9jki2AWAAnogk=;
        b=Os7JnQOlc+Jx/0w/XwkF8pU53CKVqBz7lmSRKDeLQi/0acY8gffeT0QlmIUavUuawd
         LuyKsKMSb8MLf2aeTlMyeUgO/SBkeJ32upMG2NWsVOnevZHDRIC0KL2GXo1v6BY6caf9
         CJdPo9oEdhC37Axx7cf05GxrqzbbDfcwFoBmKHJjN/4I3n7/lcayk175nFxaWCGKZqby
         hfgGmHulatSxbjBItEPhePF2qSNIlUVdZVT0SjTVnlB9ANaBpOxHP6s0PU0U8yM+tRcy
         YRnQBQ2p/FvIC3dTacr3+vTMw6oX/IXmbfpabl/iLymUELIl8SjNrYXuj1qxnmYPOgRo
         PMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486174; x=1761090974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/RCVCGaPK6LjlPKGEvZncrbwe4KtV9jki2AWAAnogk=;
        b=HCtGHiuYo0Ih0yb+N6JTZm9qdq03mOLVW7MvZ0ZjJH0osYjXWR6tduw9zcmXfejlfE
         QkIXcPtghTkCGDyvOvkoi70PrvNZ/RXH+Ipc3Z9yDS1UK4k9yMptVr+RkUlGzSnm5e//
         ysbwNrHBh8WXqp25AWvcb8CY+ZYn0a8RXxVL2vIjCeyRfNrQsd9VZHbc71iLLU+jSw/x
         23WNA3p7MRP3Ghxc7G4VS/roxSwYmV3UVZgEFrafmw33D1N6CVVEA1cztbUAAnuA1pdM
         mAzFijli8qahDoC4Q4Vf6bfVlC/HjF3/EUERkRYnAZ+mQ+LEjURo2vPiNExybSjpM0RK
         uL5A==
X-Forwarded-Encrypted: i=1; AJvYcCU8L6MHyBTEoLjtCHhpYntf7JsghIp2N/Jm4xZu56lj+MNt5Yj7E43zRLFmCDZLm828aVngxDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CYNkhD0qJnCu2z6E5ezZ59QJZaqUctjy2yn6JsgT7uql63PU
	nKoEVhoghrrqBlY1CSebB+CHm0DmdIN24pQ09cIJw0qy/Vv+/hBf03ezBIBEqV5z36X24WUyF3B
	X3eUHMg==
X-Google-Smtp-Source: AGHT+IFAB4XV4F12HPB1uOsT3Hefu/mSk4BZ2sJZZSN7huJgUsy/c6ZkatLRWl2WmtL7dTGtG7rc88+y/TY=
X-Received: from pgnb6.prod.google.com ([2002:a63:7146:0:b0:b54:f4ad:a4aa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999c:b0:2ef:1d19:3d3
 with SMTP id adf61e73a8af0-32da8139359mr38371184637.14.1760486173580; Tue, 14
 Oct 2025 16:56:13 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:57 +0000
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will support flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
at the BPF_CGROUP_INET_SOCK_CREATE hook.

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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 76628df1fc82f..ed3f0e5360595 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5733,6 +5733,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
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
@@ -8062,6 +8096,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
2.51.0.788.g6d19910ace-goog


