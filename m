Return-Path: <netdev+bounces-66638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997B8400AF
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3061F210D6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14354BFA;
	Mon, 29 Jan 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FXjGRcjD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F42454BF4
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518577; cv=none; b=A6PuRvyfYpFaO6chw25MDaNt2D76wAkHEcahjg5C5T8Q5YmgKeqIDBujTs2GwFKRY4Dzs6u2AGFW+ESfdQAodtKR2N3P0pHVTMFvdhAYQfJdub9akwAbOBIxkoGV4dZASj3FH3EJ1xpsW7kBPrNpjPY2DFH8ImUsHgM4HugWPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518577; c=relaxed/simple;
	bh=iQc89UFFtZLhiLLnPAahFLTOTj7yF81e9V+65p0uYeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXmyR7BBH2XqbnCQ9H0yy30AthS0A/CHDeA+H7YsuSBk/LbQ1Ro72AeWHZZbGHzmr6wMyjCZjDtR+Z7mY7R0vVpDsfEDKx0ZMeDP3igZyo5iKBveXglAbILcfuyyPHNOKkpxHqSRq82OhTMLy+/uErpo4JlGvC6/E7/hekPAbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FXjGRcjD; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518576; x=1738054576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnzyTh8BwF4/EL/wTM9wffLJO2Pc4A/RjdxlKGoo7Ak=;
  b=FXjGRcjDo67nzf0diH3n7A5TLy+i2GymvoHBDGqZ2JpvC86EVYRxYwSN
   lHa5Q4gy1qUg8/dz+x8aC+Aqn0bkDUdqcRb9g345ulNKfOBJk8VEMO5Ci
   AHRgukfkb2HBbP57KK3xHJznkHWOF36RGCtwZsqLZSpgpWHIt8o/tHSHw
   4=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="61883170"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:56:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 8C10D4A683;
	Mon, 29 Jan 2024 08:56:11 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:14730]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id 591b8421-ac34-4b81-9722-df1743a71c45; Mon, 29 Jan 2024 08:56:10 +0000 (UTC)
X-Farcaster-Flow-ID: 591b8421-ac34-4b81-9722-df1743a71c45
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:07 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:56:04
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
Subject: [PATCH v1 net-next 07/11] net: ena: Add more information on TX timeouts
Date: Mon, 29 Jan 2024 08:55:27 +0000
Message-ID: <20240129085531.15608-8-darinzon@amazon.com>
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

The function responsible for polling TX completions might not receive
the CPU resources it needs due to higher priority tasks running on the
requested core.

The driver might not be able to recognize such cases, but it can use its
state to suspect that they happened. If both conditions are met:

- napi hasn't been executed more than the TX completion timeout value
- napi is scheduled (meaning that we've received an interrupt)

Then it's more likely that the napi handler isn't scheduled because of
an overloaded CPU.
It was decided that for this case, the driver would wait twice as long
as the regular timeout before scheduling a reset.
The driver uses ENA_REGS_RESET_SUSPECTED_POLL_STARVATION reset reason to
indicate this case to the device.

This patch also adds more information to the ena_tx_timeout() callback.
This function is called by the kernel when it detects that a specific TX
queue has been closed for too long.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 77 +++++++++++++++----
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 18acb76..ae9291b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -47,19 +47,44 @@ static int ena_restore_device(struct ena_adapter *adapter);
 
 static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
+	enum ena_regs_reset_reason_types reset_reason = ENA_REGS_RESET_OS_NETDEV_WD;
 	struct ena_adapter *adapter = netdev_priv(dev);
+	unsigned int time_since_last_napi, threshold;
+	struct ena_ring *tx_ring;
+	int napi_scheduled;
+
+	if (txqueue >= adapter->num_io_queues) {
+		netdev_err(dev, "TX timeout on invalid queue %u\n", txqueue);
+		goto schedule_reset;
+	}
+
+	threshold = jiffies_to_usecs(dev->watchdog_timeo);
+	tx_ring = &adapter->tx_ring[txqueue];
+
+	time_since_last_napi = jiffies_to_usecs(jiffies - tx_ring->tx_stats.last_napi_jiffies);
+	napi_scheduled = !!(tx_ring->napi->state & NAPIF_STATE_SCHED);
 
+	netdev_err(dev,
+		   "TX q %d is paused for too long (threshold %u). Time since last napi %u usec. napi scheduled: %d\n",
+		   txqueue,
+		   threshold,
+		   time_since_last_napi,
+		   napi_scheduled);
+
+	if (threshold < time_since_last_napi && napi_scheduled) {
+		netdev_err(dev,
+			   "napi handler hasn't been called for a long time but is scheduled\n");
+			   reset_reason = ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;
+	}
+schedule_reset:
 	/* Change the state of the device to trigger reset
 	 * Check that we are not in the middle or a trigger already
 	 */
-
 	if (test_and_set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))
 		return;
 
