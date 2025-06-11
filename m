Return-Path: <netdev+bounces-196677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC9AD5DC3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACCB1883BE7
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6228A72F;
	Wed, 11 Jun 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOjT9HeM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273726E708
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665010; cv=none; b=AV/SQRrZ4Vs6BaN/dgbdcAfOLTO0xU4L/08O7c9oIAMgFnqC+4+RPYC116o7JnGCEuvC3Rfcnrq6skHhE9s0gqLpP/kaP8+uX9wSkCSlTSoryzBRQrGTpf+TKUoQBEIBZnSPP4hJCxW1m9F3U1ElGMucRt6BU7ZaVzorDumU0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665010; c=relaxed/simple;
	bh=A5NAD7wuACnMclHO1QKIC086ebTLfAgudnpyK0knCRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkMuxAY5SIH2laspAB/mpe79ezCg72VNbYiJU2oZnDOMFL0n/v6ewyQ9sAW65d3+Cc2XBNz1nbaqF2pIBf7hOkzCBKQQx3NWU3KpiWXM3VoAizXyd0KBo9L8ECK3RS8RY5G87cNbiKYW6S4C1/+uDdd4qRRinP6k5qmSAaDWfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOjT9HeM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665009; x=1781201009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5NAD7wuACnMclHO1QKIC086ebTLfAgudnpyK0knCRo=;
  b=hOjT9HeMxHcGZBD9x8HgN5yEsaxY737etk/0XQxoeERJQGAqOxYb2zxu
   j5TIRuTcoseoLsAtEy1NkACoLVlyvmgGwsuCk3ErVbcWKcjZiweOZvXai
   2TeJZwiHadPixOTS9sfx/oOwEbZsP0g7BjDIHYGfne7ScPPC2afuIt9Ps
   zmoD7xMkix2gsLbPsmmvtHSJZVE+ZUaIFIrK6PnveqW5AnEH5/XMsCUh/
   f1itIHBlLOtjnDMt6XkUoflpfm++4L9BlNqeuoZ8c00+KfuI21/cu79ug
   DKTKqJZTiLfiQkyVRx1ynw88zIlsnuKx36yxJawacVJTv4cJ8Uuy/6NCH
   Q==;
X-CSE-ConnectionGUID: VeyMhKvxQGSN0qmqTdp2CA==
X-CSE-MsgGUID: BSrI3kJ5S3OFYBjSBCfDFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51042568"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51042568"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:03:28 -0700
X-CSE-ConnectionGUID: 0djtYuFZQl+NYq/PqXWNCw==
X-CSE-MsgGUID: low7fiQYRw2JBYNHdiDQJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152418289"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 11:03:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	faizal.abdul.rahim@intel.com,
	chwee.lin.choong@intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 5/7] igc: add private flag to reverse TX queue priority in TSN mode
Date: Wed, 11 Jun 2025 11:03:07 -0700
Message-ID: <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

By default, igc assigns TX hw queue 0 the highest priority and queue 3
the lowest. This is opposite of most NICs, where TX hw queue 3 has the
highest priority and queue 0 the lowest.

mqprio in igc already uses TX arbitration unconditionally to reverse TX
queue priority when mqprio is enabled. The TX arbitration logic does not
require a private flag, because mqprio was added recently and no known
users depend on the default queue ordering, which differs from the typical
convention.

taprio does not use TX arbitration, so it inherits the default igc TX
queue priority order. This causes tc command inconsistencies when
configuring frame preemption with taprio compared to mqprio in igc.
Other tc command inconsistencies and configuration issues already exist
when using taprio on igc compared to other network controllers. These
issues are described in a later section.

To harmonize TX queue priority behavior between taprio and mqprio, and
to fix these issues without breaking long-standing taprio use cases,
this patch adds a new private flag, called reverse-tsn-txq-prio, to
reverse the TX queue priority. It makes queue 3 the highest and queue 0
the lowest, reusing the TX arbitration logic already used by mqprio.

