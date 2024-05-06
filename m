Return-Path: <netdev+bounces-93629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C852A8BC815
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA167B21B85
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF150A73;
	Mon,  6 May 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GmFqGz+U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806D5337A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979126; cv=none; b=K7U7Q5ZE8x9rOnkcxe7j4fXENOyiozVLpebW44WSyAUAHTK9CrIXaxRm1xDDaUwUix2h8JYoR4VZsCSWqQYiraLSc8ZJqClOnIUnoTyiDRoFnXSdJk/u8aJQ63vfiR2Pb+6KsH/0TpCasv8GdI3TmGOjN4kTERHm04FB1VFsaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979126; c=relaxed/simple;
	bh=bEnalVJ/sBAM8HVo9cUffBA/gTYUkCrx0WZTpHdZoc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fpq8l36HHNf5/PNM7+cIPXgLGSdjzKiinbR/lSGRdnih17N3dHay5rOFbAjT2BoRQ5T+DJ1fVpHCN4sL4sIQbIEuYEgAKcz7r1auERhwx/qr5qmnRfCMhpiMPYEER5VXBfa+oRdL9e968k4sTbSX6DFjcjlZs1fAmpTel5Dx4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GmFqGz+U; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714979125; x=1746515125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0XtFZI0bNXU9eVOCOmoZdIQycsMMpyx/PKmOu9jgRsQ=;
  b=GmFqGz+UUIFb0fCP5Baga0t4hoyhFk7p+Y5MTVEu95bMdTHKtUFfeQ9m
   OgAitvhs+zkb4AFBuRmO0lilhz9MZshjgF7oeIB4dFQS7pZQMaMS3CynP
   hnFGjlO4VuPHJTbZjefZzhu8+YHOM6fR609botSn5rL2mg0wqaiFOaOxR
   E=;
X-IronPort-AV: E=Sophos;i="6.07,257,1708387200"; 
   d="scan'208";a="394633739"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:05:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:31247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.73:2525] with esmtp (Farcaster)
 id 3d7d49e0-d92c-4031-95ae-acfe3c5e4eb2; Mon, 6 May 2024 07:05:22 +0000 (UTC)
