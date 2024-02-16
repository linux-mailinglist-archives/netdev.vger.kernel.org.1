Return-Path: <netdev+bounces-72555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03785882C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C051B23C78
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4541314830E;
	Fri, 16 Feb 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN0aLP3M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53A1482E2
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119792; cv=none; b=UPPNCt5IsTOXd1K+FFqKmgt+N4hNlU/QzcTG4mjv9eqIhMm9a5wpiu7wG3xoYmyvqq68Er08hql9OuvXe6WWpMiRd33nwhc8BFJA3Vh9L36aMhTma2tZJDKhtsz5sEsOfXIvehlSZm87zElZHEEBBhmk5jjJJziahrz9pBBbKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119792; c=relaxed/simple;
	bh=k+aC6nfF351NJURg4qPcKZaKk2yrdrNEtyf8bk/tKwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfEQexJbF1esSI9dMNzrhBKrLkIdYZVPGkiVrVXFTLwt37TZyY/ATwDUb08IQd4t0t5MEz71oGB5Nh/ALd5IWHz94IZgSdT3yREtCg1p4kh79FVe/HE7IWZNkbIGOFiq4QICkLmdKuJJnVhOQfsxn0tkAiEIz41kHVe/tSSx8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN0aLP3M; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119791; x=1739655791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+aC6nfF351NJURg4qPcKZaKk2yrdrNEtyf8bk/tKwo=;
  b=cN0aLP3M1LTcyDy9DGpRcfz5xjsKnohFPxhGqezwtcZbofH934+evjPv
   y519Nc079yOJgb5rsFg4LUQwvCzjOCjsS5x4JUBkVto0qf2Uce6Fuho/A
   OMEFMgPje9m9NqGSOX+bo2r9OuoVUX+tu0HC3lq1Xs8oMhalHa7zqq29C
   HHE+HGjOrDJcynew3jdU5/6oYK/ei3V7piH5EULqhCfSFcXGX+v9JEE8K
   5MzomjkeBj3pPKpVN0ONQin32mTSC+/CujBxCpy2ysYtgC1Spzi58MogR
   YttPWb69nbSfcoXRLXHTipVmi86G8yWsntjF8SOM2AbJYJK4k42gztoPj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2122885"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2122885"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8618678"
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
Subject: [PATCH net-next 3/5] i40e: Add helpers to find VSI and VEB by SEID and use them
Date: Fri, 16 Feb 2024 13:42:40 -0800
Message-ID: <20240216214243.764561-4-anthony.l.nguyen@intel.com>
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

Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
VEB or VSI by their SEID value and use these helpers to replace
existing open-coded loops.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 36 +++++++++
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 80 +++++++------------
 3 files changed, 68 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5acb26644be7..2990ff4f0306 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1355,4 +1355,40 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
 
 struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 
+/**
+ * i40e_pf_get_vsi_by_seid - find VSI by SEID
+ * @pf: pointer to a PF
+ * @seid: SEID of the VSI
+ **/
+static inline struct i40e_vsi *
+i40e_pf_get_vsi_by_seid(struct i40e_pf *pf, u16 seid)
+{
+	struct i40e_vsi *vsi;
+	int i;
+
+	i40e_pf_for_each_vsi(pf, i, vsi)
+		if (vsi->seid == seid)
+			return vsi;
+
+	return NULL;
+}
+
+/**
+ * i40e_pf_get_veb_by_seid - find VEB by SEID
+ * @pf: pointer to a PF
+ * @seid: SEID of the VSI
+ **/
+static inline struct i40e_veb *
+i40e_pf_get_veb_by_seid(struct i40e_pf *pf, u16 seid)
+{
+	struct i40e_veb *veb;
+	int i;
+
+	i40e_pf_for_each_veb(pf, i, veb)
+		if (veb->seid == seid)
+			return veb;
+
+	return NULL;
+}
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index b236b0f93202..990a60889eef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -24,37 +24,13 @@ enum ring_type {
  **/
 static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
 {
-	struct i40e_vsi *vsi;
-	int i;
-
 	if (seid < 0) {
 		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
 
 		return NULL;
 	}
 
-	i40e_pf_for_each_vsi(pf, i, vsi)
-		if (vsi->seid == seid)
-			return vsi;
-
-	return NULL;
-}
-
-/**
- * i40e_dbg_find_veb - searches for the veb with the given seid
- * @pf: the PF structure to search for the veb
- * @seid: seid of the veb it is searching for
- **/
-static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
-{
-	struct i40e_veb *veb;
-	int i;
-
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == seid)
-			return veb;
-
-	return NULL;
+	return i40e_pf_get_vsi_by_seid(pf, seid);
 }
 
 /**************************************************************
@@ -701,7 +677,7 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
 {
 	struct i40e_veb *veb;
 
-	veb = i40e_dbg_find_veb(pf, seid);
+	veb = i40e_pf_get_veb_by_seid(pf, seid);
 	if (!veb) {
 		dev_info(&pf->pdev->dev, "can't find veb %d\n", seid);
 		return;
@@ -853,7 +829,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
 		struct i40e_veb *veb;
-		int uplink_seid, i;
+		int uplink_seid;
 
 		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
 		if (cnt != 2) {
@@ -875,12 +851,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		i40e_pf_for_each_veb(pf, i, veb)
-			if (veb->seid == uplink_seid)
-				break;
-
-		if (i >= I40E_MAX_VEB && uplink_seid != 0 &&
-		    uplink_seid != pf->mac_seid) {
+		veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
+		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 43e1b4f7f9dc..e495a212d076 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13106,18 +13106,14 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	struct i40e_pf *pf = vsi->back;
 	struct nlattr *attr, *br_spec;
 	struct i40e_veb *veb;
-	int i, rem;
+	int rem;
 
 	/* Only for PF VSI for now */
 	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for PF VSI */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == vsi->uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
