Return-Path: <netdev+bounces-60711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5808213F1
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF921C20C49
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E43FEC;
	Mon,  1 Jan 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KgQz/JaO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DC9453
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118095; x=1735654095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yiVaHEK7ox78KwaLrSV3IfSdVHQsbguEDuiibFheR4E=;
  b=KgQz/JaOBX4zBn81I38Wrv9KLD6a3d8JxNYdNx8KI8MFO97f7xdY+qfu
   sMKw3E+Ccha+ozW6nAR2rV/WqImp8CIfgptyn6mA1Wjn5LYxgjisFrXu6
   YG6/ulQhJkTruVCBcbrPI/B44zFWSzJj6OXG6IUx09deOTgQgVj7PSQrs
   8=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="379573536"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:08:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 989DAA0A70;
	Mon,  1 Jan 2024 14:08:13 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15190]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.154:2525] with esmtp (Farcaster)
 id 80b82a88-34c6-4be2-bc6f-b36a39cbe8ca; Mon, 1 Jan 2024 14:08:12 +0000 (UTC)
X-Farcaster-Flow-ID: 80b82a88-34c6-4be2-bc6f-b36a39cbe8ca
Received: from EX19D021UWA003.ant.amazon.com (10.13.139.74) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:08:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D021UWA003.ant.amazon.com (10.13.139.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:08:12 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:08:09 +0000
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
Subject: [PATCH v1 net-next 11/11] net: ena: Take xdp packets stats into account in ena_get_stats64()
Date: Mon, 1 Jan 2024 14:07:24 +0000
Message-ID: <20240101140724.26232-12-darinzon@amazon.com>
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

Queue stats using ifconfig and ip are retrieved
via ena_get_stats64(). This function currently does not take
the xdp sent or dropped packets stats into account.

This commit adds the following xdp stats to ena_get_stats64():
tx bytes sent
tx packets sent
rx dropped packets

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c5a84ea..1c0a782 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2795,6 +2795,7 @@ static void ena_get_stats64(struct net_device *netdev,
 {
 	struct ena_adapter *adapter = netdev_priv(netdev);
 	struct ena_ring *rx_ring, *tx_ring;
+	u64 total_xdp_rx_drops = 0;
 	unsigned int start;
 	u64 rx_drops;
 	u64 tx_drops;
@@ -2803,8 +2804,8 @@ static void ena_get_stats64(struct net_device *netdev,
 	if (!test_bit(ENA_FLAG_DEV_UP, &adapter->flags))
 		return;
 
-	for (i = 0; i < adapter->num_io_queues; i++) {
-		u64 bytes, packets;
+	for (i = 0; i < adapter->num_io_queues + adapter->xdp_num_queues; i++) {
+		u64 bytes, packets, xdp_rx_drops;
 
 		tx_ring = &adapter->tx_ring[i];
 
@@ -2817,16 +2818,22 @@ static void ena_get_stats64(struct net_device *netdev,
 		stats->tx_packets += packets;
 		stats->tx_bytes += bytes;
 
+		/* In XDP there isn't an RX queue counterpart */
+		if (ENA_IS_XDP_INDEX(adapter, i))
+			continue;
+
 		rx_ring = &adapter->rx_ring[i];
 
 		do {
 			start = u64_stats_fetch_begin(&rx_ring->syncp);
 			packets = rx_ring->rx_stats.cnt;
 			bytes = rx_ring->rx_stats.bytes;
+			xdp_rx_drops = rx_ring->rx_stats.xdp_drop;
 		} while (u64_stats_fetch_retry(&rx_ring->syncp, start));
 
 		stats->rx_packets += packets;
 		stats->rx_bytes += bytes;
+		total_xdp_rx_drops += xdp_rx_drops;
 	}
 
 	do {
@@ -2835,7 +2842,7 @@ static void ena_get_stats64(struct net_device *netdev,
 		tx_drops = adapter->dev_stats.tx_drops;
 	} while (u64_stats_fetch_retry(&adapter->syncp, start));
 
-	stats->rx_dropped = rx_drops;
+	stats->rx_dropped = rx_drops + total_xdp_rx_drops;
 	stats->tx_dropped = tx_drops;
 
 	stats->multicast = 0;
-- 
2.40.1


