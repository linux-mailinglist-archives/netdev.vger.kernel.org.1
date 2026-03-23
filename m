Return-Path: <netdev+bounces-270534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJUuHCk2wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:46:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703F2F2295
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCF1C30217DD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18B3AC0F8;
	Mon, 23 Mar 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTFsMfSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0C3AC0CC
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269864; cv=none; b=tR/Lnv74k6O7H93qTIE+a0pJDGoDX6rZ6OZEhFOAqYsMsmoQ8bmuX2zJnClNTWd0RWlTjA7lKiAhmF8eNjhn2YdtfvNfT9jVH8OPEqPC5P/2PGmOu5NbG5IAGVukeF73r0sdINijVvz9N1mRZBNstARGN+r2eGh02FBtAyCNRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269864; c=relaxed/simple;
	bh=yIWu5pdnrtOkrME6WXuvUL0ap4Njt0Xp57JYC6efENU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKv6GGkvRsvB0sS4wRv+zobr/DBcAO6IiaJo+tBlFybF8MUdf/oVkBhw8m0nV+XCqCO0hkixlK1853IavVIPlajb4Wglyb0rCzViyMbIOtO5kfWwvOjbVNZ9F4CWDEi4pUXJuvLBnqv9eSpFkoLYP5Alb2b5W2rQ78MfSSEJnsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTFsMfSa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b5bded412so113752f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269861; x=1774874661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8T3jLqw58WVei3u9zgKQPg6WFseRWKGvJWz8TfzBKw=;
        b=WTFsMfSaTnjRBDKM0Tb8+I+evMNGrghFDSWHo9hvYG5vkzdwfi78tmwbgEOK6DBvhX
         77x9MOOuwWGBZoOwAFMo47mLp4U8ozhyz7apLHCYMVRJifyFMqE9T7I/ktB/qP1LMpVc
         0VAy4F7fbhRzvqY3oDUohxS7gkDEhuuVvYKlMRw5vwScXZgGjxKg0UF48bzuqfmpEf7i
         qHxN2WMXjLSjQ0T8Gv2SxRxZ5BybCVrjjRY7ABs/J7OexM9QjxxnpKsYIo+eWyehWKAs
         QSYNylWLK/+c3J0Y5JHrcQXfXvLmVPQ3IJVb3eC1TYV1ZeXdXAxkzMaIkMcwCESvlIfR
         J/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269861; x=1774874661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8T3jLqw58WVei3u9zgKQPg6WFseRWKGvJWz8TfzBKw=;
        b=Pbj0d/FjDcA4FymXkvy4xeB3NNwcGx61ypHYPK2NhuHO/Hlr990XEJr29rwgiMcOID
         YmuzM1+FvS/JL60LjAAizj4KJmewguveGn8l5efRIaC1LPioSXOlP+Zuga+acQw4AWHK
         /jdjGYJRWRpFdGrVphSCFnfdMZ0sxNDrCSOnwT2C7t9FHMRYnWf1OjTx+TmDY9AV9aHV
         dz82AHjWH6A3Bq8AsJnjyh6C9lD5E63cTfBO7n5KLpPJeDuUGiwQom73sDeS4ffaiYmB
         lI4flR2s6nUeWz4iAaTlUcL2ktxFNrfZh9qKp3inG9NNCgxlzcFGLBetVRK/0Y/Ei/kT
         E5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXN0052WSGhHhM70ystMXXpx0wA8/hoNVlJ+GKsN4gRiQ+In0gEtbVYLJcGdwW0cj8kgRRUe3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNFC3N4B8S7/hI1GvQN+9FzXWpxuQPZpCdcOUaIFkMbitm8p6
	ReTyepssZP9U2JEhQ6IH8/MjLqCvfsfm2FZOmtBD1me8D7XUdK1D5b4f
