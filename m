Return-Path: <netdev+bounces-88467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8995B8A757C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3833F28260B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155013A259;
	Tue, 16 Apr 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fN9x6vCe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C12C6A3
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299056; cv=none; b=JJi/769rVK9bNeuQbImJ1xykXHfUt0zvDdJqq4ou8+r+//DuAJ4Q43PYAVLqkjb5Z0B7ZSnQL0kd22xoHOJ22zw1Cbm45B4GMoBvBn+Hn0uFNG3syz/V8SOzCQoYsl1KWprTfllk/SNiupScVNkxfY295KwDYoVHTkz8LzOgXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299056; c=relaxed/simple;
	bh=UcRGENiElOE3qzcdU/4RPooTRbe/+e99fKpJg3x8zNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz1Jmzv3SmsLSqata6mrhz8GBqXN8YSZ7vCVwMneuUNfnjE/7PBSKIgRRIvHeqWA0cJ5KlpFjpXJdc0FPzHRNn64WADLDX4yLc7vq6gznsvtg8rvOiDVNXFhRweIe4vAPLYry1x7alaAQ4x3D6DYqwGS3SUxOs1oR8+UsJR/deM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fN9x6vCe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713299054; x=1744835054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcRGENiElOE3qzcdU/4RPooTRbe/+e99fKpJg3x8zNI=;
  b=fN9x6vCeZWwcYg6IXWga7tV/Lun39w7t0VuwiTiDAZPqPHWUSzwPwqrL
   hJRI8QVvihT7NeTD62jKbaiYIAJ8F7fF5VnPx78X27d5mOLAQ4uKS3agh
   USs7BzmrqdPPC8Ayy413APEUpcKsougjp4CYsjQ/4E28JZqzC62b2PmMt
   4HTStTkdDEk7H9d/1qqTbdifgWeyeSikIPtIoCEUTA1bUdcFE3WDO/RSP
   05qOW/0e35WH346lz7wEnXXlU8jBuQxmw6Lf5fDxwpFO9N0kMGxfc8yNH
   mRlY0DP5WeIbwZGtYv0whpfF3IZUNVDetjJQUWEDmBrjiGR7Iiv/gVhBb
   w==;
X-CSE-ConnectionGUID: 8dhvhZqwS8utnpbB+2Fr+g==
X-CSE-MsgGUID: Vgoc8AIARje1sYiofNqytA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8688450"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8688450"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:24:12 -0700
X-CSE-ConnectionGUID: wiLs3sAaRfW/KgEaKIC5lQ==
X-CSE-MsgGUID: zwMokgu4SQm/336KJFykLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26941870"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2024 13:24:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 1/3] ice: tc: check src_vsi in case of traffic from VF
Date: Tue, 16 Apr 2024 13:24:06 -0700
Message-ID: <20240416202409.2008383-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
References: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case of traffic going from the VF (so ingress for port representor)
source VSI should be consider during packet classification. It is
needed for hardware to not match packets from different ports with
filters added on other port.

It is only for "from VF" traffic, because other traffic direction
doesn't have source VSI.

Set correct ::src_vsi in rule_info to pass it to the hardware filter.

For example this rule should drop only ipv4 packets from eth10, not from
the others VF PRs. It is needed to check source VSI in this case.
$tc filter add dev eth10 ingress protocol ip flower skip_sw action drop

Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index b890410a2bc0..49ed5fd7db10 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -28,6 +28,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
 	 * - ICE_TC_FLWR_FIELD_VLAN_TPID (present if specified)
 	 * - Tunnel flag (present if tunnel)
 	 */
+	if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS)
+		lkups_cnt++;
 
 	if (flags & ICE_TC_FLWR_FIELD_TENANT_ID)
 		lkups_cnt++;
@@ -363,6 +365,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 	/* Always add direction metadata */
 	ice_rule_add_direction_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
 
+	if (tc_fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
+		ice_rule_add_src_vsi_metadata(&list[i]);
+		i++;
+	}
+
 	rule_info->tun_type = ice_sw_type_from_tunnel(tc_fltr->tunnel_type);
 	if (tc_fltr->tunnel_type != TNL_LAST) {
 		i = ice_tc_fill_tunnel_outer(flags, tc_fltr, list, i);
@@ -820,6 +827,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 
 	/* specify the cookie as filter_rule_id */
 	rule_info.fltr_rule_id = fltr->cookie;
+	rule_info.src_vsi = vsi->idx;
 
 	ret = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, &rule_added);
 	if (ret == -EEXIST) {
-- 
2.41.0


