Return-Path: <netdev+bounces-112874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E707E93B8B5
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A3F1C23C3F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45013CFA8;
	Wed, 24 Jul 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyEDrS8u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C913D244
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857080; cv=none; b=oJr9GOCJ6NsYkMbKTyr3k17lQ3SK8gRr6e/XSIdi2WtDlB9oAn8Q0rD8IY/orcauSo0nQA2Xadv5hKrJpxp0aIKGouxnPCeSZK/kfNXu15moybEcmmn1YOPn5y+Lh1vv/aJ7tpT3iQ/GX0ufjHpi+Cyrv5eqajqUHwCHnlYNX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857080; c=relaxed/simple;
	bh=VYQaSRllBQc8Wi/fV7TDm0mP4oAlXANENAd0ktwhnZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6MUezT/pDvpzJaVazOOTObrIb3rx3nJDAj60++jzGch/AgWbr+2FurJoIHQbvYAGBfyY1jNADBoxBbNeZzRXOyKy3K9y8CqDRXlgAtDUKqqUE8xrUEQclQks5+DLdkWVD7dYOCyovtzJ4e3zg49Wb/glogkht0xPCt7ZGUxOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyEDrS8u; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857079; x=1753393079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYQaSRllBQc8Wi/fV7TDm0mP4oAlXANENAd0ktwhnZ8=;
  b=GyEDrS8uyqyvjVzR8Cy6zD/O/W5O7bJOpNUvUdImkG5uyl9U1T+fAnPH
   MQjnbQgVv6t5gOjqX47gz7R7GFj9K0JGlixBl4peckamvDw2q0XwwZGFw
   96mKJSSSJKYcFcBNOp6wBs25ALAFwGO6b3owJfSC7UC+RdL4CWug8k90A
   WiAxl6gXEbJqWdl0r8iVy2dj0VrnAb2voUNZVt/lB5HiQFcWtISbr0RrD
   Pg1NxFKq6P4PfLLX+6Tpht7m8E5xU1sZ8RSCcBUYXx33BCq8yMs+fWSuO
   485BZ449AzI92qPxYN2SMcV2IWIEvf5JCAayrb/K+05RhNiZf8b2ceFCk
   w==;
X-CSE-ConnectionGUID: Yf4jLCvLTQu9KxOMcMXV0g==
X-CSE-MsgGUID: L5wM/aStQqOH/R21ABAgrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19704319"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19704319"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:37:59 -0700
X-CSE-ConnectionGUID: wCUYgN+VQXmXXejuafAziA==
X-CSE-MsgGUID: uOOoq0UwQa6mI8eMXBNpkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52579663"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.206])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:37:55 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH iwl-next v4 12/13] iavf: refactor add/del FDIR filters
Date: Wed, 24 Jul 2024 15:36:21 -0600
Message-ID: <20240724213623.324532-13-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724213623.324532-1-ahmed.zaki@intel.com>
References: <20240724213623.324532-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.43.0


