Return-Path: <netdev+bounces-72554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACCF85882A
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F99284328
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB514830A;
	Fri, 16 Feb 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnkruk+u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9E2FE28
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119792; cv=none; b=AJq8iMhHuftt50V6wmeXKRlvsNXjqPqFua8Fl9/rRpSzV0liioah9C6RCQVzCvRW7VlQsYqOtSEHGF8DBaeZKWlFYLnMQmDBITxJ/Lhu53Y0Th9RSu1MZ84XzJc2ATxLg/SqTTWU3tcjXLawui+vu9e9bHi1WE5y4M8C+gMCpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119792; c=relaxed/simple;
	bh=w4LwJgB2l9Og2oM1FRAG9THdOMn1aVZRUrax13q7T4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lggJBwbQC8WUTn72gFP5yaBLrsAnf+B7pGb6DgYZm8lgB0LnCZTRDn4mJ1zA5CVz0IK0iSwCP0XS7pE0K2nfEFe7yMlpXuFptJTmo8WyzMPucffAILDlIAoHCCsV1bdUx+F5uXQuxRAL0PbcQ62AUw/Y+6TJ8L5FtvjRRgzcNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnkruk+u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119791; x=1739655791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4LwJgB2l9Og2oM1FRAG9THdOMn1aVZRUrax13q7T4k=;
  b=hnkruk+ua0KvDQ4h4Yn03lKhGrbhPBwqjef/zJDXe9ZyVZW36c6sAj4Z
   qogEyn3FqsNo3Nt++5Gn2ksQFTPGVuycSjg31uSL7CcAK6iKgEMA6A4CM
   WuqFu3EUonsQtr/sAnSrkyKUBwhKW9Ua5IteNZh88FX3pq7OeTMRier7V
   zBNPEAXYNXw45TwiJYU8iAj0PVSGmD5W0Am1okc5LT7KdvdZqCfylqqo4
   DnDdTMTDeSfcUa2L7abIT8B3x3ZdJUx+YWifhqFsNbGtqmU9aHYPfFSUX
   w0jiQUJW2WoO37skut1/yEWDgm8VuSy1bFwv/Lmg40xod9VnP4GDiAnk8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2122892"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2122892"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8618681"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 16 Feb 2024 13:42:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/5] i40e: Fix broken support for floating VEBs
Date: Fri, 16 Feb 2024 13:42:41 -0800
Message-ID: <20240216214243.764561-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Although the i40e supports so-called floating VEB (VEB without
an uplink connection to external network), this support is
broken. This functionality is currently unused (except debugfs)
but it will be used by subsequent series for switchdev mode
slow-path. Fix this by following:

1) Handle correctly floating VEB (VEB with uplink_seid == 0)
   in i40e_reconstitute_veb() and look for owner VSI and
   create it only for non-floating VEBs and also set bridge
   mode only for such VEBs as the floating ones are using
   always VEB mode.
2) Handle correctly floating VEB in i40e_veb_release() and
   disallow its release when there are some VSIs. This is
   different from regular VEB that have owner VSI that is
   connected to VEB's uplink after VEB deletion by FW.
3) Fix i40e_add_veb() to handle 'vsi' that is NULL for floating
   VEBs. For floating VEB use 0 for downlink SEID and 'true'
   for 'default_port' parameters as per datasheet.
4) Fix 'add relay' command in i40e_dbg_command_write() to allow
   to create floating VEB by 'add relay 0 0' or 'add relay'

Tested using debugfs:
1) Initial state
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  173.701286] i40e 0000:02:00.0: header: 3 reported 3 total
[  173.706701] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  173.713241] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  173.719507] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

2) Add floating VEB
[root@host net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
[root@host net-next]# echo add relay > $CMD
[root@host net-next]# dmesg -c
[  245.551720] i40e 0000:02:00.0: added relay 162
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  276.984371] i40e 0000:02:00.0: header: 4 reported 4 total
[  276.989779] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  276.996302] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  277.002569] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
[  277.009091] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0

