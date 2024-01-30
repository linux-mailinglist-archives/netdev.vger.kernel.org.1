Return-Path: <netdev+bounces-67088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D484207A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF122B320EF
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE96BB3C;
	Tue, 30 Jan 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XIqc1Qh2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F26A037
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608489; cv=none; b=qZPY5bOBoEabEqVLdnipH15ujxNNMnoL4V/ObpIDZ7i6ERCC+u2stLiZcK6+Yhc772eG0QZlSvXWgMoNqZ7nRyePpje/dsrc4X5kbidn/szma9Znc0WbTCs0TpkhkNrAjGkrCsvkhlrXMq0lk6SDcEgk79FVnzYcwlLbPXFQuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608489; c=relaxed/simple;
	bh=o0Q7zBZbDz60YH0icjs9Du20gv4zQeH1zfM8y3cWzZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL3ZIqkHrNTRW7xYutltWagtb6VFQrJpavPSNoC3vmnhn+GjZpr5aZerc2dLocOtNBcM0G/TAaLZrVtVnhN19GbdHSQddYbnqHb37xYjDELY59tB16x1fs3dbUEPDCTA5ReKMTXN5MgXl8iDe5TSuMnUyRRAMOl5QCpaQ9nWYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XIqc1Qh2; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608489; x=1738144489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/iBCXgRlSZoiIqbFPUMlwYHzUPX0tyEAf95vqgaw0mA=;
  b=XIqc1Qh21TfmMAcS9u/b4tvaqXCw2Go5GO7rGZoSLt8dwWZfw9qvJcNE
   NM226t/lzcJmn/+rRX7Tp3zAY4Qy9ddByBv3qrpUZ3iZX4KgXliU9bWyj
   hwgj7BBB5q4VQhpH9OO53KALriGU/S4c+rDKUz406NQekD27OOzeU11yU
   4=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="383072360"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:47 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 70362A0B2B;
	Tue, 30 Jan 2024 09:54:45 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:21984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.8:2525] with esmtp (Farcaster)
 id b105c260-97a9-4393-ad21-ae0780623a1e; Tue, 30 Jan 2024 09:54:45 +0000 (UTC)
X-Farcaster-Flow-ID: b105c260-97a9-4393-ad21-ae0780623a1e
Received: from EX19D010UWA001.ant.amazon.com (10.13.138.225) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWA001.ant.amazon.com (10.13.138.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:36 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:33
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
Subject: [PATCH v2 net-next 10/11] net: ena: handle ena_calc_io_queue_size() possible errors
Date: Tue, 30 Jan 2024 09:53:52 +0000
Message-ID: <20240130095353.2881-11-darinzon@amazon.com>
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

Fail queue size calculation when the device returns maximum
TX/RX queue sizes that are smaller than the allowed minimum.

Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 24 +++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 8d99904..965a01c 100644
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
+		return -EINVAL;
+	}
+
+	if (max_rx_queue_size < ENA_MIN_RING_SIZE) {
+		netdev_err(adapter->netdev, "Device max RX queue size: %d < minimum: %d\n",
+			   max_rx_queue_size, ENA_MIN_RING_SIZE);
+		return -EINVAL;
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


