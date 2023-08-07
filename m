Return-Path: <netdev+bounces-25132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F97730BD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4101B28106C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4416411;
	Mon,  7 Aug 2023 20:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C64435
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:56:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07376E50
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691441806; x=1722977806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sCV61Rbcsp52JCF6caWTFuias6m/kh+m6qvTURVT08A=;
  b=Z0Lfuwugu0X7+/USqLbgaQ9zv+LmxUHyA3qCW66b1sJBLM7K86yUZ9tw
   TfXutOBKJQT07ci2JFtGVliVFxFA3FfLVhpwL8MVcM7Paj8Mq/vkR/SvC
   N+qvDLlEgUd33801dNlSZoYFhs1sZhOiqUWL/fcVlTm/MsS2ZNwawBHu5
   ORcgN+UwqIVaZGXC9RmKw7fr936cQPwXL2eLS6zXG9tEOmh/ZMuyBqZtQ
   9JJWLciR7z/EnT7D6o1uQr04LIZ3dGvBYMwf8pSAPGuc4NxG9dY8jA2/c
   W/nXU5mOPv2kL56uxThzAarqy1AZczP00P98W5EZAUCiKZqF0n2HoZlK2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350952764"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="350952764"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708015798"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="708015798"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2023 13:56:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Piotr Gardocki <piotrx.gardocki@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net] iavf: fix potential races for FDIR filters
Date: Mon,  7 Aug 2023 13:50:11 -0700
Message-Id: <20230807205011.3129224-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Piotr Gardocki <piotrx.gardocki@intel.com>

Add fdir_fltr_lock locking in unprotected places.

The change in iavf_fdir_is_dup_fltr adds a spinlock around a loop which
iterates over all filters and looks for a duplicate. The filter can be
removed from list and freed from memory at the same time it's being
compared. All other places where filters are deleted are already
protected with spinlock.

The remaining changes protect adapter->fdir_active_fltr variable so now
all its uses are under a spinlock.

Fixes: 527691bf0682 ("iavf: Support IPv4 Flow Director filters")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  5 ++++-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c    | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 2f47cfa7f06e..460ca561819a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1401,14 +1401,15 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	if (fsp->flow_type & FLOW_MAC_EXT)
 		return -EINVAL;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
 	if (adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS) {
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		dev_err(&adapter->pdev->dev,
 			"Unable to add Flow Director filter because VF reached the limit of max allowed filters (%u)\n",
 			IAVF_MAX_FDIR_FILTERS);
 		return -ENOSPC;
 	}
 
-	spin_lock_bh(&adapter->fdir_fltr_lock);
 	if (iavf_find_fdir_fltr_by_loc(adapter, fsp->location)) {
 		dev_err(&adapter->pdev->dev, "Failed to add Flow Director filter, it already exists\n");
 		spin_unlock_bh(&adapter->fdir_fltr_lock);
@@ -1781,7 +1782,9 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLCNT:
 		if (!FDIR_FLTR_SUPPORT(adapter))
 			break;
+		spin_lock_bh(&adapter->fdir_fltr_lock);
 		cmd->rule_cnt = adapter->fdir_active_fltr;
+		spin_unlock_bh(&adapter->fdir_fltr_lock);
 		cmd->data = IAVF_MAX_FDIR_FILTERS;
 		ret = 0;
 		break;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 6146203efd84..505e82ebafe4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -722,7 +722,9 @@ void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *f
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
 {
 	struct iavf_fdir_fltr *tmp;
+	bool ret = false;
 
+	spin_lock_bh(&adapter->fdir_fltr_lock);
 	list_for_each_entry(tmp, &adapter->fdir_list_head, list) {
 		if (tmp->flow_type != fltr->flow_type)
 			continue;
@@ -732,11 +734,14 @@ bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *
 		    !memcmp(&tmp->ip_data, &fltr->ip_data,
 			    sizeof(fltr->ip_data)) &&
 		    !memcmp(&tmp->ext_data, &fltr->ext_data,
-			    sizeof(fltr->ext_data)))
-			return true;
+			    sizeof(fltr->ext_data))) {
+			ret = true;
+			break;
+		}
 	}
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	return false;
+	return ret;
 }
 
 /**
-- 
2.38.1


