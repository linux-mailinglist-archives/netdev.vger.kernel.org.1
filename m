Return-Path: <netdev+bounces-251394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA3D3C2AD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E621A622568
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81993B8D79;
	Tue, 20 Jan 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOhjthrc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B393B8D6E
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897781; cv=none; b=ajc+RCv24ac/WUP9aPNVv+U0xgd2sOtsSy6WrgGPR1EkzMt9wDC+PFsNoph+9jsoJzDl0YOyKafn/K000BqToDiTHKcRIabz5HTWPTcMbTScGSBHrwQ/jLDmjvabL7Ov8bjhD5CZMANk2L4FQHksGEft1WAyaDjm58Tu88W9rhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897781; c=relaxed/simple;
	bh=a0/PmELHpKGOcb17E4AHkLA0tl21IHIWYuDFhbZZW0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHpK6uaAR7X6VY0AFgqhSlr2YJZwsUKGpIko6FPkOQGCPT8S596HtpGDYp7jwMH0NVuOAyP4eTOFF5mbJrniPQHprO4xP8lyTo/VcQNOcYk1gma/2IOGufzBroLVnfuUCyBPxaAkF/IAMZPTqgg9OCJ9fmyFMFRGZsDmQPhfeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOhjthrc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81df6a302b1so4154809b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768897779; x=1769502579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6Z3VLtzWeZjH130gNeQUV/Gwae59tlyw9m0zg3jO20=;
        b=dOhjthrc0htW/XrvpwkqKZ8H37eIEnPDXL71IzAqi1ZE3BgT9l5NctucYLWlzKSB7d
         v+PSuHbXaxy0ncx/6DcNAbeM/Kb1zLYDvbc+ypgTsbcr+ODsed/uADr3CwkAar6aEC4G
         Zb7IatSYBgcYIbvZ/Qtn9oV2Ym92KWb3wBN/RX7j2uf9gWV/9iArROoSBPOwmdBHw7Wp
         /QOpyTpkKonvMd3maqt+58fHHL9C2K7ROEG4vMmw32nrxgzI0NyaLzRSbs+mZJLlgDIk
         7Li3PvEOEffGBlch+oJQrWPGMiGn8MWHqFlvCEH8z4Vx1kH74Ye26y2f52EtnsdVYSpf
         8FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897779; x=1769502579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6Z3VLtzWeZjH130gNeQUV/Gwae59tlyw9m0zg3jO20=;
        b=wHMCYC7Upuq+VYesRYUmn1/yL9c3/3+AcPntJPYmiRIWxtU3RT9iOrVBt3W7aCpIvT
         i0yMAr+zp/6GVFvr/cLOJzaP58cCGrxbvEOd7mKDHPCLR1A1DwZmCAFrAx/t8EDHOGDH
         v+dYmckbDgOdjNjWz19SbwHIOxgN4BRsoxfMDijWyM8BoWLJLzYo3HrAmtdK8s3c1syR
         Iw6UIXefd0vopvZOplNPUSWZmA+8RTNyZHkl2bIC4l4PYO8LgE8kiUqlSPE8s9FSgVa0
         uhoGmTgalG9pI92qZZl7jS9gp3dSsr6A5Mh4EUSDMKwK9AXzjKJE2BfFtC+x7UVY5OOc
         oeow==
X-Forwarded-Encrypted: i=1; AJvYcCV0N4K9O9KEPCNeQ4jZFCk2jYn8U+BZ1UOF51aQfefv5H7+yvR5iDaIJqyCwQzrk7uxY6/M1Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdwpJJ7neT4NCTS3T/rPKBy47xT53Ixrt0/g2IYtX4eTb+293
	8irAvKd3FlQkuIfVGnCNhCPNGm1hmLUlVoGa0w8fV0dF6YmTDnNTdTv2
X-Gm-Gg: AY/fxX5aajI/PyJ8wJMl0vLr0eq+P6bLs639IGfu+dMXfAxw+0vX3VwbEQawoG3oVPh
	Pm0gnyP3Ry3YadTzoHVmKXnIUrSGEP/JQv5klt45BHhwtKN9V2cxNtqeDpsmxgRDpHTxkLV+DtY
	QZB8pQSqWnuBGBa6u2Z+JiMDPtdjZxeatCZAFE4p+KrFuAewUFnjY0dJIdA7XtG1SUhb02uf3Hd
	HMw4tH+MajqDJ7jKWMp2FM77Igv+khKuftIklMwTFatYeRQiMRn3bU0yiUDt/ckqwflu20YGC+0
	18NwC5ySYN+8Ynom8+kZAbhwkn9tmIE5b3YYk9IRrHiW3pDQdil9eJbKusveWtfj1lfGqQvo6DN
	yp4PkIJgV1ZWbizF5kvr5BYvPWBclCLdIbs1K3Ml3LSBM6M1sxeFb5uqLEgajsZuj9LfCP0eoEl
	TDg6r/01VA
X-Received: by 2002:a05:6a00:148b:b0:81a:a5fc:b1d8 with SMTP id d2e1a72fcca58-81fa17810d3mr11064914b3a.9.1768897779134;
        Tue, 20 Jan 2026 00:29:39 -0800 (PST)
Received: from [127.0.0.1] ([38.207.158.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b51d9sm11282275b3a.65.2026.01.20.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:29:38 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Tue, 20 Jan 2026 16:28:46 +0800
Subject: [PATCH bpf-next v3 1/2] bpf: Fix memory access flags in helper
 prototypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-helper_proto-v3-1-27b0180b4e77@gmail.com>
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
In-Reply-To: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
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
 h=from:subject:message-id; bh=a0/PmELHpKGOcb17E4AHkLA0tl21IHIWYuDFhbZZW0I=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2a+zROb3emVLFtW3XY2FVqvNyc4zFv3VeBNo9vN/zonM
 Z41jc7pKGVhEONikBVTZOn9YXh3Zaa58TabBQdh5rAygQxh4OIUgIm0XWT4Z5C36Jng0rVxPG+m
 7L+dEmSw+bq3/9w08S/+Tx1d1hbZlDMydO5kEMh0vrJ82efb/42Xat1mS02KsL0clfTb7m56/lY
 7PgA=
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
index 9eaa4185e0a7..fa1232873c00 100644
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
index ecc0929ce462..3c5c03d43f5f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6451,7 +6451,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.func		= bpf_kallsyms_lookup_name,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f73e08c223b5..bd15ff62490b 100644
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
index d43df98e1ded..d14401193b01 100644
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


