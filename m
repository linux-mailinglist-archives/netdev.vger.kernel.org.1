Return-Path: <netdev+bounces-92583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB28B7F77
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0213B228D7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B6194C77;
	Tue, 30 Apr 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSueilIB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3979194C9E
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500411; cv=none; b=E43OiPijYNw55xqjdIxtZP/XgPJUdq0E5RJB1TuDu3g69guSCfnF/Y8k8NLErH6/o0DWw/Yp526hV4KU7DalBtNntbmMua4KdHFnfBLVv4o47pe9QSHBXA5XOb8PvPZqpvI32o5jd7yOGqjieNFVixCwpxmupNYO74sX8bpZE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500411; c=relaxed/simple;
	bh=c3FVZmmeCHYPmYIurc1RPZFYKP+5yjTsNDJq72WhaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzYmVZnCl/x7pMOGGkn12+Rlqly4rrY7259iAnVATn8rFsp4icVZdMggPR+rNkq6ad48OoFCNJo3+YBetJDEg/1j+NOkH7vmgtF+Wv/wkT98rL3LK6rQhwzyxf62GvMOzfgNO+dNwv2JHj8v27PHscT8UvwdSK3kVk6HVbC7fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSueilIB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500410; x=1746036410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3FVZmmeCHYPmYIurc1RPZFYKP+5yjTsNDJq72WhaM8=;
  b=GSueilIBi4Eda4xNP/Yt7oky4xnrn2MALayLPWITDgTWTjRmgeNjXTwe
   s9/k1GjJz5NY23qwXDoHhvPX/kIeZ4hQg4o3g+rSKbhRGth3XKLiwD/Ex
   s/+gaM0QwzZv9JifzhgZCJEm3fY2jKIIzm6SZGndnmClboDfqloKm0lBc
   3lR9bfcNLuK00JeHrU2hZgWWImeSEgLtpxkBsIYYw/ow/SrJHOo2FLfEo
   jTnIqHMn/fNN4Y36RpgV5Px1g/dH+GKurIzjSd+aNd1DJyVy+sgos1sL1
   qpsJGrJsVaDE1hM0DElPnyn0kixVLrtebgnK53c+kncMMeI8lfZbpt8Ih
   g==;
X-CSE-ConnectionGUID: dEu0ypHuQYy2cRZSVUjDGA==
X-CSE-MsgGUID: wRm9OmanSAyTQKAvd+NLEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20839452"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20839452"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:06:46 -0700
X-CSE-ConnectionGUID: NVACn3DeQlKisTF/KGVIxw==
X-CSE-MsgGUID: ms9SK4aARIOqt69IxlNZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31147314"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:06:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 7/7] i40e: Add and use helper to reconfigure TC for given VSI
Date: Tue, 30 Apr 2024 11:06:37 -0700
Message-ID: <20240430180639.1938515-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
References: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Add helper i40e_vsi_reconfig_tc(vsi) that configures TC
for given VSI using previously stored TC bitmap.

Effectively replaces open-coded patterns:

enabled_tc = vsi->tc_config.enabled_tc;
vsi->tc_config.enabled_tc = 0;
i40e_vsi_config_tc(vsi, enabled_tc);

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 32 +++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 26e5c21df19d..2cc7bec0557b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5917,6 +5917,28 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	return ret;
 }
 
+/**
+ * i40e_vsi_reconfig_tc - Reconfigure VSI Tx Scheduler for stored TC map
+ * @vsi: VSI to be reconfigured
+ *
+ * This reconfigures a particular VSI for TCs that are mapped to the
+ * TC bitmap stored previously for the VSI.
+ *
+ * Context: It is expected that the VSI queues have been quisced before
+ *          calling this function.
+ *
+ * Return: 0 on success, negative value on failure
+ **/
+static int i40e_vsi_reconfig_tc(struct i40e_vsi *vsi)
+{
+	u8 enabled_tc;
+
+	enabled_tc = vsi->tc_config.enabled_tc;
+	vsi->tc_config.enabled_tc = 0;
+
+	return i40e_vsi_config_tc(vsi, enabled_tc);
+}
+
 /**
  * i40e_get_link_speed - Returns link speed for the interface
  * @vsi: VSI to be configured
@@ -14279,7 +14301,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
 	struct i40e_pf *pf;
-	u8 enabled_tc;
 	int ret;
 
 	if (!vsi)
@@ -14312,10 +14333,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	 * layout configurations.
 	 */
 	main_vsi = i40e_pf_get_main_vsi(pf);
-	enabled_tc = main_vsi->tc_config.enabled_tc;
-	main_vsi->tc_config.enabled_tc = 0;
 	main_vsi->seid = pf->main_vsi_seid;
-	i40e_vsi_config_tc(main_vsi, enabled_tc);
+	i40e_vsi_reconfig_tc(main_vsi);
 
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_rm_default_mac_filter(vsi, pf->hw.mac.perm_addr);
@@ -15074,11 +15093,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 		}
 	} else {
 		/* force a reset of TC and queue layout configurations */
-		u8 enabled_tc = main_vsi->tc_config.enabled_tc;
-
-		main_vsi->tc_config.enabled_tc = 0;
 		main_vsi->seid = pf->main_vsi_seid;
-		i40e_vsi_config_tc(main_vsi, enabled_tc);
+		i40e_vsi_reconfig_tc(main_vsi);
 	}
 	i40e_vlan_stripping_disable(main_vsi);
 
-- 
2.41.0


