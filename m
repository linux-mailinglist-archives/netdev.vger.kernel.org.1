Return-Path: <netdev+bounces-218920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C74B3F05D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533291A8842C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B3277814;
	Mon,  1 Sep 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDKXqKDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628D27701E
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761143; cv=none; b=tlRXSE+kZ330lCQAE5uB6KuN5FULDWigqmquurkMyNR+cNLQp1O941Uupl7qUy0x33SmLr/aWj2fWPKbZYZb+ebqK7umYke11Vv2qNbjV/UTV57Ud2CRFReJnur5+8p2u6BvuY46rRllspVd6ip7zwCU/NIQ7lEgcjeVGGBe7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761143; c=relaxed/simple;
	bh=uScYteY3Zpk5HiegczHeMM6HS/wy8g6Ky340cF/mfpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTPEl6NQSaTUVBFAWt4pBq5Hso8aA4LMTlyO/7vVWCWPtoBRU/VemfMEFDsthl4sj0OXVFHcUQCoaZAAj7v8KsBOzyFykURWgJ/pTCT0Y26Fvmi4+RTnY/23svwAqbSQRc52rQopLirIgSs0izRWBY4ATkY0rpnrYo6/z/3vgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDKXqKDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EC3C4CEFA;
	Mon,  1 Sep 2025 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761142;
	bh=uScYteY3Zpk5HiegczHeMM6HS/wy8g6Ky340cF/mfpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDKXqKDLwiJ4XCbKTM5z4i0k2nL9asa1iNntEPgv2frj2c8vv/DFHMzydKktskqr0
	 a/M8SOd7FKNyQzZ1c+5mo7dj82cQI3hWjShm2jgRNVtnHpo9LNEe713s4tGf3al8Dn
	 3k1fgbKPSGkw35vigq9hs9yGaitOwBoO8olBHcs5SsqUmt2VGx+b5cSZhhQu0bF+/J
	 yffmlzvWU3Z84o/p2tFQO11Bn5ql5vgYUac8UB/T4SCIcngpDcGEbbOUkBTq+m50Y4
	 d/7fMURV+tTvkshtCltIxpcpM/I3VjnXh7yQgUBOwFZ5SLrchZvGNCTnryM7CRZ7+V
	 ZPXtaHbCBwWRA==
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
Subject: [PATCH net-next v3 07/14] eth: fbnic: split fbnic_flush()
Date: Mon,  1 Sep 2025 14:12:07 -0700
Message-ID: <20250901211214.1027927-8-kuba@kernel.org>
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

Factor out handling a single nv from fbnic_flush() to make
it reusable for queue ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 87 ++++++++++----------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7d6bf35acfd4..8384e73b4492 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2297,52 +2297,55 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 	return err;
 }
 
+static void fbnic_nv_flush(struct fbnic_napi_vector *nv)
+{
+	int j, t;
+
+	/* Flush any processed Tx Queue Triads and drop the rest */
+	for (t = 0; t < nv->txt_count; t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+		struct netdev_queue *tx_queue;
+
+		/* Clean the work queues of unprocessed work */
+		fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+		fbnic_clean_twq1(nv, false, &qt->sub1, true,
+				 qt->sub1.tail);
+
+		/* Reset completion queue descriptor ring */
+		memset(qt->cmpl.desc, 0, qt->cmpl.size);
+
+		/* Nothing else to do if Tx queue is disabled */
+		if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
+			continue;
+
+		/* Reset BQL associated with Tx queue */
+		tx_queue = netdev_get_tx_queue(nv->napi.dev,
+					       qt->sub0.q_idx);
+		netdev_tx_reset_queue(tx_queue);
+	}
+
+	/* Flush any processed Rx Queue Triads and drop the rest */
+	for (j = 0; j < nv->rxt_count; j++, t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		/* Clean the work queues of unprocessed work */
+		fbnic_clean_bdq(&qt->sub0, qt->sub0.tail, 0);
+		fbnic_clean_bdq(&qt->sub1, qt->sub1.tail, 0);
+
+		/* Reset completion queue descriptor ring */
+		memset(qt->cmpl.desc, 0, qt->cmpl.size);
+
+		fbnic_put_pkt_buff(qt, qt->cmpl.pkt, 0);
+		memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
+	}
+}
+
 void fbnic_flush(struct fbnic_net *fbn)
 {
 	int i;
 
-	for (i = 0; i < fbn->num_napi; i++) {
-		struct fbnic_napi_vector *nv = fbn->napi[i];
-		int j, t;
-
-		/* Flush any processed Tx Queue Triads and drop the rest */
-		for (t = 0; t < nv->txt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-			struct netdev_queue *tx_queue;
-
-			/* Clean the work queues of unprocessed work */
-			fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
-			fbnic_clean_twq1(nv, false, &qt->sub1, true,
-					 qt->sub1.tail);
-
-			/* Reset completion queue descriptor ring */
-			memset(qt->cmpl.desc, 0, qt->cmpl.size);
-
-			/* Nothing else to do if Tx queue is disabled */
-			if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
-				continue;
-
-			/* Reset BQL associated with Tx queue */
-			tx_queue = netdev_get_tx_queue(nv->napi.dev,
-						       qt->sub0.q_idx);
-			netdev_tx_reset_queue(tx_queue);
-		}
-
-		/* Flush any processed Rx Queue Triads and drop the rest */
-		for (j = 0; j < nv->rxt_count; j++, t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			/* Clean the work queues of unprocessed work */
-			fbnic_clean_bdq(&qt->sub0, qt->sub0.tail, 0);
-			fbnic_clean_bdq(&qt->sub1, qt->sub1.tail, 0);
-
-			/* Reset completion queue descriptor ring */
-			memset(qt->cmpl.desc, 0, qt->cmpl.size);
-
-			fbnic_put_pkt_buff(qt, qt->cmpl.pkt, 0);
-			memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
-		}
-	}
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_nv_flush(fbn->napi[i]);
 }
 
 void fbnic_fill(struct fbnic_net *fbn)
-- 
2.51.0


