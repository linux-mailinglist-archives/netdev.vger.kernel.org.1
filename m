Return-Path: <netdev+bounces-235619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DDC334C1
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 508904F3A01
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715E346A1E;
	Tue,  4 Nov 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FCUUMxap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99F34679A
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296307; cv=none; b=sxRShFAqovGBkfSr/Qi6FFWWvt/P0h/mMSwYUUCC9LCugE6XABJTkTRRTM5DHIHBsysbKaHXikaLkO4V7IKApzawFNFOPZSrv4cNb1iqv4vwlDHYp7h6CqyvhR/Qt36z9qPDO833nR/zMhh5WVwB3SfU8M1znpokkRj1Zr8fqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296307; c=relaxed/simple;
	bh=yC5dgrKNYULbqJexR4PKQGtUHhJ4sTzYDh5lsrc8wVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twy974sQA8yfc//O5I60Hp0EGq/jDaaxhOkyKcM4iJ7V+aAvoLeH6ZvgJmHvW/vqreqNdGTP1+wa9ZKeuSL3XahuqnsI+uAujWQ0ibE8exR6hBl1gydTVusxPw7xYLMCmRExWxYds8GXkNRgVn2EGGctUKGSOhT8jNEz54t1Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FCUUMxap; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65698036968so2029622eaf.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762296303; x=1762901103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA+MIvsz3oHo5qpD2FIHZUBV7OZPnR+HBMVbUSiqp/s=;
        b=FCUUMxapq5iZZ+cFBWhNbe4LfiBxnvKWfHc8JOPeCq8AkcizPn9eV+wFfDL8Gz3Dej
         kyp4RmiObLStOZThKI16EXqH8ayu/O/G5DEH5YaL9l83MSJQ6dPhS9h6dwWyW9K0qD04
         M/RdTbwBkR3UEhiY4Cvx/VSV8hWMHlqeqdCjgoNLcJreZzFdpGAerdRnuL0TUmIqegYv
         SA2zVzKucfRbY8a6cCCtuoWKH6rad/Ov9w2zMe9njl2NWoCfhhycoqMJmwKqvZmRiLRi
         IteMDkLbXGMzBRoPpqIGJ4ZDk2qe5bvOsslSkeiW1cpS8yV1oPB4h7NZipdiBvSQ+V3H
         7tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296303; x=1762901103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA+MIvsz3oHo5qpD2FIHZUBV7OZPnR+HBMVbUSiqp/s=;
        b=Y8L6BdaWCnGhg9Ec9Kc8LnOShiFoWt6Kn/9/JrYlvIDpgNFn3WFU3AcFp/jr9nxwoW
         Y6Iajszp8ZerVsXcLXStTg1vkHXnT+R09M3tPd484oolm50VuyzVhmGue525ZE3tFh+0
         0AU6NLSoORVtz2ytqywq2Wt9/icSA3m6qSXM5HfYvY1m2R2Nx2bG5v0TRmiZxaEehorL
         dt5mz3gsM2sGfz2FQnuvnLVelDEWiGSgrBDE1PW+yy7ULYBq4LY9MSoZBzYzeNymLPgg
         DwVzp18PdP4sfhQhvs9SqCiiG9Vg3Dk2ZWMMY8mv50RaWOJDU5cHA+d9Vx7v+yzuBv1U
         eeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNjXDdY/UP2p70/39N5PPgxujcc7z4LOQCkgqn1VaTaTibnYjdEii7wyJAAUUXL0vk6PE9jkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0MwEgs84gp39/SLVDCmsQXpsa5xj+DV4mv38FEz3u4/1PhX+
	o0pishKOA7Tbk4NJx2ckp/VtZRtQb/VOH2ip7uAGwoxTBF9balM+2MoWRIXK8ZybSY4=
X-Gm-Gg: ASbGnctZ0ikeHmbl+vMpblXbMwsF75WshRO8u73399GmGTslRB75yB1v8mDDoOsZJjn
	fpmydO4Z+bUW6Q/75sdSPlnlLwKvEuFQPuHGH2X2V3vrhlhgso2FoP5IJyj5HJyEuXRVtYTEOM5
	l4a2xuYFUfIJo06uo+VJ6WUgMBonHjbwz76y0MdLO84jpdG5hpb4H8zFPjV41QmBlNbvxmWMEmW
	IJtQ8t0CFSruaGBfJNfl1ZRLTD/0/H2IRBq1egXHd8fHDM8tUnMPb3OV+AOx3FKy5XT9LpTTGn2
	vc4Wur9c+f1ZgAlmDoTEICJCIJ0UiumkWqDbs4y6cS4W7/e+KBTLv6ADvQMF1Fctiv8JidG8iiM
	eqe/kUTLX/pJvQdOi823Fo84r1+J3qqBZ9DErhpF1m1xjAo7V2CY6DvSP/ib3J+OK40BcaRHZ5N
	ICqep4SjdUoGNU8GTvbw==
