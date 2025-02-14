Return-Path: <netdev+bounces-166346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41312A359CA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E49E16CBD6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB624C689;
	Fri, 14 Feb 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSAuQT2L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCC242908;
	Fri, 14 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524146; cv=none; b=RDrM8d81TAs7oFneiZ86ha/L2Wqx3eYCEvXQ2cxRgY/0eWPmD2MKsBwb+GT1IlFu1OoZ8EuZq3sZYVZanc7qmrypNW+w/suKdIpj7lUj+FfhaOY4h4Px69/swMuax0DtsdnqRuTe9E4z+YHoBNhR8ZPw4YAjm5PFUCMA0+wxV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524146; c=relaxed/simple;
	bh=+SSx3/ctdiG9A9qumt7VFQMFd0KSKxENjMKVcnqhLVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRweRPcrkkS9yS1Op+yBeHz8LsNC9tQLChpJYLfkWTm6AjEGRtFZnGGhBfCz0WbNthNLUz5UeI95K3irpB0pk4i63Z3kiCYw7oNtKtBxjjQ+bSxSchTOKPV4v1KwrzmWAZMTIQXbK/cICBv+EA5WmWCEqRYTdqLyRssLbX2FnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSAuQT2L; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524145; x=1771060145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+SSx3/ctdiG9A9qumt7VFQMFd0KSKxENjMKVcnqhLVo=;
  b=bSAuQT2Li4zE/RqIHiapLf+clLOiXi4aZitGo5K/r9phVbOIva+CKPNc
   SmankIWcYywmO6T78AamGogARy7uqJ20AgXXgYI87+meUdweDSFur6CX9
   d8Ivbig9J6svITZ1J3yAliYV9Tbfwqbecb5vbp0nLvcO9TW4mPHmW1/R0
   H1DCgR3PQk4tWD0F4gvRi1NLJOVOgvaLlDPeZ0IF2CJw4040lKWrEnahv
   cH/x03Oaa8Ytt4OvlAF16sRTmJBQYizBxGddMcb7Bpe3YoDOEZL7WQNM5
   EYAmhoIjNDkwFsueV3LuD2wd8CfEXH0U5WS9XTJMaH4Hr0FK4cET6JJkX
   g==;
X-CSE-ConnectionGUID: dfh14GkDR1OtaqprvFU0tw==
X-CSE-MsgGUID: 3/n7pqMLTM6OlLcnviPE4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65617731"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65617731"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:09:04 -0800
X-CSE-ConnectionGUID: fbkt04u1RDa2WOy+VAF0uA==
X-CSE-MsgGUID: Ehd8NKKNQPW4p0udW+uDVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113145485"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2025 01:09:01 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0A6BC37B80;
	Fri, 14 Feb 2025 09:08:59 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: [PATCH iwl-next v4 4/6] ice: remove headers argument from ice_tc_count_lkups
Date: Fri, 14 Feb 2025 09:50:38 +0100
Message-ID: <20250214085215.2846063-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214085215.2846063-1-larysa.zaremba@intel.com>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the headers argument from the ice_tc_count_lkups() function, because
it is not used anywhere.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index ea39b999a0d0..d8d28d74222a 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -12,14 +12,11 @@
 /**
  * ice_tc_count_lkups - determine lookup count for switch filter
  * @flags: TC-flower flags
- * @headers: Pointer to TC flower filter header structure
  * @fltr: Pointer to outer TC filter structure
  *
- * Determine lookup count based on TC flower input for switch filter.
+ * Return: lookup count based on TC flower input for a switch filter.
  */
-static int
-ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
-		   struct ice_tc_flower_fltr *fltr)
+static int ice_tc_count_lkups(u32 flags, struct ice_tc_flower_fltr *fltr)
 {
 	int lkups_cnt = 1; /* 0th lookup is metadata */
 
@@ -770,7 +767,6 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 static int
 ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 {
-	struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
 	struct ice_adv_rule_info rule_info = { 0 };
 	struct ice_rule_query_data rule_added;
 	struct ice_hw *hw = &vsi->back->hw;
@@ -785,7 +781,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		return -EOPNOTSUPP;
 	}
 
-	lkups_cnt = ice_tc_count_lkups(flags, headers, fltr);
+	lkups_cnt = ice_tc_count_lkups(flags, fltr);
 	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
 	if (!list)
 		return -ENOMEM;
@@ -985,7 +981,6 @@ static int
 ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 			   struct ice_tc_flower_fltr *tc_fltr)
 {
-	struct ice_tc_flower_lyr_2_4_hdrs *headers = &tc_fltr->outer_headers;
 	struct ice_adv_rule_info rule_info = {0};
 	struct ice_rule_query_data rule_added;
 	struct ice_adv_lkup_elem *list;
@@ -1021,7 +1016,7 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 			return PTR_ERR(dest_vsi);
 	}
 
-	lkups_cnt = ice_tc_count_lkups(flags, headers, tc_fltr);
+	lkups_cnt = ice_tc_count_lkups(flags, tc_fltr);
 	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
 	if (!list)
 		return -ENOMEM;
-- 
2.43.0


