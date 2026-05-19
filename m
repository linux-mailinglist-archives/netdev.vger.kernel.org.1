Return-Path: <netdev+bounces-289428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePMwCYhODGpIeQUAu9opvQ
	(envelope-from <netdev+bounces-289428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E157E068
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE21B307DBBE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8844A33E7;
	Tue, 19 May 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su3/4BSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C34ADD92
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191097; cv=none; b=W4fCZFNwouyE9+1LVFGEvUkerEKF3eT+0fnO6gomDjN5aqUdZIMGpgAIOK7RGqudg0EVUBC/p/oUcz3NQF9XSBaF31+4UzCyBzecvibinMBfW9dL8KCbKDlIBoMfYAzZcjjHvBVDDoXCyqpvQrfzXlmhyceb+TjsqO0RRvvGeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191097; c=relaxed/simple;
	bh=1zvU4qDU3wb/QrygFCd/fJolYUBpm/KxkaIj5NT1G6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSCBcR7xaHiuOEc7EuJNNlMQEfaBgZVixvOsTp98ZMDfhvSEiBndUp9jJErN3VWN1yynuLOIgOtVV2bEZQRH+MTaaddUu3SeV5Rtz2xEWe5oxF0C9UYPmkOTHmPca2DUdH9imCdhaKyzOiWTdY7BW71OB+poIPxjVskopX5nZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su3/4BSZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2285689f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191089; x=1779795889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luu8jX5cIjKbqkRB8ggTWk1NRCDjwOjrRyL7Z363S/c=;
        b=Su3/4BSZZ75dOBgqP0ItSC3LjSN1YBdVz9Sq7HDy7DHRkSwDUZ4CK1C5NkLkHKgSJH
         idYEqUyrSCUDyb4nZa6Cl/WQyRpwv7kIZkIys9H0fWIpg5O7yY50EcMzvbw4am5ljBcn
         6gJ4lHeZHHsN0gCl/K7/+VzrarGYGrS80m4Et5iGTgj43uxIUCKQsT+thl+VI47JzmrV
         vBtRzGZ+2CWTQv6dHA6HJzglsBmtDYVRznkye7P4JE/ir1CqOjAjfjWFdzGk7yH2dPc3
         4hAsBLze2HHIENfFaLJ0toREy0bQtqgxdy/8R0jy/1arjFupwM119ydoijlOAR5jfG+R
         1NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191089; x=1779795889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=luu8jX5cIjKbqkRB8ggTWk1NRCDjwOjrRyL7Z363S/c=;
        b=BP/efD+e9Wdwbkh4NOU1KxJ+qaWIjt3j5fgFser7D2bg7oG/ts0uorU5LwX5g0Wabp
         5Qm/5etdhaI9R7Szmdmhlh9gIs6/m5GmrV0rnVTYxa+tLun4XfT8vunxrDqv68IM75vq
         0XTZD/YmpbKEnSgp2Mppz7+SCkzXwNkEGuiq7Gc9iVPVFGr5+QMHt1VE5qm19bYGEIW7
         jMz3JtfK85ZqYccpwt17Rlmo3jPf91UQKcXPVZflPbHvtVdcn1l+L5lKVa2bIFZlR45k
         f03nP9x7GzooOqWad7yctdqEmrIvE1Hh8tjcCA1Q+OqWM7DSfJAqYaToNcxLJpC+LmGM
         w4Ww==
X-Forwarded-Encrypted: i=1; AFNElJ8lqhOXxCcbtLoRReQDukAK1fAw+IbX5oQISqUJtLPOepMKPXH+dFTI7po/4HXMWPSEPzCRMpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5232utAVvj2d7e0qxnFAuI5eZjUN+Clo4H8yMBPR/2CiMpQL
	8+xLMfVPgovvMsdUm9hdIlAt87rEh3VXQ9XEugQBHJwG6ajBi4nNv+qw
X-Gm-Gg: Acq92OFgmWSVFX0WkVyOvpAqsm/PBCeeQH4hrhtzeGjvQ8F/xEPOSU+AvALgdnQwaJZ
	ZldTL3mZTgx9wHedYZux3XGTiaX6taqzc1+96rOXe1co4sHUui4/XyKkMljtGQSHWv0UNsWIf9M
	xmaoAJ8IM3Ey8M5jtEi5/0JoI0QMZGymfA2dE9MA9jzxmYPLJs1izwk/EyTwOTy9CXIa8y+hAfu
	wkNkZaVo30MqnwwkYs4UDnwmR4JP8PBmGfREg306Z1o0Xc5PLkWdvg3KOpDs+1Tw141v8ZsBhCH
	pwcjcguFGv/AZmt8HM8CjwGu5/IIYOeoCdltqYGCUldBdooD0jbAJhoZwZbwG56ap+elEMtKef9
	KtQIicGhz52meRLPNl4knCatcNEOFo1KBkgXcVvTHDZw6bi8BCVdyZGIsPzG3/55ZIJYUJooGi/
	iHKFEZkV8AlYlV2FF7JbvNCRMtIw7lcG9O/yuN96ADBy/4Dey8DURaeDN3p5JacTzGVBet/tFOH
	SROndT0nI0AI/gLlKDE1MPknwIhEA==
X-Received: by 2002:a05:600c:828d:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fe61eb313mr289522045e9.15.1779191089008;
        Tue, 19 May 2026 04:44:49 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:48 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6/8] io_uring/zcrx: notify user when out of buffers