X-Gm-Gg: ATEYQzwjoTBVLTYIvb/GJ3ceJc529C8WqXeMCGMpVGY8oFiOLz4CoPdFiaxJsc6cFdp
	pqVjeUnSf+qz0Axf7PhtK1B29PfAKbO9++jZmFrhB1IVPeGfdxYflEeBoZYmdA2BOTQWnb0nuRB
	P55NCBXr9Bhm3WZnxnnt29A6u/6pNzcz8qWVeTzkIg4cJ/xOK/9861fJ8104dRH8jfDJi3YazLm
	fcVoOaxCrmKvuv38kjBVas+mVPFfddfLupHGpi46GJjzo3ubO1ElZYw5NOvi3XiH542JoOnlQfo
	IVrQ8HatEqjCasHp1oTV6rWorgrqCvctqD3BZUNid8eIuk9sjvsmJsXQzONBWBXZYotwa5ZGD7I
	8aUeqsQ4CvM2+rMrwOLZoO/sOfO98FrpxHZ6122R+gUqhNq0V10hX4yYNNTPqLD0s8hgQWWwNNE
	mFWdp96D+S52rlmYAaEbfElVjrnjZI1RHrQXKbxedIoh4OZXvnP+QDDuGMJZH7GjoyEJbu8ocEy
	rrQLZEM3w==
X-Received: by 2002:a05:6000:25c1:b0:439:b3bb:2777 with SMTP id ffacd0b85a97d-43b6423bc5bmr19588109f8f.22.1774269861386;
        Mon, 23 Mar 2026 05:44:21 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:20 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 16/16] io_uring/zcrx: rename zcrx [un]register functions
Date: Mon, 23 Mar 2026 12:44:05 +0000
Message-ID: <657874acd117ec30fa6f45d9d844471c753b5a0f.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270534-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1703F2F2295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Drop "ifqs" from function names, as it refers to an interface queue and
there might be none once a device-less mode is introduced.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c |  2 +-
 io_uring/register.c |  2 +-
 io_uring/zcrx.c     |  6 +++---
 io_uring/zcrx.h     | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 34104c256c88..16122f877aed 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2156,7 +2156,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	mutex_lock(&ctx->uring_lock);
 	io_sqe_buffers_unregister(ctx);
 	io_sqe_files_unregister(ctx);
-	io_unregister_zcrx_ifqs(ctx);
+	io_unregister_zcrx(ctx);
 	io_cqring_overflow_kill(ctx);
 	io_eventfd_unregister(ctx);
 	io_free_alloc_caches(ctx);
diff --git a/io_uring/register.c b/io_uring/register.c
index 489a6feaf228..35432471a550 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -900,7 +900,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 		ret = -EINVAL;
 		if (!arg || nr_args != 1)
 			break;
-		ret = io_register_zcrx_ifq(ctx, arg);
+		ret = io_register_zcrx(ctx, arg);
 		break;
 	case IORING_REGISTER_RESIZE_RINGS:
 		ret = -EINVAL;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 620482cdb083..c2f4fd93b928 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -816,8 +816,8 @@ static int zcrx_register_netdev(struct io_zcrx_ifq *ifq,
 	return ret;
 }
 
-int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
-			  struct io_uring_zcrx_ifq_reg __user *arg)
+int io_register_zcrx(struct io_ring_ctx *ctx,
+		     struct io_uring_zcrx_ifq_reg __user *arg)
 {
 	struct io_uring_zcrx_area_reg area;
 	struct io_uring_zcrx_ifq_reg reg;
@@ -955,7 +955,7 @@ void io_terminate_zcrx(struct io_ring_ctx *ctx)
 	}
 }
 
-void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
+void io_unregister_zcrx(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 3e07238a4eb0..75e0a4e6ef6e 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -76,9 +76,9 @@ struct io_zcrx_ifq {
 
 #if defined(CONFIG_IO_URING_ZCRX)
 int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_arg);
-int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
+int io_register_zcrx(struct io_ring_ctx *ctx,
 			 struct io_uring_zcrx_ifq_reg __user *arg);
-void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx);
+void io_unregister_zcrx(struct io_ring_ctx *ctx);
 void io_terminate_zcrx(struct io_ring_ctx *ctx);
 int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 		 struct socket *sock, unsigned int flags,
@@ -86,12 +86,12 @@ int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
 					    unsigned int id);
 #else
-static inline int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
-					struct io_uring_zcrx_ifq_reg __user *arg)
+static inline int io_register_zcrx(struct io_ring_ctx *ctx,
+				   struct io_uring_zcrx_ifq_reg __user *arg)
 {
 	return -EOPNOTSUPP;
 }
-static inline void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
+static inline void io_unregister_zcrx(struct io_ring_ctx *ctx)
 {
 }
 static inline void io_terminate_zcrx(struct io_ring_ctx *ctx)
-- 
2.53.0


