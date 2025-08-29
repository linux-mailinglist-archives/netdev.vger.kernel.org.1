Return-Path: <netdev+bounces-218086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54AB3B071
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64067583DB5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D022417C3;
	Fri, 29 Aug 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJh9f5ja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F023ED75
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430603; cv=none; b=PqW7y9SXew0lwiVZnVHEGBdPiaEDL0ab9VgucMdEozlUIRa+qrlF4L94Jpy34y0O9Sa3GL/2QOZhaAXE9/MFdvbgkQ8k/Y13GKhsDCAMmixV8HDDvwf7BTYfVyC00jY65+fhza9O7EVwqMTrLP0nHZ9MLmX0puyXR9Qj8K0/LA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430603; c=relaxed/simple;
	bh=MXpBFHHKDhIEqbjOHfnjlvioFfrwvBPTnEi8Wcd8MiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cijeeTVdOCc8djnOnRHN36X4taXiKrOwYVXJWEeN1eZWDEYPji2MhqeGrRbJ6mXTYdzMIrFG6pkhjaIPP0VFnOmfphY1OHdVTfqKOyHpnzhbMQJPm54e9qfCsx2EhEVgtq81z2+Mzxq+bovofw4SpELOXXs2rvaaOxTQcs11DE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJh9f5ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4BCC4CEF8;
	Fri, 29 Aug 2025 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430602;
	bh=MXpBFHHKDhIEqbjOHfnjlvioFfrwvBPTnEi8Wcd8MiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJh9f5jau3J+XtJjVeL4ZqcnGtu6YQs74n6ATJ2lIGMYEIn3GM29WXYd5yZsQHqM2
	 QLuX5DVbclZuqhrby2j6w9oMYEb4QUNNscAZoeLtjNndLMIbCzDve/b/oS0L7e8TaU
	 SAQ9qljXdkz1OfHMrlVG0LfkTCFtvMx9EzFJTr1drW/40GpGneO7D2V7wchZIw+YjB
	 f4ENrOY3sDtKbS750Azy/9osOxUQ//5msJTcb6j2vhl6MuhdoTaWT2+T6mST/rNHPy
	 AFcBktK1mvm4RyD/GMdsgenulK68zJHvLATJzllG+EvLLUu17y0q5VMQgvbG6g/G0i
	 7M1MnrbwZhjyA==
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
Subject: [PATCH net-next v2 13/14] eth: fbnic: don't pass NAPI into pp alloc
Date: Thu, 28 Aug 2025 18:23:03 -0700
Message-ID: <20250829012304.4146195-14-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
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


