Return-Path: <netdev+bounces-235276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AFC2E734
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978603BA3CB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196E30CD8A;
	Mon,  3 Nov 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fS0dqLql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FB30E855
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213287; cv=none; b=HHNmianSgBfPkcARO4tS8ULEEDsh8UbeCxR15kq59waHP/j/19nAkxnC3aOkqUVfAuTsdRBaT4k7FGQTQTQFe8S2iyIWnIWS2eQN67ODgXh+pWJBLEpM48mOQkI99GrmkO8JQjihW+qN4RJR4VTVUnnToD7wCIFLg6C4QCImuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213287; c=relaxed/simple;
	bh=P+5GnNMT90O6UeRe6i0ljyQYv36MaDXJxMkhwF7LEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqBGvDpV3DtCDpFsPXH5MqB0e9CVDih+M0I4wprvdu42ljkioMgAep1SmsOeH0sT4TN+VuAo+YawUav6hDIqNkBONlCMkTRIugFZsKVoAold2P/CjjCpioSTGvGpSvo0xWnSrDeRjlDrMkUlyb0XQsDPkRWhicV23rd+iXmjNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fS0dqLql; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65043e595a8so2423487eaf.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213285; x=1762818085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q40vB7kCqmdilUB0dvDzCxv6iw86KfavrfdQYR4MxNI=;
        b=fS0dqLql0z7/VZzPKps1YTu3Ns26r6OdCfQabbAqyuy83DB8Q8ZTzWtL1BVMco/Djp
         LZhOt7NWIzii6ScXuc9yzMc2+r4O30bCxmNPj0m7wSV+28BfVigaOmnMyT/qDi7f6vW9
         FlibMu6rmRx3TI6zjx2dHuaM2rXpVpEmKoPYJkBouxPnabbQ5dVyjlBRRYyUOoG7WFhS
         S5Pje5S9MJhidWGebuH0JUEgNaFswgIuKM5hSvsXjIuaCM6JCaXn/93m3pdeIO0OYlHe
         rC9ltyoLNzSGAblcfjrwGedkR99akR+h4FBUaSIpQ+0P5suoKj3B2JeSO/hPegns++KX
         qgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213285; x=1762818085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q40vB7kCqmdilUB0dvDzCxv6iw86KfavrfdQYR4MxNI=;
        b=i5yDjZxmU6Bz1jw70Zai3qGIfC5KfKowwXvy2TEEJeoUZ36D6ugvZiK7H0dgWfwe11
         4cuVEzNTT66AUmi6U1D1CZKqRKjdEbi3yE7s5BDgeGB2dc8bLxp0oK5xwAPsoYYdUahw
         xlkCK9QdBsr9GowqBGspzcMvY7JXrUsgT0IEXg2rW9/5jK2CLOB+Qg7IE/bnjNVqOP+z
         sZ4AdC+ELJmq0WMWB7v0w//F5LXNB26mT4wwQNatKfAi+Kuy3W0pzhVm4DbGKU7SUug+
         zyvmGoNnmo5F5mCZ86/2Xe1G38Afz0FQvHAR1uG069yKm3K/Tmnx2vYx3QcOsdh/ySna
         GoHA==
X-Forwarded-Encrypted: i=1; AJvYcCXiYtkDqMzxMleRVKIGsholxPwYgq+FocG8kx0Toj2UMGyzI4TxC3Lm1W+flPpZjWzqJ6TFXZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTijjy/ZZIEUDcH5hDtzP1+jAVQhxMQCn4wz7XKOwuKRi1xZsH
	7PuBger8ZnbA/cTmKpCHArOb6Zjvt+FTSyyTFMB2/3uO3qeeIfSzCnqDPmJzLEHn1YI=
X-Gm-Gg: ASbGncuMtMZgK4UxoQdNeh9gcXlGDkYcenHUmH6WnifJ6qKYIxcE8Gi9WfeMAvb5A54
	ycjQ49heAz7BYMFsChWElGC9tU5R4BG3ETNIKk88ZA7EQlqY8vbL4+mv2A7aRtez0Aj+7ulT92/
	OkgNEr4jNL/U54+ATLW/KZ2VeDn+F8kTJK0zwCi0M5a2rb1ZN12c8ov+r5VdKGWTrtquPRFqZJK
	CvWzDKv+1XoF5FuIM55tNkUAhB2aHkj23cwzazSEnE1R9wCOtqEw85ilvyqBmhr2WMMBVzCo3Eq
	LNeNCcuqPJk/sHxj3HRfdQJJq0FDZco+YXiWzLBVsxJPuqECN377jqzIMd2/ykzI0wSx1wioxN6
	647fx6L9VBiLYptg1skiUbeC2/bFCSzUHcqBkHU6HbY2tdLrdr9UyQhhv/D3ZsWZeaEkIYcEb3p
	mfcrtVtY+0oC6vFkbs/A==
