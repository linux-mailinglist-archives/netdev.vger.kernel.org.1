Return-Path: <netdev+bounces-55723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2380C151
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9948A1C20958
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3061F615;
	Mon, 11 Dec 2023 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BUI1amFp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1081E9
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 22:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702276103; x=1733812103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fNdhKyqQSfTqcVFdqC5AdCH2k1eZp/wrj8V3qDi6cj8=;
  b=BUI1amFp8t4YIKSYo+rXbzdViUekuwoT7XkgvH1m7TQvmp/G2kMzge5H
   HGoQJyCZU6O+F1JVylvlvhx/mik2FKM9vVjIKmsZG+Ep3xn68A+WXHQN2
   2S/dxSHj2ylXHAdwEE75XzoZDwk8DO/ULk2fVsIjSZznp50Fkcvlr0cFg
   g=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="382018409"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:28:17 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 39394A0F83;
	Mon, 11 Dec 2023 06:28:15 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:37394]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.16.162:2525] with esmtp (Farcaster)
 id 6b79ee56-17da-4c07-b655-21f8f6b09897; Mon, 11 Dec 2023 06:28:15 +0000 (UTC)
X-Farcaster-Flow-ID: 6b79ee56-17da-4c07-b655-21f8f6b09897
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:15 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:14 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 11 Dec 2023 06:28:12
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
	<evostrov@amazon.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v2 net 1/4] net: ena: Destroy correct number of xdp queues upon failure
Date: Mon, 11 Dec 2023 06:27:58 +0000
Message-ID: <20231211062801.27891-2-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211062801.27891-1-darinzon@amazon.com>
References: <20231211062801.27891-1-darinzon@amazon.com>
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

The ena_setup_and_create_all_xdp_queues() function freed all the
resources upon failure, after creating only xdp_num_queues queues,
instead of freeing just the created ones.

In this patch, the only resources that are freed, are the ones
allocated right before the failure occurs.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index b5bca48..9884ef3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -74,6 +74,8 @@ static void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 			      struct ena_tx_buffer *tx_info);
 static int ena_create_io_tx_queues_in_range(struct ena_adapter *adapter,
 					    int first_index, int count);
+static void ena_free_all_io_tx_resources_in_range(struct ena_adapter *adapter,
+						  int first_index, int count);
 
 /* Increase a stat by cnt while holding syncp seqlock on 32bit machines */
 static void ena_increase_stat(u64 *statp, u64 cnt,
@@ -457,23 +459,22 @@ static void ena_init_all_xdp_queues(struct ena_adapter *adapter)
 
 static int ena_setup_and_create_all_xdp_queues(struct ena_adapter *adapter)
 {
+	u32 xdp_first_ring = adapter->xdp_first_ring;
+	u32 xdp_num_queues = adapter->xdp_num_queues;
 	int rc = 0;
 
-	rc = ena_setup_tx_resources_in_range(adapter, adapter->xdp_first_ring,
-					     adapter->xdp_num_queues);
+	rc = ena_setup_tx_resources_in_range(adapter, xdp_first_ring, xdp_num_queues);
 	if (rc)
 		goto setup_err;
 
-	rc = ena_create_io_tx_queues_in_range(adapter,
-					      adapter->xdp_first_ring,
-					      adapter->xdp_num_queues);
+	rc = ena_create_io_tx_queues_in_range(adapter, xdp_first_ring, xdp_num_queues);
 	if (rc)
 		goto create_err;
 
 	return 0;
 
 create_err:
-	ena_free_all_io_tx_resources(adapter);
+	ena_free_all_io_tx_resources_in_range(adapter, xdp_first_ring, xdp_num_queues);
 setup_err:
 	return rc;
 }
-- 
2.40.1


