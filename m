Return-Path: <netdev+bounces-157314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A1A09EBA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6293A9A50
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46822256C;
	Fri, 10 Jan 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="lnvbFvnj"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA705221DB1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552066; cv=none; b=uzSYxh9qK8OmGdc4vn0m+FJW3jlG1oyVfK7B9tyr57EKmYezhraNPhdWzaE1ZQ2tw/+9ovkCSJZ7of28FCQsbwc9DBSwoeWTqHZOIVluT6FBWXruvuotbDILz5x66rFvLCPaI0V/o3eYL2083IM57Wzvj6E5z9bsbI4wx74atww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552066; c=relaxed/simple;
	bh=rgHhTf6rAfdZBtEx37/WY25eOmyzxRg99y9EGZXeV8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bFcIpfhu9rs7HHoCOt+gK7vjgTfYqtT1y4Fhd4bKLGA2xj2Lebkfp/ZLL3oOkNkXfbKo+/2CunpnIs5Q9Fiz2znqx90wNk1pYUAl2SsAtIxU+ntqVj3lkwu2FAg3ly9XeEgXaHkFqQIDnD/GXq1Ejk2ia3yJCI19BVPUL0MQGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=lnvbFvnj; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a7mcGKFGYyAkgGGFFu98hnyLdPQNU7wLoBjj71GVM6M=; b=lnvbFvnjcizV+Wk4qEy7YFfzf8
	xpGYF0aXqwrMK5DqD/Qdt6ULNdX8MWDh36zZx97aaD65B+lsylGNgwTpuAnD3WB4aeYxSBZI7Gtyo
	4OqPYXYazWNKWiI5LO8Opuou84e5+WkOMbhcvfLo7qpaJoL2ooG4FNP00K520iGsSTC8=;
Received: from [88.117.60.28] (helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWNfT-000000003Yq-05Vn;
	Fri, 10 Jan 2025 23:39:52 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next] tsnep: Link queues to NAPIs
Date: Fri, 10 Jan 2025 23:39:39 +0100
Message-Id: <20250110223939.37490-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Use netif_queue_set_napi() to link queues to NAPI instances so that they
can be queried with netlink.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 11}'
[{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
 {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
 {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
 {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]

Additionally use netif_napi_set_irq() to also provide NAPI interrupt
number to userspace.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --do napi-get --json='{"id": 9}'
{'defer-hard-irqs': 0,
 'gro-flush-timeout': 0,
 'id': 9,
 'ifindex': 11,
 'irq': 42,
 'irq-suspend-timeout': 0}

Providing information about queues to userspace makes sense as APIs like
XSK provide queue specific access. Also XSK busy polling relies on
queues linked to NAPIs.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 28 ++++++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 45b9f5780902..71e950e023dc 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1984,23 +1984,41 @@ static int tsnep_queue_open(struct tsnep_adapter *adapter,
 
 static void tsnep_queue_enable(struct tsnep_queue *queue)
 {
+	struct tsnep_adapter *adapter = queue->adapter;
+
+	netif_napi_set_irq(&queue->napi, queue->irq);
 	napi_enable(&queue->napi);
-	tsnep_enable_irq(queue->adapter, queue->irq_mask);
+	tsnep_enable_irq(adapter, queue->irq_mask);
 
-	if (queue->tx)
+	if (queue->tx) {
+		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
+				     NETDEV_QUEUE_TYPE_TX, &queue->napi);
 		tsnep_tx_enable(queue->tx);
+	}
 
-	if (queue->rx)
+	if (queue->rx) {
+		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
+				     NETDEV_QUEUE_TYPE_RX, &queue->napi);
 		tsnep_rx_enable(queue->rx);
+	}
 }
 
 static void tsnep_queue_disable(struct tsnep_queue *queue)
 {
-	if (queue->tx)
+	struct tsnep_adapter *adapter = queue->adapter;
+
+	if (queue->rx)
+		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
+				     NETDEV_QUEUE_TYPE_RX, NULL);
+
+	if (queue->tx) {
 		tsnep_tx_disable(queue->tx, &queue->napi);
+		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
+				     NETDEV_QUEUE_TYPE_TX, NULL);
+	}
 
 	napi_disable(&queue->napi);
-	tsnep_disable_irq(queue->adapter, queue->irq_mask);
+	tsnep_disable_irq(adapter, queue->irq_mask);
 
 	/* disable RX after NAPI polling has been disabled, because RX can be
 	 * enabled during NAPI polling
-- 
2.39.5


