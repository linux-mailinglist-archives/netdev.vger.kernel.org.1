Return-Path: <netdev+bounces-213658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5CB261C4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7F9E76B1
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDF2F90FD;
	Thu, 14 Aug 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ga2z3FKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53F2F8BC5
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165595; cv=none; b=NgdKlC6PM9FN+HgGlF8GPS7rjZdQUMAXNrXIjBpyQ1bdWD8DJzCEcMX5P0G4jIYrPklMuMiSB0bIjgyf+CfpDHsIrC63gfw31ojElYNnpcxK5yu9i/oejKrXQLSBixho4UfYLe29SCRGYPIjPKsOpqVpCxp5bWYLtmPtVMBti7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165595; c=relaxed/simple;
	bh=PPrRxylf++fMKZv9Iy/oJV5oi/UlhHvNs2qCW/ynntk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H37sjwXqjUWlWtcpRHQkWbbBJMXhTsn8iMCK7I2EIdtjR3oVktoJsGtVAKDe8HKmfC87uFVslh7VuPyClk6CoRb4oIuDMHk4TpOZkjQvFRg6OhdyQuLLWCsSwpa3/osUHE1pHh0CesK6qbrHOvB0y8djPGB3LwRjvDdCySnJlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ga2z3FKc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78c66dcso116723566b.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165592; x=1755770392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yHstTE3tSbVfUP/vtg6i6reJKRnZ5jYKLUV9Bq7ySc=;
        b=Ga2z3FKccL60HW9cE1ER7cTtAUb2q5H7hhvPNeOReTLfWe/jRVJcRATWJcI4FZuF3u
         cnsRDjLrVRj/sWfMhCUqtKkH4vnPqSENbcMQTB/jvslD6teniwi9EeIHB/2u6Sqe7QlL
         H+mR04lxIt4mAqqimWSMIwATPXy7thGmstw23gLn988rCvyaxEelJ7nn7yWwZ0fXI3fy
         H82eOhtoMjLW/wGP3VnEERg3XjI2jqlJxH4XLfSgqYe3OZ7X2rSezFXhzmwOO0jf6ipA
         rE4EbaCOpwK/qilJhEg9mrax1OH6II94U/vPMRDdt//g7CLJhXeaGuecwBHKHCDMUX3m
         htfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165592; x=1755770392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yHstTE3tSbVfUP/vtg6i6reJKRnZ5jYKLUV9Bq7ySc=;
        b=hlGzlqMnoxs65YDluOhShjX5A1nGsu3KHwnPolRyyR+jkix3KCuzZD8zQ67SJvJ2ww
         tOjGWbqYosxiytDXN0ovlokXAs81wZ5MtwHGOgzBZvFaQZ83qDBKEsd23NTVIvP2OTx9
         mw/rKQHY336JhXDLBINQHfe/mVixbGSTbzICnfTD+XZp/n45N9XwaW0l9+kJ2AMW5HkV
         JBs2W7iNwanAfRtp4MlV3El2X7cYQQ94IBacFaWSUhnTM7nxiDToVo4sxh2NMp/Jv3E8
         /y6u8N12Nl/P46sY6ir4xlPGF4frbF6Z8CO4jWeD1zDED5i85Z/XgLyE1PIt+S9WC+4y
         9Qug==
X-Forwarded-Encrypted: i=1; AJvYcCWHLHmTzqQ8UIAWfxnwdJcW89yVeI9nm0wsriuvUa753bW9eVct+Yr8dsOASPjccLuPuqC+qGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PtzJpPS8EgWKZvWIxtaCgYsMpsLtruCo5CC1fskKRhrMEqsF
	Zhf3fXeclpGKvp7hZsAjzSWHy5EfgbEyR9NfbuCxnnQx27n0wFsDxAqNDmgdY4fPMMQ=
X-Gm-Gg: ASbGncuohxNeOxBOIn/wdP7VlrLSD0n50ucq1zRHPfp+wTX62l9F3me5S48N7PaBGsX
	RInE1BgMu0fmTRxprtfUy249znARcetJexY0W1Xtb/l0l+9adp+sEI/yirDX7X5+QsK9AZ0y6VT
	5oMRLejzQh6ax6t3I2dBFxihw/Yd5X1854TzDDpYgvUTjdHhc7olb5pYF8ALbEMl7M4Rh2c0JKu
	MXXAxBc06fR9oXXz+5azyF1IyFmCI0TvOiYCbQG3VAHVyAqjglO0/dwnP7Fs2KMvb2V5x0zpiFf
	fHHLaKI1IRGNxmLA5PF+0Qq/HRATiRcGw34h/PurjPgQ7KHE1HMxsNqvKvXVsXjVbYDPwKK8rIX
	Figkgap+L5TUQOCmb6QB7
