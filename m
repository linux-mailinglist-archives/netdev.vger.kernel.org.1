Return-Path: <netdev+bounces-44196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639D7D6FA5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365721C208A5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EEE27EE5;
	Wed, 25 Oct 2023 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvD3swWS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74921C8EA
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:48:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F83DC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698245297; x=1729781297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r4IllklSL3eRFegSTstqSw7cLr2JXE5NvAhcg46wysE=;
  b=ZvD3swWSVLeimCYSe5XQ3Ie53I7Tvx5oAHVqwmTEUBr+vSo7fBYb2/X3
   wyOZjJtixL0rffK40E/lezMLM+cdVfwOkE/cx8UTzt4sunFEtfxpyReWa
   ap4bRc/fUHtEJSNVmsHAy3KKddEy4iZOc3BDHtD2ARfjEwLGDtkDXVDbe
   RaumeYmbNmaDs29VHB2++nEReUNR9UptZ42wUQ2f400s2ZTLbhxplifVi
   7dBeJTinXx1sb2x9aZbKbbSJ+mNjiNhT4R/zo0hCWQK4PNseHWqi7j9OJ
   mLIxZ9Y6DjgYWwV+2j8iKxgFGxedk4QymgF5LnuGza1/f8BC09KRJsxoA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451549034"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="451549034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 07:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902568385"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902568385"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2023 07:45:36 -0700
Received: from giewont.igk.intel.com (giewont.igk.intel.com [10.211.8.15])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A5FB7284DD;
	Wed, 25 Oct 2023 15:47:58 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net] ice: Fix VF-VF direction matching in drop rule in switchdev
Date: Wed, 25 Oct 2023 16:47:24 +0200
Message-Id: <20231025144724.234304-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a drop rule on a VF, rule direction is not being set, which
results in it always being set to ingress (ICE_ESWITCH_FLTR_INGRESS
equals 0). Because of this, drop rules added on port representors don't
match any packets.

To fix it, set rule direction in drop action to egress when netdev is a
port representor, otherwise set it to ingress.

Fixes: 0960a27bd479 ("ice: Add direction metadata")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 24 ++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 0e75fc6b3c06..dd03cb69ad26 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -670,6 +670,25 @@ static int ice_tc_setup_redirect_action(struct net_device *filter_dev,
 	return 0;
 }
 
+static int
+ice_tc_setup_drop_action(struct net_device *filter_dev,
+			 struct ice_tc_flower_fltr *fltr)
+{
+	fltr->action.fltr_act = ICE_DROP_PACKET;
+
+	if (ice_is_port_repr_netdev(filter_dev)) {
+		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
+	} else if (ice_tc_is_dev_uplink(filter_dev)) {
+		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
+	} else {
+		NL_SET_ERR_MSG_MOD(fltr->extack,
+				   "Unsupported netdevice in switchdev mode");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 				       struct ice_tc_flower_fltr *fltr,
 				       struct flow_action_entry *act)
@@ -678,7 +697,10 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 
 	switch (act->id) {
 	case FLOW_ACTION_DROP:
-		fltr->action.fltr_act = ICE_DROP_PACKET;
+		err = ice_tc_setup_drop_action(filter_dev, fltr);
+		if (err)
+			return err;
+
 		break;
 
 	case FLOW_ACTION_REDIRECT:
-- 
2.31.1


