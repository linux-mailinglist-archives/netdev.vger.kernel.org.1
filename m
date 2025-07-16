Return-Path: <netdev+bounces-207526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DDB07B08
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E204A1882109
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC2B2F548A;
	Wed, 16 Jul 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sz+/bQMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3A2F5469
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682686; cv=none; b=phY+UwWq7qmn/eAGACp0OWRTrdVms+cvKyTh93HnBXQE6n2fMySMPo8TX37TQy1nCfPd+bgIckwEDRm5z4dHI3FH5XcAZr30xC5ugMKZ/p/ToRaoRX2kxI8sq9SOSnt10h8hv6XgvcNKJu1kR+eqIPSkCXzp9C5DWOSBaSFSVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682686; c=relaxed/simple;
	bh=vCj6LtLP69nZXkkH3qSQ24S3cpzVFL5D0/dQQeIW/wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVf7XkkmOUL1X/WWYPRb9EDiydT2BeLVIVyGh6+JtzPyfTMbPrfwEIhFLj4jVoMZ1tk5UON7o3whunHQ9GncDLLmKvQA1T549ZF22opOHKjkfySU3sYy9HqnJ0LdhNY2YTWp5zWg9COp0wqF0YKyVHb26+yoF4NmgkAHDGI9w/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sz+/bQMG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso568751fa.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682683; x=1753287483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15r+H6jBUondDUFeU5VOvn7uFAFwCn7xyh1my5VCvEA=;
        b=Sz+/bQMGfCtkk9VdTnr680m160yy6ERj8kQXycHaKck/vSQjN041VVTAP83xRwvytO
         /BM6ZkFpDjLsvXnELM28RuZK2y1p74KvSxIZoNq/N8CImftpOp6ThwAhG7CUz6MFILGi
         ijZ3lvLWQC1FC8HqPHSwlWVRUcEWLfM+qmtKpw9tbWt/4OyFZXHx0AavVwIsbyX84KyX
         WSAnagfNSriYEfcBTOkQWwaYXdDINV0nU2U7Nr8SWtyZBk4J9KkX7r6d2LMTvK5SLoax
         SYzuHZmMQSVVUBSmqahfd0Xm3RYbCYzqursCGrTuc6pLc0amr0b7Rcl9hA8OHgIEGOGG
         6lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682683; x=1753287483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15r+H6jBUondDUFeU5VOvn7uFAFwCn7xyh1my5VCvEA=;
        b=XbrZ+U0/JNYIJ9FG5zrDrUEXVQCVbNEiFul1LUliDGza+7mh67fDzHvjyeKUpCHunV
         77wlYpD+p9TuJH76jjLM9LmzQ3mZbHa0WVcw7F9wHo64KuO2pAwYTl/wvkU6m3aTswzi
         6LwuNbmpK8smm9rpDqxXe6wmIUz1qbCZ0hBvHyUI8OVVWMfwD7QHB7ASu/3AYQdgPSSf
         E4OHqJRPsbBCpOInYZzjoQZBpObulK52H/2Kg+dVCFAY5Rp4igKMzEj6usf6QSnXtpVi
         X5kQBOr3NA92j0u53diz2gNXoHzwjEf7j2z/CJPCln/Mqsti0VO8gIVyO95dDJ19tvtm
         N+ug==
X-Forwarded-Encrypted: i=1; AJvYcCXtZCkxzClsMIiSoobaUjXzTVHsm5R5hFyajw04XCfaiRKnKsrcDNWDqvomzMNuRUJSHInHjxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVeS4SoH8rYPHv4Mlk9a1+bYbWaNGk0nPzkdwbmJB5KRJcN9K
	haHiM7WjuWIzuPucjqhUQj5aEOeUjTiwTbHYvzJc0Wdqq7gbMGy1ALrECggF8+XUNkI=
X-Gm-Gg: ASbGncutWtvBTPoAiufoEfx/FJM05/+Tv4pGOgMicN6SIWlcSRxYQymThA8SIt7KFKU
	CSAEPzg0d/CKrMBz63JV6suqwxy6w2XgaXfpm4ytO8b7D4WbpPi1on8at5hwxCJh3o98Ini+qar
	9eNBEEjysaNCZ6piwu6N4l9H5x3UydGH0gyxwhtMwGGChAJGpmkliL3QcKXlQyC9iZKcKfHtQmz
	ab+6dr3UReVgVOY6oUfiBuS0X/8QPPx+u243cYlYizD8n5VpC/qSkAD+Knwj9hexfLBdPExNFEM
	CAaKpyBAaMdPsp22ecpeM6JMVLn2WH58lewSrkjYIm1KgoM3BXeWOMelgSadE8ak0pPsN+dqYTS
	HrWXKDS1//he5s4HAITHmyB+OnB4/aAX3icU9ll/S2e/92OeU9b9Z3jyAAtSjvOKi/3uf
