Return-Path: <netdev+bounces-18030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740A7543AF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65302817FF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3F2416B;
	Fri, 14 Jul 2023 20:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D620F96
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:20:23 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005730E3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689366019; x=1720902019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NDPaLdOJY101OU8vWUEpzg+kmqNoxhzLdZ1gJwb+We8=;
  b=aJfcmkHMK9afKjYSv4xZyvcPX0XKCMWxY/yUcB/UV9OQUOACoB8kMtqR
   SgtjTObFWzh6HtACpP7+4yAHOfuiiOzi329N0/j/xlZIFWV+zJJn1Q1LG
   /FXtVnn9G04LyUdSiL4m1dQXVoK2rBxb9ItHPkQo8pvCFZWBHI9kB5td9
   0PPCM6uqVUjLEJdAklp42lNMZPHuk+CQ8RXCgufKwcpR6ma2rK3eU44HF
   yRDxI5nDd/jnrHY3RhapfEoDoDDxseB9aYFTNPH3WmthRAa0veODLAY2Q
   31znz3LGfiWcmE/LBYNFScdoQXbN5MziWjY4V/yc05NCgBjT3Kn/ppEx1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345880078"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="345880078"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="836165376"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="836165376"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jul 2023 13:20:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next] igc: Add TransmissionOverrun counter
Date: Fri, 14 Jul 2023 13:14:28 -0700
Message-Id: <20230714201428.1718097-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add TransmissionOverrun as per defined by IEEE 802.1Q Bridges.
TransmissionOverrun counter shall be incremented if the implementation
detects that a frame from a given queue is still being transmitted by
the MAC when that gate-close event for that queue occurs.

This counter is utilised by the Certification conformance test to
inform the user application whether any packets are currently being
transmitted on a particular queue during a gate-close event.

Intel Discrete I225/I226 have a mechanism to not transmit a packets if
the gate open time is insufficient for the packet transmission by setting
the Strict_End bit. Thus, it is expected for this counter to be always
zero at this moment.

Inspired from enetc_taprio_stats() and enetc_taprio_queue_stats(), now
driver also report the tx_overruns counter per traffic class.

User can get this counter by using below command:
1) tc -s qdisc show dev <interface> root
2) tc -s class show dev <interface>

Test Result (Before):
class mq :1 root
 Sent 1289 bytes 20 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
class mq :2 root
 Sent 124 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
class mq :3 root
 Sent 46028 bytes 86 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
class mq :4 root
 Sent 2596 bytes 14 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

Test Result (After):
class taprio 100:1 root
 Sent 8491 bytes 38 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Transmit overruns: 0
class taprio 100:2 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Transmit overruns: 0
class taprio 100:3 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Transmit overruns: 0
class taprio 100:4 root
 Sent 994 bytes 11 pkt (dropped 0, overlimits 0 requeues 1)
 backlog 0b 0p requeues 1
 Transmit overruns: 0

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 35 +++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9f93f0f4f752..ddb4386c00cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6115,6 +6115,26 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 	return 0;
 }
 
+static void igc_taprio_stats(struct net_device *dev,
+			     struct tc_taprio_qopt_stats *stats)
+{
+	/* When Strict_End is enabled, the tx_overruns counter
+	 * will always be zero.
+	 */
+	stats->tx_overruns = 0;
+}
+
+static void igc_taprio_queue_stats(struct net_device *dev,
+				   struct tc_taprio_qopt_queue_stats *queue_stats)
+{
+	struct tc_taprio_qopt_stats *stats = &queue_stats->stats;
+
+	/* When Strict_End is enabled, the tx_overruns counter
+	 * will always be zero.
+	 */
+	stats->tx_overruns = 0;
+}
+
 static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 				 struct tc_taprio_qopt_offload *qopt)
 {
@@ -6125,11 +6145,20 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	if (qopt->cmd == TAPRIO_CMD_DESTROY)
+	switch (qopt->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		break;
+	case TAPRIO_CMD_DESTROY:
 		return igc_tsn_clear_schedule(adapter);
-
-	if (qopt->cmd != TAPRIO_CMD_REPLACE)
+	case TAPRIO_CMD_STATS:
+		igc_taprio_stats(adapter->netdev, &qopt->stats);
+		return 0;
+	case TAPRIO_CMD_QUEUE_STATS:
+		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
+		return 0;
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	if (qopt->base_time < 0)
 		return -ERANGE;
-- 
2.38.1


