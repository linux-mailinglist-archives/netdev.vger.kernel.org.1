Return-Path: <netdev+bounces-223585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5FB59A3E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60AE4800E1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E955343D72;
	Tue, 16 Sep 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLuQHDpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8233341661
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032827; cv=none; b=ltq6MFeK5Ioy5HMis81zne61nrjH01ALtOxUFIB9rGyOD082PL6tziMcIqmN60WnAFkG5TTOHmC4mowmAE114DGUE+kfHMqnm0MGI3CeuQ4rzFCeYj3ECGF87CuWeQIQI1GsghL71I7dlAp7vNOaKe/UmGPp536HFy4quUh2H9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032827; c=relaxed/simple;
	bh=gYNo9wucxFXCv/slJC30RScHVtA/DNyS1WQpzuJ3Xu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnPH/vdmc0rKnH8UcYflGPmN1p5MZn7JKz6poJPpimASeW1+o+ySh44pWt1DlWwPllAiwBrH4ieJMgV9mx6LEoK3tUp6QcrAN+YoDZeb79jYC7dr5P3CqXBeFoUcFIR636KHnPjArgMVYu2zttRsyV6QHlouB/SVexPPP1MdzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLuQHDpL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so2306069f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032824; x=1758637624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY49T51U0Mtyx/cgHflprbyHbn966tLE4cu3WUoaRt0=;
        b=iLuQHDpLTt6FJ0koxxHNribokZBSzpm4UYi5r5rxvOGYdOT/wwkFEku4YDaAXKQ2Mc
         M+B1OL6/9MA0nxDF+t0uIsqms/YZAyjoUopspCV56fxuTtRYrBMm3FEXAw5ctfbgAYT6
         SGPGaqHuJSgNx6I28966sRGAPJuFpMjnK1YIObHLAY/eSDkJlxW1puyoOpjGsKzJLuWr
         9iJqSxkm4qiR6mHv8Cn+6Vl1bM5BumqgsbpvqjwyO7S/uHmcE70+/egDCrOxgfG933e0
         hIQIPH03cU6d3mNHwPiMVPReKznEYWauiYHNWu8vI2Vqjgjv0wPTVFWjk0eAn79kJ/eN
         CGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032824; x=1758637624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY49T51U0Mtyx/cgHflprbyHbn966tLE4cu3WUoaRt0=;
        b=BVbZ5GoktenJusbvW315atcBy6x0iZsqLAdGzVzZf3IAMAsIywAuwBHCp9oJLBtkQe
         cpJ+u7NgQTOq7a64tM4TzxyOyJuhCMpzLEs8Pgnq3npxheispmVJjB0b0bWUFhvstZRW
         uq9xyVlRyccsY62CaSbnyiSduyuQAzsSlXK/NhOSEncxyMFNGioIeXhG63SUXJj0wTlj
         fJaactzBfQhO6WF4gKPpxjScNtWD3gAVVnmemPSJn7KhsGmmkUqDZO31UM7TM/nIjbPT
         /gu21rK+SdEN1Gg6AUcKE49DWdPcqQTsQsYrNT1GGjYq6CFnX9wiipVuUE36mMWHGok4
         lrrw==
X-Forwarded-Encrypted: i=1; AJvYcCXugVX8KB9xky2mIvYVsAlXWEf7VWUqz5rcTKy3w7Epl/PYicYJHvakgzigRNhM5d23HflLYsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzW3Vk5iIMRk/ByRZrv8EJ64/arMng4arL6Nc8yLJhs0SdMo1
	KWNnJTQIGzwOBihy6a7P/++4ZjBOiBIJWpXWxh36IchFnXf4TW01grK6
X-Gm-Gg: ASbGncv4wK8Pc6pVGuJ90ffW7G7AfNoN9R5L30rbXy0UrapK6+cO0kt7uGvGHWqjIGe
	tzRNO5n8BJ7l8PbEYsMnghNXikcjsTG2EnBqhRxFD2KtSCfqkXUnTAOJhbkhDpaBMstqbGne29j
	V/uAzF2AfP6XJRLNlKmB/MdfjtQhr4gDbGKIxIkJEVqmswxacKvz7OYjeqYVe8YCQOFq+bQjbxN
	OKmkCjt7+blroAEakCwcq6ociGlItLnN/QoXcNdSYhnxpQAU+zDdSg6xV/I0pwZEMT44yC2RD+u
	pwYsgNEN9C+y6ESx0VULvGCS0a57mhc7WlTjxUuXgGavHHRZG+hELjZTDd6Olqj3NQ1EoPI2s8+
	hpIw3pg==
X-Google-Smtp-Source: AGHT+IH2v7cRsH+AZmsZ9pgPkBbeRzBzo9r6mZPPsLsP2Oe4s2i8itl2oHafv4R4Nu6xLMDu5Upu2g==
X-Received: by 2002:a5d:5f55:0:b0:3ea:f4a1:f063 with SMTP id ffacd0b85a97d-3eaf4a1f4ccmr7188205f8f.55.1758032823705;
        Tue, 16 Sep 2025 07:27:03 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:27:02 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 13/20] io_uring/zcrx: rename dma lock
Date: Tue, 16 Sep 2025 15:27:56 +0100
Message-ID: <300922172efe71ba2323f3ce4fb77aa73887fe56.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for reusing the lock for other purposes, rename it to
"pp_lock". As before, it can be taken deeper inside the networking stack
by page pool, and so the syscall io_uring must avoid holding it while
doing queue reconfiguration or anything that can result in immediate pp
init/destruction.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 8 ++++----
 io_uring/zcrx.h | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 85832f60d68a..0deb41b74b7c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -253,7 +253,7 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 {
 	int i;
 
-	guard(mutex)(&ifq->dma_lock);
+	guard(mutex)(&ifq->pp_lock);
 	if (!area->is_mapped)
 		return;
 	area->is_mapped = false;
@@ -273,7 +273,7 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 {
 	int ret;
 
-	guard(mutex)(&ifq->dma_lock);
+	guard(mutex)(&ifq->pp_lock);
 	if (area->is_mapped)
 		return 0;
 
@@ -478,7 +478,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 	ifq->ctx = ctx;
 	spin_lock_init(&ifq->lock);
 	spin_lock_init(&ifq->rq_lock);
-	mutex_init(&ifq->dma_lock);
+	mutex_init(&ifq->pp_lock);
 	return ifq;
 }
 
@@ -527,7 +527,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 		put_device(ifq->dev);
 
 	io_free_rbuf_ring(ifq);
-	mutex_destroy(&ifq->dma_lock);
+	mutex_destroy(&ifq->pp_lock);
 	kfree(ifq);
 }
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 7604f1f85ccb..3f89a34e5282 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -54,7 +54,12 @@ struct io_zcrx_ifq {
 	struct net_device		*netdev;
 	netdevice_tracker		netdev_tracker;
 	spinlock_t			lock;
-	struct mutex			dma_lock;
+
+	/*
+	 * Page pool and net configuration lock, can be taken deeper in the
+	 * net stack.
+	 */
+	struct mutex			pp_lock;
 	struct io_mapped_region		region;
 };
 
-- 
2.49.0