X-Google-Smtp-Source: AGHT+IG0Os4EShH1w+JIRBIsE6vlmyHudnmpAq0Lh1Cf7+7VCr0O6vizCtE9Y/WKaDilTldQGfAMmg==
X-Received: by 2002:a05:651c:324a:b0:32f:219d:760d with SMTP id 38308e7fff4ca-3308e5447b9mr11155521fa.20.1752682682686;
        Wed, 16 Jul 2025 09:18:02 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa292f39fsm20144081fa.28.2025.07.16.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:50 +0200
Subject: [PATCH bpf-next v2 06/13] selftests/bpf: Cover verifier checks for
 skb_meta dynptr type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-6-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

dynptr for skb metadata behaves the same way as the dynptr for skb data
with one exception - writes to skb_meta dynptr don't invalidate existing
skb and skb_meta slices.

Repeat the tests which are specific to skb dynptr for the skb_meta dynptr
and add a couple of new tests (skb_data_valid_*) to ensure we don't
invalidate the slices in the mentioned case.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   3 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 297 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  62 +++++
 3 files changed, 362 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index f2b65398afce..375962f62f5d 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -31,7 +31,9 @@ static struct {
 	{"test_dynptr_memset_xdp_chunks", SETUP_XDP_PROG},
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
+	{"test_skb_meta_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
 	{"test_adjust_err", SETUP_SYSCALL_SLEEP},
 	{"test_zero_size_dynptr", SETUP_SYSCALL_SLEEP},
@@ -41,6 +43,7 @@ static struct {
 	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
 	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
+	{"test_dynptr_skb_meta_tp_btf", SETUP_SKB_PROG_TP},
 	{"test_probe_read_user_dynptr", SETUP_XDP_PROG},
 	{"test_probe_read_kernel_dynptr", SETUP_XDP_PROG},
 	{"test_probe_read_user_str_dynptr", SETUP_XDP_PROG},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..03c15315360b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -269,6 +269,26 @@ int data_slice_out_of_bounds_skb(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* A metadata slice can't be accessed out of bounds */
+SEC("?tc")
+__failure __msg("value is outside of the allowed memory range")
+int data_slice_out_of_bounds_skb_meta(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	/* this should fail */
+	*(md + 1) = 42;
+
+	return SK_PASS;
+}
+
 SEC("?raw_tp")
 __failure __msg("value is outside of the allowed memory range")
 int data_slice_out_of_bounds_map_value(void *ctx)
@@ -1089,6 +1109,26 @@ int skb_invalid_slice_write(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* bpf_dynptr_slice()s are read-only and cannot be written to */
+SEC("?tc")
+__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
+int skb_meta_invalid_slice_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
 /* The read-only data slice is invalidated whenever a helper changes packet data */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1115,6 +1155,29 @@ int skb_invalid_data_slice1(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-only skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice1(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	val = *md;
+
+	return SK_PASS;
+}
+
 /* The read-write data slice is invalidated whenever a helper changes packet data */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1141,6 +1204,29 @@ int skb_invalid_data_slice2(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-write skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice2(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
 /* The read-only data slice is invalidated whenever bpf_dynptr_write() is called */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1167,6 +1253,74 @@ int skb_invalid_data_slice3(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-only skb metadata slice is invalidated on write to skb data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice3(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&data, 0, "x", 1, 0);
+
+	/* this should fail */
+	val = *md;
+
+	return SK_PASS;
+}
+
+/* Read-only skb data slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_valid_data_slice3(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *d;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	d = bpf_dynptr_slice(&data, 0, NULL, sizeof(*d));
+	if (!d)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should succeed */
+	val = *d;
+
+	return SK_PASS;
+}
+
+/* Read-only skb metadata slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_meta_valid_data_slice3(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should succeed */
+	val = *md;
+
+	return SK_PASS;
+}
+
 /* The read-write data slice is invalidated whenever bpf_dynptr_write() is called */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1192,6 +1346,74 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-write skb metadata slice is invalidated on write to skb data slice */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice4(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&data, 0, "x", 1, 0);
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
+/* Read-write skb data slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_valid_data_slice4(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *d;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	d = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*d));
+	if (!d)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should succeed */
+	*d = 42;
+
+	return SK_PASS;
+}
+
+/* Read-write skb metadata slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_meta_valid_data_slice4(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should succeed */
+	*md = 42;
+
+	return SK_PASS;
+}
+
 /* The read-only data slice is invalidated whenever a helper changes packet data */
 SEC("?xdp")
 __failure __msg("invalid mem access 'scalar'")
@@ -1255,6 +1477,19 @@ int skb_invalid_ctx(void *ctx)
 	return 0;
 }
 
+/* Only supported prog type can create skb_meta-type dynptrs */
+SEC("?raw_tp")
+__failure __msg("calling kernel function bpf_dynptr_from_skb_meta is not allowed")
+int skb_meta_invalid_ctx(void *ctx)
+{
+	struct bpf_dynptr meta;
+
+	/* this should fail */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+
+	return 0;
+}
+
 SEC("fentry/skb_tx_error")
 __failure __msg("must be referenced or trusted")
 int BPF_PROG(skb_invalid_ctx_fentry, void *skb)
@@ -1267,6 +1502,18 @@ int BPF_PROG(skb_invalid_ctx_fentry, void *skb)
 	return 0;
 }
 
+SEC("fentry/skb_tx_error")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(skb_meta_invalid_ctx_fentry, void *skb)
+{
+	struct bpf_dynptr meta;
+
+	/* this should fail */
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	return 0;
+}
+
 SEC("fexit/skb_tx_error")
 __failure __msg("must be referenced or trusted")
 int BPF_PROG(skb_invalid_ctx_fexit, void *skb)
@@ -1279,6 +1526,18 @@ int BPF_PROG(skb_invalid_ctx_fexit, void *skb)
 	return 0;
 }
 
+SEC("fexit/skb_tx_error")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(skb_meta_invalid_ctx_fexit, void *skb)
+{
+	struct bpf_dynptr meta;
+
+	/* this should fail */
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	return 0;
+}
+
 /* Reject writes to dynptr slot for uninit arg */
 SEC("?raw_tp")
 __failure __msg("potential write to dynptr at off=-16")
@@ -1405,6 +1664,22 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("cgroup_skb/ingress")
+__failure __msg("the prog does not allow writes to packet data")
+int invalid_slice_rdwr_rdonly_skb_meta(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *p;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	/* this should fail */
+	p = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*p));
+	__sink(p);
+
+	return 0;
+}
+
 /* bpf_dynptr_adjust can only be called on initialized dynptrs */
 SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #0")
