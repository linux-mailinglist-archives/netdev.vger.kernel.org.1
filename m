Return-Path: <netdev+bounces-13134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F773A6C5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031CB281A69
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E9200AE;
	Thu, 22 Jun 2023 16:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9A1EA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:58:05 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AACF1BC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453075; x=1718989075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ltuG5G4J8R0Mm13/M0hIO055y2p8ZpKeJZNxzbllqs=;
  b=JebOq5wIHPawrVGTzIlUSWHfQ/p9jUlEV774DlPcnx4k375FzcFo2yzw
   pClmdCmfmyBNWBbpYcb60WvF7JVEneuo+YKKiTjHDwK0mBxFMo+VSBlOs
   gl4Nb6EoCcmnnkclmyXEGuGjlTPE0hb7LyatsANRjbpnl5Xii+XlI1zeK
   1mlY7B4nbo7ThoehST4wS3s6c+VQ+M1sKD/vKM9mX43fyECTlWz+d5vf7
   0MfQBLYH2h6/kUSPgcVgOO1N81/7qhhyM58rzSGnPcNlu/PD1gEJmdRC8
   9OuhzY/FsA1g/LY84tuSl1DbruLy9wkJspqcAnTRH5WKnRQOYahuWmXlZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340887274"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340887274"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692358329"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="692358329"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 09:57:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net v2 3/4] igc: Retrieve TX timestamp during interrupt handling
Date: Thu, 22 Jun 2023 09:52:43 -0700
Message-Id: <20230622165244.2202786-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
References: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

When the interrupt is handled, the TXTT_0 bit in the TSYNCTXCTL
register should already be set and the timestamp value already loaded
in the appropriate register.

This simplifies the handling, and reduces the latency for retrieving
the TX timestamp, which increase the amount of TX timestamps that can
be handled in a given time period.

As the "work" function doesn't run in a workqueue anymore, rename it
to something more sensible, a event handler.

Using ntpperf[1] we can see the following performance improvements:

Before:

$ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o -37
               |          responses            |     TX timestamp offset (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
1000       100   0.00%   0.00%   0.00% 100.00%      -56      +9     +52     19
1500       150   0.00%   0.00%   0.00% 100.00%      -40     +30     +75     22
2250       225   0.00%   0.00%   0.00% 100.00%      -11     +29     +72     15
3375       337   0.00%   0.00%   0.00% 100.00%      -18     +40     +88     22
5062       506   0.00%   0.00%   0.00% 100.00%      -19     +23     +77     15
7593       759   0.00%   0.00%   0.00% 100.00%       +7     +47   +5168     43
11389     1138   0.00%   0.00%   0.00% 100.00%      -11     +41   +5240     39
17083     1708   0.00%   0.00%   0.00% 100.00%      +19     +60   +5288     50
25624     2562   0.00%   0.00%   0.00% 100.00%       +1     +56   +5368     58
38436     3843   0.00%   0.00%   0.00% 100.00%      -84     +12   +8847     66
57654     5765   0.00%   0.00% 100.00%   0.00%
86481     8648   0.00%   0.00% 100.00%   0.00%
129721   12972   0.00%   0.00% 100.00%   0.00%
194581   16384   0.00%   0.00% 100.00%   0.00%
291871   16384  27.35%   0.00%  72.65%   0.00%
437806   16384  50.05%   0.00%  49.95%   0.00%

After:

$ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o -37
               |          responses            |     TX timestamp offset (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
1000       100   0.00%   0.00%   0.00% 100.00%      -44      +0     +61     19
1500       150   0.00%   0.00%   0.00% 100.00%       -6     +39     +81     16
2250       225   0.00%   0.00%   0.00% 100.00%      -22     +25     +69     15
3375       337   0.00%   0.00%   0.00% 100.00%      -28     +15     +56     14
5062       506   0.00%   0.00%   0.00% 100.00%       +7     +78    +143     27
7593       759   0.00%   0.00%   0.00% 100.00%      -54     +24    +144     47
11389     1138   0.00%   0.00%   0.00% 100.00%      -90     -33     +28     21
17083     1708   0.00%   0.00%   0.00% 100.00%      -50      -2     +35     14
25624     2562   0.00%   0.00%   0.00% 100.00%      -62      +7     +66     23
38436     3843   0.00%   0.00%   0.00% 100.00%      -33     +30   +5395     36
57654     5765   0.00%   0.00% 100.00%   0.00%
86481     8648   0.00%   0.00% 100.00%   0.00%
129721   12972   0.00%   0.00% 100.00%   0.00%
194581   16384  19.50%   0.00%  80.50%   0.00%
291871   16384  35.81%   0.00%  64.19%   0.00%
437806   16384  55.40%   0.00%  44.60%   0.00%

[1] https://github.com/mlichvar/ntpperf

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c |  2 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 15 +++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 66fb67c17e4f..a00738bf6b19 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -228,7 +228,6 @@ struct igc_adapter {
 
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
-	struct work_struct ptp_tx_work;
 	/* Access to ptp_tx_skb and ptp_tx_start are protected by the
 	 * ptp_tx_lock.
 	 */
@@ -638,6 +637,7 @@ int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
 void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
+void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
 
 #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb50bfd5b867..eb4f0e562f60 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5223,7 +5223,7 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 
 	if (tsicr & IGC_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		igc_ptp_tx_tstamp_event(adapter);
 		ack |= IGC_TSICR_TXTS;
 	}
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 42f622ceb64b..cf963a12a92f 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -540,8 +540,6 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
 {
 	unsigned long flags;
 
-	cancel_work_sync(&adapter->ptp_tx_work);
-
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
@@ -724,16 +722,14 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 }
 
 /**
- * igc_ptp_tx_work
- * @work: pointer to work struct
+ * igc_ptp_tx_tstamp_event
+ * @adapter: board private structure
  *
- * This work function checks the TSYNCTXCTL valid bit to determine when
- * a timestamp has been taken for the current stored skb.
+ * Called when a TX timestamp interrupt happens to retrieve the
+ * timestamp and send it up to the socket.
  */
-static void igc_ptp_tx_work(struct work_struct *work)
+void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter)
 {
-	struct igc_adapter *adapter = container_of(work, struct igc_adapter,
-						   ptp_tx_work);
 	struct igc_hw *hw = &adapter->hw;
 	unsigned long flags;
 	u32 tsynctxctl;
@@ -1004,7 +1000,6 @@ void igc_ptp_init(struct igc_adapter *adapter)
 
 	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->tmreg_lock);
-	INIT_WORK(&adapter->ptp_tx_work, igc_ptp_tx_work);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-- 
2.38.1


