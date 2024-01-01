Return-Path: <netdev+bounces-60709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DB8213EF
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117EF1C20BD3
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008763DF;
	Mon,  1 Jan 2024 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NRiEarkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C183C0A
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118089; x=1735654089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++UemTOn93qpIGbaiy1wWFdXDHZ36z/K67/za7oINzg=;
  b=NRiEarkxDphJiSDgfHt6u6PUzuvbbJCeqluWbSqrjzcvFBTsasETxRSy
   a1ZMgXrIbbUuP/STgj/rLEbTYaGys/HKp7Ev82jkkfnfXu48gHBRJTLJO
   TuDzHS2WLA/qAgQNJuMHwzJq4qSQylf5WGF73J/Mj6c4c7UaV01DlHflN
   s=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="175397214"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:08:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 785A840D52;
	Mon,  1 Jan 2024 14:08:06 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:48451]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.72:2525] with esmtp (Farcaster)
 id 1e1cdcea-9fa4-43de-8b9d-8aa9cea9a564; Mon, 1 Jan 2024 14:08:06 +0000 (UTC)
X-Farcaster-Flow-ID: 1e1cdcea-9fa4-43de-8b9d-8aa9cea9a564
Received: from EX19D009UWB004.ant.amazon.com (10.13.138.86) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:08:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D009UWB004.ant.amazon.com (10.13.138.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:08:03 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:08:00 +0000
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
Subject: [PATCH v1 net-next 09/11] net: ena: Always register RX queue info
Date: Mon, 1 Jan 2024 14:07:22 +0000
Message-ID: <20240101140724.26232-10-darinzon@amazon.com>
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


