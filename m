Return-Path: <netdev+bounces-232927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBEC09F12
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C23C3AE8F4
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2598306491;
	Sat, 25 Oct 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="WlVp7H2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2863054FB
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419715; cv=none; b=GiRSoKYB7GTG6jpJBrYpteZFOwqXj+jTp91mEptQoePTQa5pMjK7pw6mTA8nxd0hFWZdkGH+CoqWllUeeXQd8FUwmwdj529zwiqi0stmZ7oOyJ/J0Lqz4J+eaYP5j1eW9m+xrAoXdINuS89LGcr3sGTOUlsh2qqrb4qq3wmhBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419715; c=relaxed/simple;
	bh=ucFR12aXX4nkZAC+cILJgoMYYPjytPdbh2AHCMWelEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOalLGP/crCbVNfW8wVZJL5LMrLPqnkln8KlZvx3TobpUV+2WaLPJGIaYiPtOuo9WFc4JGDx90jVc2RsRbKbad7ZW94j6UTmKrP0zBvD6DcRzM3/Oyo1PoXLr5zVW54OUBfNoOqwA++1D96LfWTkfcmVAr8yk4h1kkyH4ArrYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=WlVp7H2j; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c5333e7033so110379a34.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761419713; x=1762024513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTyN43M0AVODz40WwOJi9olgyOCW2gYVIejIuZtFEBU=;
        b=WlVp7H2j9LfeJxJp+8JtJtE4WwWst5Ye+IoAa1GNGkpzjosAjI5WeQ0YbqSFpCi3v7
         0JYfqo1L53wwAfWwEKkBArkD/s61+cDimLt09j70ueNLrbOpr5qOHb5nC3s5rf84rLv1
         V8G+8yFKTAM7/cOYUc6Gl+QZHdAWWHlwb4Gwkl83ut6mC+hf2BTGUSKGINrCHgDddERN
         jwYfFKv7mZ3u7cAtvkmzyhSBsN5/fz2nYo/nlLK2oANlMEVNwv1+5akKbyq1PAmCoAnH
         ezMVZFgsE1btWTQlGjIdzPwic+MK7m/KayNKeCRw3uY4HRthN9PMOTEIEzOAwGwMEMAQ
         +axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419713; x=1762024513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTyN43M0AVODz40WwOJi9olgyOCW2gYVIejIuZtFEBU=;
        b=FQK7fJLGilw/qu04tjRxB7QhoB7246jPMAx/5yJTMVc1FJV1qRkecinftnioh5tUGk
         XZVXk+soRSgdgRhIzH7+iVdO/hP0HcmaSz/SIRTCjHc+CHUVYudaldQ7hKvQh9gS1dVi
         W9jSSoSn8OiE5GsUx1XjykOGkT50LlNEqlsSIEhSlXg8CCSKjFoUXTYu4JcJEpeSFcVS
         LjMBtzt5bG+5QMo3FyInO/R9brOqolImjR2gMeug99nnKcPWUoyrSFWhAUBKZW2oQyJm
         wIyyZlu4LEXEd+AAfRdtyQHt1vPzPblchXXtVXr+OtRQuU7kLa2B8vtw4iMLM0dEo7K7
         JmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvfe36QkDrL1DzjepmbiXYFWplOaP4CTSY8E6aZ+T3llhW4AWa+NByEdAeI8BeB7o6DAVQ0oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2VI71Qru7yxm0wJRj/h32xOWCEPnWKoAh3Fdi0s6bhvs7dmV
	9N2tyJpv7NTgi/9ez47yuXr03j41+npDy8AkLy8aWVhiVxJyU+MXLvyT134GCXL4gLo=
X-Gm-Gg: ASbGncvhx8k8lYdkGskTODrd16SeWEY8A7q5xvYs+jSEnrvnkiKn0HWn0eQiV5RJdQ5
	i5z1mmXBanAbZ4N6EDkb+qIPydsVOsypcDncVR8lD7dlXRlTO5SgqMJFAdx2IFayeGA3D6NXD1j
	GeQ+KqmQf42xCjrFstf7jDN+ngfljz//Z/gzejKIlDKC+TvFyV2ZS1AiDN8zVoUfq2TWf//P2RV
	px2ekMZ9kOkG7z4jP2TT/lmfiT05UwBEGo05mN4SXmrELk/denyL9IpeZWfKH5ye8Izcyh7jZ7e
	aV6iRADVickihurrdDhWbcihjkI2rx4WQRFhtCSRaB5Pny+nMbDkS2XibHJf0TkZ9NElpiuqbpY
	MiySILzIoXDtTiE6mEQg/c0zT8w3yRowq0qw7CqVjSBrcty9fVvEOuqk4uFxz6TLJSaZwZ5p1B9
	DWoFCLqVVQRZNubltCog==
X-Google-Smtp-Source: AGHT+IHZyXuxtYDqvOvduDQTElKwsWGyiSDlQerlgMWGZk7JveEdfvM8R4JWH5j0ns4dDn4DBRsAOw==
X-Received: by 2002:a05:6871:9c24:b0:3d2:c10b:cb45 with SMTP id 586e51a60fabf-3d2c10bd09dmr433476fac.9.1761419713012;
        Sat, 25 Oct 2025 12:15:13 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e2711a64sm902920fac.6.2025.10.25.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:15:12 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 2/5] io_uring/zcrx: add refcount to struct io_zcrx_ifq
Date: Sat, 25 Oct 2025 12:15:01 -0700
Message-ID: <20251025191504.3024224-3-dw@davidwei.uk>
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

Add a refcount to struct io_zcrx_ifq to track the number of proxy ifqs
that refer to it. The init count is 1 and means there are no proxy ifqs.

This ref is checked in io_shutdown_zcrx_ifqs() to ensure that an ifq is
not cleaned up while there are still proxy ifqs alive.

Opted for a bog standard refcount_t. The increment and decrement
operations are expected to happen during the slow setup/teardown paths
only, and a src ifq is only expected to be shared a handful of times at
most.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 3 +++
 io_uring/zcrx.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a816f5902091..22d759307c16 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -587,6 +587,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (!ifq)
 		return -ENOMEM;
 	ifq->rq_entries = reg.rq_entries;
+	refcount_set(&ifq->refs, 1);
 
 	scoped_guard(mutex, &ctx->mmap_lock) {
 		/* preallocate id */
@@ -730,6 +731,8 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 	lockdep_assert_held(&ctx->uring_lock);
 
 	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
+		if (refcount_read(&ifq->refs) > 1)
+			continue;
 		io_zcrx_scrub(ifq);
 		io_close_queue(ifq);
 	}
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 33ef61503092..566d519cbaf6 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -60,6 +60,8 @@ struct io_zcrx_ifq {
 	 */
 	struct mutex			pp_lock;
 	struct io_mapped_region		region;
+
+	refcount_t			refs;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.47.3


