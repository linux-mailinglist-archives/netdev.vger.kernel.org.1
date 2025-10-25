Return-Path: <netdev+bounces-232930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7A0C09F24
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C911B261F5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F43081A0;
	Sat, 25 Oct 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nZBwgih5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E93054FB
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419719; cv=none; b=Q569osSkRWOXX67SazkBagkEg0eEyjfKXZkccapfAqoOlXb62n83iyHWVqjHrcTDBZbnbJXgicSAF6MsxQ6SEWnuMRWrsc2A21wDYY3YmoBeo2SaIIxh9P+/ffVVw/iW+BcaaE5ZZS4E9dPITuXVviQ7bBEtRcidyA7E6SEOQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419719; c=relaxed/simple;
	bh=ZW6bozi3w/Cky59/kbBbCU0OOnIfkPc0jv6oLF/8+bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A29xdDuHhDm8pVbaDs8oZV/u+AhLjpFVkgY34/5HTHOzeGVeRVitdKHr7VzxgdM8Qa3zsrk3FXGGKp0H06OtdxuIm3xOu/I9LnrAzHsw0T5FFlB3X75GlBKhMsuh95vdn2421NHlfDcr8HZLtEH7bSKpyrCbSJ9rSPTy+rLfE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nZBwgih5; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-44dad158d96so119655b6e.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761419716; x=1762024516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLa5qdPvWx3yrv1sI+ZjPXmKy3SRoZdmJA4LPsTUzpw=;
        b=nZBwgih5msIthV00eGNySe6oj0dpdB/raeHHr6M1bbYsNsudk0l0wgmQYSpnFOK3fD
         PBNSBbG2g7OfeQG0xhXbYBevAvQlChBFbg50JytPsN+1oZgwcJ0KvfcA12pgBZlKIHq2
         WJPim7r5h6TPAk9yFOw1xUD+eEWEnqjh7fVFXbK0UoTjLpjBJsM2GqkpA8h797ftMZ3U
         7A7RaLXUpY2QiLGDBl0lx5xlZzsThcDi13Y+Xx4QtIO5BcPkkfoFN/3CA/ATKFzC+3Pp
         pzfNpjCfEXNSfMBEiCpVW44AfPC7MKp7FnNWrMCH0kZENXZ3uEnLbqgfd1InJCCuLLqv
         GQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419716; x=1762024516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLa5qdPvWx3yrv1sI+ZjPXmKy3SRoZdmJA4LPsTUzpw=;
        b=d3qNiSd7jRcUUTAw1rfgv7hiOEf+MAdjjB3V8th5stzwoZYoDjM4mQGKl2gdN88XXB
         sapAr2JSgTuE4Xt/Mgnn4AAAIAw/alUdoX/YhihZmXOsTL12jCCbG698/0/MWJwim1Tb
         qhL6TfU31qa2jnxiDmILGMYwhiPq1Kj+s8NjqchTd9dNDN0vuKCnidbCnBFeFC+x3Oes
         3bZ5842I98XGHuq5kct27lLeqPmymrkx9oBg5wqG5asqTCCFZzT91mKEFY3E9KRldn3D
         nQ4liKDW3cgNyHnE8PXxT7qJ4iOjdlzGaADhWtK68Q2QCCaBCZM5Bb5UNujilEbR/4mz
         Mb9g==
X-Forwarded-Encrypted: i=1; AJvYcCV5X4m2Nw1JJ44r49ieTIgvO5doi+7Af4w/5C5Im/C+DCV/YkJR1zp+vtc0DO3jRGHiC0BIAbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHk4oCM95GumJPL8flKQrUZcllW++1Qf7rBO305iPIznjNkAV
	4sE1tqiCl8s8lMioKoMLeLHgOHRAFg5Eoc08oMs40cbapRrnl0WpOCD8AmI77YMD+dM=
