Return-Path: <netdev+bounces-232926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746CC09F0C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F081B26211
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFC3054EE;
	Sat, 25 Oct 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="H3LJdNdK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA272D481F
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419714; cv=none; b=NbPcND8yT19zAgJtySMzu+b8KEwOBeGtW912NF3WZ7SrQSciVQa7oGPtj2bqzBWGpCLjKZVi6g/mHm6mib4u17skkmDNOHfDV+51SjI59Fiph7OIX16V2G+Rh2lNVD/Byh/7yRDs4IBYpWWZ2n5scxB/TN0Q10D3sG8tT6XZ208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419714; c=relaxed/simple;
	bh=qUT88k04TtiGmgEuMnwQRr8knEBK/P3H3YijIBSs3Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRYXMFqKV45b7/pkIAWb9AipJBQlnYlmYbX4tzBo/uEu4x+7gzGhKEbIMubdPD2ZhV3zuCesXzf20BZ9YPxvC5wXANgcBzLq9THtHoGxFdfbNQ/llpwZCZG0gscCyQF7GzCEYAc6Z/qyBhdDUqJSNDxMAA/EP9QNKk3PTUzhYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=H3LJdNdK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f935f7d14so1339721b6e.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761419712; x=1762024512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9UaKz+G9gYr1eZsyVRK+FYNTjIwCQnZpOwbbwcqlNY=;
        b=H3LJdNdKJO+zQ3tqffgcCZa1UUOG7UVJvcjqO96WVg1xlGNL7+7fq55aC0TqYt2qF1
         I+tw9n5+hLLK5eEtkg/L1PQwZLzWD49dneDREqhf0GWrkFA3ZTLw8M0338dJ7HhAtTFL
         GVj2tZX9xagBSLDVTOUb+5gjOr/4cbenHKuKmzfUUlASRYWY263o3fMiBWKZsLHLs2ef
         xtVwqyrp7aqpYr9n4AFAXnYmL31jTMY4YOsPnzfxX6c6GzdjPsi0Ps+67ZyMvkY6C30O
         KgKVcfItwTEoX+dLSabn/Ka+4Y0z7qGYaTwR7qxFJX9lhdHHmWhNQcIAInNXCNv2Xkf+
         t3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419712; x=1762024512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9UaKz+G9gYr1eZsyVRK+FYNTjIwCQnZpOwbbwcqlNY=;
        b=B3CC2cVRBC/Am39C2P5Dt5LwzQ5TmGZfniFjfAIrdVrrnLohgqCy2joLDyvKTpH/WF
         rm+uk47OC5CJP6viCytwxmOdA3i72yYb6ugnFUO8graCW8lY9cKSw13zAEgqMa6Zghh8
         Yy7QkT2j9Y+RtvlP5aBX0LsKPhqSvsBCrb0suVSk6W2YumMrOOADGqPvccGMnCfBoECH
         2oQv9U+9+8pI9OpPRyRgnLWmpIbSeMFP0AJcyUpb0MbgbRpC7MMvveDUIExCDFvvE6MR
         43/bHgX/QSTj5A3tm+EfVKYVArDTkzanUcbOfeYs2nh35XgmUUG7BxBi8quTXkbBXQr3
         B+WA==
X-Forwarded-Encrypted: i=1; AJvYcCV0QEv9mTqrOJ7ammYsUUsrRf364T7wEQIksWZJlr/8TNAR0AZYwuhm9g8N1UnTYYJy89BWnio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMYdtboef9qanv3ZNsOIvjhagU+gL+WYfHPqwT6wU7o8sA60R
	lwAXN9UvtSeKrUAmlh1QWUQQ5mtCSAO3rgEC/QGKd5BlObdxNLkcf+TBXOuTkpYXWwE=
X-Gm-Gg: ASbGncsIZH42mrW/STrK03HmwbgD26+BoErJAlvXFh3onFfEY80HxMqHeMbjHCeb5mp
	AzbZuwZc08/8otamzQYXUKzLbTonMnToKnFLwWNAZYh/0lOQtva5KHfQ5xmLjf2Xa8WU1d0SF31
	K7pA48UcJFPAPFGw9bFaJHJOtsnKXY+fptq3vhVslXy11ChK/F3qK0LsFhM21NaaoQJuSDS++Nt
	nnVllSzodnn5mkAtwjItHxaTDNGRt0OYxGUdNsNUOxXqPvHQxG4Z6+n4JSvhSGncWxVFhySuYKL
	Y1N89MufC1MqoXYSqQXxu9/mkO97C/pu53xOtGX0VeRu7ZE9MBfrMgwqluW/C+KzvfUOqXi/pcv
	T+1g7zmJvMHAEZmsANdz4fzwbB9KOsU1LxjPE3bfR5g+4pBhTs13t5gVeSdjEq6WzPz3PLagOvF
	57SHdy+rLw+AihfP/0bn28o6j2Xajw
X-Google-Smtp-Source: AGHT+IF4zBK/2r5KkaO29cjT+RW4obQ9KQ0UlYObpX4dW4J3s66nJE8fIvKJwOPuqxPgUFI41hMTRQ==
X-Received: by 2002:a05:6808:1b0d:b0:441:8f74:fce with SMTP id 5614622812f47-443a30be2bdmr14439909b6e.59.1761419711853;
        Sat, 25 Oct 2025 12:15:11 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3ebc7ffsm647989b6e.22.2025.10.25.12.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:15:11 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/5] io_uring/rsrc: rename and export io_lock_two_rings()
Date: Sat, 25 Oct 2025 12:15:00 -0700
Message-ID: <20251025191504.3024224-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251025191504.3024224-1-dw@davidwei.uk>
References: <20251025191504.3024224-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename lock_two_rings() to io_lock_two_rings() and export. This will be
used when registering a src ifq owned by one ring as a proxy in another
ring. During this process both rings need to be locked in a
deterministic order, similar to the current user io_clone_buffers().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/rsrc.c | 4 ++--
 io_uring/rsrc.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..d245b7592eee 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1148,7 +1148,7 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 }
 
 /* Lock two rings at once. The rings must be different! */
-static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
+void io_lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
 	if (ctx1 > ctx2)
 		swap(ctx1, ctx2);
@@ -1299,7 +1299,7 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
 	src_ctx = file->private_data;
 	if (src_ctx != ctx) {
 		mutex_unlock(&ctx->uring_lock);
-		lock_two_rings(ctx, src_ctx);
+		io_lock_two_rings(ctx, src_ctx);
 
 		if (src_ctx->submitter_task &&
 		    src_ctx->submitter_task != current) {
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index a3ca6ba66596..b002c4a5a8cd 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -70,6 +70,7 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
+void io_lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2);
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
 int io_sqe_buffers_unregister(struct io_ring_ctx *ctx);
 int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
-- 
2.47.3


