Return-Path: <netdev+bounces-204658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF3AFBA4F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F323BFC25
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263241D9A54;
	Mon,  7 Jul 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="exGgoLyT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5D170826;
	Mon,  7 Jul 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911331; cv=none; b=tk0y8jAc/lfL60WnL83bIa9NynBviOi/sYe/G01baFx76k20OaQFKev151gk+wJDMgEGW2dw9Ow0P5IXaHwIUQekolmUFxPa1kHmq8yTm3fW+eGzEv2V/zqeoYwbLXUrFP0bO9+Q0ezhXyaD8wgMvYQV7c1JFxc3CHMLDTZR1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911331; c=relaxed/simple;
	bh=NWeu7SGxhSVdlS/9NEE0yCEzhnJvx/RVSKT6SyfInrk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GUb1CEKxyCAunfyZnPZLxi8aijBvKykaAPpXZWAVpVt/Lo8ce1qNdLq1gZrJgdb+FBTFEv4CsG9NXt4JhRLx5e36GSYFHCIUhWWaQ6zKdtS0A68p3f3tRKYXTiz4oEqIiD1yUY/5eAjLJbNMdxJ6usk0y7k05xNAOom+qEq4t+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=exGgoLyT; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751911329; x=1783447329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JEmWEpxhOD1z6zGsch4in/Gj59Ug9axXAUztg6+oJPc=;
  b=exGgoLyT6hjFXI5Aqp/Ie7R0A+CrrVozT/iOYE57QeDuz7xGWrtT/XcU
   oWMHGhVaXrRLHvYUlDyXyx/6uHB8BIRPtNP+3E872x4YKFUcdG2Hs7N7I
   lTXHpDC+pojvWsVbtE4dw+zVuiGTxxj3zLOVYeb+SbXno65n3p8V4z75p
   6zPGVbqBaI6i0ogGe9DB9bN6FMKlsuTddID9t58EdI1mDj9shuymTjhAd
   4/KrRtxQUHYdeGQ27UjVArZJWYqYr5djLKQnJZn2WoN5JoT6vCVMsXDMh
   ph0FQr1ysEPcnWVs1WDYjYTug/2cEGxxsfBYOfXYASX0X8G4FhgshmNyi
   w==;
X-IronPort-AV: E=Sophos;i="6.16,295,1744070400"; 
   d="scan'208";a="315409596"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 18:02:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:28506]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.16:2525] with esmtp (Farcaster)
 id b7392d5e-6d2c-480f-a030-0f0585b05e06; Mon, 7 Jul 2025 18:02:05 +0000 (UTC)
X-Farcaster-Flow-ID: b7392d5e-6d2c-480f-a030-0f0585b05e06
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 18:02:04 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.15) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 18:02:02 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ytohnuki@amazon.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v1] igbvf: remove unused fields from struct igbvf_adapter
Date: Mon, 7 Jul 2025 19:01:17 +0100
Message-ID: <20250707180116.44657-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove following unused fields from struct igbvf_adapter that are never
referenced in the driver.

- blink_timer
- eeprom_wol
- fc_autoneg
- int_mode
- led_status
- mng_vlan_id
- polling_interval
- rx_dma_failed
- test_icr
- test_rx_ring
- test_tx_ring
- tx_dma_failed
- tx_fifo_head
- tx_fifo_size
- tx_head_addr

Also removed the following fields from struct igbvf_adapter since they
are never read or used after initialization by igbvf_probe() and igbvf_sw_init().

- bd_number
- rx_abs_int_delay
- tx_abs_int_delay
- rx_int_delay
- tx_int_delay

This changes simplify the igbvf driver by removing unused fields, which
improves maintenability.

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 25 -----------------------
 drivers/net/ethernet/intel/igbvf/netdev.c |  7 -------
 2 files changed, 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index ca6e44245a7b..a61e8eeb4121 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -154,7 +154,6 @@ struct igbvf_ring {
 /* board specific private data structure */
 struct igbvf_adapter {
 	struct timer_list watchdog_timer;
-	struct timer_list blink_timer;
 
 	struct work_struct reset_task;
 	struct work_struct watchdog_task;
@@ -162,10 +161,7 @@ struct igbvf_adapter {
 	const struct igbvf_info *ei;
 
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
-	u32 bd_number;
 	u32 rx_buffer_len;
-	u32 polling_interval;
-	u16 mng_vlan_id;
 	u16 link_speed;
 	u16 link_duplex;
 
@@ -183,9 +179,6 @@ struct igbvf_adapter {
 	unsigned int restart_queue;
 	u32 txd_cmd;
 
-	u32 tx_int_delay;
-	u32 tx_abs_int_delay;
-
 	unsigned int total_tx_bytes;
 	unsigned int total_tx_packets;
 	unsigned int total_rx_bytes;
@@ -193,23 +186,15 @@ struct igbvf_adapter {
 
 	/* Tx stats */
 	u32 tx_timeout_count;
-	u32 tx_fifo_head;
-	u32 tx_head_addr;
-	u32 tx_fifo_size;
-	u32 tx_dma_failed;
 
 	/* Rx */
 	struct igbvf_ring *rx_ring;
 
-	u32 rx_int_delay;
-	u32 rx_abs_int_delay;
-
 	/* Rx stats */
 	u64 hw_csum_err;
 	u64 hw_csum_good;
 	u64 rx_hdr_split;
 	u32 alloc_rx_buff_failed;
-	u32 rx_dma_failed;
 
 	unsigned int rx_ps_hdr_size;
 	u32 max_frame_size;
@@ -229,26 +214,16 @@ struct igbvf_adapter {
 	struct e1000_vf_stats stats;
 	u64 zero_base;
 
-	struct igbvf_ring test_tx_ring;
-	struct igbvf_ring test_rx_ring;
-	u32 test_icr;
-
 	u32 msg_enable;
 	struct msix_entry *msix_entries;
-	int int_mode;
 	u32 eims_enable_mask;
 	u32 eims_other;
 	u32 int_counter0;
 	u32 int_counter1;
 
-	u32 eeprom_wol;
 	u32 wol;
 	u32 pba;
 
-	bool fc_autoneg;
-
-	unsigned long led_status;
-
 	unsigned int flags;
 	unsigned long last_reset;
 };
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index e55dd9345833..c5e677d07a20 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1633,10 +1633,6 @@ static int igbvf_sw_init(struct igbvf_adapter *adapter)
 	adapter->max_frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
-	adapter->tx_int_delay = 8;
-	adapter->tx_abs_int_delay = 32;
-	adapter->rx_int_delay = 0;
-	adapter->rx_abs_int_delay = 8;
 	adapter->requested_itr = 3;
 	adapter->current_itr = IGBVF_START_ITR;
 
@@ -2712,7 +2708,6 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct igbvf_adapter *adapter;
 	struct e1000_hw *hw;
 	const struct igbvf_info *ei = igbvf_info_tbl[ent->driver_data];
-	static int cards_found;
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -2784,8 +2779,6 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
-	adapter->bd_number = cards_found++;
-
 	netdev->hw_features = NETIF_F_SG |
 			      NETIF_F_TSO |
 			      NETIF_F_TSO6 |
-- 
2.47.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




