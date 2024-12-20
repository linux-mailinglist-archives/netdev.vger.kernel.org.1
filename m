Return-Path: <netdev+bounces-153556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA469F8A4A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3947B1893A90
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154876C61;
	Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8KLpmzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34F7081B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663171; cv=none; b=V6Cr/3447EobsO8qshEtMWQDzA2sZQHyPpG+5qFqkpqGEM1h6W5fVc8lvwj/Choz755XWOoxANBxSYKj1nBOP3F3x8fmr0RDLq9UQ6RYcypFv1ulQAvja+3fi8ypW/CJIzrd2J2VdvgR7A5F7UPSwfeOirZLLisV3pBTELUZZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663171; c=relaxed/simple;
	bh=7IlMBOnVoFtHfMLA7W9YzKdzRS+eZFCPBwQWx59HfLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brhDmU7WuBGh+aHb3glbkXCt0sBGScfACeM1ywYSQ6gDhjjppo8wKPjMW6c/CTwMxgM7NfbcxCzw29jC6SrkBEB5csjBVGOwW2fv7Wq7/ApPJ+shYkHD7mHUR3hjIRP4N1aFlt+0bkPTouKMF5Am1Iq0nPZhTFoS6GnM51htWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8KLpmzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522F6C4CED4;
	Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663170;
	bh=7IlMBOnVoFtHfMLA7W9YzKdzRS+eZFCPBwQWx59HfLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8KLpmzWR0hGx4ErhoXEP6BhHFGv23lGLANy5OaBDj0jy//fWq43Ia1E/396eixGE
	 /1/ifIwzuqvpEvoJW1aZ8E1tiI9gWzLzEJ8KUcxAoRZpsJhlXXUsSpttjQSmx11icf
	 ySDZ4Zirkp94tM3zWAr9ZII0UMyDChM9uMOwekbJ36H2oOaPm/5QZ257m36n7ugkhd
	 2WS/Sy/oMRD9KgEkAxxieIaeM/W2qoHSKXx9NP7YtBPo/E/5DLX0ZjQ9CB46SQL2Bt
	 wvEraj1w8rWVobMCulb2gVEhjAbl0AYroDMG5hFKsVsnb0IbEiLydpnp82SbE19N7k
	 3zWXqh7bfGcCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/10] eth: fbnic: store NAPIs in an array instead of the list
Date: Thu, 19 Dec 2024 18:52:37 -0800
Message-ID: <20241220025241.1522781-7-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will need an array for storing NAPIs in the upcoming IRQ handler
reuse rework. Replace the current list we have, so that we are able
to reuse it later.

In a few places replace i as the iterator with t when we iterate
over triads, this seems slightly less confusing than having
i, j, k variables.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 -
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 117 ++++++++++--------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   7 +-
 4 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index fc7d80db5fa6..558644c49a4b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -615,7 +615,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	fbn->netdev = netdev;
 	fbn->fbd = fbd;
-	INIT_LIST_HEAD(&fbn->napis);
 
 	fbn->txq_size = FBNIC_TXQ_SIZE_DEFAULT;
 	fbn->hpq_size = FBNIC_HPQ_SIZE_DEFAULT;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index b8417b300778..0986c8f120a8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -11,10 +11,14 @@
 #include "fbnic_rpc.h"
 #include "fbnic_txrx.h"
 
