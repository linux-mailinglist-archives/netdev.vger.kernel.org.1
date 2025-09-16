Return-Path: <netdev+bounces-223584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D4B59A62
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0F9165ADF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405CB316904;
	Tue, 16 Sep 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqeYwyX2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3A341AAF
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032826; cv=none; b=j2JHDG+D65n5yJy75QlS/YHwA9kkCsFcVYONwI6JFu/AfQc3llpIxqXz+mFQ+goejAE1wnCas2yNVYR5vChIFljJON7nbJuiME6/SDsCFvexpNIBvow01Xtep36enZyw/P09t3FzlenYPF7bMHpagkXmOjeL82rwvjg424mfiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032826; c=relaxed/simple;
	bh=iinGFBa0f/ZjZC7fy9Ef65MX6zbo7oJPvjgfie94zkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc6/xUiVIHkY0q5/a40AaI3nVq0Ly0HRfE3hkPa7znxk4MDiLzyslsuoJMQc7UkFHThO2vR1zvTYXwyRhNAqIm+8QB5op3ATj19dwm52/u5ZUd2W2JcA5F3PnUDApLW2pgv8gX5BA7S5Fd/ViyTKb9mkPGRO89NNalSGeQ3gtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqeYwyX2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so3843482f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032822; x=1758637622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkLeh7Yi6azWfUAR/2SDFDynvs/1Q4+v/9gxkr7PCwc=;
        b=kqeYwyX2D1qhiPmLzSIdUZCrK84rWVSO+nuDVF5yASI2Y+b5KOcVb8wzfqxSoABe+L
         ZHYMfb5qNmSvMw7qIh/WLGQ4KfHkL02iowtCNyBQQxa6KNLKBZP0iKNwNkohq0j5SBR3
         Vb99bt44AFDtjKqXTalUqAf6Q379/2Rzmwh4JB0HtHICLF9LUNFz9W/GfbtuvqlDz3Tj
         1qFQz+JDg3I6l6aPtuFp9uzTuE0j/Rb22ISMBnNKW1f/8B0uNAUCJcBz0vq/pIYHNYCb
         rMxEoflKhotUKvsEx3f4pgm3y3ZsVLwsSeyQleNos5kEk7ARCbu0xksLvwLVm/8jLzwg
         MmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032822; x=1758637622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkLeh7Yi6azWfUAR/2SDFDynvs/1Q4+v/9gxkr7PCwc=;
        b=doJ+w7suHU73CoC7joi7AsTHfD9d2onSqq4jsYoxDTJYHDeAowpIyqhG/BfU3hQlO2
         lY1Hn2BFVozAFiWpsaejn+1pW3Q2KY+yaotBs52BjLQaZefDucoXlYMEug6Q2VxKxeM6
         PirdLv7oEeX87hq8knlIYp9vQKFfszUIqggo6LC/e7r59sqk5g9qJ/TPJKEipJSg4cGe
         cquiCjGAxYRGcqdlVEW0uEhfLj+OEQheOU5fu51+ik22+0qQIQ3zEw8EcpnclYQUHSQP
         2H9TsRSt861uD7MZsJ17WwXGEZK0Eo8Vw38gzHwsnZR5tX1zfEP3seaEBErdsDLgOafN
         n46w==
X-Forwarded-Encrypted: i=1; AJvYcCW7nc9U58C3sIpwBFZCkkrxxTGqEyai9twHGV1mYvN8F06SAmkbEYErihg/uLXhW3aRqTpQtiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3kWkVbC7L90A/udWG3c7Ut0Uafd5Bk/o0nkED2994kHlmBpa
	8D6wqMnLvjkddAWndNHYUsYmZOSutte6SgHBRYCnQx8HOq2tqi7fUPpE5PWtnQ==
X-Gm-Gg: ASbGncujiEShPw+Zbu6dnzAN7BulU7tN03jAMx1PF9OJt2UKVQ0Yb13ou6l9AtWfexm
	Pka0cqJF7ukguVzDFlgxQpFgbm5WfRxx57w0KuJWOJMnrF8w+OGACYO8dR1ilBzS8g9Zz/h60ih
	TXS7yB1xdj/BowETTsdUb1873S9iU4ABBykKSPNQR4fwlw2d8mbiUiXUwistDwEHYNQv2I6IgNE
	BCc2IV1rFmHejAzoHqsdYx80PYqjuF0o4HL6vCZ8EdG4EBT8Yd4gzA9lQ0g9siFAL7o2kTqHmFv
	la2X6QUVIbVz3sn9RVdmtBSf1V6XnCGIdYEDFwcYDlbW7w7emo38WRN2s0dH5Y4QMae2c1kehCj
	qokmpjA==
X-Google-Smtp-Source: AGHT+IEQvkPg0+Aevos57+7df/wuMjvsQ6U3uoBomKJGB06J6wAQQQekZBntx+AeL34+hNi8fErjNA==
X-Received: by 2002:a05:6000:4028:b0:3ea:bed8:7043 with SMTP id ffacd0b85a97d-3eabed874c4mr5750824f8f.7.1758032822343;
        Tue, 16 Sep 2025 07:27:02 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:27:01 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 12/20] io_uring/zcrx: make niov size variable