@@ -1665,6 +1940,28 @@ int clone_skb_packet_data(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int clone_skb_packet_meta(struct __sk_buff *skb)
+{
+	struct bpf_dynptr clone, meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	bpf_dynptr_clone(&meta, &clone);
+	md = bpf_dynptr_slice_rdwr(&clone, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	*md = 42;
+
+	return 0;
+}
+
 /* A xdp clone's data slices should be invalid anytime packet data changes */
 SEC("?xdp")
 __failure __msg("invalid mem access 'scalar'")
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 7d7081d05d47..680c58484cba 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -188,6 +188,26 @@ int test_skb_readonly(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?cgroup_skb/egress")
+int test_skb_meta_readonly(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	int ret;
+
+	err = 1;
+	ret = bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (ret)
+		return 1;
+
+	err = 2;
+	ret = bpf_dynptr_write(&meta, 0, "x", 1, 0);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
 SEC("?cgroup_skb/egress")
 int test_dynptr_skb_data(struct __sk_buff *skb)
 {
@@ -209,6 +229,27 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_meta_data(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+	int ret;
+
+	err = 1;
+	ret = bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (ret)
+		return 1;
+
+	err = 2;
+	md = bpf_dynptr_data(&meta, 0, sizeof(*md));
+	if (md)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
 SEC("tp/syscalls/sys_enter_nanosleep")
 int test_adjust(void *ctx)
 {
@@ -567,6 +608,27 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 	return 1;
 }
 
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(test_dynptr_skb_meta_tp_btf, void *skb, void *location)
+{
+	struct bpf_dynptr meta;
+	int ret;
+
+	err = 1;
+	ret = bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (ret)
+		return 1;
+
+	/* Expect write failure. tp_btf skb is readonly. */
+	err = 2;
+	ret = bpf_dynptr_write(&meta, 0, "x", 1, 0);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
 static inline int bpf_memcmp(const char *a, const char *b, u32 size)
 {
 	int i;

-- 
2.43.0


