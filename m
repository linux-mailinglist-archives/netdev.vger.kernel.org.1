Return-Path: <netdev+bounces-30829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43AB789301
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3341C2108D
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C8385;
	Sat, 26 Aug 2023 01:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3E1364
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:21:33 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910B9212B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0d0bf18d6so12748265ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20221208.gappssmtp.com; s=20221208; t=1693012892; x=1693617692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqXYs9JKDR7EAnDxjSwatlgPrNqTmHker8ZbKfpU3gE=;
        b=UZk+0Z3kfokcBJDT7Us5aYoJyw3bmhBrpP3D1m68k8z0cEpWjObh+WFmr51vihzjPP
         bqufzVhsbrXenQCvIWgY2qDhnhue+gMNiTI/o1sVl9bke6zeVKmAneedI70HmO4FxLz1
         iZsjCXllqi20cqKoKJ/KtvEpJdGk3zCBJSxEkoUzpzX9b+FSKwkfsKu7Mvm+H4n7jp+Q
         MnG173XXOoICRnBiyPlx/xDVoiIPt/cCCOmGU7xdS5PE9XDcAFHLiBA8IIugyaEJHxer
         KWfhU+Q8WFz8VAcg1yLWGcLEW4wp3+h//9AGP9dqhuuUDpTe+XO1C3nSoS+GNKtqTNy8
         PnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693012892; x=1693617692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqXYs9JKDR7EAnDxjSwatlgPrNqTmHker8ZbKfpU3gE=;
        b=VR1NORXNmnmmASlNUvO/OVlgs7PGN8iUnvWttzwUScIIPCIm45+gR+nxOB0uqQGz5t
         /J5SVPTv5GrJiQfzDdKUMF3WlHt5Oh2cpMW7uhIIGObPWNQvRHAF5urYaYdPKn2lz62l
         IrsNRVxLSeHlrjeFvniXUY1l5qeT7FrW8xcXcpbk/bjzIXmQ/1IUkRnXRBl4a7FdBJT/
         uopSAAqvbu4NHiCDsyKJK2T+Z7faLWShFl+4xxB/2J62HVISeKtT9RXUNTMljt9k+s8m
         5Py6eoRPRMq8ynQ+MuenyJI8/2XyRv4NLf15esW0gAevQvVMtc/e96EZnWYtkko7aIfY
         UrfA==
X-Gm-Message-State: AOJu0Yyci9cEhkqoIGGnSgcO3XfJ0VqonpMkwbJMhDj/mFKs/aSotERD
	2nsbiNRwgbp30Fqt5YVcDz7sMg==
X-Google-Smtp-Source: AGHT+IGCyPX2jM9xBria+78I08Xewm97ynjbJS1JDqK3/K/tRjHnCUZiK/uOI937WtjPOIVHyHjc5w==
X-Received: by 2002:a17:903:248:b0:1bc:8748:8bc0 with SMTP id j8-20020a170903024800b001bc87488bc0mr22750701plh.33.1693012892026;
        Fri, 25 Aug 2023 18:21:32 -0700 (PDT)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001bbb598b8bbsm2425852pli.41.2023.08.25.18.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:21:31 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 04/11] io_uring: setup ZC for an RX queue when registering an ifq
Date: Fri, 25 Aug 2023 18:19:47 -0700
Message-Id: <20230826011954.1801099-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230826011954.1801099-1-dw@davidwei.uk>
References: <20230826011954.1801099-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Wei <davidhwei@meta.com>

This patch sets up ZC for an RX queue in a net device when an ifq is
registered with io_uring. The RX queue is specified in the registration
struct. The XDP command added in the previous patch is used to enable or
disable ZC RX.

For now since there is only one ifq, its destruction is implicit during
io_uring cleanup.

Signed-off-by: David Wei <davidhwei@meta.com>
Co-developed-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 io_uring/io_uring.c |  1 +
 io_uring/zc_rx.c    | 62 +++++++++++++++++++++++++++++++++++++++++++--
 io_uring/zc_rx.h    |  1 +
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0b6c5508b1ca..f2ec0a454307 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3098,6 +3098,7 @@ static __cold void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	xa_for_each(&ctx->personalities, index, creds)
 		io_unregister_personality(ctx, index);
+	io_unregister_zc_rx_ifq(ctx);
 	if (ctx->rings)
 		io_poll_remove_all(ctx, NULL, true);
 	mutex_unlock(&ctx->uring_lock);
