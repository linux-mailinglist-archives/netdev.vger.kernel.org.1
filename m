Return-Path: <netdev+bounces-215118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A0B2D22F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E670622FDF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1B2C11CD;
	Wed, 20 Aug 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzph08Fc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760E2C11C7
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658636; cv=none; b=ELQk7fbIopleloMEkeiyM/47n1vHR1vWB+KiFA80L9AJneskP41kXBJ3d6ZhkxUm+ZTMiEsbm4R3P8aktA6oMr2AUwg1C4HjiQlgyqyngxmO63JoBz7Snd9YzjsDsNAUcj3kIU5DOMETZfuDcVky+1fDGzB7JI76m1bntlHG2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658636; c=relaxed/simple;
	bh=U9SSb4BPfWxf7DiZ75b+OJbIeLMlZJ8cgl3IKILqJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq4eGSh3EjQojAK86FdAvLQ7BSIHkApg80Xq/xNxRJoY4Il86t8vK0h9HsOn3cobhHBMXa8ZPP2HaIUlDw0Efv8Zibb7DI2+4spKstWFOwR1Dvrs3GyuZ7+ReEE/ckzhbvyjPsebfNJPAiVqgpFCEzmJiYyKcwJjdWxDrLf4d7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzph08Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C57C19422;
	Wed, 20 Aug 2025 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658636;
	bh=U9SSb4BPfWxf7DiZ75b+OJbIeLMlZJ8cgl3IKILqJNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzph08FcaL5wwcMmsT9O10aamIN+ofPLYiYVj1JyW+JseUaqOAhbbqS16494tum7H
	 az1sKKUlB4SbvCrhDD2N3z+PRu++71RMfrhsgATn58pqKiz6AKcUg1fyJg5JTEFe4j
	 7LjttGYxRv37Q6AjnwE1ahxvR2PdUYcnXCkSx/H+P2k9U6hbJ1GWb05smZI1kocysI
	 23+gszdpeHG4gVkmTLXL/pC5szHwRIPawQ21p0mQonEVlebAjZyrc32NaaA9x3xT3V
	 LUHuqIOMfVwXXPnlI1D0XNpIiYATrpvm2rzQYUixfm5ulQ+nRqsooYVQT1wB4hd7oO
	 oiMwhN19DgsPQ==
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
Subject: [PATCH net-next 08/15] eth: fbnic: split fbnic_flush()
Date: Tue, 19 Aug 2025 19:56:57 -0700
Message-ID: <20250820025704.166248-9-kuba@kernel.org>
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
2.50.1


