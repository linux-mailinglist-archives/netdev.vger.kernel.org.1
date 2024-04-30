Return-Path: <netdev+bounces-92577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B908B7F71
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD2FB22ECD
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5119066C;
	Tue, 30 Apr 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ma6ix47d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F99181CE8
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500407; cv=none; b=Yvpmaw9vbtBLW3CaUNpmvt55XMPwJxZ1K0uiERnrqdseApqH3HEzjUBuCVMWdwLaoFoQzZlwszBuYosUusZTC76R/caCrlLaEJNP4+NTqZ1mofP0stYXcea4owsAoMIMx3EL612PZ9B+gsvUmN/Dmn/0xRmXogD3TOH8s+RHIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500407; c=relaxed/simple;
	bh=sF9WnFBWGQG75yblf3BIjmKMRjXhPYvKucbFJWHdeZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UULa6bLNDh914n8Tnt5nneI20QkGjVSj+8vXZ6vFwLYQFfyb2VwjKG4ioZDOKaG6l70D2hDdyamHMtiW0fgV/682BDn5WdoTMgqwspUJK21dIX8tijBJtsjDr3VEdH5KBJFzq9mL7ERfU6jmzWhIhpk/ecP0G0+UBXi3HZEoZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ma6ix47d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500405; x=1746036405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sF9WnFBWGQG75yblf3BIjmKMRjXhPYvKucbFJWHdeZQ=;
  b=ma6ix47dB0OWBEUL67qrM+vRYk7oFyXoPNcKWzy85HCk+EI0v/wnWkxO
   gkF55ZGqma7kI5uTF2+rHrGX3PYSVTBCNYHkS/+Ki7sS5BxUmM+23kWgi
   dVC5uvZYPTGyUS7wKNE5zuAv+vIo27/gBXTq/jzc/LghRED19HujBqWNK
   XcknEHFToe8uQqA3K0C48pZBWRK0DI8V9WDx6WFRBxmaW+ZIchLJLVnMa
   Iy2+ON3VpHLGfYMZBxHy60ZHAAxv+pnVn7UPUJC+4MfHpR26FMF/OD3Gs
   YR9eJ1N0nOp9Ylnf7utw+4V5ThxtjTzuveu3/mk7tspZRfieDa8gSEbSz
   Q==;
X-CSE-ConnectionGUID: gwTd9Z36S5yAnGQ2crLGAQ==
X-CSE-MsgGUID: /lpgb2ACRGyCBpMtPD09+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20839410"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20839410"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:06:44 -0700
X-CSE-ConnectionGUID: Ffxoyq64QOuzIGRV3Dekkg==
X-CSE-MsgGUID: qYpe23C1QDqWu0ezCPtnAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31147294"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:06:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/7] i40e: Remove flags field from i40e_veb
Date: Tue, 30 Apr 2024 11:06:31 -0700
Message-ID: <20240430180639.1938515-2-anthony.l.nguyen@intel.com>
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

The field is initialized always to zero and it is never read.
Remove it.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  3 +--
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++--------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2fbabcdb5bb5..5248e78f7849 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -788,7 +788,6 @@ struct i40e_veb {
 	u16 stats_idx;		/* index of VEB parent */
 	u8  enabled_tc;
 	u16 bridge_mode;	/* Bridge Mode (VEB/VEPA) */
-	u16 flags;
 	u16 bw_limit;
 	u8  bw_max_quanta;
 	bool is_abs_credits;
@@ -1213,7 +1212,7 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi);
 void i40e_vsi_stop_rings_no_wait(struct  i40e_vsi *vsi);
 int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi);
 int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count);
-struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16 uplink_seid,
+struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 uplink_seid,
 				u16 downlink_seid, u8 enabled_tc);
 void i40e_veb_release(struct i40e_veb *veb);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index f9ba45f596c9..6147c5f128e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -867,7 +867,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid, enabled_tc);
+		veb = i40e_veb_setup(pf, uplink_seid, vsi_seid, enabled_tc);
 		if (veb)
 			dev_info(&pf->pdev->dev, "added relay %d\n", veb->seid);
 		else
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bcc99a6676f9..e27b2aa544b6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13127,7 +13127,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 
 		/* Insert a new HW bridge */
 		if (!veb) {
-			veb = i40e_veb_setup(pf, 0, vsi->uplink_seid, vsi->seid,
+			veb = i40e_veb_setup(pf, vsi->uplink_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 			if (veb) {
 				veb->bridge_mode = mode;
@@ -14383,10 +14383,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		}
 
 		if (vsi->uplink_seid == pf->mac_seid)
-			veb = i40e_veb_setup(pf, 0, pf->mac_seid, vsi->seid,
+			veb = i40e_veb_setup(pf, pf->mac_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 		else if ((vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
-			veb = i40e_veb_setup(pf, 0, vsi->uplink_seid, vsi->seid,
+			veb = i40e_veb_setup(pf, vsi->uplink_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 		if (veb) {
 			if (vsi->seid != pf->vsi[pf->lan_vsi]->seid) {
@@ -14780,7 +14780,6 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 /**
  * i40e_veb_setup - Set up a VEB
  * @pf: board private structure
- * @flags: VEB setup flags
  * @uplink_seid: the switch element to link to
  * @vsi_seid: the initial VSI seid
  * @enabled_tc: Enabled TC bit-map
@@ -14793,9 +14792,8 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
  * Returns pointer to the successfully allocated VEB sw struct on
  * success, otherwise returns NULL on failure.
  **/
-struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
-				u16 uplink_seid, u16 vsi_seid,
-				u8 enabled_tc)
+struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 uplink_seid,
+				u16 vsi_seid, u8 enabled_tc)
 {
 	struct i40e_vsi *vsi = NULL;
 	struct i40e_veb *veb;
@@ -14826,7 +14824,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	if (veb_idx < 0)
 		goto err_alloc;
 	veb = pf->veb[veb_idx];
-	veb->flags = flags;
 	veb->uplink_seid = uplink_seid;
 	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
 
-- 
2.41.0