+#define FBNIC_MAX_NAPI_VECTORS		128u
+
 struct fbnic_net {
 	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
 	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
 
+	struct fbnic_napi_vector *napi[FBNIC_MAX_NAPI_VECTORS];
+
 	struct net_device *netdev;
 	struct fbnic_dev *fbd;
 
@@ -56,8 +60,6 @@ struct fbnic_net {
 
 	/* Time stampinn filter config */
 	struct kernel_hwtstamp_config hwtstamp_config;
-
-	struct list_head napis;
 };
 
 int __fbnic_open(struct fbnic_net *fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b5050fabe8fe..87e4eb03d991 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1116,16 +1116,17 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	fbnic_free_irq(fbd, v_idx, nv);
 	page_pool_destroy(nv->page_pool);
 	netif_napi_del(&nv->napi);
-	list_del(&nv->napis);
+	fbn->napi[fbnic_napi_idx(nv)] = NULL;
 	kfree(nv);
 }
 
 void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 {
-	struct fbnic_napi_vector *nv, *temp;
+	int i;
 
-	list_for_each_entry_safe(nv, temp, &fbn->napis, napis)
-		fbnic_free_napi_vector(fbn, nv);
+	for (i = 0; i < fbn->num_napi; i++)
+		if (fbn->napi[i])
+			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
 static void fbnic_name_napi_vector(struct fbnic_napi_vector *nv)
@@ -1222,7 +1223,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	nv->v_idx = v_idx;
 
 	/* Tie napi to netdev */
-	list_add(&nv->napis, &fbn->napis);
+	fbn->napi[fbnic_napi_idx(nv)] = nv;
 	netif_napi_add(fbn->netdev, &nv->napi, fbnic_poll);
 
 	/* Record IRQ to NAPI struct */
@@ -1307,7 +1308,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	page_pool_destroy(nv->page_pool);
 napi_del:
 	netif_napi_del(&nv->napi);
-	list_del(&nv->napis);
+	fbn->napi[fbnic_napi_idx(nv)] = NULL;
 	kfree(nv);
 	return err;
 }
@@ -1612,19 +1613,18 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 
 void fbnic_free_resources(struct fbnic_net *fbn)
 {
-	struct fbnic_napi_vector *nv;
+	int i;
 
-	list_for_each_entry(nv, &fbn->napis, napis)
-		fbnic_free_nv_resources(fbn, nv);
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_free_nv_resources(fbn, fbn->napi[i]);
 }
 
 int fbnic_alloc_resources(struct fbnic_net *fbn)
 {
-	struct fbnic_napi_vector *nv;
-	int err = -ENODEV;
+	int i, err = -ENODEV;
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
-		err = fbnic_alloc_nv_resources(fbn, nv);
+	for (i = 0; i < fbn->num_napi; i++) {
+		err = fbnic_alloc_nv_resources(fbn, fbn->napi[i]);
 		if (err)
 			goto free_resources;
 	}
@@ -1632,8 +1632,8 @@ int fbnic_alloc_resources(struct fbnic_net *fbn)
 	return 0;
 
 free_resources:
-	list_for_each_entry_continue_reverse(nv, &fbn->napis, napis)
-		fbnic_free_nv_resources(fbn, nv);
+	while (i--)
+		fbnic_free_nv_resources(fbn, fbn->napi[i]);
 
 	return err;
 }
@@ -1670,33 +1670,34 @@ static void fbnic_disable_rcq(struct fbnic_ring *rxr)
 
 void fbnic_napi_disable(struct fbnic_net *fbn)
 {
-	struct fbnic_napi_vector *nv;
+	int i;
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
-		napi_disable(&nv->napi);
+	for (i = 0; i < fbn->num_napi; i++) {
+		napi_disable(&fbn->napi[i]->napi);
 
-		fbnic_nv_irq_disable(nv);
+		fbnic_nv_irq_disable(fbn->napi[i]);
 	}
 }
 
 void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
-	struct fbnic_napi_vector *nv;
-	int i, j;
+	int i, j, t;
+
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
 		/* Disable Tx queue triads */
-		for (i = 0; i < nv->txt_count; i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (t = 0; t < nv->txt_count; t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_disable_twq0(&qt->sub0);
 			fbnic_disable_tcq(&qt->cmpl);
 		}
 
 		/* Disable Rx queue triads */
-		for (j = 0; j < nv->rxt_count; j++, i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_disable_bdq(&qt->sub0, &qt->sub1);
 			fbnic_disable_rcq(&qt->cmpl);
@@ -1792,14 +1793,15 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 
 void fbnic_flush(struct fbnic_net *fbn)
 {
-	struct fbnic_napi_vector *nv;
+	int i;
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
-		int i, j;
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
+		int j, t;
 
 		/* Flush any processed Tx Queue Triads and drop the rest */
-		for (i = 0; i < nv->txt_count; i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (t = 0; t < nv->txt_count; t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 			struct netdev_queue *tx_queue;
 
 			/* Clean the work queues of unprocessed work */
@@ -1823,8 +1825,8 @@ void fbnic_flush(struct fbnic_net *fbn)
 		}
 
 		/* Flush any processed Rx Queue Triads and drop the rest */
-		for (j = 0; j < nv->rxt_count; j++, i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			/* Clean the work queues of unprocessed work */
 			fbnic_clean_bdq(nv, 0, &qt->sub0, qt->sub0.tail);
@@ -1845,14 +1847,15 @@ void fbnic_flush(struct fbnic_net *fbn)
 
 void fbnic_fill(struct fbnic_net *fbn)
 {
-	struct fbnic_napi_vector *nv;
+	int i;
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
-		int i, j;
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
+		int j, t;
 
 		/* Configure NAPI mapping for Tx */
-		for (i = 0; i < nv->txt_count; i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (t = 0; t < nv->txt_count; t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			/* Nothing to do if Tx queue is disabled */
 			if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
@@ -1866,8 +1869,8 @@ void fbnic_fill(struct fbnic_net *fbn)
 		/* Configure NAPI mapping and populate pages
 		 * in the BDQ rings to use for Rx
 		 */
-		for (j = 0; j < nv->rxt_count; j++, i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			/* Associate Rx queue with NAPI */
 			netif_queue_set_napi(nv->napi.dev, qt->cmpl.q_idx,
@@ -2025,21 +2028,23 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 void fbnic_enable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
-	struct fbnic_napi_vector *nv;
-	int i, j;
+	int i;
+
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
+		int j, t;
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
 		/* Setup Tx Queue Triads */
-		for (i = 0; i < nv->txt_count; i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (t = 0; t < nv->txt_count; t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_enable_twq0(&qt->sub0);
 			fbnic_enable_tcq(nv, &qt->cmpl);
 		}
 
 		/* Setup Rx Queue Triads */
-		for (j = 0; j < nv->rxt_count; j++, i++) {
-			struct fbnic_q_triad *qt = &nv->qt[i];
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_enable_bdq(&qt->sub0, &qt->sub1);
 			fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
@@ -2064,10 +2069,11 @@ void fbnic_napi_enable(struct fbnic_net *fbn)
 {
 	u32 irqs[FBNIC_MAX_MSIX_VECS / 32] = {};
 	struct fbnic_dev *fbd = fbn->fbd;
-	struct fbnic_napi_vector *nv;
 	int i;
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
+
 		napi_enable(&nv->napi);
 
 		fbnic_nv_irq_enable(nv);
@@ -2096,17 +2102,18 @@ void fbnic_napi_depletion_check(struct net_device *netdev)
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	u32 irqs[FBNIC_MAX_MSIX_VECS / 32] = {};
 	struct fbnic_dev *fbd = fbn->fbd;
-	struct fbnic_napi_vector *nv;
-	int i, j;
+	int i, j, t;
+
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
 
-	list_for_each_entry(nv, &fbn->napis, napis) {
 		/* Find RQs which are completely out of pages */
-		for (i = nv->txt_count, j = 0; j < nv->rxt_count; j++, i++) {
+		for (t = nv->txt_count, j = 0; j < nv->rxt_count; j++, t++) {
 			/* Assume 4 pages is always enough to fit a packet
 			 * and therefore generate a completion and an IRQ.
 			 */
-			if (fbnic_desc_used(&nv->qt[i].sub0) < 4 ||
-			    fbnic_desc_used(&nv->qt[i].sub1) < 4)
+			if (fbnic_desc_used(&nv->qt[t].sub0) < 4 ||
+			    fbnic_desc_used(&nv->qt[t].sub1) < 4)
 				irqs[nv->v_idx / 32] |= BIT(nv->v_idx % 32);
 		}
 	}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 8d626287c3f4..1965d1fa38a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -110,8 +110,6 @@ struct fbnic_napi_vector {
 	u8 txt_count;
 	u8 rxt_count;
 
-	struct list_head napis;
-
 	struct fbnic_q_triad qt[];
 };
 
@@ -137,4 +135,9 @@ void fbnic_fill(struct fbnic_net *fbn);
 void fbnic_napi_depletion_check(struct net_device *netdev);
 int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail);
 
+static inline int fbnic_napi_idx(const struct fbnic_napi_vector *nv)
+{
+	return nv->v_idx - FBNIC_NON_NAPI_VECTORS;
+}
+
 #endif /* _FBNIC_TXRX_H_ */
-- 
2.47.1


