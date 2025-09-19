Return-Path: <netdev+bounces-224837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6DB8ADED
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF46C16816E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749E26E143;
	Fri, 19 Sep 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMB6aiKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50242261B8A
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305373; cv=none; b=lIu+frrxDFc2yQEaas8QJShLDFJ8w4VJphtAoh+Jj+FX4do71F4RLDwoDn0/Hfy0D8gaZg0Gn7VceMLAtw1TM74VpsKVA/m/auDfvKWTK6C7MQFrEQfQCZ8sTBUeEXKaT+0oVPAdTEYMGeVD/M8RonAx91D8nyW3RD3B9HefAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305373; c=relaxed/simple;
	bh=mnhFefxXBFpAxTuPQC7oZZaXYOasqtRHyRYWS3i67S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgWy3CfMzpVSJ06sz/eEsaiNJaaskme2Hl35LiXzWVbPm48BARiWIEIdlb26yG1vU8ZqxBlJcBNlDu4AbPRGoTBEWq9/ZUcXsBcw4ofZpajLQJJrQ6/mkDwb/iV+DWol+uudR1QJtE/K12tbM0VibCg6dB7kZG1CzD44uTxFW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMB6aiKP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-268107d8662so22815085ad.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305372; x=1758910172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=QMB6aiKPLQS7dmJ/pUYWVaQeSHSDJKnRYdbS+5wGEM39FldMrgJ8dFcJYF+dMKYtTh
         NPeiLh536tcgCWQ8qoiId+6RZIOSHvINCnjNdMT5hBENzPaepuHHsHJs5PCzEgwgy+Eq
         8XrEhnqzx7xyfqZv6bwmcBTmCw1ftHuZ6e+mafGYJFFNJof3T8sT3xr2c9jb1tWtpBq+
         dnbyW+hPcV2923YELgiUQX2RUP6XwR1zGGZF1hogK1kf46PhKCIvdz1mU6LL0dvcmBIy
         ORRXKRSmMv7FKnjTRfAPcoLeiCDv1ahGt4nFQZXu6ksDI/oRcEC6FomGnjj7ihxUURqv
         hsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305372; x=1758910172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r1RUUuGz0HNQTWTUVyljerk1TXvTpK2To+3rwkm5Mw=;
        b=jEJWockZGSuqhyzOku1eNDqwOpge0b+kdG6PdLVA4+qf7Mw1Uazl6YJihH5u6PrdW3
         3n4p0Qur/1xDkvarkOJ83ZcEmY/i9UeOFLW7VA+Mip3yfJqZHa42Rvc1jRke/70yRLsK
         380XIVisRQPm/N3tx9uIztNQF2wA1Blg2OPxKYHTpm3cuzHjKtKfNdN+64M5nSIYRiPU
         8t0m6UUE2RgcL/VQgBptDB/oDTUraNDLOn4CUhDWs6eJfbHaFIRPtjSgv6NW20lGMkr6
         Fg1tkXMbzpvOSu7/GbV3GL4pqo+i9KIMqFNpPuuvmX1vo7j0zssil9PsdZQKbG+TcPXU
         BqJA==
X-Gm-Message-State: AOJu0YxhLXwv6nmFGqlm6ma4LtRNvFpDMHdMkSpDluP0MyAytBGoinTC
	lsNnGputsaluHbnpkDFihLgzNGPwR6eyq+Zk7aUEhYYFVU2sea4/CHVL
X-Gm-Gg: ASbGncsxKxdhW90BwRZaros6VinwImb3vAZYVngb1uybkFC2iXWoqMdTxsUG/TQsMiX
	/i0oG3F7GdU515dCmu0e6beReGWOQoYK55WVKIBzCcL55mdn8yN7bAatWdSRCwJvS/Vd3AZUkvV
	ydOH5lP+3LkAkahCg2DabLE8hUs/kcWZgu6fHIfRweNBgH7rMMUYwq1StPWKhAfpeOv/c1vNQPz
	/gUV4dbCAZZ4MpIrsDdXlc8QuLBN5oYGsMhR2CxD1F+HviOSIA77N/q4RjCkPeWUHVJ91iE8vlp
	r4JKQvDrEWCqmifhNlTKnAMszm2p2iDcPqhgCCOX7M1E5UPRL4c6yKfFKU80+ohMUeOmmDrQA7F
	EtThinOXCUs47N6G9R5SEjpH8
X-Google-Smtp-Source: AGHT+IEOxYaoPTKGlkn3Kqx08q3AA8T+7eAF9tmxMyHzXxed6cIunrYp6VWh28+tRDL/P6ibU6zVdw==
X-Received: by 2002:a17:903:3884:b0:24c:82ad:a503 with SMTP id d9443c01a7336-269ba53a976mr51098275ad.41.1758305371668;
        Fri, 19 Sep 2025 11:09:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980357043sm59701505ad.138.2025.09.19.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/6] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Fri, 19 Sep 2025 11:09:24 -0700
Message-ID: <20250919180926.1760403-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
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


