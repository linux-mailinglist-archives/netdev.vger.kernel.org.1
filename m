Return-Path: <netdev+bounces-92853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCF8B9253
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C2D1F22346
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA17168B05;
	Wed,  1 May 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzduO/li"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB772168B1A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605963; cv=none; b=osJ0wVYr/uvpb4QVMazR2xNDKXlhJ7ylDpQE3GyVU/+dzcZ5BNXa0tQiQMof7AR4NYIlZqQ+vu+dtSNKFr8wHLIULZ7gkmt/BJyFZeQbKZKwQuzFwj7Rivejmf7h4iruqOafXH6LmypKw6tsdUyMb5yUrCjUl9J1KDeoqCRo8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605963; c=relaxed/simple;
	bh=G9vTwaOh9tqpmWBRnbfIv95mAPnSNpQXI1b5OG2x6ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AehCrG9NZvTvwdrnL6I5akiFI3Xt14d7rAGTjYqjQ5bZB54n7rejt1XkXhpVm3kbc1Huy8FFEytRw0KsMOifUlcU3/ov8GVAOBFkKUpuM/0qjMr43NAtDBU+DYRMs4Qdf7XkbreI4Vo9wQEUv6mh5gIkhK9aQmoUd8/U3p8cezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzduO/li; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de604d35ec0so6023146276.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605960; x=1715210760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQKspPSBYhGlej/Z1yQFkrqQvo1+u8pB8UNnxcDCgXM=;
        b=NzduO/ligzttOh4HOv08u92bab8JlWolPc9jlsd5ivDVvJw6kLJmEEPFw23jGjzeaV
         ZzPrSNVkA+XW30E5lhtcyATIP4BRRBz1bGqmc/JtXHbTb44vETb0UlKZth/H/tNNNfm/
         gxbspCg5QoCvFQoFXC0rC0X1326dtadlNJC9krl2znsiQiaVkNvahHCJNQRa4kU5iJR5
         3Opk3sg7uOmE9G7LjIA1uHLtm1gUIyFtRUMO9Cj59zEOWlxrpHXaNz3ZnqrMWsa1g5q7
         6/Kv5kNs2VE/qeKiixTx7aS/RumNguQ8f/TwMNz7KNk/92m/HRKqV3m9W5IejPphg5DG
         Ojag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605960; x=1715210760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQKspPSBYhGlej/Z1yQFkrqQvo1+u8pB8UNnxcDCgXM=;
        b=T664PyPL3Efx1xF2ZJXHPsO1LsRWL1qlSCqilXU8d9Qd6n+3xf5HEY0tJYptjsP1H+
         tZr6Nam6AFv4fmIW2Li47RrHAr46FJRjT/J+tiNe050Sqf6Wi3swyFE66PdIlX8lR0G6
         pimEWhKqzj2zi1Euh80KrEqZ9FS2ZorxmwQO2IqysGGo0ySQBu3r/0W40X06ijkthRQj
         w5MYsxjAM/dL1gfe0DhFig8Px66nqeWkeoywmtGHkDOiMnMoveLSa7wpXi95WIUvcsV5
         9BjGbGfIxTfrlhm7bEEGEyjKdqPVLbN2jAzh5AhRBR5Oa/93CbK3c9dntSWidoBSAAQ2
         pcjw==
X-Gm-Message-State: AOJu0Yy72leMgO7VN0PPHzuexXoZuvB/Ro6mkLZCHE1wEtc3e1VukOQn
	Zc1Ip+HsxIMuEQSJxlm0uGLaOV95LQyb0CF0Tn1kmTQsCRjW2e9wF+dxzpVf6RcOFg2Mbs4emh8
	3hrwpFr5tRJR3lj9/oDgPxuqvAyxs5dufB5WBFW0R/EQr+j/ml0TDmDZcjBSnb/xb09Bhfq7Las
	Q7K+9bfKOgMQu+tIQntc31ff7/KXlgk+DCUphRoz1Gqn4=
X-Google-Smtp-Source: AGHT+IH9X3g2nHdCUNhovfmGjdQX4nADcPdvh477P+X1iZqsQKM/5QObCOfAlAkcHgYx/0sPR6ejPjYyCGX1YA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:2d06:0:b0:de5:4ed6:d3f3 with SMTP id
 t6-20020a252d06000000b00de54ed6d3f3mr89854ybt.6.1714605960631; Wed, 01 May
 2024 16:26:00 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:41 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-3-shailend@google.com>
Subject: [PATCH net-next v2 02/10] gve: Make the GQ RX free queue funcs idempotent
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Although this is not fixing any existing double free bug, making these
functions idempotent allows for a simpler implementation of future ndo
hooks that act on a single queue.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 9b56e89c4f43..0a3f88170411 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -30,6 +30,9 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
 	u32 slots = rx->mask + 1;
 	int i;
 
+	if (!rx->data.page_info)
+		return;
+
 	if (rx->data.raw_addressing) {
 		for (i = 0; i < slots; i++)
 			gve_rx_free_buffer(&priv->pdev->dev, &rx->data.page_info[i],
@@ -69,20 +72,26 @@ static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	int idx = rx->q_num;
 	size_t bytes;
 
-	bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
-	dma_free_coherent(dev, bytes, rx->desc.desc_ring, rx->desc.bus);
-	rx->desc.desc_ring = NULL;
+	if (rx->desc.desc_ring) {
+		bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
+		dma_free_coherent(dev, bytes, rx->desc.desc_ring, rx->desc.bus);
+		rx->desc.desc_ring = NULL;
+	}
 
-	dma_free_coherent(dev, sizeof(*rx->q_resources),
-			  rx->q_resources, rx->q_resources_bus);
-	rx->q_resources = NULL;
+	if (rx->q_resources) {
+		dma_free_coherent(dev, sizeof(*rx->q_resources),
+				  rx->q_resources, rx->q_resources_bus);
+		rx->q_resources = NULL;
+	}
 
 	gve_rx_unfill_pages(priv, rx, cfg);
 
-	bytes = sizeof(*rx->data.data_ring) * slots;
-	dma_free_coherent(dev, bytes, rx->data.data_ring,
-			  rx->data.data_bus);
-	rx->data.data_ring = NULL;
+	if (rx->data.data_ring) {
+		bytes = sizeof(*rx->data.data_ring) * slots;
+		dma_free_coherent(dev, bytes, rx->data.data_ring,
+				  rx->data.data_bus);
+		rx->data.data_ring = NULL;
+	}
 
 	kvfree(rx->qpl_copy_pool);
 	rx->qpl_copy_pool = NULL;
-- 
2.45.0.rc0.197.gbae5840b3b-goog


