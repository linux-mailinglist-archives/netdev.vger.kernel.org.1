Return-Path: <netdev+bounces-30511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FC78799C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541221C20F3E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE64A927;
	Thu, 24 Aug 2023 20:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E9A925
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 20:51:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C781989
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692910290; x=1724446290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYMSdV8kIfutV2sCMvV1fsnorMYgysjdhqchviM5pEk=;
  b=jTB0lz5+y1jgdhAR1KNE4p1yHkHGYyde6+0Bs+ZtCpG6MYQd/25ADsvZ
   JfAqLDsqeCpyqHtxoykrkxE7upS35kThjy+F+jra4FbGtF426iOfCBhJe
   S9jP7iIYZxZNcL+vKAYPnp7hF2Rac/9gT4m3jtNUvPdwJ85bpoeBPNmjZ
   gdsKDV2EHWWZ1VgJJqJOR+jNlq+Pujgbv+6qRlwk1tZrHxxK1qenKSIZ6
   gczws0Zuoe6TLtwLmq0Ocy79OgGs3E9hgNZkPWZYv+CEUX9NfFZ83jB21
   yRVI/NIr6Eo6zZZ/sKp6I7ygLMKGaq87mq1CxR2SYsR8/Ev7yqt3amsQ8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364746208"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364746208"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 13:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827312265"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827312265"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 13:51:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 1/3] igc: Add support for multiple in-flight TX timestamps
Date: Thu, 24 Aug 2023 13:44:16 -0700
Message-Id: <20230824204418.1551093-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
References: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Add support for using the four sets of timestamping registers that
i225/i226 have available for TX.

In some workloads, where multiple applications request hardware
transmission timestamps, it was possible that some of those requests
were denied because the only in use register was already occupied.

This is also in preparation to future support for hardware
timestamping with multiple PTP domains. With multiple domains chances
of multiple TX timestamps being requested at the same time increase.

