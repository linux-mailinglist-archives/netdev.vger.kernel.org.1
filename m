Return-Path: <netdev+bounces-166617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A07A3697E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3BA7A23B7
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45157179BF;
	Sat, 15 Feb 2025 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="w+WpDSfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB8DF60
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578204; cv=none; b=k0u0B7dhqfrJzqdFLh4u3j+0haQr4xlXGFl0Xc4DFzd6SEGNZrFM2/WB6hXl6PebY0J6ElMSgZVg4Uj2obNtcC6PwPmnl6uPJ1q16NP7ctjhCwiBGVLX50HRf8oc6pPVK06IRazJa0MN+EFoUzjqrA9KSOJ7EQj3RAzT8KtRvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578204; c=relaxed/simple;
	bh=xV+HbjoPZhjUAGGHGU8YbI0mz3uuDMqf8qpq252dPvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlXlfykKDFU9Uz9GyAReSla27RgbODYIswCYxvOrbiJ1ufpSnVy9DB1ndGscLG+z+jv55Ud9XelhpZ70etySD+xyC7JQJc5vSP2PWz0mORBpgDYACkWNQIjvYZYekCZJWmcvl1JX7riVrgYEJbmGxpAG+J5JJ1RwW479zyiuJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=w+WpDSfH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f61b01630so59820535ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739578202; x=1740183002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayGmHinChkh4euhmmLNAbFxNHBewzdvRepp7HKsmfMg=;
        b=w+WpDSfHoXl68xFW8BquntvFpXPeGGr0CE43sCjhb76kRGukvQwPuPJJMJpRaSEdCG
         d4a2W9Yhcvxb6YxFb0r/EabPwC2dWPEAv8x4MwukuqicudgbOzsNRlJzhdKcMARWQG/m
         MKwfz0iJtpSnzyzRRpJ756Ivlw0nMtu6p/eKymCJxNSu4QVC1mSzFWyr0q+FeM7QFYnY
         CAE+9+YqcqSLNOt6ifaEOBj4oQJxbnoZ8bJYrmpmlq3apX6QA3i0KtmT5WofbPzWMMIe
         L7g2OhvVPGFXDQ6mo+5SpwjU/o4Yq7ke9CSbwuPLDzDX/SQBxmXyNopY4a1R8fxn00oW
         YQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578202; x=1740183002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayGmHinChkh4euhmmLNAbFxNHBewzdvRepp7HKsmfMg=;
        b=AZVQksltCxz9ydxQshJ6pp315pckrJdCI0x/pBzyjLHYZr2qzlFxFwEKmKyHJd7fJ5
         4785xgYg7N/ZSaEEfebfj/McIjHyVh4IV3O5/4J1c5J169pZfAH4AmGO1DlVR7al9ZV7
         gIau+Jq/wzkpFJcysWG8V10VwWeuEWA7IgfyG73sfQQtS7Mob0moW19vIrBoh2Zzo8XW
         +2b8b6bMk205OPwnH+eTOyx0MF9D3FuJFx+FH+HAIrDzMLpLVnyrJFjjhQVzfMl/CqfT
         zVDV9E+7GJkfSdHkxP7RGOFzXtKhiPWxKR5KjGS4bXxJ7uLkt+tvYDjgAdlU4nGAqK0J
         hLBw==
X-Forwarded-Encrypted: i=1; AJvYcCXYldnCijSNd4tJGNoKiGvZZ7GJ0JSm+8ZsJa+aXF0GhF28AgRSI6925GlStIipALJ09syjuJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsG1pPOzq9D2h+jhqSZsdGKAr2EJMpivl235DCrpusZZ4aF/g
	/sueEESsORtG6qTyqIzh18lB8ZhCTg/UTUfaX4/aXUANwotzgx5gqKQc2U48jFQ=
