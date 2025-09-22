Return-Path: <netdev+bounces-225428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB1B93986
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BA82A1A15
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4C3176ED;
	Mon, 22 Sep 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZxdmliT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71D253F07
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584046; cv=none; b=cUeDaQoH4UcDbg7mFRfSh2MNFa1cGiFssmnYE7pUPV2DSK1mnjzDnwiPh08QfhKkbbwJ0tD4RAM4ZiMSIbfHdzdZ7l3jyuhUbojgSlPB551zcnGPfDqMo3yzUJ+Ixk4CsHQwDcztTNK6wXDYKC6+gbYIbbmqDFKAy9PQZ7LyIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584046; c=relaxed/simple;
	bh=2f050itZdHTRLHGn40vb/EYrVJu4XQ+KblywoVqTgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrEBnnIXrFxd0PoOpk03sBe4KWdl7yqPx9C8uQtr+7vienFI6qPbbIPnujjzNV5Su21+i2wxv7Bmlm8T7faenyp3UFaGVgFI9FX0ZC3V3ObFV5TmfLCY4txoYbFIRWXaHVd6moGdOpQYhwBvlQt4njuRv7S3uKeTTftafGuIKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZxdmliT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so5568904a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584044; x=1759188844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etD7gcHK9LnUFM4hDKKBvWAyvkFUC5teRK2v0kQ0URc=;
        b=ZZxdmliTsZKmioVrYHWEpWo7kvwi6XstRUgURqym0vvOt2nkNM2rIV1POIKsx27fc8
         3KLBLJA1gD8PPJLArjt+sDkaOX6TlZHbA7YgX130qfIQ2F41B4uPk1jPfFfqScJOmSe8
         uG/jrclpU8G3kDcFZayPSqiC6nPjFDDO8HbOjhFVffBWkc1xB7IilBzo63TIIN9xzNN6
         owVIQ2QKkfgpsQqtWlV7Mu5wiY4iIEgA7yBAsoDXOpXZyG9LXC9D0tX0boxilZ5u+v/J
         2bvFF4ICqPCEFeP8mqLe7UQH2ayG5afhsKjzUsmzZAeX6suXUOVC1LodIGobJ8LxyAGl
         Y+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584044; x=1759188844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etD7gcHK9LnUFM4hDKKBvWAyvkFUC5teRK2v0kQ0URc=;
        b=hEcUVC/AYcA7x2JgfPVRiC3/4M44A4khUD5ucsLqOvcKJovQhwNca2lcba9NuTduzC
         kkoxmXFVaX8CwspIahfrAKYFSahVn7YayuYY/59RpFTGhpiOQkZTCcmYca5a1gfDNnU+
         oyIUg1UWPvchhjqs/mBV2KKjoykFQcDdG9GD0FF9KQYlLufSn2u2ZrpknBdafiuDJuJE
         bKZZOqGfRXwhrT6nr6mKnuCOLG4ZByVJx2hithTcrlbtBlG2LpkjKA1p4qv9ubgZYE0g
         9T8tZwZ/VHQCUdy4pHI2oVeWLbeuN3czHgUlF3O+4IbEFCJesEBicYx3Ko/LCJa9krsN
         BM0Q==
X-Gm-Message-State: AOJu0YxEjyEcqxuKUdh+5rDhBHEzVFrDU8hDQ0KLGyy+AhSlZSGXgfCI
	IBn5nxA2nU+OWYap0Yez8ziz+MXtfaWRpX9UxbQ8gsx1z1/Z4VAzYr2W
X-Gm-Gg: ASbGncsdHBL04Ott88vFBRJ8WVd/1aGQHNVmoXPhh6LTioK1gHhMofW0lh2QLBKqv2x
	QSLhn/bHAo+QC6kOuKpPsG0eQnMZABnlGFYRssJ8ycaCqqfBw6t8qsFbCi6D8cQfqqFFso76ttB
	gYYFhW+Fc139NpCLsmEU4RQSi9o8GdRep/J4QK9DA1Ybh/ZWjlv+yz1aA0CF+3XlL08CB5Gn/Ke
	qMi+lSI1TfEVQoOVPV7o5erO27alwHwwJozIRsP0Bkp9xuMxblGQjeewwNbdglXoZZqTkpMbobB
	mifvaCQW28Y/pgOp+GJ4n6zwMPf4CJxsC1s48UhMeHca9x0sBhQxaZUBe/WTTOgrPaKmiuwT29n
	75BycJl//f8S7
X-Google-Smtp-Source: AGHT+IEmURHV9sf0CzRHyouWrWrzQLZd5tv6Xobeqk+WSUgoShRYhyWlyM7Fma/AObe4XRFM7BlfYg==
X-Received: by 2002:a17:90b:3d8f:b0:32e:9281:7c7b with SMTP id 98e67ed59e1d1-332a92dfb85mr825921a91.3.1758584043503;
        Mon, 22 Sep 2025 16:34:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1fb6sm13885313a91.16.2025.09.22.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:34:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 6/8] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Mon, 22 Sep 2025 16:33:54 -0700
Message-ID: <20250922233356.3356453-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
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
data area available in an xdp_buff, max_linear_sz, is alawys filled up
before copying data_in into fragments.

This patch will allow users to specify the size of data that goes into
the linear area. When ctx_in->data_end is different from data_size_in,
only ctx_in->data_end bytes of data will be put into the linear area when
creating the xdp_buff.

While ctx_in->data_end will be allowed to be different from data_size_in,
it cannot be larger than the data_size_in as there will be no data to
copy from user space. If it is larger than the maximum linear data area
size, the layout suggested by the user will not be honored. Data beyond
max_linear_sz bytes will still be copied into fragments.

Finally, since it is possible for a NIC to produce a xdp_buff with empty
linear data area, allow it when calling bpf_test_init() from
bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
xdp_buff. This is done by moving lower-bound check to callers as most of
them already do except bpf_prog_test_run_skb(). The change also fixes a
bug that allows passing an xdp_buff with data < ETH_HLEN. This can
happen when ctx is used and metadata is at least ETH_HLEN.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c                                | 15 ++++++++++++---
 .../bpf/prog_tests/xdp_context_test_run.c         |  4 +---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2a0af50f177e..dfb03ee0bb62 100644
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
@@ -1207,7 +1210,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 {
 	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	u32 retval = 0, duration, max_linear_sz, size;
+	u32 retval = 0, meta_sz = 0, duration, max_linear_sz, size;
 	u32 linear_sz = kattr->test.data_size_in;
 	u32 batch_size = kattr->test.batch_size;
 	u32 headroom = XDP_PACKET_HEADROOM;
@@ -1246,13 +1249,16 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != kattr->test.data_size_in ||
+		if (ctx->data_meta || ctx->data_end > kattr->test.data_size_in ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
 			goto free_ctx;
 		/* Meta data is allocated from the headroom */
 		headroom -= ctx->data;
+
+		meta_sz = ctx->data;
+		linear_sz = ctx->data_end;
 	}
 
 	max_linear_sz = PAGE_SIZE - headroom - tailroom;
@@ -1262,6 +1268,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (do_live && kattr->test.data_size_in > linear_sz)
 		goto free_ctx;
 
+	if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
+		return -EINVAL;
+
 	data = bpf_test_init(kattr, linear_sz, max_linear_sz, headroom, tailroom);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
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


