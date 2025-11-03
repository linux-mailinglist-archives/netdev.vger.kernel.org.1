Return-Path: <netdev+bounces-235272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21648C2E6F7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFD644EF02A
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0F3016E0;
	Mon,  3 Nov 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="K6MB4B4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7D2FF660
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213280; cv=none; b=qEvkjetFKsj5iaTPUvFEtBTQPDs1feRIZ1nrOQSkammmoPIlCmzDlY5EAu4TNuOAKUY1cssW7N0eLJi0rvRhuPuZyJKCepV1NNVLLKVnmiPGw3qJw1D/gIWtacpJpvQ1rUgv7k3yP/pk9p9LpIkbc5z1xKifP4kHxzA891okErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213280; c=relaxed/simple;
	bh=kWgLpn99r2uccXtAZ5hHigzLPk/KX0jMRx78svgRyTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LI34ZRITA9FyJFT4bo7LhM1RHmxW1CyEJLuIgBJ/BdwRTz4YC7KVcXK6BSMnbOEAERQybQk77/2PFBIs1DVIdyLhcYXa6AKnF42D1GjUExd3FMFh70LZN30SuS8D3KyAkXSWlJWOMhg6lkAQQ7ndn8QFljbjfImBblTOUkJDqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=K6MB4B4K; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65682227f37so1691230eaf.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762213278; x=1762818078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au71y5tGG7FoutQx3iuhLTtL9ni/7HS75sjfoRLhoTw=;
        b=K6MB4B4K/gTdkG9NH9B9CDrtBKVAMlHk1rl30+R8LQdeyCxU8hF9f0ef8oRGJhqJX6
         UqZ4RRdCEh8pchsA/ybQDSDWQcHrOyYw3ANCDaXijMhVLGr9FzrwPBVPQ4XaeWaDvkVt
         XjiFUuKJwv8HbNxfGNJy+YQjuRfTIQ1+Kf3LiSwPLQbrQy4dHV5EjWFK4Rx7UwUCu7kI
         dY+jb0yaPKS40q7BBiTHdWBj7Y/1s0lpqiBU6rWFdLmDxzjVwInhlUugR9zwCxGWbJAi
         cU1HtT39oEtqVDgDqKae/F5KDNtw9NZDODM7NuH5pqztNsYolJ98cr/Z64goybMiXAJc
         +d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213278; x=1762818078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au71y5tGG7FoutQx3iuhLTtL9ni/7HS75sjfoRLhoTw=;
        b=TyvSVYITaLQaZzteyGgtohP1O6kRuJgXUvGS/WiZcsecDzvl36Jy+L6gXr+2gri0Sj
         yvZy+YRywP0dCVZcEv/17MzhZYKuYQW/Ut/c0QAmPT3GfOZohoA2+4S6p3h+Fpd6N2d/
         4KQG1GeCXhg4J+/c7VRlwcdzqRMGpeHb1Cz0kWCllTKRHC2ygz8KXwQAQdCtJAD/brO2
         H4fITyDnLes9LTowpXCafl/WM/47/HfBQg5t/odZMEOx4BJYwdgJQfkFx65lAKg3QiSB
         QOnAsvhOlD3WtKOqxsTcjWpIAvDFDntLOSHnyCx4PEUKpZDVWmijtHI1/txRGOtUxhb2
         z+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh1e7/wxiVLep4efa3IRoEKfa1oUAYLl+MmxS9f7FPiP/qrtZxRHle+Id4SExjQCmudripOas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqr9tpp19xhJg1+qMt4elbHWLX3G1ouFDROKVQMFCteesDPSbp
	hgBs8ATzab0YoRgAqGapGu56UgbCjQgMx28EMwr2l1QhudHdAOSZoyv2BJxXyr/8jjU=
