Return-Path: <netdev+bounces-270519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIjNEy83wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:50:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B82F2391
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1C8306D377
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D5E3A960F;
	Mon, 23 Mar 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etLACBqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC639A7EF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269846; cv=none; b=nGSILdE2x9eZIqomgdV3FoeK0xJ3WCfR8LiaXT3dUwPMiXwVj1DpAYnbC9l6udjnxIKAkF96qW79F+ckxJlYWIoDZV/sWaXmY7/iFtgaA8OEGv0IQdtsJmbxDeCom+D7Zzzqbny2/hCUjkD23meiMej0VWQPIH3FsCxt/1Z16Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269846; c=relaxed/simple;
	bh=hcHiswI8Enk7ngY6IjB7vRUJTGacXZZNBOGSJouu+S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIe8FsN9efNIKjj2YVR0060ntSp1VhAPwffpf52RwM5pGhMcA/KOSLrSy0uniu80znNyNAP+jIM4SxenQWIbEObdOfOVe/NCukcvRYZZrUGqdt7lMOr4s1WK6La9BbbMvBZBdctjCQIcfMVTJZrmA9sUQuaEWCvImXMvbvhUcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etLACBqr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2596836f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269843; x=1774874643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4M+LNsDXPjhUL/AlYRYLcs09IR7UAhjljLQub/CJ7o=;
        b=etLACBqrFExPWkrLtHp6mDDPaGZeo+3hf0XuKwdMhkMcwNQw1wkRIRWzPdFu+DovcE
         AZj5NaJ0NpzD+l3tCw7rfMlPvf8sTkApDtI6SgmxYuG2w8UiC5qVb8n1dlPGZjSYQFn3
         yHN3OZekGmBKUDH6+/wV/YPpN6fdWltMAX8Xwpjpxdcndop2grBwtnCfTTCrmEbPu4gm
         lv9I4LjCNQ1VBRwXz4+LfHiRbOPfLIjGIZHql3yZGejTBOJ+4Gv1X3r+QUY6cJFWihos
         P81IERs/Q0xEtQuUX/r/iuEesrld8YHdrpLcMhv7jLY2vfPfl5yWoB/4L0k12qFUsnUN
         eCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269843; x=1774874643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4M+LNsDXPjhUL/AlYRYLcs09IR7UAhjljLQub/CJ7o=;
        b=kjHeKYuYIowpN44cMY5UVxLdeCDqPfBT3OWWxKjO7N0evNs9mKIibUJOFfqwgYelf6
         WWvxOJ3wz8YenyruZX6OcxMbSuBQQ5AK7Fp1sjluK0or6o53eONvkB/fZejSOuiThQZu
         jGOIS87B6LCVkpNrtIG8BBIEcIjZ/p0m4DFi/E4VVJurGNzXLNpCvYFkSIQ6SVs1TZc2
         YfXmxLtDBALCLXi6pzBnSUTyb7KRZIJB/NJLs/gTaWy2njkYWZH1UkkRIfxYTz53tVu2
         Zo5/H8Do/Jjz7KFr/YQr8Qe5xaQPSfO4QWmJHA08sc0LeM3IaTlZjGL96iauQWCBMoA6
         nhMA==
X-Forwarded-Encrypted: i=1; AJvYcCU57JnDTYhZbdAQxRudgHBEazgqu4GPjo4GL4c2LuxcSt50SSzoLOUpV86C8PsBgAINqsW4prk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHZ3pTWLlLcA5s0t3tNxr0ep4XbzGm2XCyP/+y005vdyD+jqd
	atiNCv5Dgx2rZHPEzIkEYOJUVpaoefSVwrFgIySJ3opso6Vj79wIfD/3
X-Gm-Gg: ATEYQzyS0PG7vz4aDTctIen2/WwcMopKWjDFL8fwL5D+dQsG8ER+jT8aZVnb6Jb3DZM
	4mMBheU5edT7jxX1YPx6ZiZG0PVO8B6rGZD8yo2M//v3a0XIKQbfHPwtfh9gf3ZvQhQSk9CUTxQ
	yNpQsPuuxbjE7eLyLpXvbrFdSoiu7iQT9ByMfy9l4vbFTKsRC1c5CXKFqpnykPrqbE0kkYjkfeD
	uRG00OG11tOZX92YgN0hdzVva/erD6goAuzC84XczrWa3/iA1ZN13zrxArLoCM6mOboqv41BKS7
	MfTi3j9EcG0acQfpq/fiIs6Zyysw4sJs0rfbE3M13/DoQhOJ7K9A66m7zZ8XQRX1hz9eorJmwh1
	YcYOsxn/UkQPc1288k8mZUG4R8K5IhU4RYXPFDmqhY72qZvwIL/QLJbmv3YThMyVGJUsm5zQZN6
	rU8wyrY8RnMpoc9OddWxXeUT8IxkIU3Q7+7JdkHSCmHkL/jh0yetkhrqagAePyZl6PN6sb9Mt74
	v416vYm8g==
