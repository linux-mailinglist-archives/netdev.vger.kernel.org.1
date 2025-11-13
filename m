Return-Path: <netdev+bounces-238288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F4C56FDF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 408EC344FDE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF933D6D5;
	Thu, 13 Nov 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5slMbys"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789033CE85
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030795; cv=none; b=k4SuQR/PhkqsBqnv4zXqPiN+WXEa1O7053K2fTq1/yobVMPFVc87krq36c+VaGCZ/XAGTvm67+vfMgY+hK6FlNm3jKutx39oOlLar21vW+5Lov7dRzsePNgym1jP2guMOTdNpTtWJm9xGGNCqV/Tx64I+DlNMnwASkmYfuJgz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030795; c=relaxed/simple;
	bh=OaILz3NDGjWldUWh2AZ17G0CzkHdvUBuhPwKbKivUR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBKYYE5Ao08N+xcNVH+lsQlxs813QQNQKLPAFKqBs+WptuANgibmSwTXyOK0mGRiiQEuoTKyW6kASL5c331dOyQXLHUTNlWZCysaxPnnbkIyAstvKWMOQd/LTrNyPQZq//itVQ00bZNObRiUVAuQQxWvpqrVBjjadoimrFfa6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5slMbys; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so4755735e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030792; x=1763635592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YIMwEByh+TEvupTVZZN+UcpOkMd7QdwsB9FAakJM2Y=;
        b=b5slMbysYBPtQxlQNy8sL9QPQpWnV9IS46mmo6IkCjf4mjY1Sk7LYS9xMDu4Q0xzZm
         SGgovhzmBU2HLAAGDvWEjzomHoqDKzQY3QkgZiJ5uzRD9DwZqj4iOPQzpJ0JcqlbSCkt
         Rdv3LZvO6wT/UftNg7g4Omsj73jbk0Q5sYXdebqucH0rbwVne7ahNJmxEC1oWUR3GxY0
         XoBS5xWEYnIdOLIH5sCxvvwc/rlblYoYiEfOZ6AfPFUIffFQbcXLZjByexevTr/fSLAd
         Oox4ioIucRXssiwU9vBVKXbly7t+IeqTYMuBJ1FeZ45i+mxPwmPI0BORR09flTiS4ZJK
         o1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030792; x=1763635592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YIMwEByh+TEvupTVZZN+UcpOkMd7QdwsB9FAakJM2Y=;
        b=EmYvPzu4I45U0NOy/AgsjiDiSoXbRCo4JmQzLebhdvHOnq2wJCIYV0dxNIaFWqMfOH
         6msHdFMR5bUuZFI1xDYkR5m41i+ezNH1r+WJfN6W+sI4JKAGUtDm27nWlLFpCVv0n+d6
         QADce9R9Q3On32EOysoc5dAbJlTMxFla8yG9JAa6msGIkyrA0Zm3bksh74fAdbr9k2oy
         rdF42nbSpNmVnR1LhbpXZObOJeVhZaFBoiY+cEHQtfIFob6K5bDRzUEv4YCgw/OBCdhB
         o1W2xGCZXXffthW4KtksfkrbtzCtVekXyk/hmeJBeFz0boMTK3k+JcIuJeXM7OkscuaJ
         lHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUPQe4jFiInLgw7ps4FERmelY5H3ziSE9Gjqegvf9YChZMF4bE7K5K6FKqpmHLUachngtA7KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWUO/7P2N9i0WshpBq9g0XsZModdaYAedYZAQxoGsHhTO7f+j
	C+0c/ym2JM6bx4Tl9FQnVkvJ/SpMDXR3HO/mBCbYQINWVImQuYGugFwb
X-Gm-Gg: ASbGnctjhY/aw1S4/1mZsjrxElTLmYZFv2tN/PPiWhAwMekosxa4OwSffqP9BXZ3vyy
	cKFx5s3WMvExWxWI9ZVmqJb2K/3T045v27KohUSYpoq9um7SWhocuf2sUxLkrwGFdnf9V9M0Was
	O4noShdLa1rTHXZfhghY7FXLeVkJntX3HHQ38CenbS2OHZZ9utZ/X70OKFliVR6zMIpNkTwGJDL
	pN8JiSJKm11HOu1xDDfyF9Ezqp6pBkjPzfQZVPnHDy0j3pmBBc/A3qZlAGEoM/CD4tQwdARkntC
	6VlhebNSxV3NMh6xqGBz6wM//2uQyFL6BerbFSHMNvkqOXAfIkf+KkCO0UAPgHrcG3EaJ+d7JpB
	L6AFqEMyfuFvCqX4xEy3xHkGV0KGe91auYARDFNU0czKCEh70NgIvXXqWCio=
