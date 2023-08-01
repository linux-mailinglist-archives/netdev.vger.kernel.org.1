Return-Path: <netdev+bounces-23009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C376A623
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5411C20DB6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD159A59;
	Tue,  1 Aug 2023 01:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB607E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:16:50 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C384A10EA
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690852607; x=1722388607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b5WhSjde2r8XEbweVLXGUkprRp65g6AuGY6uG1nH19k=;
  b=X0+uR5gCwGH6izRAyHPWp3ksXWSs2hQdT/6vOeisl5KQNXRjZgujlF5n
   nCscGkWm/eDN+wr3qPYLobYbV3FkNn/Z7MD3kg1r37xzwQts64VzKtXi3
   LKvt4ioRArSAfYg4MrFDBDdrBtRx7O1DTKXw4VlzqMmcD6TV2wZ8AGvoR
   nWN38hYz9SJotEC8Ql9UesivNjJUKjJE0k9wXiZR3mFbX+6F04StAtYjT
   HWoWY1NQJo71D5W0xNkV5Ix/v5BOs5mbhWo2ecXXcqdbrW/fYNFB36zkt
   S5wC/9eUiBeKOv1DddWSPra+LhOVBB2DHVNgeFaxiUFCwie0w4A0Di1gb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372792741"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372792741"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798458572"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798458572"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 18:16:45 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	muhammad.husaini.zulkifli@intel.com,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	naamax.meir@linux.intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net v3 2/2] igc: Modify the tx-usecs coalesce setting
Date: Tue,  1 Aug 2023 09:15:18 +0800
Message-Id: <20230801011518.25370-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>
References: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 49 +++++++++++++++-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 62d925b26f2c..ed67d9061452 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -914,19 +914,44 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
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
+		if (old_tx_itr != ec->tx_coalesce_usecs) {
+			if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
+				adapter->tx_itr_setting = ec->tx_coalesce_usecs;
+			else
+				adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
+
+			adapter->rx_itr_setting = adapter->tx_itr_setting;
+		} else if (old_rx_itr != ec->rx_coalesce_usecs) {
+			if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
+				adapter->rx_itr_setting = ec->rx_coalesce_usecs;
+			else
+				adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
+
+			adapter->tx_itr_setting = adapter->rx_itr_setting;
+		}
+	} else {
+		/* convert to rate of irq's per second */
+		if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
+			adapter->rx_itr_setting = ec->rx_coalesce_usecs;
+		else
+			adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
 
-	/* convert to rate of irq's per second */
-	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS)
-		adapter->tx_itr_setting = adapter->rx_itr_setting;
-	else if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
-		adapter->tx_itr_setting = ec->tx_coalesce_usecs;
-	else
-		adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
+		/* convert to rate of irq's per second */
+		if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <= 3)
+			adapter->tx_itr_setting = ec->tx_coalesce_usecs;
+		else
+			adapter->tx_itr_setting = ec->tx_coalesce_usecs << 2;
+	}
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		struct igc_q_vector *q_vector = adapter->q_vector[i];
-- 
2.17.1


