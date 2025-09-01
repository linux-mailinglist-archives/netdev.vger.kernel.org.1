Return-Path: <netdev+bounces-218916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F255B3F059
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408007B0C18
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35845275AF5;
	Mon,  1 Sep 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqfmJhXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFB275AE2
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761140; cv=none; b=oflL3qGMeK8vlyo0+xUAoCCkbETAqlFc1vXtB+U5RuLuiOzSHOSRmZE0/5/zn87LpepwJqrl9vQdGmsoCb/ilCqJdmXg9Bn8ZRISg/7aU5f+fDtCaglPNBvcR9P3ZQxGXRzcVIFZnnfaWq7nZFS+SYwL1O4EwEHdbTbhtLn2gEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761140; c=relaxed/simple;
	bh=V2VOPYTC2OrLy0lnziyQzUeIHo5s+qhySspr0QCurAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9m4A3nSw2zDNDsPHilvKO6BD6bJb8Gdq0w/tmsBIvMKjm40LZp+ohMw5hLZkTRX3i2EbxD4nKI36ZeQk0+85KfxGpvp+GOQUwoPiFsXK/K1yotvJwi/ZOjEllY5uszzpeFmQip//uK9crwJyf1BEMDNYFYsrb/+eMszaFsvLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqfmJhXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078A8C4CEF8;
	Mon,  1 Sep 2025 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761139;
	bh=V2VOPYTC2OrLy0lnziyQzUeIHo5s+qhySspr0QCurAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqfmJhXTzwcF0kTHkMQ/AEXCjj3beEbjOvZCqjKQw2813DC6BFxXbHUlFRsAWD4Hs
	 XrJyblU66TQMm7GAqMzfDXQuc7tTDTSATWQYd+ExHmdm6RNGC7EczTRD52Z2XHHNca
	 qIJu490RHi/EQlKRF1Octe1dZLRbHlsn5zWmXphR1H3SudRTVREffl0Xplo/89BFUC
	 YBFwHWt4/3VAd491J82gC/n25G660ftKLoqpSUEJX8AWFDAlJVV8830T+f8TFHUUOh
	 Lc9M2JKEj0W4qt0HT24c4G7dDFdsr9XaG1VmGUXPLudgzPNMFrouBDTaKPggHb4NnB
	 vqNIJ201xjQtA==
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
Subject: [PATCH net-next v3 03/14] eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
Date: Mon,  1 Sep 2025 14:12:03 -0700
Message-ID: <20250901211214.1027927-4-kuba@kernel.org>
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

page pools are now at the ring level, move page pool alloc
to fbnic_alloc_rx_qt_resources(), and freeing to
fbnic_free_qt_resources().

This significantly simplifies fbnic_alloc_napi_vector() error
handling, by removing a late failure point.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 37 +++++---------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 29a780f72c14..15ebbaa0bed2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1485,7 +1485,6 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
-		fbnic_free_qt_page_pools(&nv->qt[i]);
 	}
 
 	fbnic_napi_free_irq(fbd, nv);
@@ -1681,10 +1680,6 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
 		fbn->rx[rxq_idx] = &qt->cmpl;
 
-		err = fbnic_alloc_qt_page_pools(fbn, nv, qt);
-		if (err)
-			goto free_ring_cur_qt;
-
 		/* Update Rx queue index */
 		rxt_count--;
 		rxq_idx += v_count;
@@ -1695,26 +1690,6 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	return 0;
 
-	while (rxt_count < nv->rxt_count) {
-		qt--;
-
-		fbnic_free_qt_page_pools(qt);
-free_ring_cur_qt:
-		fbnic_remove_rx_ring(fbn, &qt->sub0);
-		fbnic_remove_rx_ring(fbn, &qt->sub1);
-		fbnic_remove_rx_ring(fbn, &qt->cmpl);
-		rxt_count++;
-	}
-	while (txt_count < nv->txt_count) {
-		qt--;
-
-		fbnic_remove_tx_ring(fbn, &qt->sub0);
-		fbnic_remove_xdp_ring(fbn, &qt->sub1);
-		fbnic_remove_tx_ring(fbn, &qt->cmpl);
-
-		txt_count++;
-	}
-	fbnic_napi_free_irq(fbd, nv);
 napi_del:
 	netif_napi_del(&nv->napi);
 	fbn->napi[fbnic_napi_idx(nv)] = NULL;
@@ -1934,6 +1909,7 @@ static void fbnic_free_qt_resources(struct fbnic_net *fbn,
 	if (xdp_rxq_info_is_reg(&qt->xdp_rxq)) {
 		xdp_rxq_info_unreg_mem_model(&qt->xdp_rxq);
 		xdp_rxq_info_unreg(&qt->xdp_rxq);
+		fbnic_free_qt_page_pools(qt);
 	}
 }
 
@@ -1971,12 +1947,15 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->sub0.q_idx,
-			       nv->napi.napi_id);
+	err = fbnic_alloc_qt_page_pools(fbn, nv, qt);
 	if (err)
 		return err;
 
-	/* Register XDP memory model for completion queue */
+	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->sub0.q_idx,
+			       nv->napi.napi_id);
+	if (err)
+		goto free_page_pools;
+
 	err = xdp_rxq_info_reg_mem_model(&qt->xdp_rxq, MEM_TYPE_PAGE_POOL,
 					 qt->sub0.page_pool);
 	if (err)
@@ -2004,6 +1983,8 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 	xdp_rxq_info_unreg_mem_model(&qt->xdp_rxq);
 unreg_rxq:
 	xdp_rxq_info_unreg(&qt->xdp_rxq);
+free_page_pools:
+	fbnic_free_qt_page_pools(qt);
 	return err;
 }
 
-- 
2.51.0


