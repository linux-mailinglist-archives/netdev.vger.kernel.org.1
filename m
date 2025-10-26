Return-Path: <netdev+bounces-233011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDAC0AF08
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB513B2FBF
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F326E16E;
	Sun, 26 Oct 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kUGD415u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4924A079
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500081; cv=none; b=iMpnYbil/t/B6fOzFE4pAvOrrwzRoZeEGgd3+pCxSerBCQoc51E6DceHd8Espt6Qd7oL1OvYtMa9tJWRYXsk/Saw3tsDMsa6Eq+COn3cNkfpTRhGaL250XPlKP9QfrUsk2C02xmxe0Ds383FUypl1zwdDGkh+1XrrJc0qDpAm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500081; c=relaxed/simple;
	bh=ptG5+SHINYPHzYMQWRE05qadCLy7t9hxHMr2AoPLVBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fx5dpaTpgOw3NXkMKEbthuFFQQiKt09pFg8ujXg8/Z8Bi3saAnbl+IrCm7kPz+OvkUIxJFcH5kAGXd50xnxVRHRwgiUuSftIaRYBe3+wrS4sURfn3wknSqR+sbqxpZMJyf7AxbRonTfl0WWQNnHVpi+ozrGxva4tgRGrIMKtbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=kUGD415u; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-36f13d00674so3023029fac.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761500079; x=1762104879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wrMkWzoqje6s8rXMO2Ji8dE/ng2JvcyGTWZGSmHOPs=;
        b=kUGD415uAdTRYrWftb0tsp+blv54YLNyPgxpyPnnRarv3J3oEnGVDcdX7ryhxvhQbI
         lPacRXQSH4EpmNI7pgb1KIZL1q24GMD3wM7bCMSHEVIcpfzwO20s37grBPQJ1YkKLCC5
         esDl7ncc4VcjOWvPAWHrm9NFhC7uLPKkR2zAlzKUqQdzzcnMp+70x/kJsFowpsXc0p/X
         XW1vklUSKTT5emKTEUI4duuQNxGFVbnQ0uN0YLsqQR0S2KOS5wua0Y+OCtnnzUgwdrKY
         NlhGBhFgLAKapYbuxS4RonIQ5FTfR7hcHOYith7VEgNuA7D/Ru7zvkG3JcLze4uzDgww
         +pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500079; x=1762104879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wrMkWzoqje6s8rXMO2Ji8dE/ng2JvcyGTWZGSmHOPs=;
        b=f5h4qrXLKV5hA3fnjRL85bvYhWj0dikT1oWY6tJB37BQAOnre8bALJXOVSnPVqmfZk
         5Jqua6qEyHaprkH3IR7N38OUaX8eN0IY7i5vnJ4fLabLJtwektAYnj9PLPc5U1jydZaF
         URz91f2VYmeFmV6sIKo6P3GJkEP7RoAmrBeUpcD8OXFszk2mFJI8nxiQ9uwSy+TN4TFU
         F4VqYVJRGiyKULceslcYZJ1pvBBuQNAVNaJKjkmMpYEWPaRWn5rKsl/PhgjtfF6SaYOe
         CQNaqhm5XtIRTJXktyTtlNltz1bhrgCLmfw2jTvAHQjqwAmUAtx2ijLvx1TcsFLg3qkf
         P0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWj238h9/QJ+608YiEslnsT98wLLoLS/LgxodNqUehNMb0uUrCUSJ5JcqxP/EvNHIx8jjJGdbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvacC8205a2OpQalYMzxINvuA6xtiqEytdqqQkb1APvuuRWtGu
	gIIklhWE5Qy7agUOYVDI9dpQntN4hy3Oj1tTg4lbGQ4NLS3Z6tM4cJnDG244XPNGLns=
