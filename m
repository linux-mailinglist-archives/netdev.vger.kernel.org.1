Return-Path: <netdev+bounces-238293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B12C5700C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FDA335436D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2B33EB01;
	Thu, 13 Nov 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWVnWJXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51B33E368
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030803; cv=none; b=DXhmbq/b7xkjMKfIzTLjXBxPb9OxdR6lr2WMjvp2XVMStP3maHyHo8U99cKbcecMRsF/03pK4nHWwIxx0T1083ArWV2szncV9tMRhzUgXYmAyxF9n8ACSPBnY/Zs3lOoTQqaLnlGI0LCvjDj+6YfdVpr8thUOBs1JRSHPYteKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030803; c=relaxed/simple;
	bh=81qA4ZUKcISyk/h/kHiInqRUcaxAW8DzjE2dxUhidsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aab0P5s0oyNu25sRk0P4AvGUYhxhmmWTnWkjjLLfkOLXYj4dWy/P/JAcPbRIFiw/6uZkQ1g/edxS8nrEX9DUIwmDwgwJEwrJFrkiAPXVvjw1ILQ8GW8hM0GL3i6XjgSbPu7prE/9BA3kVH7sJhWR5ULIQAtWEwvGXK3pfpFMtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWVnWJXK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so3594025e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030799; x=1763635599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXb2ishPj39E4/z5wHUjvNOMlSVBJJXjzfwe3Bgyjz8=;
        b=KWVnWJXK3n/CrDjquJpn/s0CIhiaceighOfBbTqFXROhPWyCSB1PSwqWD0cJhMMEj3
         rAli1L+ZhzQfOsUQiShr6HgU/OepGH+tz9/BU1MO6B7NrCN6m+MMDMSYZewRFY5ORu4k
         N/LIGVdU+sL8cMXWrnYNZX9g+HEqyDZa7vlBN0KgrtC+9yNpTVbnVfm/Wqk/8EqmoMOx
         XPhjYTfEdDgXu93fwiLJbnEtGLtZ2nTqPREws1AAoe2zovS/wCasYf6a0pizdZQKIyOb
         LaWR1Zg/ZQ1LSbHQPcJ5PQj+0nR/Gy6txI6WRMCU8vJQpjqOAkFvGoqB8e5oq5Dw2lt3
         gomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030799; x=1763635599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXb2ishPj39E4/z5wHUjvNOMlSVBJJXjzfwe3Bgyjz8=;
        b=KTxD+HwPvJhSX+zeaA5Y2K6jBbW5OaThoMGYoeqdEEjANvDDd6Vpdv4MczK8ul5gNO
         p+zXyTBKA0LqRrOWCTjjS7sGO8mW/qbdUu0NS64SDXH+uRr8XFG7RPy7BkUUyZLWCq/E
         wigH6KcrG3TU3hcSMyzEBIZr3wLxq8mRvHu5ugmLsXg8HP3xuazoA2bUcKa88XXhLDLd
         LS8T4DRLXm0zmlQDDjv+X2/c6bTWxg1yTB5MbNdPqfZ4F3hLaTq/dv8rxsK6k6XMQWar
         8oXL/ZPWjOGwqjk+y/cg1lyf4Y9E+7stUS7oSOGT71MaASQcsdKG46TwEnL/TkNcsXEz
         oGeA==
X-Forwarded-Encrypted: i=1; AJvYcCXrfThFyAdYd4vC6w+IYM4POK1LuswTrsCu8+Sxx2qVjc+tUKpAs2HKCONVeLx/bwzWbmwzjZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf9rbr+/hcXOCgjrwgQzV6W6UkzTvg000wcE7rBpIC3o/Ko69
	HSZw3pY6niwTkzBUAjePdXjJhJ97K4fDvZ/z+e/EyJgjDCBa1eXXfsgP
X-Gm-Gg: ASbGnct/nukiZwx/oTna0+IvlkfNJWgZB+y4BapEKGIEYzb1qi1R5fhxuKq+u3KiKIF
	hcWx+QEINLVNyqicnELQm4h+zUF0rCW9oHbTh73sYpVHgFKIzY02NLzcCJ21L+edq3wsni9gZ48
	W42qrunzKVJruUSAnEj3DxmKpKD+KhxKKzavoCTvs7aFsthTG8TgIn9DfWE2Z3ky8EJZ3FYOXw+
	WMWOIfekgFH9QLjwGVcjO6LmqEA9Qxnx2eglQ/WRGD/zNMAWHX6B1R0NQ+P6tAeWw+pDJ/THsU4
	CkvjdhfmSPOP+WBLT8Exyn8VmshkBA+7JhHYWeRnKz0CKu8iC/QOVygdDOLN8F+BxR6P7v9ViF0
	dHUDhpXDbk5e80gw7Abjm1EQzeK+bQyGqxDSBSi8/Bm3tSdbuGI+1qbjySlI=
X-Google-Smtp-Source: AGHT+IGidb4hzqe1cMai/PRO3YYe3yCigLBZkoHC1WZpcYshjDp7qHtVmbRVFtkr8/fSND7/vgx3ZA==
X-Received: by 2002:a05:600c:6298:b0:471:672:3486 with SMTP id 5b1f17b1804b1-4778706edd0mr57111475e9.15.1763030799541;
        Thu, 13 Nov 2025 02:46:39 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:38 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>
Subject: [PATCH 10/10] io_uring/zcrx: share an ifq between rings
Date: Thu, 13 Nov 2025 10:46:18 +0000
Message-ID: <010805428bd2451a94dc3e3bd77af33e573118ca.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <dw@davidwei.uk>

Add a way to share an ifq from a src ring that is real (i.e. bound to a
HW RX queue) with other rings. This is done by passing a new flag
IORING_ZCRX_IFQ_REG_IMPORT in the registration struct
io_uring_zcrx_ifq_reg, alongside the fd of an exported zcrx ifq.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring.h |  4 +++
 io_uring/zcrx.c               | 63 +++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a4acb4a3c4e9..21b8d159f637 100644
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
index da7e556c349e..b99cf2c6670a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -660,6 +660,63 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	return 0;
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
@@ -685,11 +742,13 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
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
2.49.0


