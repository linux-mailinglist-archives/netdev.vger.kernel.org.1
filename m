Return-Path: <netdev+bounces-235621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F8C334C7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE9E74F64E6
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9CD333738;
	Tue,  4 Nov 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Eo/37XsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B82346E5B
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296309; cv=none; b=cd+m98PezZgHqpKq9PTsdvVWHZSXYIkAF55lCKRL6xu6Bi+UP8C6kVF81Th07RQzfDMnqoovzWtfR/CV7XpUsKESc+4I39TznaCf3jSKeNEKupU4IqerAfoMwUrXNE/X1cl7K5hM7UkbwjTb99FPfzTkbmpFKro/LjhazyVxvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296309; c=relaxed/simple;
	bh=4X7yplVhodWhw/RkySGYlwrpw581slqzwJbYHW/2BNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGXVVKPek/lkizNNgQYn2zQspPmFUV6Vs24GVfyLd+OBHKIk8Csbfr8PxflDlN8MkF5g0csFcFILINHOm8tAgY3+9MU1m3/rzJZMm2w2LrzV/ZriAawL657Nc5SYcl6VltaWzHZKnf2DlZ36rQ3IJ+cuwC+TDxyIgXHi7ro8+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Eo/37XsH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e10d1477afso548310fac.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762296307; x=1762901107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDyf8hnr6ftwJRjPNQhZsT5EFe6u4EruQiaSCRXzIjY=;
        b=Eo/37XsHK5J5ysJOoEwDhBnDdmZ7ogaIE1rOdnEJY2fjaDHHgUNcR0yHXrihIpTF+j
         0sD46t6JYQM0GyGYUpjDtXMrtIaioxZSABr9gxVSPOGVulhceWkzkvhzSPXe+MGzYXuK
         3VrjUwnteckoQ14Jxfk+X67JIqNKhnGahpkVX2e+xg4W8iSNkosTWW9eLFMvEYffjMvb
         5PdxeMMlp9nQNrv5JBhIrL2Y4EaJSYS+Qad5nLNMkTYdNagtBEVvM4RfwISZzs9wBIKY
         LvdLKDcYQ0T6cNfi1LUEP1GzfuVIPP2XqsYk45wXTePHOIcd8B1cxHubgutFC30WbUYJ
         yMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296307; x=1762901107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDyf8hnr6ftwJRjPNQhZsT5EFe6u4EruQiaSCRXzIjY=;
        b=rtxsToIkwyH5TkCd/GtcuHcqhrdA+trfFPAAHpPwsyLrVhkZr9jQm9qGmUlPx7HSGP
         6fSJBD0xjnISf6tfG2Cdc310eYI/desU8ftZYDVHoe3rVu9FT4aBPRk8zbwukBWdrj3J
         4yp2TBKqHwRS/PpMgnk02JlFv3z+OMhGTAwcezML5W8KfL8c3tsB7E3SKKKFxUBT9toh
         dh6Jmrcu31p+I7oUqDGwlUdvfRNOCagIgVqvQuDNwE7QwH2WHBosJfPchcPIenJ8pS2q
         fec7suWJ4PtjYMWu77cUDlkxupoxV5oK+1CF5a954M+b7QcPxrL8voyh4CBBBJXyQUCN
         gxyg==
X-Forwarded-Encrypted: i=1; AJvYcCXp9XL1YgfjYfyd/OZORfMBoQ7slV4qslNlvKyMtsdEdTdFrCuRgJwM8/P47zdq6L8aJK05Huc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTl6RT3erBn4UVfb8mzq5RFZhTF8CA+ZXW29JAcBQXHP53uuJE
	Dke2tCOsjv4qg0dQ7w5Kj5AKX8XzF9rVoA0US/883/7YYEBCDSUIcuDznz1iMvB0vWvshXrSPfR
	C7MiP
X-Gm-Gg: ASbGncvRGneDDEGJLwyt2S1EEYnxWQ2pTDgqvRjjPNjtvSe9lLn4WYLcHlULAXDNteK
	eDyRacYjLuvRy7F8Rp7bn1jBgDYJMzK3mP8VWw/tRE1ynCO9xMtiisrh4/HJ4uinFzbzI/eu5Mx
	yA6EDIq33pEZUFn2mpn+oUrPPwsWMXU1AAiBFiuJgWDNUHFh7utkNG85B6l3PCLOf8oeOdt9kOV
	oZ/78su76SC6gNQll+Vw7aNZJGeSEJvyo2vu6otFJNNTqSU/zmsiliEALM111Ozr2gC78CjEU2e
	B2t570Zal/P8QB+L/q73w3+Ui0QloiCheYTDC3uVZkAvYQwdax+oHJLXyUIxaQy8v986jUJ79vu
	ZSiw/xVctB255HVI9fjWw6+gf5xSCk0DsmjgZEjua2GICXI8AzZ6sXdxWMjrSC348DpO1+tlKea
	K2VxLdho36ZJ6pivft9GBKTVsDFA==
X-Google-Smtp-Source: AGHT+IFQSqaGPHWpsUZTQR/Haimsxfq1Vc8pRkwG1js8sfSP4eGZqe+B24MQF2JC/TsLZmIB2ZBFtQ==
X-Received: by 2002:a05:6870:23a1:b0:3cd:a995:6c6 with SMTP id 586e51a60fabf-3e19977e68dmr438499fac.13.1762296307095;
        Tue, 04 Nov 2025 14:45:07 -0800 (PST)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2448b02sm1419678a34.5.2025.11.04.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:45:06 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v1 6/7] io_uring/zcrx: move io_unregister_zcrx_ifqs() down
Date: Tue,  4 Nov 2025 14:44:57 -0800
Message-ID: <20251104224458.1683606-7-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104224458.1683606-1-dw@davidwei.uk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
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


