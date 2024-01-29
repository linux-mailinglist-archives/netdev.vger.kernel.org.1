Return-Path: <netdev+bounces-66640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC898400B1
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306551F210D7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A3354BF0;
	Mon, 29 Jan 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GQ5RIc34"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4254BE8
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518584; cv=none; b=EgHztOfP6JfOxPzuCrH/koN3yUXc02EH0LCHJzKlY1lGe+2KZGgAT33UFVuizGntoxtmS8WBiFAJm+d+kPRaf6i7QOukMoxV+UDUIPPKRCt6JJfA4Am4w9NwwQAkV+d3fdqmgL5ZeIjK0E9HfRZpQqORfBKpLZb/BeYp4PJ/ofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518584; c=relaxed/simple;
	bh=G0fFSXuD+1kGJ6yvOzBCNvlXIqftm2TOJkmJgYFX3T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mW9RpdHD+FeW0ZUOwuirkB6KcIKCr+srA33D6gwKv2k5ELMMeEdiEoWvW680FhaAFf57kgDflr81OeRxr2lZcvi4LnB9zG0hWelQlnBZW8KxDX0armAwiTQXdn61xTDs59vg/brpy2ZHyHa8mLO6aol/y7TgO3C0Hodv3BhXNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GQ5RIc34; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518583; x=1738054583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wG0p+AgUsxBrxitzrF3nbH/sJ2gGdkQ7snFV7YrrD7Y=;
  b=GQ5RIc34E0Qzk99xbQ/Wcv+jKVr0y1UUNCz6RxfeMUrd4dhB3vSP2VVH
   OqIlwmc4W9m9bWGYcjqsr8LBtkJ+EeWR4DcbPl/9+az0JTWHd6/x/zSqI
   7LA2XNWUVgVMMxmQHHW5FVonqBZH+4V8RGsh1iWmapPlgF8/MbkmLIfBh
   Q=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="609347738"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:56:19 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id C3EB9A0823;
	Mon, 29 Jan 2024 08:56:18 +0000 (UTC)
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:28017]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.29.125:2525] with esmtp (Farcaster)
 id b774696a-ea62-4267-94f0-5340c631d5e6; Mon, 29 Jan 2024 08:56:17 +0000 (UTC)
X-Farcaster-Flow-ID: b774696a-ea62-4267-94f0-5340c631d5e6
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:17 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:17 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:56:15
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkolder@amazon.com>
Subject: [PATCH v1 net-next 10/11] net: ena: handle ena_calc_io_queue_size() possible errors
Date: Mon, 29 Jan 2024 08:55:30 +0000
Message-ID: <20240129085531.15608-11-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
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

Fail queue size calculation when the device returns maximum
TX/RX queue sizes that are smaller than the allowed minimum.

Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 24 +++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 8d99904..ca56dff 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2899,8 +2899,8 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_xdp_xmit		= ena_xdp_xmit,
 };
 
-static void ena_calc_io_queue_size(struct ena_adapter *adapter,
-				   struct ena_com_dev_get_features_ctx *get_feat_ctx)
+static int ena_calc_io_queue_size(struct ena_adapter *adapter,
+				  struct ena_com_dev_get_features_ctx *get_feat_ctx)
 {
 	struct ena_admin_feature_llq_desc *llq = &get_feat_ctx->llq;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -2959,6 +2959,18 @@ static void ena_calc_io_queue_size(struct ena_adapter *adapter,
 	max_tx_queue_size = rounddown_pow_of_two(max_tx_queue_size);
 	max_rx_queue_size = rounddown_pow_of_two(max_rx_queue_size);
 
+	if (max_tx_queue_size < ENA_MIN_RING_SIZE) {
+		netdev_err(adapter->netdev, "Device max TX queue size: %d < minimum: %d\n",
+			   max_tx_queue_size, ENA_MIN_RING_SIZE);
+		return -EFAULT;
+	}
+
+	if (max_rx_queue_size < ENA_MIN_RING_SIZE) {
+		netdev_err(adapter->netdev, "Device max RX queue size: %d < minimum: %d\n",
+			   max_rx_queue_size, ENA_MIN_RING_SIZE);
+		return -EFAULT;
+	}
+
 	/* When forcing large headers, we multiply the entry size by 2, and therefore divide
 	 * the queue size by 2, leaving the amount of memory used by the queues unchanged.
 	 */
@@ -2989,6 +3001,8 @@ static void ena_calc_io_queue_size(struct ena_adapter *adapter,
 	adapter->max_rx_ring_size = max_rx_queue_size;
 	adapter->requested_tx_ring_size = tx_queue_size;
 	adapter->requested_rx_ring_size = rx_queue_size;
+
+	return 0;
 }
 
 static int ena_device_validate_params(struct ena_adapter *adapter,
@@ -3190,11 +3204,15 @@ static int ena_device_init(struct ena_adapter *adapter, struct pci_dev *pdev,
 		goto err_admin_init;
 	}
 
-	ena_calc_io_queue_size(adapter, get_feat_ctx);
+	rc = ena_calc_io_queue_size(adapter, get_feat_ctx);
+	if (unlikely(rc))
+		goto err_admin_init;
 
 	return 0;
 
 err_admin_init:
+	ena_com_abort_admin_commands(ena_dev);
+	ena_com_wait_for_abort_completion(ena_dev);
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
 err_mmio_read_less:
-- 
2.40.1


