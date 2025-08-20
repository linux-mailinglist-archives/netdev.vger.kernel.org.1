Return-Path: <netdev+bounces-215124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C52B2D234
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B15D68309B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB42D29CD;
	Wed, 20 Aug 2025 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzYZUolq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5106257AD1
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658640; cv=none; b=DglgKqY+JavOI98pfBUJBkcaz792IOJLFHCjp+GVv0W+/OfVoGgN89ble5oS5mTMy4HpHevlKYAWm5kK7M5MbSOQziV9YvLsVK//a5uaF4dCK2nXkku7yijBHqeAK15IbiWpqtdkemVwCgDoXjmCeEDjwmM62ONnQtWqsKkWCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658640; c=relaxed/simple;
	bh=6YXZOTZ9plbg+o8Uz8jADOoIv+XqxIwmzfFJ7iVNzo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usEqOd3mJwBcvOtwXroXJozM5TIXqi20JDLNHer6M+BVpqg3gKynNDHF3Vnn1kmdeI7Cx7gdXtI43jVY/PARY4rRx9W2rKjcvYnLNQ4TYExpIEyxUc/vtI/KmmP1B0g0GGK/lVTFCWUOB/+Q6qf72iV9PllI4J4wFzoax+JFd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzYZUolq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D2EC4CEF1;
	Wed, 20 Aug 2025 02:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658640;
	bh=6YXZOTZ9plbg+o8Uz8jADOoIv+XqxIwmzfFJ7iVNzo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzYZUolq0ts0A/hB/p/cDZFWaTX51to5tUw8jBWVSiMoEx8uGi4Xg/engbntCdsae
	 kqiPwYG0UT7/2mpX+/SLXO5freb1RNTRDLoCjkpT5Majq8cobDG9oRAiGg9b63CArX
	 1qtWHeaTHHTGWaQfzWyAqhOQVBVGAVlFxJsRLEpD0wMnvPI9WWkxkOKyTYxulGJ84O
	 JI55SUr3caik9mEeybRt7f3oLPfbSL3FhwBRyq6b1eIUr/7HOSW6YgortzA+3IeAf6
	 ZaEHn4OfkY+ap311FFAlWsK3MD1tGfHG+ThiByH4e3Eg9MHLm8SbyPqTx22jtv0tsK
	 0d+MpD/NmeY4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 14/15] eth: fbnic: don't pass NAPI into pp alloc
Date: Tue, 19 Aug 2025 19:57:03 -0700
Message-ID: <20250820025704.166248-15-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
References: <20250820025704.166248-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue API may ask us to allocate page pools when the device
is down, to validate that we ingested a memory provider binding.
Don't require NAPI to be passed to fbnic_alloc_qt_page_pools(),
to make calling fbnic_alloc_qt_page_pools() without NAPI possible.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 958793be21a1..980c8e991c0c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1515,8 +1515,8 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 }
 
 static int
-fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
-			  struct fbnic_q_triad *qt, unsigned int rxq_idx)
+fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
+			  unsigned int rxq_idx)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
@@ -1524,7 +1524,7 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
 			 PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = fbn->hpq_size + fbn->ppq_size,
 		.nid = NUMA_NO_NODE,
-		.dev = nv->dev,
+		.dev = fbn->netdev->dev.parent,
 		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = 0,
 		.max_len = PAGE_SIZE,
@@ -1971,7 +1971,7 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = fbnic_alloc_qt_page_pools(fbn, nv, qt, qt->cmpl.q_idx);
+	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx);
 	if (err)
 		return err;
 
-- 
2.50.1


