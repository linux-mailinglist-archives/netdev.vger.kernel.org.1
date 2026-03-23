Return-Path: <netdev+bounces-270523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGalOfQ1wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:45:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3652F225B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FCE5301530B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C03A9633;
	Mon, 23 Mar 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxv0/S2s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450D3A9629
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269852; cv=none; b=awGFB0tb9tqcpZSQpqpj8SDJIhAakF3U0m2BoK5iLsHogpSmhzCID8zem8WdEmKgpgzfQ+TpDmWqAQCyXpNMhuapU//fl0p8v0zUveNVLZBaqOHMYB789ZGQOtFgi+dFlTl503+uuptOhwiCEyOOh4iBkvUkAFd4KbWj+gsYgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269852; c=relaxed/simple;
	bh=BJCDSk/ikO5vcGJQqSK3RBpbIbBN6G40dJabdP4kfJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJAU51Zu2p87vC5YuIRpdY5AUyRlLeLBwk36cAoFgETqPX3bgo64Uq6RHUYQqBWiyT59G5bnW47hB8uW30K6x8fhTnLscmJPMq/P1WWWkN9Wvn1TBz1w8L9g013YD3MUk75ixOKEvm/UaNlvN4czkd1wjaairtsmqhGzk7XssE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxv0/S2s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso4418448f8f.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269849; x=1774874649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3SpE6pAv0CHtcxGEAqgEZJYKI2Qu5Y7W2dacp60yPU=;
        b=mxv0/S2sMvU64OioBRusNYVWWBbHLIk7YvTt/fUm6KOxRiPIbqNOTgTPhFvNGah+oA
         EwU8mV4I3q6759NGulu10W91WJMy+UQTrRiIX18fb3hXKuVMujY7hnpN0SnkwaehGhjE
         t7fjxutwmYkC/1oNkkdYpHr3eNtJe3X5+hjzY254LJVCNw6JfOQjyDQGDLrdWPJHpm/z
         BPXYu7mh1O/5Mq995ziFTs3SRRwSMArJBqBd9KRoayVdgBkYFdPo9L9pF6GUobR7b6k3
         ++WWZq5Ir6VT6JM2dkLZnngyFinnCytCpesrFqOByFJPbkCrcqd2KTo63G9TYql65Ede
         ACZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269849; x=1774874649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3SpE6pAv0CHtcxGEAqgEZJYKI2Qu5Y7W2dacp60yPU=;
        b=rECtOioiiKD114H1zrTCqi6cZXruoslzbgwyT91u3SudV6E9/9y81mcb8xkanbIDbo
         QrpmzWOt+2Ky+8xuwdL8NzmpLSECGLucKhk5/fy0aTU7SHV9aKGeLNdtC7y6YIje9SDi
         FYSkyVD+eFuiErqLKVOQvUAxU6BqEacn8JtNUJH0ATQXRXuWrcXH4mEoTSdsqusDd764
         fXSijyyDkBXo8Ek6jhQwt+CTzYKET2DJNlkTu76ZXs0slxB63ClHKGZLwjUNm66bXZYb
         IKe0iEf67FPGFfJTRajEd07u3wgwhXYYHoHNKfBZXVKfWexUj0rfICmt3K2ay6wPvITY
         pTdw==
X-Forwarded-Encrypted: i=1; AJvYcCWfImmDla1xtk0rG6lApAXOeQEFpo0l2ngsEhSvNf/Jd00t0p6cS/fetvnGEBLGtE0kr33wbwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRizoVKeNZtjVbSPy/Aupw2uFqASm1NN255lDB/ocL34vrtvU7
	nx+hLr7JhESvAmfTUHLm50umw3GdLBmhuHS4ZWoE4pyGerO8lqeZ3JrpUVrO1g==
X-Gm-Gg: ATEYQzy9NMPuguuusioejZ6ZOZdpeMixzakuvyaqpllFEI0oGX/mgOwmm/nNGer5wEL
	nOFQyY2cFBlGaM+0JqytOHRN10Agw2zfizD5CihZdwzCrn05vW/BCst36TRDGWMGkrufqUAcr3v
	LKNzZl33wKEjxHklj2gswbg7gNCWqFT8xnQ2IaFWbsof+8of7U4UbQr3hE/Tt3p7URFBPCNY4o2
	GtJJYFhnHrWZMNFrszdsd15Nt4igXdjlx3KtaGxGpcvuEgsymitozEUa4qEVFOkzL7fvupi0Hg6
	APKMujqNyaavcq0Aeicnm8yEn3G4Mm/AFlIRV4p1q/DYci2boxdaw42ie3wKuFTTUpnn4G7GuMv
	jJ3A9fmYRf9zlFyg0mEfoeAlNx62ETDYpVA8ovpWPv4HM0rZxrt1JlxchhYzuh5CsgJ6XoczOkO
	tmzUDHVKdoxDvRAtI3/FfsLktkJC4mu67279GzRh42XSXmjw0ffVY7XNB2r1fqsjAA6LIzPPpZl
	9yUy4rbkg==