X-Gm-Gg: ASbGncsxsOjkkVr1I1Ax89S5M/MGn8iidnL49w7clQsNSCv8NHU8eKqdQzZqNLVCS5I
	gBCwnmEzNn0ar2sv9UOuQy6AxzNk4BolMenui7izwqBHX9tjQwuitgL7yrrVe+52LFdH/cDXVXp
	X0QVRs+tBI1IKo/OxTWwRkFV0jmgs+tsjwV6gcxvltA0RcudX0CpmsIYFsq9aRXYJbNbD9wEckM
	XCYGmASQx0pwltTJz39YIEvUan0tgryebGCuaujmyC0zXwm/A58yY4hYCZgHR91oz8xJ6s4HyBX
X-Google-Smtp-Source: AGHT+IHVx0wjxAiXmdCr0Fn7Fi85LqJv6+vxgpdoI89LKMlUUCt/oZixCJVVOa0VWBe6546UoRSrdw==
X-Received: by 2002:a05:6a20:2584:b0:1e1:a449:ff71 with SMTP id adf61e73a8af0-1ee8d67ef96mr1645068637.1.1739578201719;
        Fri, 14 Feb 2025 16:10:01 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324f64a39asm2160299b3a.69.2025.02.14.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:10:01 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	lizetao <lizetao1@huawei.com>
Subject: [PATCH v14 02/11] io_uring/zcrx: add io_zcrx_area
Date: Fri, 14 Feb 2025 16:09:37 -0800
Message-ID: <20250215000947.789731-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250215000947.789731-1-dw@davidwei.uk>
References: <20250215000947.789731-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io_zcrx_area that represents a region of userspace memory that is
used for zero copy. During ifq registration, userspace passes in the
uaddr and len of userspace memory, which is then pinned by the kernel.
Each net_iov is mapped to one of these pages.

The freelist is a spinlock protected list that keeps track of all the
net_iovs/pages that aren't used.

For now, there is only one area per ifq and area registration happens
implicitly as part of ifq registration. There is no API for
adding/removing areas yet. The struct for area registration is there for
future extensibility once we support multiple areas and TCP devmem.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/uapi/linux/io_uring.h |  9 ++++
 io_uring/rsrc.c               |  2 +-
 io_uring/rsrc.h               |  1 +
 io_uring/zcrx.c               | 89 ++++++++++++++++++++++++++++++++++-
 io_uring/zcrx.h               | 16 +++++++
 5 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6a1632d0fba1..44844707d327 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -981,6 +981,15 @@ struct io_uring_zcrx_offsets {
 	__u64	__resv[2];
 };
 
+struct io_uring_zcrx_area_reg {
+	__u64	addr;
+	__u64	len;
+	__u64	rq_area_token;
+	__u32	flags;
+	__u32	__resv1;
+	__u64	__resv2[2];
+};
+
 /*
  * Argument for IORING_REGISTER_ZCRX_IFQ
  */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index af39b69eb4fd..20b884c84e55 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -77,7 +77,7 @@ static int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
 	return 0;
 }
 
-static int io_buffer_validate(struct iovec *iov)
+int io_buffer_validate(struct iovec *iov)
 {
 	unsigned long tmp, acct_len = iov->iov_len + (PAGE_SIZE - 1);
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 190f7ee45de9..0f8c20246a74 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -68,6 +68,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 			    unsigned size, unsigned type);
 int io_register_rsrc(struct io_ring_ctx *ctx, void __user *arg,
 			unsigned int size, unsigned int type);
+int io_buffer_validate(struct iovec *iov);
 
 bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 			      struct io_imu_folio_data *data);
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f3ace7e8264d..04883a3ae80c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -10,6 +10,7 @@
 #include "kbuf.h"
 #include "memmap.h"
 #include "zcrx.h"
+#include "rsrc.h"
 
 #define IO_RQ_MAX_ENTRIES		32768
 
@@ -44,6 +45,79 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 	ifq->rqes = NULL;
 }
 
