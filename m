Return-Path: <netdev+bounces-110914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C114D92EE93
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40EE1C21DD0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0C16EB4B;
	Thu, 11 Jul 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ+T+pX7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484C16E88B
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721612; cv=none; b=uI6LNVJVPSd3/PpWpojyxvZVvcT+/XZewJaZT3PaRw1guwfLCCf+gsJx73JARBiFOXPhSsFSJANl2scynWUssO9CF/9luHjfck0I7QTEFY2m4phRS2pZwRtkV6WlDIhGz1i+MD8rjKIMFZNgXSv6HoIaCNgVg0DaLVQF0F97at0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721612; c=relaxed/simple;
	bh=sCfYxBmI4hr9eAH9PjCrqVz78NpcvTnAWifJc1GIHOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWuDnGhg8FRowibIY+I411dGS3WGakxsDJmYTcK+Nzg00OvSvi3TGrL8GznZdSj8O7MleIgnKuIGwmPkkRW1EWt1VroX169Pjkcfvqkx/jhR4MsRSKYiLXfFi6idwu+SluXjA5T8DJfGAPJ336mtbnr6flEGl7JZZ0J0hUUQ37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ+T+pX7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721611; x=1752257611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sCfYxBmI4hr9eAH9PjCrqVz78NpcvTnAWifJc1GIHOw=;
  b=DZ+T+pX7bME92N4B91FEWztwfr5sjh4aUMuFFyiL73yf6TpUyPk2jSEr
   nGauUE4v8jTrykOG9QLC3Q4JGizXXHxmVSh6nBXPicR72I52071NMFbij
   2IlAEOKe+DHOBEuphUlgwDyTA8QcnGFw5GYZSUWnplxpiDCnvikGc9X/X
   cJcjCdjLaltw2uwx+s7h3NRtFJnPrU+dJtXrtZvfWbPW9a+ZyETTx9b7d
   oWSIQ6wOvFN640tcDCZKfN7WCOkHimECWGOmx6nfOwUwfMTGNOt91S4R8
   CiiEy6w+WF2NmB8QPSsV7KMViuqCX19cdiXStm19Un152ShnKyjq33BMW
   Q==;
X-CSE-ConnectionGUID: PsF6zNFjT5KFEmWnRxmXrQ==
X-CSE-MsgGUID: u1i3QR0HRrCwgjGb9uwUPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28720979"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28720979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:13:29 -0700
X-CSE-ConnectionGUID: 9PgVX/JtTaurjVG/A7TwKA==
X-CSE-MsgGUID: hl2axdXGTaiZHe6/iFBh9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48390923"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2024 11:13:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 7/7] ice: Add tracepoint for adding and removing switch rules
Date: Thu, 11 Jul 2024 11:13:10 -0700
Message-ID: <20240711181312.2019606-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
References: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Track the number of rules and recipes added to switch. Add a tracepoint to
ice_aq_sw_rules(), which shows both rule and recipe count. This information
can be helpful when designing a set of rules to program to the hardware, as
it shows where the practical limit is. Actual limits are known (64 recipes,
32k rules), but it's hard to translate these values to how many rules the
*user* can actually create, because of extra metadata being implicitly
added, and recipe/rule chaining. Chaining combines several recipes/rules to
create a larger recipe/rule, so one large rule added by the user might
actually consume multiple rules from hardware perspective.

Rule counter is simply incremented/decremented in ice_aq_sw_rules(), since
all rules are added or removed via it.

Counting recipes is harder, as recipes can't be removed (only overwritten).
Recipes added via ice_aq_add_recipe() could end up being unused, when
there is an error in later stages of rule creation. Instead, track the
allocation and freeing of recipes, which should reflect the actual usage of
recipes (if something fails after recipe(s) were created, caller should
free them). Also, a number of recipes are loaded from NVM by default -
initialize the recipe counter with the number of these recipes on switch
initialization.

Example configuration:
  cd /sys/kernel/tracing
  echo function > current_tracer
  echo ice_aq_sw_rules > set_ftrace_filter
  echo ice_aq_sw_rules > set_event
  echo 1 > tracing_on
  cat trace