X-Google-Smtp-Source: AGHT+IFqn1X5hq7U//MnJeKdagqQJxtyS6zorBPY1bk63dJjS6CNf9uUBuXVG3+J+Kqkg24gHF9vKg==
X-Received: by 2002:a05:6000:1acf:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-42b4bb9894amr5618983f8f.16.1763030791955;
        Thu, 13 Nov 2025 02:46:31 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:30 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 05/10] io_uring/zcrx: add sync refill queue flushing
Date: Thu, 13 Nov 2025 10:46:13 +0000
Message-ID: <287ddbe37aaad197cd64e10f6e41ed7c35d79e38.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an zcrx interface via IORING_REGISTER_ZCRX_CTRL that forces the
kernel to flush / consume entries from the refill queue. Just as with
the IORING_REGISTER_ZCRX_REFILL attempt, the motivation is to address
cases where the refill queue becomes full, and the user can't return
buffers and needs to stash them. It's still a slow path, and the user
should size refill queue appropriately, but it should be helpful for
handling temporary traffic spikes and other unpredictable conditions.

The interface is simpler comparing to ZCRX_REFILL as it doesn't need
temporary refill entry arrays and gives natural batching, whereas
ZCRX_REFILL requires even more user logic to be somewhat efficient.

Also, add a structure for the operation. It's not currently used but
can serve for future improvements like limiting the number of buffers to
process, etc.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring.h | 10 ++++-
 io_uring/zcrx.c               | 74 +++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 5b7851704efe..7e20a555b697 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1086,13 +1086,21 @@ struct io_uring_zcrx_ifq_reg {
 };
 
 enum zcrx_ctrl_op {
+	ZCRX_CTRL_FLUSH_RQ,
+
 	__ZCRX_CTRL_LAST,
 };
 
+struct zcrx_ctrl_flush_rq {
+	__u64		__resv[6];
+};
+
 struct zcrx_ctrl {
 	__u32	zcrx_id;
 	__u32	op; /* see enum zcrx_ctrl_op */
-	__u64	__resv[8];
+	__u64	__resv[2];
+
+	struct zcrx_ctrl_flush_rq	zc_flush;
 };
 
 #ifdef __cplusplus
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0b5f4320c7a9..08c103af69bc 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -941,6 +941,71 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.uninstall		= io_pp_uninstall,
 };
 
+static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
+			      struct io_zcrx_ifq *zcrx)
+{
+	unsigned int mask = zcrx->rq_entries - 1;
+	unsigned int i;
+
+	guard(spinlock_bh)(&zcrx->rq_lock);
+
+	nr = min(nr, io_zcrx_rqring_entries(zcrx));
+	for (i = 0; i < nr; i++) {
+		struct io_uring_zcrx_rqe *rqe = io_zcrx_get_rqe(zcrx, mask);
+		struct net_iov *niov;
+
+		if (!io_parse_rqe(rqe, zcrx, &niov))
+			break;
+		netmem_array[i] = net_iov_to_netmem(niov);
+	}
+
+	smp_store_release(&zcrx->rq_ring->head, zcrx->cached_rq_head);
+	return i;
+}
+
+#define ZCRX_FLUSH_BATCH 32
+
+static void zcrx_return_buffers(netmem_ref *netmems, unsigned nr)
+{
+	unsigned i;
+
+	for (i = 0; i < nr; i++) {
+		netmem_ref netmem = netmems[i];
+		struct net_iov *niov = netmem_to_net_iov(netmem);
+
+		if (!io_zcrx_put_niov_uref(niov))
+			continue;
+		if (!page_pool_unref_and_test(netmem))
+			continue;
+		io_zcrx_return_niov(niov);
+	}
+}
+
+static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
+			 struct zcrx_ctrl *ctrl)
+{
+	struct zcrx_ctrl_flush_rq *frq = &ctrl->zc_flush;
+	netmem_ref netmems[ZCRX_FLUSH_BATCH];
+	unsigned total = 0;
+	unsigned nr;
+
+	if (!mem_is_zero(&frq->__resv, sizeof(frq->__resv)))
+		return -EINVAL;
+
+	do {
+		nr = zcrx_parse_rq(netmems, ZCRX_FLUSH_BATCH, zcrx);
+
+		zcrx_return_buffers(netmems, nr);
+		total += nr;
+
+		if (fatal_signal_pending(current))
+			break;
+		cond_resched();
+	} while (nr == ZCRX_FLUSH_BATCH && total < zcrx->rq_entries);
+
+	return 0;
+}
+
 int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 {
 	struct zcrx_ctrl ctrl;
@@ -956,10 +1021,13 @@ int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 	zcrx = xa_load(&ctx->zcrx_ctxs, ctrl.zcrx_id);
 	if (!zcrx)
 		return -ENXIO;
-	if (ctrl.op >= __ZCRX_CTRL_LAST)
-		return -EOPNOTSUPP;
 
-	return -EINVAL;
+	switch (ctrl.op) {
+	case ZCRX_CTRL_FLUSH_RQ:
+		return zcrx_flush_rq(ctx, zcrx, &ctrl);
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
-- 
2.49.0