X-Received: by 2002:a05:6000:2389:b0:43b:3a65:8c9d with SMTP id ffacd0b85a97d-43b6423b77emr18567089f8f.19.1774269843222;
        Mon, 23 Mar 2026 05:44:03 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:02 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	Youngmin Choi <youngminchoi94@gmail.com>
Subject: [PATCH io_uring-7.1 01/16] io_uring/zcrx: return back two step unregistration
Date: Mon, 23 Mar 2026 12:43:50 +0000
Message-ID: <0ce21f0565ab4358668922a28a8a36922dfebf76.1774261953.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC0B82F2391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are reports where io_uring instance removal takes too long and an
ifq reallocation by another zcrx instance fails. Split zcrx destruction
into two steps similarly how it was before, first close the queue early
but maintain zcrx alive, and then when all inflight requests are
completed, drop the main zcrx reference. For extra protection, mark
terminated zcrx instances in xarray and warn if we double put them.

Cc: stable@vger.kernel.org # 6.19+
Link: https://github.com/axboe/liburing/issues/1550
Reported-by: Youngmin Choi <youngminchoi94@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c |  4 ++++
 io_uring/zcrx.c     | 44 +++++++++++++++++++++++++++++++++++++++++---
 io_uring/zcrx.h     |  4 ++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6eaa21e09469..34104c256c88 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2308,6 +2308,10 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 	struct io_tctx_node *node;
 	int ret;
 
+	mutex_lock(&ctx->uring_lock);
+	io_terminate_zcrx(ctx);
+	mutex_unlock(&ctx->uring_lock);
+
 	/*
 	 * If we're doing polled IO and end up having requests being
 	 * submitted async (out-of-line), then completions can come in while
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 73fa82759771..8c76c174380d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -624,12 +624,17 @@ static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
 	}
 }
 
-static void zcrx_unregister(struct io_zcrx_ifq *ifq)
+static void zcrx_unregister_user(struct io_zcrx_ifq *ifq)
 {
 	if (refcount_dec_and_test(&ifq->user_refs)) {
 		io_close_queue(ifq);
 		io_zcrx_scrub(ifq);
 	}
+}
+
+static void zcrx_unregister(struct io_zcrx_ifq *ifq)
+{
+	zcrx_unregister_user(ifq);
 	io_put_zcrx_ifq(ifq);
 }
 
@@ -887,6 +892,36 @@ static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 	return &area->nia.niovs[niov_idx];
 }
 
+static inline bool is_zcrx_entry_marked(struct io_ring_ctx *ctx, unsigned long id)
+{
+	return xa_get_mark(&ctx->zcrx_ctxs, id, XA_MARK_0);
+}
+
+static inline void set_zcrx_entry_mark(struct io_ring_ctx *ctx, unsigned long id)
+{
+	xa_set_mark(&ctx->zcrx_ctxs, id, XA_MARK_0);
+}
+
+void io_terminate_zcrx(struct io_ring_ctx *ctx)
+{
+	struct io_zcrx_ifq *ifq;
+	unsigned long id = 0;
+
+	lockdep_assert_held(&ctx->uring_lock);
+
+	while (1) {
+		scoped_guard(mutex, &ctx->mmap_lock)
+			ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
+		if (!ifq)
+			break;
+		if (WARN_ON_ONCE(is_zcrx_entry_marked(ctx, id)))
+			break;
+		set_zcrx_entry_mark(ctx, id);
+		id++;
+		zcrx_unregister_user(ifq);
+	}
+}
+
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
@@ -898,12 +933,15 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 			unsigned long id = 0;
 
 			ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
-			if (ifq)
+			if (ifq) {
+				if (WARN_ON_ONCE(!is_zcrx_entry_marked(ctx, id)))
+					break;
 				xa_erase(&ctx->zcrx_ctxs, id);
+			}
 		}
 		if (!ifq)
 			break;
-		zcrx_unregister(ifq);
+		io_put_zcrx_ifq(ifq);
 	}
 
 	xa_destroy(&ctx->zcrx_ctxs);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 0ddcf0ee8861..0316a41a3561 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -74,6 +74,7 @@ int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_arg);
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			 struct io_uring_zcrx_ifq_reg __user *arg);
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx);
+void io_terminate_zcrx(struct io_ring_ctx *ctx);
 int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 		 struct socket *sock, unsigned int flags,
 		 unsigned issue_flags, unsigned int *len);
@@ -88,6 +89,9 @@ static inline int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 static inline void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 }
+static inline void io_terminate_zcrx(struct io_ring_ctx *ctx)
+{
+}
 static inline int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			       struct socket *sock, unsigned int flags,
 			       unsigned issue_flags, unsigned int *len)
-- 
2.53.0


