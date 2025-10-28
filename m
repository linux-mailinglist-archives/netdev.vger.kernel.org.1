Return-Path: <netdev+bounces-233614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9AC164F0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C227B506608
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C534DCF5;
	Tue, 28 Oct 2025 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CnNVs5c0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06334DCE0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673609; cv=none; b=pD57uu9TWryKymEZktoO3e+Qc2Zz7q8PnVlRMiePY/iHnDSsA4ImFv7d2z4j84S2ZOUTtRz9ydlvDh0golVl24DsdS6UjvMtyYiU/ZnfdpuEL6W/4mkknQb17FJtRunkrlOoze37vYnnVEeARvX6gQzHKlxfeHXjoncyql3GQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673609; c=relaxed/simple;
	bh=q7BK9iktocfJYm+/WotXGKhxxS+aD37j96cH6TGbOE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUEmYWOriQXxUMY0JFlDdWoX/TvOYGez1IHWvw3tzje4AJ93b9ci0YuoueVa3+r/gYollR7VbCeUbj0NT0Xs63iNs1emx0vReacuW6UN1zmvt+aL8abniZ19+lIjf+VVmUaet7xyPXjYR39MLBJacUCdpWNCGn5mXIgreK2cilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CnNVs5c0; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-654ee606fb5so1068764eaf.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761673606; x=1762278406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPop6mvsum5XsgmkruquoYcW5M+7CiBgtUqQPcfMIkw=;
        b=CnNVs5c0oD/qgvJ02FNy6Rq9glzcgakgrjtiMzrU/0n3Aizce5qCjKQ17nhQl+7pZf
         m5ytfpE19QGyBO06jK8aWhnlf6EATgnBmKpwy1vtsBbyIx3rXyLg3nnOzRoR37soOxC+
         rri6CtI2eOWytVFZj3k92gjAtd9Pi4gptGoPjUM2Uac4T5VnbGeBYC7lFkTmVVELQTZS
         vHSrdhVNM+FFkXECnTip86Gq+/08oVzZDgJsKBU8K8uxJm6HN4ClU0kVyuds73zJru1w
         kzSVjp6aJ2n801DhmXboMjaJuMjoLjN3fCGBMsQ5bBBS0uSmEZoHY25lNmFunh1s1ESZ
         sK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673606; x=1762278406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPop6mvsum5XsgmkruquoYcW5M+7CiBgtUqQPcfMIkw=;
        b=rOC+/GvzfbBqovRc4Vsl1HDefpGNtumvh3TXmdKTRUfW+7crXNjXOjPW6WsFK9Ehah
         AgbcUPYmVOP73oHqJp4CCLIQ6ief/kgbC4mphmhixM7Vgm4lUvr7xz+6ebHzmF+IsNFf
         J4Okyopq/UUg+kNHaj5diud/boZpIjYDaSHkkvlhz3JiSq8i4XLxyxW1wD3OrMUp1L+L
         RcdPX0fvGO7ARETdtf3BRSqVJ7oVIekZx2mac/WPLsJzFU5YULCkNcx+alBtEnDhNscW
         IV2qaILI5GK84KXHZNxyI1LHFOIFWfD+2TTdlS3xaEg68w7MVqDPoTSKyis+ap0RUPPr
         ERCA==
X-Forwarded-Encrypted: i=1; AJvYcCWkrF0XVYVnyvPwLqrAxB/YnChhcSF7VzlfoOrBjlaeEooXSXSdE0/kjNEJEuKtQY9Xb2E4Mbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmnel3dtwHBUGi+H5RNruwefhOL2yxDC7ogwq0sLmYHzASXA2
	Q4TJbxit+JPEUGSSxVlA8LUMbNMh3RbnUue6VQY2fr8gP3sSIW11YgMdQal0EW56pcM=
X-Gm-Gg: ASbGncsE5XFy6sq/uEMCn10/n9imgso3kl00KZnNyekLWvewfwVoHKHUKGxbJj9GeJG
	44HkrOOg402S88+DkSOV1UEK7Pnib7eX6fds7uQ3mrNe/YCVJC4bXhFjeaOzQJHx8bStnNzaQTQ
	ckWwktpCVMnP4VVGWTDwenEszZrXwJpocW8hOJp4oUF98WajNwPsFXUR7B7DQKxDNfSOP3zBjTH
	LrWJQa8KSS+ziXj2kQE4LmKrWVXoNiaR+XSNMSaGpU+7KHgT3GldYQuXhs33NvNRXcs6XE+A7Jx
	YIT+w10YRi3ZMc5RWQ+SFbVzu3cYHp7ZVaiLrwIRcj5eVtV58qdDzeisT3I6IcDVClJP+LCRS3J
	Lto2HPh2ZmlDma/wrJpQgzRBpeb9SvGvwM/Ooi6Ag+jYdQuqJLCo1bGadt/w8KDulQm1a+3/2qj
	x6AlQsczbDhvKJUv84XA==
