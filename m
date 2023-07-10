Return-Path: <netdev+bounces-16526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8274DB4A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494D11C20B20
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480E13ACD;
	Mon, 10 Jul 2023 16:40:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD013ACA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:40:45 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950AE8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689007244; x=1720543244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTtEhRoVUMXX2y+JASwjCgOkC7VQ/7tole03eO+OZjc=;
  b=e2w734vig1rSASezP7mVoHhx5Xs6EZvg5IDqrD3wyvFJdW8a+qC37/M8
   zDbHxV3HEMYhgqUbkPTWzf9Oe3XY5wAdk5tZ7Z5Hdn5UpUUikMit+BLfh
   7a/tCinRy/wGsWFIuOmZxiw0KdQ4ohU0/3nJolu0C3/cwxhqkzg4wOTk2
   khwzOoM03tI+Npu6rxqquCONAfv7kymsY7fFiSHVkOQS9U8R1hw3V+W62
   vfXoB97upfRWNt5/DZjmUyA//X4AqcasHKJ8kQA7WjkjmtVXx7xxkhjKH
   pM+efkXE+KDMq/e4G05d17OzoaElF4xcNofBYe91dEeSJ8MhFd9PITIYb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364431374"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364431374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="810867150"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="810867150"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 09:40:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com,
	aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 2/6] igc: Do not enable taprio offload for invalid arguments
Date: Mon, 10 Jul 2023 09:34:59 -0700
Message-Id: <20230710163503.2821068-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Florian Kauer <florian.kauer@linutronix.de>

Only set adapter->taprio_offload_enable after validating the arguments.
Otherwise, it stays set even if the offload was not enabled.
Since the subsequent code does not get executed in case of invalid
arguments, it will not be read at first.
However, by activating and then deactivating another offload
(e.g. ETF/TX launchtime offload), taprio_offload_enable is read
and erroneously keeps the offload feature of the NIC enabled.

This can be reproduced as follows:

    # TAPRIO offload (flags == 0x2) and negative base-time leading to expected -ERANGE
    sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time -1000 \
	    sched-entry S 01 300000 \
	    flags 0x2

    # IGC_TQAVCTRL is 0x0 as expected (iomem=relaxed for reading register)
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

    # Activate ETF offload
    sudo tc qdisc replace dev enp1s0 parent root handle 6666 mqprio \
	    num_tc 3 \
	    map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
	    queues 1@0 1@1 2@2 \
	    hw 0
    sudo tc qdisc add dev enp1s0 parent 6666:1 etf \
	    clockid CLOCK_TAI \
	    delta 500000 \
	    offload

    # IGC_TQAVCTRL is 0x9 as expected
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

    # Deactivate ETF offload again
    sudo tc qdisc delete dev enp1s0 parent 6666:1

    # IGC_TQAVCTRL should now be 0x0 again, but is observed as 0x9
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fae534ef1c4f..fb8e55c7c402 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6097,6 +6097,7 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
+	adapter->taprio_offload_enable = false;
 	adapter->qbv_config_change_errors = 0;
 	adapter->qbv_transition = false;
 	adapter->qbv_count = 0;
@@ -6124,20 +6125,12 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	switch (qopt->cmd) {
-	case TAPRIO_CMD_REPLACE:
-		adapter->taprio_offload_enable = true;
-		break;
-	case TAPRIO_CMD_DESTROY:
-		adapter->taprio_offload_enable = false;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	if (!adapter->taprio_offload_enable)
+	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		return igc_tsn_clear_schedule(adapter);
 
+	if (qopt->cmd != TAPRIO_CMD_REPLACE)
+		return -EOPNOTSUPP;
+
 	if (qopt->base_time < 0)
 		return -ERANGE;
 
@@ -6149,6 +6142,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
+	adapter->taprio_offload_enable = true;
 
 	igc_ptp_read(adapter, &now);
 
-- 
2.38.1


