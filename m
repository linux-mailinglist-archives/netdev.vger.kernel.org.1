Return-Path: <netdev+bounces-235617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A4C3349D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF3318C4B39
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80420333738;
	Tue,  4 Nov 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pbJ7tsUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100A314A69
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296303; cv=none; b=WBw+dFZzb9DFrYqWfcHinPWg2dqSuSgl4H++0nmFPVMRHzQH+SFNWsVjH8+Sq3Eg3JOXcNmlQhneqp6DPSFy9xHgqF/OkhrIrPUUx4xCftFiJYMLv2W7Z952YkF8MukCVC0WO/hcO5yYeYwqMsj3sYNQrFSqzNKrplowIaayIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296303; c=relaxed/simple;
	bh=cIXg+tN9h9zlfWJjNBcrzbEYMhJ5IW2HJ5uhk4M9KsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t72K8m5yX44ZOsCMDlrBIJLsGqoeK5T2nSHbVUbiIsyN0KIJxx6WwdkBWFlM9+OCKpVWHAGwjHUmySHBnoX/BZiSj7VqETIEiDQtBjQgHrmZ7piNp6VDfIRyG1xQS3YZnd4pngkE58STFFsfKY6UbQgvBD81O3jz2c4LRsX3Axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=pbJ7tsUZ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-443a7490a54so2951528b6e.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762296301; x=1762901101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Du3rc+vnvYBpwFFWNDgSM6MmBUWouZFTL1+wbgJzm0=;
        b=pbJ7tsUZYy3b8RT3Q8HaaaChmR6OlrJM96fQp+1Hws9I3wrnDAU7FlElO21XeGSsaN
         yPOv0PdIO1vDII1a/zYfdBKXqj+DpUWKFYqidftQ/WjneVOxFnIZmh81eascCkWhT+Jh
         3Np3xgiBMryzUO0KdQyGe9xJMtOiOE6mOR1yI7/ApPHQpr4m6vRVbKtkho+IPU/Vo3qv
         x5mE0KWOR6DYBzniPQKIabsvvw01sXbrNRbc6L9RqOrccBdZFMrWElLQ33CzXiBPIZ1K
         Nwp+6Uor819r70gBTR09bcnm9kL7uhmlfLwUrBH2rbLK9lFgyX/NZYlHmL9NHJrMxVkU
         5Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296301; x=1762901101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Du3rc+vnvYBpwFFWNDgSM6MmBUWouZFTL1+wbgJzm0=;
        b=br6DLIVMMysxsp1Ei+/+zNmtMTVYTMAOcHHMGznm5STBslo0AraNYg+bjnCYcRCLrt
         4Ji1W/rrU1K7oc5ZmeJZGQk1JDiBTM4NU0R2BM86EqALcFlanH/1Ug7CIQrzw8NOpTx5
         QZrkuJWIhFF4NoRZurLOLANBhgg5QjfQcL7OKR5TXZdPnM3pDMiuzLhOfERMVyzWum+u
         AzjH2eBnahxDgykEfBBbCj2dM9VRbShdIT/oLcCZrEUCcsSC9ASEzX5msTLzDlWfPnBa
         xgPYrHZ0xgUY829n+H7qqtNCamFr1ol5IXNa/iDeF4tSRfMmnQPx/Gq+/yXariBHMFGx
         mzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1N2GhoYM75itFpgQFsVr0Kd4j67eMVwR9/N6lNLByNZDFP8a6w8MfPMOnF1UwZak4Lun9eFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeljWnAb3R1MNN0mBCalFdF61rhXmQ2m1BbdfMcjRxyVXdu/z
	wVnqR+npFpQwxFTtPUEwhe9FQcKd7aZOCmGMp8QDiv2Jk8g3gMW3JmrX9a1BUbSjz84=
X-Gm-Gg: ASbGnct51+R7V9Yn7joJLEEEVzoPniL0iPhUVl678eSAHnHQgUomR69NOIk0+kymi7v
	/VuF6UdZbfT3vlC7446eDgJzfG5f6/CP/SoUsQ0EQ0hiIflO5ouGLfAVo1Zk02eYL8UT75shRg3
	qjnMvYGszEX5IbL95S4IXT0bDxTnfJmPr1TMYTSyqP0UWkJcnjlibuSSvARIbxtFdbL4KIwPX8s
	nCtTRmorBy0wA8XTQNyXi7y7CodNv8kGDe1/KeDCIjftV7RtmpNXJhgH5hrN56ryNQCmcc6gX/J
	Hh6BCn2osQlWZN4zAPCLYeUtIJbnPLAGomyuSJzIOhVoaEi5+oot0wgftxVvYTtFziLrRyl4kVR
	wKQ45RwDc1drbhLJlslCr/9B9Gbqms8WMW6TQu+Gb8ijGvcgagZMYRZr4D2Z6JLT37XD+PwvfrM
	ip3EqK694klXJfeL1rUQ==
X-Google-Smtp-Source: AGHT+IE/nn9FUaFF9F3hbq19NOeYBcvG62gr62vsJWF7y9JhQaonX1waw6MHeSnMc9NYJDuaaln0SQ==
X-Received: by 2002:a05:6808:308e:b0:44d:b300:e903 with SMTP id 5614622812f47-44fed502c18mr385970b6e.54.1762296301003;
        Tue, 04 Nov 2025 14:45:01 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff46fa5afsm1508938fac.5.2025.11.04.14.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:45:00 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v1 1/7] io_uring/memmap: remove unneeded io_ring_ctx arg
Date: Tue,  4 Nov 2025 14:44:52 -0800
Message-ID: <20251104224458.1683606-2-dw@davidwei.uk>
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


