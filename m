Return-Path: <netdev+bounces-224173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A6B818F8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9144A6EB2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2A321284;
	Wed, 17 Sep 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIqYW1O9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119B321265
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136470; cv=none; b=aiwuZNjnFiZ9S5xUfAlhk3XGjdcKew2SkR8TSPXKOWW2lIqGyLqGcf8Qr3YvC1AwUYis7JD6spIl5qyUZlC5eYLTFWrm0hRdRzkkaPWWfnbBecA/dTFe1L3InsW8OVWLWwHLjT1B6iRT3M1w5YJZrV6xEdYbw3SCnV2bu/ka35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136470; c=relaxed/simple;
	bh=rGkoFu9nkoi5/nIXhQG8fsZVP8xpKsdD3ZK3Uhe0wtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nWvR5jhPF2NKxGGIrmpFCcFt3XqiWgSymKN3EGWTTVZVcqs8/VSw9LE3sEdxqbv1jGSwNKemHD/RRHYhQ07LV6rb7U1wlmSoCW4jzrvQbf9kN1sb4NjMd/cqCkH8d+0g9mqvMdPEvIdF8MIXh4Qx6Qa6zRhiu2rEL/q0MMITiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIqYW1O9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-25177b75e38so1843955ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136468; x=1758741268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=OIqYW1O9XiS6NGxE3Qe6aULzZvxbQgeOo8GCgGpTtACwC50HJ5pHHt8scSklpmZn4v
         BuDL0DLkoEyfcYxXM4WISu9ibk8UgPln6eMF78FsN+hjlGxYVmfqe6AcY1rP9Z+NQQ4s
         rKf0muHB6D2+WzCagf6x4lIAf/fIsgYY/Y52KdHfyWs/mmM6ccUbJdk37OxcqvzWaBBe
         3851ZrFadVSoifEDk5EHqBns3Be+3SZC0j6G8LJWC4Hkj75hLe4F9tcDoZyP4sgx49d6
         FIvzbjU8stvzOMfdBtisfmkKate9SurENRY/GWVgYbzZij2JxOfGVeT73RSwZvVgy1OB
         Iu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136468; x=1758741268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=KvThfbfKGd3IH4zEzEzSLBTzmM4hrRjn1xMyZepWD5f8ydDOOqlathqF4+Xu9bWOCu
         MsoSgejjXY2+C0x+xULxrMgorPeVVZHY9SRFpCUdcdMGhmt8kGlw2fTDQ8hZHX6xjoa4
         WIgdXjN4k3bt6ac+xiWLIAYF28BLtlOuupkjrFHlCz2pStlk9QtuwC9bJ2zmC+tmAN+Z
         Zp8zuX/KYM+SQYYVvp9VU1Dup5wwVhERFVc3BzsjhUdwCa/URq5LLojS6vA/sHOmjDKa
         Ul4Y0ZiAgZ2EIMUyN8NO3n1yL6nr3d4LMQBkgqxm4Q6xpRhFAr5/foAE6ZXtQU8kulxj
         5ipw==
X-Forwarded-Encrypted: i=1; AJvYcCVFs5uJhfCNRPr2NQLDpIdevMncg6jMYnnCselX6f1Bt1V6/JVDEOPxFfnbq2ICxus0hdXllBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5x5+pJlfkPsQCTE14/MHDYG1xEQoG20MNbmk0LcjpSL0V8EAE
	rJybGBTzJ9a45cokTs0j9Dl+JsP2ttaZdegtlz3AWj8eT6+cboood+1UtUCNjopqYEFsKJJw4ou
	O7wKesg==
X-Google-Smtp-Source: AGHT+IEIXdlD/Lhy/9NeVY7kSo0I0sWa5FA00WVfbE+XAyTxlfKnmSF2NHwH7+epxiwxApVOZeumWdsKF2o=
X-Received: from pjbtd3.prod.google.com ([2002:a17:90b:5443:b0:32b:50cb:b92f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c67:b0:25c:5bda:53a8
 with SMTP id d9443c01a7336-268137f751dmr35617025ad.37.1758136467942; Wed, 17
 Sep 2025 12:14:27 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:14:00 +0000
In-Reply-To: <20250917191417.1056739-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917191417.1056739-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191417.1056739-5-kuniyu@google.com>
Subject: [PATCH v9 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will support flagging SK_MEMCG_EXCLUSIVE via bpf_setsockopt() at
the BPF_CGROUP_INET_SOCK_CREATE hook.

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
2.51.0.384.g4c02a37b29-goog