3) Add VMDQ2 VSI to this new VEB
[root@host net-next]# echo add vsi 162 > $CMD
[root@host net-next]# dmesg -c
[  332.314030] i40e 0000:02:00.0: added VSI 394 to relay 162
[  332.337486] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  387.284490] i40e 0000:02:00.0: header: 5 reported 5 total
[  387.289904] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  387.296446] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  387.302708] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  387.309234] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  387.315500] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

4) Try to delete the VEB
[root@host net-next]# echo del relay 162 > $CMD
[root@host net-next]# dmesg -c
[  428.749297] i40e 0000:02:00.0: deleting relay 162
[  428.754011] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left

5) Do PF reset and check switch status after rebuild
[root@host net-next]# echo pfr > $CMD
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  738.056172] i40e 0000:02:00.0: header: 5 reported 5 total
[  738.061577] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  738.068104] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  738.074367] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  738.080892] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  738.087160] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

6) Delete VSI and delete VEB
[root@host net-next]# echo del vsi 394 > $CMD
[root@host net-next]# echo del relay 162 > $CMD
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[ 1233.081126] i40e 0000:02:00.0: deleting VSI 394
[ 1239.345139] i40e 0000:02:00.0: deleting relay 162
[ 1244.886920] i40e 0000:02:00.0: header: 3 reported 3 total
[ 1244.892328] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[ 1244.898853] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[ 1244.905119] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 29 ++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 87 ++++++++++---------
 2 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 990a60889eef..921a97d5479e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -829,10 +829,14 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
 		struct i40e_veb *veb;
+		u8 enabled_tc = 0x1;
 		int uplink_seid;
 
 		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
-		if (cnt != 2) {
+		if (cnt == 0) {
+			uplink_seid = 0;
+			vsi_seid = 0;
+		} else if (cnt != 2) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: bad command string, cnt=%d\n",
 				 cnt);
@@ -844,23 +848,28 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		vsi = i40e_dbg_find_vsi(pf, vsi_seid);
-		if (!vsi) {
-			dev_info(&pf->pdev->dev,
-				 "add relay: VSI %d not found\n", vsi_seid);
-			goto command_write_done;
-		}
-
 		veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
 		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
 			goto command_write_done;
+		} else if (uplink_seid) {
+			vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
+			if (!vsi) {
+				dev_info(&pf->pdev->dev,
+					 "add relay: VSI %d not found\n",
+					 vsi_seid);
+				goto command_write_done;
+			}
+			enabled_tc = vsi->tc_config.enabled_tc;
+		} else if (vsi_seid) {
+			dev_info(&pf->pdev->dev,
+				 "add relay: VSI must be 0 for floating relay\n");
+			goto command_write_done;
 		}
 
-		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid,
-				     vsi->tc_config.enabled_tc);
+		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid, enabled_tc);
 		if (veb)
 			dev_info(&pf->pdev->dev, "added relay %d\n", veb->seid);
 		else
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e495a212d076..31d1b1ff07b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10372,41 +10372,48 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
 	struct i40e_vsi *vsi;
 	int v, ret;
 
