Return-Path: <netdev+bounces-116626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9794B36F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E309B21FFF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBAA15575E;
	Wed,  7 Aug 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJCWgZ+D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06428155399
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072417; cv=none; b=QNTbf9+IP/XZKk9QRaLwrw/n3s4Q13Cwd8DwK8Rr6UJWNDEIQOsfxIrcCnv962xoV7fC8dZAQCpk2Jia825DSYKD0TwtmKB+Kh4QG0KDWP1nS9CAtJpYeDQ5kPapRoqFqZamVfCNIfzwZIl+15a357QhyhZ/ygCge2HOV5YsR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072417; c=relaxed/simple;
	bh=5mM5ABSp43dV7RdzUepqRAXJkGdgenmlsijFtwlLMuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEP5z1X5YD2hL8js00pb9yMZDj/QVYIQEzroJSPjxjaYKzr2F7E1ZkiQlzZW9lgw6vQkWsnB0Qht1MuxfX+v6SNaCPtvjZFhGsyL+IglQ2T0oGQssQNK5hQ4L7Kr3xzf82w+9bhMgPP6HJW7AK9KAKstjBrqfkP+jf8Kjuwq3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJCWgZ+D; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072416; x=1754608416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5mM5ABSp43dV7RdzUepqRAXJkGdgenmlsijFtwlLMuA=;
  b=YJCWgZ+D5SlH+YOfp8Wo2CW41uVH+pY+WZzOBw771Lks3a5gs+/ptYI4
   Nuvf/4uNIVukounhD8F/nxt/1lhDv74SL9xWdf0xnFGUo2CAVYWFO0yi5
   o5kgUz7qu3EvI723/1+1ZCotp0Ff2iLjfSlCKFPZqz37UbaQ3TGT/cNuH
   2gLE6oMZBqWGob4NG9lQ/TNWhRKth7bXMjw2UT1Q5l14UyCBHhZJf1PUG
   FKMOYTCRzDT7El/NHP4BuzQoxulBiSscJLIQe0y+kKKHHP6edGHbP1Wb3
   ilUKeur0zPR/HdKT3PTky66IUjl9X4Fc96lWrHsnslV0s0DEW4ruIKZsJ
   w==;
X-CSE-ConnectionGUID: OLuKLyfIR+WIZGKb+zJk4Q==
X-CSE-MsgGUID: 8vyyRCnNRyCE2Os+M01ZHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577304"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577304"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:13:34 -0700
X-CSE-ConnectionGUID: DU+/IvOwT9aGgTQpN1fA7w==
X-CSE-MsgGUID: IOEk77/VSzmnW2sG3Bgl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61956620"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 16:13:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 1/4] igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
Date: Wed,  7 Aug 2024 16:13:25 -0700
Message-ID: <20240807231329.3827092-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
References: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

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

Fixes: 43546211738e ("igc: Add new device ID's")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index 22cefb1eeedf..46d4c3275bbb 100644
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
+ * a) Ethernet Controller I225/I226 Specification Update Rev 2.1
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
2.42.0