-	ena_reset_device(adapter, ENA_REGS_RESET_OS_NETDEV_WD);
+	ena_reset_device(adapter, reset_reason);
 	ena_increase_stat(&adapter->dev_stats.tx_timeout, 1, &adapter->syncp);
-
-	netif_err(adapter, tx_err, dev, "Transmit time out\n");
 }
 
 static void update_rx_ring_mtu(struct ena_adapter *adapter, int mtu)
@@ -3374,14 +3399,18 @@ static int check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
 					  struct ena_ring *tx_ring)
 {
 	struct ena_napi *ena_napi = container_of(tx_ring->napi, struct ena_napi, napi);
+	enum ena_regs_reset_reason_types reset_reason = ENA_REGS_RESET_MISS_TX_CMPL;
 	unsigned int time_since_last_napi;
 	unsigned int missing_tx_comp_to;
 	bool is_tx_comp_time_expired;
 	struct ena_tx_buffer *tx_buf;
 	unsigned long last_jiffies;
+	int napi_scheduled;
 	u32 missed_tx = 0;
 	int i, rc = 0;
 
+	missing_tx_comp_to = jiffies_to_msecs(adapter->missing_tx_completion_to);
+
 	for (i = 0; i < tx_ring->ring_size; i++) {
 		tx_buf = &tx_ring->tx_buffer_info[i];
 		last_jiffies = tx_buf->last_jiffies;
@@ -3408,25 +3437,45 @@ static int check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
 			adapter->missing_tx_completion_to);
 
 		if (unlikely(is_tx_comp_time_expired)) {
-			if (!tx_buf->print_once) {
-				time_since_last_napi = jiffies_to_usecs(jiffies - tx_ring->tx_stats.last_napi_jiffies);
-				missing_tx_comp_to = jiffies_to_msecs(adapter->missing_tx_completion_to);
-				netif_notice(adapter, tx_err, adapter->netdev,
-					     "Found a Tx that wasn't completed on time, qid %d, index %d. %u usecs have passed since last napi execution. Missing Tx timeout value %u msecs\n",
-					     tx_ring->qid, i, time_since_last_napi, missing_tx_comp_to);
+			time_since_last_napi =
+				jiffies_to_usecs(jiffies - tx_ring->tx_stats.last_napi_jiffies);
+			napi_scheduled = !!(ena_napi->napi.state & NAPIF_STATE_SCHED);
+
+			if (missing_tx_comp_to < time_since_last_napi && napi_scheduled) {
+				/* We suspect napi isn't called because the
+				 * bottom half is not run. Require a bigger
+				 * timeout for these cases
+				 */
+				if (!time_is_before_jiffies(last_jiffies +
+					2 * adapter->missing_tx_completion_to))
+					continue;
+
+				reset_reason = ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;
 			}
 
-			tx_buf->print_once = 1;
 			missed_tx++;
+
+			if (tx_buf->print_once)
+				continue;
+
+			netif_notice(adapter, tx_err, adapter->netdev,
+				     "TX hasn't completed, qid %d, index %d. %u usecs from last napi execution, napi scheduled: %d\n",
+				     tx_ring->qid, i, time_since_last_napi, napi_scheduled);
+
+			tx_buf->print_once = 1;
 		}
 	}
 
 	if (unlikely(missed_tx > adapter->missing_tx_completion_threshold)) {
 		netif_err(adapter, tx_err, adapter->netdev,
-			  "The number of lost tx completions is above the threshold (%d > %d). Reset the device\n",
+			  "Lost TX completions are above the threshold (%d > %d). Completion transmission timeout: %u.\n",
 			  missed_tx,
-			  adapter->missing_tx_completion_threshold);
-		ena_reset_device(adapter, ENA_REGS_RESET_MISS_TX_CMPL);
+			  adapter->missing_tx_completion_threshold,
+			  missing_tx_comp_to);
+		netif_err(adapter, tx_err, adapter->netdev,
+			  "Resetting the device\n");
+
+		ena_reset_device(adapter, reset_reason);
 		rc = -EIO;
 	}
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
index 1e007a4..2c3d6a7 100644
--- a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
@@ -21,6 +21,7 @@ enum ena_regs_reset_reason_types {
 	ENA_REGS_RESET_USER_TRIGGER                 = 12,
 	ENA_REGS_RESET_GENERIC                      = 13,
 	ENA_REGS_RESET_MISS_INTERRUPT               = 14,
+	ENA_REGS_RESET_SUSPECTED_POLL_STARVATION    = 15,
 };
 
 /* ena_registers offsets */
-- 
2.40.1


