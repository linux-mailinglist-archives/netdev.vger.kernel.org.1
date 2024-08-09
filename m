Return-Path: <netdev+bounces-117266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A734D94D58A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC40A1C215BA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5A7B3E1;
	Fri,  9 Aug 2024 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qc+8v3vv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643415A842
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225004; cv=none; b=gyJGkwbH98/k/8GspEcUVd5/bRNMuLJfUXQqdWvZky7zJ1L5hrtYxLEV+BBp3Zn8x1v3MtfFTFEFwVxR4MUTfKkkmWdhqxAjhSRBNP4NFCMzbJtODzi+kxqcJXlgCvXsmiYi1+eq6iZaKRD42xt46pMLeGNrHudo2ulQmt5ktPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225004; c=relaxed/simple;
	bh=tbYV53tO1ExEVxJSZAHIvE3/sh+rRMVQRouoky16wH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7iR/qunTwzBj2lX8G5lll3ju1Womcf9jZ4HDsiGBRWSJdflk46gZ1pkeNppbcQTWI5oqAab258gZ3qy0+NwR39UAF8rlUd2tdJpDNN6qiD74/nD17qNO02ZiGPMQrEyf+WG/1xx4s7MviZgH7lr4WyeqrRWl4Iygqqprga+mvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qc+8v3vv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723225002; x=1754761002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbYV53tO1ExEVxJSZAHIvE3/sh+rRMVQRouoky16wH8=;
  b=Qc+8v3vvWNwlx2cnMPW7nuQQ1Q7oM3pS+LR76B3jOuMKryjmEtdt39lI
   6c/GrgCj8Oq+zS+eptIG7h31rPIJ14dTuRJjpd3BXDMSmqefMdZcC+btV
   pnwMkLNwvF3t4wIA13CqbQNj+Ab2cSskqZmxc+fBo8j8QPyw+bBNK2+Q6
   goCrSaREosoaFLNwUacCU1/C1B3VzjSVX2678cQY+11S67L3Q8r1/FbTq
   dbpicFB7JariGz7viDUKTXYx/QqT7HhNGIRnsPYQ3uAyq8/lbyRN1YtsV
   xLqGY6ZQMqikxKdLNAFQrTv+tPLyFtt+pW8MS1MxrtOdaFETcQqizvOYP
   g==;
X-CSE-ConnectionGUID: mjC4lozXTxWiSr+NFRjxDg==
X-CSE-MsgGUID: WGYCxIpwQjyQZiscy8fPHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21551334"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21551334"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:36:33 -0700
X-CSE-ConnectionGUID: 8Ibq78OeSi6UFtjyQFUKoA==
X-CSE-MsgGUID: tHLmwgL+SCKXaINKes7Onw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57589210"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 10:36:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 12/13] iavf: refactor add/del FDIR filters
Date: Fri,  9 Aug 2024 10:36:11 -0700
Message-ID: <20240809173615.2031516-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
References: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

In preparation for a second type of FDIR filters that can be added by
tc-u32, move the add/del of the FDIR logic to be entirely contained in
iavf_fdir.c.

The iavf_find_fdir_fltr_by_loc() is renamed to iavf_find_fdir_fltr()
to be more agnostic to the filter ID parameter (for now @loc, which is
relevant only to current FDIR filters added via ethtool).

The FDIR filter deletion is moved from iavf_del_fdir_ethtool() in
ethtool.c to iavf_fdir_del_fltr(). While at it, fix a minor bug where
the "fltr" is accessed out of the fdir_fltr_lock spinlock protection.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  5 ++
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 56 ++-------------
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 72 +++++++++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  7 +-
 4 files changed, 83 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 23a6557fc3db..dfed22baebf8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -444,6 +444,11 @@ struct iavf_adapter {
 	spinlock_t adv_rss_lock;	/* protect the RSS management list */
 };
 