Date: Tue, 16 Sep 2025 15:27:55 +0100
Message-ID: <5d29fc35107408e1d23d4d9e853cccc4e270b0f1.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using PAGE_SIZE for the niov size add a niov_shift field to
ifq, and patch up all important places. Copy fallback still assumes
PAGE_SIZE, so it'll be wasting some memory for now.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 30 ++++++++++++++++++++----------
 io_uring/zcrx.h |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 764723bf04d6..85832f60d68a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -45,15 +45,18 @@ static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *nio
 static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+	unsigned niov_pages_shift;
 
 	lockdep_assert(!area->mem.is_dmabuf);
 
-	return area->mem.pages[net_iov_idx(niov)];
+	niov_pages_shift = area->ifq->niov_shift - PAGE_SHIFT;
+	return area->mem.pages[net_iov_idx(niov) << niov_pages_shift];
 }
 
 static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
+	unsigned niov_size = 1U << ifq->niov_shift;
 	struct sg_table *sgt = area->mem.sgt;
 	struct scatterlist *sg;
 	unsigned i, niov_idx = 0;
@@ -62,13 +65,16 @@ static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 		dma_addr_t dma = sg_dma_address(sg);
 		unsigned long sg_len = sg_dma_len(sg);
 
+		if (WARN_ON_ONCE(sg_len % niov_size))
+			return -EINVAL;
+
 		while (sg_len && niov_idx < area->nia.num_niovs) {
 			struct net_iov *niov = &area->nia.niovs[niov_idx];
 
 			if (net_mp_niov_set_dma_addr(niov, dma))
 				return -EFAULT;
-			sg_len -= PAGE_SIZE;
-			dma += PAGE_SIZE;
+			sg_len -= niov_size;
+			dma += niov_size;
 			niov_idx++;
 		}
 	}
@@ -284,18 +290,21 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 	return ret;
 }
 
-static void io_zcrx_sync_for_device(const struct page_pool *pool,
+static void io_zcrx_sync_for_device(struct page_pool *pool,
 				    struct net_iov *niov)
 {
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 	dma_addr_t dma_addr;
 
+	unsigned niov_size;
+
 	if (!dma_dev_need_sync(pool->p.dev))
 		return;
 
+	niov_size = 1U << io_pp_to_ifq(pool)->niov_shift;
 	dma_addr = page_pool_get_dma_addr_netmem(net_iov_to_netmem(niov));
 	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
-				     PAGE_SIZE, pool->p.dma_dir);
+				     niov_size, pool->p.dma_dir);
 #endif
 }
 
@@ -413,7 +422,8 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (ret)
 		goto err;
 
-	nr_iovs = area->mem.size >> PAGE_SHIFT;
+	ifq->niov_shift = PAGE_SHIFT;
+	nr_iovs = area->mem.size >> ifq->niov_shift;
 	area->nia.num_niovs = nr_iovs;
 
 	ret = -ENOMEM;
@@ -764,7 +774,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		unsigned niov_idx, area_idx;
 
 		area_idx = rqe->off >> IORING_ZCRX_AREA_SHIFT;
-		niov_idx = (rqe->off & ~IORING_ZCRX_AREA_MASK) >> PAGE_SHIFT;
+		niov_idx = (rqe->off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
 
 		if (unlikely(rqe->__pad || area_idx))
 			continue;
@@ -854,8 +864,8 @@ static int io_pp_zc_init(struct page_pool *pp)
 		return -EINVAL;
 	if (WARN_ON_ONCE(!pp->dma_map))
 		return -EOPNOTSUPP;
-	if (pp->p.order != 0)
-		return -EOPNOTSUPP;
+	if (pp->p.order + PAGE_SHIFT != ifq->niov_shift)
+		return -EINVAL;
 	if (pp->p.dma_dir != DMA_FROM_DEVICE)
 		return -EOPNOTSUPP;
 
@@ -930,7 +940,7 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 		cqe->flags |= IORING_CQE_F_32;
 
 	area = io_zcrx_iov_to_area(niov);
-	offset = off + (net_iov_idx(niov) << PAGE_SHIFT);
+	offset = off + (net_iov_idx(niov) << ifq->niov_shift);
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
 	rcqe->off = offset + ((u64)area->area_id << IORING_ZCRX_AREA_SHIFT);
 	rcqe->__pad = 0;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 27d7cf28a04e..7604f1f85ccb 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -41,6 +41,7 @@ struct io_zcrx_area {
 struct io_zcrx_ifq {
 	struct io_ring_ctx		*ctx;
 	struct io_zcrx_area		*area;
+	unsigned			niov_shift;
 
 	spinlock_t			rq_lock ____cacheline_aligned_in_smp;
 	struct io_uring			*rq_ring;
-- 
2.49.0


