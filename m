Return-Path: <netdev+bounces-29807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35533784CCE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC02B2811BC
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5434CFE;
	Tue, 22 Aug 2023 22:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB620183
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 22:23:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF19CDA
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692743011; x=1724279011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoH+76Crkh6Y+iagR726p4a6tnOuF8/kL/034a2D4/4=;
  b=BrWRI49Aff+nioXkQRhiTLK0Ab7oINGgzblF2QF8yk+PYafygMtC63ho
   7Y8Lww1SzAXTjFVt7BNgTeiLKBx4LUXDNqEyRmBafYc8UK4c26GwbTxnV
   ve5lvhQ955Z1pc/l7IEDIfflfYJ6dEPnuQXvuptWCCq8/EECBuUcYsrsT
   f3Wzx479uVgWBgWmSN9hp6fJXClS2r/neHDgnDd1oWVeE4qvY8hUa9fG9
   9v7JWDdUp54CqlGTgthu0tnvUuHdfnd5ynpEZVwTko+m2rLUZcWoyumcz
   wA+IpRGgCu8dAMeKgGtNu7Xn6K6rhXJP7ug9U3tA1bLUX6L/XZyQV+tB8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364192304"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364192304"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 15:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="729976450"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="729976450"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2023 15:23:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	horms@kernel.org,
	bcreeley@amd.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Date: Tue, 22 Aug 2023 15:16:20 -0700
Message-Id: <20230822221620.2988753-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.38.1