Date: Tue, 19 May 2026 12:44:32 +0100
Message-ID: <35cd307a03a43583838a2e151fc641c69abd786f.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289428-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B78E157E068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are currently no easy ways for the user to know if zcrx is out of
buffers and page pool fails to allocate. Add uapi for zcrx to communicate
it back.

It's implemented as a separate CQE, which for now is posted to the creator
ctx. To use it, on registration the user space needs to pass an instance
of struct zcrx_notification_desc, which tells the kernel the user_data
for resulting CQEs and which event types are expected / allowed.

When an allowed event happens, zcrx will post a CQE containing the
specified user_data, and lower bits of cqe->res will be set to the event
mask. Before the kernel could post another notification of the given
type, the user needs to acknowledge that it processed the previous one
by issuing IORING_REGISTER_ZCRX_CTRL with ZCRX_CTRL_ARM_NOTIFICATION.

The only notification type the patch implements is
ZCRX_NOTIF_NO_BUFFERS, but we'll need more of them in the future.

Co-developed-by: Vishwanath Seshagiri <vishs@meta.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/zcrx.h | 24 ++++++++-
 io_uring/io_uring.c                |  2 +-
 io_uring/io_uring.h                |  1 +
 io_uring/zcrx.c                    | 86 +++++++++++++++++++++++++++++-
 io_uring/zcrx.h                    |  7 ++-
 5 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index 5ce02c7a6096..67185566ad3c 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -65,6 +65,20 @@ enum zcrx_features {
 	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
 	 */
 	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
+	ZCRX_FEATURE_NOTIFICATION	= 1 << 1,
+};
+
+enum zcrx_notification_type {
+	ZCRX_NOTIF_NO_BUFFERS,
+
+	__ZCRX_NOTIF_TYPE_LAST,
+};
+
+struct zcrx_notification_desc {
+	__u64	user_data;
+	__u32	type_mask;
+	__u32	__resv1;
+	__u64	__resv2[10];
 };
 
 /*
@@ -82,12 +96,14 @@ struct io_uring_zcrx_ifq_reg {
 	struct io_uring_zcrx_offsets offsets;
 	__u32	zcrx_id;
 	__u32	rx_buf_len;
-	__u64	__resv[3];
+	__u64	notif_desc; /* see struct zcrx_notification_desc */
+	__u64	__resv[2];
 };
 
 enum zcrx_ctrl_op {
 	ZCRX_CTRL_FLUSH_RQ,
 	ZCRX_CTRL_EXPORT,
+	ZCRX_CTRL_ARM_NOTIFICATION,
 
 	__ZCRX_CTRL_LAST,
 };
