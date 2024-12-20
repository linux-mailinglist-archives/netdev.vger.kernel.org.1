Return-Path: <netdev+bounces-153558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2C19F8A48
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7100165E82
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB36126C18;
	Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtXSwprF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8086338
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663171; cv=none; b=ZtkzKMTQYMm/l8iMZEMz/iocpnQzX+9pHJDJ1RKVMQtZxabw2YU739ECsE+fozWGpnpte8b7gpn3ly51jwygnuUDFTkriqwb71NbYLnzOOesxPNddR9vmMvxnmAekP181JUAT6m2MfsqhJTBh4aR1Rj3s4nyen4Y08kHFXIk+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663171; c=relaxed/simple;
	bh=MHijPVmRNgFlTGtf1uz38UqMTEII7iJDUjhwPm75v/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tud6lkQx8jc/2k274E6xRj9sEhnv+0lw2CT42nWh6DGS2slu75jh12dnkpHYTPrtukVDdGhgi9wP19NFfiKwWV7Jwv/Tie6qbJddDKVkk6WoARhE0WJ81phZ24+tD/iksp0pNguMqtHMkV52AsDaAdCNsJbZiSBtlmeZ7V7H3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtXSwprF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B83C4CEDE;
	Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663171;
	bh=MHijPVmRNgFlTGtf1uz38UqMTEII7iJDUjhwPm75v/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtXSwprFwMNulhc97QO1y4KgcEDqjBDe6peOVMHR+l2Saom98OtUjXFm+u9tb7wC2
	 r8h80Bx1tBtU/NtBlC172kimxE/bWmh0NklTXSWxhncFccW1piaBxpvp/9VVQHtDDw
	 5/ZCoZS3g5ALPXrkm20I98WhrR8wWeBIKaerQFBQZ3gOElsXVXt/bYAxxXwFIVgBQT
	 p6wAzgvAK+/XvuAa+83QBAfntMFkVAOlGoSc+FWV2kgwpr03QMl/omqm6WYa8TDe8y
	 tewPD3Bs65MIybJin1/zYtxc8jN2kVVxLQ7wl2jmdHv8iX4KbfmPZVQuTgai2bLF87
	 UWF7zlzfuau+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/10] eth: fbnic: centralize the queue count and NAPI<>queue setting
Date: Thu, 19 Dec 2024 18:52:39 -0800
Message-ID: <20241220025241.1522781-9-kuba@kernel.org>
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

From: Alexander Duyck <alexanderduyck@fb.com>

To simplify dealing with RTNL_ASSERT() requirements further
down the line, move setting queue count and NAPI<>queue
association to their own helpers.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 92 +++++++++++++------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  2 +
 3 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 2f19144e4410..7a96b6ee773f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -23,13 +23,7 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto free_napi_vectors;
 
-	err = netif_set_real_num_tx_queues(fbn->netdev,
-					   fbn->num_tx_queues);
-	if (err)
-		goto free_resources;
-
-	err = netif_set_real_num_rx_queues(fbn->netdev,
-					   fbn->num_rx_queues);
+	err = fbnic_set_netif_queues(fbn);
 	if (err)
 		goto free_resources;
 
@@ -93,6 +87,7 @@ static int fbnic_stop(struct net_device *netdev)
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 
+	fbnic_reset_netif_queues(fbn);
 	fbnic_free_resources(fbn);
 	fbnic_free_napi_vectors(fbn);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 75b491b8e1ca..92fc1ad6ed6f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1621,6 +1621,71 @@ int fbnic_alloc_resources(struct fbnic_net *fbn)
 	return err;
 }
 
