Return-Path: <netdev+bounces-73977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B985F84C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4731F26AC0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3512DD98;
	Thu, 22 Feb 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g80SNrB0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2912D779
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605340; cv=none; b=okPJ2Vz/zsoVVdc6vJ1exLYAXCB+jq9qaU7oGCeSFs3V0OX7jpbNk/gNYdyAs6AJmZwf+/RIVCmvDvOmdZrQPWVhlBgiKOIdbYGQPcwlouJuospouIZnqHxd7vNnVUeMrrVjnDh86ulZGi4+JAdSe2hxrteoONQBVgreocK/638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605340; c=relaxed/simple;
	bh=tZALNZCBnFmX5cXJHpLMa1vf4yJteiPE9BYCLjCMEV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHEQowzy97d6u1LTeJ2XNK4p7Pc/WZfudtTMQeX0H+hlX0XA8ItWcogii+IOZDIi72AMoNDvwlPcrWfe5/DhudmqDY2+ZhRVSHvMT2dgq2GuDXYOuHFj5XpIFCPenkiM37Y/izP2ARVFBXXQSrWkMv+1k3Nu4vlPk4zBYRqBvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g80SNrB0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708605339; x=1740141339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZALNZCBnFmX5cXJHpLMa1vf4yJteiPE9BYCLjCMEV4=;
  b=g80SNrB0V+sEIL8/UOwcAiDIpXf5dFJoSjQRsGv0EQC9+zSJkeZVI+fN
   a1X36/r3eEI7CiBfGBhI+cipQWchiFexbp/rUmebEhx/ruxWElCChRF9J
   hrAW1dcGmXQxAOdLejPw+e07Pljygms2qKyJcD0gwLuheNiNxj4fkWRWt
   XX0Ct6Yf/5tD+lK6nKUqZhK/a3/w295WZIXCFC0VJftf9VBrpR//oG+kr
   INbnw/J5E1uNjRgF2F/n1/ZvlYpy76eyheEd12x0dZuXXLaXAcP7JSQNg
   c+TF+2XsdoIwIg+XhEKrkkepO+5fKj2PQMpdbJShDeqZhZoqEaG1ONirL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28267854"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28267854"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:35:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10216251"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa005.jf.intel.com with ESMTP; 22 Feb 2024 04:35:37 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	pmenzel@molgen.mpg.de,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [iwl-next v2 1/2] ice: tc: check src_vsi in case of traffic from VF
Date: Thu, 22 Feb 2024 13:39:55 +0100
Message-ID: <20240222123956.2393-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


