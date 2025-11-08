Return-Path: <netdev+bounces-237014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15958C43328
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C4D3AF66F
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3258E275AF5;
	Sat,  8 Nov 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="L7UPL5ra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7D27978C
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625676; cv=none; b=Nx39wt3wOw6nsFB3VjK0/Qg2mRnNaaYno+kS7e8Y7O1EovHpCmSKBMox0FC9XeGXGX9kcF4PF5+A4/2ByCjAg0b8KRRJnLQ7JXFH7QlJ0v5jptwY6LU5dpVNsqJHY0O9HwI4vKUQNsoFt2//7Ti7sEOkr2S6DRaKNM6efAQOpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625676; c=relaxed/simple;
	bh=QMbgf28t7Wf8iojQhsSnuWgYkc5TK4ZVRXgndF/GowU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPnmg3Mvey6t9sctsF9eN3UiabXN9Mu7pL8RjJsDBiJ/xQWW06mzOZ1JjU6P4OP+VQ8nKoxK66LaJDaAujWF3t1CsnjoNAJ++q19jdMiVBlvQm+oo6NnyqULKMm3D3LdypKo38RzakPbpV7S6CvfZaCvqnOazrwkdq/9mZyaPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=L7UPL5ra; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c51f56f3fdso1379900a34.2
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762625673; x=1763230473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/PdQmrlcLPfoOh3SahN7VasJ5pX5oJY3C7hCi9nQfw=;
        b=L7UPL5rad8kGqn94CPQ8LyxjK7k9SFZPgDT8G+FPyxmPFoR2TTzyC1zUtDIuqusidV
         GlitEA0GFC7rHOqXuNsRaj35ai2SNodlHmbKFTp2cTfPAORcwslDKU/fe2gYkrfWe47c
         steg1v9OMcT8DNPc0JCy0OKLVJFJ67swTR3gKNbgqF2BoY/0i+IVZcBiPs/tweNfjQ5D
         0xvpTo8o4UGUMBHQqFhxJK3vcIpyB/qchg+OV7Zt6D0ch/Lb5Q2S3stDRh12393cuHCI
         Oztqb3Og7sjGH8+kh9RWyfPkDYoVDHAF+imYYuS3YL2m9ftneM/XVHv+8INjF2dLU8Hp
         mBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625673; x=1763230473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/PdQmrlcLPfoOh3SahN7VasJ5pX5oJY3C7hCi9nQfw=;
        b=Uj/35VsdamD5BReYGImjTBejBzIjiEsDTI/hG8gH0VnZmCldP2NnoukOBcfbYFejxQ
         gN1l0efWLjO4DDvEGc9CUbgz+yaltrDMSTpkutpRqjpBh6UrUrv0XVpLsOrgZUxCeBd/
         69Sr0LMim30tDJbWdj097WbKIAmaXIn8A2LKnW/OIr55JPHgu9Erg701ITUwWEeFz4PS
         AWotgA/l+y3fRvEYwLsIWS5qp2VOpU4JUzc52FZ7EWSDIYjK/6dPaTsw+PPo5UajmO+4
         RxtCZf5WujHTVF1Nft2qO/41/GcvHbprFXMVQKvKh/sMUiJo2+xz3v8nIwL+v0ZaIoO0
         qWtA==
X-Forwarded-Encrypted: i=1; AJvYcCXTF93azr22DcWxYzT1o4WUC73RzUsbg3WBRAcLGLUDvs65ELNC7VGtoQz3zj2WhDoSLRZTY4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC1jt0JA5kTI8bWXvQeT0Ajz+qJDNg5ds+01r6GuAJKihLxE8/
	TAdq6TPv9KSd6ZGF/Fv/TRV9J7uYHVCmnj+5n8m9VdEApNGEGilVqh8SXmviJp1gEF4=
X-Gm-Gg: ASbGncs1O6l05JbKEZ0oP42Zvl54ulhkst7pRYoFdLu/emI1l62zINHaeE2c1XKsxNR
	qVaYFCnLyWSc/8hBMspY+ysgJq8A52J5ITUQRkPyExom459iqYEmL8UKw6A2FIwCF8a+CCmFxxv
	uecVdReechHvozpUgJLphpW+uKPREk22dO8uqon0BvXeE7/Mw3vzwCgF3XHvlMa7pLv/3Fp5rPJ
	F+VO6/CmQ15ITXTat2ELaibADeaGynzrcjCZMlku7f2piIzGfCa8W8JlW6cHKgoWw3Ri3oDXnUS
	xux2D9U9Em65fn0DJASNht5wfNJdHoTRAqQB0Xo2SgIL86bPlw9Mg7M38rBnsgXJ+QmcDZJQGnU
	/20gf65WpABjrUkV4RZvmdfx1ym3iYuOo4qjGu4LZEPZqZUYAk4Yg12H2Zby0U4rB5P4R5s9JJx
	1RLuAiQlRD4qMuJ6V3PmyqdAUSktBlYA==