X-Gm-Gg: ASbGnct3usVlsWdvmnPmOihvbYZhUjsiWjjs6xML3t7sYTOOTmgwLsbyfh0iG3BvWlK
	8N0r1hFGLauSR5EPcTmdRot2xfzYtK//d0tM1xGF2fQKMvDOxSG95mYO8pwGXmsfE63vLJ9Dzud
	UkWYI6n+BWVpnGKwN0Ed+BYEjilbCB5QfxswS1Lj8i9MvrutWF2XrLqSzxPI+HWoKjdK91++/zP
	sIoPR7sTvWfCJIigq9MnF/2IHdAak2LBk5gIAoPf62UN07WatlsMhlXX/GMcJYwQ5+x5h79DIYD
	SURciTF5Ov+2FP+5V21K3qm5PQb//V2Kcaja5TbRfy02fLFZ7ba/fzEMsa5tp8nAV6WqfUcgp9d
	oMDEJY5slUIjI/SiUc091xAGkpIfFdIAWbold/MWh2t37VE090e0AfbPctqJ+m/JDevIF4YTVNo
	j8lLovU9yS2l1WF9MJd0vprfDDT63S2Q==
X-Google-Smtp-Source: AGHT+IGwmwEvp/L5haWMWL0GlANjkivMG6Qdljk3C5JK2jhrSs9vWeVCuWMmctQC7Nz5WvU1Rov7Ww==
X-Received: by 2002:a05:6808:c1e4:b0:44e:b245:1c09 with SMTP id 5614622812f47-44f95df8eddmr6605591b6e.12.1762213278311;
        Mon, 03 Nov 2025 15:41:18 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656ad40e244sm461942eaf.11.2025.11.03.15.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:41:17 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 01/12] io_uring/zcrx: remove sync refill uapi
Date: Mon,  3 Nov 2025 15:40:59 -0800
Message-ID: <20251103234110.127790-2-dw@davidwei.uk>
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

From: Pavel Begunkov <asml.silence@gmail.com>

There is a better way to handle the problem IORING_REGISTER_ZCRX_REFILL
solves. Disable it for now and remove relevant uapi, it'll be reworked
for next release.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/uapi/linux/io_uring.h | 12 ------------
 io_uring/register.c           |  3 ---
 io_uring/zcrx.c               | 11 +++++++++++
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 04797a9b76bc..e96080db3e4d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -697,9 +697,6 @@ enum io_uring_register_op {
 	/* query various aspects of io_uring, see linux/io_uring/query.h */
 	IORING_REGISTER_QUERY			= 35,
 
-	/* return zcrx buffers back into circulation */
-	IORING_REGISTER_ZCRX_REFILL		= 36,
-
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
@@ -1081,15 +1078,6 @@ struct io_uring_zcrx_ifq_reg {
 	__u64	__resv[3];
 };
 
-struct io_uring_zcrx_sync_refill {
-	__u32		zcrx_id;
-	/* the number of entries to return */
-	__u32		nr_entries;
-	/* pointer to an array of struct io_uring_zcrx_rqe */
-	__u64		rqes;
-	__u64		__resv[2];
-};
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/io_uring/register.c b/io_uring/register.c
index 1a3e05be6e7b..d8ce1b5cc3a2 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -826,9 +826,6 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	case IORING_REGISTER_QUERY:
 		ret = io_query(ctx, arg, nr_args);
 		break;
-	case IORING_REGISTER_ZCRX_REFILL:
-		ret = io_zcrx_return_bufs(ctx, arg, nr_args);
-		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a816f5902091..b694fa582d29 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -931,6 +931,16 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 #define IO_ZCRX_MAX_SYS_REFILL_BUFS		(1 << 16)
 #define IO_ZCRX_SYS_REFILL_BATCH		32
 
+struct io_uring_zcrx_sync_refill {
+	__u32		zcrx_id;
+	/* the number of entries to return */
+	__u32		nr_entries;
+	/* pointer to an array of struct io_uring_zcrx_rqe */
+	__u64		rqes;
+	__u64		__resv[2];
+};
+
+
 static void io_return_buffers(struct io_zcrx_ifq *ifq,
 			      struct io_uring_zcrx_rqe *rqes, unsigned nr)
 {
@@ -955,6 +965,7 @@ static void io_return_buffers(struct io_zcrx_ifq *ifq,
 	}
 }
 
+__maybe_unused
 int io_zcrx_return_bufs(struct io_ring_ctx *ctx,
 			void __user *arg, unsigned nr_arg)
 {
-- 
2.47.3


