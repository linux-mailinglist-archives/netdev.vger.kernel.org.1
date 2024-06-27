Return-Path: <netdev+bounces-107353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38F91A9FB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA471F235AE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E881198A08;
	Thu, 27 Jun 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsLygTB6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5054198850
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500080; cv=none; b=s1L8V3Q6yWAYrR5HQVqh25HJZA+U/tRgTK7FU+ytu+w9Ryv+muyZ/SEdli3FhKkk7U8Oeq8y3fjpzU1Z8Z3Pv8M5VDUTtzu5tXTsAp7K+jmwN8c8jT/lrgQkgclVopQjBO1f76kPlQsdTpSghqJj90gWxLfCPHFBN2Cn7TQMgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500080; c=relaxed/simple;
	bh=eoFfAXCTy1Wvfh0fDOYD0+Dn9bIrke38elVoLryAzMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDN219oaqHx6ZL+VAd2DUuOMntjp6Pbe4TTTNSaUMtSLLxo0lGZ6LdQFqio8mya2sPB5gNp9COxsoaaWQZOZ9gnlrIQTLX/7ieprA5iA/OgQQXOzU4Ol/hI7KS5+CisHqObkWb+2wHrbPxe9Oujd4C7c7iOKry8GRrnoXCbADvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PsLygTB6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719500079; x=1751036079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoFfAXCTy1Wvfh0fDOYD0+Dn9bIrke38elVoLryAzMc=;
  b=PsLygTB6bby+tN+PI4WRnDPB3qbXOFCqQoikj3KG14PDVBx1jJwMebMh
   O68z38xy7ewMR8CBaDkCuqmrEhNme3Lin+66ihGzNE3LrBjKibm09DKKM
   IQ+401BflW6d5LRaLBaqPKpUkjZ0zFByQ92K8dxXkw4I/FFKr2mSuXEJs
   uDRwuuP7xnOEyg5c9kO0IMruf7yBoUCe8VNdxW6syvNec2Ytr/+wojL6+
   sUh+RmRju640DQtooGHEf0ZmITgaSouEn+toOi3i0MC7D5O5qM8lXdYco
   CYcmHCG329ULM5MRfOEmF25h9+jvgm14H2LZ9BQuO3y1RIuPh3yTaYfKN
   w==;
X-CSE-ConnectionGUID: 05CtDoaTQJ2IWcv8yyyMXA==
X-CSE-MsgGUID: A0cd8qkSRFqwCS0zVVkhVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20514986"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20514986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:54:32 -0700
X-CSE-ConnectionGUID: pkBbbH5cQUKENspAzaWiFw==
X-CSE-MsgGUID: FgbLce8sQKWsLEmGAnGdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="67616408"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jun 2024 07:54:31 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C0B5627BCC;
	Thu, 27 Jun 2024 15:54:16 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	pmenzel@molgen.mpg.de,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v3 7/7] ice: Add tracepoint for adding and removing switch rules
Date: Thu, 27 Jun 2024 16:55:47 +0200
Message-ID: <20240627145547.32621-8-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
References: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

---
v3: Added example configuration and output
---
 drivers/net/ethernet/intel/ice/ice_common.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_switch.c | 22 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_trace.h  | 18 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 ++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6abd1b3796ab..009716a12a26 100644
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
index c330a436d11a..b6bc2de53b0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -764,6 +764,8 @@ struct ice_switch_info {
 	struct ice_sw_recipe *recp_list;
 	u16 prof_res_bm_init;
 	u16 max_used_prof_index;
+	u16 rule_cnt;
+	u8 recp_cnt;
 
 	DECLARE_BITMAP(prof_res_bm[ICE_MAX_NUM_PROFILES], ICE_MAX_FV_WORDS);
 };
-- 
2.45.0


