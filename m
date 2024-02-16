Return-Path: <netdev+bounces-72553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB67858829
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D40A1C226B4
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D01482F4;
	Fri, 16 Feb 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8JQxeGL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0878145FFC
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119791; cv=none; b=YgCr1Mt26oNLX08Tz3CMLiG4lTkNlgCEQThGDBzciOX1qMDYLLw2dPFmhOiAMvw/m/VWorHVEM7SghYefRzZGV+YCYz8Z8CiqLESX6LsEzFjyTpNbNYc09lLlwD6AfeJW4CIwa/MrNgfyE2/Ib0weybehdyHZAdj2Ty1At6WDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119791; c=relaxed/simple;
	bh=buTJ9Pul14Ewpgv4As6TXOPnq0d4k5brOEK/wFj0LBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWsGRbPFQ02/9JedczkhtaAhr6hYrs0BDvtgLMLQLYJQaa/gUYbmbK2mr1g9y2fHI4BCGludX/cI7vQILdmJdKNxfSh8/JvWo/66qUQydkbj0s7g4s9PbeIpofUO5WCaEc66tNiU+tEMjpXdAppVGrVbISnEps83spFi0r5f7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8JQxeGL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119789; x=1739655789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buTJ9Pul14Ewpgv4As6TXOPnq0d4k5brOEK/wFj0LBk=;
  b=T8JQxeGLvtGMCG0mVjNIP+bSo1Sqf+GHyiFkikJafLgpt9nFr1bVvKd1
   DzCqrFuLxoVLoBHRKNqna9QwIYxCCa9jeDI3e6sHZ9+cBBBfaLA0zV6p/
   SU3P1aMWeK+rcJ+QjJu7QViaJZyNsbiSV6/qPkLnwMMdmVyuKWwtaAUHJ
   25xjTLYLtCU7XdQHDzBIY8uusT6fHk3IeOZnjAbgYs1IPSQ4z969FXWux
   w5JP/f/G96vppVPMM8fM4I9ZmWa4lK/M1tnrm8E2vJEOdRA5+5rV6wplN
   poUC928ST9AaevweW8Ygpl7T5DDUY6OaJSzIr7LiQ3cdPCFccKKB82vGs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2122876"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2122876"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8618684"
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
Subject: [PATCH net-next 5/5] i40e: Remove VEB recursion
Date: Fri, 16 Feb 2024 13:42:42 -0800
Message-ID: <20240216214243.764561-6-anthony.l.nguyen@intel.com>
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

The VEB (virtual embedded switch) as a switch element can be
connected according datasheet though its uplink to:
- Physical port
- Port Virtualizer (not used directly by i40e driver but can
  be present in MFP mode where the physical port is shared
  between PFs)
- No uplink (aka floating VEB)

But VEB uplink cannot be connected to another VEB and any attempt
to do so results in:

"i40e 0000:02:00.0: couldn't add VEB, err -EIO aq_err I40E_AQ_RC_ENOENT"

that indicates "the uplink SEID does not point to valid element".

Remove this logic from the driver code this way:

1) For debugfs only allow to build floating VEB (uplink_seid == 0)
   or main VEB (uplink_seid == mac_seid)
2) Do not recurse in i40e_veb_link_event() as no VEB cannot have
   sub-VEBs
3) Ditto for i40e_veb_rebuild() + simplify the function as we know
   that the VEB for rebuild can be only the main LAN VEB or some
   of the floating VEBs
4) In i40e_rebuild() there is no need to check veb->uplink_seid
   as the possible ones are 0 and MAC SEID
5) In i40e_vsi_release() do not take into account VEBs whose
   uplink is another VEB as this is not possible
6) Remove veb_idx field from i40e_veb as a VEB cannot have
   sub-VEBs

Tested using i40e debugfs interface:
1) Initial state
[root@cnb-03 net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
[   98.440641] i40e 0000:02:00.0: header: 3 reported 3 total
[   98.446053] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[   98.452593] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[   98.458856] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

2) Add floating VEB
[root@cnb-03 net-next]# echo add relay > $CMD
[root@cnb-03 net-next]# dmesg -c
[  122.745630] i40e 0000:02:00.0: added relay 162
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
[  136.650049] i40e 0000:02:00.0: header: 4 reported 4 total
[  136.655466] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  136.661994] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  136.668264] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
[  136.674787] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0

3) Add VMDQ2 VSI to this new VEB
[root@cnb-03 net-next]# dmesg -c
[  168.351763] i40e 0000:02:00.0: added VSI 394 to relay 162
[  168.374652] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
[  195.683204] i40e 0000:02:00.0: header: 5 reported 5 total
[  195.688611] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  195.695143] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  195.701410] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  195.707935] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  195.714201] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

