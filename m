Return-Path: <netdev+bounces-69567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B909584BB0D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAE01F25BC0
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7E1373;
	Tue,  6 Feb 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cgW4cvSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA1EDE
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237277; cv=none; b=q9wUXc6DE7qnyQUAborFxQuHz2pQIHCYCbkUBhMSWlDRA8uUNMAQ6705EAm9b0udSDmyEoLbuiHeJzeAiTsM+U77QP5Zmw/KYvJqC9ujAw4XLBB+Uc/oggacHLve+Mq8n/YGW61aSq5eSLUl6unVb1+oLhfd9nizJcIHP8BFo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237277; c=relaxed/simple;
	bh=HGkg8jn+1tiQhhHkeDvYdLT6P19EyKlQEBs4srDnGLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9z6+tX5W9KAEUSKRAVclbHc2pmMknIA31TxWCkhRbVeDUjfKvun6TufJZ4dCNG2Y9688OEIyhJnPUCLp3QjhfA7VfW+DXgMVj4i4jq9HnsuFe3+np1BoiNKUhjtAn7hHpiUVSN8cVhrfy6k6lFWJjX+gBcscRZxsCkYUQa+pwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cgW4cvSY; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bff2f6080aso40929139f.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237275; x=1707842075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKc3IuqsYtihfLzHWvhn751k2a+IQ40XzH/g9DCcLM8=;
        b=cgW4cvSYo1OgOCkhvzk4UPBGVR0AKOLSpnpi3B1J2qQ4oS1DkBcwBXdjStnc4TJX0p
         W019zozBIuhzRwyB7+xSXVyXtY6d/e9Z6oicoa0ts+UxiwyiRLDZSPerTcxa6y0nLSjS
         Zvo+OzfDkTJFWP1rSWZVVnUKxWOAamid1tDtcF6oW1BOf/oLjLNGG1NJR5p5xjoP98ty
         LqcOKFXD+P6+dBajeZGs7BPMccNuNhhb36NgmYtuUcIRpVbkDlcsEnqMIZXhnAjobT+7
         iyDk5jtviGv8Ol1bdUfqDqvtIfp2ijHHdLyXmaaUh0VYtFiNkBm0ItveZzzZyktDS6tK
         T+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237275; x=1707842075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKc3IuqsYtihfLzHWvhn751k2a+IQ40XzH/g9DCcLM8=;
        b=L2M8lA2hSDrlicYh9UUEfS3P2XKtLlWHDd3BX2zXT7baPl5QfdrwS4PdadDS29Sb/u
         q42wdBA/if8a0g0hbnCgo5bD3vqgm8Mwm5tsIiV182fAr4AveqB60JyMXlK2JaabJqIJ
         eGR5yoFQZl788IT6WlLRdhHA69iPsRTIkwDrmOu/moGkYN0t/U450E6BCK1Q41rhA71R
         9l4Q4nsRn7GoxTyY7TxA4c1yze5P1sARDyNb4RxuSvIKEDsoyj/t0cMbDA5vXwrWm+P+
         dsjT9n/PCa5IgpxL4azi+aTd1gBNHLrk7iVYzlUxPju1Zmfbi4LOBMEFDQ5rOB9uGsKP
         UMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGyCg7Kebv2XtE4WLrdBIEPdjEbUB1nw3MsaBK/II+ZfIpi+AO8U7L5NnNjZ7w7lrCfUWzy07NoIBrSk3zw6djkHOzvLIQ
X-Gm-Message-State: AOJu0Yw8KTytEjRz0hk5T2xxWTFL2beZ7/xKUxVvcPRS3r1lH3CQ5KWT
	9qtB/coOARJA8F+FckNIzAg0iFDwrxGAveAoK+ZdXAkLsFZlpdi6bzWZ38ETUpM=
