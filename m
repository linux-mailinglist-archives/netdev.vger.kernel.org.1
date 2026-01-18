Return-Path: <netdev+bounces-250818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D2D39350
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 09:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57262300EBB6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA57275861;
	Sun, 18 Jan 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU7W6Ufg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5D23F431
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768724250; cv=none; b=Z1kKodwn4+fGtz7SiEhq+eoRmB98Qdi6mbY+uATBHE5kavU0KIDBR4S6uEUkJ+dRgpa//YVxvYyYh1K5ufbY5NxMOA7x2QSlhME7TxvchLtm8H/J9C9Z/b7GseuYOEDfSlXuR13j4c9uiQk/+B83ZGnUlZWpiuYpOy8JlgdW/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768724250; c=relaxed/simple;
	bh=xXffxQvzK07hZEuFa1ysfLfvbEICjMUXdPizVEPinUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfjX4wcXIw4bET1jsDbkV9nfhzi8M084lNf4BOB9IuXsXwweD7aLcl3A+ErmPII54yrWzumBTT9hpjSg4J0M0wU+0POTCtS/+aUMeA+BNlQTPbIsKY4MQ8VyVFHFwnwsNL7KucMBGDRpxeQJhP00f317xBLgj5A8I0WKgnDdrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU7W6Ufg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so2121415b3a.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 00:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768724248; x=1769329048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqap0FeAOULyYnI/LBiMZE3yIuHyBVsfjaQkrDWyRwY=;
        b=CU7W6UfgHxgGUDattkOnwD4rm9du3cFzq44/zp2pb6B5BAwADEhYhGfySdt/YY0e8m
         9a6pkDSo22qRflJcfcg9B8N2My1jTXbt/lUCC4OAmrMYclxR2zLhJAioC89OoOSm5Wyz
         qCX9PDShwt/cjAJgu6DKnZqZ8F2sXy2Be2qaVxf5EbaDUp4lm40QL6c0qMGX9lz7/N9I
         5u7o/MWCTR1yD/a7ybYIYoTLa92VTMraTh7AYE010+oB3BVquTCUh5msFQ+MHvJgvvgN
         XbGPZn7Pu+ne+qlt+DDOyYYGl5ae61wuZYFBJoRshZbOe+z2XLujIer4CRMJhqpUVBmH
         9h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768724248; x=1769329048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqap0FeAOULyYnI/LBiMZE3yIuHyBVsfjaQkrDWyRwY=;
        b=nbf/CLFl/1v5R09SB51NDKhtF4SeNNj55cDnq1J9B51KGUdZowPajr8NoI2kb/y3GP
         HSqrU9ktTAC9ZeCfEPvEOHppAxxFWgP2wtUUktFFoxa8kz0MU5Yh2ceqqAHHLfaKvVoI
         t74gqX2rNndRvbVIYvZHqH2VOJcD6VbiR8pTdXKcnlV2zWy5sBwEyWCY9RZR6ccONWna
         uUhJZiceyStS3K0zWQRicHNqS62dt0nsHrVqsvbYA0Of17azcztKgBtVzP1te2OAfUNw
         6iqBBe/tgMXB6N1HpwjxOohm0pU2lB9hKjvPLehatTmV6Xjgj9Q/LLZqVQjx5RNug2fc
         yU1w==
X-Forwarded-Encrypted: i=1; AJvYcCUw2DbaUJuVimHuw1Iifo52kxMZeRcVpo0WQdQpxEbaPqEkKvCpiUiHuEwB8y9zix796FwMZf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g6jLW2Sh8FlqLF7DSMFQm4JZmlmPC/Mx23uaOktn+Mz/vZdk
	6KIOlQ787vW5HqOs9MdFwrP14MHwjvTrnd3wDmUQqcr6hTT1KOSBpoxu
