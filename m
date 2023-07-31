Return-Path: <netdev+bounces-22840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EC7698D7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D3F1C20C25
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85818AF4;
	Mon, 31 Jul 2023 14:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1389018AF3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 14:00:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8F7D8B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690811977; x=1722347977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FLzU3pA/+0H8iLwjfinK0J+eRdmmpjynTV8LPGQR8c0=;
  b=SHYo1DmUXSootp5g/Uvdl7r9QtFJdjQ2MlT3v+L80MtYTEHVDBgVt8fA
   SURPLjkWv0vGHWnPAENTQj0LpnW0v149Mu78F3CWdEKLiL0ybz98VbYVt
   xVRwCQRckpl73fxRitBdWPTDL4GDzvDrVcwZAuPct2ep6/HDUwHGDXaZN
   wM39oGpFWmaB1p1AJEtPtUE2HyOdv0dASm8cf3o4fh471JCq1oSS/gI+U
   f+nP8/Qc7joHz/HCaCMgZQz3oqm6K4zZD2EcbpSwB6oQVnGdY+D3DmXe4
   jVVrLJmrAvkNbrwonI4WwvFBxl1gXaQk+bs8K451bTCRCUx0jjmz0TD0W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="348621036"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348621036"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757951536"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="757951536"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 06:59:23 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Grzegorz Szczurek <grzegorzx.szczurek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v3] i40e: Clear stats after deleting tc
Date: Mon, 31 Jul 2023 15:52:18 +0200
Message-Id: <20230731135218.10051-1-jedrzej.jagielski@intel.com>
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

There was an issue with ethtool stats that have not been cleared after tc
had been deleted. Stats printed by ethtool -S remained the same despite
qdisc had been removed, what is an unexpected behavior.
Stats should be reset once the qdisc is removed.

Fix this by resetting stats after deleting tc by calling
i40e_vsi_reset_stats() function after destroying qdisc.

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
v3: Correct the commit msg
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


