Return-Path: <netdev+bounces-24437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD37702F6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33681C20C4E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F5CA5C;
	Fri,  4 Aug 2023 14:27:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C402BA4F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:27:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793FCC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159236; x=1722695236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GXmF27uGNRobpHnK3Kr3IDEDkP14r39sOYDAQGNg9ks=;
  b=e4KxdKYyhJXvQjOUsoVbr0ukiQx9dp2cOEuZERCxI5OKmyzwOyffZQ5r
   ojkN0sA+usZvaGYDF148yc/2ZKLmP2VvxQnqrFBGDgCcr7sTCoSqQ6BMS
   j3PvJAxM92U6wStV1ahq4EeFuZe3ayn6bKz2AXkku8Uv8H+m6md515coj
   ReleYGwFer/3fgWcwk64nSLpU4/oO9oI5+cG4vP8hqcc4CC+MgX330nwd
   ka3oa53Eo53YpulIUVxwI5mgFweaA0/heY5CiGK7vcmFspd9AumhAsWbU
   3vxkb1seWk8JzkKUS3LGJOcNC9Rc6iterDtx1l955oMkDEJ/w9ZDdCZ9r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="401123203"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="401123203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844107132"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="844107132"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 07:27:13 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 910093494F;
	Fri,  4 Aug 2023 15:27:12 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leon@kernel.org,
	jiri@resnulli.us,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ice: Block switchdev mode when ADQ is active and vice versa
Date: Fri,  4 Aug 2023 16:26:54 +0200
Message-ID: <20230804142654.9729-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ADQ and switchdev are not supported simultaneously. Enabling both at the
same time can result in nullptr dereference.

To prevent this, check if ADQ is active when changing devlink mode to
switchdev mode, and check if switchdev is active when enabling ADQ.

Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: Added netlink extack, changed error message to be more informative, 
    fixed typo in commit message
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ad0a007b7398..8f232c41a89e 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -538,6 +538,12 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		break;
 	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
 	{
+		if (ice_is_adq_active(pf)) {
+			dev_err(ice_pf_to_dev(pf), "Couldn't change eswitch mode to switchdev - ADQ is active. Delete ADQ configs and try again, e.g. tc qdisc del dev $PF root");
+			NL_SET_ERR_MSG_MOD(extack, "Couldn't change eswitch mode to switchdev - ADQ is active. Delete ADQ configs and try again, e.g. tc qdisc del dev $PF root");
+			return -EOPNOTSUPP;
+		}
+
 		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
 			 pf->hw.pf_id);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cf92c39467c8..2468b6018613 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8834,6 +8834,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			}
 		}
 
+		if (ice_is_eswitch_mode_switchdev(pf)) {
+			netdev_err(netdev, "TC MQPRIO offload not supported, switchdev is enabled\n");
+			err = -EOPNOTSUPP;
+			goto adev_unlock;
+		}
+
 		/* setup traffic classifier for receive side */
 		mutex_lock(&pf->tc_mutex);
 		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);
-- 
2.41.0