X-Google-Smtp-Source: AGHT+IHGX09ZwU0r9KtnFAfB9k518CqpJMG77lsRWA/Zoc7I2VmqCxChPBvPfqhFxSQM6IDD6iliCw==
X-Received: by 2002:a6b:ef07:0:b0:7bf:cc4d:ea53 with SMTP id k7-20020a6bef07000000b007bfcc4dea53mr3488843ioh.0.1707237275253;
        Tue, 06 Feb 2024 08:34:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqycd8BVtvgYWdnuco6aREtlfEnNV8TP4RSynXRhuhT7NfjrRUgjr9FS48gPpdoaMHD/gmK8t3gBL2JgW5PgTExD3T2L3F4ZBCvj/liG8kyZN+XFdsI81Y0vgKjeSAciH8d6+HsqINiz4AY/nZEZBqJTMMp5lxpH+CBkCJSY7kvcI=
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u8-20020a02aa88000000b00471337ff774sm573316jai.113.2024.02.06.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:34:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	olivier@trillion01.com,
	Stefan Roesch <shr@devkernel.io>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] io-uring: add sqpoll support for napi busy poll
Date: Tue,  6 Feb 2024 09:30:07 -0700
Message-ID: <20240206163422.646218-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206163422.646218-1-axboe@kernel.dk>
References: <20240206163422.646218-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Roesch <shr@devkernel.io>

This adds the sqpoll support to the io-uring napi.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Suggested-by: Olivier Langlois <olivier@trillion01.com>
Link: https://lore.kernel.org/r/20230608163839.2891748-6-shr@devkernel.io
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/napi.c   | 24 ++++++++++++++++++++++++
 io_uring/napi.h   |  6 +++++-
 io_uring/sqpoll.c |  4 ++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/io_uring/napi.c b/io_uring/napi.c
index 1112cc39153c..3e578df36cc5 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -252,4 +252,28 @@ void __io_napi_busy_loop(struct io_ring_ctx *ctx, struct io_wait_queue *iowq)
 		io_napi_blocking_busy_loop(ctx, iowq);
 }
 
+/*
+ * io_napi_sqpoll_busy_poll() - busy poll loop for sqpoll
+ * @ctx: pointer to io-uring context structure
+ *
+ * Splice of the napi list and execute the napi busy poll loop.
+ */
+int io_napi_sqpoll_busy_poll(struct io_ring_ctx *ctx)
+{
+	LIST_HEAD(napi_list);
+	bool is_stale = false;
+
+	if (!READ_ONCE(ctx->napi_busy_poll_to))
+		return 0;
+	if (list_empty_careful(&ctx->napi_list))
+		return 0;
+
+	rcu_read_lock();
+	is_stale = __io_napi_do_busy_loop(ctx, NULL);
+	rcu_read_unlock();
+
+	io_napi_remove_stale(ctx, is_stale);
+	return 1;
+}
+
 #endif
diff --git a/io_uring/napi.h b/io_uring/napi.h
index be8aa8ee32d9..b6d6243fc7fe 100644
--- a/io_uring/napi.h
+++ b/io_uring/napi.h
@@ -17,6 +17,7 @@ void __io_napi_add(struct io_ring_ctx *ctx, struct socket *sock);
 void __io_napi_adjust_timeout(struct io_ring_ctx *ctx,
 		struct io_wait_queue *iowq, struct timespec64 *ts);
 void __io_napi_busy_loop(struct io_ring_ctx *ctx, struct io_wait_queue *iowq);
+int io_napi_sqpoll_busy_poll(struct io_ring_ctx *ctx);
 
 static inline bool io_napi(struct io_ring_ctx *ctx)
 {
@@ -83,7 +84,10 @@ static inline void io_napi_busy_loop(struct io_ring_ctx *ctx,
 				     struct io_wait_queue *iowq)
 {
 }
-
+static inline int io_napi_sqpoll_busy_poll(struct io_ring_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 #endif
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 28bf0e085d31..f3979cacda13 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -15,6 +15,7 @@
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
+#include "napi.h"
 #include "sqpoll.h"
 
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
@@ -194,6 +195,9 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 			ret = io_submit_sqes(ctx, to_submit);
 		mutex_unlock(&ctx->uring_lock);
 
+		if (io_napi(ctx))
+			ret += io_napi_sqpoll_busy_poll(ctx);
+
 		if (to_submit && wq_has_sleeper(&ctx->sqo_sq_wait))
 			wake_up(&ctx->sqo_sq_wait);
 		if (creds)
-- 
2.43.0


