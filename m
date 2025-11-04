Return-Path: <netdev+bounces-235622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71619C334CD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210DC4F6B60
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A484346FC1;
	Tue,  4 Nov 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NBIUIhn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EB2D0C8B
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296310; cv=none; b=dnBo8YYuBx7glMfJbR4WMlEFYvrAGDOfMpXkycwTokd3wlCAp7a2WyX92QTiyEEhSkb/aXYw2dKW0+Idb6IcTlUfdr5cCR9KjJTbEW/FxdMk5s4kN+TMXw+wnLVdBSWjn8AIcNfJWkXUck7DXXbtjIhn7POIKCeTzrPrEKpSrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296310; c=relaxed/simple;
	bh=q7BK9iktocfJYm+/WotXGKhxxS+aD37j96cH6TGbOE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVQzDt4YioQdI8T+exheGQIBwtk9QhprGFH1O71dzzdGLT/oBEhdYWrXiS8u4S5dX6P2RH5qUg3oU78CQceU27DeZREoedLiV9RJHfKkRzJCwvAvzZmrB9P7peM1TOnDSiJ77lv5SBU5MPBUmQ4zqqFGjZ2ugvq4zBEymU76bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NBIUIhn7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c97709a4fbso2273938fac.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762296306; x=1762901106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPop6mvsum5XsgmkruquoYcW5M+7CiBgtUqQPcfMIkw=;
        b=NBIUIhn7a/hiO9aaV5nt1JptYGaUqnYgDjOBtXf+gWuUIUW2wBBvYdMYPJvp5HrU4d
         CpS3/kiVF8Pwhqy+91/dwCpQhtFlTbKnJwmlfAedz3BUR/j0IB5e6D2WBtXP83uWPJes
         tHn9bfchGYDiOWz/TT1Uynx5Q7LR/5FAsapaOGKJajSQAeOoI8mJgDRp90+XGgnCvO5U
         O/UPt2DrExK00pu7Dio4FUvTyFfUN+42fLVA8GGgAPqQ8Ko+StgyZiv14iFrrEKTEPcL
         F0a77CY/udAH+1KD/cvG4+gCGeFVvzEzuB7xENCgWvzj2wJWsIsp7MRKDfhcuQXqVkax
         9tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296306; x=1762901106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPop6mvsum5XsgmkruquoYcW5M+7CiBgtUqQPcfMIkw=;
        b=btdOKcjUQph3q8JNBN4Guf/JdCPYIJgnhKTnrRQFrsj1qQcSD02/Ve6on9RztwXzZf
         g8QlHQPW8yaZ8XNEyqIMygTRniRVdK/vd5jCUglETPzaqjL4RWXCACwcWYUQHbs5MKyj
         YlYoAXDgs1+CWI43/hS3LwW6REiGxIfQm7qJstErUNjX5HrwrkK/pUY6+8RytQSDpbi+
         sSdC5XKjkrIofvO3v7KQ8EUQtD7kjKcDGz8r7G8O+tu2jgj1A+75BHpuEcWuKddSSItu
         OVhNXe67QbdoTLZxlGdqqHcHe53c/ndJab54SeZn0NROlfZAMUz3Ut1B0WO4IMP1KGqg
         Isfw==
X-Forwarded-Encrypted: i=1; AJvYcCXtUY+jd/ja2g3mhRHcFtytJh/xNp5U+PNpvREx0InyfGu+z3g+b7A2pkaS+aUKL8jN+BG/ruQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7SR/JIpeRPb2rc+ewNrnBe59WCmj5Tu0PhVulAdUybnuYE7l
	TvFaDLPd8/OYg0Y5nhiyKR8tJUfQg806aSg/OZKVgDK+bfSWPnETavh6meLncegRkHg=
X-Gm-Gg: ASbGncsc60bS7hs6X14hMKtP46RqiIogAlMbQmWuO2ZkEMBY2HJ1FDfxuE3qTTC7aBY
	FZkHfP1CHN6mV9mR0bnzLZ9EEDNGST4XRKQoUQ6H2Ce050xpHUrQXxLlQ+1BjYXRGX7VxblFjO+
	FLsCj66Sy6XI0yyoCuWAvQY50HJv0N+10EdS4jlH0xg9cNadfXrJSXSp+HjyTjeZeZ/zVuvTBfW
	jYY9Q1NQlQNkrlBUK5WQqsUZ4pJgjzESyccKdyDk75SydeeEJgZqpthczpijGnHmJ6p2HbIRjjg
	Ncnfr50mymsHbYHQUQd6eDCIfqb/J0LIHEVyde9u20S06fVditN3T1UZl3OEaNprT85/Gurqsvq
	jQ5qvA7ebt5muSCp/Pf7YgYjCyA8RtC2u2SVWgdw1Z08RFbisbcwkbzq4SCMZvisNuTknVpdIYJ
	DKy8W1fkOkF2dl6n0=