Before:
$ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o 37
               |          responses            |     TX timestamp offset (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
1000       100   0.00%   0.00%   0.00% 100.00%       +1     +41     +73     13
1500       150   0.00%   0.00%   0.00% 100.00%       +9     +49     +87     15
2250       225   0.00%   0.00%   0.00% 100.00%       +9     +42     +79     13
3375       337   0.00%   0.00%   0.00% 100.00%      +11     +46     +81     13
5062       506   0.00%   0.00%   0.00% 100.00%       +7     +44     +80     13
7593       759   0.00%   0.00%   0.00% 100.00%       +9     +44     +79     12
11389     1138   0.00%   0.00%   0.00% 100.00%      +14     +51     +87     13
17083     1708   0.00%   0.00%   0.00% 100.00%       +1     +41     +80     14
25624     2562   0.00%   0.00%   0.00% 100.00%      +11     +50   +5107     51
38436     3843   0.00%   0.00%   0.00% 100.00%       -2     +36   +7843     38
57654     5765   0.00%   0.00%   0.00% 100.00%       +4     +42  +10503     69
86481     8648   0.00%   0.00%   0.00% 100.00%      +11     +54   +5492     65
129721   12972   0.00%   0.00%   0.00% 100.00%      +31   +2680   +6942   2606
194581   16384  16.79%   0.00%   0.87%  82.34%      +73   +4444  +15879   3116
291871   16384  35.05%   0.00%   1.53%  63.42%     +188   +5381  +17019   3035
437806   16384  54.95%   0.00%   2.55%  42.50%     +233   +6302  +13885   2846

After:
$ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o 37
               |          responses            |     TX timestamp offset (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
1000       100   0.00%   0.00%   0.00% 100.00%      -20     +12     +43     13
1500       150   0.00%   0.00%   0.00% 100.00%      -23     +18     +57     14
2250       225   0.00%   0.00%   0.00% 100.00%       -2     +33     +67     13
3375       337   0.00%   0.00%   0.00% 100.00%       +1     +38     +76     13
5062       506   0.00%   0.00%   0.00% 100.00%       +9     +52     +93     14
7593       759   0.00%   0.00%   0.00% 100.00%      +11     +47     +82     13
11389     1138   0.00%   0.00%   0.00% 100.00%       -9     +27     +74     13
17083     1708   0.00%   0.00%   0.00% 100.00%      -13     +25     +66     14
25624     2562   0.00%   0.00%   0.00% 100.00%       -8     +28     +65     13
38436     3843   0.00%   0.00%   0.00% 100.00%      -13     +28     +69     13
57654     5765   0.00%   0.00%   0.00% 100.00%      -11     +32     +71     14
86481     8648   0.00%   0.00%   0.00% 100.00%       +2     +44     +83     14
129721   12972  15.36%   0.00%   0.35%  84.29%       -2   +2248  +22907   4252
194581   16384  42.98%   0.00%   1.98%  55.04%       -4   +5278  +65039   5856
291871   16384  54.33%   0.00%   2.21%  43.46%       -3   +6306  +22608   5665

We can see that with 4 registers, as expected, we are able to handle a
increasing number of requests more consistently, but as soon as all
registers are in use, the decrease in quality of service happens in a
sharp step.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  18 +-
 drivers/net/ethernet/intel/igc/igc_base.h    |   3 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   7 +
 drivers/net/ethernet/intel/igc/igc_main.c    |  41 ++++-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 174 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_regs.h    |  12 ++
 6 files changed, 192 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 1c6ab340c020..8ebe6999a528 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -38,6 +38,8 @@ void igc_ethtool_set_ops(struct net_device *);
 
 #define MAX_FLEX_FILTER			32
 
+#define IGC_MAX_TX_TSTAMP_REGS		4
+
 enum igc_mac_filter_type {
 	IGC_MAC_FILTER_TYPE_DST = 0,
 	IGC_MAC_FILTER_TYPE_SRC
@@ -70,6 +72,15 @@ struct igc_rx_packet_stats {
 	u64 other_packets;
 };
 
+struct igc_tx_timestamp_request {
+	struct sk_buff *skb;   /* reference to the packet being timestamped */
+	unsigned long start;   /* when the tstamp request started (jiffies) */
+	u32 mask;              /* _TSYNCTXCTL_TXTT_{X} bit for this request */
+	u32 regl;              /* which TXSTMPL_{X} register should be used */
+	u32 regh;              /* which TXSTMPH_{X} register should be used */
+	u32 flags;             /* flags that should be added to the tx_buffer */
+};
+
 struct igc_ring_container {
 	struct igc_ring *ring;          /* pointer to linked list of rings */
 	unsigned int total_bytes;       /* total bytes processed this int */
@@ -245,9 +256,8 @@ struct igc_adapter {
 	 * ptp_tx_lock.
 	 */
 	spinlock_t ptp_tx_lock;
-	struct sk_buff *ptp_tx_skb;
+	struct igc_tx_timestamp_request tx_tstamp[IGC_MAX_TX_TSTAMP_REGS];
 	struct hwtstamp_config tstamp_config;
-	unsigned long ptp_tx_start;
 	unsigned int ptp_flags;
 	/* System time value lock */
 	spinlock_t tmreg_lock;
@@ -455,6 +465,10 @@ enum igc_tx_flags {
 	/* olinfo flags */
 	IGC_TX_FLAGS_IPV4	= 0x10,
 	IGC_TX_FLAGS_CSUM	= 0x20,
+
+	IGC_TX_FLAGS_TSTAMP_1	= 0x100,
+	IGC_TX_FLAGS_TSTAMP_2	= 0x200,
+	IGC_TX_FLAGS_TSTAMP_3	= 0x400,
 };
 
 enum igc_boards {
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 9f3827eda157..f7d6491d4c60 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -34,6 +34,9 @@ struct igc_adv_tx_context_desc {
 
 /* Adv Transmit Descriptor Config Masks */
 #define IGC_ADVTXD_MAC_TSTAMP	0x00080000 /* IEEE1588 Timestamp packet */
+#define IGC_ADVTXD_TSTAMP_REG_1	0x00010000 /* Select register 1 for timestamp */
+#define IGC_ADVTXD_TSTAMP_REG_2	0x00020000 /* Select register 2 for timestamp */
+#define IGC_ADVTXD_TSTAMP_REG_3	0x00030000 /* Select register 3 for timestamp */
 #define IGC_ADVTXD_DTYP_CTXT	0x00200000 /* Advanced Context Descriptor */
 #define IGC_ADVTXD_DTYP_DATA	0x00300000 /* Advanced Data Descriptor */
 #define IGC_ADVTXD_DCMD_EOP	0x01000000 /* End of Packet */
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 2f780cc90883..700827bdd626 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -454,6 +454,9 @@
 
 /* Time Sync Transmit Control bit definitions */
 #define IGC_TSYNCTXCTL_TXTT_0			0x00000001  /* Tx timestamp reg 0 valid */
+#define IGC_TSYNCTXCTL_TXTT_1			0x00000002  /* Tx timestamp reg 1 valid */
+#define IGC_TSYNCTXCTL_TXTT_2			0x00000004  /* Tx timestamp reg 2 valid */
+#define IGC_TSYNCTXCTL_TXTT_3			0x00000008  /* Tx timestamp reg 3 valid */
 #define IGC_TSYNCTXCTL_ENABLED			0x00000010  /* enable Tx timestamping */
 #define IGC_TSYNCTXCTL_MAX_ALLOWED_DLY_MASK	0x0000F000  /* max delay */
 #define IGC_TSYNCTXCTL_SYNC_COMP_ERR		0x20000000  /* sync err */
@@ -461,6 +464,10 @@
 #define IGC_TSYNCTXCTL_START_SYNC		0x80000000  /* initiate sync */
 #define IGC_TSYNCTXCTL_TXSYNSIG			0x00000020  /* Sample TX tstamp in PHY sop */
 
+#define IGC_TSYNCTXCTL_TXTT_ANY ( \
+		IGC_TSYNCTXCTL_TXTT_0 | IGC_TSYNCTXCTL_TXTT_1 | \
+		IGC_TSYNCTXCTL_TXTT_2 | IGC_TSYNCTXCTL_TXTT_3)
+
 /* Timer selection bits */
 #define IGC_AUX_IO_TIMER_SEL_SYSTIM0	(0u << 30) /* Select SYSTIM0 for auxiliary time stamp */
 #define IGC_AUX_IO_TIMER_SEL_SYSTIM1	(1u << 30) /* Select SYSTIM1 for auxiliary time stamp */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e7701866d8b4..293b45717683 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1271,10 +1271,21 @@ static u32 igc_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
 	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSO,
 				 (IGC_ADVTXD_DCMD_TSE));
 
-	/* set timestamp bit if present */
+	/* set timestamp bit if present, will select the register set
+	 * based on the _TSTAMP(_X) bit.
+	 */
 	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP,
 				 (IGC_ADVTXD_MAC_TSTAMP));
 
+	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP_1,
+				 (IGC_ADVTXD_TSTAMP_REG_1));
+
+	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP_2,
+				 (IGC_ADVTXD_TSTAMP_REG_2));
+
+	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP_3,
+				 (IGC_ADVTXD_TSTAMP_REG_3));
+
 	/* insert frame checksum */
 	cmd_type ^= IGC_SET_FLAG(skb->no_fcs, 1, IGC_ADVTXD_DCMD_IFCS);
 
@@ -1533,6 +1544,26 @@ static int igc_tso(struct igc_ring *tx_ring,
 	return 1;
 }
 
+static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *skb, u32 *flags)
+{
+	int i;
+
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		if (tstamp->skb)
+			continue;
+
+		tstamp->skb = skb_get(skb);
+		tstamp->start = jiffies;
+		*flags = tstamp->flags;
+
+		return true;
+	}
+
+	return false;
+}
+
 static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 				       struct igc_ring *tx_ring)
 {
@@ -1614,14 +1645,12 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		 * timestamping request.
 		 */
 		unsigned long flags;
+		u32 tstamp_flags;
 
 		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
-		if (!adapter->ptp_tx_skb) {
+		if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			tx_flags |= IGC_TX_FLAGS_TSTAMP;
-
-			adapter->ptp_tx_skb = skb_get(skb);
-			adapter->ptp_tx_start = jiffies;
+			tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index f0b979a70655..928f38792203 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -558,11 +558,16 @@ static void igc_ptp_enable_rx_timestamp(struct igc_adapter *adapter)
 static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
 {
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
-	adapter->ptp_tx_skb = NULL;
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		dev_kfree_skb_any(tstamp->skb);
+		tstamp->skb = NULL;
+	}
 
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
@@ -659,61 +664,106 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 }
 
 /* Requires adapter->ptp_tx_lock held by caller. */
-static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
+static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
+			       struct igc_tx_timestamp_request *tstamp)
 {
-	struct igc_hw *hw = &adapter->hw;
-
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
-	adapter->ptp_tx_skb = NULL;
+	dev_kfree_skb_any(tstamp->skb);
+	tstamp->skb = NULL;
 	adapter->tx_hwtstamp_timeouts++;
-	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
-	rd32(IGC_TXSTMPH);
+
 	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
 }
 
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
+	struct igc_tx_timestamp_request *tstamp;
+	struct igc_hw *hw = &adapter->hw;
 	unsigned long flags;
