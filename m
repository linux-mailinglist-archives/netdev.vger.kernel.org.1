Return-Path: <netdev+bounces-235279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C599C2E71C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8084EF1B3
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4731A559;
	Mon,  3 Nov 2025 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="r1Cv1Ge2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA23191AD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213291; cv=none; b=OMdLGNjNB/etThB+XGEOAiAHFnSHEqdHZNbVQqneY59fwBKs/HtqegBeKRdZEMZxC46AwDP8IYqPaQ8hwq61+zdZ3VVcDNNHvAK0/mUHge9U4CIS9TlyeAmkqzo5ISjtbAe9iFia/uoVLnl3U39YLKmE94QpT/d7dUjM6SV0Qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213291; c=relaxed/simple;
	bh=U0ZYXEHXEsTrFhhXuREKpn8yvcDcxKISIDWF4BsAVmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndv/YMUn1Yopk1iJVEDo5agf5cvGizS42KStbgR1BUXC265M+RF5/g7MWJpWkvg/AbnnSutVOilWsYsnu43PIWAKpOti1D/BuPjmaxlGhMJJXv9C0rFkT77SRcxPo7MU9dOEF+uc+vefOHfo2uq5MHWAVV7USk4Ketk6Ofj5f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=r1Cv1Ge2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3c972dec6easo3656474fac.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213289; x=1762818089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTmA5rsVRDDOULatDfSTXyOcAevzV0wASZvMyMVykzE=;
        b=r1Cv1Ge2bk7IY1J32layCDI8AOsV6JuLFDY84r91zroseYgLM+Qnq5D/ZtUg1f/8db
         F7RHM5hb2pEMnYLTqpVsF0EkaetrZToIpCrr4CAeSFA2rNOfA27Vk1xuxnWCV/e6/NYU
         PPN7NfLAKVOSkrcaUXduUL2xGFWxhAYGHp2hKU2aJ3xc1QEF1lHMjI+o40gUph2YLpLX
         k5p2I86psr9Gqv51LxUsWoYV+Wbte4UOUbaZVMcCWjdAiadAkikW6lbIlnaF8vrU5iAB
         qW66w6+TR05dsSIyV7w4EiPjIx+2YFYgSKrENFWL0KeLO/u/IKh20jSbCmelOs9QNixi
         mhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213289; x=1762818089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTmA5rsVRDDOULatDfSTXyOcAevzV0wASZvMyMVykzE=;
        b=dxUaZQKXyUMjp6myl/iqf6JIFMg2IjAmoaXUhXhLcpXs/EiZdj9YVxxfTKxzu0UIJ+
         YNwwTcvNEAvwVEeLFVGE9uLjfz2NS7ABTvwFjzztLDSpFGBpHHhm4Le6ZKqFHVsYoak1
         SF9D3PEUf1Wsx1zxE2Dn02ujUehDk9L2QIY96Q+apZJ3JnMQbTOEr9hYnXrCNj49K+rT
         9VN0C7kEbaGkTFJVE1KeUibn8Mrz3aFgzaYKpwUE8TgpQNI1edryWfVHfqMMFDD+6xR5
         8UyUASBzMkot1PUDy+cWHcIuFi4R8fsg4PfL8QLi2x6GZw1ps62YW67u8FDp1xu/KGNk
         Y65Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOZUfFy8ZF+NZauo3A6itEq6MrYRLfCSfn0fXsdMKtbHP3q9D0n9JBHJrUNSxPJO5RO1gk9VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBkoDiPJJiCt5nRA+c5dmjtjOJxcMcMY9UCUytC+nl2y4mKDz
	mOv1+1QnSkbea6ZdNj+vM+O/WbVj7KCnQCbDw50Itffcfb5dGBl1bHg7TSc3V1v45Po=
X-Gm-Gg: ASbGncvwLd2OeWG4z+qwD7KGbnPK6Bl9dOOReu6Su9F2LKcLrm+F4GkCw35DO2d2MZ8
	6fQRVYUyxAP5DFXDFNlFIrSMDgr+LFnvZtXQXwgrBPKM/UMTATFrafHmSoEv74ZMbDYbPKgY4Gd
	suPZmP9Nmo4FCl5eaayBm2nE86jMNHdC91yZ9/E3ipp/s9DerEArRpQxhnWixKSD/LEff7I0qoG
	oJIsp60A8Ne/fgPm6D8a/6KBBcst5bPUSViZ96luAysQHqBHuIh/Lg9PVMHxNPpmfeQLxqarZET
	m6/RzKLncJXpjUCul44micSsHqBB2KBEBA5zlon57BHM83msb/Zz2a1tVPLJIf6IoAPEq65Zz47
	PmNFgJDPLpPq64jwBJAhnjofOzIxI3opUiNncQ+S4o8hB3afPaufiETM5dnD3t6JIg/EyEMWGJ9
	GFW8YJkNWjrDQzGsERIejf/2tkUCbm
X-Google-Smtp-Source: AGHT+IEZmEv9zbPEz/npMP5dJmCkfcJ7WhnZZqdXqwCw3LP++yZGNkqR0P8i7IURJvU2QZ0BTB2WkA==
X-Received: by 2002:a05:6870:cc84:b0:344:a994:2ad4 with SMTP id 586e51a60fabf-3dacd10ca2dmr6075029fac.20.1762213288786;
        Mon, 03 Nov 2025 15:41:28 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff521394esm519107fac.9.2025.11.03.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:28 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 08/12] io_uring/zcrx: move io_unregister_zcrx_ifqs() down
Date: Mon,  3 Nov 2025 15:41:06 -0800
Message-ID: <20251103234110.127790-9-dw@davidwei.uk>
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

In preparation for removing the ref on ctx->refs held by an ifq and
removing io_shutdown_zcrx_ifqs(), move io_unregister_zcrx_ifqs() down
such that it can call io_zcrx_scrub().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index dcf5297c0330..bb5cc6ec5b9b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -681,28 +681,6 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	return ret;
 }
 
-void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
-{
-	struct io_zcrx_ifq *ifq;
-
-	lockdep_assert_held(&ctx->uring_lock);
-
-	while (1) {
-		scoped_guard(mutex, &ctx->mmap_lock) {
-			unsigned long id = 0;
-
-			ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
-			if (ifq)
-				xa_erase(&ctx->zcrx_ctxs, id);
-		}
-		if (!ifq)
-			break;
-		io_zcrx_ifq_free(ifq);
-	}
-
-	xa_destroy(&ctx->zcrx_ctxs);
-}
-
 static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 {
 	unsigned niov_idx;
@@ -768,6 +746,28 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 	}
 }
 
+void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
+{
+	struct io_zcrx_ifq *ifq;
+
+	lockdep_assert_held(&ctx->uring_lock);
+
+	while (1) {
+		scoped_guard(mutex, &ctx->mmap_lock) {
+			unsigned long id = 0;
+
+			ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
+			if (ifq)
+				xa_erase(&ctx->zcrx_ctxs, id);
+		}
+		if (!ifq)
+			break;
+		io_zcrx_ifq_free(ifq);
+	}
+
+	xa_destroy(&ctx->zcrx_ctxs);
+}
+
 static inline u32 io_zcrx_rqring_entries(struct io_zcrx_ifq *ifq)
 {
 	u32 entries;
-- 
2.47.3


