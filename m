Return-Path: <netdev+bounces-25127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F27730B6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C101F280E9B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8664174F7;
	Mon,  7 Aug 2023 20:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28B174C2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:55:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4233510F3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691441716; x=1722977716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=19WZSssXwkCl1X0P35cFsuqJS24ENiDK92aSvIFbmtY=;
  b=O3T0TF61IcQPphFmsnRyMjkZhUOk0HRkL9YVTtpOmTQPQUdAOcfqdKHr
   Cl/JNjzMWUQdy/HrFJdQPvDmtDAwjqWlB6FbP0Z7eQ4axTcpAsb+RZuLO
   9e42GvfiyH6bu44q5xKhIigcv80j5U5LUTlWwZRUfvO1B0/G1WlcsU+1D
   uR2UvIBaRfi5LMBzs+3K4l3jUV3ASSR3CiO4Efhl3TaeHGj87hSq6RV/4
   9sL8VdmYu3cGMNeUnfk3TzsLkydf1UfiQcTC1+7cTWSPAC7JRKjjHkmEq
   GHXVHeccG3CBqR7Zp3Az+ArepIaGcNnefj5iGuKZc/ivwqSP5ccayRPY5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350952453"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="350952453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734226837"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="734226837"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2023 13:55:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <simon.horman@corigine.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next v2 2/6] ice: Add direction metadata
Date: Mon,  7 Aug 2023 13:48:31 -0700
Message-Id: <20230807204835.3129164-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230807204835.3129164-1-anthony.l.nguyen@intel.com>
References: <20230807204835.3129164-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Currently it is possible to create a filter which breaks TX traffic, e.g.:

tc filter add dev $PF1 ingress protocol ip prio 1 flower ip_proto udp
dst_port $PORT action mirred egress redirect dev $VF1_PR

This adds a rule which might match both TX and RX traffic, and in TX path
the PF will actually receive the traffic, which breaks communication.

To fix this, add a match on direction metadata flag when adding a tc rule.

Because of the way metadata is currently handled, a duplicate lookup word
would appear if VLAN metadata is also added. The lookup would still work
correctly, but one word would be wasted. To prevent it, lookup 0 now always
contains all metadata. When any metadata needs to be added, it is added to
lookup 0 and lookup count is not incremented. This way, two flags residing
in the same word will take up one word, instead of two.

Note: the drop action is also affected, i.e. it will now only work in one
direction.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/ice_protocol_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.c   | 11 ++++--
 drivers/net/ethernet/intel/ice/ice_switch.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 34 +++++++++----------
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 6a9364761165..9812b98d107f 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -287,6 +287,7 @@ struct ice_nvgre_hdr {
  * M = EVLAN (0x8100) - Outer L2 header has EVLAN (ethernet type 0x8100)
  * N = EVLAN (0x9100) - Outer L2 header has EVLAN (ethernet type 0x9100)
  */
+#define ICE_PKT_FROM_NETWORK	BIT(3)
 #define ICE_PKT_VLAN_STAG	BIT(12)
 #define ICE_PKT_VLAN_ITAG	BIT(13)
 #define ICE_PKT_VLAN_EVLAN	(BIT(14) | BIT(15))
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 91bc92f5059b..dcbb69bc9f5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6058,14 +6058,21 @@ ice_adv_add_update_vsi_list(struct ice_hw *hw,
 void ice_rule_add_tunnel_metadata(struct ice_adv_lkup_elem *lkup)
 {
 	lkup->type = ICE_HW_METADATA;
-	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_TUNNEL] =
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_TUNNEL] |=
 		cpu_to_be16(ICE_PKT_TUNNEL_MASK);
 }
 
+void ice_rule_add_direction_metadata(struct ice_adv_lkup_elem *lkup)
+{
+	lkup->type = ICE_HW_METADATA;
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_VLAN] |=
+		cpu_to_be16(ICE_PKT_FROM_NETWORK);
+}
+
 void ice_rule_add_vlan_metadata(struct ice_adv_lkup_elem *lkup)
 {
 	lkup->type = ICE_HW_METADATA;
-	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_VLAN] =
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_VLAN] |=
 		cpu_to_be16(ICE_PKT_VLAN_MASK);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 250823ac173a..0bd4320e39df 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -359,6 +359,7 @@ int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id);
 
 /* Switch/bridge related commands */
 void ice_rule_add_tunnel_metadata(struct ice_adv_lkup_elem *lkup);
