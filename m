Return-Path: <netdev+bounces-20490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A26F75FBC3
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353902814E0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047DF9E8;
	Mon, 24 Jul 2023 16:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C47F9E0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:18:51 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4E10CB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215529; x=1721751529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLAjhiJl2DI/1hCKlWSkaXledA13ruzJScqm+J30Aks=;
  b=Az/egpcfzztlLeotGNBnhGKWVNlJwKqzIX3oU5lI0h58TH3SXPy++77A
   rh4pX6qm3ttuwCjNx+msVAWv9x327HVWmqu+7ti8O5s+UcnE0qVHzpJia
   Rmcdlw2qzBb8wAtCjZ6w3aWkaozb+u3iIvHvo5S+SDeurzsV1p3cKvoF4
   wR4JRqhxvqCdZzB2CLLT7HbbBTh+50oAD+LK8AJYJnPM/OUqFMf4h1I5T
   TlVzTt1ETNuhO7LI0JrtttwKUMOUeOWfIof9FYO+g6lkxOQnD8DPvumHv
   iw9me/0Hs+blI0JjVJIPSGO6wOQVCLotdr8ShmgOjiQspFijw3GdUqUZq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398394093"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398394093"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899545999"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899545999"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 09:18:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	simon.horman@corigine.com,
	vladbu@nvidia.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next v2 03/12] ice: Don't tx before switchdev is fully configured
Date: Mon, 24 Jul 2023 09:11:43 -0700
Message-Id: <20230724161152.2177196-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wojciech Drewek <wojciech.drewek@intel.com>

There is possibility that ice_eswitch_port_start_xmit might be
called while some resources are still not allocated which might
cause NULL pointer dereference. Fix this by checking if switchdev
configuration was finished.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index be5b22691f7c..15a4c148c28b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -331,6 +331,9 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	np = netdev_priv(netdev);
 	vsi = np->vsi;
 
+	if (!vsi || !ice_is_switchdev_running(vsi->back))
+		return NETDEV_TX_BUSY;
+
 	if (ice_is_reset_in_progress(vsi->back->state) ||
 	    test_bit(ICE_VF_DIS, vsi->back->state))
 		return NETDEV_TX_BUSY;
-- 
2.38.1