X-Gm-Gg: ASbGncsKLcssphwpGHagdoY9B9eDuJcZmNFEmtU4iUkOdoU/YxfgF5oWX8Uqr/toa21
	mn906Ym6jwhR6GSr7OwGp9pbX2C2gLVCQnyzL04TfWWNhMzF6Uhpi2wb+FOzz+DH9dZZEFCKJd1
	o9N017FCHMaWS7mIUf6Fw1UJtuajaX4Ssh6+ENe1HNA8UcQcGwmUTiawsAqmck57ALMeJSpk8sX
	ewRo4CKreT0OfXDChQf8YX1atd5sasKDIRf3i+xiv51/7D4xlK9a6Y7b/uYWpxw5fVY5KXFuGMb
	va49sV9n5UGfXxVd+nDPRmw7sSiL1jh739K7nn3vYVZ4xQhN3eNz1MkMSl5ZazjLi91eM4J+vPJ
	0Kha24BNgmecCah+c0qqMfUHjJcsz4TmLl/saZ68kWJqPdTkyGG7pMGUDY7bJY/t5oLvYtY53Ot
	lqyeZ3YnxRsQHFa7D6OA==
X-Google-Smtp-Source: AGHT+IEWJZa9OXo9rvQ9o7Mxp6lXlmW/3pY72P5TsSgsFlf9Lt291nRuTeu9czNeY7JBIYl0Io62Wg==
X-Received: by 2002:a05:6808:c28a:b0:441:8f74:f31 with SMTP id 5614622812f47-44d94000d1dmr2447563b6e.59.1761419716525;
        Sat, 25 Oct 2025 12:15:16 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef29a199sm683030eaf.10.2025.10.25.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:15:16 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 5/5] io_uring/zcrx: free proxy ifqs
Date: Sat, 25 Oct 2025 12:15:04 -0700
Message-ID: <20251025191504.3024224-6-dw@davidwei.uk>
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

Freeing an ifq is a two step process: in io_ring_exit_work(), the ifqs
are first cleaned up via io_shutdown_zcrx_ifqs() while there are still
outstanding ctx->refs. Then once ctx->refs falls to 0, the ifqs are
freed in io_unregister_zcrx_ifqs().

The main thing to note is that io_shutdown_zcrx_ifqs() may be called
multiple times. To ensure each ifq is only cleaned up once, set
ifq->if_rxq to -1 once cleanup is done.

Proxy ifqs hold two refs: one on the src ifq and one on the src ring. In
io_shutdown_zcrx_ifqs(), dec both refs. While these refs are held, the
src ring is looping in io_ring_exit_work(). The active refs on ifq->refs
prevents the src ifqs from being cleaned up, and the active refs on
ctx->refs prevents the objects from being freed. Once all refs are gone,
the src ring proceeds with io_ring_ctx_free().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6b9066333fcf..2d0d1ca016c5 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -519,6 +519,8 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
+	if (ifq->proxy)
+		goto free;
 	io_close_queue(ifq);
 
 	if (ifq->area)
@@ -528,6 +530,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 
 	io_free_rbuf_ring(ifq);
 	mutex_destroy(&ifq->pp_lock);
+free:
 	kfree(ifq);
 }
 
@@ -801,10 +804,19 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 	lockdep_assert_held(&ctx->uring_lock);
 
 	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
-		if (refcount_read(&ifq->refs) > 1)
+		if (ifq->if_rxq == -1)
 			continue;
-		io_zcrx_scrub(ifq);
-		io_close_queue(ifq);
+
+		if (!ifq->proxy) {
+			if (refcount_read(&ifq->refs) > 1)
+				continue;
+			io_zcrx_scrub(ifq);
+			io_close_queue(ifq);
+		} else {
+			refcount_dec(&ifq->proxy->refs);
+			percpu_ref_put(&ifq->proxy->ctx->refs);
+			ifq->if_rxq = -1;
+		}
 	}
 }
 
-- 
2.47.3


