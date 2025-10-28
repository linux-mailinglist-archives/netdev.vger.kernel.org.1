Return-Path: <netdev+bounces-233616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE36C164F9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2E894FD10E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50534E772;
	Tue, 28 Oct 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="1Nr9CXWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98734CFB9
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673611; cv=none; b=PZ3nFJrFqng5vCsZGlKwM4YP0Gd/ELYhK8Jce/BqZGXlrtgvmfDg4fr6HDwtf/yQhws5nY7BLVOi2N6OO7lqlzz+5gcg51rfHatyeqUgr1ULT3L7AqMNM7b4C/EAoWgAftPc/pPIErUCnRj9Nv4Ffw39CIoig3SChIjkI/o4UOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673611; c=relaxed/simple;
	bh=sR5KTAJ1qX7NTAind3uBuB+y3bPielF9T92+VG0Pm/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu0rvwzH+dv7QB0lWN2axbIGHP2BHxdnLR4uAXwZieWgI1Tys8gZq5bUiU6FYzPt0QHbcD3ONzhSdIzMApECBZED1lfBBzEGF40h6oM+c2Oam+34MA92Auv+cXhsYq/cmObWSZuQlo9OsN50BJmKanJSnkVIdcVONIyBhKvYGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=1Nr9CXWl; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-44daa894741so837073b6e.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761673608; x=1762278408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1H5FIjUD5fZtLsxVqgbA1/ASgasVs7HS+4Xszj+/Vc=;
        b=1Nr9CXWlnU6HOdb7WZHQqrYUngn1nmhfBLzcWZ90BCbGAIO8bbDUUo2bCtvblRZwAW
         OhN40nRZlFYmVbKTYXi7V4u1OMK4i1lsN7oXZi9Bhnkooh79wlOVgBuNHtZCJPtVb+nL
         q7TpmNrWSQVYTDLiZ521K4N66zjb2eZfcHs0DWQ4MUmCXb6jonvTv2W+FwJm2gAQhOfS
         IyXP88W2jKaKTxcnbWinotKilJBORBF7I8sUNap8SX3VsjSoHUf3nhlwjY+gXAb8SxqD
         RZn6GkC72eRbyYr8VkB5SpzodgwFVbk2oEvhs92k+b+6z9bg0r8/00rlo0v1fcWgHSh3
         hDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673608; x=1762278408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1H5FIjUD5fZtLsxVqgbA1/ASgasVs7HS+4Xszj+/Vc=;
        b=jazEJT0XqxYlJxx/aQhw0dgwL6UIcjeOMkiQ5VjFMismA7V29BlSQGdPmVepQTVjJy
         cUz+UUbRiKQKefDXUXDdLfoI6/greiOFfpE1f/KAkGTYptYWEjYjOJL12Vpe0FeanSmu
         OwMSgFpS9xhQ2SzVj0D/5zC75+dhSfKncGe82PV1AJg+lhQ3VaGwDCu6I6lVc2dg12Rb
         6aljJUs6aFoP3+S48SdMOg1HYZyfPCZ3py0TLEvbBuEmXekin2pgXHhuFuWUlKbrr8m0
         2zG3N9Ults/eSSqYa6GROvlqd0cMqkCfosU9lzUCleNhOkycJu4Ht38OSMExol3thnNK
         URGg==
X-Forwarded-Encrypted: i=1; AJvYcCX5WelHKKpDxIHN8nKeynHyRRxWge31z17hAyyOfzEO+W+IrW4zJQBOBB0BolA9AAgUDUoV/f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVO6ZmJl+lSA89V/ZGcG5XyvOs9gLo1orJQKGjB4efkwsnbrYF
	FIRkxJVlFX0WBEKhgrfzRt6FMJAh3EtN/MwSJZTMiErLb1WoGuMzRURS0TK5OnqrzK8=
X-Gm-Gg: ASbGncv9PTExacSoR++aHhAZGnovhD1L0yS89Hl0QK3GfgVLhfbj16F91oc03r2yIDY
	O1TAWioIleCy6jZVzfgVAAwOOEp/Und18ithAOIC6kfmXDuboBFs02Sctm84fbI2PW9XPnHrARd
	OLcqjiJ21WE/wneNpNhFXlTkZxRAPHeqnnlAPJZcHxOrWjH4NkgA6rqN/JEsxBs87iMgZrcUe2I
	anKYhONjwv0Cx259q2I/sVeNgUwE2vBUVrJQ/ngZa+UTSRbyojTqr9ZCJTsYf7qs9a5RJHgLfUY
	AnvfWoxJkZPqxpzTBMiCc9QQhiV21at9HSb2Ir8XXdr11fmHQWV/9DNIP7fuaO8S+yDAk/qEyLy
	yk8B79H0la8kezXdiemxsgEBGDiD1Pwy8xzEsRdRrlOA0n/ezca6RKfkI4On2YgbY8bwIN86ANb
	EpW+sUIqHX7wk7hLARNv8=
