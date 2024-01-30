Return-Path: <netdev+bounces-67084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9E842047
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118021C24A62
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941616A352;
	Tue, 30 Jan 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d/ES2/Ef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72826A334
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608476; cv=none; b=JoTpBq7ubK71j5JDa8fop7Km0yRFpOMejjeaV4ZdE/RiYG6u0ehndXyiqitDai8Siju4J8K10eDn3rAhWPsUxssAIoh2K2E6fNGrbkRUw6yZO/O8VWeDNwOgO7vOZzk/hjkw3Depp3viMF1YJrTPVhuNlvJ0TMSU2bq9ghjXIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608476; c=relaxed/simple;
	bh=us69zVGCUBWs2TF3IYxqGzvKNWcIGv6S6Y8u2d9kfd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0K8hPOUVKcSqT/NeQQOJDqjuiSnGemyrmp8NPYDiVj3HX6BsHdIIuRMw2mCAhdddcGSSwQZe1XCzWbSy/tSQkzVmU5B9CKiIXlRvkHwb2Eogme2xAOooMrcP+m2WPNbSGfvAWORIfs7g78UbmLpBkVErSUwXuxc6KT+4YbTfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d/ES2/Ef; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608475; x=1738144475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Q9fAz4UfKDgIZ+ckd9rfNZR/KOKAT8r7M1gVe6PoOw=;
  b=d/ES2/Ef+Z594Iqkf3WMknMK0H1WAgSX6cXGSvwardkURdmOASbYy4zE
   daVMBDjeuf7ku+J5rnRovFOGiOCLMfx7Uy2RJ1V7PS8CPWUlvi+Knw5GR
   dtxLpsAOZZKhtQB2Su2HOSUVsCVLQ/2auvwUQckBhsNPxaaL8rwwQLtqW
   M=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="383072295"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:33 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id A393E805E7;
	Tue, 30 Jan 2024 09:54:31 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:38614]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.214:2525] with esmtp (Farcaster)
 id 5c34db49-c0c2-4a6b-b853-1d0bb9908aa3; Tue, 30 Jan 2024 09:54:30 +0000 (UTC)
X-Farcaster-Flow-ID: 5c34db49-c0c2-4a6b-b853-1d0bb9908aa3
Received: from EX19D010UWB004.ant.amazon.com (10.13.138.37) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWB004.ant.amazon.com (10.13.138.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:29 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:26
 +0000
From: <darinzon@amazon.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkoler@amazon.com>
Subject: [PATCH v2 net-next 09/11] net: ena: Change default print level for netif_ prints
Date: Tue, 30 Jan 2024 09:53:51 +0000
Message-ID: <20240130095353.2881-10-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130095353.2881-1-darinzon@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
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

The netif_* functions are used by the driver to log events into the
kernel ring (dmesg) similar to the netdev_* ones. Unlike the latter,
the netif_* function family allow the user to choose what events get
logged using ethtool:
	sudo ethtool -s [interface] msglvl [msg_type] on

By default the events which get logged are slow-path related and aren't
printed often (e.g. interface up related prints). This patch removes the
NETIF_MSG_TX_DONE type (called every TX completion polling) from the
defaults and adds NETIF_MSG_IFDOWN instead as it makes more sensible
defaults.

This patch also transforms ena_down() print from netif_info into
netif_dbg (same as the analogue print in ena_up()) as it suits it
better.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d4ca406..8d99904 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -32,7 +32,7 @@ MODULE_LICENSE("GPL");
 #define ENA_MAX_RINGS min_t(unsigned int, ENA_MAX_NUM_IO_QUEUES, num_possible_cpus())
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | \
-		NETIF_MSG_TX_DONE | NETIF_MSG_TX_ERR | NETIF_MSG_RX_ERR)
+		NETIF_MSG_IFDOWN | NETIF_MSG_TX_ERR | NETIF_MSG_RX_ERR)
 
 static struct ena_aenq_handlers aenq_handlers;
 
@@ -2212,7 +2212,7 @@ void ena_down(struct ena_adapter *adapter)
 {
 	int io_queue_count = adapter->num_io_queues + adapter->xdp_num_queues;
 
-	netif_info(adapter, ifdown, adapter->netdev, "%s\n", __func__);
+	netif_dbg(adapter, ifdown, adapter->netdev, "%s\n", __func__);
 
 	clear_bit(ENA_FLAG_DEV_UP, &adapter->flags);
 
-- 
2.40.1


