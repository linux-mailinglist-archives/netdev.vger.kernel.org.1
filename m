Return-Path: <netdev+bounces-215114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07EBB2D21E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B71C2285C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000826F2BC;
	Wed, 20 Aug 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z42oSeqs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6E26F28C
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658634; cv=none; b=Y8pT8+Kf5FcmaWwi0Kp9t+a3cHNjhfYuWC2nGuZHETy13cutdaYOp6k1Rd2lVAB3U5IhNi8+tGVIO2522/AIFZfQq+79blUsPUhc3vMiJ++QDeJom3IigI1rcx9ozzQ1fL4IRqiH2F2DNHUmqp6FP8OIDANzxVtiLGrhG87XNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658634; c=relaxed/simple;
	bh=2Pcg2PRh0zGsGbGvZL8E+x0uMvPoWGlCVuHgun+sbnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMu3WW1nYgiAwl3pBfX9CDuWxymRqyOOeB4Y/QoT62udoAqvUc5VfvIPpl85sL6cIjRgils0WjHYXnYbIycLEtbIMM2J/vNVCHKl6+HeaHHQqMyqBAX0ivVOacjbc9YGP4W+D9BHqdlYMNLm+R9s6d2bj+oLydHEPIb0nGr1LrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z42oSeqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AAAC16AAE;
	Wed, 20 Aug 2025 02:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658633;
	bh=2Pcg2PRh0zGsGbGvZL8E+x0uMvPoWGlCVuHgun+sbnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z42oSeqsQdQsLzzex40aTyAGyJ34ymixvJgXAmW8KTPwfng/v0S7mrbz4GaW4Qk2c
	 9bmMSU3UM9GSXOwu7FfQ3JIky1go5tunXNiB9CJdI00mMuUUjDd0A3p/y8ZvYrKuz5
	 s83jS6lr5/rDqYpanAzXOPvKToAunXXbGKegpigVaTjHTItZyonsGO0EltHrTh6hFD
	 3ByHppeUs8+gVhZ1R4eUZqGeJL+1T7yNxlIno8fmoYvuzD3dMY86Pn09we2XoNcws5
	 e0ejNZZJXWcmzFAxrfs8OdWjDT973/UdcRF9beon0G7VEkH9cQRrE9qTxmfw7mdi9Q
	 dejiTraWvh6Xw==
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
Subject: [PATCH net-next 04/15] eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
Date: Tue, 19 Aug 2025 19:56:53 -0700
Message-ID: <20250820025704.166248-5-kuba@kernel.org>
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
2.50.1


