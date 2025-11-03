Return-Path: <netdev+bounces-235275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78505C2E729
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18333B189E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7761330C345;
	Mon,  3 Nov 2025 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="f1SDq2Mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19F30F811
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213285; cv=none; b=Ty+8CxKeH8l3av5BBai+5nqgpqvIoc8cDk+I5kWIsblQBHDXWJ4LaRqJa8dH/RCNsP74lTIgwo7Fc+elmuMGj4cYwDAWVtenoacUWj5F84ftAhB1YD/xkH6vjXm5gtWn9aaPRMhG4jVEF/wzT7HJNNaTxT6RTmULWRPfLt1lF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213285; c=relaxed/simple;
	bh=cij3JfZSebcavYoRUNFPRPXocMaEZhSOcjX+XKhNma8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ly7Rz82wn1Aw0KgDeAoZblX3nAWxtnRet1FdjeGUhyWjesexd7D1+5XPh+30lDNzHlM9bk5PzWNrKlmhGa5KqTSccrarpYE0fFNjGwcxn+2JxJ2PVMD81mefImRtFdYLEdEdA2IsapDzcoe6wIUVxc/L2xUqndDQBv/2kWkDPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=f1SDq2Mu; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-44f6c663452so837973b6e.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213283; x=1762818083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YWddLlJnGbk94Nk0hqlQLruN6wB0BuFH4VlwqE/AOQ=;
        b=f1SDq2MuxmlM1uEWhcx7E/b6z6/b11va0ZN8Z+2pwxCMTrpPyEwrfneEVvPSgbtk+N
         9PBRUNkBH3f5vSqSFFDAzBCl/y7lRwqlumA+ZuuFkBvWrk4c87S0uZS5xYGbCWuTFDvv
         hPHhsWXiRd/Sbv21dtjJ1vlEfA11aEifyNDDzi+UxM2NjDucVXIbU/PCWtjeISOFv4Kk
         K0lJhYVNIX/9h9ynqwHFDoPLhO2Vk6Sr3KrhE2HXaJghCz7QObKJ2bFaDbCKHhCdgaBU
         0iL4rN5IAgZuLvqwCaKV0QDkYChSoaGodNIRkED5SqKIYLEVmm8oDncUGFMi6FjP5R3z
         LqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213283; x=1762818083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YWddLlJnGbk94Nk0hqlQLruN6wB0BuFH4VlwqE/AOQ=;
        b=QmggAERawRBnk5EXWi9RMtBB0iLLzbFFCLDfxiXilydwr6SGaTbYOSSYm+3rrA0MkV
         L8qoKjaH+aWrwLbyofKd34J0xI/Zv/vo8I/wYISwceRY9reyGVbVN2IBe/fsAXc8XgqT
         T6W2nSIBv4R43Roc9snvdJJby+q+rOxFeFla3/2qRfkQsJtvs9HynMnYVYSOjBErIehm
         XRl+TMhNTHfTfq4x9oMBO/mRUu6NGPenKhYxSjxgULU05Ec0FU/GNVKyDwMGwl2VD9HZ
         H47qJlQ0kPRVy+wpQW51jbeUG0tCYqjntYko/vhlfS5xH4fxkHYieH5cFKHNOCC/f8NG
         wnRw==
X-Forwarded-Encrypted: i=1; AJvYcCW6vruTc8pwR/Q4t8z2Y4BbP7djpHxK6xfa5SXmpVhbR05DLe6gMh0D1/deQM+rHSXFYncN/Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKmjgI7nppSH9v1/4u23oXnXtheMXF5bBwfSW6D/uFtlLxhbY
	7/lxsqzb8IHJSXVgqpsnJDgbDRPN+KTNFnxo+lfyN8qBfjQvtFk3pDmCwtUyVp76L+E=
X-Gm-Gg: ASbGncvKR+AmXXiMFNpPcyEdCWYuVMxmrH5Q9MCOCcjvLrxulDuKVOjHbXG6oLCwj/F
	V0ycAfTuExgNSeI+1pBHPK/HTQEvBlKl5RtN/xnC4edEKM+32XTGHolpW0K7P6uB1hiBTZpI7AM
	xQf2yLib7VUgkQVZNUxkO47ZIo4bHKY4ELHDPHyquPEujRlKr8Z3KwnESbLtHk6QhV+vfVQM60t
	H0BAtwSdziNDLvsMyuuk8YYTEswr8b8mPwQ/Qc0QBeelDoRMbw2VxFnjkpVFRUwNuuvFGMod8zQ
	FuADKzw7hHUxfOrXUNlOFxwJsPVaTwJmhc4oKxv2qj6DmiDmWB+LDoetFNSMsqohQHNwvUUMP7Q
	TT6E27d4QNCbndgsjxwQunRvVQ3m7MsA2lHh2126eK3P09Gz0v6OWB6SYareBRsJ/1f6Q3LWxb+
	uLc22hTI08p8pj0LaCqw==
X-Google-Smtp-Source: AGHT+IHSHSCqdEnDMpr8ZgDJmVe/TTylgEGMIpPhaOvEceZTr5OdT2OAceFmeqc82OVr7dr4mEmjrA==
X-Received: by 2002:a05:6808:13cc:b0:441:8f74:fd6 with SMTP id 5614622812f47-44f960728c7mr7085135b6e.67.1762213282940;
        Mon, 03 Nov 2025 15:41:22 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff796bdf8sm521687fac.21.2025.11.03.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:22 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 04/12] io_uring/memmap: refactor io_free_region() to take user_struct param
