Return-Path: <netdev+bounces-155621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E7A032A0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC607A2344
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55321E47A9;
	Mon,  6 Jan 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+xqzi/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528A14F9F3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201990; cv=none; b=jWnf7aFJEuTkWiE9rchqm9AmJd/OG3jI8VYAMbNL1gm0+pgqGshNjZFz/i0dEo3HisSEGSq9FVGWBTAFEpcSNpCViWdoYUfQbw+s10fBWcIF5XOS/V4zGE3FzwcelSp/if613FFDrz29iDJnGSs5QyI+GFzhH4+WOAY2u6yOqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201990; c=relaxed/simple;
	bh=2dwYvq60tvmtHAA9etEo/aNX0amV6YKSaA07CqnF76M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTHR0SFyuqf/GfNgGUc7yLgq34oU2mf7IJqBZVYnG2A1OnSkogBNTfo6MClEsBnARY1o/Z99pzRxAH0UqRYm2arhsDuVPwQrI5l5q2TyH4QuqGRJ0ggbeRfshuCwzUpOpuqsSXX0OV21UUOsKBikbm8kHNK3b70hLH2ZHCa4xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+xqzi/Z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201988; x=1767737988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dwYvq60tvmtHAA9etEo/aNX0amV6YKSaA07CqnF76M=;
  b=R+xqzi/ZsbFcsnzyD48WNojyR1R4CiFiYzb/tst1NRyiIVu3811gqHzs
   5swo3bt5anSTfTutLpFCs1lPIDRLhbAiSz1JiDcF8jmWbqw+xSEBc4xLk
   Og3UbUOk+ygNRAe14L7WBS95Ao9Zj9Z5+hH/+1yaIlC31ftA7vLWv4Va1
   wgebNNfiHHt7m5407SrrTMvsorMXT0RaQRMlFHJdHGtRZd8k60e0WQA4E
   JNjmDGkvMA79fo7YRM3F3k7nLWyNm4KPNqRYgHFvMygECVv2F0aWVJuSr
   uKvBnoWTb4C/XUPaljflw19c859zho/j5oVrZAuThAQJwusuQ3bs1LjhL
   g==;
X-CSE-ConnectionGUID: ttFFxwgPQD2s8hnRFJmYow==
X-CSE-MsgGUID: z2bUFAwrRgi8Jw0Z2TJFUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858788"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858788"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:43 -0800
X-CSE-ConnectionGUID: QF/vnYilTSy8pHdSlRXnSA==
X-CSE-MsgGUID: jLqC7ciKRYaUI7j03EggIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368497"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next 15/15] intel/fm10k: Remove unused fm10k_iov_msg_mac_vlan_pf
Date: Mon,  6 Jan 2025 14:19:23 -0800
Message-ID: <20250106221929.956999-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

fm10k_iov_msg_mac_vlan_pf() has been unused since 2017's
commit 1f5c27e52857 ("fm10k: use the MAC/VLAN queue for VF<->PF MAC/VLAN
requests")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 120 --------------------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h |   2 -
 2 files changed, 122 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 98861cc6df7c..b9dd7b719832 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1179,126 +1179,6 @@ s32 fm10k_iov_select_vid(struct fm10k_vf_info *vf_info, u16 vid)
 		return vid;
 }
 
