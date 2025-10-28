Return-Path: <netdev+bounces-233609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5FC164F3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AEC40442A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0234C9AE;
	Tue, 28 Oct 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="M3VGDJmb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035A23EABC
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673605; cv=none; b=g/o/5oQ88gv0LXj/ItGOd6zXBeVenrouTUYzjQMucmVy4Ng5CzaKrn3qhHxWR5ZMqbkCPKnUzowpd/adu8gSCJlP7I+8X5RWEpWz1KMdxLnEQcsXPy4zdlwKkOqkp8SiXu//NfwqzkySpegbEO9dCklMrAsC7qjmuwtpbxvqmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673605; c=relaxed/simple;
	bh=cIXg+tN9h9zlfWJjNBcrzbEYMhJ5IW2HJ5uhk4M9KsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+u+uUFxaYj22wx1/YZ7ZMAF8BMzhHJ+UGhz2bJ2x1J93rhy86bIA/z+iKDtTduoqKVyqCnRNZM3NXBWfeIjzSdW4KyGskDy8rshcI6OOrPTXZ3ujnfLSY8b5Jfxbet4ja7EM7+VokcDBx+yw1jPU7CrYpx3HnPPmGXVcSJvhIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=M3VGDJmb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3d18422565eso2914564fac.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761673602; x=1762278402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Du3rc+vnvYBpwFFWNDgSM6MmBUWouZFTL1+wbgJzm0=;
        b=M3VGDJmb06eovMgvwpf0LY33OxgC/QZY4Aa0d4nupvt5qu31UnI0O66H3gCZSa6vAy
         FO+zdZycaRnsF5/3y2CWtv0aIt2g+c9s6uZnIUGMPt3whnLZ8ibF0yd41XwmTFXI8q9M
         sP5aQS28F0MrV2j73Qsd/bx3rGFyg/ecZ+xNzAHJIHqhUlYZTTWTQkjxMsamFAsVavSY
         d0I4ycbqjVjvSiYFUD9XYX7Hc0o/KRkPjRFN52HQ/b/5BewMr2D/dVDD9fe+IDFo60sl
         5xfiYOfIyRAhLXazeEzdVBk5dq1jSehpnGxg74/bqCM8f5QqdmeehVuaJzKNS3Cl9Elx
         FSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673602; x=1762278402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Du3rc+vnvYBpwFFWNDgSM6MmBUWouZFTL1+wbgJzm0=;
        b=dyOXBRrrjdG5kPQS7TNjPeLuKVTIOYOEV/1KAx7nzReIEw3ue0EYE6Kqzhr2aq9Ogd
         N4bR4lwNkvsvzttJW2i8oHrT8o3udw9VytrU5iho4XCIgIRcgZUtjb315DBtRZ1L5XWr
         TcX9KAVR2UOThQMJQ+pjanoG5EnSZG3WAckFdD8x3CSqjMISkQm3jcXm3qYcoUbrdcZr
         DXmqMwr/FSq9k3f0orC+O5AojxfT846vABNk3seUqCy2l2E9Psypol+1hsFSCNnqTGa+
         Y4nzFURwVF5ZQ86lXz9fEgXz5YaIKO9TrSRkHxJgMeDgrSfHKtstFB4QG8DqSZsxAIGz
         v/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVh8hse2kAaC6Fj5/VqiAuUSfNxrjuENmUGvGOyn8iTyRmvu4h6EZmMi8efMFbig0WcgC9syDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORN/XDj9b0UOHB7WIZx5h1X9w8MqIPB/v4K+PzjUU6y4Eh0oy
	f7AXFArns294o9iYwK2IbTh5Vmg+BEIIdECh30Jj6rzvpyynNTRC+J25Gjtf1hVqHq8=
X-Gm-Gg: ASbGncvRQ0TZympLQ70DR68Flk/I6UJNjTpvQbnXxg+yhv9oQsTUt0rAM2wqPVh6fA0
	W4ZZDvFH9l6C9T+Y6EeSDYqd4kLdnBgp8k0lsCtlEtGoRu+7X7KujkI+S+Y8P2dRWZxhdfiI2Bp
	OCSMn7RfIXo1xcDcL3RGHt4G+HBXerRRr4wNPGudk6oALFb7d3u5q8Mf2UfwTKrCyotMY0BFNKh
	7gOBNbDjduTQz5/YqiJImpW21kJ/L7CKIhtQT8wIhdASYAuU0WobiIKjYdqYLWCPCkfuiDQt1cT
	8p/uJ5p7Yc3npU9BG9q0iAFJyVf4gCXVkdH6+uGabkKzoSXnqVhTLJkSt3cqUJdJ3heLXdVHWsB
	UKVpHewFDADy8/MFs5IpqAeVlGrN6x0xbKfk6hUw3LGxHJy2/cdJTVC98AKiTraH8aMI2gN0b5K
	bBrPs0lN9W1ZQ/UqnPPQ==
X-Google-Smtp-Source: AGHT+IHNBwaTuVlKbviFRStplaOVwH6U1T0/n+dfNL00nvGwBLr9BA86MrTQMPJz2TmJ7wDktJPApQ==
X-Received: by 2002:a05:6871:5290:b0:3d3:4834:b3c with SMTP id 586e51a60fabf-3d747d47867mr137879fac.35.1761673602432;
        Tue, 28 Oct 2025 10:46:42 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e2c30b50sm3837001fac.11.2025.10.28.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:46:42 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 1/8] io_uring/memmap: remove unneeded io_ring_ctx arg
Date: Tue, 28 Oct 2025 10:46:32 -0700
Message-ID: <20251028174639.1244592-2-dw@davidwei.uk>
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


