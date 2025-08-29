Return-Path: <netdev+bounces-218060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B629B3B024
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB4A5683F5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46D1D7E26;
	Fri, 29 Aug 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaO7uEEv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66A1DE2CC
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429235; cv=none; b=DVrr1dDZj7lpmHlLE+KyPuwxvc5VXfZaFhfEJAdHPmZTVvJW2RVvM1lvvVXvbF4UjwU35aSKiYsC6ZPdtQFIwbCNxXnjhbFL+j8kOx5Uat2VxXM+eeYNcgoUg8zuXROF64C9ERXL8nJvYeOTsPyfK7FFo6OspmxZWtcZ7+2xqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429235; c=relaxed/simple;
	bh=Is8kbxRW8jhZhX+6XLLs47qB3YfRF2r1dknjq2Pezc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R0r95laLl8NJbOAo6/iz/NnjluAfUdTHhgAWa5uCY4pi0w+7IVIlAoEovWRwuj+NrJy58AR3UMSInf3NPFy4ClpGssJmfCJUsk3mpGqxo1Y+/AYdgAJytH/XZ69oqEYrrUAyfIMpvxEWOYe3JErIPBkAcJvlGKM0v49fxSIxEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaO7uEEv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1415066b3a.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429234; x=1757034034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAF3FQNLKAl9oDz0E05A/xKhwXgqQ4gwB23R4aRTiHk=;
        b=uaO7uEEvy1Iahds43oa/CHxAuyizreI+KqqCbI5NDAD+Sk+hJJMmn6U1hRjMfLK4oB
         x4u+iGrytnmur1UVJtreCpL1xSK+svKhGmm4CKe7SZSB8gWsfpFB4xR9+HDYGZxZdK0j
         zKNN4M8E/oST1W4/x1xa/NcfoVr61MR4EiVTSPo3fV0O+muEYyFQeGp0bnKGEpZZhmun
         RgNjANEOfFXeDmQDFUUnSY7pM//7Yt9cut4ymP7QExJE0VyWUObTUavo4ZIcy252gllB
         QUlLwjME8YB+rerD9meIEL+meaiXgOGj6Xjt/lHBvcjAmOrRAM5zSjICNUOw2sQJYD8L
         K41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429234; x=1757034034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAF3FQNLKAl9oDz0E05A/xKhwXgqQ4gwB23R4aRTiHk=;
        b=KVeo210PZozD9M/lohuNg14mvFzhOC7+m5WcLBq6WHr3K0gfpYNuBDr7FQRNRqOdp7
         Lxy22v2Yf1AI49sJkcXR54EEtdVCGCwJ8fnXhfE4txJAnDp07lTJzETardu5lc1IbnhR
         rQ4iJVaUqSy3K339btD2MNncLFchQExsDKSxZs5JOm5coDBwJX+xoVySH8yuQgVnght8
         LjHHUQEgvxgV1nzT6boRkZ+x/DntyrsWPhqBLQ+hfH9i/hAtwU7sQviuSFOAGoJdHTUI
         mkTsaMJfXtgtSwboGlq/JC6VnU12BdSYYNUZG3t4yb+AUd2QRDEyi2EwKBBUrcc5Vcq+
         PL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxsPnDGkE682BtM8ciLgMY4O7BhvZ6UOtZHbs3WDvzuKKr0ZzlVIzq8OgpuTV0CT2iIx0zyqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymV7qlI4FRu0c4UXxwl1U7Py00lCxqDUNctHNbrWVDMfMGhBJf
	oXOsBo4JLL9Gu9jTDlRyoV6vGwNwqqxWasrqWc6nOMdS/ybdQZy/ySdduhzTBsgZQ+U9ArLtaIm
	8ArjTHw==
X-Google-Smtp-Source: AGHT+IHFp4wOwQl8ZGrkq9TjXMLxJ7v7p+L5PsbNdfCeg7YTZKt9akhASRe8npJw+ekfKStndxntsZEeUWE=
X-Received: from pfoo18.prod.google.com ([2002:a05:6a00:1a12:b0:771:e7c9:bf42])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1953:b0:771:e4b0:4641
 with SMTP id d2e1a72fcca58-771e4b04bbdmr21349037b3a.1.1756429233575; Thu, 28
 Aug 2025 18:00:33 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:00:05 +0000
In-Reply-To: <20250829010026.347440-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829010026.347440-3-kuniyu@google.com>
Subject: [PATCH v4 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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
v4:
  * Use __bpf_setsockopt() instead of _bpf_setsockopt()
  * Add getsockopt() for a cgroup with multiple bpf progs running
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..b6d514039cf8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,6 +5723,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
+	.func		= bpf_unlocked_sock_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_unlocked_sock_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_unlocked_sock_getsockopt_proto = {
+	.func		= bpf_unlocked_sock_getsockopt,
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
+			return &bpf_unlocked_sock_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_unlocked_sock_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.318.gd7df087d1a-goog