X-Gm-Gg: AY/fxX7fXNIPLnV45NVcA5RciK+aMIPMYXI9KnCIdyHcTHojQwf3eCCkqahTi518Ua0
	+Vl8sAc2xxiEpEzHcTunhx6V7nMG5b24CKCudLzNWlPrzmzGj+XCE+kcMruX0mHQA9ILigwgmfu
	VLv7/mBVpNg5Z8XBeVQs+sRvayouvpNU3SGfi1YncJMShHxB4fTTrNwCMRilyABBdGP9W7Hc5ry
	pcAW0eu/Ctp4H1EkaJfeg5mpLLWzGQE6MuarHkA2yIJVXNHo5Ksd9D8/0bwF3yuonB74meHRXhC
	Y4m2XDhA6Sc/Ha13+p4aC+PG5lZLgAObHK9HIptSSJ6NM2rvydt2beGgPJaKqpf8E54yQfW+l3D
	2+Ui3VXhNobuYtsAzQnUmSYMTL7b/Qje4Ks4FrvOtJnt5tIwHomDoS+8QdfCfwhYV3xuUXpxr7n
	4I8ePTKpUDsaxlN9ry+BI=
X-Received: by 2002:a05:6a20:6a24:b0:366:14b0:4afd with SMTP id adf61e73a8af0-38deeb9fb64mr12423998637.36.1768724248066;
        Sun, 18 Jan 2026 00:17:28 -0800 (PST)
Received: from [127.0.0.1] ([38.207.158.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d1f1sm5917393a12.22.2026.01.18.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 00:17:27 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Sun, 18 Jan 2026 16:16:39 +0800
Subject: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in helper
 prototypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
In-Reply-To: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6857; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=xXffxQvzK07hZEuFa1ysfLfvbEICjMUXdPizVEPinUA=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2bOdE7JM/0zd8fYWIZaTbFpclQ+/K66QXGX5pawPKnHu
 14Vq73tKGVhEONikBVTZOn9YXh3Zaa58TabBQdh5rAygQxh4OIUgIm8t2P4w/FxdXRBrlLH1mMK
 v1d7FzG/OnJLtvCcMvOpSd8/TRC4+4yRYVZoxk794PIVPUZqKdmuqRKTeVObVtW87mJoyu39Os+
 AAwA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking"),
the verifier started relying on the access type flags in helper
function prototypes to perform memory access optimizations.

Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
corresponding MEM_RDONLY or MEM_WRITE flags. This omission causes the
verifier to incorrectly assume that the buffer contents are unchanged
across the helper call. Consequently, the verifier may optimize away
subsequent reads based on this wrong assumption, leading to correctness
issues.

For bpf_get_stack_proto_raw_tp, the original MEM_RDONLY was incorrect
since the helper writes to the buffer. Change it to ARG_PTR_TO_UNINIT_MEM
which correctly indicates write access to potentially uninitialized memory.

Similar issues were recently addressed for specific helpers in commit
ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffer")
and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name args").

Fix these prototypes by adding the correct memory access flags.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/trace/bpf_trace.c |  6 +++---
 net/core/filter.c        | 20 ++++++++++----------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..f66284f8ec2c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1077,7 +1077,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.func		= bpf_snprintf,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
 	.arg4_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4ff82144f885..ee116a3b7baf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6407,7 +6407,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.func		= bpf_kallsyms_lookup_name,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe28d86f7c35..59c2394981c7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1022,7 +1022,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.func		= bpf_snprintf_btf,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
@@ -1526,7 +1526,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.gpl_only       = true,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
 	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 };
@@ -1661,7 +1661,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 616e0520a0bb..18174e0d3fcf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6399,7 +6399,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -6454,7 +6454,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -8008,9 +8008,9 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv4_proto = {
 	.gpl_only	= true, /* __cookie_v4_init_sequence() is GPL */
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg1_size	= sizeof(struct iphdr),
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -8040,9 +8040,9 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv6_proto = {
 	.gpl_only	= true, /* __cookie_v6_init_sequence() is GPL */
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg1_size	= sizeof(struct ipv6hdr),
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -8060,9 +8060,9 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv4_proto = {
 	.gpl_only	= true, /* __cookie_v4_check is GPL */
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg1_size	= sizeof(struct iphdr),
-	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg2_size	= sizeof(struct tcphdr),
 };
 
@@ -8084,9 +8084,9 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv6_proto = {
 	.gpl_only	= true, /* __cookie_v6_check is GPL */
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg1_size	= sizeof(struct ipv6hdr),
-	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg2_size	= sizeof(struct tcphdr),
 };
 #endif /* CONFIG_SYN_COOKIES */

-- 
2.43.0


