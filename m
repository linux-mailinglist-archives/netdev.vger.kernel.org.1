Return-Path: <netdev+bounces-199543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC7AE0AA3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF123A5CEF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E700230D0A;
	Thu, 19 Jun 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+VRZvM1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C418024;
	Thu, 19 Jun 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347513; cv=none; b=cQ5L5xXytI8N1I2KgxAV2s/eCCmbzn6UhV6kTANY4Z7MmSKP+ZLnt9BOjll7lIXsr/SUwXeQBhcYOK3tDJfAdAugu+PWfPSJTnaTKFSOsWb8cGmOsht7nBM3i00qwXnjC7/a8Co6KXC48HrI4NFhRL75bgdSHXI96dXoLx2ky2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347513; c=relaxed/simple;
	bh=cemE3KPr09GBuAk4yA33g6zjJYuMfVRlqLTDeiEf3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AK6C6WqTBk2YG93FRHN8IUsXlRretSbtWdwcwaxmzV4c0RUPGUqedyPw8DGlWJOwjUNwYICKYT4hWbABV2roP3EzB2RinlHh8vKWjo/r1+Y99jb7bUGTMQsWzydUoOaBd+Yc4WUmlXD5Yk9NgXcqBgoE20GEt0iDGAdCOXhfPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+VRZvM1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750347508; x=1781883508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cemE3KPr09GBuAk4yA33g6zjJYuMfVRlqLTDeiEf3kU=;
  b=c+VRZvM1Us0ttWGzI9dafuy+wJvwFGaeu3BQiiVRdv1/g66VSJkMEFvR
   paofVJkB2c7yf+yolfwcgRAaIk6RLzGo1PsSzzpTDJcCy4z4NbRkMM85l
   FZZMDaD5Vhz30HsQX/DAJhKL82SXby+00+6OsCZdmsf63qFlIKAqSIAxV
   uSa+Q/j9WQY/ilbDsfm5kAR9eJqNAzLnNe66IFQEhFubmZe7WujYSQ3Sl
   6VkBvCJekGNyX45asu19gLpOw3jLlxTBwDeKn75I1gXe13W6o8AFjSt8P
   0uqRJiP3mJEArXi7GAyOSMdi+KYdMqpnJqtSiKyUN4I1SzRTZFvC/aY0f
   Q==;
X-CSE-ConnectionGUID: 6J0Q959QQP+eQQdvK5RGfQ==
X-CSE-MsgGUID: PDCaEvJCQOmUGzcjHs2VIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56425674"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="56425674"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 08:38:17 -0700
X-CSE-ConnectionGUID: xl3ttfQLSL6jMsqtEydclw==
X-CSE-MsgGUID: 9w88Gj9+Qi+FwjFKM2De2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="150115355"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa010.jf.intel.com with ESMTP; 19 Jun 2025 08:38:11 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next,v2 1/1] igc: Add wildcard rule support to ethtool NFC using Default Queue
Date: Thu, 19 Jun 2025 23:37:38 +0800
Message-Id: <20250619153738.2788568-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for a lowest priority wildcard (catch-all) rule in
ethtool's Network Flow Classification (NFC) for the igc driver. The
wildcard rule directs all unmatched network traffic, including traffic not
captured by Receive Side Scaling (RSS), to a specified queue. This
functionality utilizes the Default Queue feature available in I225/I226
hardware.

The implementation has been validated on Intel ADL-S systems with two
back-to-back connected I226 network interfaces.

Testing Procedure:
1. On the Device Under Test (DUT), verify the initial statistic:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 0
        rx_queue_1_packets: 0
        rx_queue_2_packets: 0
        rx_queue_3_packets: 0

2. From the Link Partner, send 10 ARP packets:
   $ arping -c 10 -I enp170s0 169.254.1.2

3. On the DUT, verify the packet reception on Queue 0:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 10
        rx_queue_1_packets: 0
        rx_queue_2_packets: 0
        rx_queue_3_packets: 0

4. On the DUT, add a wildcard rule to route all packets to Queue 3:
   $ sudo ethtool -N enp1s0 flow-type ether queue 3

5. From the Link Partner, send another 10 ARP packets:
   $ arping -c 10 -I enp170s0 169.254.1.2

6. Now, packets are routed to Queue 3 by the wildcard (Default Queue) rule:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 10
        rx_queue_1_packets: 0
        rx_queue_2_packets: 0
        rx_queue_3_packets: 10

7. On the DUT, add a EtherType rule to route ARP packet to Queue 1:
   $ sudo ethtool -N enp1s0 flow-type ether proto 0x0806 queue 1

8. From the Link Partner, send another 10 ARP packets:
   $ arping -c 10 -I enp170s0 169.254.1.2

9. Now, packets are routed to Queue 1 by the EtherType rule because it is
   higher priority than the wildcard (Default Queue) rule:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 10
        rx_queue_1_packets: 10
        rx_queue_2_packets: 0
        rx_queue_3_packets: 10

10. On the DUT, delete all the NFC rules:
    $ sudo ethtool -N enp1s0 delete 63
    $ sudo ethtool -N enp1s0 delete 64

11. From the Link Partner, send another 10 ARP packets:
    $ arping -c 10 -I enp170s0 169.254.1.2

12. Now, packets are routed to Queue 0 because the value of Default Queue
    is reset back to 0:
    $ ethtool -S enp1s0 | grep rx_q.*packets
         rx_queue_0_packets: 20
         rx_queue_1_packets: 10
         rx_queue_2_packets: 0
         rx_queue_3_packets: 10