X-Google-Smtp-Source: AGHT+IGG5v+Bzx2YdnvN+edflESwvjBbj42aNUf+BHdumuV4GVGSmBg+c70fo/cCzgXp4EfZjyPJ1g==
X-Received: by 2002:a05:6808:ec5:b0:44d:badf:f41a with SMTP id 5614622812f47-44fed30a937mr374253b6e.32.1762296306159;
        Tue, 04 Nov 2025 14:45:06 -0800 (PST)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44fd84952c4sm1066384b6e.1.2025.11.04.14.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:45:05 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v1 5/7] io_uring/zcrx: add user_struct and mm_struct to io_zcrx_ifq
Date: Tue,  4 Nov 2025 14:44:56 -0800
Message-ID: <20251104224458.1683606-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104224458.1683606-1-dw@davidwei.uk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing ifq->ctx and making ifq lifetime independent
of ring ctx, add user_struct and mm_struct to io_zcrx_ifq.

In the ifq cleanup path, these are the only fields used from the main
ring ctx to do accounting. Taking a copy in the ifq allows ifq->ctx to
be removed later, including the ctx->refs held by the ifq.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 24 ++++++++++++++++++------
 io_uring/zcrx.h |  2 ++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 5c90404283ff..774efbce8cb6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -200,7 +200,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	}
 
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
-	ret = io_account_mem(ifq->ctx->user, ifq->ctx->mm_account, mem->account_pages);
+	ret = io_account_mem(ifq->user, ifq->mm_account, mem->account_pages);
 	if (ret < 0)
 		mem->account_pages = 0;
 
@@ -344,7 +344,8 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 	atomic_inc(io_get_user_counter(niov));
 }
 
-static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
+static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
+				 struct io_zcrx_ifq *ifq,
 				 struct io_uring_zcrx_ifq_reg *reg,
 				 struct io_uring_region_desc *rd,
 				 u32 id)
@@ -362,7 +363,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
 
-	ret = io_create_region(ifq->ctx, &ifq->region, rd, mmap_offset);
+	ret = io_create_region(ctx, &ifq->region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 
@@ -378,7 +379,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 
 static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 {
-	io_free_region(ifq->ctx->user, &ifq->region);
+	io_free_region(ifq->user, &ifq->region);
 	ifq->rq_ring = NULL;
 	ifq->rqes = NULL;
 }
@@ -390,7 +391,7 @@ static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
-		io_unaccount_mem(area->ifq->ctx->user, area->ifq->ctx->mm_account,
+		io_unaccount_mem(ifq->user, ifq->mm_account,
 				 area->mem.account_pages);
 
 	kvfree(area->freelist);
@@ -525,6 +526,9 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 
 	if (ifq->area)
 		io_zcrx_free_area(ifq, ifq->area);
+	free_uid(ifq->user);
+	if (ifq->mm_account)
+		mmdrop(ifq->mm_account);
 	if (ifq->dev)
 		put_device(ifq->dev);
 
@@ -588,6 +592,14 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	ifq = io_zcrx_ifq_alloc(ctx);
 	if (!ifq)
 		return -ENOMEM;
+	if (ctx->user) {
+		get_uid(ctx->user);
+		ifq->user = ctx->user;
+	}
+	if (ctx->mm_account) {
+		mmgrab(ctx->mm_account);
+		ifq->mm_account = ctx->mm_account;
+	}
 	ifq->rq_entries = reg.rq_entries;
 
 	scoped_guard(mutex, &ctx->mmap_lock) {
@@ -597,7 +609,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			goto ifq_free;
 	}
 
-	ret = io_allocate_rbuf_ring(ifq, &reg, &rd, id);
+	ret = io_allocate_rbuf_ring(ctx, ifq, &reg, &rd, id);
 	if (ret)
 		goto err;
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 33ef61503092..8d828dc9b0e4 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -42,6 +42,8 @@ struct io_zcrx_ifq {
 	struct io_ring_ctx		*ctx;
 	struct io_zcrx_area		*area;
 	unsigned			niov_shift;
+	struct user_struct		*user;
+	struct mm_struct		*mm_account;
 
 	spinlock_t			rq_lock ____cacheline_aligned_in_smp;
 	struct io_uring			*rq_ring;
-- 
2.47.3