X-Google-Smtp-Source: AGHT+IGaRdMoHxrYXRoFywkb9zzwtOseeYfUChxcZZvNvkul5gfGuN9xS0zLBpc7AsVgalBrl0Hahg==
X-Received: by 2002:a05:6820:2006:b0:656:84ec:64a with SMTP id 006d021491bc7-656bb64d4c7mr290855eaf.8.1762296303554;
        Tue, 04 Nov 2025 14:45:03 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656ad43a2b4sm1178456eaf.18.2025.11.04.14.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:45:03 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v1 3/7] io_uring/rsrc: refactor io_{un}account_mem() to take {user,mm}_struct param
Date: Tue,  4 Nov 2025 14:44:54 -0800
Message-ID: <20251104224458.1683606-4-dw@davidwei.uk>
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

Refactor io_{un}account_mem() to take user_struct and mm_struct
directly, instead of accessing it from the ring ctx.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/rsrc.c | 26 ++++++++++++++------------
 io_uring/rsrc.h |  6 ++++--
 io_uring/zcrx.c |  5 +++--
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..59135fe84082 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -56,27 +56,29 @@ int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 	return 0;
 }
 
-void io_unaccount_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
+void io_unaccount_mem(struct user_struct *user, struct mm_struct *mm_account,
+		      unsigned long nr_pages)
 {
-	if (ctx->user)
-		__io_unaccount_mem(ctx->user, nr_pages);
+	if (user)
+		__io_unaccount_mem(user, nr_pages);
 
-	if (ctx->mm_account)
-		atomic64_sub(nr_pages, &ctx->mm_account->pinned_vm);
+	if (mm_account)
+		atomic64_sub(nr_pages, &mm_account->pinned_vm);
 }
 
-int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
+int io_account_mem(struct user_struct *user, struct mm_struct *mm_account,
+		   unsigned long nr_pages)
 {
 	int ret;
 
-	if (ctx->user) {
-		ret = __io_account_mem(ctx->user, nr_pages);
+	if (user) {
+		ret = __io_account_mem(user, nr_pages);
 		if (ret)
 			return ret;
 	}
 
-	if (ctx->mm_account)
-		atomic64_add(nr_pages, &ctx->mm_account->pinned_vm);
+	if (mm_account)
+		atomic64_add(nr_pages, &mm_account->pinned_vm);
 
 	return 0;
 }
@@ -145,7 +147,7 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 	}
 
 	if (imu->acct_pages)
-		io_unaccount_mem(ctx, imu->acct_pages);
+		io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pages);
 	imu->release(imu->priv);
 	io_free_imu(ctx, imu);
 }
@@ -684,7 +686,7 @@ static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
 	if (!imu->acct_pages)
 		return 0;
 
-	ret = io_account_mem(ctx, imu->acct_pages);
+	ret = io_account_mem(ctx->user, ctx->mm_account, imu->acct_pages);
 	if (ret)
 		imu->acct_pages = 0;
 	return ret;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index a3ca6ba66596..d603f6a47f5e 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -120,8 +120,10 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags);
 int io_files_update_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages);
-int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages);
-void io_unaccount_mem(struct io_ring_ctx *ctx, unsigned long nr_pages);
+int io_account_mem(struct user_struct *user, struct mm_struct *mm_account,
+		   unsigned long nr_pages);
+void io_unaccount_mem(struct user_struct *user, struct mm_struct *mm_account,
+		      unsigned long nr_pages);
 
 static inline void __io_unaccount_mem(struct user_struct *user,
 				      unsigned long nr_pages)
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d15453884004..30d3a7b3c407 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -200,7 +200,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	}
 
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
-	ret = io_account_mem(ifq->ctx, mem->account_pages);
+	ret = io_account_mem(ifq->ctx->user, ifq->ctx->mm_account, mem->account_pages);
 	if (ret < 0)
 		mem->account_pages = 0;
 
@@ -389,7 +389,8 @@ static void io_zcrx_free_area(struct io_zcrx_area *area)
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
-		io_unaccount_mem(area->ifq->ctx, area->mem.account_pages);
+		io_unaccount_mem(area->ifq->ctx->user, area->ifq->ctx->mm_account,
+				 area->mem.account_pages);
 
 	kvfree(area->freelist);
 	kvfree(area->nia.niovs);
-- 
2.47.3