Date: Mon,  3 Nov 2025 15:41:02 -0800
Message-ID: <20251103234110.127790-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103234110.127790-1-dw@davidwei.uk>
References: <20251103234110.127790-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor io_free_region() to take user_struct directly, instead of
accessing it from the ring ctx.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/io_uring.c | 6 +++---
 io_uring/kbuf.c     | 4 ++--
 io_uring/memmap.c   | 8 ++++----
 io_uring/memmap.h   | 2 +-
 io_uring/register.c | 6 +++---
 io_uring/zcrx.c     | 2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 200b6c4bb2cc..7d42748774f8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2798,8 +2798,8 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 
 static void io_rings_free(struct io_ring_ctx *ctx)
 {
-	io_free_region(ctx, &ctx->sq_region);
-	io_free_region(ctx, &ctx->ring_region);
+	io_free_region(ctx->user, &ctx->sq_region);
+	io_free_region(ctx->user, &ctx->ring_region);
 	ctx->rings = NULL;
 	ctx->sq_sqes = NULL;
 }
@@ -2884,7 +2884,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_eventfd_unregister(ctx);
 	io_free_alloc_caches(ctx);
 	io_destroy_buffers(ctx);
-	io_free_region(ctx, &ctx->param_region);
+	io_free_region(ctx->user, &ctx->param_region);
 	mutex_unlock(&ctx->uring_lock);
 	if (ctx->sq_creds)
 		put_cred(ctx->sq_creds);
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index c034c90396bc..8a329556f8df 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -428,7 +428,7 @@ static int io_remove_buffers_legacy(struct io_ring_ctx *ctx,
 static void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
 {
 	if (bl->flags & IOBL_BUF_RING)
-		io_free_region(ctx, &bl->region);
+		io_free_region(ctx->user, &bl->region);
 	else
 		io_remove_buffers_legacy(ctx, bl, -1U);
 
@@ -672,7 +672,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	io_buffer_add_list(ctx, bl, reg.bgid);
 	return 0;
 fail:
-	io_free_region(ctx, &bl->region);
+	io_free_region(ctx->user, &bl->region);
 	kfree(bl);
 	return ret;
 }
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index d1318079c337..b1054fe94568 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -88,7 +88,7 @@ enum {
 	IO_REGION_F_SINGLE_REF			= 4,
 };
 
-void io_free_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr)
+void io_free_region(struct user_struct *user, struct io_mapped_region *mr)
 {
 	if (mr->pages) {
 		long nr_refs = mr->nr_pages;
@@ -105,8 +105,8 @@ void io_free_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr)
 	}
 	if ((mr->flags & IO_REGION_F_VMAP) && mr->ptr)
 		vunmap(mr->ptr);
-	if (mr->nr_pages && ctx->user)
-		__io_unaccount_mem(ctx->user, mr->nr_pages);
+	if (mr->nr_pages && user)
+		__io_unaccount_mem(user, mr->nr_pages);
 
 	memset(mr, 0, sizeof(*mr));
 }
@@ -228,7 +228,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		goto out_free;
 	return 0;
 out_free:
-	io_free_region(ctx, mr);
+	io_free_region(ctx->user, mr);
 	return ret;
 }
 
diff --git a/io_uring/memmap.h b/io_uring/memmap.h
index 58002976e0c3..a7c476f499d5 100644
--- a/io_uring/memmap.h
+++ b/io_uring/memmap.h
@@ -16,7 +16,7 @@ unsigned long io_uring_get_unmapped_area(struct file *file, unsigned long addr,
 					 unsigned long flags);
 int io_uring_mmap(struct file *file, struct vm_area_struct *vma);
 
-void io_free_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr);
+void io_free_region(struct user_struct *user, struct io_mapped_region *mr);
 int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset);
diff --git a/io_uring/register.c b/io_uring/register.c
index 38b20a7a34db..244d523d1bad 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -381,8 +381,8 @@ struct io_ring_ctx_rings {
 static void io_register_free_rings(struct io_ring_ctx *ctx,
 				   struct io_ring_ctx_rings *r)
 {
-	io_free_region(ctx, &r->sq_region);
-	io_free_region(ctx, &r->ring_region);
+	io_free_region(ctx->user, &r->sq_region);
+	io_free_region(ctx->user, &r->ring_region);
 }
 
 #define swap_old(ctx, o, n, field)		\
@@ -604,7 +604,7 @@ static int io_register_mem_region(struct io_ring_ctx *ctx, void __user *uarg)
 	if (ret)
 		return ret;
 	if (copy_to_user(rd_uptr, &rd, sizeof(rd))) {
-		io_free_region(ctx, &region);
+		io_free_region(ctx->user, &region);
 		return -EFAULT;
 	}
 
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3e9d8333a301..ec0a76b4f199 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -378,7 +378,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 
 static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 {
-	io_free_region(ifq->ctx, &ifq->region);
+	io_free_region(ifq->ctx->user, &ifq->region);
 	ifq->rq_ring = NULL;
 	ifq->rqes = NULL;
 }
-- 
2.47.3


