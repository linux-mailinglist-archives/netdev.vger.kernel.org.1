Return-Path: <netdev+bounces-51474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36C7FAC56
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD961C20E55
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9991146522;
	Mon, 27 Nov 2023 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKtnpxCt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52939D5F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701119446; x=1732655446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVNCFxlQxCkzYPDZ+Wbo7x2fKrLpg/sKPxzfXJMB4xI=;
  b=EKtnpxCtGPYYt8Ngit0GTxFYAYNGb/ocOiu+qYDCbNtTACbj1AFg/GC9
   OuDKrhjPXNjh9FBG16+aT6ArJYRclLyMYx1HJpHHQqNh4fE5JltSERfvg
   YR8SWtAumrFdnwqk7US3IMfuEGOgbtMGAtDGqFgv5/7aM6UKoPrZ/Ju1Z
   k9O+ED+mBN/1cVygJPynLp0Z6HKeUL1dJ/6Z8luQemjjvEBWcrgCxyMmC
   zi3YnIHiptSerf/oymqT3kOGlbe6aaGzYwRcixrj5bcInLGdvcdfkR/zZ
   JPX+E8qo6N3Z0JR16UoQ554gkfIhCa49ZRf6Wk2N+cD86iOFQrEEbyOS8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="5982927"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="5982927"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9724685"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2023 13:10:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 5/5] iavf: use iavf_schedule_aq_request() helper
Date: Mon, 27 Nov 2023 13:10:35 -0800
Message-ID: <20231127211037.1135403-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
References: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Oros <poros@redhat.com>

Use the iavf_schedule_aq_request() helper when we need to
schedule a watchdog task immediately. No functional change.

Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 10 +++-------
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 15 +++++----------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 6f236d1a6444..6b3d3e54b8b7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1445,10 +1445,9 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	iavf_fdir_list_add_fltr(adapter, fltr);
 	adapter->fdir_active_fltr++;
 	fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
 
 ret:
 	if (err && fltr)
@@ -1479,7 +1478,6 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	if (fltr) {
 		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
 			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		} else {
 			err = -EBUSY;
 		}
@@ -1489,7 +1487,7 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
 	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
 
 	return err;
 }
@@ -1658,7 +1656,6 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 			rss_old->hash_flds = hash_flds;
 			memcpy(&rss_old->cfg_msg, &rss_new->cfg_msg,
 			       sizeof(rss_new->cfg_msg));
-			adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 		} else {
 			err = -EEXIST;
 		}
@@ -1668,12 +1665,11 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 		rss_new->packet_hdrs = hdrs;
 		rss_new->hash_flds = hash_flds;
 		list_add_tail(&rss_new->list, &adapter->adv_rss_list_head);
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 	}
 	spin_unlock_bh(&adapter->adv_rss_lock);
 
 	if (!err)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_ADV_RSS_CFG);
 
 	mutex_unlock(&adapter->crit_lock);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 27d63b605638..06a87030c163 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1059,13 +1059,12 @@ static int iavf_replace_primary_mac(struct iavf_adapter *adapter,
 	 */
 	new_f->is_primary = true;
 	new_f->add = true;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
 	ether_addr_copy(hw->mac.addr, new_mac);
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	/* schedule the watchdog task to immediately process the request */
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_MAC_FILTER);
 	return 0;
 }
 
@@ -1284,8 +1283,7 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
 
 	iavf_napi_enable_all(adapter);
 
-	adapter->aq_required |= IAVF_FLAG_AQ_ENABLE_QUEUES;
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ENABLE_QUEUES);
 }
 
 /**
@@ -1439,8 +1437,7 @@ void iavf_down(struct iavf_adapter *adapter)
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
 	}
 
-	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DISABLE_QUEUES);
 }
 
 /**
@@ -2337,10 +2334,8 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 		}
 	}
 
-	if (aq_required) {
-		adapter->aq_required |= aq_required;
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
-	}
+	if (aq_required)
+		iavf_schedule_aq_request(adapter, aq_required);
 }
 
 /**
-- 
2.41.0