X-Google-Smtp-Source: AGHT+IFWG45zJ7ER1ckvPb72NF7zpRT49ujYDdYnols7g2aonGmmDiVw/IxJpRGK0LdQpUE0XKftdg==
X-Received: by 2002:a05:6870:32d4:b0:345:862b:7190 with SMTP id 586e51a60fabf-3d74609eebamr127515fac.18.1761673605915;
        Tue, 28 Oct 2025 10:46:45 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5302222a1sm3388773a34.31.2025.10.28.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:46:45 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 5/8] io_uring/zcrx: add user_struct and mm_struct to io_zcrx_ifq
Date: Tue, 28 Oct 2025 10:46:36 -0700
Message-ID: <20251028174639.1244592-6-dw@davidwei.uk>
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

In preparation for removing ifq->ctx and making ifq lifetime independent
of ring ctx, add user_struct and mm_struct to io_zcrx_ifq.

In the ifq cleanup path, these are the only fields used from the main
ring ctx to do accounting. Taking a copy in the ifq allows ifq->ctx to
be removed later, including the ctx->refs held by the ifq.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 24 ++++++++++++++++++------
 io_uring/zcrx.h |  2 ++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 5c90404283ff..774efbce8cb6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -200,7 +200,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	}
 
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
-	ret = io_account_mem(ifq->ctx->user, ifq->ctx->mm_account, mem->account_pages);
+	ret = io_account_mem(ifq->user, ifq->mm_account, mem->account_pages);
 	if (ret < 0)
 		mem->account_pages = 0;
 
@@ -344,7 +344,8 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 	atomic_inc(io_get_user_counter(niov));
 }
 
-static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
+static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
+				 struct io_zcrx_ifq *ifq,
 				 struct io_uring_zcrx_ifq_reg *reg,
 				 struct io_uring_region_desc *rd,
 				 u32 id)
@@ -362,7 +363,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
 
-	ret = io_create_region(ifq->ctx, &ifq->region, rd, mmap_offset);
+	ret = io_create_region(ctx, &ifq->region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 
@@ -378,7 +379,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 
 static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 {
-	io_free_region(ifq->ctx->user, &ifq->region);
+	io_free_region(ifq->user, &ifq->region);
 	ifq->rq_ring = NULL;
 	ifq->rqes = NULL;
 }
@@ -390,7 +391,7 @@ static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
-		io_unaccount_mem(area->ifq->ctx->user, area->ifq->ctx->mm_account,
+		io_unaccount_mem(ifq->user, ifq->mm_account,
 				 area->mem.account_pages);
 
 	kvfree(area->freelist);
@@ -525,6 +526,9 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 
 	if (ifq->area)
 		io_zcrx_free_area(ifq, ifq->area);
+	free_uid(ifq->user);
+	if (ifq->mm_account)
+		mmdrop(ifq->mm_account);
 	if (ifq->dev)
 		put_device(ifq->dev);
 
@@ -588,6 +592,14 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	ifq = io_zcrx_ifq_alloc(ctx);
 	if (!ifq)
 		return -ENOMEM;
+	if (ctx->user) {
+		get_uid(ctx->user);
+		ifq->user = ctx->user;
+	}
+	if (ctx->mm_account) {
+		mmgrab(ctx->mm_account);
+		ifq->mm_account = ctx->mm_account;
+	}
 	ifq->rq_entries = reg.rq_entries;
 
 	scoped_guard(mutex, &ctx->mmap_lock) {
@@ -597,7 +609,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			goto ifq_free;
 	}
 
-	ret = io_allocate_rbuf_ring(ifq, &reg, &rd, id);
+	ret = io_allocate_rbuf_ring(ctx, ifq, &reg, &rd, id);
 	if (ret)
 		goto err;
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 33ef61503092..8d828dc9b0e4 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -42,6 +42,8 @@ struct io_zcrx_ifq {
 	struct io_ring_ctx		*ctx;
 	struct io_zcrx_area		*area;
 	unsigned			niov_shift;
+	struct user_struct		*user;
+	struct mm_struct		*mm_account;
 
 	spinlock_t			rq_lock ____cacheline_aligned_in_smp;
 	struct io_uring			*rq_ring;
-- 
2.47.3


