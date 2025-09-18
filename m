Return-Path: <netdev+bounces-215125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524DB2D228
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700F71C244F1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBB2D3738;
	Wed, 20 Aug 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trhHWsUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A102D3226
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658641; cv=none; b=ud8BUd6gF118fiXd8mPKye85SCQBLjc36IkFUqiRN86Z43nSEGWWUUxIu7uaiL2zxiXcxkANqvx/tyfFFDq1ecuymdvZGGMi/Qyxypm7ceZS4yoq4KkudIj20ApIuLSa82sycq1UVOAN4kF+iJGhjTdNsnF2d7QObErFG+E00ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658641; c=relaxed/simple;
	bh=uFYOTvjStXDvWeDOFRc3fkLQebj7s+2qhmWGik6rFGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLTGZvtT9u0A0peJN6HPwFGMMdBj+LP/yoX+Xnd+ygUMJyBNZoD7orD7nh0B9TtVui1MjGo6+0cQhYd6Xlusfsrjjvlz73n1aGAE8vJ0F5O/GgrbHGGJD+vwGuzEPATtxx/33Rub96v9qrD8K5OJqwY6yNdiA4o7zlDU6rPbTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trhHWsUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB370C16AAE;
	Wed, 20 Aug 2025 02:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658641;
	bh=uFYOTvjStXDvWeDOFRc3fkLQebj7s+2qhmWGik6rFGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trhHWsUIDC3QC+y44hLNGDlMIJuVSc32enugIM5XV0SON9SuwiiR+fMoIKKS/7lF2
	 GBOHlCDxmMo1uf/3c5QtKm0uID+zM1yQBNcRnOfXB0YlF9Mfb2sfbrmNdUZGCih424
	 LsUbTn7/J4s1n2Qz8Kb54xygran+Naqv9zCYmmFXOSOtvOsUc/qEiNzSuFE8FXp2ZS
	 6BzF2nxEYSL5pFxTQO3f2QbiiXhxcR6r2p2k+zG4XBEPSseAUrSHTKXWdNeyWnJzjf
	 80JbhrXw7cNn2J9ph/Tgwwhqq8wsgYbGudYwroTDLVDtCPNcCc8GnudLX4YCgN6anW
	 6k+EK5uLiuXmw==
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
Subject: [PATCH net-next 15/15] eth: fbnic: support queue ops / zero-copy Rx
Date: Tue, 19 Aug 2025 19:57:04 -0700
Message-ID: <20250820025704.166248-16-kuba@kernel.org>
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

Support queue ops. fbnic doesn't shut down the entire device
just to restart a single queue.

  ./tools/testing/selftests/drivers/net/hw/iou-zcrx.py
  TAP version 13
  1..3
  ok 1 iou-zcrx.test_zcrx
  ok 2 iou-zcrx.test_zcrx_oneshot
  ok 3 iou-zcrx.test_zcrx_rss
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   2 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 171 ++++++++++++++++++
 3 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 58ae7f9c8f54..31fac0ba0902 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -156,6 +156,8 @@ struct fbnic_napi_vector {
 	struct fbnic_q_triad qt[];
 };
 
+extern const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops;
+
 netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
 netdev_features_t
 fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 37c900ce8257..abdcf88bc957 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -747,11 +747,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
+	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
 
 	fbnic_set_ethtool_ops(netdev);
 
-	netdev->request_ops_lock = true;
-
 	fbn = netdev_priv(netdev);
 
 	fbn->netdev = netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 980c8e991c0c..e891ae8b4d58 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2212,6 +2212,13 @@ static void __fbnic_nv_disable(struct fbnic_napi_vector *nv)
 	}
 }
 
+static void
+fbnic_nv_disable(struct fbnic_net *fbn, struct fbnic_napi_vector *nv)
+{
+	__fbnic_nv_disable(nv);
+	fbnic_wrfl(fbn->fbd);
+}
+
 void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
@@ -2307,6 +2314,44 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 	return err;
 }
 