X-Gm-Gg: ASbGncumD9rOpx2xmf7l2K01TSBNOaVSj4UFwP8Nafo424/Pq1u0VWM3ifJg3Xol5WU
	IDFr9iZPNRYQQHh5dupV9XDs8NSEeRSAyV+csjX6KkluKeJbM63NjQIUX/johmIBJH1vYLEM3Uz
	nv1LuWY8aeP0lruBJSAQN/oHhfXZoxTX4ofXqjFS8WitvxeQdylNIKGiK++cKbcYLzR1tkIQign
	MnYPh/EpopbpIlcbIjOVAcMgdRekZpbBZoF1++/xZYR8ECLgEMMAhWQSgFXPEyIoKAUvoxWw9zr
	SxEGzuhqldQ7+9r9Fm4QUKZoUu6zGAuABCs5FF3D/GJf7iB49hHVQLNA4e25NNOyPePX8ZZTy50
	2gy2QwqaJRahNAKc+tfMe3yKN+L/zBi9Q5RwQTaOEgTVQSkwm2DRGFq1BEolBP8nYACZDuT/0GW
	Sq34g9gB2m6I3QalmonLt6lm2bjIRK1xZ/px1BtzcA
X-Google-Smtp-Source: AGHT+IETgiVRAvYzKc9+muMhxPRKQtXTMdXZxmGX5DWCFg9o6Ft2lMDorH+B92tbCy0AIO8oCI10JA==
X-Received: by 2002:a05:6870:a082:b0:315:b768:bd1d with SMTP id 586e51a60fabf-3c98cef6f18mr14871746fac.6.1761500079329;
        Sun, 26 Oct 2025 10:34:39 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5301188d1sm1551230a34.3.2025.10.26.10.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:34:38 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v3 2/3] io_uring/zcrx: add refcount to struct io_zcrx_ifq
Date: Sun, 26 Oct 2025 10:34:33 -0700
Message-ID: <20251026173434.3669748-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026173434.3669748-1-dw@davidwei.uk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a refcount to struct io_zcrx_ifq to track the number of rings that
share it. For now, this is only ever 1 i.e. not shared, but will be
larger once shared ifqs are added.

This ref is dec and tested in io_shutdown_zcrx_ifqs() to ensure that an
ifq is not cleaned up while there are still rings using it.

It's important to note that io_shutdown_zcrx_ifqs() may be called in a
loop in io_ring_exit_work() while waiting for ctx->refs to drop to 0.
Use XArray marks to ensure that the refcount dec only happens once.

The cleanup functions io_zcrx_scrub() and io_close_queue() only take ifq
locks and do not need anything from the ring ctx. Therefore it is safe
to call from any ring.

Opted for a bog standard refcount_t. The inc and dec ops are expected to
happen during the slow setup/teardown paths only, and a src ifq is only
expected to be shared a handful of times at most.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 18 ++++++++++++++++--
 io_uring/zcrx.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a816f5902091..569cc0338acb 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -587,6 +587,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (!ifq)
 		return -ENOMEM;
 	ifq->rq_entries = reg.rq_entries;
+	refcount_set(&ifq->refs, 1);
 
 	scoped_guard(mutex, &ctx->mmap_lock) {
 		/* preallocate id */
@@ -730,8 +731,21 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 	lockdep_assert_held(&ctx->uring_lock);
 
 	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
-		io_zcrx_scrub(ifq);
-		io_close_queue(ifq);
+		if (xa_get_mark(&ctx->zcrx_ctxs, index, XA_MARK_0))
+			continue;
+
+		/* Safe to clean up from any ring. */
+		if (refcount_dec_and_test(&ifq->refs)) {
+			io_zcrx_scrub(ifq);
+			io_close_queue(ifq);
+		}
+
+		/*
+		 * This is called in a loop in io_ring_exit_work() until
+		 * ctx->refs drops to 0. Use marks to ensure refcounts are only
+		 * decremented once per ifq per ring.
+		 */
+		xa_set_mark(&ctx->zcrx_ctxs, index, XA_MARK_0);
 	}
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


