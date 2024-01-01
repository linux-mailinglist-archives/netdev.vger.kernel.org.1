Return-Path: <netdev+bounces-60707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8848213ED
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A18B2152B
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED933610C;
	Mon,  1 Jan 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KSfvIHhq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C258BE0
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118080; x=1735654080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CR96B+YILaM99d3bbmSq08xlCZekStwuL9j1AhRmSz8=;
  b=KSfvIHhq+lGc5ErWDUTBIZNOiW/sT1Zy7CRyr+EgqJAkTQLZH9KKrmzs
   HqZ6hHeKomR2sKgHb6mmuSA2nRXomIlcvNVaRXJ5+xujLN8funhD4nyAp
   NHMhKmudFYvek7TbSUwZU7oP17zvluyLXMVYSpIL3yf91oe1NAOfWiVkl
   g=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="628611473"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:07:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id EDD25822A8;
	Mon,  1 Jan 2024 14:07:54 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:11523]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.93:2525] with esmtp (Farcaster)
 id 0f3df674-ae1d-4057-b7c4-2df92acf3d89; Mon, 1 Jan 2024 14:07:54 +0000 (UTC)
X-Farcaster-Flow-ID: 0f3df674-ae1d-4057-b7c4-2df92acf3d89
Received: from EX19D002UWA002.ant.amazon.com (10.13.138.246) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D002UWA002.ant.amazon.com (10.13.138.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:53 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:51 +0000
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v1 net-next 07/11] net: ena: Refactor napi functions
Date: Mon, 1 Jan 2024 14:07:20 +0000
Message-ID: <20240101140724.26232-8-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101140724.26232-1-darinzon@amazon.com>
References: <20240101140724.26232-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

This patch focuses on changes to the XDP part of the napi
polling routine.

1. Update the `napi_comp` stat only when napi is actually
   complete.
2. Simplify the code by using a function pointer to the right
   napi routine (XDP vs non-XDP path)
3. Remove unnecessary local variables.
4. Adjust a debug print to show the processed XDP frame index
   rather than the pointer.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 20 ++++++++---
 drivers/net/ethernet/amazon/ena/ena_xdp.c    | 35 +++++++++-----------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 03da62f..d65ee64 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1754,18 +1754,28 @@ static void ena_del_napi_in_range(struct ena_adapter *adapter,
 static void ena_init_napi_in_range(struct ena_adapter *adapter,
 				   int first_index, int count)
 {
+	int (*napi_handler)(struct napi_struct *napi, int budget);
 	int i;
 
 	for (i = first_index; i < first_index + count; i++) {
 		struct ena_napi *napi = &adapter->ena_napi[i];
+		struct ena_ring *rx_ring, *tx_ring;
 
-		netif_napi_add(adapter->netdev, &napi->napi,
-			       ENA_IS_XDP_INDEX(adapter, i) ? ena_xdp_io_poll : ena_io_poll);
+		memset(napi, 0, sizeof(*napi));
 
-		if (!ENA_IS_XDP_INDEX(adapter, i)) {
-			napi->rx_ring = &adapter->rx_ring[i];
+		rx_ring = &adapter->rx_ring[i];
+		tx_ring = &adapter->tx_ring[i];
+
+		napi_handler = ena_io_poll;
+		if (ENA_IS_XDP_INDEX(adapter, i))
+			napi_handler = ena_xdp_io_poll;
+
+		netif_napi_add(adapter->netdev, &napi->napi, napi_handler);
+
+		if (!ENA_IS_XDP_INDEX(adapter, i))
+			napi->rx_ring = rx_ring;
 
-		napi->tx_ring = &adapter->tx_ring[i];
+		napi->tx_ring = tx_ring;
 		napi->qid = i;
 	}
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index 363e361..dd01b41 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -385,23 +385,22 @@ static int ena_clean_xdp_irq(struct ena_ring *tx_ring, u32 budget)
 			break;
 
 		tx_info = &tx_ring->tx_buffer_info[req_id];
-		xdpf = tx_info->xdpf;
 
-		tx_info->xdpf = NULL;
 		tx_info->last_jiffies = 0;
-		ena_unmap_tx_buff(tx_ring, tx_info);
 
-		netif_dbg(tx_ring->adapter, tx_done, tx_ring->netdev,
-			  "tx_poll: q %d skb %p completed\n", tx_ring->qid,
-			  xdpf);
+		xdpf = tx_info->xdpf;
+		tx_info->xdpf = NULL;
+		ena_unmap_tx_buff(tx_ring, tx_info);
+		xdp_return_frame(xdpf);
 
 		tx_pkts++;
 		total_done += tx_info->tx_descs;
-
-		xdp_return_frame(xdpf);
 		tx_ring->free_ids[next_to_clean] = req_id;
 		next_to_clean = ENA_TX_RING_IDX_NEXT(next_to_clean,
 						     tx_ring->ring_size);
+
+		netif_dbg(tx_ring->adapter, tx_done, tx_ring->netdev,
+			  "tx_poll: q %d pkt #%d req_id %d\n", tx_ring->qid, tx_pkts, req_id);
 	}
 
 	tx_ring->next_to_clean = next_to_clean;
@@ -421,22 +420,19 @@ static int ena_clean_xdp_irq(struct ena_ring *tx_ring, u32 budget)
 int ena_xdp_io_poll(struct napi_struct *napi, int budget)
 {
 	struct ena_napi *ena_napi = container_of(napi, struct ena_napi, napi);
-	u32 xdp_work_done, xdp_budget;
 	struct ena_ring *tx_ring;
-	int napi_comp_call = 0;
+	u32 work_done;
 	int ret;
 
 	tx_ring = ena_napi->tx_ring;
 
-	xdp_budget = budget;
-
 	if (!test_bit(ENA_FLAG_DEV_UP, &tx_ring->adapter->flags) ||
 	    test_bit(ENA_FLAG_TRIGGER_RESET, &tx_ring->adapter->flags)) {
 		napi_complete_done(napi, 0);
 		return 0;
 	}
 
-	xdp_work_done = ena_clean_xdp_irq(tx_ring, xdp_budget);
+	work_done = ena_clean_xdp_irq(tx_ring, budget);
 
 	/* If the device is about to reset or down, avoid unmask
 	 * the interrupt and return 0 so NAPI won't reschedule
@@ -444,18 +440,19 @@ int ena_xdp_io_poll(struct napi_struct *napi, int budget)
 	if (unlikely(!test_bit(ENA_FLAG_DEV_UP, &tx_ring->adapter->flags))) {
 		napi_complete_done(napi, 0);
 		ret = 0;
-	} else if (xdp_budget > xdp_work_done) {
-		napi_comp_call = 1;
-		if (napi_complete_done(napi, xdp_work_done))
+	} else if (budget > work_done) {
+		ena_increase_stat(&tx_ring->tx_stats.napi_comp, 1,
+				  &tx_ring->syncp);
+		if (napi_complete_done(napi, work_done))
 			ena_unmask_interrupt(tx_ring, NULL);
+
 		ena_update_ring_numa_node(tx_ring, NULL);
-		ret = xdp_work_done;
+		ret = work_done;
 	} else {
-		ret = xdp_budget;
+		ret = budget;
 	}
 
 	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->tx_stats.napi_comp += napi_comp_call;
 	tx_ring->tx_stats.tx_poll++;
 	u64_stats_update_end(&tx_ring->syncp);
 	tx_ring->tx_stats.last_napi_jiffies = jiffies;
-- 
2.40.1


