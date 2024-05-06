Return-Path: <netdev+bounces-93626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C218BC812
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6601F221DE
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D11422A5;
	Mon,  6 May 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z6r2yDRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C814039E
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979114; cv=none; b=MM2uEtE+fmfWg0ZwvwdwEwbkqX9Hit+sbrCd2qwE0wRSAshZVmOVmV6UkDK8uGTHstiNtjVdjWYlmErKw72aW+PYyeA36FD6qanH79d3eBeL20Jbrj9BlJgeqOwy7mTSRGgjbDQaXP8Wt4UDv7j0jx5sm4Wi4r7dyfVslatldWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979114; c=relaxed/simple;
	bh=3sjiuCuEVgzWKmn6V7by1aqXmRfcSV/TWODtIWQw2Tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imTDVB0TUYXLYAKUPYirnLSww9YlbJbFzUGXOhvTqrZBGvGYSyexkQ6VYGVPlyq/glhJ4qAx/OnpFPQBkCJpot2IzfpMXJbngLrmriMT0dbAp7wV55vEAXc3/J5vg5A9xVO4w1Vnd5iO94V2Uw1HpRolydV13B9wGjeCTtLEhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z6r2yDRy; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714979113; x=1746515113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hqK7YjX30RcyYWudkzqCLxv1PJIQ5kQZobD1wSDzwYI=;
  b=Z6r2yDRyZKGi4HQ8GO+Hw/j9u+NG2PRw50S2F9pc/8gYkcn4lF7kNJLx
   viMiUKWeI1WPatsXX1nhqAEa4G6Py74VRGwd3znMPF++Ja7GnGD9yCmns
   ibGMhxJ1N37AmGnEuB92CJSH0JWaokqZT/XoAYrldooiZdJzxzVhmL3OV
   E=;
X-IronPort-AV: E=Sophos;i="6.07,257,1708387200"; 
   d="scan'208";a="723871357"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:05:06 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.0.204:50748]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.59.248:2525] with esmtp (Farcaster)
 id 49c5451d-6ef1-4df8-8ea0-a260677864b1; Mon, 6 May 2024 07:05:05 +0000 (UTC)
X-Farcaster-Flow-ID: 49c5451d-6ef1-4df8-8ea0-a260677864b1
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:04 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:04 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 07:05:02 +0000
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
Subject: [PATCH v1 net-next 1/6] net: ena: Add a counter for driver's reset failures
Date: Mon, 6 May 2024 07:04:48 +0000
Message-ID: <20240506070453.17054-2-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506070453.17054-1-darinzon@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

This patch adds a counter to the ena_adapter struct in
order to keep track of reset failures.
The counter is incremented every time either ena_restore_device()
or ena_destroy_device() fail.

Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 18 ++++++++++++------
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 0cb6cc1c..28583db8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -49,6 +49,7 @@ static const struct ena_stats ena_stats_global_strings[] = {
 	ENA_STAT_GLOBAL_ENTRY(interface_up),
 	ENA_STAT_GLOBAL_ENTRY(interface_down),
 	ENA_STAT_GLOBAL_ENTRY(admin_q_pause),
+	ENA_STAT_GLOBAL_ENTRY(reset_fail),
 };
 
 static const struct ena_stats ena_stats_eni_strings[] = {
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index be5acfa4..683088af 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(pci, ena_pci_tbl);
 
 static int ena_rss_init_default(struct ena_adapter *adapter);
 static void check_for_admin_com_state(struct ena_adapter *adapter);
-static void ena_destroy_device(struct ena_adapter *adapter, bool graceful);
+static int ena_destroy_device(struct ena_adapter *adapter, bool graceful);
 static int ena_restore_device(struct ena_adapter *adapter);
 
 static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
@@ -3235,14 +3235,15 @@ err_disable_msix:
 	return rc;
 }
 
-static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)
+static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
 	bool dev_up;
+	int rc = 0;
 
 	if (!test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
-		return;
+		return 0;
 
 	netif_carrier_off(netdev);
 
@@ -3260,7 +3261,7 @@ static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 	 *  and device is up, ena_down() already reset the device.
 	 */
 	if (!(test_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags) && dev_up))
-		ena_com_dev_reset(adapter->ena_dev, adapter->reset_reason);
+		rc = ena_com_dev_reset(adapter->ena_dev, adapter->reset_reason);
 
 	ena_free_mgmnt_irq(adapter);
 
@@ -3279,6 +3280,8 @@ static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 
 	clear_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
 	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
+
+	return rc;
 }
 
 static int ena_restore_device(struct ena_adapter *adapter)
@@ -3355,14 +3358,17 @@ err:
 
 static void ena_fw_reset_device(struct work_struct *work)
 {
+	int rc = 0;
+
 	struct ena_adapter *adapter =
 		container_of(work, struct ena_adapter, reset_task);
 
 	rtnl_lock();
 
 	if (likely(test_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))) {
-		ena_destroy_device(adapter, false);
-		ena_restore_device(adapter);
+		rc |= ena_destroy_device(adapter, false);
+		rc |= ena_restore_device(adapter);
+		adapter->dev_stats.reset_fail += !!rc;
 
 		dev_err(&adapter->pdev->dev, "Device reset completed successfully\n");
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 6d2cc202..d5950974 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -290,6 +290,7 @@ struct ena_stats_dev {
 	u64 admin_q_pause;
 	u64 rx_drops;
 	u64 tx_drops;
+	u64 reset_fail;
 };
 
 enum ena_flags_t {
-- 
2.40.1