+static int
+fbnic_wait_queue_idle(struct fbnic_net *fbn, bool rx, unsigned int idx)
+{
+	static const unsigned int tx_regs[] = {
+		FBNIC_QM_TWQ_IDLE(0), FBNIC_QM_TQS_IDLE(0),
+		FBNIC_QM_TDE_IDLE(0), FBNIC_QM_TCQ_IDLE(0),
+	}, rx_regs[] = {
+		FBNIC_QM_HPQ_IDLE(0), FBNIC_QM_PPQ_IDLE(0),
+		FBNIC_QM_RCQ_IDLE(0),
+	};
+	struct fbnic_dev *fbd = fbn->fbd;
+	unsigned int val, mask, off;
+	const unsigned int *regs;
+	unsigned int reg_cnt;
+	int i, err;
+
+	regs = rx ? rx_regs : tx_regs;
+	reg_cnt = rx ? ARRAY_SIZE(rx_regs) : ARRAY_SIZE(tx_regs);
+
+	off = idx / 32;
+	mask = BIT(idx % 32);
+
+	for (i = 0; i < reg_cnt; i++) {
+		err = read_poll_timeout_atomic(fbnic_rd32, val, val & mask,
+					       2, 500000, false,
+					       fbd, regs[i] + off);
+		if (err) {
+			netdev_err(fbd->netdev,
+				   "wait for queue %s%d idle failed 0x%04x(%d): %08x (mask: %08x)\n",
+				   rx ? "Rx" : "Tx", idx, regs[i] + off, i,
+				   val, mask);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static void fbnic_nv_flush(struct fbnic_napi_vector *nv)
 {
 	int j, t;
@@ -2625,6 +2670,12 @@ static void __fbnic_nv_enable(struct fbnic_napi_vector *nv)
 	}
 }
 
+static void fbnic_nv_enable(struct fbnic_net *fbn, struct fbnic_napi_vector *nv)
+{
+	__fbnic_nv_enable(nv);
+	fbnic_wrfl(fbn->fbd);
+}
+
 void fbnic_enable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
@@ -2703,3 +2754,123 @@ void fbnic_napi_depletion_check(struct net_device *netdev)
 
 	fbnic_wrfl(fbd);
 }
+
+static int fbnic_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	const struct fbnic_q_triad *real;
+	struct fbnic_q_triad *qt = qmem;
+	struct fbnic_napi_vector *nv;
+
+	if (!netif_running(dev))
+		return fbnic_alloc_qt_page_pools(fbn, qt, idx);
+
+	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
+	nv = fbn->napi[idx % fbn->num_napi];
+
+	fbnic_ring_init(&qt->sub0, real->sub0.doorbell, real->sub0.q_idx,
+			real->sub0.flags);
+	fbnic_ring_init(&qt->sub1, real->sub1.doorbell, real->sub1.q_idx,
+			real->sub1.flags);
+	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
+			real->cmpl.flags);
+
+	return fbnic_alloc_rx_qt_resources(fbn, nv, qt);
+}
+
+static void fbnic_queue_mem_free(struct net_device *dev, void *qmem)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	struct fbnic_q_triad *qt = qmem;
+
+	if (!netif_running(dev))
+		fbnic_free_qt_page_pools(qt);
+	else
+		fbnic_free_qt_resources(fbn, qt);
+}
+
+static void __fbnic_nv_restart(struct fbnic_net *fbn,
+			       struct fbnic_napi_vector *nv)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	int i;
+
+	fbnic_nv_enable(fbn, nv);
+	fbnic_nv_fill(nv);
+
+	napi_enable_locked(&nv->napi);
+	fbnic_nv_irq_enable(nv);
+	fbnic_wr32(fbd, FBNIC_INTR_SET(nv->v_idx / 32), BIT(nv->v_idx % 32));
+	fbnic_wrfl(fbd);
+
+	for (i = 0; i < nv->txt_count; i++)
+		netif_wake_subqueue(fbn->netdev, nv->qt[i].sub0.q_idx);
+}
+
+static int fbnic_queue_start(struct net_device *dev, void *qmem, int idx)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	struct fbnic_napi_vector *nv;
+	struct fbnic_q_triad *real;
+
+	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
+	nv = fbn->napi[idx % fbn->num_napi];
+
+	fbnic_aggregate_ring_rx_counters(fbn, &real->sub0);
+	fbnic_aggregate_ring_rx_counters(fbn, &real->sub1);
+	fbnic_aggregate_ring_rx_counters(fbn, &real->cmpl);
+
+	memcpy(real, qmem, sizeof(*real));
+
+	__fbnic_nv_restart(fbn, nv);
+
+	return 0;
+}
+
+static int fbnic_queue_stop(struct net_device *dev, void *qmem, int idx)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	const struct fbnic_q_triad *real;
+	struct fbnic_napi_vector *nv;
+	int i, t;
+	int err;
+
+	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
+	nv = fbn->napi[idx % fbn->num_napi];
+
+	napi_disable_locked(&nv->napi);
+	fbnic_nv_irq_disable(nv);
+
+	for (i = 0; i < nv->txt_count; i++)
+		netif_stop_subqueue(dev, nv->qt[i].sub0.q_idx);
+	fbnic_nv_disable(fbn, nv);
+
+	for (t = 0; t < nv->txt_count + nv->rxt_count; t++) {
+		err = fbnic_wait_queue_idle(fbn, t >= nv->txt_count,
+					    nv->qt[t].sub0.q_idx);
+		if (err)
+			goto err_restart;
+	}
+
+	fbnic_synchronize_irq(fbn->fbd, nv->v_idx);
+	fbnic_nv_flush(nv);
+
+	page_pool_disable_direct_recycling(real->sub0.page_pool);
+	page_pool_disable_direct_recycling(real->sub1.page_pool);
+
+	memcpy(qmem, real, sizeof(*real));
+
+	return 0;
+
+err_restart:
+	__fbnic_nv_restart(fbn, nv);
+	return err;
+}
+
+const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops = {
+	.ndo_queue_mem_size	= sizeof(struct fbnic_q_triad),
+	.ndo_queue_mem_alloc	= fbnic_queue_mem_alloc,
+	.ndo_queue_mem_free	= fbnic_queue_mem_free,
+	.ndo_queue_start	= fbnic_queue_start,
+	.ndo_queue_stop		= fbnic_queue_stop,
+};
-- 
2.50.1