X-Google-Smtp-Source: AGHT+IE8xbeVVRGHiFmxG82p+ZPKIQUtovg55wOvop3j0icOAZrta0tajg6ArEVh4Hsz2JNrTbuDuw==
X-Received: by 2002:a17:907:2da1:b0:ae3:5d36:aa6b with SMTP id a640c23a62f3a-afcb98f88f4mr225795966b.36.1755165591543;
        Thu, 14 Aug 2025 02:59:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2563610466b.39.2025.08.14.02.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:29 +0200
Subject: [PATCH bpf-next v7 3/9] selftests/bpf: Cover verifier checks for
 skb_meta dynptr type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-3-8a39e636e0fb@cloudflare.com>
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

dynptr for skb metadata behaves the same way as the dynptr for skb data
with one exception - writes to skb_meta dynptr don't invalidate existing
skb and skb_meta slices.

Duplicate those the skb dynptr tests which we can, since
bpf_dynptr_from_skb_meta kfunc can be called only from TC BPF, to cover the
skb_meta dynptr verifier checks.

Also add a couple of new tests (skb_data_valid_*) to ensure we don't
invalidate the slices in the mentioned case, which are specific to skb_meta
dynptr.

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 +++++
 3 files changed, 315 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 9b2d9ceda210..b9f86cb91e81 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -32,6 +32,8 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
 	{"test_adjust_err", SETUP_SYSCALL_SLEEP},
 	{"test_zero_size_dynptr", SETUP_SYSCALL_SLEEP},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..dda6a8dada82 100644
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
@@ -1192,6 +1232,188 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-only skb data slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_slice_invalid_after_metadata_write(struct __sk_buff *skb)
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
+	/* this should fail */
+	val = *d;
+
+	return SK_PASS;
+}
+
+/* Read-write skb data slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_slice_invalid_after_metadata_write(struct __sk_buff *skb)
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
+	/* this should fail */
+	*d = 42;
+
+	return SK_PASS;
+}
+
+/* Read-only skb metadata slice is invalidated on write to skb data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_meta_slice_invalid_after_payload_write(struct __sk_buff *skb)
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
+/* Read-write skb metadata slice is invalidated on write to skb data slice */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_meta_slice_invalid_after_payload_write(struct __sk_buff *skb)
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
+/* Read-only skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_meta_slice_invalid_after_payload_helper(struct __sk_buff *skb)
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
+/* Read-write skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_meta_slice_invalid_after_payload_helper(struct __sk_buff *skb)
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
+/* Read-only skb metadata slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_meta_slice_invalid_after_metadata_write(struct __sk_buff *skb)
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
+	/* this should fail */
+	val = *md;
+
+	return SK_PASS;
+}
+
+/* Read-write skb metadata slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_meta_slice_invalid_after_metadata_write(struct __sk_buff *skb)
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
+	/* this should fail */
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
@@ -1665,6 +1900,29 @@ int clone_skb_packet_data(struct __sk_buff *skb)
 	return 0;
 }
 
+/* A skb clone's metadata slice becomes invalid anytime packet data changes */
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
index 8315273cb900..127dea342e5a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -211,6 +211,61 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?tc")
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
+	/* This should return NULL. Must use bpf_dynptr_slice API */
+	err = 2;
+	md = bpf_dynptr_data(&meta, 0, sizeof(*md));
+	if (md)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
+/* Check that skb metadata dynptr ops don't accept any flags. */
+SEC("?tc")
+int test_dynptr_skb_meta_flags(struct __sk_buff *skb)
+{
+	const __u64 INVALID_FLAGS = ~0ULL;
+	struct bpf_dynptr meta;
+	__u8 buf;
+	int ret;
+
+	err = 1;
+	ret = bpf_dynptr_from_skb_meta(skb, INVALID_FLAGS, &meta);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 2;
+	ret = bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (ret)
+		return 1;
+
+	err = 3;
+	ret = bpf_dynptr_read(&buf, 0, &meta, 0, INVALID_FLAGS);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 4;
+	ret = bpf_dynptr_write(&meta, 0, &buf, 0, INVALID_FLAGS);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
 SEC("tp/syscalls/sys_enter_nanosleep")
 int test_adjust(void *ctx)
 {

-- 
2.43.0