4) Try to delete the VEB
[root@cnb-03 net-next]# echo del relay 162 > $CMD
[root@cnb-03 net-next]# dmesg -c
[  239.260901] i40e 0000:02:00.0: deleting relay 162
[  239.265621] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left

5) Do PF reset and check switch status after rebuild
[root@cnb-03 net-next]# echo pfr > $CMD
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
...
[  272.333655] i40e 0000:02:00.0: header: 5 reported 5 total
[  272.339066] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  272.345599] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  272.351862] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  272.358387] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  272.364654] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

6) Delete VSI and delete VEB
[  297.199116] i40e 0000:02:00.0: deleting VSI 394
[  299.807580] i40e 0000:02:00.0: deleting relay 162
[  309.767905] i40e 0000:02:00.0: header: 3 reported 3 total
[  309.773318] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  309.779845] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  309.786111] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |   1 -
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 176 ++++++++----------
 3 files changed, 76 insertions(+), 109 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2990ff4f0306..ba24f3fa92c3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -783,7 +783,6 @@ struct i40e_new_mac_filter {
 struct i40e_veb {
 	struct i40e_pf *pf;
 	u16 idx;
-	u16 veb_idx;		/* index of VEB parent */
 	u16 seid;
 	u16 uplink_seid;
 	u16 stats_idx;		/* index of VEB parent */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 921a97d5479e..f9ba45f596c9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -683,9 +683,8 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
 		return;
 	}
 	dev_info(&pf->pdev->dev,
-		 "veb idx=%d,%d stats_ic=%d  seid=%d uplink=%d mode=%s\n",
-		 veb->idx, veb->veb_idx, veb->stats_idx, veb->seid,
-		 veb->uplink_seid,
+		 "veb idx=%d stats_ic=%d  seid=%d uplink=%d mode=%s\n",
+		 veb->idx, veb->stats_idx, veb->seid, veb->uplink_seid,
 		 veb->bridge_mode == BRIDGE_MODE_VEPA ? "VEPA" : "VEB");
 	i40e_dbg_dump_eth_stats(pf, &veb->stats);
 }