+static void io_zcrx_free_area(struct io_zcrx_area *area)
+{
+	kvfree(area->freelist);
+	kvfree(area->nia.niovs);
+	if (area->pages) {
+		unpin_user_pages(area->pages, area->nia.num_niovs);
+		kvfree(area->pages);
+	}
+	kfree(area);
+}
+
+static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+			       struct io_zcrx_area **res,
+			       struct io_uring_zcrx_area_reg *area_reg)
+{
+	struct io_zcrx_area *area;
+	int i, ret, nr_pages;
+	struct iovec iov;
+
+	if (area_reg->flags || area_reg->rq_area_token)
+		return -EINVAL;
+	if (area_reg->__resv1 || area_reg->__resv2[0] || area_reg->__resv2[1])
+		return -EINVAL;
+	if (area_reg->addr & ~PAGE_MASK || area_reg->len & ~PAGE_MASK)
+		return -EINVAL;
+
+	iov.iov_base = u64_to_user_ptr(area_reg->addr);
+	iov.iov_len = area_reg->len;
+	ret = io_buffer_validate(&iov);
+	if (ret)
+		return ret;
+
+	ret = -ENOMEM;
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
+	if (!area)
+		goto err;
+
+	area->pages = io_pin_pages((unsigned long)area_reg->addr, area_reg->len,
+				   &nr_pages);
+	if (IS_ERR(area->pages)) {
+		ret = PTR_ERR(area->pages);
+		area->pages = NULL;
+		goto err;
+	}
+	area->nia.num_niovs = nr_pages;
+
+	area->nia.niovs = kvmalloc_array(nr_pages, sizeof(area->nia.niovs[0]),
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!area->nia.niovs)
+		goto err;
+
+	area->freelist = kvmalloc_array(nr_pages, sizeof(area->freelist[0]),
+					GFP_KERNEL | __GFP_ZERO);
+	if (!area->freelist)
+		goto err;
+
+	for (i = 0; i < nr_pages; i++)
+		area->freelist[i] = i;
+
+	area->free_count = nr_pages;
+	area->ifq = ifq;
+	/* we're only supporting one area per ifq for now */
+	area->area_id = 0;
+	area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
+	spin_lock_init(&area->freelist_lock);
+	*res = area;
+	return 0;
+err:
+	if (area)
+		io_zcrx_free_area(area);
+	return ret;
+}
+
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
@@ -59,6 +133,9 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
+	if (ifq->area)
+		io_zcrx_free_area(ifq->area);
+
 	io_free_rbuf_ring(ifq);
 	kfree(ifq);
 }
@@ -66,6 +143,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			  struct io_uring_zcrx_ifq_reg __user *arg)
 {
+	struct io_uring_zcrx_area_reg area;
 	struct io_uring_zcrx_ifq_reg reg;
 	struct io_uring_region_desc rd;
 	struct io_zcrx_ifq *ifq;
@@ -99,7 +177,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	reg.rq_entries = roundup_pow_of_two(reg.rq_entries);
 
-	if (!reg.area_ptr)
+	if (copy_from_user(&area, u64_to_user_ptr(reg.area_ptr), sizeof(area)))
 		return -EFAULT;
 
 	ifq = io_zcrx_ifq_alloc(ctx);
@@ -110,6 +188,10 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
+	ret = io_zcrx_create_area(ifq, &ifq->area, &area);
+	if (ret)
+		goto err;
+
 	ifq->rq_entries = reg.rq_entries;
 	ifq->if_rxq = reg.if_rxq;
 
@@ -122,7 +204,10 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		ret = -EFAULT;
 		goto err;
 	}
-
+	if (copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
+		ret = -EFAULT;
+		goto err;
+	}
 	ctx->ifq = ifq;
 	return 0;
 err:
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 58e4ab6c6083..53fd94b65b38 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -3,9 +3,25 @@
 #define IOU_ZC_RX_H
 
 #include <linux/io_uring_types.h>
+#include <net/page_pool/types.h>
+
+struct io_zcrx_area {
+	struct net_iov_area	nia;
+	struct io_zcrx_ifq	*ifq;
+
+	u16			area_id;
+	struct page		**pages;
+
+	/* freelist */
+	spinlock_t		freelist_lock ____cacheline_aligned_in_smp;
+	u32			free_count;
+	u32			*freelist;
+};
 
 struct io_zcrx_ifq {
 	struct io_ring_ctx		*ctx;
+	struct io_zcrx_area		*area;
+
 	struct io_uring			*rq_ring;
 	struct io_uring_zcrx_rqe	*rqes;
 	u32				rq_entries;
-- 
2.43.5


