Return-Path: <netdev+bounces-218074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9739B3B05F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E1A0175A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F11DFE26;
	Fri, 29 Aug 2025 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkWw8lsh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BF1D61BB
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430593; cv=none; b=AuPROuelzqTuzdMb486AsD6vHlxv4qf0LnrDKcZjg6iDl3EXqLP1AtsC/TK5WTgvCrJU4rW4bD0DFZUoyV6RJVIwNAj6Zs710ZbXuOZzOeG3PRokJCrXVEPkMytquCxchAPuk91CcDHF6+whKMTJR91udPGsPARAZ2ApH1Xv0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430593; c=relaxed/simple;
	bh=mx4mNLyirOmcQp+jf08jYhKX6naJG/ht4Fm6Jb6u60E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUEeS61Q90ZxYZjFNBcXXSLq8SFPWVdXmJavlOheM0Fcjm69RxWFC0j9s2UeEU0PT9YpSml20xWyM3J4jaroZuf7qS8bgs7aEQRCV5uKwqUK1tQy5mMcqDFP/Tqr1qtneVjz+wOyX6D/olzFRvh5MgZVKf3y12cEIHrEqDVF6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkWw8lsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B8C4CEF8;
	Fri, 29 Aug 2025 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430593;
	bh=mx4mNLyirOmcQp+jf08jYhKX6naJG/ht4Fm6Jb6u60E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkWw8lshSkYdqRk6WQI6/K1FG+ovf8MkU5AOYryZkzPv8FasZRpvWcWqkqLusgJcA
	 g4UiIdcnYfbtVHDood4ALeuQlYl3ts0b/07X1CrPMIQL3AgfWPQuCEqD2I0RKGXPa1
	 n1U+3yaJZW5fQGOYWrFN29ugMP/xWksFW0VRG37XggwZv9eMbLKVYIn4hi633SiiRz
	 TZpXAl7ZieLXvVeG0+tKKmy5cd359skMlslGWcA3mnJ77kRyuow5RhRYogxNAwUl1Z
	 vG4EB+m8U5L0oFm5JbwM75oqXWfVZVTw3Q/P0apIYffzTWxFkz0hrQS4F+nzt9fTaK
	 xN8vnxRRArakQ==
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
Subject: [PATCH net-next v2 02/14] eth: fbnic: move xdp_rxq_info_reg() to resource alloc
Date: Thu, 28 Aug 2025 18:22:52 -0700
Message-ID: <20250829012304.4146195-3-kuba@kernel.org>
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

Move rxq_info and mem model registration from fbnic_alloc_napi_vector()
and fbnic_alloc_nv_resources() to fbnic_alloc_rx_qt_resources().
The rxq_info is now registered later in the process, but that
should not cause any issues.

rxq_info lives in the fbnic_q_triad (qt) struct so qt init is a more
natural place. Encapsulating the logic in the qt functions will also
allow simplifying the cleanup in the NAPI related alloc functions
in the next commit.

Rx does not have a dedicated fbnic_free_rx_qt_resources(),
but we can use xdp_rxq_info_is_reg() to tell whether given
rxq_info was in use (effectively - if it's a qt for an Rx queue).

Having to pass nv into fbnic_alloc_rx_qt_resources() is not
great in terms of layering, but that's temporary, pp will
move soon..

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 58 +++++++++-----------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7f8bdb08db9f..29a780f72c14 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1482,7 +1482,6 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	for (j = 0; j < nv->rxt_count; j++, i++) {
-		xdp_rxq_info_unreg(&nv->qt[i].xdp_rxq);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
@@ -1686,11 +1685,6 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		if (err)
 			goto free_ring_cur_qt;
 
-		err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, rxq_idx,
-				       nv->napi.napi_id);
-		if (err)
-			goto free_qt_pp;
-
 		/* Update Rx queue index */
 		rxt_count--;
 		rxq_idx += v_count;
@@ -1704,8 +1698,6 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	while (rxt_count < nv->rxt_count) {
 		qt--;
 
-		xdp_rxq_info_unreg(&qt->xdp_rxq);
-free_qt_pp:
 		fbnic_free_qt_page_pools(qt);
 free_ring_cur_qt:
 		fbnic_remove_rx_ring(fbn, &qt->sub0);
@@ -1938,6 +1930,11 @@ static void fbnic_free_qt_resources(struct fbnic_net *fbn,
 	fbnic_free_ring_resources(dev, &qt->cmpl);
 	fbnic_free_ring_resources(dev, &qt->sub1);
 	fbnic_free_ring_resources(dev, &qt->sub0);
+
+	if (xdp_rxq_info_is_reg(&qt->xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(&qt->xdp_rxq);
+		xdp_rxq_info_unreg(&qt->xdp_rxq);
+	}
 }
 
 static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
@@ -1968,15 +1965,27 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 }
 
 static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
+				       struct fbnic_napi_vector *nv,
 				       struct fbnic_q_triad *qt)
 {
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = fbnic_alloc_rx_ring_resources(fbn, &qt->sub0);
+	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->sub0.q_idx,
+			       nv->napi.napi_id);
 	if (err)
 		return err;
 
+	/* Register XDP memory model for completion queue */
+	err = xdp_rxq_info_reg_mem_model(&qt->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 qt->sub0.page_pool);
+	if (err)
+		goto unreg_rxq;
+
+	err = fbnic_alloc_rx_ring_resources(fbn, &qt->sub0);
+	if (err)
+		goto unreg_mm;
+
 	err = fbnic_alloc_rx_ring_resources(fbn, &qt->sub1);
 	if (err)
 		goto free_sub0;
@@ -1991,22 +2000,20 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 	fbnic_free_ring_resources(dev, &qt->sub1);
 free_sub0:
 	fbnic_free_ring_resources(dev, &qt->sub0);
+unreg_mm:
+	xdp_rxq_info_unreg_mem_model(&qt->xdp_rxq);
+unreg_rxq:
+	xdp_rxq_info_unreg(&qt->xdp_rxq);
 	return err;
 }
 
 static void fbnic_free_nv_resources(struct fbnic_net *fbn,
 				    struct fbnic_napi_vector *nv)
 {
-	int i, j;
+	int i;
 
-	/* Free Tx Resources  */
-	for (i = 0; i < nv->txt_count; i++)
+	for (i = 0; i < nv->txt_count + nv->rxt_count; i++)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
-
-	for (j = 0; j < nv->rxt_count; j++, i++) {
-		fbnic_free_qt_resources(fbn, &nv->qt[i]);
-		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
-	}
 }
 
 static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
@@ -2023,26 +2030,13 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 
 	/* Allocate Rx Resources */
 	for (j = 0; j < nv->rxt_count; j++, i++) {
-		/* Register XDP memory model for completion queue */
-		err = xdp_reg_mem_model(&nv->qt[i].xdp_rxq.mem,
-					MEM_TYPE_PAGE_POOL,
-					nv->qt[i].sub0.page_pool);
+		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i]);
 		if (err)
-			goto xdp_unreg_mem_model;
-
-		err = fbnic_alloc_rx_qt_resources(fbn, &nv->qt[i]);
-		if (err)
-			goto xdp_unreg_cur_model;
+			goto free_qt_resources;
 	}
 
 	return 0;
 
-xdp_unreg_mem_model:
-	while (j-- && i--) {
-		fbnic_free_qt_resources(fbn, &nv->qt[i]);
-xdp_unreg_cur_model:
-		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
-	}
 free_qt_resources:
 	while (i--)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
-- 
2.51.0