X-Google-Smtp-Source: AGHT+IGfBeHNEpuV0IjI8ZIiSI1As/6mZc06GH3+ejMb9gpj6vLekzTSlcbgY4LisVuYwZEu9Z8d2A==
X-Received: by 2002:a05:6808:4f60:b0:441:8f74:f3c with SMTP id 5614622812f47-44f7a557121mr128504b6e.54.1761673608435;
        Tue, 28 Oct 2025 10:46:48 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3e80083sm2770913b6e.14.2025.10.28.10.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:46:48 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 7/8] io_uring/zcrx: add refcount to ifq and remove ifq->ctx
Date: Tue, 28 Oct 2025 10:46:38 -0700
Message-ID: <20251028174639.1244592-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028174639.1244592-1-dw@davidwei.uk>
References: <20251028174639.1244592-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a refcount to struct io_zcrx_ifq to track the number of rings that
share it. For now, this is only ever 1 i.e. not shared.

This refcount replaces the ref that the ifq holds on ctx->refs via the
page pool memory provider. This was used to keep the ifq around until
the ring ctx is being freed i.e. ctx->refs fall to 0. But with ifq now
being refcounted directly by the ring, and ifq->ctx removed, this is no
longer necessary.

Since ifqs now no longer hold refs to ring ctx, there isn't a need to
split the cleanup of ifqs into two: io_shutdown_zcrx_ifqs() in
io_ring_exit_work() while waiting for ctx->refs to drop to 0, and
io_unregister_zcrx_ifqs() after. Remove io_shutdown_zcrx_ifqs().

So an ifq now behaves like a normal refcounted object; the last ref from
a ring will free the ifq.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/io_uring.c |  5 -----
 io_uring/zcrx.c     | 24 +++++-------------------
 io_uring/zcrx.h     |  6 +-----
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7d42748774f8..8af5efda9c11 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3042,11 +3042,6 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 			io_cqring_overflow_kill(ctx);
 			mutex_unlock(&ctx->uring_lock);
 		}
-		if (!xa_empty(&ctx->zcrx_ctxs)) {
-			mutex_lock(&ctx->uring_lock);
-			io_shutdown_zcrx_ifqs(ctx);
-			mutex_unlock(&ctx->uring_lock);
-		}
 
 		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
 			io_move_task_work_from_local(ctx);
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index b3f3d55d2f63..6324dfa61ce0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -479,7 +479,6 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 		return NULL;
 
 	ifq->if_rxq = -1;
-	ifq->ctx = ctx;
 	spin_lock_init(&ifq->rq_lock);
 	mutex_init(&ifq->pp_lock);
 	return ifq;
@@ -592,6 +591,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	ifq = io_zcrx_ifq_alloc(ctx);
 	if (!ifq)
 		return -ENOMEM;
+	refcount_set(&ifq->refs, 1);
 	if (ctx->user) {
 		get_uid(ctx->user);
 		ifq->user = ctx->user;
@@ -714,19 +714,6 @@ static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
 	}
 }
 
-void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
-{
-	struct io_zcrx_ifq *ifq;
-	unsigned long index;
-
-	lockdep_assert_held(&ctx->uring_lock);
-
-	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
-		io_zcrx_scrub(ifq);
-		io_close_queue(ifq);
-	}
-}
-
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
@@ -743,7 +730,10 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 		}
 		if (!ifq)
 			break;
-		io_zcrx_ifq_free(ifq);
+		if (refcount_dec_and_test(&ifq->refs)) {
+			io_zcrx_scrub(ifq);
+			io_zcrx_ifq_free(ifq);
+		}
 	}
 
 	xa_destroy(&ctx->zcrx_ctxs);
@@ -894,15 +884,11 @@ static int io_pp_zc_init(struct page_pool *pp)
 	if (ret)
 		return ret;
 
-	percpu_ref_get(&ifq->ctx->refs);
 	return 0;
 }
 
 static void io_pp_zc_destroy(struct page_pool *pp)
 {
-	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
-
-	percpu_ref_put(&ifq->ctx->refs);
 }
 
 static int io_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 8d828dc9b0e4..5951f127298c 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -39,9 +39,9 @@ struct io_zcrx_area {
 };
 
 struct io_zcrx_ifq {
-	struct io_ring_ctx		*ctx;
 	struct io_zcrx_area		*area;
 	unsigned			niov_shift;
+	refcount_t			refs;
 	struct user_struct		*user;
 	struct mm_struct		*mm_account;
 
@@ -70,7 +70,6 @@ int io_zcrx_return_bufs(struct io_ring_ctx *ctx,
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			 struct io_uring_zcrx_ifq_reg __user *arg);
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx);
-void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx);
 int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 		 struct socket *sock, unsigned int flags,
 		 unsigned issue_flags, unsigned int *len);
@@ -85,9 +84,6 @@ static inline int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 static inline void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 }
-static inline void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
-{
-}
 static inline int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			       struct socket *sock, unsigned int flags,
 			       unsigned issue_flags, unsigned int *len)
-- 
2.47.3