Users must set the private flag when enabling frame preemption with
taprio to follow the standard convention. Doing so promotes adoption of
the correct priority model for new features while preserving
compatibility with legacy configurations.

This new private flag addresses:

1.  Non-standard socket -> tc -> TX hw queue mapping for taprio in igc

Without the private flag:
- taprio maps (socket -> tc -> TX hardware queue) differently on igc
  compared to other network controllers
- On igc, mqprio maps tc differently from taprio, since mqprio already
  uses TX arbitration

The following examples compare taprio configuration on igc and other
network controllers:
a)  On other NICs (TX hw queue 3 is highest priority):
    taprio num_tc 4 map 0 1 2 3 .... \
    queues 1@0 1@1 1@2 1@3

    Mapping translates to:
    socket 0 -> tc 0 -> queue 0
    socket 3 -> tc 3 -> queue 3

    This is the normal mapping that respects the standard convention:
    higher socket number -> higher tc -> higher priority TX hw queue

b)  On igc (TX hw queue 0 is highest priority by default):
    taprio num_tc 4 map 3 2 1 0 .... \
    queues 1@0 1@1 1@2 1@3

    Mapping translates to:
    socket 0 -> tc 3 -> queue 3
    socket 3 -> tc 0 -> queue 0

    This igc tc mapping example is based on Intel's TSN validation test
    case, where a higher socket priority maps to a higher priority queue.
    It respects the mapping:
      higher socket number -> higher priority TX hw queue
    but breaks the expected ordering:
      higher tc -> higher priority TX hw queue
    as defined in [Ref1]. This custom mapping complicates common taprio
    setup across NICs.

2.  Non-standard frame preemption mapping for taprio in igc

Without the private flag:
- Compared to other network controllers, taprio on igc must flip the
  expected fp sequence, since express traffic is expected to map to the
  highest priority queue and preemptible traffic to lower ones
- On igc, frame preemption configuration for mqprio differs from taprio,
  since mqprio already uses TX arbitration

The following examples compare taprio frame preemption configuration on
igc and other network controllers:
a)  On other NICs (TX hw queue 3 is highest priority):
    taprio num_tc 4 map ..... \
    queues 1@0 1@1 1@2 1@3 \
    fp P P P E

    Mapping translates to:
    tc0, tc1, tc2 -> preemptible -> queue 0, 1, 2
    tc3           -> express     -> queue 3

    This is the normal mapping that respects the standard convention:
    higher tc -> express traffic -> higher priority TX hw queue
    lower tc  -> preemptible traffic -> lower priority TX hw queue

b)  On igc (TX hw queue 0 is highest priority by default):
    taprio num_tc 4 map ...... \
    queues 1@0 1@1 1@2 1@3 \
    fp E P P P

    Mapping translates to:
    tc0           -> express     -> queue 0
    tc1, tc2, tc3 -> preemptible -> queue 1, 2, 3

    This inversion respects the mapping of:
      express traffic -> higher priority TX hw queue
    but breaks the expected ordering:
      higher tc -> express traffic
    as defined in [Ref1] where higher tc indicates higher priority. In
    this case, the lower tc0 is assigned to express traffic. This custom
    mapping further complicates common preemption setup across NICs.

Tests were performed on taprio with the following combinations, where
two apps send traffic simultaneously on different queues:

  Private Flag   Traffic Sent By           Traffic Sent By
  ----------------------------------------------------------------
  enabled        iperf3 (queue 3)          iperf3 (queue 0)
  disabled       iperf3 (queue 0)          iperf3 (queue 3)
  enabled        iperf3 (queue 3)          real-time app (queue 0)
  disabled       iperf3 (queue 0)          real-time app (queue 3)
  enabled        real-time app (queue 3)   iperf3 (queue 0)
  disabled       real-time app (queue 0)   iperf3 (queue 3)
  enabled        real-time app (queue 3)   real-time app (queue 0)
  disabled       real-time app (queue 0)   real-time app (queue 3)

