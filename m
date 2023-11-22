Return-Path: <netdev+bounces-49928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C797F3E59
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 07:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41221C20B77
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA90168A9;
	Wed, 22 Nov 2023 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrxGSxUO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F383D1AC
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 22:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700635896; x=1732171896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=st2jlcfVa7BJwPPfhHBSWNTFl0cuqHDBOwpJJ+aFNTQ=;
  b=mrxGSxUO+TgenKUlqYW6LjBMSRxNu2BvocmBcE2iFyzu6YNgrNIMyAT5
   WBavUgE8BhRr53eq3r9ID3TmeHsH24hWiZ/fAVfU7PNWQatjpKOzs77GR
   x/tbqLIYHTsy+Z4KM8vpq4sqmrcimGlvxpyysnxc7HPdrT8RaBDpzYts5
   0nNnMbyV0eGyHIZNITOQHYO2nHd1vQtmWpZ+X9KWadIH9zfef6KLt3wER
   JdCfn7ZoxBRSyS17oxtLKI75TIRppuiB8uoe8hbwaDXHJ9KrrF0T7tC8N
   k0+plrFVrT5JDEJkRarc6ezpbKfTkMoT8hprFV1QZJCG1GYAiYxxZFKR8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391764123"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="391764123"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 22:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716746174"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="716746174"
Received: from fedora-sys-rao.jf.intel.com (HELO f37-upstream-rao..) ([10.166.5.220])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 22:51:36 -0800
From: Ranganatha Rao <ranganatha.rao@intel.com>
To: e1000-patches@eclists.intel.com
Cc: netdev@vger.kernel.org,
	Piotr Gardocki <piotrx.gardocki@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ranganatha Rao <ranganatha.rao@intel.com>
Subject: [PATCH iwl-net v1 2/2] iavf: Handle ntuple on/off based on new state machines for flow director
Date: Tue, 21 Nov 2023 22:46:01 -0500
Message-ID: <20231122034601.38054-3-ranganatha.rao@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122034601.38054-1-ranganatha.rao@intel.com>
References: <20231122034601.38054-1-ranganatha.rao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Gardocki <piotrx.gardocki@intel.com>

ntuple-filter feature on/off:
Default is on. If turned off, the filters will be removed from both
PF and iavf list. The removal is irrespective of current filter state.

Steps to reproduce:
-------------------

1. Ensure ntuple is on.

ethtool -K enp8s0 ntuple-filters on

2. Create a filter to receive the traffic into non-default rx-queue like 15
and ensure traffic is flowing into queue into 15.
Now, turn off ntuple. Traffic should not flow to configured queue 15.
It should flow to default RX queue.

Fixes: 0dbfbabb840d ("iavf: Add framework to enable ethtool ntuple filters")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Ranganatha Rao <ranganatha.rao@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 59 +++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 567435e23936..98116872f6bd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4341,6 +4341,49 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 	return ret;
 }
 
+/**
+ * iavf_disable_fdir - disable Flow Director and clear existing filters
+ * @adapter: board private structure
+ **/
+static void iavf_disable_fdir(struct iavf_adapter *adapter)
+{
+	struct iavf_fdir_fltr *fdir, *fdirtmp;
+	bool del_filters = false;
+
+	adapter->flags &= ~IAVF_FLAG_FDIR_ENABLED;
+
+	/* remove all Flow Director filters */
+	spin_lock_bh(&adapter->fdir_fltr_lock);
+	list_for_each_entry_safe(fdir, fdirtmp, &adapter->fdir_list_head,
+				 list) {
+		if (fdir->state == IAVF_FDIR_FLTR_ADD_REQUEST ||
+		    fdir->state == IAVF_FDIR_FLTR_INACTIVE) {
+			/* Delete filters not registered in PF */
+			list_del(&fdir->list);
+			kfree(fdir);
+			adapter->fdir_active_fltr--;
+		} else if (fdir->state == IAVF_FDIR_FLTR_ADD_PENDING ||
+			   fdir->state == IAVF_FDIR_FLTR_DIS_REQUEST ||
+			   fdir->state == IAVF_FDIR_FLTR_ACTIVE) {
+			/* Filters registered in PF, schedule their deletion */
+			fdir->state = IAVF_FDIR_FLTR_DEL_REQUEST;
+			del_filters = true;
+		} else if (fdir->state == IAVF_FDIR_FLTR_DIS_PENDING) {
+			/* Request to delete filter already sent to PF, change
+			 * state to DEL_PENDING to delete filter after PF's
+			 * response, not set as INACTIVE
+			 */
+			fdir->state = IAVF_FDIR_FLTR_DEL_PENDING;
+		}
+	}
+	spin_unlock_bh(&adapter->fdir_fltr_lock);
+
+	if (del_filters) {
+		adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
+		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	}
+}
+
 #define NETIF_VLAN_OFFLOAD_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
 					 NETIF_F_HW_VLAN_CTAG_TX | \
 					 NETIF_F_HW_VLAN_STAG_RX | \
@@ -4366,6 +4409,13 @@ static int iavf_set_features(struct net_device *netdev,
 	    ((netdev->features & NETIF_F_RXFCS) ^ (features & NETIF_F_RXFCS)))
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 
+	if ((netdev->features & NETIF_F_NTUPLE) ^ (features & NETIF_F_NTUPLE)) {
+		if (features & NETIF_F_NTUPLE)
+			adapter->flags |= IAVF_FLAG_FDIR_ENABLED;
+		else
+			iavf_disable_fdir(adapter);
+	}
+
 	return 0;
 }
 
@@ -4715,6 +4765,9 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 
 	features = iavf_fix_netdev_vlan_features(adapter, features);
 
+	if (!FDIR_FLTR_SUPPORT(adapter))
+		features &= ~NETIF_F_NTUPLE;
+
 	return iavf_fix_strip_features(adapter, features);
 }
 
@@ -4832,6 +4885,12 @@ int iavf_process_config(struct iavf_adapter *adapter)
 	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
 		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
+	if (FDIR_FLTR_SUPPORT(adapter)) {
+		netdev->hw_features |= NETIF_F_NTUPLE;
+		netdev->features |= NETIF_F_NTUPLE;
+		adapter->flags |= IAVF_FLAG_FDIR_ENABLED;
+	}
+
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
 	/* Do not turn on offloads when they are requested to be turned off.
-- 
2.41.0