diff --git a/io_uring/zc_rx.c b/io_uring/zc_rx.c
index 6c57c9b06e05..8cc66731af5b 100644
--- a/io_uring/zc_rx.c
+++ b/io_uring/zc_rx.c
@@ -3,6 +3,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/io_uring.h>
+#include <linux/netdevice.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -10,6 +11,35 @@
 #include "kbuf.h"
 #include "zc_rx.h"
 
+typedef int (*bpf_op_t)(struct net_device *dev, struct netdev_bpf *bpf);
+
+static int __io_queue_mgmt(struct net_device *dev, struct io_zc_rx_ifq *ifq,
+			   u16 queue_id)
+{
+	struct netdev_bpf cmd;
+	bpf_op_t ndo_bpf;
+
+	ndo_bpf = dev->netdev_ops->ndo_bpf;
+	if (!ndo_bpf)
+		return -EINVAL;
+
+	cmd.command = XDP_SETUP_ZC_RX;
+	cmd.zc_rx.ifq = ifq;
+	cmd.zc_rx.queue_id = queue_id;
+
+	return ndo_bpf(dev, &cmd);
+}
+
+static int io_open_zc_rxq(struct io_zc_rx_ifq *ifq)
+{
+	return __io_queue_mgmt(ifq->dev, ifq, ifq->if_rxq_id);
+}
+
+static int io_close_zc_rxq(struct io_zc_rx_ifq *ifq)
+{
+	return __io_queue_mgmt(ifq->dev, NULL, ifq->if_rxq_id);
+}
+
 static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zc_rx_ifq *ifq;
@@ -19,12 +49,17 @@ static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
 		return NULL;
 
 	ifq->ctx = ctx;
+	ifq->if_rxq_id = -1;
 
 	return ifq;
 }
 
 static void io_zc_rx_ifq_free(struct io_zc_rx_ifq *ifq)
 {
+	if (ifq->if_rxq_id != -1)
+		io_close_zc_rxq(ifq);
+	if (ifq->dev)
+		dev_put(ifq->dev);
 	io_free_rbuf_ring(ifq);
 	kfree(ifq);
 }
@@ -41,17 +76,22 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	if (ctx->ifq)
 		return -EBUSY;
+	if (reg.if_rxq_id == -1)
+		return -EINVAL;
 
 	ifq = io_zc_rx_ifq_alloc(ctx);
 	if (!ifq)
 		return -ENOMEM;
 
-	/* TODO: initialise network interface */
-
 	ret = io_allocate_rbuf_ring(ifq, &reg);
 	if (ret)
 		goto err;
 
+	ret = -ENODEV;
+	ifq->dev = dev_get_by_index(&init_net, reg.if_idx);
+	if (!ifq->dev)
+		goto err;
+
 	/* TODO: map zc region and initialise zc pool */
 
 	ifq->rq_entries = reg.rq_entries;
@@ -59,6 +99,10 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 	ifq->if_rxq_id = reg.if_rxq_id;
 	ctx->ifq = ifq;
 
+	ret = io_open_zc_rxq(ifq);
+	if (ret)
+		goto err;
+
 	ring_sz = sizeof(struct io_rbuf_ring);
 	rqes_sz = sizeof(struct io_uring_rbuf_rqe) * ifq->rq_entries;
 	cqes_sz = sizeof(struct io_uring_rbuf_cqe) * ifq->cq_entries;
@@ -80,3 +124,17 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 	io_zc_rx_ifq_free(ifq);
 	return ret;
 }
+
+int io_unregister_zc_rx_ifq(struct io_ring_ctx *ctx)
+{
+	struct io_zc_rx_ifq *ifq;
+
+	ifq = ctx->ifq;
+	if (!ifq)
+		return -EINVAL;
+
+	ctx->ifq = NULL;
+	io_zc_rx_ifq_free(ifq);
+
+	return 0;
+}
diff --git a/io_uring/zc_rx.h b/io_uring/zc_rx.h
index 4363734f3d98..340ececa9f9c 100644
--- a/io_uring/zc_rx.h
+++ b/io_uring/zc_rx.h
@@ -17,5 +17,6 @@ struct io_zc_rx_ifq {
 
 int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 			  struct io_uring_zc_rx_ifq_reg __user *arg);
+int io_unregister_zc_rx_ifq(struct io_ring_ctx *ctx);
 
 #endif
-- 
2.39.3


