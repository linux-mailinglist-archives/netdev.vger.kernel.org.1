Return-Path: <netdev+bounces-18026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4F7543A5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754CA2809A8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFF2772C;
	Fri, 14 Jul 2023 20:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E62419D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:16:51 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DC3AA9
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689365795; x=1720901795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JZyyHriPa+HbvgiB4o8p/9rR3Z+RGPwPz4lMcIqn/w=;
  b=T6AbfVSBcWkDE8OOBh5Gkiz7UW9BYWKfEP7aaRUlKQxzbX+R/df0av1u
   DEvT0yEifpLMiLqCbqAQLk0rFdegSE2jxcG139JpYSLE/dUwvKyP8FNwq
   0qC4mLjYlIArZlx6UXbyEXFzjDqNfk3iixQBM1Cj6FcKmBgEkTB4PdxeD
   xJvvrD10Sy3oe1B6H+soX7aYw0E1b6zCIf09a4mouqJ5cA9TNsC0mCSJv
   CFKl20FQhPpFOqh2JKsG8z9u3nmWnAyhCccHvSBb57gX0ZBj1Zv9k3h03
   t+kVRXAFKvt7tlPIDDF4p6AnNP9xpIwxPRpHM3lSjLf1RIUXouKzq1GhO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="431744612"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="431744612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="752168798"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="752168798"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2023 13:16:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/2] ice: Unregister netdev and devlink_port only once
Date: Fri, 14 Jul 2023 13:10:40 -0700
Message-Id: <20230714201041.1717834-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230714201041.1717834-1-anthony.l.nguyen@intel.com>
References: <20230714201041.1717834-1-anthony.l.nguyen@intel.com>
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

From: Petr Oros <poros@redhat.com>

Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
functions") ice_vsi_release does things twice. There is unregister
netdev which is unregistered in ice_deinit_eth also.

It also unregisters the devlink_port twice which is also unregistered
in ice_deinit_eth(). This double deregistration is hidden because
devl_port_unregister ignores the return value of xa_erase.

[   68.642167] Call Trace:
[   68.650385]  ice_devlink_destroy_pf_port+0xe/0x20 [ice]
[   68.655656]  ice_vsi_release+0x445/0x690 [ice]
[   68.660147]  ice_deinit+0x99/0x280 [ice]
[   68.664117]  ice_remove+0x1b6/0x5c0 [ice]

[  171.103841] Call Trace:
[  171.109607]  ice_devlink_destroy_pf_port+0xf/0x20 [ice]
[  171.114841]  ice_remove+0x158/0x270 [ice]
[  171.118854]  pci_device_remove+0x3b/0xc0
[  171.122779]  device_release_driver_internal+0xc7/0x170
[  171.127912]  driver_detach+0x54/0x8c
[  171.131491]  bus_remove_driver+0x77/0xd1
[  171.135406]  pci_unregister_driver+0x2d/0xb0
[  171.139670]  ice_module_exit+0xc/0x55f [ice]

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 27 ------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 00e3afd507a4..0054d7e64ec3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2972,39 +2972,12 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		return -ENODEV;
 	pf = vsi->back;
 
-	/* do not unregister while driver is in the reset recovery pending
-	 * state. Since reset/rebuild happens through PF service task workqueue,
-	 * it's not a good idea to unregister netdev that is associated to the
-	 * PF that is running the work queue items currently. This is done to
-	 * avoid check_flush_dependency() warning on this wq
-	 */
-	if (vsi->netdev && !ice_is_reset_in_progress(pf->state) &&
-	    (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state))) {
-		unregister_netdev(vsi->netdev);
-		clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
-	}
-
-	if (vsi->type == ICE_VSI_PF)
-		ice_devlink_destroy_pf_port(pf);
-
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
 
 	ice_vsi_close(vsi);
 	ice_vsi_decfg(vsi);
 
-	if (vsi->netdev) {
-		if (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state)) {
-			unregister_netdev(vsi->netdev);
-			clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
-		}
-		if (test_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state)) {
-			free_netdev(vsi->netdev);
-			vsi->netdev = NULL;
-			clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
-		}
-	}
-
 	/* retain SW VSI data structure since it is needed to unregister and
 	 * free VSI netdev when PF is not in reset recovery pending state,\
 	 * for ex: during rmmod.
-- 
2.38.1


