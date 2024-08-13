Return-Path: <netdev+bounces-118232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4A950FB2
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D47B1C224EB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DFA1AD3E5;
	Tue, 13 Aug 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4dU8eWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF21AC43E
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587785; cv=none; b=fEWKaZy+n5DTekNFu0TZRz4CNzrCPX1/PaxAK0S8yxkHIKcAe+bbDnWgvCTzSJzRoMNA4yWxFhKqYjF2hQjJ/WZefo5VyNIn9cdJAqMKuZo++6fafqt8Clpuz93Sf0lc5OdxqO4Am1jDOrmRCzWfHQ9NEv7+xzMyZPabPafYhnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587785; c=relaxed/simple;
	bh=tbYV53tO1ExEVxJSZAHIvE3/sh+rRMVQRouoky16wH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHsQ4XMMATpWi/B9H3/i3CAtWfRXo5ymnsJgvlmiQG2jO3oJKwtL/vW5ENK36DEHERND4zXR/7gQ7/0yroksCOe2vY/FKYNK43LcVEd+CGCFQPr4gGIFnAnVmBbTaWscgEX8v5xdqndcElIJRGkQzMFnkIBbz4MPlAM1ywM5BoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4dU8eWZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723587784; x=1755123784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbYV53tO1ExEVxJSZAHIvE3/sh+rRMVQRouoky16wH8=;
  b=K4dU8eWZTsCG12OFsSa4sopnVmYdZWcEGCS6evUutp5wAivudMn3wDeK
   1yTCRJFQKPyTolQUCx6YHiP+neW5oyd7x+LrsFQ/5s6HG5w6TVKGTBbLZ
   dbBZD+Y9EMzwcJUi8V8TsDkVdXL9n0p3WOYlp+7ovOuM5k0rqGfC5RTy0
   +DK/9YyJG6AQHACHhPeyfPY5drlcLjuSqgm5YiXjzKWJFmc8FgfI6wzxc
   6B+hfYzQCA894ZdviPQoKVLb7ly0h5MDj0XGRBa11BxDzYJwRmkYg4e7U
   pLFWCRc30lPqyO/3cMnGJxcNai4VLz2Oi6WtQk0T4eVBqXXU1lsIKbkJw
   w==;
X-CSE-ConnectionGUID: C+x+E7ARQDuhrnXBwaCUcg==
X-CSE-MsgGUID: IYWLpSbTSC6T5FdntYtjZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39287141"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="39287141"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 15:22:56 -0700
X-CSE-ConnectionGUID: iRu2wgxuThSZpMUyG5HbgQ==
X-CSE-MsgGUID: ZP3agfc3SR+waSQaBN5ONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="59381092"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 15:22:55 -0700
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
Subject: [PATCH net-next v2 12/13] iavf: refactor add/del FDIR filters
Date: Tue, 13 Aug 2024 15:22:47 -0700
Message-ID: <20240813222249.3708070-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
References: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
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


