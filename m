Return-Path: <netdev+bounces-208231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A1B0AA6B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9FA4528C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543732E9ED6;
	Fri, 18 Jul 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNaQ5tBo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706932E88BB
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864695; cv=none; b=hl2kS0LdKLnBkye6zTEWRb6VGDx1RqcCIOl+1t1Zmq33aAe55zZcbSapOqdKStaY+lM6tDkDlHQo1pn6KuIquFNarhaQrRbx2ywuoGE286bGe+JrmpUDhiCC6zDnTa1bFZoAnzK2wem9ZqU0beiL3WukjfoSY0B4bbTIQQytYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864695; c=relaxed/simple;
	bh=PQ1yDixxiQlWsQ9AxpUB/JUwtCB5rTMkVmyYx3J5z+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4XpxfuHe26CEElURVvLSMVsKeu5yles38KCxWFnF3H5nwmN1kaRiHDa8z+hw/zvwj85oKszV64oXMzyNClasyOK+n2I8D9xbHHtEsCWufY2dcsyDzyN6kN/awgWs7syyGH23hxSIENzPq/p5IXyMDY69134I4u0DhyWVQSzakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNaQ5tBo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864693; x=1784400693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQ1yDixxiQlWsQ9AxpUB/JUwtCB5rTMkVmyYx3J5z+A=;
  b=RNaQ5tBoFA0i9v33xc2DIw+56w2wpSwBL+AfXfgP2vyYWz+MNLQg5KDs
   Uw/Ly7ummN2DJ+qhVIiYR0lmUTPq8TRLdtFf9j74ElmwgZiU9Pabe/OXW
   Smi3Q6nJNabsHdtSVwjKw/Aon5qbTPNockAwziMEbMyL3NYWcEQ6fR6vq
   /XnBtrda0ZAfUiknaN/qz8wkjzxyasXCRM7LExhShTR+5esTkvhDgdMpD
   2L6Z8mk1s0Rh+WkYKr1DWt8HLphTGwCtAMSbdLzwKoZhcLLWsf6Z91o9k
   B4nkqrD1HR9SkeezFmKH4LZzDcH6QGuprkfuCEumqICOxh3JK72je3uoe
   Q==;
X-CSE-ConnectionGUID: xFCf59/xQR6bSDkXOEUiKA==
X-CSE-MsgGUID: 32T1QnBvQkmagGs5KFOKyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320639"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320639"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:25 -0700
X-CSE-ConnectionGUID: jlO7Y2h8QB6tu3pUs0N1dA==
X-CSE-MsgGUID: sEA0S7sxREaO5MsEZ18hGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506915"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	anthony.l.nguyen@intel.com,
	enjuk@amazon.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 12/13] igbvf: remove unused fields from struct igbvf_adapter
Date: Fri, 18 Jul 2025 11:51:13 -0700
Message-ID: <20250718185118.2042772-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuto Ohnuki <ytohnuki@amazon.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 25 -----------------------
 drivers/net/ethernet/intel/igbvf/netdev.c |  7 -------
 2 files changed, 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index ba9c3fee6da7..da8e1fd47301 100644
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
@@ -229,24 +214,14 @@ struct igbvf_adapter {
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
index aed9162afd38..61dfcd8cb370 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1629,10 +1629,6 @@ static int igbvf_sw_init(struct igbvf_adapter *adapter)
 	adapter->max_frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
-	adapter->tx_int_delay = 8;
-	adapter->tx_abs_int_delay = 32;
-	adapter->rx_int_delay = 0;
-	adapter->rx_abs_int_delay = 8;
 	adapter->requested_itr = 3;
 	adapter->current_itr = IGBVF_START_ITR;
 
@@ -2708,7 +2704,6 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct igbvf_adapter *adapter;
 	struct e1000_hw *hw;
 	const struct igbvf_info *ei = igbvf_info_tbl[ent->driver_data];
-	static int cards_found;
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -2780,8 +2775,6 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
-	adapter->bd_number = cards_found++;
-
 	netdev->hw_features = NETIF_F_SG |
 			      NETIF_F_TSO |
 			      NETIF_F_TSO6 |
-- 
2.47.1


