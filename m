Return-Path: <netdev+bounces-22200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC9766735
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113E428271D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2500AD305;
	Fri, 28 Jul 2023 08:33:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985BC8CB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:33:36 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926383A97
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690533215; x=1722069215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hnc0lMNk+anUERBMUxuJAA1oybg5268RVleOUAuDplc=;
  b=E1SWMzCsyZLHAOGftB5FVgiQDcTh9QEMxdTea4NbElBzyGgOMfzlmm1Z
   jGeDfbX3c5GWewQI1ykx2BDnNtv4Rre9JN8sCo9IGEClqAMxks00AyT4X
   A7gQwq92AI7zLNePmrmvr+QJe1Ft9y6iKl5rDb5sD+9w8MI1g07SHFjDv
   HhCoblVnpx2quxIaMcZCCngBNR+289QVSi+mmnoGZXRleAN9eKL1hEHnP
   Ys3ZRoTBrqPuTltEoRYZZCJpw0KCL29fLwibSvr9/nPtTPGEvcWStDEpd
   qdVwUvp0z/tYiehHMS3qkmcMOY0F8ZgyJP6Aq+mOreES8EhU0SzdFbeWd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348822849"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348822849"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797361920"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="797361920"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2023 01:32:02 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D4FE437E09;
	Fri, 28 Jul 2023 09:32:01 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: [PATCH iwl-next v2] ice: Support untagged VLAN traffic in br offload
Date: Fri, 28 Jul 2023 10:30:42 +0200
Message-Id: <20230728083042.13326-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification
with vid = 1, it means that we have to offload untagged traffic.
This is achieved by adding vlan metadata lookup.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: remove unrelated changes, fix typos, add comment in
    ice_eswitch_br_get_lkups_cnt
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 10 +++++++---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h |  9 ---------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 67bfd1f61cdd..5b425260b0eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -104,13 +104,18 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
 static u16
 ice_eswitch_br_get_lkups_cnt(u16 vid)
 {
-	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
+	/* if vid == 0 then we need only one lookup (ICE_MAC_OFOS),
+	 * otherwise we need both mac and vlan
+	 */
+	return vid == 0 ? 1 : 2;
 }
 
 static void
 ice_eswitch_br_add_vlan_lkup(struct ice_adv_lkup_elem *list, u16 vid)
 {
-	if (ice_eswitch_br_is_vid_valid(vid)) {
+	if (vid == 1) {
+		ice_rule_add_vlan_metadata(&list[1]);
+	} else if (vid > 1) {
 		list[1].type = ICE_VLAN_OFOS;
 		list[1].h_u.vlan_hdr.vlan = cpu_to_be16(vid & VLAN_VID_MASK);
 		list[1].m_u.vlan_hdr.vlan = cpu_to_be16(0xFFFF);
@@ -400,7 +405,6 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
 	unsigned long event;
 	int err;
 
-	/* untagged filtering is not yet supported */
 	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
 		return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index 85a8fadb2928..cf7b0e5acfcb 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -103,15 +103,6 @@ struct ice_esw_br_vlan {
 		     struct ice_esw_br_fdb_work, \
 		     work)
 
-static inline bool ice_eswitch_br_is_vid_valid(u16 vid)
-{
-	/* In trunk VLAN mode, for untagged traffic the bridge sends requests
-	 * to offload VLAN 1 with pvid and untagged flags set. Since these
-	 * flags are not supported, add a MAC filter instead.
-	 */
-	return vid > 1;
-}
-
 void
 ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
 int
-- 
2.40.1