@@ -101,6 +117,11 @@ struct zcrx_ctrl_export {
 	__u32 		__resv1[11];
 };
 
+struct zcrx_ctrl_arm_notif {
+	__u32		notif_type;
+	__u32		__resv[11];
+};
+
 struct zcrx_ctrl {
 	__u32	zcrx_id;
 	__u32	op; /* see enum zcrx_ctrl_op */
@@ -109,6 +130,7 @@ struct zcrx_ctrl {
 	union {
 		struct zcrx_ctrl_export		zc_export;
 		struct zcrx_ctrl_flush_rq	zc_flush;
+		struct zcrx_ctrl_arm_notif	zc_arm_notif;
 	};
 };
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2ebb0ba37c4f..c5972274cce1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -160,7 +160,7 @@ static void io_poison_cached_req(struct io_kiocb *req)
 	req->apoll = IO_URING_PTR_POISON;
 }
 
-static void io_poison_req(struct io_kiocb *req)
+void io_poison_req(struct io_kiocb *req)
 {
 	io_poison_cached_req(req);
 	req->async_data = IO_URING_PTR_POISON;
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index e612a66ee80e..de0a3bed58d1 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -213,6 +213,7 @@ bool __io_alloc_req_refill(struct io_ring_ctx *ctx);
 
 void io_activate_pollwq(struct io_ring_ctx *ctx);
 void io_restriction_clone(struct io_restriction *dst, struct io_restriction *src);
+void io_poison_req(struct io_kiocb *req);
 
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
 {
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 2d8a0c453212..455226790553 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -767,6 +767,8 @@ static int import_zcrx(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (reg->if_rxq || reg->rq_entries || reg->area_ptr || reg->region_ptr)
 		return -EINVAL;
+	if (reg->notif_desc)
+		return -EINVAL;
 	if (reg->flags & ~ZCRX_REG_IMPORT)
 		return -EINVAL;
 
@@ -855,6 +857,7 @@ static int zcrx_register_netdev(struct io_zcrx_ifq *ifq,
 int io_register_zcrx(struct io_ring_ctx *ctx,
 		     struct io_uring_zcrx_ifq_reg __user *arg)
 {
+	struct zcrx_notification_desc notif;
 	struct io_uring_zcrx_area_reg area;
 	struct io_uring_zcrx_ifq_reg reg;
 	struct io_uring_region_desc rd;
@@ -898,10 +901,22 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 	if (copy_from_user(&area, u64_to_user_ptr(reg.area_ptr), sizeof(area)))
 		return -EFAULT;
 
+	memset(&notif, 0, sizeof(notif));
+	if (reg.notif_desc && copy_from_user(&notif, u64_to_user_ptr(reg.notif_desc),
+					     sizeof(notif)))
+		return -EFAULT;
+	if (notif.type_mask & ~ZCRX_NOTIF_TYPE_MASK)
+		return -EINVAL;
+	if (notif.__resv1 || !mem_is_zero(&notif.__resv2, sizeof(notif.__resv2)))
+		return -EINVAL;
+
 	ifq = io_zcrx_ifq_alloc(ctx);
 	if (!ifq)
 		return -ENOMEM;
 
+	ifq->notif_data = notif.user_data;
+	ifq->allowed_notif_mask = notif.type_mask;
+
 	if (ctx->user) {
 		get_uid(ctx->user);
 		ifq->user = ctx->user;
@@ -953,7 +968,8 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
-	zcrx_set_ring_ctx(ifq, ctx);
+	if (notif.type_mask)
+		zcrx_set_ring_ctx(ifq, ctx);
 	return 0;
 err:
 	scoped_guard(mutex, &ctx->mmap_lock)
@@ -1126,6 +1142,48 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
 	return allocated;
 }
 
+static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
+{
+	struct io_kiocb *req = tw_req.req;
+	struct io_ring_ctx *ctx = req->ctx;
+
+	io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
+	percpu_ref_put(&ctx->refs);
+	io_poison_req(req);
+	kmem_cache_free(req_cachep, req);
+}
+
+static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
+{
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
+	u32 type_mask = 1 << type;
+	struct io_kiocb *req;
+
+	if (!(type_mask & ifq->allowed_notif_mask))
+		return;
+
+	guard(spinlock_bh)(&ifq->ctx_lock);
+	if (!ifq->master_ctx)
+		return;
+	if (type_mask & ifq->fired_notifs)
+		return;
+
+	req = kmem_cache_alloc(req_cachep, gfp);
+	if (unlikely(!req))
+		return;
+
+	ifq->fired_notifs |= type_mask;
+
+	req->opcode = IORING_OP_NOP;
+	req->cqe.user_data = ifq->notif_data;
+	req->cqe.res = type;
+	req->ctx = ifq->master_ctx;
+	percpu_ref_get(&req->ctx->refs);
+	req->tctx = NULL;
+	req->io_task_work.func = zcrx_notif_tw;
+	io_req_task_work_add(req);
+}
+
 static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 {
 	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
@@ -1142,8 +1200,10 @@ static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 		goto out_return;
 
 	allocated = io_zcrx_refill_slow(pp, ifq, netmems, to_alloc);
-	if (!allocated)
+	if (!allocated) {
+		zcrx_send_notif(ifq, ZCRX_NOTIF_NO_BUFFERS);
 		return 0;
+	}
 out_return:
 	zcrx_sync_for_device(pp, ifq, netmems, allocated);
 	allocated--;
@@ -1292,12 +1352,32 @@ static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
 	return 0;
 }
 
+static int zcrx_arm_notif(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
+			  struct zcrx_ctrl *ctrl)
+{
+	const struct zcrx_ctrl_arm_notif *an = &ctrl->zc_arm_notif;
+	unsigned type_mask;
+
+	if (an->notif_type >= __ZCRX_NOTIF_TYPE_LAST)
+		return -EINVAL;
+	if (!mem_is_zero(&an->__resv, sizeof(an->__resv)))
+		return -EINVAL;
+
+	guard(spinlock_bh)(&zcrx->ctx_lock);
+	type_mask = 1U << an->notif_type;
+	if (type_mask & ~zcrx->fired_notifs)
+		return -EINVAL;
+	zcrx->fired_notifs &= ~type_mask;
+	return 0;
+}
+
 int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 {
 	struct zcrx_ctrl ctrl;
 	struct io_zcrx_ifq *zcrx;
 
 	BUILD_BUG_ON(sizeof(ctrl.zc_export) != sizeof(ctrl.zc_flush));
+	BUILD_BUG_ON(sizeof(ctrl.zc_export) != sizeof(ctrl.zc_arm_notif));
 
 	if (nr_args)
 		return -EINVAL;
@@ -1315,6 +1395,8 @@ int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 		return zcrx_flush_rq(ctx, zcrx, &ctrl);
 	case ZCRX_CTRL_EXPORT:
 		return zcrx_export(ctx, zcrx, &ctrl, arg);
+	case ZCRX_CTRL_ARM_NOTIFICATION:
+		return zcrx_arm_notif(ctx, zcrx, &ctrl);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 76389a5dd50f..e8b7717d6adf 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -9,7 +9,9 @@
 #include <net/net_trackers.h>
 
 #define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT | ZCRX_REG_NODEV)
-#define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE)
+#define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE |\
+					 ZCRX_FEATURE_NOTIFICATION)
+#define ZCRX_NOTIF_TYPE_MASK		(1U << ZCRX_NOTIF_NO_BUFFERS)
 
 struct io_zcrx_mem {
 	unsigned long			size;
@@ -75,6 +77,9 @@ struct io_zcrx_ifq {
 
 	spinlock_t			ctx_lock;
 	struct io_ring_ctx		*master_ctx;
+	u32				allowed_notif_mask;
+	u32				fired_notifs;
+	u64				notif_data;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.54.0