@@ -848,8 +847,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
-		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
+		if (uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 31d1b1ff07b0..f12092cdb1f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9873,7 +9873,6 @@ static void i40e_vsi_link_event(struct i40e_vsi *vsi, bool link_up)
  **/
 static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 {
-	struct i40e_veb *veb_it;
 	struct i40e_vsi *vsi;
 	struct i40e_pf *pf;
 	int i;
@@ -9882,12 +9881,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 		return;
 	pf = veb->pf;
 
-	/* depth first... */
-	i40e_pf_for_each_veb(pf, i, veb_it)
-		if (veb_it->uplink_seid == veb->seid)
-			i40e_veb_link_event(veb_it, link_up);
-
-	/* ... now the local VSIs */
+	/* Send link event to contained VSIs */
 	i40e_pf_for_each_vsi(pf, i, vsi)
 		if (vsi->uplink_seid == veb->seid)
 			i40e_vsi_link_event(vsi, link_up);
@@ -10356,56 +10350,57 @@ static void i40e_config_bridge_mode(struct i40e_veb *veb)
 }
 
 /**
- * i40e_reconstitute_veb - rebuild the VEB and anything connected to it
+ * i40e_reconstitute_veb - rebuild the VEB and VSIs connected to it
  * @veb: pointer to the VEB instance
  *
- * This is a recursive function that first builds the attached VSIs then
- * recurses in to build the next layer of VEB.  We track the connections
- * through our own index numbers because the seid's from the HW could
- * change across the reset.
+ * This is a function that builds the attached VSIs. We track the connections
+ * through our own index numbers because the seid's from the HW could change
+ * across the reset.
  **/
 static int i40e_reconstitute_veb(struct i40e_veb *veb)
 {
 	struct i40e_vsi *ctl_vsi = NULL;
 	struct i40e_pf *pf = veb->pf;
-	struct i40e_veb *veb_it;
 	struct i40e_vsi *vsi;
 	int v, ret;
 
-	if (veb->uplink_seid) {
-		/* Look for VSI that owns this VEB, temporarily attached to base VEB */
-		i40e_pf_for_each_vsi(pf, v, vsi)
-			if (vsi->veb_idx == veb->idx &&
-			    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
-				ctl_vsi = vsi;
-				break;
-			}
+	/* As we do not maintain PV (port virtualizer) switch element then
+	 * there can be only one non-floating VEB that have uplink to MAC SEID
+	 * and its control VSI is the main one.
+	 */
+	if (WARN_ON(veb->uplink_seid && veb->uplink_seid != pf->mac_seid)) {
+		dev_err(&pf->pdev->dev,
+			"Invalid uplink SEID for VEB %d\n", veb->idx);
+		return -ENOENT;
+	}
 
-		if (!ctl_vsi) {
-			dev_info(&pf->pdev->dev,
-				 "missing owner VSI for veb_idx %d\n",
-				 veb->idx);
-			ret = -ENOENT;
-			goto end_reconstitute;
+	if (veb->uplink_seid == pf->mac_seid) {
+		/* Check that the LAN VSI has VEB owning flag set */
+		ctl_vsi = pf->vsi[pf->lan_vsi];
+
+		if (WARN_ON(ctl_vsi->veb_idx != veb->idx ||
+			    !(ctl_vsi->flags & I40E_VSI_FLAG_VEB_OWNER))) {
+			dev_err(&pf->pdev->dev,
+				"Invalid control VSI for VEB %d\n", veb->idx);
+			return -ENOENT;
 		}
-		if (ctl_vsi != pf->vsi[pf->lan_vsi])
-			ctl_vsi->uplink_seid =
-				pf->vsi[pf->lan_vsi]->uplink_seid;
 
+		/* Add the control VSI to switch */
 		ret = i40e_add_vsi(ctl_vsi);
 		if (ret) {
-			dev_info(&pf->pdev->dev,
-				 "rebuild of veb_idx %d owner VSI failed: %d\n",
-				 veb->idx, ret);
-			goto end_reconstitute;
+			dev_err(&pf->pdev->dev,
+				"Rebuild of owner VSI for VEB %d failed: %d\n",
+				veb->idx, ret);
+			return ret;
 		}
+
 		i40e_vsi_reset_stats(ctl_vsi);
 	}
 
 	/* create the VEB in the switch and move the VSI onto the VEB */
 	ret = i40e_add_veb(veb, ctl_vsi);
 	if (ret)
-		goto end_reconstitute;
+		return ret;
 
 	if (veb->uplink_seid) {
 		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
@@ -10427,23 +10422,12 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
 				dev_info(&pf->pdev->dev,
 					 "rebuild of vsi_idx %d failed: %d\n",
 					 v, ret);
-				goto end_reconstitute;
+				return ret;
 			}
 			i40e_vsi_reset_stats(vsi);
 		}
 	}
 
-	/* create any VEBs attached to this VEB - RECURSION */
-	i40e_pf_for_each_veb(pf, v, veb_it) {
-		if (veb_it->veb_idx == veb->idx) {
-			veb_it->uplink_seid = veb->seid;
-			ret = i40e_reconstitute_veb(veb_it);
-			if (ret)
-				break;
-		}
-	}
-
-end_reconstitute:
 	return ret;
 }
 
@@ -10984,31 +10968,29 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	 */
 	if (vsi->uplink_seid != pf->mac_seid) {
 		dev_dbg(&pf->pdev->dev, "attempting to rebuild switch\n");
-		/* find the one VEB connected to the MAC, and find orphans */
+
+		/* Rebuild VEBs */
 		i40e_pf_for_each_veb(pf, v, veb) {
-			if (veb->uplink_seid == pf->mac_seid ||
-			    veb->uplink_seid == 0) {
-				ret = i40e_reconstitute_veb(veb);
-				if (!ret)
-					continue;
-
-				/* If Main VEB failed, we're in deep doodoo,
-				 * so give up rebuilding the switch and set up
-				 * for minimal rebuild of PF VSI.
-				 * If orphan failed, we'll report the error
-				 * but try to keep going.
-				 */
-				if (veb->uplink_seid == pf->mac_seid) {
-					dev_info(&pf->pdev->dev,
-						 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
-						 ret);
-					vsi->uplink_seid = pf->mac_seid;
-					break;
-				} else if (veb->uplink_seid == 0) {
-					dev_info(&pf->pdev->dev,
-						 "rebuild of orphan VEB failed: %d\n",
-						 ret);
-				}
+			ret = i40e_reconstitute_veb(veb);
+			if (!ret)
+				continue;
+
+			/* If Main VEB failed, we're in deep doodoo,
+			 * so give up rebuilding the switch and set up
+			 * for minimal rebuild of PF VSI.
+			 * If orphan failed, we'll report the error
+			 * but try to keep going.
+			 */
+			if (veb->uplink_seid == pf->mac_seid) {
+				dev_info(&pf->pdev->dev,
+					 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
+					 ret);
+				vsi->uplink_seid = pf->mac_seid;
+				break;
+			} else if (veb->uplink_seid == 0) {
+				dev_info(&pf->pdev->dev,
+					 "rebuild of orphan VEB failed: %d\n",
+					 ret);
 			}
 		}
 	}
@@ -14124,9 +14106,9 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
  **/
 int i40e_vsi_release(struct i40e_vsi *vsi)
 {
-	struct i40e_veb *veb, *veb_it;
 	struct i40e_mac_filter *f;
 	struct hlist_node *h;
+	struct i40e_veb *veb;
 	struct i40e_pf *pf;
 	u16 uplink_seid;
 	int i, n, bkt;
@@ -14190,27 +14172,28 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 
 	/* If this was the last thing on the VEB, except for the
 	 * controlling VSI, remove the VEB, which puts the controlling
-	 * VSI onto the next level down in the switch.
+	 * VSI onto the uplink port.
 	 *
 	 * Well, okay, there's one more exception here: don't remove
-	 * the orphan VEBs yet.  We'll wait for an explicit remove request
+	 * the floating VEBs yet.  We'll wait for an explicit remove request
 	 * from up the network stack.
 	 */
-	n = 0;
-	i40e_pf_for_each_vsi(pf, i, vsi)
-		if (vsi->uplink_seid == uplink_seid &&
-		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
-			n++;      /* count the VSIs */
+	veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
+	if (veb && veb->uplink_seid) {
+		n = 0;
 
-	veb = NULL;
-	i40e_pf_for_each_veb(pf, i, veb_it) {
-		if (veb_it->uplink_seid == uplink_seid)
-			n++;     /* count the VEBs */
-		if (veb_it->seid == uplink_seid)
-			veb = veb_it;
+		/* Count non-controlling VSIs present on  the VEB */
+		i40e_pf_for_each_vsi(pf, i, vsi)
+			if (vsi->uplink_seid == uplink_seid &&
+			    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
+				n++;
+
+		/* If there is no VSI except the control one then release
+		 * the VEB and put the control VSI onto VEB uplink.
+		 */
+		if (!n)
+			i40e_veb_release(veb);
 	}
-	if (n == 0 && veb && veb->uplink_seid != 0)
-		i40e_veb_release(veb);
 
 	return 0;
 }
@@ -14724,14 +14707,11 @@ void i40e_veb_release(struct i40e_veb *veb)
 		return;
 	}
 
-	/* For regular VEB move the owner VSI to uplink VEB */
+	/* For regular VEB move the owner VSI to uplink port */
 	if (veb->uplink_seid) {
 		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
 		vsi->uplink_seid = veb->uplink_seid;
-		if (veb->uplink_seid == pf->mac_seid)
-			vsi->veb_idx = I40E_NO_VEB;
-		else
-			vsi->veb_idx = veb->veb_idx;
+		vsi->veb_idx = I40E_NO_VEB;
 	}
 
 	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
@@ -14811,8 +14791,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 				u16 uplink_seid, u16 vsi_seid,
 				u8 enabled_tc)
 {
-	struct i40e_veb *veb, *uplink_veb = NULL;
 	struct i40e_vsi *vsi = NULL;
+	struct i40e_veb *veb;
 	int veb_idx;
 	int ret;
 
@@ -14834,14 +14814,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 			return NULL;
 		}
 	}
-	if (uplink_seid && uplink_seid != pf->mac_seid) {
-		uplink_veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
-		if (!uplink_veb) {
-			dev_info(&pf->pdev->dev,
-				 "uplink seid %d not found\n", uplink_seid);
-			return NULL;
-		}
-	}
 
 	/* get veb sw struct */
 	veb_idx = i40e_veb_mem_alloc(pf);
@@ -14850,7 +14822,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	veb = pf->veb[veb_idx];
 	veb->flags = flags;
 	veb->uplink_seid = uplink_seid;
-	veb->veb_idx = (uplink_veb ? uplink_veb->idx : I40E_NO_VEB);
 	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
 
 	/* create the VEB in the switch */
@@ -14921,7 +14892,6 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 		pf->veb[pf->lan_veb]->seid = seid;
 		pf->veb[pf->lan_veb]->uplink_seid = pf->mac_seid;
 		pf->veb[pf->lan_veb]->pf = pf;
-		pf->veb[pf->lan_veb]->veb_idx = I40E_NO_VEB;
 		break;
 	case I40E_SWITCH_ELEMENT_TYPE_VSI:
 		if (num_reported != 1)
-- 
2.41.0