X-Google-Smtp-Source: AGHT+IFkpJmAP6lQuXqOAJ3jQQni9HN1oW5izLgQ0227Q+Wen+0S6Ls5aLGwf8xEgoUMU70zsODDBw==
X-Received: by 2002:a05:6808:218f:b0:438:3b4c:c414 with SMTP id 5614622812f47-4502a1cb142mr1705910b6e.18.1762625673645;
        Sat, 08 Nov 2025 10:14:33 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4500280856fsm3823182b6e.24.2025.11.08.10.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:14:33 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v6 5/5] io_uring/zcrx: share an ifq between rings
Date: Sat,  8 Nov 2025 10:14:23 -0800
Message-ID: <20251108181423.3518005-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251108181423.3518005-1-dw@davidwei.uk>
References: <20251108181423.3518005-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a way to share an ifq from a src ring that is real (i.e. bound to a
HW RX queue) with other rings. This is done by passing a new flag
IORING_ZCRX_IFQ_REG_IMPORT in the registration struct
io_uring_zcrx_ifq_reg, alongside the fd of an exported zcrx ifq.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/uapi/linux/io_uring.h |  4 +++
 io_uring/zcrx.c               | 63 +++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f5dae95bc0a8..49c3ce7f183b 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1067,6 +1067,10 @@ struct io_uring_zcrx_area_reg {
 	__u64	__resv2[2];
 };
 
+enum zcrx_reg_flags {
+	ZCRX_REG_IMPORT	= 1,
+};
+
 /*
  * Argument for IORING_REGISTER_ZCRX_IFQ
  */
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 49990c89ce95..ef6819fc51db 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -651,6 +651,63 @@ static int export_zcrx(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	return fd;
 }
 
+static int import_zcrx(struct io_ring_ctx *ctx,
+		       struct io_uring_zcrx_ifq_reg __user *arg,
+		       struct io_uring_zcrx_ifq_reg *reg)
+{
+	struct io_zcrx_ifq *ifq;
+	struct file *file;
+	int fd, ret;
+	u32 id;
+
+	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
+		return -EINVAL;
+	if (!(ctx->flags & (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED)))
+		return -EINVAL;
+	if (reg->if_rxq || reg->rq_entries || reg->area_ptr || reg->region_ptr)
+		return -EINVAL;
+
+	fd = reg->if_idx;
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	file = fd_file(f);
+	if (file->f_op != &zcrx_box_fops || !file->private_data)
+		return -EBADF;
+
+	ifq = file->private_data;
+	refcount_inc(&ifq->refs);
+	refcount_inc(&ifq->user_refs);
+
+	scoped_guard(mutex, &ctx->mmap_lock) {
+		ret = xa_alloc(&ctx->zcrx_ctxs, &id, NULL, xa_limit_31b, GFP_KERNEL);
+		if (ret)
+			goto err;
+	}
+
+	reg->zcrx_id = id;
+	io_fill_zcrx_offsets(&reg->offsets);
+	if (copy_to_user(arg, reg, sizeof(*reg))) {
+		ret = -EFAULT;
+		goto err_xa_erase;
+	}
+
+	scoped_guard(mutex, &ctx->mmap_lock) {
+		ret = -ENOMEM;
+		if (xa_store(&ctx->zcrx_ctxs, id, ifq, GFP_KERNEL))
+			goto err_xa_erase;
+	}
+
+	return 0;
+err_xa_erase:
+	scoped_guard(mutex, &ctx->mmap_lock)
+		xa_erase(&ctx->zcrx_ctxs, id);
+err:
+	zcrx_unregister(ifq);
+	return ret;
+}
+
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			  struct io_uring_zcrx_ifq_reg __user *arg)
 {
@@ -676,11 +733,13 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
-	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
-		return -EFAULT;
 	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) ||
 	    reg.__resv2 || reg.zcrx_id)
 		return -EINVAL;
+	if (reg.flags & ZCRX_REG_IMPORT)
+		return import_zcrx(ctx, arg, &reg);
+	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
+		return -EFAULT;
 	if (reg.if_rxq == -1 || !reg.rq_entries || reg.flags)
 		return -EINVAL;
 	if (reg.rq_entries > IO_RQ_MAX_ENTRIES) {
-- 
2.47.3


