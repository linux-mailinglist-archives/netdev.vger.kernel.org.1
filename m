Return-Path: <netdev+bounces-29808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AA784CCF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3931128110F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7D3D385;
	Tue, 22 Aug 2023 22:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172B3D380
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 22:23:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1292CD9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692743011; x=1724279011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uuImgP94/qhPf7xzlHBDbbTdnEc6U9qpE/OGxiSH2c=;
  b=adX3MOSnQPLduHqjSpA6klW3J0k0/3U1cE9BMDQn/5DwzvCCInGzPmmJ
   0InYyvkXHkMoUZQImzUJcqoAIdW9tkHGIkP+EcBIfs7fIYpJUEU6H0lr0
   xgSKguUh2WrynnWYfhfLk2Tx2UXBU/fqRq/sE8JOXzT4Ydkxcmma0nCs+
   PQt0YLbbPhOsAfEkdnPoRwKUbABPhvb//ZREDS8zw+jrWilJoFzbxt1O8
   KOZcTfKl5M0F2q0+KWQAAs+wACXDOHvWhGJFSpnQxzrnY+SyNYh9BD4hb
   q9RFx7dhu5TMjZxT+ihE0dfQDl0QPF0FP3UFUlDzW6qnlHKofBGKQSKz6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364192298"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364192298"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 15:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="729976447"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="729976447"
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
Subject: [PATCH net v3 1/2] igc: Expose tx-usecs coalesce setting to user
Date: Tue, 22 Aug 2023 15:16:19 -0700
Message-Id: <20230822221620.2988753-2-anthony.l.nguyen@intel.com>
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 93bce729be76..62d925b26f2c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -880,12 +880,10 @@ static int igc_ethtool_get_coalesce(struct net_device *netdev,
 	else
 		ec->rx_coalesce_usecs = adapter->rx_itr_setting >> 2;
 
-	if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS)) {
-		if (adapter->tx_itr_setting <= 3)
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting;
-		else
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
-	}
+	if (adapter->tx_itr_setting <= 3)
+		ec->tx_coalesce_usecs = adapter->tx_itr_setting;
+	else
+		ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
 
 	return 0;
 }
@@ -910,9 +908,6 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 	    ec->tx_coalesce_usecs == 2)
 		return -EINVAL;
 
-	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) && ec->tx_coalesce_usecs)
-		return -EINVAL;
-
 	/* If ITR is disabled, disable DMAC */
 	if (ec->rx_coalesce_usecs == 0) {
 		if (adapter->flags & IGC_FLAG_DMAC)
-- 
2.38.1


