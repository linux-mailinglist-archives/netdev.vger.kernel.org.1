Return-Path: <netdev+bounces-237011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF57BC43313
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F370E188DE85
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBA2741B6;
	Sat,  8 Nov 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="hnXzvCmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB41244687
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625671; cv=none; b=Rl2v29xMRvDE0DLEBvQoPf3CBs08mI8vgNFpDUq6k5hkdOKorZHxhybE8eFkbcB3anR3lPpP97+iD1O4ErUmZPS5u/mK3CE6YNwXcrMi3JDGOY75l2dlwXgWsIRK+TZeEPOoUoFl4vt7jd6/MDvEzNp+HGMzwjHsW12+EN4r7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625671; c=relaxed/simple;
	bh=RZO8QZNl3njWNXuqdNfw6N7pEXP58ME3UMHZJeNoP2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ1MiIyTbJ5BsF+vfcDaBqWWkLWQWJj9mQrOkKp2pm5poKpKx8lqas9Tk5z3mGNoEQxvHWjQQT/p8wulOq9OUCbwPr7OHOPaZ0D1UWPMmT+dXFZz5oI55X3SZmoLay/gPAju5NexFn3f11O4A0lYk6shE/vOanfuOVBLd3l0xw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=hnXzvCmw; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c28ff7a42eso527500a34.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762625669; x=1763230469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2vw8iUOwVqaGoE8XlVsCXxMXbv+G8Ki5VhI3SGzvvU=;
        b=hnXzvCmwE4XitFzLitVU8cvksvkYkS6TcGLse02JCoRNbi9gIKGD28DDSgQfpOI6b+
         CG6pgkT366a4oCMhMNvpctzVqi0MEX3AWeMItXvUqa321ycBTszEhR9OKFWbA7bKQCnU
         bXFUeKk8q+hZbGw+szdcJmlQAzWQiB+kk0BqG6u7SxbUb37Yf0MLuc8ROxEO+4y/35Pz
         LEkQTtCQTwHYBz8U5nn0L4ZLJjwlNlWCNFpRurR9vgFO3wL83OyempQDrZbm9pYVyoCI
         j66EVSt8/qp5bWDnud3JuOWKViVzN2YZLFWA0RbqSi9txY0OYdDD4QysYvwV8hWhuJQT
         NjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625669; x=1763230469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e2vw8iUOwVqaGoE8XlVsCXxMXbv+G8Ki5VhI3SGzvvU=;
        b=pr3qCuTiYXmuhfW7wnVnZH6tgpqkHslAFNU5USZvinvh1o0JyEF+urDP8tlAVMPd56
         fZBFJ7WxeWxb9UTQrdlcohjLhiBdZDS/XvRoRRPha4CC4NbSEu+W9/EJ4dZAdQ6Hqmeo
         T6xRwCkO4Vz5ee9kE2oIbKIkIhaUfmqWyhCdEdz/0mEg+T/r2zIGdrUqYdSbnWpFwXF3
         2Dhu1YJuZtn1aL2PeubXsGMy63+psZyyfUkdjkveQpwBd1p15997Vj7PHKG1x7VowoL8
         88DzccmEPFjIBfIcGoL4a4ydr5Esmy/KERGkGZF3gg44NnSMXjPianVCdck9o1JXT/aS
         YorQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfQQCrts3r6ZF79gQp3FtOa66jxUnVTfR8R+sI1Wdm67pWd6tFmDs3shIUZqzMPS80cfN6FDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDNJWr7g1Im6yv4Nv3i2fdw1RU+/vJXNngePNUsa1XL43EUa1
	ccIhArZp4BuGT+Ll2/qJ1AgBWqqeLSjosLy8N2GnFyecLPzXFUSv20gUemLH9ZZqAHU=
X-Gm-Gg: ASbGncuGR/sQQahDf87/njTBk/375D2kmY47e7kHqzQStdkOgO0jZCTfj02QMhmjNwq
	3zIFBBXzP5ByLvmugjwRmLyF9Ehr7iHvO/9wU20vDrUMgjNQoWYwXYDoMBlZJwm7Z8/9JWDXJf0
	QZQA2jf7hk/dqJHewNpPoBXmLGqrxEtCO4PyaWCmqJVtu1E4BCmCuynkF0A2erdv4AHXsi81/C7
	tD/Z7QNmXWPSNb6wLO00yYSjnC+cmiTA6pCEvtnaSgVTB6xHfpmQrxkNFZpaHfBIw8VpxuAB2yN
	YbHJi6s+ql1HmDEwCnFehN/BNRMitKmvaVrL7kLBaQqTZVao5F68NUVakgC5WzhuxOenmudbWM0
	LzNBl9W9jL+06H+dCKJgetaeF79kIeePbGT/bxoY/xybKjvxQn6buBWipotUohGdeMX+iffSTfi
	GPt8bIM7Qk7XYIyWlUQiFVAlQtEA==
X-Google-Smtp-Source: AGHT+IF6gNSwYnRgghPkpBkUYnXcSqhkM6QyqQFlgGWnDcCoQdXuPUj2PJbBzvCf/8jntLmS8eJ3+Q==
X-Received: by 2002:a05:6830:4873:b0:7c2:8937:5d2e with SMTP id 46e09a7af769-7c6fd7a7ffemr1540255a34.15.1762625669187;
        Sat, 08 Nov 2025 10:14:29 -0800 (PST)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f11323a0sm3249772a34.27.2025.11.08.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:14:28 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v6 1/5] io_uring/zcrx: count zcrx users
Date: Sat,  8 Nov 2025 10:14:19 -0800
Message-ID: <20251108181423.3518005-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251108181423.3518005-1-dw@davidwei.uk>
References: <20251108181423.3518005-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

zcrx tries to detach ifq / terminate page pools when the io_uring ctx
owning it is being destroyed. There will be multiple io_uring instances
attached to it in the future, so add a separate counter to track the
users. Note, refs can't be reused for this purpose as it only used to
prevent zcrx and rings destruction, and also used by page pools to keep
it alive.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 7 +++++--
 io_uring/zcrx.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 5f7a1b29842e..de4ba6e61130 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -482,6 +482,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 	spin_lock_init(&ifq->rq_lock);
 	mutex_init(&ifq->pp_lock);
 	refcount_set(&ifq->refs, 1);
+	refcount_set(&ifq->user_refs, 1);
 	return ifq;
 }
 
@@ -742,8 +743,10 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 		if (!ifq)
 			break;
 
-		io_close_queue(ifq);
-		io_zcrx_scrub(ifq);
+		if (refcount_dec_and_test(&ifq->user_refs)) {
+			io_close_queue(ifq);
+			io_zcrx_scrub(ifq);
+		}
 		io_put_zcrx_ifq(ifq);
 	}
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index f29edc22c91f..32ab95b2cb81 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -55,6 +55,8 @@ struct io_zcrx_ifq {
 	struct net_device		*netdev;
 	netdevice_tracker		netdev_tracker;
 	refcount_t			refs;
+	/* counts userspace facing users like io_uring */
+	refcount_t			user_refs;
 
 	/*
 	 * Page pool and net configuration lock, can be taken deeper in the
-- 
2.47.3