-	/* build VSI that owns this VEB, temporarily attached to base VEB */
-	i40e_pf_for_each_vsi(pf, v, vsi)
-		if (vsi->veb_idx == veb->idx &&
-		    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
-			ctl_vsi = vsi;
-			break;
+	if (veb->uplink_seid) {
+		/* Look for VSI that owns this VEB, temporarily attached to base VEB */
+		i40e_pf_for_each_vsi(pf, v, vsi)
+			if (vsi->veb_idx == veb->idx &&
+			    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
+				ctl_vsi = vsi;
+				break;
+			}
+
+		if (!ctl_vsi) {
+			dev_info(&pf->pdev->dev,
+				 "missing owner VSI for veb_idx %d\n",
+				 veb->idx);
+			ret = -ENOENT;
+			goto end_reconstitute;
 		}
+		if (ctl_vsi != pf->vsi[pf->lan_vsi])
+			ctl_vsi->uplink_seid =
+				pf->vsi[pf->lan_vsi]->uplink_seid;
 
-	if (!ctl_vsi) {
-		dev_info(&pf->pdev->dev,
-			 "missing owner VSI for veb_idx %d\n", veb->idx);
-		ret = -ENOENT;
-		goto end_reconstitute;
-	}
-	if (ctl_vsi != pf->vsi[pf->lan_vsi])
-		ctl_vsi->uplink_seid = pf->vsi[pf->lan_vsi]->uplink_seid;
-	ret = i40e_add_vsi(ctl_vsi);
-	if (ret) {
-		dev_info(&pf->pdev->dev,
-			 "rebuild of veb_idx %d owner VSI failed: %d\n",
-			 veb->idx, ret);
-		goto end_reconstitute;
+		ret = i40e_add_vsi(ctl_vsi);
+		if (ret) {
+			dev_info(&pf->pdev->dev,
+				 "rebuild of veb_idx %d owner VSI failed: %d\n",
+				 veb->idx, ret);
+			goto end_reconstitute;
+		}
+		i40e_vsi_reset_stats(ctl_vsi);
 	}
-	i40e_vsi_reset_stats(ctl_vsi);
 
 	/* create the VEB in the switch and move the VSI onto the VEB */
 	ret = i40e_add_veb(veb, ctl_vsi);
 	if (ret)
 		goto end_reconstitute;
 
-	if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
-		veb->bridge_mode = BRIDGE_MODE_VEB;
-	else
-		veb->bridge_mode = BRIDGE_MODE_VEPA;
-	i40e_config_bridge_mode(veb);
+	if (veb->uplink_seid) {
+		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
+			veb->bridge_mode = BRIDGE_MODE_VEB;
+		else
+			veb->bridge_mode = BRIDGE_MODE_VEPA;
+		i40e_config_bridge_mode(veb);
+	}
 
 	/* create the remaining VSIs attached to this VEB */
 	i40e_pf_for_each_vsi(pf, v, vsi) {
@@ -14702,29 +14709,29 @@ void i40e_veb_release(struct i40e_veb *veb)
 	/* find the remaining VSI and check for extras */
 	i40e_pf_for_each_vsi(pf, i, vsi_it)
 		if (vsi_it->uplink_seid == veb->seid) {
-			vsi = vsi_it;
+			if (vsi_it->flags & I40E_VSI_FLAG_VEB_OWNER)
+				vsi = vsi_it;
 			n++;
 		}
 
-	if (n != 1) {
+	/* Floating VEB has to be empty and regular one must have
+	 * single owner VSI.
+	 */
+	if ((veb->uplink_seid && n != 1) || (!veb->uplink_seid && n != 0)) {
 		dev_info(&pf->pdev->dev,
 			 "can't remove VEB %d with %d VSIs left\n",
 			 veb->seid, n);
 		return;
 	}
 
-	/* move the remaining VSI to uplink veb */
-	vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
+	/* For regular VEB move the owner VSI to uplink VEB */
 	if (veb->uplink_seid) {
+		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
 		vsi->uplink_seid = veb->uplink_seid;
 		if (veb->uplink_seid == pf->mac_seid)
 			vsi->veb_idx = I40E_NO_VEB;
 		else
 			vsi->veb_idx = veb->veb_idx;
-	} else {
-		/* floating VEB */
-		vsi->uplink_seid = pf->vsi[pf->lan_vsi]->uplink_seid;
-		vsi->veb_idx = pf->vsi[pf->lan_vsi]->veb_idx;
 	}
 
 	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
@@ -14742,8 +14749,8 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 	bool enable_stats = !!test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
 	int ret;
 
-	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi->seid,
-			      veb->enabled_tc, false,
+	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi ? vsi->seid : 0,
+			      veb->enabled_tc, vsi ? false : true,
 			      &veb->seid, enable_stats, NULL);
 
 	/* get a VEB from the hardware */
@@ -14775,9 +14782,11 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 		return -ENOENT;
 	}
 
-	vsi->uplink_seid = veb->seid;
-	vsi->veb_idx = veb->idx;
-	vsi->flags |= I40E_VSI_FLAG_VEB_OWNER;
+	if (vsi) {
+		vsi->uplink_seid = veb->seid;
+		vsi->veb_idx = veb->idx;
+		vsi->flags |= I40E_VSI_FLAG_VEB_OWNER;
+	}
 
 	return 0;
 }
-- 
2.41.0


