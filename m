Return-Path: <netdev+bounces-60743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B164821526
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F37281AF3
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D1DDD8;
	Mon,  1 Jan 2024 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RpkUHcuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE448DDC2
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704136197; x=1735672197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++UemTOn93qpIGbaiy1wWFdXDHZ36z/K67/za7oINzg=;
  b=RpkUHcuT2OsQw8LtBjcmr2kHn+OgdzZKJp1NSdZpa4vlpkAd9mz6aV3N
   hQN4LMxsD2C0sj9f1YAVJAO5uQPyiRETIeAWO9y2/kfleSS/Nydlce6W9
   gG9ehu58z57jtR/adncSvtNyNuSncEbYiPWQ67SH6CrydFbhw9Hnmhnf2
   E=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="628636544"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:09:56 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 9CCB8ECA4F;
	Mon,  1 Jan 2024 19:09:55 +0000 (UTC)
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:31772]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.23.15:2525] with esmtp (Farcaster)
 id a82e803c-3c45-4ce3-bb1c-ac5fdeec3f64; Mon, 1 Jan 2024 19:09:54 +0000 (UTC)
X-Farcaster-Flow-ID: a82e803c-3c45-4ce3-bb1c-ac5fdeec3f64
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:50 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:50 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 19:09:48 +0000
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
Subject: [PATCH v2 net-next 09/11] net: ena: Always register RX queue info
Date: Mon, 1 Jan 2024 19:08:53 +0000
Message-ID: <20240101190855.18739-10-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101190855.18739-1-darinzon@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
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

The RX queue info contains information about the RX queue which might
be relevant to the kernel.

To avoid configuring this queue for different scenarios, this patch
moves the RX queue configuration to ena_up()/ena_down() function and
makes it configured every interface state toggle.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |  4 ++++
 drivers/net/ethernet/amazon/ena/ena_xdp.c    | 11 +++++++----
 drivers/net/ethernet/amazon/ena/ena_xdp.h    |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d65ee64..c5a84ea 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -753,6 +753,7 @@ static void ena_destroy_all_rx_queues(struct ena_adapter *adapter)
 	for (i = 0; i < adapter->num_io_queues; i++) {
 		ena_qid = ENA_IO_RXQ_IDX(i);
 		cancel_work_sync(&adapter->ena_napi[i].dim.work);
+		ena_xdp_unregister_rxq_info(&adapter->rx_ring[i]);
 		ena_com_destroy_io_queue(adapter->ena_dev, ena_qid);
 	}
 }
@@ -1984,12 +1985,15 @@ static int ena_create_all_io_rx_queues(struct ena_adapter *adapter)
 		if (rc)
 			goto create_err;
 		INIT_WORK(&adapter->ena_napi[i].dim.work, ena_dim_work);
+
+		ena_xdp_register_rxq_info(&adapter->rx_ring[i]);
 	}
 
 	return 0;
 
 create_err:
 	while (i--) {
+		ena_xdp_unregister_rxq_info(&adapter->rx_ring[i]);
 		cancel_work_sync(&adapter->ena_napi[i].dim.work);
 		ena_com_destroy_io_queue(ena_dev, ENA_IO_RXQ_IDX(i));
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index c9992ce..fc1c4ef 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -191,12 +191,14 @@ setup_err:
 /* Provides a way for both kernel and bpf-prog to know
  * more about the RX-queue a given XDP frame arrived on.
  */
-static int ena_xdp_register_rxq_info(struct ena_ring *rx_ring)
+int ena_xdp_register_rxq_info(struct ena_ring *rx_ring)
 {
 	int rc;
 
 	rc = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev, rx_ring->qid, 0);
 
+	netif_dbg(rx_ring->adapter, ifup, rx_ring->netdev, "Registering RX info for queue %d",
+		  rx_ring->qid);
 	if (rc) {
 		netif_err(rx_ring->adapter, ifup, rx_ring->netdev,
 			  "Failed to register xdp rx queue info. RX queue num %d rc: %d\n",
@@ -217,8 +219,11 @@ err:
 	return rc;
 }
 
-static void ena_xdp_unregister_rxq_info(struct ena_ring *rx_ring)
+void ena_xdp_unregister_rxq_info(struct ena_ring *rx_ring)
 {
+	netif_dbg(rx_ring->adapter, ifdown, rx_ring->netdev,
+		  "Unregistering RX info for queue %d",
+		  rx_ring->qid);
 	xdp_rxq_info_unreg_mem_model(&rx_ring->xdp_rxq);
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 }
@@ -236,10 +241,8 @@ void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
 		old_bpf_prog = xchg(&rx_ring->xdp_bpf_prog, prog);
 
 		if (!old_bpf_prog && prog) {
-			ena_xdp_register_rxq_info(rx_ring);
 			rx_ring->rx_headroom = XDP_PACKET_HEADROOM;
 		} else if (old_bpf_prog && !prog) {
-			ena_xdp_unregister_rxq_info(rx_ring);
 			rx_ring->rx_headroom = NET_SKB_PAD;
 		}
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.h b/drivers/net/ethernet/amazon/ena/ena_xdp.h
index 25204fb..cfd8272 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.h
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.h
@@ -42,6 +42,8 @@ int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
 int ena_xdp_xmit(struct net_device *dev, int n,
 		 struct xdp_frame **frames, u32 flags);
 int ena_xdp(struct net_device *netdev, struct netdev_bpf *bpf);
+int ena_xdp_register_rxq_info(struct ena_ring *rx_ring);
+void ena_xdp_unregister_rxq_info(struct ena_ring *rx_ring);
 
 enum ena_xdp_errors_t {
 	ENA_XDP_ALLOWED = 0,
-- 
2.40.1


