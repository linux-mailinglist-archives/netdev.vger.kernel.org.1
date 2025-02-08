Return-Path: <netdev+bounces-164338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FBA2D665
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 14:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF87188BE25
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6C2500C7;
	Sat,  8 Feb 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqOXPKiN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500C248164;
	Sat,  8 Feb 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739021896; cv=none; b=aQN7ur92GmUaxUFea8FnV1PaiCbexkGwE7knshQt3RalAvCQXz5SH3B/qWAj+9AFihWJ1EP6YuhZzmU8pmHyFMI+bvAjF9qcv18vBONGTU3/4gjRrMkoHWQarNOAIV8qci1MZMnU8PI2em5+WohHOZc0OZ13rygJ/BXHHcesyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739021896; c=relaxed/simple;
	bh=+gNRs1X2BAvlhEPkTgX809XWcuXH5nlbdN2f+T0v8jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIFDbQdccGM+zqsXzLjEngAzVOwGOLOfzKiwbXOSteZN8GagxnMow7laeH5J2rpsOtx3s979NNy53/0IyB5h/El+dOZX7I/RuHZD9XPQQ2SCF8EuP+IdcW1gOZouuNdnxBi168vT8zDWUgcgtxgGHkKU0gTyn6Hm4AdvRT4Mj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqOXPKiN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739021895; x=1770557895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gNRs1X2BAvlhEPkTgX809XWcuXH5nlbdN2f+T0v8jA=;
  b=XqOXPKiNF9KbSkp55qAyabH5oQyR3lK+CMIPMcoJfTilWlkJGaEQA8sa
   MUK5TASZ1stlCJdSAS7Mhqy86iUpzD/kk1pngetxGlIh2zkx+0Zwyozoo
   CtfqG5j4KkHeHF2LTNpinkmC4Pmqp6ML7KgQO/CDFlfPrQTq53kk7x6zJ
   fFA6rQwHtsEibWKYnVY2ug6KeDJVLSuzfqWbUm6Ky1im1eFby7D7U8bud
   6fzoI7x8ptu7AQpB+saogcknSVZVw5gJfj/z+pWQrcQofUrKaKriQOEb5
   kG9hagl52WfAT8YxmeBqPXF8L8glYLIlcLKzXIjnhpRU2dtHMIRQLQszx
   w==;
X-CSE-ConnectionGUID: 3OvcIqHsTTi/dmJ/6eK0qQ==
X-CSE-MsgGUID: G5I5B1HgS+SQhSH1YAVKSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51084831"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51084831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 05:38:14 -0800
X-CSE-ConnectionGUID: QZeZotDHRUWleoQxd74qAA==
X-CSE-MsgGUID: kTyzdcQGS5OuN4zRiSpwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116980876"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 08 Feb 2025 05:38:11 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6733832C91;
	Sat,  8 Feb 2025 13:38:10 +0000 (GMT)
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
Subject: [PATCH iwl-next v3 4/6] ice: remove headers argument from ice_tc_count_lkups
Date: Sat,  8 Feb 2025 14:22:45 +0100
Message-ID: <20250208132251.1989365-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208132251.1989365-1-larysa.zaremba@intel.com>
References: <20250208132251.1989365-1-larysa.zaremba@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index ea39b999a0d0..2acc9ea5b98b 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -12,14 +12,11 @@
 /**
  * ice_tc_count_lkups - determine lookup count for switch filter
  * @flags: TC-flower flags
- * @headers: Pointer to TC flower filter header structure
  * @fltr: Pointer to outer TC filter structure
  *
  * Determine lookup count based on TC flower input for switch filter.
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