Co-developed-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
V2:
  - use Ethtool wildcard rule instead of extra uAPI (Jakub Kicinski & Jacob Keller)
  - combine MRQC register definitions into a single location (Kurt Kanzenbach)
  - use FIELD_PREP (Kurt Kanzenbach)
  - use RCT rule (Wojciech Drewek)
  - no need brackets for single line code (Wojciech Drewek)
  - use imperative mood in commit message (Marcin Szycik)
  - ensure igc_ prefix in function name (Marcin Szycik)

V1: https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20240730012212.775814-1-yoong.siang.song@intel.com/
---
 drivers/net/ethernet/intel/igc/igc.h         | 15 ++++++-------
 drivers/net/ethernet/intel/igc/igc_defines.h |  4 ++++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    | 22 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 1525ae25fd3e..c580ecc954be 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -406,10 +406,6 @@ extern char igc_driver_name[];
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
 
-#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
-#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
-
 /* RX-desc Write-Back format RSS Type's */
 enum igc_rss_type_num {
 	IGC_RSS_TYPE_NO_HASH		= 0,
@@ -635,6 +631,7 @@ enum igc_filter_match_flags {
 	IGC_FILTER_FLAG_DST_MAC_ADDR =	BIT(3),
 	IGC_FILTER_FLAG_USER_DATA =	BIT(4),
 	IGC_FILTER_FLAG_VLAN_ETYPE =	BIT(5),
+	IGC_FILTER_FLAG_DEFAULT_QUEUE = BIT(6),
 };
 
 struct igc_nfc_filter {
@@ -662,10 +659,14 @@ struct igc_nfc_rule {
 	bool flex;
 };
 
-/* IGC supports a total of 32 NFC rules: 16 MAC address based, 8 VLAN priority
- * based, 8 ethertype based and 32 Flex filter based rules.
+/* IGC supports a total of 65 NFC rules, listed below in order of priority:
+ *  - 16 MAC address based filtering rules (highest priority)
+ *  - 8 ethertype based filtering rules
+ *  - 32 Flex filter based filtering rules
+ *  - 8 VLAN priority based filtering rules
+ *  - 1 default queue rule (lowest priority)
  */
-#define IGC_MAX_RXNFC_RULES		64
+#define IGC_MAX_RXNFC_RULES		65
 
 struct igc_flex_filter {
 	u8 index;
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 86b346687196..498ba1522ca4 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -383,11 +383,15 @@
 #define IGC_RXDEXT_STATERR_IPE		0x40000000
 #define IGC_RXDEXT_STATERR_RXE		0x80000000
 
+#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
 #define IGC_MRQC_RSS_FIELD_IPV4_TCP	0x00010000
 #define IGC_MRQC_RSS_FIELD_IPV4		0x00020000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP_EX	0x00040000
 #define IGC_MRQC_RSS_FIELD_IPV6		0x00100000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
+#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
+#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
+#define IGC_MRQC_DEFAULT_QUEUE_MASK	GENMASK(5, 3)
 
 /* Header split receive */
 #define IGC_RFCTL_IPV6_EX_DIS	0x00010000
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index a7f397b58cd6..ecb35b693ce5 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1283,6 +1283,24 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 		rule->flex = true;
 	else
 		rule->flex = false;
+
+	/* The wildcard rule is only applied if:
+	 *  a) None of the other filtering rules match (match_flags is zero)
+	 *  b) The flow type is ETHER_FLOW only (no additional fields set)
+	 *  c) Mask for Source MAC address is not specified (all zeros)
+	 *  d) Mask for Destination MAC address is not specified (all zeros)
+	 *  e) Mask for L2 EtherType is not specified (zero)
+	 *
+	 * If all these conditions are met, the rule is treated as a wildcard
+	 * rule. Default queue feature will be used, so that all packets that do
+	 * not match any other rule will be routed to the default queue.
+	 */
+	if (!rule->filter.match_flags &&
+	    fsp->flow_type == ETHER_FLOW &&
+	    is_zero_ether_addr(fsp->m_u.ether_spec.h_source) &&
+	    is_zero_ether_addr(fsp->m_u.ether_spec.h_dest) &&
+	    !fsp->m_u.ether_spec.h_proto)
+		rule->filter.match_flags = IGC_FILTER_FLAG_DEFAULT_QUEUE;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e12915b42a9..87311ea47018 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3874,6 +3874,22 @@ static void igc_del_flex_filter(struct igc_adapter *adapter,
 	wr32(IGC_WUFC, wufc);
 }
 
+static void igc_set_default_queue_filter(struct igc_adapter *adapter, u32 queue)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 mrqc = rd32(IGC_MRQC);
+
+	mrqc &= ~IGC_MRQC_DEFAULT_QUEUE_MASK;
+	mrqc |= FIELD_PREP(IGC_MRQC_DEFAULT_QUEUE_MASK, queue);
+	wr32(IGC_MRQC, mrqc);
+}
+
+static void igc_reset_default_queue_filter(struct igc_adapter *adapter)
+{
+	/* Reset the default queue to its default value which is Queue 0 */
+	igc_set_default_queue_filter(adapter, 0);
+}
+
 static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 			       struct igc_nfc_rule *rule)
 {
@@ -3912,6 +3928,9 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 			return err;
 	}
 
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_DEFAULT_QUEUE)
+		igc_set_default_queue_filter(adapter, rule->action);
+
 	return 0;
 }
 
@@ -3939,6 +3958,9 @@ static void igc_disable_nfc_rule(struct igc_adapter *adapter,
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
 		igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST,
 				   rule->filter.dst_addr);
+
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_DEFAULT_QUEUE)
+		igc_reset_default_queue_filter(adapter);
 }
 
 /**
-- 
2.34.1


