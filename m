Return-Path: <netdev+bounces-26312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5D7777F0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D962820B0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF061FB26;
	Thu, 10 Aug 2023 12:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD4442C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:14:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F3123
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691669644; x=1723205644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wx5myXOtLJV2KeSzFA3pd4U9Pgf+WCRz8T5yYTgROjc=;
  b=S7uEdDgjb7TcjvJv780bQUAUViIG72I7+JthYjVxuoasmQNg5mAubvbw
   GYHB97w82UmhOj9QIX+sH3vpS7P1pASr10wuNiH/AGkHJTs1R+yy/N+Ww
   haOdSDT2zA0v7p9r/PWhoKibm983MnILWPptQ+GiA97RxQkNIau7bAd4c
   yj3yEJZ0SnOjrHhK8RTz68oWYKCqhRw3cddpNHCE0S4OtU1kWjaYRMMay
   Tmg3oM28fjqGMNw71HOuj0Ct/ibUkEefm8WrWJepcYr5gt62LSRQcUo+Q
   Zzz/hL1JDLuv5JCXKRWp2U+W/DQxcjuQzIth8I1+evbjUfS3+Zn29tqdx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="375098690"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375098690"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846369686"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846369686"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 05:14:00 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A6A5332CAB;
	Thu, 10 Aug 2023 13:13:59 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leon@kernel.org,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3] ice: Block switchdev mode when ADQ is active and vice versa
Date: Thu, 10 Aug 2023 14:12:46 +0200
Message-ID: <20230810121245.51587-2-marcin.szycik@linux.intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
v3: Moved switchdev mode check out of adev lock
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 5 +++++
 2 files changed, 11 insertions(+)

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
index cf92c39467c8..b40dfe6ae321 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8823,6 +8823,11 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 						  ice_setup_tc_block_cb,
 						  np, np, true);
 	case TC_SETUP_QDISC_MQPRIO:
+		if (ice_is_eswitch_mode_switchdev(pf)) {
+			netdev_err(netdev, "TC MQPRIO offload not supported, switchdev is enabled\n");
+			return -EOPNOTSUPP;
+		}
+
 		if (pf->adev) {
 			mutex_lock(&pf->adev_mutex);
 			device_lock(&pf->adev->dev);
-- 
2.41.0