X-Received: by 2002:a05:6000:2484:b0:43b:4c6b:754a with SMTP id ffacd0b85a97d-43b6427b552mr18767045f8f.53.1774269848642;
        Mon, 23 Mar 2026 05:44:08 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:07 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 05/16] io_uring/zcrx: implement device-less mode for zcrx
Date: Mon, 23 Mar 2026 12:43:54 +0000
Message-ID: <674f8ad679c5a0bc79d538352b3042cf0999596e.1774261953.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270523-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB3652F225B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow creating a zcrx instance without attaching it to a net device.
All data will be copied through the fallback path. The user is also
expected to use ZCRX_CTRL_FLUSH_RQ to handle overflows as it normally
should even with a netdev, but it becomes even more relevant as there
will likely be no one to automatically pick up buffers.

Apart from that, it follows the zcrx uapi for the I/O path, and is
useful for testing, experimentation, and potentially for the copy
recieve path in the future if improved.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/zcrx.h |  9 ++++++-
 io_uring/zcrx.c                    | 41 ++++++++++++++++++++----------
 io_uring/zcrx.h                    |  2 +-
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index 3163a4b8aeb0..103d65e690eb 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -49,7 +49,14 @@ struct io_uring_zcrx_area_reg {
 };
 
 enum zcrx_reg_flags {
-	ZCRX_REG_IMPORT	= 1,
+	ZCRX_REG_IMPORT		= 1,
+
+	/*
+	 * Register a zcrx instance without a net device. All data will be
+	 * copied. The refill queue entries might not be automatically
+	 * consmumed and need to be flushed, see ZCRX_CTRL_FLUSH_RQ.
+	 */
+	ZCRX_REG_NODEV		= 2,
 };
 
 enum zcrx_features {
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d2798a82c678..d772e1609c4b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -127,10 +127,10 @@ static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
 	int dmabuf_fd = area_reg->dmabuf_fd;
 	int i, ret;
 
+	if (!ifq->dev)
+		return -EINVAL;
 	if (off)
 		return -EINVAL;
-	if (WARN_ON_ONCE(!ifq->dev))
-		return -EFAULT;
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EINVAL;
 
@@ -211,11 +211,13 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	if (ret)
 		goto out_err;
 
-	ret = dma_map_sgtable(ifq->dev, &mem->page_sg_table,
-			      DMA_FROM_DEVICE, IO_DMA_ATTR);
-	if (ret < 0)
-		goto out_err;
-	mapped = true;
+	if (ifq->dev) {
+		ret = dma_map_sgtable(ifq->dev, &mem->page_sg_table,
+				      DMA_FROM_DEVICE, IO_DMA_ATTR);
+		if (ret < 0)
+			goto out_err;
+		mapped = true;
+	}
 
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
 	ret = io_account_mem(ifq->user, ifq->mm_account, mem->account_pages);
@@ -450,7 +452,8 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	ret = io_import_area(ifq, &area->mem, area_reg);
 	if (ret)
 		goto err;
-	area->is_mapped = true;
+	if (ifq->dev)
+		area->is_mapped = true;
 
 	if (buf_size_shift > io_area_max_shift(&area->mem)) {
 		ret = -ERANGE;
@@ -486,9 +489,11 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->type = NET_IOV_IOURING;
 	}
 
-	ret = io_populate_area_dma(ifq, area);
-	if (ret)
-		goto err;
+	if (ifq->dev) {
+		ret = io_populate_area_dma(ifq, area);
+		if (ret)
+			goto err;
+	}
 
 	area->free_count = nr_iovs;
 	/* we're only supporting one area per ifq for now */
@@ -826,6 +831,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	if (reg.if_rxq == -1 || !reg.rq_entries)
 		return -EINVAL;
+	if ((reg.if_rxq || reg.if_idx) && (reg.flags & ZCRX_REG_NODEV))
+		return -EINVAL;
 	if (reg.rq_entries > IO_RQ_MAX_ENTRIES) {
 		if (!(ctx->flags & IORING_SETUP_CLAMP))
 			return -EINVAL;
@@ -861,9 +868,15 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	ret = zcrx_register_netdev(ifq, &reg, &area);
-	if (ret)
-		goto err;
+	if (!(reg.flags & ZCRX_REG_NODEV)) {
+		ret = zcrx_register_netdev(ifq, &reg, &area);
+		if (ret)
+			goto err;
+	} else {
+		ret = io_zcrx_create_area(ifq, &area, &reg);
+		if (ret)
+			goto err;
+	}
 
 	reg.zcrx_id = id;
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 0316a41a3561..f395656c3160 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -8,7 +8,7 @@
 #include <net/page_pool/types.h>
 #include <net/net_trackers.h>
 
-#define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT)
+#define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT | ZCRX_REG_NODEV)
 #define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE)
 
 struct io_zcrx_mem {
-- 
2.53.0


