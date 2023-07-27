Return-Path: <netdev+bounces-21814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59782764E22
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15586281E4E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A0D518;
	Thu, 27 Jul 2023 08:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE001C2C2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:50:40 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83559E9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690447839; x=1721983839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yi/fZbqc2aTipgo4D4/H6pWrGYqmIoIAdaNXEMhKqEE=;
  b=LgCZL3kcxvrDheQ0rvVCAXN95Dij7pFLVp1vdfdM5Msh7/N47f/tTxrl
   XPNBhTigs8KljeR4WsGGO9N77nEoUmAD/cyYrU1oM/YB2QzKjrn0UGDIm
   rrawCR3EUSSmtmKnEQZkeAq7i4JHLiyamKHG9H9d2DEN8+03q6a+b39WI
   RXfw30VGkWJ1+cGJqNaxcN6p5jhG7FEGaWCJ0jH8OLLu76eKcUJ3NV+wV
   VBlmL+62hFmyjt+/pOeEKbF/JOvwkdvsJZnFk/bhd5PBf7+atU7yK1sXg
   C+A5aqB+6ctbIcgpMw+vnsJEAFcodVU38tWmGc8wcgFRkmPmB0D19UqO/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368269728"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="368269728"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 01:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840653914"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840653914"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2023 01:50:37 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Grzegorz Szczurek <grzegorzx.szczurek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v2] i40e: Clear stats after deleting tc
Date: Thu, 27 Jul 2023 10:43:35 +0200
Message-Id: <20230727084335.63856-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
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

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

There was an issue with ethtool stats that
have not been cleared after tc had been deleted.
Stats printed by ethtool -S remained the same despite
qdick had been removed, what is an unexpected behavior.
Stats should be reseted once qdick is removed.

Fix this by resetting stats after deleting tc
by calling i40e_vsi_reset_stats() function after
distroying qdisc.

Steps to reproduce:

1) Add ingress rule
tc qdisc add dev <ethX> ingress

2) Create qdisc and filter
tc qdisc add dev <ethX> root mqprio num_tc 4 map 0 0 0 0 1 2 2 3 queues 2@0 2@2 1@4 1@5 hw 1 mode channel
tc filter add dev <ethX> protocol ip parent ffff: prio 3 flower dst_ip <ip> ip_proto tcp dst_port 8300 skip_sw hw_tc 2

3) Run iperf between client and SUT
iperf3 -s -p 8300
iperf3 -c <ip> -p 8300

4) Check the ethtool stats
ethtool -S <ethX> | grep packets | column

5) Delete filter and qdisc
tc filter del dev <ethX> parent ffff:
tc qdisc del dev <ethX> root

6) Check the ethtool stats and see that they didn't change
ethtool -S <ethX> | grep packets | column

Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: Make the commit msg more detailed
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 29ad1797adce..e8e03ede1672 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5885,6 +5885,11 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 
 	/* Update the netdev TC setup */
 	i40e_vsi_config_netdev_tc(vsi, enabled_tc);
+
+	/* After destroying qdisc reset all stats of the vsi */
+	if (!vsi->mqprio_qopt.qopt.hw)
+		i40e_vsi_reset_stats(vsi);
+
 out:
 	return ret;
 }
-- 
2.31.1