-		veb = NULL; /* No VEB found */
+	veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
 
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (!br_spec)
@@ -13182,18 +13178,15 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	struct i40e_veb *veb = NULL;
-	int i;
+	struct i40e_veb *veb;
 
 	/* Only for PF VSI for now */
 	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for the PF VSI */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == vsi->uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
+	veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
+	if (!veb)
 		return 0;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
@@ -14368,8 +14361,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	struct i40e_vsi *vsi = NULL;
 	struct i40e_veb *veb = NULL;
 	u16 alloc_queue_pairs;
-	int ret, i;
 	int v_idx;
+	int ret;
 
 	/* The requested uplink_seid must be either
 	 *     - the PF's port seid
@@ -14384,18 +14377,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	 *
 	 * Find which uplink_seid we were given and create a new VEB if needed
 	 */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
-		veb = NULL;
-
+	veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
 	if (!veb && uplink_seid != pf->mac_seid) {
-		i40e_pf_for_each_vsi(pf, i, vsi)
-			if (vsi->seid == uplink_seid)
-				break;
-
-		if (i == pf->num_alloc_vsi) {
+		vsi = i40e_pf_get_vsi_by_seid(pf, uplink_seid);
+		if (!vsi) {
 			dev_info(&pf->pdev->dev, "no such uplink_seid %d\n",
 				 uplink_seid);
 			return NULL;
@@ -14423,10 +14408,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 			}
 			i40e_config_bridge_mode(veb);
 		}
-		i40e_pf_for_each_veb(pf, i, veb)
-			if (veb->seid == vsi->uplink_seid)
-				break;
-		if (i == I40E_MAX_VEB) {
+		veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
+		if (!veb) {
 			dev_info(&pf->pdev->dev, "couldn't add VEB\n");
 			return NULL;
 		}
@@ -14820,8 +14803,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 				u8 enabled_tc)
 {
 	struct i40e_veb *veb, *uplink_veb = NULL;
-	struct i40e_vsi *vsi;
-	int vsi_idx, veb_idx;
+	struct i40e_vsi *vsi = NULL;
+	int veb_idx;
 	int ret;
 
 	/* if one seid is 0, the other must be 0 to create a floating relay */
@@ -14834,23 +14817,16 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	}
 
 	/* make sure there is such a vsi and uplink */
-	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
-		if (vsi->seid == vsi_seid)
-			break;
-
-	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
-		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
-			 vsi_seid);
-		return NULL;
+	if (vsi_seid) {
+		vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
+		if (!vsi) {
+			dev_err(&pf->pdev->dev, "vsi seid %d not found\n",
+				vsi_seid);
+			return NULL;
+		}
 	}
-
 	if (uplink_seid && uplink_seid != pf->mac_seid) {
-		i40e_pf_for_each_veb(pf, veb_idx, veb) {
-			if (veb->seid == uplink_seid) {
-				uplink_veb = veb;
-				break;
-			}
-		}
+		uplink_veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
 		if (!uplink_veb) {
 			dev_info(&pf->pdev->dev,
 				 "uplink seid %d not found\n", uplink_seid);
@@ -14872,7 +14848,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	ret = i40e_add_veb(veb, vsi);
 	if (ret)
 		goto err_veb;
-	if (vsi_idx == pf->lan_vsi)
+
+	if (vsi && vsi->idx == pf->lan_vsi)
 		pf->lan_veb = veb->idx;
 
 	return veb;
@@ -14919,13 +14896,10 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 			int v;
 
 			/* find existing or else empty VEB */
-			i40e_pf_for_each_veb(pf, v, veb)
-				if (veb->seid == seid) {
-					pf->lan_veb = v;
-					break;
-				}
-
-			if (pf->lan_veb >= I40E_MAX_VEB) {
+			veb = i40e_pf_get_veb_by_seid(pf, seid);
+			if (veb) {
+				pf->lan_veb = veb->idx;
+			} else {
 				v = i40e_veb_mem_alloc(pf);
 				if (v < 0)
 					break;
-- 
2.41.0


