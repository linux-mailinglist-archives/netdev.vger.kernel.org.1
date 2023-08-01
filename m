Return-Path: <netdev+bounces-23367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71376BB75
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF23D1C203D7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747CF23BD7;
	Tue,  1 Aug 2023 17:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5072359F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:37:45 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08352103
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911456; x=1722447456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fb/x6fZ/506s9dzkc268yQaU+4kqaUt9nAjbZ0edDjc=;
  b=dm3wSaUWS4JINdS2Z/Qxr3wlUjBVpWCn8emEiacbeuwdshzgB8TIodJ9
   saq/NkClEyYSwDPl6QSpGvPFrNrX5nSmegIAhlbL8XitUnYm347nACsNf
   ItNljUEbvjsU3UJlToteigHOxGzex2Av07t6sCvLffrGtorIQ3Sm3O3Qh
   VyMa8nHoGvOB9EKwZjvRrZbq+6/Clq3jpFhdRGMaAPa84izkCE8pUTFzE
   ZE3N+5dG7+PC9LFF30wAOV9l8i4AR1cput7Zg4N+naqXf38aBaCMyDkLL
   qy+KntCNsE1Wmbr9OJhtBe27HZJbs6h7klIp03RvJZKcotWl8eKS3kj/Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455740666"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455740666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798769694"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="798769694"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 10:37:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in br offload
Date: Tue,  1 Aug 2023 10:31:07 -0700
Message-Id: <20230801173112.3625977-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wojciech Drewek <wojciech.drewek@intel.com>

When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification
with vid = 1, it means that we have to offload untagged traffic.
This is achieved by adding vlan metadata lookup.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.38.1