X-Google-Smtp-Source: AGHT+IG0BMLhsVTBv+cN/07Os4rshmF+lhWl4UgqLIf1FGZ0EbG7qnPbFzUIu0wfvFoZ6qBCb7Vobg==
X-Received: by 2002:a05:6820:22a5:b0:654:f9a7:76dc with SMTP id 006d021491bc7-6568a6c89b0mr6426854eaf.4.1762213284849;
        Mon, 03 Nov 2025 15:41:24 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656ad292d31sm468988eaf.8.2025.11.03.15.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:24 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 05/12] io_uring/rsrc: refactor io_{un}account_mem() to take {user,mm}_struct param
Date: Mon,  3 Nov 2025 15:41:03 -0800
Message-ID: <20251103234110.127790-6-dw@davidwei.uk>
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

Refactor io_{un}account_mem() to take user_struct and mm_struct
directly, instead of accessing it from the ring ctx.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/rsrc.c | 26 ++++++++++++++------------
 io_uring/rsrc.h |  6 ++++--
 io_uring/zcrx.c |  5 +++--
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..59135fe84082 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -56,27 +56,29 @@ int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 	return 0;
 }
 
-void io_unaccount_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
+void io_unaccount_mem(struct user_struct *user, struct mm_struct *mm_account,
+		      unsigned long nr_pages)
 {
-	if (ctx->user)
-		__io_unaccount_mem(ctx->user, nr_pages);
+	if (user)
+		__io_unaccount_mem(user, nr_pages);
 
-	if (ctx->mm_account)
-		atomic64_sub(nr_pages, &ctx->mm_account->pinned_vm);
+	if (mm_account)
+		atomic64_sub(nr_pages, &mm_account->pinned_vm);
 }
 
-int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
+int io_account_mem(struct user_struct *user, struct mm_struct *mm_account,
+		   unsigned long nr_pages)
 {
 	int ret;
 
-	if (ctx->user) {
-		ret = __io_account_mem(ctx->user, nr_pages);
+	if (user) {
+		ret = __io_account_mem(user, nr_pages);
 		if (ret)
 			return ret;
 	}
 
-	if (ctx->mm_account)
-		atomic64_add(nr_pages, &ctx->mm_account->pinned_vm);
+	if (mm_account)
+		atomic64_add(nr_pages, &mm_account->pinned_vm);
 
 	return 0;
 }
@@ -145,7 +147,7 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 	}
 
 	if (imu->acct_pages)
-		io_unaccount_mem(ctx, imu->acct_pages);
+		io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pages);
 	imu->release(imu->priv);
 	io_free_imu(ctx, imu);
 }
@@ -684,7 +686,7 @@ static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
 	if (!imu->acct_pages)
 		return 0;
 
-	ret = io_account_mem(ctx, imu->acct_pages);
+	ret = io_account_mem(ctx->user, ctx->mm_account, imu->acct_pages);
 	if (ret)
 		imu->acct_pages = 0;
 	return ret;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index a3ca6ba66596..d603f6a47f5e 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -120,8 +120,10 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags);
 int io_files_update_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages);
-int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages);
-void io_unaccount_mem(struct io_ring_ctx *ctx, unsigned long nr_pages);
+int io_account_mem(struct user_struct *user, struct mm_struct *mm_account,
+		   unsigned long nr_pages);
+void io_unaccount_mem(struct user_struct *user, struct mm_struct *mm_account,
+		      unsigned long nr_pages);
 
 static inline void __io_unaccount_mem(struct user_struct *user,
 				      unsigned long nr_pages)
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index ec0a76b4f199..ac9abfd54799 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -200,7 +200,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	}
 
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
-	ret = io_account_mem(ifq->ctx, mem->account_pages);
+	ret = io_account_mem(ifq->ctx->user, ifq->ctx->mm_account, mem->account_pages);
 	if (ret < 0)
 		mem->account_pages = 0;
 
@@ -389,7 +389,8 @@ static void io_zcrx_free_area(struct io_zcrx_area *area)
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
-		io_unaccount_mem(area->ifq->ctx, area->mem.account_pages);
+		io_unaccount_mem(area->ifq->ctx->user, area->ifq->ctx->mm_account,
+				 area->mem.account_pages);
 
 	kvfree(area->freelist);
 	kvfree(area->nia.niovs);
-- 
2.47.3


