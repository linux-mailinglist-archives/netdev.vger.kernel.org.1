Return-Path: <netdev+bounces-293926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHizHcYgHmrmhQkAu9opvQ
	(envelope-from <netdev+bounces-293926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:16:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD2626807
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29CB3037E63
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1F2E62B3;
	Tue,  2 Jun 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsGahvJI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85448264619
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359333; cv=none; b=V/mLr5mYA1EaDOgEcVv/fPHq4f8Jd0j+YEFlYNlTSglgqTD5F1jqA3hWQR7fJqXdDfjdKtV+CsWesK4bpbWFx0xB5Z6OtPUlOBpLpmdwzIOvK6KLbVobO30jAXr2Rt7k9xUDc+95N/SkXC+V4t7/iV+QJbbeb8aS04bnareglvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359333; c=relaxed/simple;
	bh=3dgMEJWOCpdkTidhqhCeFwMgeKYxmPG93+bJU5TqogE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6VKqSUAAbCcOKqxSya9Q+1iTdIOh9AgnoA7NXFgRoH8Fv0STRGHXNkUOJHy11ClzEsWSOdNbQfrC+tEsUg/lM7y197XFXeEueO7lSE+m5iP/YSNkuVGRHLADADr3nN/RF3ql+7CGoZ9erlnDT+hpohMh/tmqZCu5FDIKM9CIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsGahvJI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359332; x=1811895332;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3dgMEJWOCpdkTidhqhCeFwMgeKYxmPG93+bJU5TqogE=;
  b=SsGahvJItn10X0+iaHSawc9BDg2CKpQzX5FZbJi+dyS+Bi8p4e4gJhXx
   fffrM//N8V53JGUWzlfW30YyV/MXAJNbGKgkQjrXngGvNKMmgFwKISyCq
   jtbYMzFzvBBE4r3uC9h+C6hw1jDRMK5ctNO6jKva7cOahelJRRVQEL9Hv
   DQxvt2SRrqe2mJfcNku9Ai7vu0Wd6UG+PM9alDh6xBzN1jzhO5llIoLdC
   0qu22dwbuwimNMWz3qCKk6W8G4BjSONSJ7W/gJqVuHQ+roUfg8jQVlVDw
   P7HgOqOdv9UnWhT5jJ8B6hMll4uLS+qihMhP+8PRj8nzQ8a3h/wm8aJiS
   w==;
X-CSE-ConnectionGUID: sGkopMA2SJymR7Td5v7VcA==
X-CSE-MsgGUID: vZRKNdDBQYGh71nF7Fc/+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84755423"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84755423"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
X-CSE-ConnectionGUID: fbtR9wcRRsmpY7gj58MGsw==
X-CSE-MsgGUID: tkRitGPIT9iEIxr7FCyRsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267598722"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 01 Jun 2026 17:14:20 -0700
Subject: [PATCH iwl-next 3/6] ice: extract function to allocate aggregator
 info structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-3-36d6ecbe5ede@intel.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3567;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=3dgMEJWOCpdkTidhqhCeFwMgeKYxmPG93+bJU5TqogE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiw5hQU5341/vZt+V2jL98hkmajLufd6zizg4ihzPCL84
 oTCTj7XjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaSf4uR4cyGO2yreJs0dJ75
 nlJy/Mpexa1SEcNsujDpxJrEZJ+Dzgx/5Ryzw70FtZ9furxRJXy9e82rDGeh4JhXReoPxM48zVH
 gBgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293926-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: E6AD2626807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new ice_alloc_agg_info() helper function which allocates an
aggregator info structure with an ID between min_id and max_id, inserting
it into the agg_list xarray. Use this function in ice_sched_cfg_agg().

This is done in preparation of refactoring the aggregator node ID logic in
ice_set_agg_vsi().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 74 +++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index bfca45f5c53c..88392ebf4454 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2693,6 +2693,54 @@ ice_sched_add_agg_cfg(struct ice_port_info *pi, u32 agg_id, u8 tc)
 	return 0;
 }
 
+/**
+ * ice_alloc_agg_info - Allocate aggregator info structure
+ * @hw: pointer to the HW structure
+ * @min_id: the minimum ID to allocate
+ * @max_id: the maximum ID to allocate
+ * @agg_type: the aggregator node type
+ *
+ * Allocates a new aggregator info structure with an ID between min_id and
+ * max_id, inserting it into the agg_list xarray. If an exact ID is required,
+ * use the same value for both min_id and max_id.
+ *
+ * Context: Must be called while holding the scheduler lock.
+ *
+ * Return: the allocated aggregator info structure pointer, or an ERR_PTR on
+ * failure.
+ */
+static struct ice_sched_agg_info *
+ice_alloc_agg_info(struct ice_hw *hw, u32 min_id, u32 max_id,
+		   enum ice_agg_type agg_type)
+{
+	struct ice_sched_agg_info *agg_info;
+	u32 agg_id;
+	int status;
+
+	/* Create new entry for new aggregator ID */
+	agg_info = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*agg_info),
+				GFP_KERNEL);
+	if (!agg_info)
+		return ERR_PTR(-ENOMEM);
+
+	agg_info->agg_type = agg_type;
+	agg_info->tc_bitmap[0] = 0;
+
+	/* Initialize the aggregator VSI list head */
+	INIT_LIST_HEAD(&agg_info->agg_vsi_list);
+	agg_info->num_vsis = 0;
+
+	status = xa_alloc(&hw->agg_list, &agg_id, agg_info,
+			  XA_LIMIT(min_id, max_id), GFP_KERNEL);
+	if (status) {
+		devm_kfree(ice_hw_to_dev(hw), agg_info);
+		return ERR_PTR(status);
+	}
+	agg_info->agg_id = agg_id;
+
+	return agg_info;
+}
+
 /**
  * ice_sched_cfg_agg - configure aggregator node
  * @pi: port information structure
@@ -2719,29 +2767,11 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 	u8 tc;
 
 	agg_info = xa_load(&hw->agg_list, agg_id);
-	if (!agg_info) {
-		/* Create new entry for new aggregator ID */
-		agg_info = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*agg_info),
-					GFP_KERNEL);
-		if (!agg_info)
-			return -ENOMEM;
+	if (!agg_info)
+		agg_info = ice_alloc_agg_info(hw, agg_id, agg_id, agg_type);
+	if (IS_ERR(agg_info))
+		return PTR_ERR(agg_info);
 
-		agg_info->agg_id = agg_id;
-		agg_info->agg_type = agg_type;
-		agg_info->tc_bitmap[0] = 0;
-
-		/* Initialize the aggregator VSI list head */
-		INIT_LIST_HEAD(&agg_info->agg_vsi_list);
-		agg_info->num_vsis = 0;
-
-		/* Add new entry in aggregator array */
-		status = xa_insert(&hw->agg_list, agg_id, agg_info,
-				   GFP_KERNEL);
-		if (status) {
-			devm_kfree(ice_hw_to_dev(hw), agg_info);
-			return status;
-		}
-	}
 	/* Create aggregator node(s) for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
 		if (!ice_is_tc_ena(*tc_bitmap, tc)) {

-- 
2.54.0.1064.gd145956f57df


