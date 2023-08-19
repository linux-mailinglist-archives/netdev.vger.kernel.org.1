Return-Path: <netdev+bounces-29100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD37819D7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4092E1C20947
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C346746B1;
	Sat, 19 Aug 2023 13:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1B125A0
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:53:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CAA22A14
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692453139; x=1723989139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yde9xJhaTEZD+38PelDCp44E5kb3nUKVR/tKJEve7W0=;
  b=PGMSCIEsGSd9AbauUfBOA6kgKxSZcEZBsmx1vbEpe/6UItyezQMJVSZ9
   pz9VCQcEqM7izSt9e8Yon9Kf9Fj9FhFv6tvcUrY9+2O3h1u16/5KtOZG5
   /cTPrkQsny7/vvm7memGJIrqdjW0isjCyv0SN2hWD9ZFmQHd8wXVYuQdA
   YTA+nl0Uda7Aj+zX6WFTDyBpw/obEhaIZIcrWGMndEbjzhjfScds5Nags
   2s7VijQJcU2Jur8kb3BGCvENnK3gsh1VjbjLxZoHGn94LCelqpWgZ5NLX
   PXz9v6pXExgpcaHfgesGDzW7cPwsLsyspw+JeDIAXsowppzjfePd6SaTI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="363463634"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="363463634"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 06:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="805452183"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="805452183"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2023 06:52:14 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Cc: sasha.neftin@intel.com,
	bcreeley@amd.com,
	horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	muhammad.husaini.zulkifli@intel.com,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	naamax.meir@linux.intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net v4 2/2] igc: Modify the tx-usecs coalesce setting
Date: Sat, 19 Aug 2023 21:50:51 +0800
Message-Id: <20230819135051.29390-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230819135051.29390-1-muhammad.husaini.zulkifli@intel.com>
References: <20230819135051.29390-1-muhammad.husaini.zulkifli@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This patch enables users to modify the tx-usecs parameter.
The rx-usecs value will adhere to the same value as tx-usecs
if the queue pair setting is enabled.

How to test:
User can set the coalesce value using ethtool command.

Example command:
Set: ethtool -C <interface>

Previous output:

root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
netlink error: Invalid argument

New output:

root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
rx-usecs: 10
rx-frames: n/a
rx-usecs-irq: n/a
rx-frames-irq: n/a

tx-usecs: 10
tx-frames: n/a
tx-usecs-irq: n/a
tx-frames-irq: n/a

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 45 ++++++++++++++------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 62d925b26f2c..40ec6ebc0843 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -888,6 +888,11 @@ static int igc_ethtool_get_coalesce(struct net_device *netdev,
 	return 0;
 }
 
+static int igc_ethtool_coalesce_to_itr_setting(u32 coalesce_usecs)
+{
+	return coalesce_usecs <= 3 ? coalesce_usecs : coalesce_usecs << 2;
+}
+
 static int igc_ethtool_set_coalesce(struct net_device *netdev,
 				    struct ethtool_coalesce *ec,
 				    struct kernel_ethtool_coalesce *kernel_coal,
@@ -914,19 +919,35 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 			adapter->flags &= ~IGC_FLAG_DMAC;
 	}
 
-	/* convert to rate of irq's per second */
-	if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
-		adapter->rx_itr_setting = ec->rx_coalesce_usecs;
-	else
-		adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
+	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
+		u32 old_tx_itr, old_rx_itr;
+
+		/* This is to get back the original value before byte shifting */
+		old_tx_itr = (adapter->tx_itr_setting <= 3) ?
+			      adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
+
+		old_rx_itr = (adapter->rx_itr_setting <= 3) ?
+			      adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
+
+		/* convert to rate of irq's per second */
+		if (old_tx_itr != ec->tx_coalesce_usecs) {
+			adapter->tx_itr_setting =
+				igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce_usecs);
+			adapter->rx_itr_setting = adapter->tx_itr_setting;
+		} else if (old_rx_itr != ec->rx_coalesce_usecs) {
+			adapter->rx_itr_setting =
+				igc_ethtool_coalesce_to_itr_setting(ec->rx_coalesce_usecs);
+			adapter->tx_itr_setting = adapter->rx_itr_setting;
+		}
+	} else {
+		/* convert to rate of irq's per second */
+		adapter->rx_itr_setting =
+			igc_ethtool_coalesce_to_itr_setting(ec->rx_coalesce_usecs);
 
-	/* convert to rate of irq's per second */
-	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS)
-		adapter->tx_itr_setting = adapter->rx_itr_setting;
-	else if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
-		adapter->tx_itr_setting = ec->tx_coalesce_usecs;
-	else
-		adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
+		/* convert to rate of irq's per second */
+		adapter->tx_itr_setting =
+			igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce_usecs);
+	}
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		struct igc_q_vector *q_vector = adapter->q_vector[i];
-- 
2.17.1


