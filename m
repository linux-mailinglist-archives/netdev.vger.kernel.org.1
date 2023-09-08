Return-Path: <netdev+bounces-32544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB17983E6
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8671C20C28
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994FE1C3D;
	Fri,  8 Sep 2023 08:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890515B6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:19:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C31FC4
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694161141; x=1725697141;
  h=from:to:cc:subject:date:message-id;
  bh=AURspU3F76W2cee+nFjq4Ps1mpWQnJyFzP2jJXded+c=;
  b=Q1ExqXWWWVDyVlZAwTJjpQAv1mx5iTxAY8WKQx+EkJ2grB/Er9jfsXMI
   yNFNSfw2GsAMIVmANdiGfAmg2qKsuNSQHt9bi08HBZUkR1+bF3igY+5QG
   OikFMUJutRQuN9uqMyJbJMn6lwFCqHgXQ+F4Le3mhEsjI3UZBIRbYT8yT
   /bAKe6x4QPiZ6BtsyJX0+omqJhj7hWxekeMoTetIknvk9vbC9fsQR7pKO
   KGL7mYlgwxbrFjEUdJpGSy8uU139iVVmJXr8QGFN7gH6T8pkQZAJ8EobK
   w+NhQut5mRwHdMnyGtQrjtF100SW022WOwqMewta9YqVfUS1L0RuBykSr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="362655518"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="362655518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 01:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735878681"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="735878681"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
  by orsmga007.jf.intel.com with ESMTP; 08 Sep 2023 01:18:46 -0700
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
	anthony.l.nguyen@intel.com,
	husainizulkifli@gmail.com
Subject: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
Date: Fri,  8 Sep 2023 16:17:34 +0800
Message-Id: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

When users attempt to obtain the coalesce setting using the
ethtool command, current code always returns 0 for tx-usecs.
This is because I225/6 always uses a queue pair setting, hence
tx_coalesce_usecs does not return a value during the
igc_ethtool_get_coalesce() callback process. The pair queue
condition checking in igc_ethtool_get_coalesce() is removed by
this patch so that the user gets information of the value of tx-usecs.

Even if i225/6 is using queue pair setting, there is no harm in
notifying the user of the tx-usecs. The implementation of the current
code may have previously been a copy of the legacy code i210.
Since I225 has the queue pair setting enabled, tx-usecs will always adhere
to the user-set rx-usecs value. An error message will appear when the user
attempts to set the tx-usecs value for the input parameters because,
by default, they should only set the rx-usecs value.

This patch also adds the helper function to get the
previous rx coalesce value similar to tx coalesce.

How to test:
User can get the coalesce value using ethtool command.

Example command:
Get: ethtool -c <interface>

Previous output:

rx-usecs: 3
rx-frames: n/a
rx-usecs-irq: n/a
rx-frames-irq: n/a

tx-usecs: 0
tx-frames: n/a
tx-usecs-irq: n/a
tx-frames-irq: n/a

New output:

rx-usecs: 3
rx-frames: n/a
rx-usecs-irq: n/a
rx-frames-irq: n/a

tx-usecs: 3
tx-frames: n/a
tx-usecs-irq: n/a
tx-frames-irq: n/a

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
---
V4 -> V5:
- Squash patch for set/get together as recommended by Jakub.
- Fix unstabilize value when user insert both tx and rx params
together.
- Add error message for unsupported config.

V3 -> V4:
- Implement the helper function, as recommended by Brett Creely.
- Fix typo in cover letter.

V2 -> V3:
- Refactor the code, as Simon suggested, to make it more readable.

V1 -> V2:
- Split the patch file into two, like Anthony suggested.
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 31 ++++++++++++--------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 93bce729be76..7ab6dd58e400 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -868,6 +868,18 @@ static void igc_ethtool_get_stats(struct net_device *netdev,
 	spin_unlock(&adapter->stats64_lock);
 }
 
+static int igc_ethtool_get_previous_rx_coalesce(struct igc_adapter *adapter)
+{
+	return (adapter->rx_itr_setting <= 3) ?
+		adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
+}
+
+static int igc_ethtool_get_previous_tx_coalesce(struct igc_adapter *adapter)
+{
+	return (adapter->tx_itr_setting <= 3) ?
+		adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
+}
+
 static int igc_ethtool_get_coalesce(struct net_device *netdev,
 				    struct ethtool_coalesce *ec,
 				    struct kernel_ethtool_coalesce *kernel_coal,
@@ -875,17 +887,8 @@ static int igc_ethtool_get_coalesce(struct net_device *netdev,
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	if (adapter->rx_itr_setting <= 3)
-		ec->rx_coalesce_usecs = adapter->rx_itr_setting;
-	else
-		ec->rx_coalesce_usecs = adapter->rx_itr_setting >> 2;
-
-	if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS)) {
-		if (adapter->tx_itr_setting <= 3)
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting;
-		else
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
-	}
+	ec->rx_coalesce_usecs = igc_ethtool_get_previous_rx_coalesce(adapter);
+	ec->tx_coalesce_usecs = igc_ethtool_get_previous_tx_coalesce(adapter);
 
 	return 0;
 }
@@ -910,8 +913,12 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 	    ec->tx_coalesce_usecs == 2)
 		return -EINVAL;
 
-	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) && ec->tx_coalesce_usecs)
+	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) &&
+	    ec->tx_coalesce_usecs != igc_ethtool_get_previous_tx_coalesce(adapter)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Queue Pair mode enabled, both Rx and Tx coalescing controlled by rx-usecs");
 		return -EINVAL;
+	}
 
 	/* If ITR is disabled, disable DMAC */
 	if (ec->rx_coalesce_usecs == 0) {
-- 
2.17.1


