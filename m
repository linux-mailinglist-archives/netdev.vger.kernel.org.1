Return-Path: <netdev+bounces-109648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5131A92949B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F9C282988
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2A6E61B;
	Sat,  6 Jul 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYSO6XKB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018561DFF0;
	Sat,  6 Jul 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720280433; cv=none; b=XskqjNZujMrJTsX6UYHepg1CjoZMnjXhKzG6jmAq75a+hDC7xW2FMIVbWgLyJJQ/0jvUwrX0YH9qzCjdl9WqYzoG5e5VwsEjmY9oykQSFvAIJZwmrpQcrMjpBypxiinsMREiB8H4JfAzkTpkXgLAdxVQq71zA3Maz7L8UvSe69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720280433; c=relaxed/simple;
	bh=B9cq+agi7Z47PzTtFESKu91Q9MobwL8iJhg5tW6e2KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HA5PczWbptHjUzPJ9dpHvIvJjEXQsPhVc934cUVlXax34EqD1cluw+O1FchtTFGXLZuce47mdnwmQYuDfEHr+tqNDUYmmEYGufl96wdynQypzXmqsFC8Xh6lviHAOKviKt23Bnu4XXwgByMZ+tqdeXgZmJXOrLC5FuBIxX7O8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYSO6XKB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720280432; x=1751816432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B9cq+agi7Z47PzTtFESKu91Q9MobwL8iJhg5tW6e2KU=;
  b=nYSO6XKBrZg2YRmH4wmaIKljhNwuvsWMI9verZR/VVniS1HS0h6kKzi5
   c4uUxAMO6gm1OR+MWHRirYuT4X2W24yFMCoFTPBI9ved6YY3dTnkRvkvK
   N5Y5xmN4WU5W47kV4y0DsdoDuPfRvM24gtG5wP3adW8IFTtYILwdIZKgf
   CyxOBmI17WIEq2njtikaYBqVBcrO7HBx62oV1LeL/5z8kLozgn2y66qJ4
   1KQd/lEa9K7Qhb1wKK6QFwvPzjKbbWn/W/1Rv7dMBX2UEhk+pPKytj1R0
   STAQA5pNJ2ycWHM/d9LV18hebFy1nDsDANmrT3/PoBq6nFs2YPdADeUys
   g==;
X-CSE-ConnectionGUID: iZoFic8IR5KzaZZa1mO1sQ==
X-CSE-MsgGUID: OXh9WUhURVCi8t7bzAskGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="21350735"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="21350735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 08:40:31 -0700
X-CSE-ConnectionGUID: hIvsrpwtSAabL+rEevT2Rg==
X-CSE-MsgGUID: 52zHHZnDQ12AyBC6FnhYkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="52294187"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 08:40:31 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 45FEC204150D;
	Sat,  6 Jul 2024 08:40:28 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v2 1/1] igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
Date: Sat,  6 Jul 2024 11:38:07 -0400
Message-Id: <20240706153807.3390950-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing uncovered that even when the taprio gate is closed, some packets
still transmit.

According to i225/6 hardware errata [1], traffic might overflow the
planned QBV window. This happens because MAC maintains an internal buffer,
primarily for supporting half duplex retries. Therefore, even when the
gate closes, residual MAC data in the buffer may still transmit.

To mitigate this for i226, reduce the MAC's internal buffer from 192 bytes
to the recommended 88 bytes by modifying the RETX_CTL register value.

This follows guidelines from:
[1] Ethernet Controller I225/I22 Spec Update Rev 2.1 Errata Item 9:
    TSN: Packet Transmission Might Cross Qbv Window
[2] I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control

Note that the RETX_CTL register can't be used in TSN mode because half
duplex feature cannot coexist with TSN.

Test Steps:
1.  Send taprio cmd to board A:
    tc qdisc replace dev enp1s0 parent root handle 100 taprio \
    num_tc 4 \
    map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
    queues 1@0 1@1 1@2 1@3 \
    base-time 0 \
    sched-entry S 0x07 500000 \
    sched-entry S 0x0f 500000 \
    flags 0x2 \
    txtime-delay 0

    Note that for TC3, gate should open for 500us and close for another
    500us.

3.  Take tcpdump log on Board B.

4.  Send udp packets via UDP tai app from Board A to Board B.

5.  Analyze tcpdump log via wireshark log on Board B. Ensure that the
    total time from the first to the last packet received during one cycle
    for TC3 does not exceed 500us.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com/

Changelog:
v1 -> v2
- Update commit description (Paul).
- Rename qbvfullth -> qbvfullthreshold (Paul).
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  6 ++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 34 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 5f92b3c7c3d4..511384f3ec5c 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -404,6 +404,12 @@
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
 
+/* Retry Buffer Control */
+#define IGC_RETX_CTL			0x041C
+#define IGC_RETX_CTL_WATERMARK_MASK	0xF
+#define IGC_RETX_CTL_QBVFULLTH_SHIFT	8 /* QBV Retry Buffer Full Threshold */
+#define IGC_RETX_CTL_QBVFULLEN	0x1000 /* Enable QBV Retry Buffer Full Threshold */
+
 /* Transmit Scheduling Latency */
 /* Latency between transmission scheduling (LaunchTime) and the time
  * the packet is transmitted to the network in nanosecond.
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 22cefb1eeedf..9df3680b9fcb 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -78,6 +78,15 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 	wr32(IGC_GTXOFFSET, txoffset);
 }
 
+static void igc_tsn_restore_retx_default(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 retxctl;
+
+	retxctl = rd32(IGC_RETX_CTL) & IGC_RETX_CTL_WATERMARK_MASK;
+	wr32(IGC_RETX_CTL, retxctl);
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -91,6 +100,9 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_restore_retx_default(adapter);
+
 	tqavctrl = rd32(IGC_TQAVCTRL);
 	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
 		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
@@ -111,6 +123,25 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	return 0;
 }
 
+/* To partially fix i226 HW errata, reduce MAC internal buffering from 192 Bytes
+ * to 88 Bytes by setting RETX_CTL register using the recommendation from:
+ * a) Ethernet Controller I225/I22 Specification Update Rev 2.1
+ *    Item 9: TSN: Packet Transmission Might Cross the Qbv Window
+ * b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
+ */
+static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 retxctl, watermark;
+
+	retxctl = rd32(IGC_RETX_CTL);
+	watermark = retxctl & IGC_RETX_CTL_WATERMARK_MASK;
+	/* Set QBVFULLTH value using watermark and set QBVFULLEN */
+	retxctl |= (watermark << IGC_RETX_CTL_QBVFULLTH_SHIFT) |
+		   IGC_RETX_CTL_QBVFULLEN;
+	wr32(IGC_RETX_CTL, retxctl);
+}
+
 static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -123,6 +154,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_set_retx_qbvfullthreshold(adapter);
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		u32 txqctl = 0;
-- 
2.25.1