Private flag is controlled with:
 ethtool --set-priv-flags enp1s0 reverse-tsn-txq-prio <on|off>

[Ref1]
IEEE 802.1Q clause 8.6.8 Transmission selection:
"For a given Port and traffic class, frames are selected from the
corresponding queue for transmission if and only if:
...
b) For each queue corresponding to a numerically higher value of traffic
class supported by the Port, the operation of the transmission selection
algorithm supported by that queue determines that there is no frame
available for transmission."

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 12 ++++++++++--
 drivers/net/ethernet/intel/igc/igc_main.c    |  3 ++-
 drivers/net/ethernet/intel/igc/igc_tsn.c     |  3 ++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index daab06fc3f80..023ff8a5b285 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -395,6 +395,7 @@ extern char igc_driver_name[];
 #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
 #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
 #define IGC_FLAG_TSN_PREEMPT_ENABLED	BIT(19)
+#define IGC_FLAG_TSN_REVERSE_TXQ_PRIO	BIT(20)
 
 #define IGC_FLAG_TSN_ANY_ENABLED				\
 	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3fc1eded9605..054b7390cb4b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -122,9 +122,11 @@ static const char igc_gstrings_test[][ETH_GSTRING_LEN] = {
 #define IGC_STATS_LEN \
 	(IGC_GLOBAL_STATS_LEN + IGC_NETDEV_STATS_LEN + IGC_QUEUE_STATS_LEN)
 
+#define IGC_PRIV_FLAGS_LEGACY_RX		BIT(0)
+#define IGC_PRIV_FLAGS_REVERSE_TSN_TXQ_PRIO	BIT(1)
 static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
-#define IGC_PRIV_FLAGS_LEGACY_RX	BIT(0)
 	"legacy-rx",
+	"reverse-tsn-txq-prio",
 };
 
 #define IGC_PRIV_FLAGS_STR_LEN ARRAY_SIZE(igc_priv_flags_strings)
@@ -1600,6 +1602,9 @@ static u32 igc_ethtool_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags & IGC_FLAG_RX_LEGACY)
 		priv_flags |= IGC_PRIV_FLAGS_LEGACY_RX;
 
+	if (adapter->flags & IGC_FLAG_TSN_REVERSE_TXQ_PRIO)
+		priv_flags |= IGC_PRIV_FLAGS_REVERSE_TSN_TXQ_PRIO;
+
 	return priv_flags;
 }
 
@@ -1608,10 +1613,13 @@ static int igc_ethtool_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	unsigned int flags = adapter->flags;
 
-	flags &= ~IGC_FLAG_RX_LEGACY;
+	flags &= ~(IGC_FLAG_RX_LEGACY | IGC_FLAG_TSN_REVERSE_TXQ_PRIO);
 	if (priv_flags & IGC_PRIV_FLAGS_LEGACY_RX)
 		flags |= IGC_FLAG_RX_LEGACY;
 
+	if (priv_flags & IGC_PRIV_FLAGS_REVERSE_TSN_TXQ_PRIO)
+		flags |= IGC_FLAG_TSN_REVERSE_TXQ_PRIO;
+
 	if (flags != adapter->flags) {
 		adapter->flags = flags;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1322a2db6dba..82d53fad6b6a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6698,7 +6698,8 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
-		caps->broken_mqprio = true;
+		if (!(adapter->flags & IGC_FLAG_TSN_REVERSE_TXQ_PRIO))
+			caps->broken_mqprio = true;
 
 		if (hw->mac.type == igc_i225) {
 			caps->supports_queue_max_sdu = true;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 78a4a9cf5f96..43151ab4c1b7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -398,7 +398,8 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
-	if (adapter->strict_priority_enable)
+	if (adapter->strict_priority_enable ||
+	    adapter->flags & IGC_FLAG_TSN_REVERSE_TXQ_PRIO)
 		igc_tsn_tx_arb(adapter, true);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-- 
2.47.1