X-Farcaster-Flow-ID: 3d7d49e0-d92c-4031-95ae-acfe3c5e4eb2
Received: from EX19D010UWA003.ant.amazon.com (10.13.138.199) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWA003.ant.amazon.com (10.13.138.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:22 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 07:05:19 +0000
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
Subject: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt moderation update action
Date: Mon, 6 May 2024 07:04:53 +0000
Message-ID: <20240506070453.17054-7-darinzon@amazon.com>
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

Changes in the interrupt moderation values for TX/RX are infrequent
from host side. When asking to unmask interrupts, the driver always
provides the requested interrupt moderation values, regardless of
whether they've changed or not.

A new mechanism has been developed in new devices, which allows
selectively updating the relevant HW components based on whether
interrupt moderation values have changed from the previous request
or not (and by that, saving the processing on the device side).

When a change in the interrupt moderation value is made (either by
DIM or through an ethtool command), a field is updated to reflect
this change. When asking to unmask interrupts, the driver checks
the above mentioned field to see if any of the interrupt moderation
values (TX or RX) for the particular queue whose interrupts
are now being unmasked has changed, and updates the device accordingly.
The mentioned field is being reset (set to false) during the
procedure which triggers the interrupt unmask.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.h     |  9 +++++-
 .../net/ethernet/amazon/ena/ena_eth_io_defs.h |  5 ++-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 14 +++++---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 32 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  9 ++++--
 5 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 924f03f5..adce2d7f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -980,13 +980,16 @@ static inline bool ena_com_get_cap(struct ena_com_dev *ena_dev,
  * @rx_delay_interval: Rx interval in usecs
  * @tx_delay_interval: Tx interval in usecs
  * @unmask: unmask enable/disable
+ * @no_moderation_update: 0 - Indicates that any of the TX/RX intervals was
+ *                        updated, 1 - otherwise
  *
  * Prepare interrupt update register with the supplied parameters.
  */
 static inline void ena_com_update_intr_reg(struct ena_eth_io_intr_reg *intr_reg,
 					   u32 rx_delay_interval,
 					   u32 tx_delay_interval,
-					   bool unmask)
+					   bool unmask,
+					   bool no_moderation_update)
 {
 	intr_reg->intr_control = 0;
 	intr_reg->intr_control |= rx_delay_interval &
@@ -998,6 +1001,10 @@ static inline void ena_com_update_intr_reg(struct ena_eth_io_intr_reg *intr_reg,
 
 	if (unmask)
 		intr_reg->intr_control |= ENA_ETH_IO_INTR_REG_INTR_UNMASK_MASK;
+
+	intr_reg->intr_control |=
+		(((u32)no_moderation_update) << ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_SHIFT) &
+			ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_MASK;
 }
 
 static inline u8 *ena_com_get_next_bounce_buffer(struct ena_com_io_bounce_buffer_control *bounce_buf_ctrl)
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_io_defs.h b/drivers/net/ethernet/amazon/ena/ena_eth_io_defs.h
index 332ac0d2..a4d6d0ee 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_io_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_io_defs.h
@@ -261,7 +261,8 @@ struct ena_eth_io_intr_reg {
 	/* 14:0 : rx_intr_delay
 	 * 29:15 : tx_intr_delay
 	 * 30 : intr_unmask
-	 * 31 : reserved
+	 * 31 : no_moderation_update - 0 - moderation
+	 *    updated, 1 - moderation not updated
 	 */
 	u32 intr_control;
 };
@@ -381,6 +382,8 @@ struct ena_eth_io_numa_node_cfg_reg {
 #define ENA_ETH_IO_INTR_REG_TX_INTR_DELAY_MASK              GENMASK(29, 15)
 #define ENA_ETH_IO_INTR_REG_INTR_UNMASK_SHIFT               30
 #define ENA_ETH_IO_INTR_REG_INTR_UNMASK_MASK                BIT(30)
+#define ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_SHIFT      31
+#define ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_MASK       BIT(31)
 
 /* numa_node_cfg_reg */
 #define ENA_ETH_IO_NUMA_NODE_CFG_REG_NUMA_MASK              GENMASK(7, 0)
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index b24cc3f0..d7a343ce 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -390,8 +390,11 @@ static void ena_update_tx_rings_nonadaptive_intr_moderation(struct ena_adapter *
 
 	val = ena_com_get_nonadaptive_moderation_interval_tx(adapter->ena_dev);
 
-	for (i = 0; i < adapter->num_io_queues; i++)
-		adapter->tx_ring[i].smoothed_interval = val;
+	for (i = 0; i < adapter->num_io_queues; i++) {
+		adapter->tx_ring[i].interrupt_interval_changed =
+			adapter->tx_ring[i].interrupt_interval != val;
+		adapter->tx_ring[i].interrupt_interval = val;
+	}
 }
 
 static void ena_update_rx_rings_nonadaptive_intr_moderation(struct ena_adapter *adapter)
@@ -401,8 +404,11 @@ static void ena_update_rx_rings_nonadaptive_intr_moderation(struct ena_adapter *
 
 	val = ena_com_get_nonadaptive_moderation_interval_rx(adapter->ena_dev);
 
-	for (i = 0; i < adapter->num_io_queues; i++)
-		adapter->rx_ring[i].smoothed_interval = val;
+	for (i = 0; i < adapter->num_io_queues; i++) {
+		adapter->rx_ring[i].interrupt_interval_changed =
+			adapter->rx_ring[i].interrupt_interval != val;
+		adapter->rx_ring[i].interrupt_interval = val;
+	}
 }
 
 static int ena_set_coalesce(struct net_device *net_dev,
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 53f1000f..d5bac233 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -224,8 +224,10 @@ void ena_init_io_rings(struct ena_adapter *adapter,
 		txr->tx_max_header_size = ena_dev->tx_max_header_size;
 		txr->tx_mem_queue_type = ena_dev->tx_mem_queue_type;
 		txr->sgl_size = adapter->max_tx_sgl_size;
-		txr->smoothed_interval =
+		txr->interrupt_interval =
 			ena_com_get_nonadaptive_moderation_interval_tx(ena_dev);
+		/* Initial value, mark as true */
+		txr->interrupt_interval_changed = true;
 		txr->disable_meta_caching = adapter->disable_meta_caching;
 		spin_lock_init(&txr->xdp_tx_lock);
 
@@ -238,8 +240,10 @@ void ena_init_io_rings(struct ena_adapter *adapter,
 			rxr->ring_size = adapter->requested_rx_ring_size;
 			rxr->rx_copybreak = adapter->rx_copybreak;
 			rxr->sgl_size = adapter->max_rx_sgl_size;
-			rxr->smoothed_interval =
+			rxr->interrupt_interval =
 				ena_com_get_nonadaptive_moderation_interval_rx(ena_dev);
+			/* Initial value, mark as true */
+			rxr->interrupt_interval_changed = true;
 			rxr->empty_rx_queue = 0;
 			rxr->rx_headroom = NET_SKB_PAD;
 			adapter->ena_napi[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
@@ -1364,7 +1368,10 @@ static void ena_dim_work(struct work_struct *w)
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	struct ena_napi *ena_napi = container_of(dim, struct ena_napi, dim);
 
-	ena_napi->rx_ring->smoothed_interval = cur_moder.usec;
+	ena_napi->rx_ring->interrupt_interval = cur_moder.usec;
+	/* DIM will schedule the work in case there was a change in the profile. */
+	ena_napi->rx_ring->interrupt_interval_changed = true;
+
 	dim->state = DIM_START_MEASURE;
 }
 
@@ -1391,24 +1398,33 @@ static void ena_adjust_adaptive_rx_intr_moderation(struct ena_napi *ena_napi)
 void ena_unmask_interrupt(struct ena_ring *tx_ring,
 			  struct ena_ring *rx_ring)
 {
-	u32 rx_interval = tx_ring->smoothed_interval;
+	u32 rx_interval = tx_ring->interrupt_interval;
 	struct ena_eth_io_intr_reg intr_reg;
+	bool no_moderation_update = true;
 
 	/* Rx ring can be NULL when for XDP tx queues which don't have an
 	 * accompanying rx_ring pair.
 	 */
-	if (rx_ring)
+	if (rx_ring) {
 		rx_interval = ena_com_get_adaptive_moderation_enabled(rx_ring->ena_dev) ?
-			rx_ring->smoothed_interval :
+			rx_ring->interrupt_interval :
 			ena_com_get_nonadaptive_moderation_interval_rx(rx_ring->ena_dev);
 
+		no_moderation_update &= !rx_ring->interrupt_interval_changed;
+		rx_ring->interrupt_interval_changed = false;
+	}
+
+	no_moderation_update &= !tx_ring->interrupt_interval_changed;
+	tx_ring->interrupt_interval_changed = false;
+
 	/* Update intr register: rx intr delay,
 	 * tx intr delay and interrupt unmask
 	 */
 	ena_com_update_intr_reg(&intr_reg,
 				rx_interval,
-				tx_ring->smoothed_interval,
-				true);
+				tx_ring->interrupt_interval,
+				true,
+				no_moderation_update);
 
 	ena_increase_stat(&tx_ring->tx_stats.unmask_interrupt, 1,
 			  &tx_ring->syncp);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index d5950974..b5a501eb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -267,8 +267,13 @@ struct ena_ring {
 	enum ena_admin_placement_policy_type tx_mem_queue_type;
 
 	struct ena_com_rx_buf_info ena_bufs[ENA_PKT_MAX_BUFS];
-	u32  smoothed_interval;
-	u32  per_napi_packets;
+	u32 interrupt_interval;
+	/* Indicates whether interrupt interval has changed since previous set.
+	 * This flag will be kept up, until cleared by the routine which updates
+	 * the device with the modified interrupt interval value.
+	 */
+	bool interrupt_interval_changed;
+	u32 per_napi_packets;
 	u16 non_empty_napi_events;
 	struct u64_stats_sync syncp;
 	union {
-- 
2.40.1


