Return-Path: <netdev+bounces-218926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076AB3F063
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF7B1A86A1C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88EE279DDA;
	Mon,  1 Sep 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6A4jmn8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4D278143
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761147; cv=none; b=ob2VrbezKqCNY5x0Fm+kdwW7wXkGEeF/p+vdjASiYTmA1hNgSQkX/il5O86x4jPb2nOLi3Ow5d4VXxvEBx3ET8obtnaCvrAMzcyCcB2UC6ySkqgh+QaU5Mv3TqQoc/gW0PgRrNljPPwVvCJDj1G+0KtCs9ITHWEEKBFzmx1KP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761147; c=relaxed/simple;
	bh=MXpBFHHKDhIEqbjOHfnjlvioFfrwvBPTnEi8Wcd8MiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1+SbfLfkgNT/I0wO92A6khxmW+3MW6P7gD0EEFGVVlQt/eddxQygiZdyQm6DZVekpe5OumjTJb02qgRBv0K2uBFa6qpiJ3hICy3bxXDOvB6waz4RXz8lAiqVqOrv4vrKKkv8T+CJQma2Vn2Wg3ngD5Synziigf6KYLJvkUcUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6A4jmn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F27C4CEF0;
	Mon,  1 Sep 2025 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761147;
	bh=MXpBFHHKDhIEqbjOHfnjlvioFfrwvBPTnEi8Wcd8MiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6A4jmn8RPo5XB6fqAQGiyTwxrngMfzY2gCiGjNe2YV68nhh7CFud5Dh5Q2R21khB
	 d/W9WUQpBHJ50Fn3kqB2s3aC1huE0po7kz/WK5qdDRNoGPELu3h7ty+haUGvidH6Gz
	 5VKkQRJU+EYaQXJBgrTP5/VXqvrlNQeUBvMA2PZDeH54vmvsp1+ymXYb8YzIYVld56
	 CmGePK5C08tRMPs2r2k6yVfIIqhB4pmEdyTmCJdvEDCI97qaOPU6wp4UUWKKtYsONi
	 m9Rw+H6XlluC7zhLB/FLUYW9j2WFAycz+YQrsWEXIILyhTvthMDpMFF4OfEUB5c4pD
	 V7G6FNddX3rAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 13/14] eth: fbnic: don't pass NAPI into pp alloc
Date: Mon,  1 Sep 2025 14:12:13 -0700
Message-ID: <20250901211214.1027927-14-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
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
index f5b83b6e1cc3..2e8ea3e01eba 100644
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
2.51.0