+void ice_rule_add_direction_metadata(struct ice_adv_lkup_elem *lkup);
 void ice_rule_add_vlan_metadata(struct ice_adv_lkup_elem *lkup);
 void ice_rule_add_src_vsi_metadata(struct ice_adv_lkup_elem *lkup);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 38547db1ec4e..37b54db91df2 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -7,6 +7,8 @@
 #include "ice_lib.h"
 #include "ice_protocol_type.h"
 
+#define ICE_TC_METADATA_LKUP_IDX 0
+
 /**
  * ice_tc_count_lkups - determine lookup count for switch filter
  * @flags: TC-flower flags
@@ -19,7 +21,13 @@ static int
 ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
 		   struct ice_tc_flower_fltr *fltr)
 {
-	int lkups_cnt = 0;
+	int lkups_cnt = 1; /* 0th lookup is metadata */
+
+	/* Always add metadata as the 0th lookup. Included elements:
+	 * - Direction flag (always present)
+	 * - ICE_TC_FLWR_FIELD_VLAN_TPID (present if specified)
+	 * - Tunnel flag (present if tunnel)
+	 */
 
 	if (flags & ICE_TC_FLWR_FIELD_TENANT_ID)
 		lkups_cnt++;
@@ -54,10 +62,6 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
 	if (flags & (ICE_TC_FLWR_FIELD_VLAN | ICE_TC_FLWR_FIELD_VLAN_PRIO))
 		lkups_cnt++;
 
-	/* is VLAN TPID specified */
-	if (flags & ICE_TC_FLWR_FIELD_VLAN_TPID)
-		lkups_cnt++;
-
 	/* is CVLAN specified? */
 	if (flags & (ICE_TC_FLWR_FIELD_CVLAN | ICE_TC_FLWR_FIELD_CVLAN_PRIO))
 		lkups_cnt++;
@@ -84,10 +88,6 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
 		     ICE_TC_FLWR_FIELD_SRC_L4_PORT))
 		lkups_cnt++;
 
-	/* matching for tunneled packets in metadata */
-	if (fltr->tunnel_type != TNL_LAST)
-		lkups_cnt++;
-
 	return lkups_cnt;
 }
 
@@ -176,10 +176,9 @@ static u16 ice_check_supported_vlan_tpid(u16 vlan_tpid)
 
 static int
 ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
-			 struct ice_adv_lkup_elem *list)
+			 struct ice_adv_lkup_elem *list, int i)
 {
 	struct ice_tc_flower_lyr_2_4_hdrs *hdr = &fltr->outer_headers;
-	int i = 0;
 
 	if (flags & ICE_TC_FLWR_FIELD_TENANT_ID) {
 		u32 tenant_id;
@@ -329,8 +328,7 @@ ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
 	}
 
 	/* always fill matching on tunneled packets in metadata */
-	ice_rule_add_tunnel_metadata(&list[i]);
-	i++;
+	ice_rule_add_tunnel_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
 
 	return i;
 }
@@ -358,13 +356,16 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 	struct ice_tc_flower_lyr_2_4_hdrs *headers = &tc_fltr->outer_headers;
 	bool inner = false;
 	u16 vlan_tpid = 0;
-	int i = 0;
+	int i = 1; /* 0th lookup is metadata */
 
 	rule_info->vlan_type = vlan_tpid;
 
+	/* Always add direction metadata */
+	ice_rule_add_direction_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
+
 	rule_info->tun_type = ice_sw_type_from_tunnel(tc_fltr->tunnel_type);
 	if (tc_fltr->tunnel_type != TNL_LAST) {
-		i = ice_tc_fill_tunnel_outer(flags, tc_fltr, list);
+		i = ice_tc_fill_tunnel_outer(flags, tc_fltr, list, i);
 
 		headers = &tc_fltr->inner_headers;
 		inner = true;
@@ -431,8 +432,7 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 		rule_info->vlan_type =
 				ice_check_supported_vlan_tpid(vlan_tpid);
 
-		ice_rule_add_vlan_metadata(&list[i]);
-		i++;
+		ice_rule_add_vlan_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
 	}
 
 	if (flags & (ICE_TC_FLWR_FIELD_CVLAN | ICE_TC_FLWR_FIELD_CVLAN_PRIO)) {
-- 
2.38.1


