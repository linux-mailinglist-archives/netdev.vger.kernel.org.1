Return-Path: <netdev+bounces-22371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98CB76731C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C139282494
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E4156CA;
	Fri, 28 Jul 2023 17:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE36154A8
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:19:08 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F38188;
	Fri, 28 Jul 2023 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690564747; x=1722100747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jgRNOMQ1SQm5ITQcDKK7Rl0K6TkyC//9Yvh0aOrBvPI=;
  b=gBt/rw2G8aag+ExUmVNGa6rzSJOSsqhQo/pgdyMiHg+qjVkucLTc8XAm
   aaGN12YzHoUDCyAS4wkAyLNCSuvyHX/ZM4RqBzKpJDPfSq5i8SWRxduBI
   zGGXxHNlUSeheTOKG61Pm8IB9p84FgqymeoCC/kmWeFCLxnwb1iNJMsIh
   CMgdmwf589wbgAe1hd0Yia56gdvMoTVaunTFOz0q/esAacUaY0532axXB
   a8wDU795apxuCEt1z8AbbyWBB4B6SIKNyUcU0fcZ1oSyFZpOtTyuFMajK
   95j2ZX8K9yw1cPbshkIteWuZ7B/abnUOcUvqcpYBgI0Z0YlPlD7qozO5O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371342852"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="371342852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="851287722"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851287722"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 10:19:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Rafal Rogalski <rafalx.rogalski@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	shiraz.saleem@intel.com,
	mustafa.ismail@intel.com,
	jgg@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Kamil Maziarz <kamil.maziarz@intel.com>,
	Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Subject: [PATCH net] ice: Fix RDMA VSI removal during queue rebuild
Date: Fri, 28 Jul 2023 10:12:43 -0700
Message-Id: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafal Rogalski <rafalx.rogalski@intel.com>

During qdisc create/delete, it is necessary to rebuild the queue
of VSIs. An error occurred because the VSIs created by RDMA were
still active.

Added check if RDMA is active. If yes, it disallows qdisc changes
and writes a message in the system logs.

Fixes: 348048e724a0 ("ice: Implement iidc operations")
Signed-off-by: Rafal Rogalski <rafalx.rogalski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f02d44455772..cf92c39467c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8813,6 +8813,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_pf *pf = np->vsi->back;
+	bool locked = false;
 	int err;
 
 	switch (type) {
@@ -8822,10 +8823,27 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 						  ice_setup_tc_block_cb,
 						  np, np, true);
 	case TC_SETUP_QDISC_MQPRIO:
+		if (pf->adev) {
+			mutex_lock(&pf->adev_mutex);
+			device_lock(&pf->adev->dev);
+			locked = true;
+			if (pf->adev->dev.driver) {
+				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
+				err = -EBUSY;
+				goto adev_unlock;
+			}
+		}
+
 		/* setup traffic classifier for receive side */
 		mutex_lock(&pf->tc_mutex);
 		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);
 		mutex_unlock(&pf->tc_mutex);
+
+adev_unlock:
+		if (locked) {
+			device_unlock(&pf->adev->dev);
+			mutex_unlock(&pf->adev_mutex);
+		}
 		return err;
 	default:
 		return -EOPNOTSUPP;
-- 
2.38.1