+	bool found = false;
+	int i;
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
-	if (!adapter->ptp_tx_skb)
-		goto unlock;
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+		tstamp = &adapter->tx_tstamp[i];
+
+		if (!tstamp->skb)
+			continue;
 
-	if (time_is_after_jiffies(adapter->ptp_tx_start + IGC_PTP_TX_TIMEOUT))
-		goto unlock;
+		if (time_is_after_jiffies(tstamp->start + IGC_PTP_TX_TIMEOUT))
+			continue;
 
-	igc_ptp_tx_timeout(adapter);
+		igc_ptp_tx_timeout(adapter, tstamp);
+		found = true;
+	}
+
+	if (found) {
+		/* Reading the high register of the first set of timestamp registers
+		 * clears all the equivalent bits in the TSYNCTXCTL register.
+		 */
+		rd32(IGC_TXSTMPH_0);
+	}
 
-unlock:
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
+static void igc_ptp_tx_reg_to_stamp(struct igc_adapter *adapter,
+				    struct igc_tx_timestamp_request *tstamp, u64 regval)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	struct sk_buff *skb;
+	int adjust = 0;
+
+	skb = tstamp->skb;
+	if (!skb)
+		return;
+
+	if (igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval))
+		return;
+
+	switch (adapter->link_speed) {
+	case SPEED_10:
+		adjust = IGC_I225_TX_LATENCY_10;
+		break;
+	case SPEED_100:
+		adjust = IGC_I225_TX_LATENCY_100;
+		break;
+	case SPEED_1000:
+		adjust = IGC_I225_TX_LATENCY_1000;
+		break;
+	case SPEED_2500:
+		adjust = IGC_I225_TX_LATENCY_2500;
+		break;
+	}
+
+	shhwtstamps.hwtstamp =
+		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
+
+	tstamp->skb = NULL;
+
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
+}
+
 /**
  * igc_ptp_tx_hwtstamp - utility function which checks for TX time stamp
  * @adapter: Board private structure
  *
- * If we were asked to do hardware stamping and such a time stamp is
- * available, then it must have been for this skb here because we only
- * allow only one such packet into the queue.
+ * Check against the ready mask for which of the timestamp register
+ * sets are ready to be retrieved, then retrieve that and notify the
+ * rest of the stack.
  *
  * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
-	struct sk_buff *skb = adapter->ptp_tx_skb;
-	struct skb_shared_hwtstamps shhwtstamps;
 	struct igc_hw *hw = &adapter->hw;
-	u32 tsynctxctl;
-	int adjust = 0;
 	u64 regval;
+	u32 mask;
+	int i;
 
-	if (WARN_ON_ONCE(!skb))
-		return;
-
-	tsynctxctl = rd32(IGC_TSYNCTXCTL);
-	tsynctxctl &= IGC_TSYNCTXCTL_TXTT_0;
-	if (tsynctxctl) {
+	mask = rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
+	if (mask & IGC_TSYNCTXCTL_TXTT_0) {
 		regval = rd32(IGC_TXSTMPL);
 		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
 	} else {
@@ -742,37 +792,30 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 		txstmpl_new = rd32(IGC_TXSTMPL);
 
 		if (txstmpl_old == txstmpl_new)
-			return;
+			goto done;
 
 		regval = txstmpl_new;
 		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
 	}
-	if (igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval))
-		return;
 
-	switch (adapter->link_speed) {
-	case SPEED_10:
-		adjust = IGC_I225_TX_LATENCY_10;
-		break;
-	case SPEED_100:
-		adjust = IGC_I225_TX_LATENCY_100;
-		break;
-	case SPEED_1000:
-		adjust = IGC_I225_TX_LATENCY_1000;
-		break;
-	case SPEED_2500:
-		adjust = IGC_I225_TX_LATENCY_2500;
-		break;
-	}
+	igc_ptp_tx_reg_to_stamp(adapter, &adapter->tx_tstamp[0], regval);
 
-	shhwtstamps.hwtstamp =
-		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
+done:
+	/* Now that the problematic first register was handled, we can
+	 * use retrieve the timestamps from the other registers
+	 * (starting from '1') with less complications.
+	 */
+	for (i = 1; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
 
-	adapter->ptp_tx_skb = NULL;
+		if (!(tstamp->mask & mask))
+			continue;
 
-	/* Notify the stack and free the skb after we've unlocked */
-	skb_tstamp_tx(skb, &shhwtstamps);
-	dev_kfree_skb_any(skb);
+		regval = rd32(tstamp->regl);
+		regval |= (u64)rd32(tstamp->regh) << 32;
+
+		igc_ptp_tx_reg_to_stamp(adapter, tstamp, regval);
+	}
 }
 
 /**
@@ -788,12 +831,8 @@ void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter)
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
-	if (!adapter->ptp_tx_skb)
-		goto unlock;
-
 	igc_ptp_tx_hwtstamp(adapter);
 
-unlock:
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
@@ -1006,9 +1045,34 @@ static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 void igc_ptp_init(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct igc_tx_timestamp_request *tstamp;
 	struct igc_hw *hw = &adapter->hw;
 	int i;
 
+	tstamp = &adapter->tx_tstamp[0];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_0;
+	tstamp->regl = IGC_TXSTMPL_0;
+	tstamp->regh = IGC_TXSTMPH_0;
+	tstamp->flags = 0;
+
+	tstamp = &adapter->tx_tstamp[1];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_1;
+	tstamp->regl = IGC_TXSTMPL_1;
+	tstamp->regh = IGC_TXSTMPH_1;
+	tstamp->flags = IGC_TX_FLAGS_TSTAMP_1;
+
+	tstamp = &adapter->tx_tstamp[2];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_2;
+	tstamp->regl = IGC_TXSTMPL_2;
+	tstamp->regh = IGC_TXSTMPH_2;
+	tstamp->flags = IGC_TX_FLAGS_TSTAMP_2;
+
+	tstamp = &adapter->tx_tstamp[3];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_3;
+	tstamp->regl = IGC_TXSTMPL_3;
+	tstamp->regh = IGC_TXSTMPH_3;
+	tstamp->flags = IGC_TX_FLAGS_TSTAMP_3;
+
 	switch (hw->mac.type) {
 	case igc_i225:
 		for (i = 0; i < IGC_N_SDP; i++) {
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index dba5a5759b1c..20e17f5fbce3 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -243,6 +243,18 @@
 #define IGC_SYSTIMR	0x0B6F8  /* System time register Residue */
 #define IGC_TIMINCA	0x0B608  /* Increment attributes register - RW */
 
+/* TX Timestamp Low */
+#define IGC_TXSTMPL_0		0x0B618
+#define IGC_TXSTMPL_1		0x0B698
+#define IGC_TXSTMPL_2		0x0B6B8
+#define IGC_TXSTMPL_3		0x0B6D8
+
+/* TX Timestamp High */
+#define IGC_TXSTMPH_0		0x0B61C
+#define IGC_TXSTMPH_1		0x0B69C
+#define IGC_TXSTMPH_2		0x0B6BC
+#define IGC_TXSTMPH_3		0x0B6DC
+
 #define IGC_TXSTMPL	0x0B618  /* Tx timestamp value Low - RO */
 #define IGC_TXSTMPH	0x0B61C  /* Tx timestamp value High - RO */
 
-- 
2.38.1


