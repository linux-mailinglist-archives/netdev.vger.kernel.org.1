Return-Path: <netdev+bounces-104660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3776490DDE7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9339CB2098A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D216CD09;
	Tue, 18 Jun 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpV71IKR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F315E5CA
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744538; cv=none; b=Ce2GrQs+SoFhN9Jq7VWuoNrZIc/qe7+hk+h6a4cxzSAVKYNg42zlr4+3lp9wJ3mKOzgfkfHAmEz2Zc6796tO7Xfr435v9Oiex23/WT4Z+ieLA7NFnV7wwtKf5cIyVxfqVw8HfO3s1+sJPkIMk5hvIb2l7XneC008siD9uT4Xx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744538; c=relaxed/simple;
	bh=ZcZSmjpf3b4lzlXFEfM73nSXV0zFLpejy9dlg/S+vLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULdQrE+foChYLawjO1iCDHak9RrOf+SaRtbCfigNqzEGvGTlbPOOPSJpUqH8oGuGjzV8OuqhI2ZKUbby6miJprEGp7ehcXBbWNZDZU9KVdRi348AluIApAnZ18pgW8qlmUL+W4u/8fG08jyjWfkkyA2rtEOrVJKN+qh0jviyReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpV71IKR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718744537; x=1750280537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZcZSmjpf3b4lzlXFEfM73nSXV0zFLpejy9dlg/S+vLE=;
  b=KpV71IKRiVgztt/9s16LAQA9vANZJX+Zkbmtj3K9zPMBsFvOowl0Zb2q
   qWOknW/ZZpzR/F//+s84++kA9bjTjXMomrfTpfUqbzGWb38TbUELU2Byg
   aWeiQ84YGGVfWWx+6m9cjB47io8b/7m3eg0ESBsl9p0G8KRYY6kGqkIPe
   NJGq/Q2l4vb/yewKewQwrgTHk2qvgklHhOVcBQrmA8HQ/qLUwp81JKLVh
   A/S4UKq9GfJ3kVn8fX+0Mz1r9Xw5sXmJQ8cHswkNp8VDNA7eDatxkuZZi
   VPG0sgCCFydaVFcqBSGo8aqtKd409mgLZjCkF38S/0kukCuiQWVOQOAag
   w==;
X-CSE-ConnectionGUID: vXlqYmOWQdio2usGUxAiSw==
X-CSE-MsgGUID: 75hjPb5ATFOsVzjbymAWlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15528435"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15528435"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 14:02:16 -0700
X-CSE-ConnectionGUID: pB4tIwKQQnOI8mpR57W2+w==
X-CSE-MsgGUID: pqIuGLfeQ2WMqIx0MvvKXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41785490"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jun 2024 14:02:15 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net] ice: Fix VSI list rule with ICE_SW_LKUP_LAST type
Date: Tue, 18 Jun 2024 14:02:05 -0700
Message-ID: <20240618210206.981885-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Adding/updating VSI list rule, as well as allocating/freeing VSI list
resource are called several times with type ICE_SW_LKUP_LAST, which fails
because ice_update_vsi_list_rule() and ice_aq_alloc_free_vsi_list()
consider it invalid. Allow calling these functions with ICE_SW_LKUP_LAST.

This fixes at least one issue in switchdev mode, where the same rule with
different action cannot be added, e.g.:

  tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF1_PR
  tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF2_PR

Fixes: 0f94570d0cae ("ice: allow adding advanced rules")
Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 94d6670d0901..1191031b2a43 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1899,7 +1899,8 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 	    lkup_type == ICE_SW_LKUP_ETHERTYPE_MAC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC_VLAN ||
-	    lkup_type == ICE_SW_LKUP_DFLT) {
+	    lkup_type == ICE_SW_LKUP_DFLT ||
+	    lkup_type == ICE_SW_LKUP_LAST) {
 		sw_buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_VSI_LIST_REP);
 	} else if (lkup_type == ICE_SW_LKUP_VLAN) {
 		if (opc == ice_aqc_opc_alloc_res)
@@ -2922,7 +2923,8 @@ ice_update_vsi_list_rule(struct ice_hw *hw, u16 *vsi_handle_arr, u16 num_vsi,
 	    lkup_type == ICE_SW_LKUP_ETHERTYPE_MAC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC ||
 	    lkup_type == ICE_SW_LKUP_PROMISC_VLAN ||
-	    lkup_type == ICE_SW_LKUP_DFLT)
+	    lkup_type == ICE_SW_LKUP_DFLT ||
+	    lkup_type == ICE_SW_LKUP_LAST)
 		rule_type = remove ? ICE_AQC_SW_RULES_T_VSI_LIST_CLEAR :
 			ICE_AQC_SW_RULES_T_VSI_LIST_SET;
 	else if (lkup_type == ICE_SW_LKUP_VLAN)
-- 
2.41.0


