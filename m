Return-Path: <netdev+bounces-235274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A62C2E702
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E1304EBE80
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CB30DD37;
	Mon,  3 Nov 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ehsjjTJe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935430E855
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213284; cv=none; b=WVwPcNzbN2VfVkZ1750JhCQEBcZxDwVZaLG1pD7s4kmAg3DNNECeuVYzuspkN+b9cfKBhObfpaoWZXJbyAs/Dg9j3AcC6RdpOLuEqR602DXWLGY3WeWd5nZVcet7XE0l56CvBPvRApeU1vHpz5ecsNnSUuAAPtpqmNNfp0Wh6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213284; c=relaxed/simple;
	bh=cIXg+tN9h9zlfWJjNBcrzbEYMhJ5IW2HJ5uhk4M9KsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAaoKyml3IlvMEbACmGEGb6oyQDl6vytbJdXSLF+6uDhSn2eVuzYDgEoj9DxAe2fkOJ86rzo4b4buhg+Jixk7Jd+lBhoz6icpg3fYBahkClKOc4Daa/nQ2g24aAdAIbP+H98G+B/HiQe+GZc1/bEwJTvvavlp+1x9dkwXi63ES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ehsjjTJe; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-373b7e07182so3357804fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213281; x=1762818081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Du3rc+vnvYBpwFFWNDgSM6MmBUWouZFTL1+wbgJzm0=;
        b=ehsjjTJedhehZam+IUZSBR6Jm3nUoibU37tEza/HEk0prU1RoL8OSO2dElTBn3r0E4
         BpizlpHD7zeUIfVegLkNz2Pvs8wM4MBBLMusfysyzmsNe2016DEGmJDXcW3/rMRJhf+4
         pJk1pm5QCKBh/xAgGOGQzyHzrh0v5JBETZy4gPiZjNXmM5aqQkDch6gTW7vv4K3DPCeD
         nnOOnY6q2THCtP+6jtg2/eGY9fgPO4UEo1XiYSj2+ILShM+m0W4IXCJjfCIfzhdpGveU
         U7na23EZtkagIlFzzsoP5OBq2xomvzkE0et6GsKxcNGvUYSiDWCNhw6Mag6v9jyUqMxf
         IE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213281; x=1762818081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Du3rc+vnvYBpwFFWNDgSM6MmBUWouZFTL1+wbgJzm0=;
        b=P/EUaE6BHI8LweZXJAfkThirnQ5+QC9TNmibYs8r2Yo9LmyGcTDfaLxpM6vTNex03P
         ZJgiLqv3KtuqLiYea758iRrKQtlCVukO5fD6aZVEz7HU2bslRQvJgmJiwd7M0+3C4L+3
         /sgHWhXei2o/se9J1zNo3qeOKPaVHvflbxBJQZzyUL128YA4h6yM7rrkMp15dtilNlcm
         EPP6+V2UU5XRuYXMzq5tmt/X7U29c+C80bTUZvO1nnIK8k2Q3yziWqig9jCPOHR5EzIt
         maA14Cr0Lm1/jkuz9KJqDBXgjAvnwoUMtSHjNKRJMxTx8p25KoGYrHFLCqoBnHGIu6P3
         jDDw==
X-Forwarded-Encrypted: i=1; AJvYcCUiqE3pGjF9DJj5/Of+fqj/Ssj6ZJ9/bb+Kh/PpexgrYT/ed3hXegI4D3yDYkRP85MP74HtoSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+x4tcFaKQuTdQqS2U5AXw0QbKlD6QNPsdODXrgxBF98Cz1P8
	5HpVVz8SuoZZxybjMmSS+JXYltr8o1fHUdOch/AwhdlhS6ri1LG0LYxuWciQIz1B0pu39Tlob2z
	iDfeE
X-Gm-Gg: ASbGnct+r4phf/9WyICqgcLoC+AX+hKIuu6iEtCRh///bamqH6sKf/aQPyzKghHkg5L
	MDnVPuY9LNsIbiadPtNeVjhKpXSm35YdfJ9bNuwOAyl7mH2eadLiW1c78rfWnhq7gFqL96++N7W
	Fq37/J/8JZEYdPnF+pmyBBpkWAoTtaKYtGux4zHiep34tmrzMXcK0lp6BuqIIVePivOs9TWB+s3
	1yUSUwEHF27dd2ThFxxI/UsMrq1w2dfwiMBPTtNyG8gONoHr//XMT+Kqwpqgw+KVwrDMb7sqDdD
	9QkXSgASj8TiQyLO85cyIxc6HjYmh7Hlqoc8IRfQBcSAGhWbd4FKqL34qPq8uSzO95M1yZicjdK
	fptqcJCRgnAIXNgnJeEOwYSU0Eq04B6LZDvom5yih2BtYZcU6dBtbItQGJ+M3qKaJv5Rzd/Vvds
	5AJhrt3rjwhjXkFq9QHSTXp3Eo8uA23w==
X-Google-Smtp-Source: AGHT+IHxScxSSuSgLTqjWhOCow+BFw3hFTHDVH/SZE0r8rxc/e2eU7jEi88LOGeSkmX3N2qFx4pjXQ==
X-Received: by 2002:a05:6870:d373:b0:3c3:1ec8:2aa9 with SMTP id 586e51a60fabf-3dacbfbea23mr6752173fac.24.1762213281420;
        Mon, 03 Nov 2025 15:41:21 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff4c0e8a4sm533685fac.8.2025.11.03.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:21 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 03/12] io_uring/memmap: remove unneeded io_ring_ctx arg
Date: Mon,  3 Nov 2025 15:41:01 -0800
Message-ID: <20251103234110.127790-4-dw@davidwei.uk>
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

Remove io_ring_ctx arg from io_region_pin_pages() and
io_region_allocate_pages() that isn't used.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/memmap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index aa388ecd4754..d1318079c337 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -131,9 +131,8 @@ static int io_region_init_ptr(struct io_mapped_region *mr)
 	return 0;
 }
 
-static int io_region_pin_pages(struct io_ring_ctx *ctx,
-				struct io_mapped_region *mr,
-				struct io_uring_region_desc *reg)
+static int io_region_pin_pages(struct io_mapped_region *mr,
+			       struct io_uring_region_desc *reg)
 {
 	unsigned long size = mr->nr_pages << PAGE_SHIFT;
 	struct page **pages;
@@ -150,8 +149,7 @@ static int io_region_pin_pages(struct io_ring_ctx *ctx,
 	return 0;
 }
 
-static int io_region_allocate_pages(struct io_ring_ctx *ctx,
-				    struct io_mapped_region *mr,
+static int io_region_allocate_pages(struct io_mapped_region *mr,
 				    struct io_uring_region_desc *reg,
 				    unsigned long mmap_offset)
 {
@@ -219,9 +217,9 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 	mr->nr_pages = nr_pages;
 
 	if (reg->flags & IORING_MEM_REGION_TYPE_USER)
-		ret = io_region_pin_pages(ctx, mr, reg);
+		ret = io_region_pin_pages(mr, reg);
 	else
-		ret = io_region_allocate_pages(ctx, mr, reg, mmap_offset);
+		ret = io_region_allocate_pages(mr, reg, mmap_offset);
 	if (ret)
 		goto out_free;
 
-- 
2.47.3


