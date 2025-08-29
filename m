Return-Path: <netdev+bounces-218075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEFB3B061
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFBB1C83F63
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1251FAC4E;
	Fri, 29 Aug 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUH2Nhjw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB01F4192
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430594; cv=none; b=hUCeZzjnQt5KAI+FNe/MJlf/roCB9UymfFD/vMM3ZCUuJFbSBLMU2Ar3kU20scYrVHk8vPvStbzhfv6cU1q/qLWRFQAE2hz7ifjJ1UJ7Kxa+XtpxwozsoQhWCkV3YiEl6vieOyihpK7g5Xw8UPlYuDuKeVKPeh8HlLR2kxakmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430594; c=relaxed/simple;
	bh=V2VOPYTC2OrLy0lnziyQzUeIHo5s+qhySspr0QCurAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJjODHoqSL6GAUDE5t2VxGyISjV8nybuaSWSErEcLrM+/Uzyo0G7oXtyFAuvqv0bpqzlJOK+c6kwcz/8svZ8HgS4ST0Q7BgFqxMpDuxCDkDNzMVVvGHiiJML61g9GvJpF+pCMfgfhzknnOLjiKyYmJDxHoNGF6lt5UXqwn8Bv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUH2Nhjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F413C4CEEB;
	Fri, 29 Aug 2025 01:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430594;
	bh=V2VOPYTC2OrLy0lnziyQzUeIHo5s+qhySspr0QCurAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUH2Nhjw2AaJgOO+hYuGmAX377l+SW6P5hkpAuR9oD0x1DuPRfOoF6ru/cSiKfEXB
	 j8GwATppcOJLcVf56EceVK00dnBXhS0dg/WZfviVkNkJP03xIgq7ylOM8Ki7/tQ3pT
	 7qS/UTkP36F7Iv97A3/YwxLGxcFQ+tXMc1wzNBnZWvfLsu9JPs5rGdhXrBdalIv1OQ
	 tH2H4JJSQz8s7APkoz9KPCtbdUatgc9k3pg1W3IOwHOCZ+HI1x6cxHEdeX+UszY6oI
	 OXHT744wp/cE5Wz8grTcYzsjplKEXKTuzGSEm/gXtf81GJ/XiDSona/CFCfwsqnias
	 YBOCv/X7wtNfg==
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
Subject: [PATCH net-next v2 03/14] eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
Date: Thu, 28 Aug 2025 18:22:53 -0700
Message-ID: <20250829012304.4146195-4-kuba@kernel.org>
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


