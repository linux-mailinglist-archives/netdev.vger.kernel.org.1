Return-Path: <netdev+bounces-21324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E139076344A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4FA1C21238
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08674CA64;
	Wed, 26 Jul 2023 10:52:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093ECA60
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:52:15 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4FE63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690368733; x=1721904733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zEFXQIDnbqzGy3klfE8pIw+vAiyG1hyleWZ8itQcZUk=;
  b=IX/kFH8bn8qj8F0urs937JkcPe+VHtDqugYuLBEI4dlEUi/0yHNrHwbd
   lWFolXq5bG7P1b8cS46EWtOmZWAmHNeZmE59tZ9pXpkk0/WSL+o/sOHe2
   P1+Wgr+v3YhZlZxpQHvMYi2fWHeXb0ORvqMITfNGQC3MQI5q1Jb6baiaW
   z7EFDZxrQBiJj3DQdi65YLJUj5Xn1xy5blWl8yftlpYE2o9PQl/P8ATdC
   rYbHRz4PBtS3NafE4JiDcYQkG+FH5wu7V1N4QkWNTvN0wPmViufsD8exM
   etRm0vnTAMPN0+/CbZEuOnIOfSMF5u3tR9AQ5u0urxnAsNp4+cWDQkkAt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="371589238"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="371589238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 03:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791799202"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791799202"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 03:52:11 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5CBE634904;
	Wed, 26 Jul 2023 11:52:10 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	marcin.szycik@linux.intel.com
Subject: [PATCH net-next] ice: VLAN untagged traffic support
Date: Wed, 26 Jul 2023 12:50:54 +0200
Message-Id: <20230726105054.295220-1-wojciech.drewek@intel.com>
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

When driver recives SWITCHDEV_FDB_ADD_TO_DEVICE notification
with vid = 1, it means that we have to offload untagged traffic.
This is achieved by adding vlan metadata lookup.

Also remove unnecessary brackets in ice_eswitch_br_fdb_entry_create.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 9 +++++----
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h | 9 ---------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 67bfd1f61cdd..05bee706b946 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -104,13 +104,15 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
 static u16
 ice_eswitch_br_get_lkups_cnt(u16 vid)
 {
-	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
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
@@ -400,11 +402,10 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
 	unsigned long event;
 	int err;
 
-	/* untagged filtering is not yet supported */
 	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
 		return;
 
-	if ((bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING)) {
+	if (bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) {
 		vlan = ice_esw_br_port_vlan_lookup(bridge, br_port->vsi_idx,
 						   vid);
 		if (IS_ERR(vlan)) {
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


