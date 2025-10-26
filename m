Return-Path: <netdev+bounces-233012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0BFC0AF11
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79B29349D0F
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E092BE034;
	Sun, 26 Oct 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fGozCyt+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62157265CA7
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500082; cv=none; b=SoSH8OP7vnIG68mp0ryV9LUkYqSQ+61KZvIBQ0Vf0aC820yEnwc29tLFOok5HVgU/VaRlS2YC4x7nYh8low7lErakwYgmSwEzbD7Potsbwhfr7FkSNaVGtGru1BxMYeOvt4j2ieGav2gkbvi60IqfwUwnZ7w3yn+Z1/QFxfTy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500082; c=relaxed/simple;
	bh=3msrC7wKLE1fNhAfPoK49/RjZR2yrgIFIEWuPP2fclw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny2Qgz1kPOdM+6BdELnMNGyuyJNZEzVJYrbqh6zClj+XOWuvWkM3YAwcdwU/AWxZJnIUDGeHF5BIW9HFuKZmtT8asUZRkVcUw6t7A2yl7mISlGjjb5gmm+sbCF8InFnAY8bwHb09hCp7o96AF9ZmQKu4JkXkqA+Njgy6VhLTuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fGozCyt+; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-654ed784e42so910522eaf.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761500080; x=1762104880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErqQh0QvNJHpIGphYroejBW3nZy/6TpoE1gV1gS9Shc=;
        b=fGozCyt+tBa9ASg5sY4+U7HX5MsWUQQKy1dEB2AmGHMA788IMACPYtVHyW1oNf2jQL
         kEHrVxNCNYfn8YuQewPbvNHJ5YPeU14PWPcfMfW1HhEXgrqADZVRwh71uKA7K+wjVqX+
         Ym9xbBn7ZIBIm8lfg/EUKwn6COvenAHdc3alLpeFwlmXEbCjDBN/8JXPjy/JNcn2Mfsy
         JvpuA+61Xf28BES3Qd7BApNwQrxOpNdgNE3gg5jvKonaUwBV7i1lBPvLG/ITGXjrttHv
         NfYU19YHbFjnvIzeNs7PBk1mfi7bTbDseYqenJXmt5Sg4P7XbGTKc2+dlx333o4B4v3C
         Apvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500080; x=1762104880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErqQh0QvNJHpIGphYroejBW3nZy/6TpoE1gV1gS9Shc=;
        b=s1sjuPER6BnbgnAOMRLfIt4JmPiibvim2zHFBObZGlzp6C/hZV7zlpG5AA7mXVELsd
         b2B/LmMuN2ttTSrZ29k1dMOkaq5QyLT43jEXVhaN7GrTVtuoVeaDWw/Z1Bb+wFtj3j2X
         xt81t3aTiTnmwRqGWLHSqEbuQAyF5ficYEjbQ6KtrkkrO9LQkvckdpU/b9hzPUt7HHOR
         O2n6C2qyjUEMKhuAfIx4XS5kEyShll00yuZzBzdTYHfurbA07HaG+exjk+Rz8LABKlYV
         CmRPalVgj/6tZAODbfiUnPWZSMzWK091w4Pwyb39KFwhKLKn/+lN/3dfoSSwESAAdrij
         zrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCd7jHtxiT/GL8d8YghVhyvYUe7xkdgbB3ttti/abZeB9F5rJYBVCJZIYxI6AZud3xLiKeS3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR99Syk4rr0OlmO27QjQa54CUDoGmGkfYa9qVN58F1i3aCC2ym
	hUzbVcpgZ4t2Xi8S1NHF3i6lYRwfYaiUczJu/ekD4jThXtLDW0HQyJP0y9kvputne2w=
X-Gm-Gg: ASbGncvyUCVVPwHajKEQFWGWIqEzM07+tCZtC0KgiiWZbrP0djN7hznEwqrwSlb+Hcq
	zHOlnKVcSo3Ra6OeOKxM4zZSqHoK04TAo26kM3144LD28C/6eqqXTLS9d0ytiDOnew+IhUBpRld
	+eMIpUTCy/MhlyA0vg0da67kyKa1vNpiIIPV3zm2Bg17kOg5+ZtuVlE8TnW0iV3+aq0Cx187Ukt
	4jx5aZ4Mjd+d1HLyuf3+2Gko9BtgNFfI3ScZY8IyJfZLZZFxAfO6VyDLlahXK2Ev7S5vGtc6OLU
	zscD4AIgj/KLbQ0RX2XXGGkgtPbADqVP5n3423HFU3TWCB5NPMHOTnXdIHz7SI/lMUJvnA4mmaH
	N+4Ndza+GUhf4m3yNMIpM6WY86yohsxEnpjSJwwmaY2pdVwYEFgpTkDLP9G4H93g2/5nWlI+ltc
	422Wl/cB9UV7V9gEsJhUnzOb3+NuvaX+Je27xtB0Y=
