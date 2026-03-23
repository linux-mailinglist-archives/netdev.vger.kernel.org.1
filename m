Return-Path: <netdev+bounces-270524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOvXMZg3wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:52:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6622F23F5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5276A302F708
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3C3A9DB0;
	Mon, 23 Mar 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVzpviZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EC3A960F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269853; cv=none; b=XfwCfm2a/rfgXNzR4l87c2z3wxRkJXKHX9lBnOldCCzEClL5S3TiSb3/bhypxTwL2ntc42ed9U9Oa2uhjJ5azI/OkWnAgO9nzJFmW8SybX/33Fir6ikSpYhJg8A8t9RMc7qGS1m/cjWVFYG6d4a2xRQfB5mCxSUcrc71hbqf1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269853; c=relaxed/simple;
	bh=dhn/QuxYD6uUbk1LBMab09YQzOVfQq5TFz8bfn5rEqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgiAgZEj7j3xh91ScSiLhS9nIgn0u+MucSHOaxD/z5CpcOWpVXhTQwD64WHhZOD410feWmjz//84bd2HFZ6O+B9JDGH6iZyy7HWE3WRVGb/3ZiqWbAJlOy1JKnEQXuCDD9Ed55xWjVVCU7nhqDC66op+InNGUa1bYxhufnWbhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVzpviZJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so3632495f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269850; x=1774874650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG2Lr9uDtrcGMnHU+Auqm9HgflOqtMU5LxKYhILDbiQ=;
        b=KVzpviZJP+TJPcdhO5fFGklbkjnJhgSIKKbP99+ezYuTtS/b29lSFxVM4caH4iQbJf
         UONo/pZZr+/hOShTaPD9AC9vCVfP73dax3qFtFp+4+Fq7T8O+4kzIR+WcnxHdo4mrWa/
         w8Ap1HyjLbZJMNUNLz+Ro4dqf8Ua3cqP0yb1Q/WsoVNe3ng5JOy3rfoQvjHidZl8ZK4L
         N1I1W5D3nRFdmHcCJnHxdIxgfTWJhwHVl/60v5c1atEjThYw/NQ0W3hiiyMMkt7K53f6
         MOv0Y6mm44fqUDqtUWmiCkxzYJ+DUd2/asg7LRqk5wGH2U3Eh8O48odb0elAc/5P5rrT
         Foyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269850; x=1774874650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GG2Lr9uDtrcGMnHU+Auqm9HgflOqtMU5LxKYhILDbiQ=;
        b=fjBEiLaJBVHylBcSY4MaecNgmL3+nhXK8gb9YGbn8eQmpDY+pJEQxlyQNhKzwxxe+1
         igisLMJQTlq3hSUVEQ6M0CNRkA/SGjUn6Wk3wgoZSVI7xM8gQsIZuLdhyHcHvP5oZ42L
         y7jG5e6OtmiUIRJquzwL2JxjRL+5PVBkdzHkAGqAJWRUsVRVHS0FIdj8pSwN2rXZtd/n
         rmaRPMaHjBorGtnZm1KllU4cJWninXgSuRXbsyFDuf9FIrxOYdXtkMuSVN8bnd9pWhXL
         nkhoY4EGZs4maj20S1+ri0AiMSWSVzn10+fa32ORaH6KtHYjhu5EjUSenPovv/z6apL3
         iBEg==
X-Forwarded-Encrypted: i=1; AJvYcCVtBX+PAHH5+3w3qs0XkPeL26lkhPCx7kBsE8RXKsTPlvQUeAS+OKOjPPrk4cGwR/Un4qIcU7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/VtD7KWr0HbXnI8+Wk49N6jyo74nhJq2QhDFX8vTTrBlzKpsg
	03mXNO4Gck+Wb1Rm1D2gdz89DeqGY9k38p7PPkmnkleOQU4mu/TsDCRL
X-Gm-Gg: ATEYQzwcrlLkJuqZHM55RhlDi2C7iDLmN72Ly3W2ZLjVmhDN2sYBdLzVWcyxU/miQRv
	4LQsVL1cAdDWS2PkRDO1Cc7VkT/JRgLmb0cEz3uZa0remZXFuTWIgzIls24nHvdMa7aQsh6Ey5a
	0zvsTVLDrL2Uk1XUVrZow8u7jIZDVWTYdB3FB02ZdboNtP1iZO8po27yg50TvmAYpL/4MxwW//Q
	ptcq4VYg71cG+Hi3+v2ddtf8od86vpXth620lqz9QPc+KHtheahyVIShhhRfdajoQi3IskfKz2h
	ZVPa5jhxE62MPdz/3vSQDC4HYvzQzBEK0HRVGRCUZpYfj3TyHxmVJXJAYgNQSWE/i2hAzyoiMNp
	hFg+nVnpRkdIievzZVUKUuujB4Q6O70tvXspOz1pWvRrk5nt/mov39rXF3vNIbIeL3g6fvcbweM
	Zx612v/OfHwQmQNnNoWGJVoieqVZnJvzefRH2xNX8Wo0XclkGvObPocjtxMBXc2YO641G2URsQC
	LVEbAt3Lg==
X-Received: by 2002:a05:6000:230b:b0:43b:4aba:8f52 with SMTP id ffacd0b85a97d-43b64262db0mr18244829f8f.32.1774269850084;
        Mon, 23 Mar 2026 05:44:10 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 06/16] io_uring/zcrx: use better name for RQ region
Date: Mon, 23 Mar 2026 12:43:55 +0000
Message-ID: <ac815790d2477a15826aecaa3d94f2a94ef507e6.1774261953.git.asml.silence@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270524-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2B6622F23F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename "region" to "rq_region" to highlight that it's a refill queue
region.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 8 ++++----
 io_uring/zcrx.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d772e1609c4b..f10df7750740 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -384,11 +384,11 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
 
-	ret = io_create_region(ctx, &ifq->region, rd, mmap_offset);
+	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 
-	ptr = io_region_get_ptr(&ifq->region);
+	ptr = io_region_get_ptr(&ifq->rq_region);
 	ifq->rq_ring = (struct io_uring *)ptr;
 	ifq->rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
@@ -397,7 +397,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 
 static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 {
-	io_free_region(ifq->user, &ifq->region);
+	io_free_region(ifq->user, &ifq->rq_region);
 	ifq->rq_ring = NULL;
 	ifq->rqes = NULL;
 }
@@ -645,7 +645,7 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
 
 	lockdep_assert_held(&ctx->mmap_lock);
 
-	return ifq ? &ifq->region : NULL;
+	return ifq ? &ifq->rq_region : NULL;
 }
 
 static int zcrx_box_release(struct inode *inode, struct file *file)
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index f395656c3160..3b2681a1fafd 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -66,7 +66,7 @@ struct io_zcrx_ifq {
 	 * net stack.
 	 */
 	struct mutex			pp_lock;
-	struct io_mapped_region		region;
+	struct io_mapped_region		rq_region;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.53.0


