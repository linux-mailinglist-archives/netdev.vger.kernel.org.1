Return-Path: <netdev+bounces-233615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95197C16514
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE0D405EDE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2434DCF2;
	Tue, 28 Oct 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="GySTAjes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF734C83A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673610; cv=none; b=Utg02CeLnIdl2fBN0kbFsFg5AnrEg145RwGgmqYmAsXDZryxQkxuqVtPHZKnv+owgCwyd3lrFOrGuWV6DWQVnCzEvpvbJtz1AChRxDg+nXQKUL79DMlKlWzMslGcDIDvFxEftP7T7JNt3RH1QzccBSr0Bew9GM8hewR6YKv5FPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673610; c=relaxed/simple;
	bh=4X7yplVhodWhw/RkySGYlwrpw581slqzwJbYHW/2BNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3WFI0lXm2kPkrBGqW9HQa6fFWvZFf/Z38FDhAQP7hKteYUAwdm2xLJUNiiHrgf1jBhTZ6BO9kAkSK0xuGnwAXYIdat4iO2zLhMyYY9+2hs5ELjGfYJC4GRdgDxwNPSXLSJvNfDCkJFPKrTZfynMQLAxc308iJnj6FjlgbhnTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=GySTAjes; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c29466eabaso2096981a34.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761673607; x=1762278407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDyf8hnr6ftwJRjPNQhZsT5EFe6u4EruQiaSCRXzIjY=;
        b=GySTAjesw3WeotvxhJyl5gG5/gON04KEkEMyE+3DnzzzpeOuPTzWAKaLq0A1ZRT0nV
         /IFUsmZCEvSo+ErP8CJoDwwQ1iWW1TmQoNi4QINYMyGAO66aufQGScwRRcEcIsfHPAlP
         5nR0kYZWZPSY2Gp689XFCigAv0ywzmW76gHg8w0AVG5mvqhWZBXdIonLN7bbIeTdB8d+
         NK/4rLdPxZswsMCdzWqR1TWzrSllO4+k5/r4rxWeOhaw6xn5lwqSL5iIkplVpIKMDVBO
         16PG6uZKEgm1zsB9jMVd4unzUNNboeVrODyybYpoZ3bndsZzusMyAa49csd2pjxRlHVj
         L89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673607; x=1762278407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDyf8hnr6ftwJRjPNQhZsT5EFe6u4EruQiaSCRXzIjY=;
        b=LbwQZ8dETo6F2zMEABypM0pNa5gxmJIWD3535TvC6gZHMqBsD4k7SBBaELCz/pZmhG
         WEu7rpsqetIqzosaqQEJLWa618ijhQUsMRhJDyDNd+MYiVeSTBj5xv6XEB/geRq0j4qZ
         Ryv28ZE9sNfGpWTffNYbasstdbaI7QS3wbTvTWUeQDrMu6PqtlryQ7qVD1LMBg/zblc5
         c46en3l2VedQQ91npBb5dIRZktEzDFuOscDePvayfPpQ/0KldWLXGkq68B7Jz2YgSHkh
         GoMbMzt9eJrrt2TXNZS1DXyT24cY5H6bdfU/33J8eFsMlTggNUVtDM8vMJ5m6OotUZ/e
         kGPw==
X-Forwarded-Encrypted: i=1; AJvYcCWRRpV9bpa/2pWSWfpkNnS/wyn/T9xlRp5EEWqyn2a43qYkUcDL23kwCNwuisLbp8P/RCu6mKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHIKRjWFgD3fChRoBH2B5eoFgb3JXpsozWy3iP+9Lzrq4h7x2
	sZiJ9JxnkF4nSojj7p7Bfcfv3cvRF5lxEd+2Z1VD5tZot9G3acoUCHkOXPxppIRGYsU=
X-Gm-Gg: ASbGncuE6Zw+/cf/Q658N/ie3SRxDu+v2EYpb2FCpDlr3v+clc1UXpihS99rYOkCOjJ
	OWDakoHORMSmcO43RYkOEk1ozQl5200xITcFr/AjH9Iwfrw8dDnl8D4YfzNZd/18e3iNlRTmsGN
	PkHf4Z7XM7Xb2sdD3lAALPOrLAMeILSFpoARFDOXm1pMaW0yV0kTK5RBAoLXj1CopgZOl86eCGK
	sPC3JR0FTJGLKB7qY5v/FeYtDBoHk6GFF9uz9QZmAZEF5Tsde8WPmYqxo24DsXCCBO+Jv5c7ZXn
	oD6hgSwA0rZ6WfJ5RSPLOlFGyCUyK/R02w+SqlPP+w5qOs3nIQCVSa2Wrx32zW2MLogUAa/u9Hw
	9T81lhaMmp03t91wu1DYe/SMmwq/TpAXHSFZMLAZUyQshx710FCDD24o/rSj8RQbBdfqNZZpL/Q
	QjZCW4acfDioFo3PUOunrQOLmlshLNtA==
X-Google-Smtp-Source: AGHT+IHy6oA+5SIa1EhB6DkbklhqEBYozMSXWJiOdcmQiwMz1qehwMqQblPJYpBg1hC9JfGHacdesA==
X-Received: by 2002:a05:6830:2a92:b0:7ae:39a2:2656 with SMTP id 46e09a7af769-7c6832d1bf7mr75178a34.25.1761673606975;
        Tue, 28 Oct 2025 10:46:46 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5302068e3sm3373571a34.27.2025.10.28.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:46:46 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 6/8] io_uring/zcrx: move io_unregister_zcrx_ifqs() down
Date: Tue, 28 Oct 2025 10:46:37 -0700
Message-ID: <20251028174639.1244592-7-dw@davidwei.uk>
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

In preparation for removing the ref on ctx->refs held by an ifq and
removing io_shutdown_zcrx_ifqs(), move io_unregister_zcrx_ifqs() down
such that it can call io_zcrx_scrub().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 774efbce8cb6..b3f3d55d2f63 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -662,28 +662,6 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
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
@@ -749,6 +727,28 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
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


