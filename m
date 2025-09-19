Return-Path: <netdev+bounces-224923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32EB8B9CE
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F6F3BA242
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FF2D94B7;
	Fri, 19 Sep 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvpaWovC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE602D838E
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323400; cv=none; b=s9mNRoCK8eLxHBelEzixsppmD+osg1D7ahNSs4P5pyr9EQ7pzRYqwabJGkabCc05DQ75TulVNx0yqkT+1dgWPKk71uF7ZiruBxwNGtDQFAE37WB6VlZqP9qQygQoPA27YpiC4+bN5CbXxANNlzp3EDWe0+bzE3sqcuZmhN59Yxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323400; c=relaxed/simple;
	bh=mnhFefxXBFpAxTuPQC7oZZaXYOasqtRHyRYWS3i67S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLM98USVz+3TI5t5FoX762np0z3NmaJkL/9FrUTLe0oa3D6GHHifUVSWbzjP2EZu8VC8qtUg82anGZhmEDpyrwwi7KinBe8HDXDRbI/qIdyHLmyhA9qIJlxRFJHfDsVOS55cKWR/8kdTNf6Mlik4NL6h1z6oHywtwfRPyAFvfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvpaWovC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2570bf605b1so35594065ad.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323398; x=1758928198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=YvpaWovCdBIOMR7csXr6GHiMPtxOqpv/JnIm2JoCWX1bWG6n95+PU5s+XPOf87A6H0
         21ODQUAeKyZTyKfaE9i8ibxxbCzcZK2sPoYVt0CbxiuZt1WhP8IydIMqwrABUNco8cwZ
         cMSl/dumpMFpVPDKxy/U1eoxHS1mkpqf9KrMzr18TyDgBQYEzCDFv9/BXMLZ83/vJtXl
         ZpUlWXUFqWv697Wi79X4zOVVed+X4DVbZpkVjiK1251bLbnUqUs6lWjhg/Eefe8MI23E
         eWILn1dXGsWZJYTkX0pyKeB6P2gS0c2RBYS/baBwOWVTlCPqiZaotnMm7zzHhx+kYa9W
         /+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323398; x=1758928198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=dEDgGm5CaMwct5u3cjlKU7cwKaas1/OYST3NqravCAQNYXC4SF1uPKaJ4THHpoLTHx
         drDd/1psZYy9gmM2hcA194XiX01DQWA8NjpEFeY3fnBTG+M61wOiKpVP5KGWZ7G2uFDL
         yyv+jqn4qQOL/PsG848WX+kdQhEvoDgZMoIYjEW3HoXFtWS09IuPErRgT3b5ToTogfNk
         QpUOL5JiLyTeAT7GPdRjapxA/vQufCv3rm/tk+kUW3P1idA4cEcCKnj2UOSmNCDJCuxQ
         suIlCU4iT+Ae/r+gVguiVAHtb3JPBVZJXMj1A0kMZD0BgGtLvg4epTJS/m4WIdN3dUmm
         tR1Q==
X-Gm-Message-State: AOJu0YxhcsN0mtMlieVfplfSF9NXXAQdefDhV+P2sg+B0M3rauYeJlIW
	X0VF0Z/eUEZ0NfrtWmJYbfIPTZqd1OjsZAlzWxjYz5bDWBMsALrw8LM1vvpwxw==
X-Gm-Gg: ASbGncug6rloZGawuDjykk2PyDdBx3GItiORzWR7wB0aKF5/Wvmv0/tYk2NnyolVq0X
	EI+E6QxHIBEWg15vvsdCqkrm4Cp7sQAmBzODitmMII2sodjVfyZXHyxg9QbQ75MX0lHXdLH30bu
	dXgkgLqTzs0tA/CKgCsYVbVUIB0DjSDwk/I2fofPTeBL0Rss0wWVTsTP43+RYrbknE4EndsC0Wo
	ZKP21FTp3HICT6bWAjmrd45JRFufzXbgLyeQVvcy4rTFy6rXhG41O2tysSY1Ib8SsDcvqrqABEH
	ojw5phNZxOhN9md6yQ7tXzuvzF4n5Nuuoxf6vPwPtMFR+DjyJdEaq0+tNClw9dsvdzdW6oUuD5L
	7unC+D7B1o97TGA==
X-Google-Smtp-Source: AGHT+IFuLlM8aFTKXtZCHE01Rw33LzfydoorwmiFO/dtCvKUrTwP3n/9EIW3CbMiMrJ+3KRlp6BU8Q==
X-Received: by 2002:a17:903:3c30:b0:25c:6159:8ec0 with SMTP id d9443c01a7336-269ba552d35mr62357125ad.51.1758323398035;
        Fri, 19 Sep 2025 16:09:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803184d3sm64056585ad.116.2025.09.19.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Fri, 19 Sep 2025 16:09:50 -0700
Message-ID: <20250919230952.3628709-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To test bpf_xdp_pull_data(), an xdp packet containing fragments as well
as free linear data area after xdp->data_end needs to be created.
However, bpf_prog_test_run_xdp() always fills the linear area with
data_in before creating fragments, leaving no space to pull data. This
patch will allow users to specify the linear data size through
ctx->data_end.

Currently, ctx_in->data_end must match data_size_in and will not be the
final ctx->data_end seen by xdp programs. This is because ctx->data_end
is populated according to the xdp_buff passed to test_run. The linear
data area available in an xdp_buff, max_data_sz, is alawys filled up
before copying data_in into fragments.

This patch will allow users to specify the size of data that goes into
the linear area. When ctx_in->data_end is different from data_size_in,
only ctx_in->data_end bytes of data will be put into the linear area when
creating the xdp_buff.

While ctx_in->data_end will be allowed to be different from data_size_in,
it cannot be larger than the data_size_in as there will be no data to
copy from user space. If it is larger than the maximum linear data area
size, the layout suggested by the user will not be honored. Data beyond
max_data_sz bytes will still be copied into fragments.

Finally, since it is possible for a NIC to produce a xdp_buff with empty
linear data area, allow it when calling bpf_test_init() from
bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
xdp_buff. This is done by moving lower-bound check to callers as most of
them already do except bpf_prog_test_run_skb().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c                                       | 9 +++++++--
 .../selftests/bpf/prog_tests/xdp_context_test_run.c      | 4 +---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..0cbd3b898c45 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
+	if (user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
 	size = SKB_DATA_ALIGN(size);
@@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
+	if (size < ETH_HLEN)
+		return -EINVAL;
+
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
 			     size, NET_SKB_PAD + NET_IP_ALIGN,
 			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
@@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != size ||
+		if (ctx->data_meta || ctx->data_end > size ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
 			goto free_ctx;
 		/* Meta data is allocated from the headroom */
 		headroom -= ctx->data;
+
+		size = ctx->data_end;
 	}
 
 	max_data_sz = PAGE_SIZE - headroom - tailroom;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 46e0730174ed..178292d1251a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -97,9 +97,7 @@ void test_xdp_context_test_run(void)
 	/* Meta data must be 255 bytes or smaller */
 	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
 
-	/* Total size of data must match data_end - data_meta */
-	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
-			       sizeof(data) - 1, 0, 0, 0);
+	/* Total size of data must be data_end - data_meta or larger */
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
 			       sizeof(data) + 1, 0, 0, 0);
 
-- 
2.47.3


