Return-Path: <netdev+bounces-23008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C493476A622
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCF281776
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA73A32;
	Tue,  1 Aug 2023 01:16:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC07E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:16:48 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B416810F5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690852605; x=1722388605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iNbzwRMjAEvSzQbxsOi+KU8F2Wyrzf5JNrk8JE3lgeI=;
  b=W62S17dcPuEhR7ALAW42QSW+m0wPJJLVa+G+dvOa/hp0IN+DBzElIjoj
   O6AjivOGqWxBH57aszDekuGpa7XB6a4ErwUL4QQr4RtSrNAE8Uw6HPWz5
   SMRxMIXFfwK9yauxOmSOdLgT3c5pmN0c2FoZkVn8IbYSzvK7FMJGbJmh6
   dby1Krmw0L0dB2vzYEw8/tNCNU0OB4D49XXxI+mGe16QJlC09VunecNem
   3ZkQi6jJGDSUHohUvCH7aJToqkKpaKVDgD3l+kRFcKamdPn3E53/9TQz5
   NVHR7wuuKJILw3QgV1VmyB+s4O9DKbjNL/OMZaaO9QICbe3yRJ2Fa9prZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372792726"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372792726"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798458559"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798458559"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 18:16:42 -0700
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
Subject: [PATCH iwl-net v3 1/2] igc: Expose tx-usecs coalesce setting to user
Date: Tue,  1 Aug 2023 09:15:17 +0800
Message-Id: <20230801011518.25370-2-muhammad.husaini.zulkifli@intel.com>
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
2.17.1


