Return-Path: <netdev+bounces-69565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BFF84BB09
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2DEB24AA0
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0944F17C9;
	Tue,  6 Feb 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v/joypFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A374C85
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237273; cv=none; b=tebaEJmpxBc2t1Engnh1XCg77vTX5nnwgjd/qzhli/mz8jqLcTEhr/vXFN5BjRMd0gJJnNP+aIPBfdOH/aMBk4PNVs9aKpvY+l6+mMiXdmzjByPu5Dc8Jb3MKqJT7+5havkdivRlbEBvVianmhYtOiXqEEcIZgnbfoQE4i1Cexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237273; c=relaxed/simple;
	bh=qFrLfnZUqnxpf9kZjxPOH7hXkYHaofqwbA2Dey+GNqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSGAelaAiwjpInfjzdOfiMYqumidzO3MH50r04V1y4dytWFpZmDmfg8raDx8YxtGPKh6Tznuyb51O+VuQVGJZRibxb8PPe2CRhVI7kmm8cf9ips3v1bK8i5K5KV0z0GAXq+F0gK4dD13LswNEST0l8ngJQiIjKztZ1QTuXuLbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v/joypFv; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso98779639f.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237271; x=1707842071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2f7mblEBC6gILdcCaQ7zTCfyhJUPrlWxzcU1XfF6vs=;
        b=v/joypFvE741RtF+1oGU3hPX0xq2skhyBFvPiHzNxt8cRKjyVQNQS+ApRdFQVwS3WY
         OgQ+zNQjpolipizHc3gDjfnAFzf4l/kQl/xYej/FVw5ChshgHKpoJHVQcgCUejo3Ra9p
         Uj9wIuFlYCvJuaIdqbuNLfo/t1oprmB/73K/OQhulFjkE0oKwDk1zo0uAST3DdBG64ar
         ZFbkOqL0hy0S6cFWPvj6a+cWWer8CdtLzTvtXEmawgWY812JyzWLDqLDDiqJKdj78exB
         k1nIKHSyHS4E+prPjv2pAW1Nk2DkTs4frRag2giXw+udehibdd0r+H4ll/GSslcOxzXk
         g2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237271; x=1707842071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2f7mblEBC6gILdcCaQ7zTCfyhJUPrlWxzcU1XfF6vs=;
        b=SsYbCyyy8QoQJbFztlAujcpQL1UP4vx7CjCZ8qXVH+YFifoZN8eVZOSav37Csf81o3
         E1k00cxfB/Yqbsepb1iL1uTNuUnAfEP3x7RtJ2CPsm2vGHxyRhRFTBeABUmtLEx2brWH
         hm/mLM2Zz3yviV3vdDGsDT45/GGDeX23iKW8FIoG0XNj998Ackgsq2wXjtm8y/ndrAyn
         sATRqu7RgzmuvF6wKmzP8uXjrtDj29o2z7Asbq8laxJeDGkYEYwIdsbdGJLzw/m6cT06
         zzpQb/Y3rwEO81FOcUb0EnakGdrDFtrN+cwKSQeGiakqwmNQ5cHTlOKZC/1wSPpWOk++
         BF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7BkUHM7nmXh8ly/0BzO4wntwIBARDdLmQleVRUrOrFZcBHF0a8YzTjf0HjXookFtQDgHKec3GAnV9W+Jsg1QKQOiiQuoQ
X-Gm-Message-State: AOJu0YySTkA0MQ6UkORxDpGV6Mljxaw+Q+XQD+witC7goBy1jq0Veg+q
	YYL1Ffog7licfA+HdTz7vtY3VTEI3fHRd3lvUgZ02CKcBg8mucPcSfu4jxQ40Vs=
X-Google-Smtp-Source: AGHT+IGiNAJxWmLVVliV4s3lCMHniDuSEsp/FWRaG+qQ/jxQx6rRqR8ocSXystJKlPiDsnFN/Q2UDw==
X-Received: by 2002:a6b:f308:0:b0:7c3:f836:aed with SMTP id m8-20020a6bf308000000b007c3f8360aedmr465487ioh.0.1707237271462;
        Tue, 06 Feb 2024 08:34:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVafBau/mNjUZi+BUFYhR5vMCBIJteOSb0oVEqYyc4vOHHFUjQsDP795cU8ds5OuMVrh+SSibTXxljcONOdoR1LQjxwO9YxA4Q156iJQncFbLfoXDwFzeNAGeFKmicZS3uiNWIz5XmX05lCksLqqXQ7Y7jHci7e6yOMPgeMR91hBXI=
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u8-20020a02aa88000000b00471337ff774sm573316jai.113.2024.02.06.08.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:34:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	olivier@trillion01.com,
	Stefan Roesch <shr@devkernel.io>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] io-uring: move io_wait_queue definition to header file
Date: Tue,  6 Feb 2024 09:30:05 -0700
Message-ID: <20240206163422.646218-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206163422.646218-1-axboe@kernel.dk>
References: <20240206163422.646218-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Roesch <shr@devkernel.io>

This moves the definition of the io_wait_queue structure to the header
file so it can be also used from other files.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Link: https://lore.kernel.org/r/20230608163839.2891748-4-shr@devkernel.io
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 21 ---------------------
 io_uring/io_uring.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 9ba2244c624e..76762371eba3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2477,33 +2477,12 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 	return ret;
 }
 
-struct io_wait_queue {
-	struct wait_queue_entry wq;
-	struct io_ring_ctx *ctx;
-	unsigned cq_tail;
-	unsigned nr_timeouts;
-	ktime_t timeout;
-};
-
 static inline bool io_has_work(struct io_ring_ctx *ctx)
 {
 	return test_bit(IO_CHECK_CQ_OVERFLOW_BIT, &ctx->check_cq) ||
 	       !llist_empty(&ctx->work_llist);
 }
 
-static inline bool io_should_wake(struct io_wait_queue *iowq)
-{
-	struct io_ring_ctx *ctx = iowq->ctx;
-	int dist = READ_ONCE(ctx->rings->cq.tail) - (int) iowq->cq_tail;
-
-	/*
-	 * Wake up if we have enough events, or if a timeout occurred since we
-	 * started waiting. For timeouts, we always want to return to userspace,
-	 * regardless of event count.
-	 */
-	return dist >= 0 || atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
-}
-
 static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
 			    int wake_flags, void *key)
 {
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 38af82788786..859f6e0580e3 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -35,6 +35,28 @@ enum {
 	IOU_STOP_MULTISHOT	= -ECANCELED,
 };
 
+struct io_wait_queue {
+	struct wait_queue_entry wq;
+	struct io_ring_ctx *ctx;
+	unsigned cq_tail;
+	unsigned nr_timeouts;
+	ktime_t timeout;
+
+};
+
+static inline bool io_should_wake(struct io_wait_queue *iowq)
+{
+	struct io_ring_ctx *ctx = iowq->ctx;
+	int dist = READ_ONCE(ctx->rings->cq.tail) - (int) iowq->cq_tail;
+
+	/*
+	 * Wake up if we have enough events, or if a timeout occurred since we
+	 * started waiting. For timeouts, we always want to return to userspace,
+	 * regardless of event count.
+	 */
+	return dist >= 0 || atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
+}
+
 bool io_cqe_cache_refill(struct io_ring_ctx *ctx, bool overflow);
 void io_req_cqe_overflow(struct io_kiocb *req);
 int io_run_task_work_sig(struct io_ring_ctx *ctx);
-- 
2.43.0