X-Google-Smtp-Source: AGHT+IHIEQXjYginCIgzLoh/5t5cMHYYwahxi0vlB5OWPpEEsAUWMu4sNYl7yJ7szNIKVgqTgLo0yg==
X-Received: by 2002:a05:6808:21a0:b0:44d:a64f:6782 with SMTP id 5614622812f47-44da64f6dc2mr2203709b6e.30.1761500080433;
        Sun, 26 Oct 2025 10:34:40 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef283b0asm1257882eaf.4.2025.10.26.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:34:40 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v3 3/3] io_uring/zcrx: share an ifq between rings
Date: Sun, 26 Oct 2025 10:34:34 -0700
Message-ID: <20251026173434.3669748-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026173434.3669748-1-dw@davidwei.uk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a way to share an ifq from a src ring that is real i.e. bound to a
HW RX queue with other rings. This is done by passing a new flag
IORING_ZCRX_IFQ_REG_SHARE in the registration struct
io_uring_zcrx_ifq_reg, alongside the fd of the src ring and the ifq id
to be shared.

To prevent the src ring or ifq from being cleaned up or freed while
there are still shared ifqs, take the appropriate refs on the src ring
(ctx->refs) and src ifq (ifq->refs).

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/uapi/linux/io_uring.h |  4 ++
 io_uring/zcrx.c               | 74 ++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 04797a9b76bc..4da4552a4215 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1063,6 +1063,10 @@ struct io_uring_zcrx_area_reg {
 	__u64	__resv2[2];
 };
 
+enum io_uring_zcrx_ifq_reg_flags {
+	IORING_ZCRX_IFQ_REG_SHARE	= 1,
+};
+
 /*
  * Argument for IORING_REGISTER_ZCRX_IFQ
  */
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 569cc0338acb..7418c959390a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -22,10 +22,10 @@
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
-#include "kbuf.h"
 #include "memmap.h"
 #include "zcrx.h"
 #include "rsrc.h"
+#include "register.h"
 
 #define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
 
@@ -541,6 +541,67 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
 	return ifq ? &ifq->region : NULL;
 }
 
+static int io_share_zcrx_ifq(struct io_ring_ctx *ctx,
+			     struct io_uring_zcrx_ifq_reg __user *arg,
+			     struct io_uring_zcrx_ifq_reg *reg)
+{
+	struct io_ring_ctx *src_ctx;
+	struct io_zcrx_ifq *src_ifq;
+	struct file *file;
+	int src_fd, ret;
+	u32 src_id, id;
+
+	src_fd = reg->if_idx;
+	src_id = reg->if_rxq;
+
+	file = io_uring_register_get_file(src_fd, false);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	src_ctx = file->private_data;
+	if (src_ctx == ctx)
+		return -EBADFD;
+
+	mutex_unlock(&ctx->uring_lock);
+	io_lock_two_rings(ctx, src_ctx);
+
+	ret = -EINVAL;
+	src_ifq = xa_load(&src_ctx->zcrx_ctxs, src_id);
+	if (!src_ifq)
+		goto err_unlock;
+
+	percpu_ref_get(&src_ctx->refs);
+	refcount_inc(&src_ifq->refs);
+
+	scoped_guard(mutex, &ctx->mmap_lock) {
+		ret = xa_alloc(&ctx->zcrx_ctxs, &id, NULL, xa_limit_31b, GFP_KERNEL);
+		if (ret)
+			goto err_unlock;
+
+		ret = -ENOMEM;
+		if (xa_store(&ctx->zcrx_ctxs, id, src_ifq, GFP_KERNEL)) {
+			xa_erase(&ctx->zcrx_ctxs, id);
+			goto err_unlock;
+		}
+	}
+
+	reg->zcrx_id = id;
+	if (copy_to_user(arg, reg, sizeof(*reg))) {
+		ret = -EFAULT;
+		goto err;
+	}
+	mutex_unlock(&src_ctx->uring_lock);
+	fput(file);
+	return 0;
+err:
+	scoped_guard(mutex, &ctx->mmap_lock)
+		xa_erase(&ctx->zcrx_ctxs, id);
+err_unlock:
+	mutex_unlock(&src_ctx->uring_lock);
+	fput(file);
+	return ret;
+}
+
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			  struct io_uring_zcrx_ifq_reg __user *arg)
 {
@@ -566,6 +627,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
+	if (reg.flags & IORING_ZCRX_IFQ_REG_SHARE)
+		return io_share_zcrx_ifq(ctx, arg, &reg);
 	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
 		return -EFAULT;
 	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) ||
@@ -663,7 +726,7 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 			if (ifq)
 				xa_erase(&ctx->zcrx_ctxs, id);
 		}
-		if (!ifq)
+		if (!ifq || ctx != ifq->ctx)
 			break;
 		io_zcrx_ifq_free(ifq);
 	}
@@ -734,6 +797,13 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 		if (xa_get_mark(&ctx->zcrx_ctxs, index, XA_MARK_0))
 			continue;
 
+		/*
+		 * Only shared ifqs want to put ctx->refs on the owning ifq
+		 * ring. This matches the get in io_share_zcrx_ifq().
+		 */
+		if (ctx != ifq->ctx)
+			percpu_ref_put(&ifq->ctx->refs);
+
 		/* Safe to clean up from any ring. */
 		if (refcount_dec_and_test(&ifq->refs)) {
 			io_zcrx_scrub(ifq);
-- 
2.47.3


