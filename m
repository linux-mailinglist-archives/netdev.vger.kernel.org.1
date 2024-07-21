Return-Path: <netdev+bounces-112307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96D938366
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 07:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E690C1C20A27
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 05:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493D33F7;
	Sun, 21 Jul 2024 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkOtZxjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084A1396
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721540170; cv=none; b=pIAgC2i/0XUoWyxL2IPkNfAfRGXXmg7szhwZakADz39ykAEvSd6HvV44sZT3bqXfOk51Lmk86ltHd3l9SzqBjB4vzlscOLbo5wSFf0IBPEsJYcR2x4bZI1ov/G7atcULDwqaGUmX3X/7HqdPT4bxs55scxS4n3kk25ME0Fs1FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721540170; c=relaxed/simple;
	bh=ecFsU62cphHzKl7E9uNwrJLrodLufWnDbjE5IYMvWGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qac1Faed+Q8i5voquZxfCaMSVTzcxngkQ0nVXR55Ux4l94Nudun4Yd9IkdFWme8Jl70aEVWAjYGKPTx0nrBpOAaschsDGtHZr0zIovuU4qzP/4x+oIjXftn2kOYmSxxjjx5o+hV8kyDJbQZMDUmgFNl1tgSNkuHfqqPrp5OubB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkOtZxjQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso1949572a12.1
        for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 22:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721540168; x=1722144968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCMDkwfQywobrT/8UzVsaPvpEwsCxE6+P+SSrIzLVWc=;
        b=OkOtZxjQg7QXcivneeUTfsIEhOSujwme3JmSmtCiAxfoJQlxkb9xqiBg5p9KXhTVjt
         5DYOItmcee7fL7zUijzPu8sPbHKEKk71iRykIgUlhBNHb/A6b9A5naJ2KOs7LXKc7mq0
         G97W++2gH2Q0AbOHX3CxJEe90UlN91Kwqvb+UD6En/m8hgaG8FOn7+VeXkewyLACzL8e
         VD2Vx2QY1FEYgLKLxymavmAZZGyyWxP5TtGqVlqC0NqNkNzbUkwnzH+TIV9e95ItQc6s
         5P3xVCrlAJIpMfYb6qR3IQcaD8Q1SK6NVH8kXSA8QaAzXbBrMq54gpbetmygrK7ZEvFl
         Ox8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721540168; x=1722144968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCMDkwfQywobrT/8UzVsaPvpEwsCxE6+P+SSrIzLVWc=;
        b=WCHjqnN4EoUjDHd6V1AeYHhrdquPrTlmJDMwMPuUdVqD5lh4rVPoP+pd3Jzwl0Qtfu
         xZKO20VUppnTT3kUTROdym/M8DsVjE889+u87kKns7zFSomPdurVWhWg4AGKYkzBRmNJ
         i61OVDW4zcXPy58HQxJj9ykr9rwnO+TVpHAbuMDix98+4kn72ztMNJsENyQINyP5eKWC
         xGwbgzPXtlRvV/5HCv7YR6/w/rg8WSjuABSZA3IC6kr1TqmsHQ+uhFdkEqH4iyjbXzET
         7M1d3PqcTmsPuexGmjrLSQq83WE0Kjwv74mJz5kqiOvngc7zd5vZ0PnJc/T8KFBnO1x9
         Babw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2dloGC2lN2kAgWMdG54cLvy3XVxojxdK7rkBgDOgvzzebBbzVF6ReZ2xXbe0E0uEBjAK+MLVVqlCi4XUzRnfei0mD0NF
X-Gm-Message-State: AOJu0YxRDG0NAey24ntLfnaKBMtJ/gn8xWMI+X48PcF/hmYNIo74JVa0
	V6ksQGud75LounQYIT+Hkaf4pk3Iim3H1wkllBuwRKeWn6lb9yj6
X-Google-Smtp-Source: AGHT+IFO2Sb8cnvlGucA8oLlQFjg2uApJURNpphcpRqi6xVrONT0LXmfwHp6NjCYvjkdddfOTL/ryg==
X-Received: by 2002:a17:90a:9c05:b0:2cd:3445:f87f with SMTP id 98e67ed59e1d1-2cd344606d8mr1136881a91.4.1721540168208;
        Sat, 20 Jul 2024 22:36:08 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7754a6d3sm5611676a91.56.2024.07.20.22.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 22:36:07 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org
Subject: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart logic
Date: Sun, 21 Jul 2024 05:35:54 +0000
Message-Id: <20240721053554.1233549-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
updates(creates and deletes) a page_pool.
But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
connected to an old page_pool.
So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.

An old page_pool is no longer used so it is supposed to be
deleted by page_pool_destroy() but it isn't.
Because the xdp_rxq_info is holding the reference count for it and the
xdp_rxq_info is not updated, an old page_pool will not be deleted in
the queue restart logic.

Before restarting 1 queue:
./tools/net/ynl/samples/page-pool
enp10s0f1np1[6] page pools: 4 (zombies: 0)
	refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
	recycling: 0.0% (alloc: 128:8048 recycle: 0:0)

After restarting 1 queue:
./tools/net/ynl/samples/page-pool
enp10s0f1np1[6] page pools: 5 (zombies: 0)
	refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
	recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)

Before restarting queues, an interface has 4 page_pools.
After restarting one queue, an interface has 5 page_pools, but it
should be 4, not 5.
The reason is that queue restarting logic creates a new page_pool and
an old page_pool is not deleted due to the absence of an update of
xdp_rxq_info logic.

Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Do not use memcpy in the bnxt_queue_start
 - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
   bnxt_queue_mem_free().

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bb3be33c1bbd..ffa74c26ee53 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
 
 	rxr->page_pool->p.napi = NULL;
 	rxr->page_pool = NULL;
+	memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
 
 	ring = &rxr->rx_ring_struct;
 	rmem = &ring->ring_mem;
@@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	if (rc)
 		return rc;
 
+	rc = xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
+	if (rc < 0)
+		goto err_page_pool_destroy;
+
+	rc = xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
+					MEM_TYPE_PAGE_POOL,
+					clone->page_pool);
+	if (rc)
+		goto err_rxq_info_unreg;
+
 	ring = &clone->rx_ring_struct;
 	rc = bnxt_alloc_ring(bp, &ring->ring_mem);
 	if (rc)
@@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
 err_free_rx_ring:
 	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
+err_rxq_info_unreg:
+	xdp_rxq_info_unreg(&clone->xdp_rxq);
+err_page_pool_destroy:
 	clone->page_pool->p.napi = NULL;
 	page_pool_destroy(clone->page_pool);
 	clone->page_pool = NULL;
@@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	bnxt_free_one_rx_ring(bp, rxr);
 	bnxt_free_one_rx_agg_ring(bp, rxr);
 
+	xdp_rxq_info_unreg(&rxr->xdp_rxq);
+
 	page_pool_destroy(rxr->page_pool);
 	rxr->page_pool = NULL;
 
@@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
 	rxr->rx_next_cons = clone->rx_next_cons;
 	rxr->page_pool = clone->page_pool;
+	rxr->xdp_rxq = clone->xdp_rxq;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
-- 
2.34.1


