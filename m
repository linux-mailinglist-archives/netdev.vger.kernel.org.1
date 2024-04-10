Return-Path: <netdev+bounces-86469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9E89EE9B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95588B2216C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25657158DBC;
	Wed, 10 Apr 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SW8YdXQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3913D2BC
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740460; cv=none; b=SQyPzsa84kqUlg0VdswJdJGjHU8yE9JVFZVcBL34fY8lcEIuqAK9+fXfMLICENIZ3MzIYoy/UBTQLANFqDmcPtTaZQBfG6B/IeHbX5oFwdJGBfJhW5DSdoBWu/40Wg2NE2VmpumrchU5NdbCco4seX+Af8+AUF6NcUGlb5uKC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740460; c=relaxed/simple;
	bh=rpUI9OhY8Iech6UlVObWfF8DxO9jcB5NqLu9I7vh8NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpVfLskMp99Cmqcl8yVLfXhBVq+3swmMnKee9+laNxQHjfrCMtHwnFRjtuckEMcU2Zm7IsWakbSFOdUBQ4TTZgJAWd6v8zGpvID+gOxI+L0JNO7Vtzxt4LKVMTslVR1upoxswsle6mpeQcm0UpNc5xW3FB8tpVC8wndgBleGN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SW8YdXQm; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712740458; x=1744276458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNt4QUoh4dcj2PjndpAELx3g8LF5znHzBYSpuo5boC0=;
  b=SW8YdXQmh/ZJgCDA2Y9zmKA8KiTyvYtLndetKxtTM9GtvtUCa6fGoYhK
   yApxtiM3c+0jN1aiGV8i+StgDGuBcLU5lexEVFRY1BtYBXuZPpAMPsJi+
   2l8PDBQXW9TsszhMk1A+DQCl1mLh9D3yAT7tK+e8X613rI91qQTAtjdZJ
   o=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="80118632"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:14:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:62744]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.49:2525] with esmtp (Farcaster)
 id 55d4b87a-3f50-4d6a-a5b4-0139b5dc1814; Wed, 10 Apr 2024 09:14:16 +0000 (UTC)
X-Farcaster-Flow-ID: 55d4b87a-3f50-4d6a-a5b4-0139b5dc1814
Received: from EX19D021UWA001.ant.amazon.com (10.13.139.24) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D021UWA001.ant.amazon.com (10.13.139.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:15 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 10 Apr 2024 09:14:12
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, Netanel Belgazal
	<netanel@annapurnalabs.com>, Sameeh Jubran <sameehj@amazon.com>, "Amit
 Bernstein" <amitbern@amazon.com>
Subject: [PATCH v1 net 2/4] net: ena: Wrong missing IO completions check order
Date: Wed, 10 Apr 2024 09:13:56 +0000
Message-ID: <20240410091358.16289-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410091358.16289-1-darinzon@amazon.com>
References: <20240410091358.16289-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

Missing IO completions check is called every second (HZ jiffies).
This commit fixes several issues with this check:

1. Duplicate queues check:
   Max of 4 queues are scanned on each check due to monitor budget.
   Once reaching the budget, this check exits under the assumption that
   the next check will continue to scan the remainder of the queues,
   but in practice, next check will first scan the last already scanned
   queue which is not necessary and may cause the full queue scan to
   last a couple of seconds longer.
   The fix is to start every check with the next queue to scan.
   For example, on 8 IO queues:
   Bug: [0,1,2,3], [3,4,5,6], [6,7]
   Fix: [0,1,2,3], [4,5,6,7]

2. Unbalanced queues check:
   In case the number of active IO queues is not a multiple of budget,
   there will be checks which don't utilize the full budget
   because the full scan exits when reaching the last queue id.
   The fix is to run every TX completion check with exact queue budget
   regardless of the queue id.
   For example, on 7 IO queues:
   Bug: [0,1,2,3], [4,5,6], [0,1,2,3]
   Fix: [0,1,2,3], [4,5,6,0], [1,2,3,4]
   The budget may be lowered in case the number of IO queues is less
   than the budget (4) to make sure there are no duplicate queues on
   the same check.
   For example, on 3 IO queues:
   Bug: [0,1,2,0], [1,2,0,1]
   Fix: [0,1,2], [0,1,2]

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 21 +++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 09e7da1a..59befc0f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3481,10 +3481,11 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
 {
 	struct ena_ring *tx_ring;
 	struct ena_ring *rx_ring;
-	int i, budget, rc;
+	int qid, budget, rc;
 	int io_queue_count;
 
 	io_queue_count = adapter->xdp_num_queues + adapter->num_io_queues;
+
 	/* Make sure the driver doesn't turn the device in other process */
 	smp_rmb();
 
@@ -3497,27 +3498,29 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
 	if (adapter->missing_tx_completion_to == ENA_HW_HINTS_NO_TIMEOUT)
 		return;
 
-	budget = ENA_MONITORED_TX_QUEUES;
+	budget = min_t(u32, io_queue_count, ENA_MONITORED_TX_QUEUES);
 
-	for (i = adapter->last_monitored_tx_qid; i < io_queue_count; i++) {
-		tx_ring = &adapter->tx_ring[i];
-		rx_ring = &adapter->rx_ring[i];
+	qid = adapter->last_monitored_tx_qid;
+
+	while (budget) {
+		qid = (qid + 1) % io_queue_count;
+
+		tx_ring = &adapter->tx_ring[qid];
+		rx_ring = &adapter->rx_ring[qid];
 
 		rc = check_missing_comp_in_tx_queue(adapter, tx_ring);
 		if (unlikely(rc))
 			return;
 
-		rc =  !ENA_IS_XDP_INDEX(adapter, i) ?
+		rc =  !ENA_IS_XDP_INDEX(adapter, qid) ?
 			check_for_rx_interrupt_queue(adapter, rx_ring) : 0;
 		if (unlikely(rc))
 			return;
 
 		budget--;
-		if (!budget)
-			break;
 	}
 
-	adapter->last_monitored_tx_qid = i % io_queue_count;
+	adapter->last_monitored_tx_qid = qid;
 }
 
 /* trigger napi schedule after 2 consecutive detections */
-- 
2.40.1