+static void fbnic_set_netif_napi(struct fbnic_napi_vector *nv)
+{
+	int i, j;
+
+	/* Associate Tx queue with NAPI */
+	for (i = 0; i < nv->txt_count; i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+
+		netif_queue_set_napi(nv->napi.dev, qt->sub0.q_idx,
+				     NETDEV_QUEUE_TYPE_TX, &nv->napi);
+	}
+
+	/* Associate Rx queue with NAPI */
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+
+		netif_queue_set_napi(nv->napi.dev, qt->cmpl.q_idx,
+				     NETDEV_QUEUE_TYPE_RX, &nv->napi);
+	}
+}
+
+static void fbnic_reset_netif_napi(struct fbnic_napi_vector *nv)
+{
+	int i, j;
+
+	/* Disassociate Tx queue from NAPI */
+	for (i = 0; i < nv->txt_count; i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+
+		netif_queue_set_napi(nv->napi.dev, qt->sub0.q_idx,
+				     NETDEV_QUEUE_TYPE_TX, NULL);
+	}
+
+	/* Disassociate Rx queue from NAPI */
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+
+		netif_queue_set_napi(nv->napi.dev, qt->cmpl.q_idx,
+				     NETDEV_QUEUE_TYPE_RX, NULL);
+	}
+}
+
+int fbnic_set_netif_queues(struct fbnic_net *fbn)
+{
+	int i, err;
+
+	err = netif_set_real_num_queues(fbn->netdev, fbn->num_tx_queues,
+					fbn->num_rx_queues);
+	if (err)
+		return err;
+
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_set_netif_napi(fbn->napi[i]);
+
+	return 0;
+}
+
+void fbnic_reset_netif_queues(struct fbnic_net *fbn)
+{
+	int i;
+
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_reset_netif_napi(fbn->napi[i]);
+}
+
 static void fbnic_disable_twq0(struct fbnic_ring *txr)
 {
 	u32 twq_ctl = fbnic_ring_rd32(txr, FBNIC_QUEUE_TWQ0_CTL);
@@ -1801,10 +1866,6 @@ void fbnic_flush(struct fbnic_net *fbn)
 			tx_queue = netdev_get_tx_queue(nv->napi.dev,
 						       qt->sub0.q_idx);
 			netdev_tx_reset_queue(tx_queue);
-
-			/* Disassociate Tx queue from NAPI */
-			netif_queue_set_napi(nv->napi.dev, qt->sub0.q_idx,
-					     NETDEV_QUEUE_TYPE_TX, NULL);
 		}
 
 		/* Flush any processed Rx Queue Triads and drop the rest */
@@ -1820,10 +1881,6 @@ void fbnic_flush(struct fbnic_net *fbn)
 
 			fbnic_put_pkt_buff(nv, qt->cmpl.pkt, 0);
 			qt->cmpl.pkt->buff.data_hard_start = NULL;
-
-			/* Disassociate Rx queue from NAPI */
-			netif_queue_set_napi(nv->napi.dev, qt->cmpl.q_idx,
-					     NETDEV_QUEUE_TYPE_RX, NULL);
 		}
 	}
 }
@@ -1836,29 +1893,12 @@ void fbnic_fill(struct fbnic_net *fbn)
 		struct fbnic_napi_vector *nv = fbn->napi[i];
 		int j, t;
 
-		/* Configure NAPI mapping for Tx */
-		for (t = 0; t < nv->txt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			/* Nothing to do if Tx queue is disabled */
-			if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
-				continue;
-
-			/* Associate Tx queue with NAPI */
-			netif_queue_set_napi(nv->napi.dev, qt->sub0.q_idx,
-					     NETDEV_QUEUE_TYPE_TX, &nv->napi);
-		}
-
 		/* Configure NAPI mapping and populate pages
 		 * in the BDQ rings to use for Rx
 		 */
-		for (j = 0; j < nv->rxt_count; j++, t++) {
+		for (j = 0, t = nv->txt_count; j < nv->rxt_count; j++, t++) {
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
-			/* Associate Rx queue with NAPI */
-			netif_queue_set_napi(nv->napi.dev, qt->cmpl.q_idx,
-					     NETDEV_QUEUE_TYPE_RX, &nv->napi);
-
 			/* Populate the header and payload BDQs */
 			fbnic_fill_bdq(nv, &qt->sub0);
 			fbnic_fill_bdq(nv, &qt->sub1);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index c8d908860ab0..92c671135ad7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -124,6 +124,8 @@ int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);
 int fbnic_alloc_resources(struct fbnic_net *fbn);
 void fbnic_free_resources(struct fbnic_net *fbn);
+int fbnic_set_netif_queues(struct fbnic_net *fbn);
+void fbnic_reset_netif_queues(struct fbnic_net *fbn);
 irqreturn_t fbnic_msix_clean_rings(int irq, void *data);
 void fbnic_napi_enable(struct fbnic_net *fbn);
 void fbnic_napi_disable(struct fbnic_net *fbn);
-- 
2.47.1


