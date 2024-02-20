Return-Path: <netdev+bounces-73251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC6885B9B0
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8531D1F2497B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF4657CA;
	Tue, 20 Feb 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhqTOz8+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81762657D1
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426544; cv=none; b=N0FO+7Jn3Tn8v42BkEOdNxIU/dRn787r2X4KtgFK3nq3cLPkwC937CudmEUjM0YlJAVNS3Rwr0x/+ZAncP20wcJ0h7dYdvFaaNsSeNSYAgHK9gZOdJzqtEeSElPmwyGeLVg9RmlUlpEu4H+K8hQvbXwy8nadtkLo1AVJEQ5Id6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426544; c=relaxed/simple;
	bh=iXy9l0bdbeQqEXnZFJi+2J80dy5971br0gFmslEOHsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX/7JyQX91UHwkxH2uz7yKKjmcnEjmzGX/LPCfDMtXjfduCIphnj60gsQCbZNo9DyYngqQMoOw+gK3ybmWi9hj3nejIjF6VlVpEXepgzHxiu7gKH3z78voCkOcIQlvvo1QJRiTDJb5FIx3FG3TklsWjbMPw2f+eeJwRvysXuV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhqTOz8+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708426543; x=1739962543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXy9l0bdbeQqEXnZFJi+2J80dy5971br0gFmslEOHsE=;
  b=nhqTOz8+584CCsRdWBXVEGXHYgkHVpWzhsZpjWuK2OePLQ5rRb2Qu+Me
   1iApTlAe/U1SO9BlJ/xgo2V3Cw1i5S2b/HlNtYAISUOLSkQy50226G/QI
   7Smm8B2Y30izMVDdJ1GTOu2Jg7lY4ujfg9KVp/EAR5v9kWgrLvKFY3nWC
   xoqP7YxbAuyWrBWO0WBiJyQo1RCxCCXBaiVYcBvZ1hkKzP3AH6u/L+OXw
   JLDxQ1L1mT9qNCGBYYKvz25NHQ2SI0dXhLmqSksMZgrEYC3ySRbB2xKjr
   RwfeYHnsqG6N/HwrKkvHtuiClgXYczQ3PvwkL0/OOLuOC6sWsckyWVTiH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13934161"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13934161"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4734489"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2024 02:55:40 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [iwl-next v1 1/2] ice: tc: check src_vsi in case of traffic from VF
Date: Tue, 20 Feb 2024 11:59:49 +0100
Message-ID: <20240220105950.6814-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
References: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of traffic going from the VF (so ingress for port representor)
there should be a check for source VSI. It is needed for hardware to not
match packets from different port with filters added on other port.

It is only for "from VF" traffic, because other traffic direction
doesn't have source VSI.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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
2.42.0