Example output:
  tc-4097    [069] ...1.   787.595536: ice_aq_sw_rules <-ice_rem_adv_rule
  tc-4097    [069] .....   787.595705: ice_aq_sw_rules: rules=9 recipes=15
  tc-4098    [057] ...1.   787.652033: ice_aq_sw_rules <-ice_add_adv_rule
  tc-4098    [057] .....   787.652201: ice_aq_sw_rules: rules=10 recipes=16

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_switch.c | 22 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_trace.h  | 18 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 ++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e77261704ee4..c1a364174a47 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -934,6 +934,9 @@ static int ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 	INIT_LIST_HEAD(&sw->vsi_list_map_head);
 	sw->prof_res_bm_init = 0;
 
+	/* Initialize recipe count with default recipes read from NVM */
+	sw->recp_cnt = ICE_SW_LKUP_LAST;
+
 	status = ice_init_def_sw_recp(hw);
 	if (status) {
 		devm_kfree(ice_hw_to_dev(hw), hw->switch_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 27828cdfe085..3caafcdc301f 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3,6 +3,7 @@
 
 #include "ice_lib.h"
 #include "ice_switch.h"
+#include "ice_trace.h"
 
 #define ICE_ETH_DA_OFFSET		0
 #define ICE_ETH_ETHTYPE_OFFSET		12
@@ -1961,6 +1962,15 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16 rule_list_sz,
 	    hw->adminq.sq_last_status == ICE_AQ_RC_ENOENT)
 		status = -ENOENT;
 
+	if (!status) {
+		if (opc == ice_aqc_opc_add_sw_rules)
+			hw->switch_info->rule_cnt += num_rules;
+		else if (opc == ice_aqc_opc_remove_sw_rules)
+			hw->switch_info->rule_cnt -= num_rules;
+	}
+
+	trace_ice_aq_sw_rules(hw->switch_info);
+
 	return status;
 }
 
@@ -2181,8 +2191,10 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 	sw_buf->res_type = cpu_to_le16(res_type);
 	status = ice_aq_alloc_free_res(hw, sw_buf, buf_len,
 				       ice_aqc_opc_alloc_res);
-	if (!status)
+	if (!status) {
 		*rid = le16_to_cpu(sw_buf->elem[0].e.sw_resp);
+		hw->switch_info->recp_cnt++;
+	}
 
 	return status;
 }
@@ -2196,7 +2208,13 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
  */
 static int ice_free_recipe_res(struct ice_hw *hw, u16 rid)
 {
-	return ice_free_hw_res(hw, ICE_AQC_RES_TYPE_RECIPE, 1, &rid);
+	int status;
+
+	status = ice_free_hw_res(hw, ICE_AQC_RES_TYPE_RECIPE, 1, &rid);
+	if (!status)
+		hw->switch_info->recp_cnt--;
+
+	return status;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 244cddd2a9ea..07aab6e130cd 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -330,6 +330,24 @@ DEFINE_EVENT(ice_esw_br_port_template,
 	     TP_ARGS(port)
 );
 
+DECLARE_EVENT_CLASS(ice_switch_stats_template,
+		    TP_PROTO(struct ice_switch_info *sw_info),
+		    TP_ARGS(sw_info),
+		    TP_STRUCT__entry(__field(u16, rule_cnt)
+				     __field(u8, recp_cnt)),
+		    TP_fast_assign(__entry->rule_cnt = sw_info->rule_cnt;
+				   __entry->recp_cnt = sw_info->recp_cnt;),
+		    TP_printk("rules=%u recipes=%u",
+			      __entry->rule_cnt,
+			      __entry->recp_cnt)
+);
+
+DEFINE_EVENT(ice_switch_stats_template,
+	     ice_aq_sw_rules,
+	     TP_PROTO(struct ice_switch_info *sw_info),
+	     TP_ARGS(sw_info)
+);
+
 /* End tracepoints */
 
 #endif /* _ICE_TRACE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index e26ae79578ba..cf3cddbae23b 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -761,6 +761,8 @@ struct ice_switch_info {
 	struct ice_sw_recipe *recp_list;
 	u16 prof_res_bm_init;
 	u16 max_used_prof_index;
+	u16 rule_cnt;
+	u8 recp_cnt;
 
 	DECLARE_BITMAP(prof_res_bm[ICE_MAX_NUM_PROFILES], ICE_MAX_FV_WORDS);
 };
-- 
2.41.0


