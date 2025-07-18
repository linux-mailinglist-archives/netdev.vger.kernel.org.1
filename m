Return-Path: <netdev+bounces-208230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91168B0AA68
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463BE5C1046
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B52E9ECE;
	Fri, 18 Jul 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0jx1x9V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDF2E974D
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864694; cv=none; b=JMh+2HgrlYQwOE45JCGfI/JJoHqN0lWZnvCj+sVN0l5B4yCSHpJw+NZTEeXotkeOnNqy3pUdw9ojEbr+l5i3s3OH/NMYxy9Q8O2X+lO5CTMJCzSrnvqZFEeicgMpFf67yeGSjCW65gRlFOvo/zJn6y2VCMSe4GmWbWXpbvjx7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864694; c=relaxed/simple;
	bh=nHwf6ysJmgVxMDxQ1Exgqrgixwx5U+M0MosMJp0y4E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAo5ej3B2DEgAjmYslRetBOXAFYjEzF+NDai2irP1K9A1StKs914Xbq9hHFrkqa2aU4Fjax/+8/APtn72njC/35k6660hPJwoCp0ZC08WJNQo18qlC01PLNDuRiAnw4Ew3pGOtLKy8/Oo/W9U+/b0pbnGXW8nJHoD2E/5Pyy1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0jx1x9V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864693; x=1784400693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHwf6ysJmgVxMDxQ1Exgqrgixwx5U+M0MosMJp0y4E4=;
  b=b0jx1x9VJa1OJRXq24Lkkg0yFDGt/5V35i7fgjiA6jUg9kCpSDjKsmXf
   eaCkDDFaaYUdyS6jjmWKE0JClZhvlJZQSOzuRDE+ohS5mVnB/T1CnnzJK
   Ng4nc6TvUgkl78UHCZRm1eZaNgfKSvHKfwtP6VoKsjj3Wpwq/rR9W1fiK
   XX+pEsFWqeBrBjrKGQZN4qsNPDc3jH7b+LPBmDQozSIhlBdnZvvPi2Fpx
   m2FTiQxrYIn2uJQ4Lg0ZHaIde2XinnZ/7/Y2Fhox0ajQP0R5sf7yjMuN5
   x/2Q5Gvylzn7tmTNyxixxIhdYyVsGiF4vcSeiBfIXfs6Nf1mXW9zTmecb
   g==;
X-CSE-ConnectionGUID: G4+vBH2qTreiNoecxCTozg==
X-CSE-MsgGUID: 4B0r4/6vRtKD4vqa7q1eCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320627"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320627"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:25 -0700
X-CSE-ConnectionGUID: ZlM9O30ySjKjVQmQP0IvfA==
X-CSE-MsgGUID: 96dHxGB3Qv2jaqHbVJ3zDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506911"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Song Yoong Siang <yoong.siang.song@intel.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	hector.blanco.alcaine@intel.com,
	vinicius.gomes@intel.com,
	kevin.tian@intel.com,
	kurt@linutronix.de,
	richardcochran@gmail.com,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	daniel@iogearbox.net,
	corbet@lwn.net,
	brett.creeley@amd.com,
	srasheed@marvell.com,
	ast@kernel.org,
	bcreeley@amd.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 11/13] igc: Add wildcard rule support to ethtool NFC using Default Queue
Date: Fri, 18 Jul 2025 11:51:12 -0700
Message-ID: <20250718185118.2042772-12-anthony.l.nguyen@intel.com>
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

From: Song Yoong Siang <yoong.siang.song@intel.com>

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

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Co-developed-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 11 +++++++---
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    | 22 ++++++++++++++++++++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index fdec66caef4d..266bfcf2a28f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -631,6 +631,7 @@ enum igc_filter_match_flags {
 	IGC_FILTER_FLAG_DST_MAC_ADDR =	BIT(3),
 	IGC_FILTER_FLAG_USER_DATA =	BIT(4),
 	IGC_FILTER_FLAG_VLAN_ETYPE =	BIT(5),
+	IGC_FILTER_FLAG_DEFAULT_QUEUE = BIT(6),
 };
 
 struct igc_nfc_filter {
@@ -658,10 +659,14 @@ struct igc_nfc_rule {
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
index d80254f2a278..498ba1522ca4 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -391,6 +391,7 @@
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
 #define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
 #define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
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
index 32ea4fdd3e2b..458e5eaa92e5 100644
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
2.47.1