+/* Must be called with fdir_fltr_lock lock held */
+static inline bool iavf_fdir_max_reached(struct iavf_adapter *adapter)
+{
+	return adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS;
+}
 
 /* Ethtool Private Flags */
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 52273f7eab2c..7ab445eeee18 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -927,7 +927,7 @@ iavf_get_ethtool_fdir_entry(struct iavf_adapter *adapter,
 
 	spin_lock_bh(&adapter->fdir_fltr_lock);
 
-	rule = iavf_find_fdir_fltr_by_loc(adapter, fsp->location);
+	rule = iavf_find_fdir_fltr(adapter, fsp->location);
 	if (!rule) {
 		ret = -EINVAL;
 		goto release_lock;
@@ -1263,15 +1263,7 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 		return -EINVAL;
 
 	spin_lock_bh(&adapter->fdir_fltr_lock);
-	if (adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS) {
-		spin_unlock_bh(&adapter->fdir_fltr_lock);
-		dev_err(&adapter->pdev->dev,
-			"Unable to add Flow Director filter because VF reached the limit of max allowed filters (%u)\n",
-			IAVF_MAX_FDIR_FILTERS);
-		return -ENOSPC;
-	}
-
-	if (iavf_find_fdir_fltr_by_loc(adapter, fsp->location)) {
+	if (iavf_find_fdir_fltr(adapter, fsp->location)) {
 		dev_err(&adapter->pdev->dev, "Failed to add Flow Director filter, it already exists\n");
 		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		return -EEXIST;
@@ -1291,23 +1283,10 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	}
 
 	err = iavf_add_fdir_fltr_info(adapter, fsp, fltr);
-	if (err)
-		goto ret;
-
-	spin_lock_bh(&adapter->fdir_fltr_lock);
-	iavf_fdir_list_add_fltr(adapter, fltr);
-	adapter->fdir_active_fltr++;
-
-	if (adapter->link_up)
-		fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-	else
-		fltr->state = IAVF_FDIR_FLTR_INACTIVE;
-	spin_unlock_bh(&adapter->fdir_fltr_lock);
+	if (!err)
+		err = iavf_fdir_add_fltr(adapter, fltr);
 
-	if (adapter->link_up)
-		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
-ret:
-	if (err && fltr)
+	if (err)
 		kfree(fltr);
 
 	mutex_unlock(&adapter->crit_lock);
@@ -1324,34 +1303,11 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
-	struct iavf_fdir_fltr *fltr = NULL;
-	int err = 0;
 
 	if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 		return -EOPNOTSUPP;
 
-	spin_lock_bh(&adapter->fdir_fltr_lock);
-	fltr = iavf_find_fdir_fltr_by_loc(adapter, fsp->location);
-	if (fltr) {
-		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
-			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
-		} else if (fltr->state == IAVF_FDIR_FLTR_INACTIVE) {
-			list_del(&fltr->list);
-			kfree(fltr);
-			adapter->fdir_active_fltr--;
-			fltr = NULL;
-		} else {
-			err = -EBUSY;
-		}
-	} else if (adapter->fdir_active_fltr) {
-		err = -EINVAL;
-	}
-	spin_unlock_bh(&adapter->fdir_fltr_lock);
-
-	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
-		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
-
-	return err;
+	return iavf_fdir_del_fltr(adapter, fsp->location);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 2d47b0b4640e..1e1daf71dfa0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -815,13 +815,14 @@ bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *
 }
 
 /**
- * iavf_find_fdir_fltr_by_loc - find filter with location
+ * iavf_find_fdir_fltr - find FDIR filter
  * @adapter: pointer to the VF adapter structure
  * @loc: location to find.
  *
- * Returns pointer to Flow Director filter if found or null
+ * Returns: pointer to Flow Director filter if found or NULL. Lock must be held.
  */
-struct iavf_fdir_fltr *iavf_find_fdir_fltr_by_loc(struct iavf_adapter *adapter, u32 loc)
+struct iavf_fdir_fltr *iavf_find_fdir_fltr(struct iavf_adapter *adapter,
+					   u32 loc)
 {
 	struct iavf_fdir_fltr *rule;
 
@@ -833,14 +834,26 @@ struct iavf_fdir_fltr *iavf_find_fdir_fltr_by_loc(struct iavf_adapter *adapter,
 }
 
 /**
- * iavf_fdir_list_add_fltr - add a new node to the flow director filter list
+ * iavf_fdir_add_fltr - add a new node to the flow director filter list
  * @adapter: pointer to the VF adapter structure
  * @fltr: filter node to add to structure
+ *
+ * Return: 0 on success or negative errno on failure.
  */
-void iavf_fdir_list_add_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
+int iavf_fdir_add_fltr(struct iavf_adapter *adapter,
+		       struct iavf_fdir_fltr *fltr)
 {
 	struct iavf_fdir_fltr *rule, *parent = NULL;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
+	if (iavf_fdir_max_reached(adapter)) {
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
+		dev_err(&adapter->pdev->dev,
+			"Unable to add Flow Director filter (limit (%u) reached)\n",
+			IAVF_MAX_FDIR_FILTERS);
+		return -ENOSPC;
+	}
+
 	list_for_each_entry(rule, &adapter->fdir_list_head, list) {
 		if (rule->loc >= fltr->loc)
 			break;
@@ -851,4 +864,53 @@ void iavf_fdir_list_add_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr
 		list_add(&fltr->list, &parent->list);
 	else
 		list_add(&fltr->list, &adapter->fdir_list_head);
+	adapter->fdir_active_fltr++;
+
+	if (adapter->link_up)
+		fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
+	else
+		fltr->state = IAVF_FDIR_FLTR_INACTIVE;
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
+
+	if (adapter->link_up)
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
+
+	return 0;
+}
+
+/**
+ * iavf_fdir_del_fltr - delete a flow director filter from the list
+ * @adapter: pointer to the VF adapter structure
+ * @loc: location to delete.
+ *
+ * Return: 0 on success or negative errno on failure.
+ */
+int iavf_fdir_del_fltr(struct iavf_adapter *adapter, u32 loc)
+{
+	struct iavf_fdir_fltr *fltr = NULL;
+	int err = 0;
+
+	spin_lock_bh(&adapter->fdir_fltr_lock);
+	fltr = iavf_find_fdir_fltr(adapter, loc);
+
+	if (fltr) {
+		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
+			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
+		} else if (fltr->state == IAVF_FDIR_FLTR_INACTIVE) {
+			list_del(&fltr->list);
+			kfree(fltr);
+			adapter->fdir_active_fltr--;
+			fltr = NULL;
+		} else {
+			err = -EBUSY;
+		}
+	} else if (adapter->fdir_active_fltr) {
+		err = -EINVAL;
+	}
+
+	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
+
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
+	return err;
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.h b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
index d31bd923ba8c..5c85eb25fa2a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
@@ -128,6 +128,9 @@ int iavf_validate_fdir_fltr_masks(struct iavf_adapter *adapter,
 int iavf_fill_fdir_add_msg(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
 void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
-void iavf_fdir_list_add_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
-struct iavf_fdir_fltr *iavf_find_fdir_fltr_by_loc(struct iavf_adapter *adapter, u32 loc);
+int iavf_fdir_add_fltr(struct iavf_adapter *adapter,
+		       struct iavf_fdir_fltr *fltr);
+int iavf_fdir_del_fltr(struct iavf_adapter *adapter, u32 loc);
+struct iavf_fdir_fltr *iavf_find_fdir_fltr(struct iavf_adapter *adapter,
+					   u32 loc);
 #endif /* _IAVF_FDIR_H_ */
-- 
2.42.0