-/**
- *  fm10k_iov_msg_mac_vlan_pf - Message handler for MAC/VLAN request from VF
- *  @hw: Pointer to hardware structure
- *  @results: Pointer array to message, results[0] is pointer to message
- *  @mbx: Pointer to mailbox information structure
- *
- *  This function is a default handler for MAC/VLAN requests from the VF.
- *  The assumption is that in this case it is acceptable to just directly
- *  hand off the message from the VF to the underlying shared code.
- **/
-s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
-			      struct fm10k_mbx_info *mbx)
-{
-	struct fm10k_vf_info *vf_info = (struct fm10k_vf_info *)mbx;
-	u8 mac[ETH_ALEN];
-	u32 *result;
-	int err = 0;
-	bool set;
-	u16 vlan;
-	u32 vid;
-
-	/* we shouldn't be updating rules on a disabled interface */
-	if (!FM10K_VF_FLAG_ENABLED(vf_info))
-		err = FM10K_ERR_PARAM;
-
-	if (!err && !!results[FM10K_MAC_VLAN_MSG_VLAN]) {
-		result = results[FM10K_MAC_VLAN_MSG_VLAN];
-
-		/* record VLAN id requested */
-		err = fm10k_tlv_attr_get_u32(result, &vid);
-		if (err)
-			return err;
-
-		set = !(vid & FM10K_VLAN_CLEAR);
-		vid &= ~FM10K_VLAN_CLEAR;
-
-		/* if the length field has been set, this is a multi-bit
-		 * update request. For multi-bit requests, simply disallow
-		 * them when the pf_vid has been set. In this case, the PF
-		 * should have already cleared the VLAN_TABLE, and if we
-		 * allowed them, it could allow a rogue VF to receive traffic
-		 * on a VLAN it was not assigned. In the single-bit case, we
-		 * need to modify requests for VLAN 0 to use the default PF or
-		 * SW vid when assigned.
-		 */
-
-		if (vid >> 16) {
-			/* prevent multi-bit requests when PF has
-			 * administratively set the VLAN for this VF
-			 */
-			if (vf_info->pf_vid)
-				return FM10K_ERR_PARAM;
-		} else {
-			err = fm10k_iov_select_vid(vf_info, (u16)vid);
-			if (err < 0)
-				return err;
-
-			vid = err;
-		}
-
-		/* update VSI info for VF in regards to VLAN table */
-		err = hw->mac.ops.update_vlan(hw, vid, vf_info->vsi, set);
-	}
-
-	if (!err && !!results[FM10K_MAC_VLAN_MSG_MAC]) {
-		result = results[FM10K_MAC_VLAN_MSG_MAC];
-
-		/* record unicast MAC address requested */
-		err = fm10k_tlv_attr_get_mac_vlan(result, mac, &vlan);
-		if (err)
-			return err;
-
-		/* block attempts to set MAC for a locked device */
-		if (is_valid_ether_addr(vf_info->mac) &&
-		    !ether_addr_equal(mac, vf_info->mac))
-			return FM10K_ERR_PARAM;
-
-		set = !(vlan & FM10K_VLAN_CLEAR);
-		vlan &= ~FM10K_VLAN_CLEAR;
-
-		err = fm10k_iov_select_vid(vf_info, vlan);
-		if (err < 0)
-			return err;
-
-		vlan = (u16)err;
-
-		/* notify switch of request for new unicast address */
-		err = hw->mac.ops.update_uc_addr(hw, vf_info->glort,
-						 mac, vlan, set, 0);
-	}
-
-	if (!err && !!results[FM10K_MAC_VLAN_MSG_MULTICAST]) {
-		result = results[FM10K_MAC_VLAN_MSG_MULTICAST];
-
-		/* record multicast MAC address requested */
-		err = fm10k_tlv_attr_get_mac_vlan(result, mac, &vlan);
-		if (err)
-			return err;
-
-		/* verify that the VF is allowed to request multicast */
-		if (!(vf_info->vf_flags & FM10K_VF_FLAG_MULTI_ENABLED))
-			return FM10K_ERR_PARAM;
-
-		set = !(vlan & FM10K_VLAN_CLEAR);
-		vlan &= ~FM10K_VLAN_CLEAR;
-
-		err = fm10k_iov_select_vid(vf_info, vlan);
-		if (err < 0)
-			return err;
-
-		vlan = (u16)err;
-
-		/* notify switch of request for new multicast address */
-		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort,
-						 mac, vlan, set);
-	}
-
-	return err;
-}
-
 /**
  *  fm10k_iov_supported_xcast_mode_pf - Determine best match for xcast mode
  *  @vf_info: VF info structure containing capability flags
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index 8e814df709d2..ad3696893cb1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -99,8 +99,6 @@ extern const struct fm10k_tlv_attr fm10k_err_msg_attr[];
 
 s32 fm10k_iov_select_vid(struct fm10k_vf_info *vf_info, u16 vid);
 s32 fm10k_iov_msg_msix_pf(struct fm10k_hw *, u32 **, struct fm10k_mbx_info *);
-s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *, u32 **,
-			      struct fm10k_mbx_info *);
 s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *, u32 **,
 				 struct fm10k_mbx_info *);
 
-- 
2.47.1


