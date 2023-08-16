Return-Path: <netdev+bounces-28220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD3777EB20
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DFB281C62
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938F1ADEC;
	Wed, 16 Aug 2023 20:54:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1C1ADDD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7D271E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219275; x=1723755275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XbMGjTPuajPWdld1CAe/b6HX7q37Yu5Px4HPXR+FnmM=;
  b=PuWMGuq7+1BzNR1hqXjAU5KX1Ks/2QlJzFXnCiunBjtAgv2/Xn+MUYAt
   DiV7Q4Vgza5e9h1eFGkzZMf3Go0/L+7KWIeRVcPuSXfpIKjqe+AkED3mY
   RCrnDiLWIpQsi9Qotqg4M4HGlWUOT+ntn0HXgJCjOju+sqw3dNvIvzOmV
   +F3ayQFdJVwTF0wRSH3k1jjQ7sMnyIiRvMgcqSrCsSt4NyBZ5QiI+aWrA
   2fLJtcWY/XyrMAsvs6Nlg3kr8uQSgbgiK9X/bzkBJ/itlrd5gr8a8jEic
   eNTYFu2rZUAnPebZgosztNKXNakF2PxawHjseT095lhR/CDdAkMGmXwgA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604805"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626403"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626403"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 10/14] ice: use list_for_each_entry() helper
Date: Wed, 16 Aug 2023 13:47:32 -0700
Message-Id: <20230816204736.1325132-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yang Yingliang <yangyingliang@huawei.com>

Convert list_for_each() to list_for_each_entry() where applicable.
No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 36b7044717e8..a68974c1aa38 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -129,11 +129,9 @@ ice_lag_find_hw_by_lport(struct ice_lag *lag, u8 lport)
 	struct ice_lag_netdev_list *entry;
 	struct net_device *tmp_netdev;
 	struct ice_netdev_priv *np;
-	struct list_head *tmp;
 	struct ice_hw *hw;
 
-	list_for_each(tmp, lag->netdev_head) {
-		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+	list_for_each_entry(entry, lag->netdev_head, node) {
 		tmp_netdev = entry->netdev;
 		if (!tmp_netdev || !netif_is_ice(tmp_netdev))
 			continue;
@@ -1535,11 +1533,9 @@ static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 	struct ice_lag_netdev_list *entry;
 	struct ice_netdev_priv *np;
 	struct net_device *netdev;
-	struct list_head *tmp;
 	struct ice_pf *pf;
 
-	list_for_each(tmp, lag->netdev_head) {
-		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+	list_for_each_entry(entry, lag->netdev_head, node) {
 		netdev = entry->netdev;
 		np = netdev_priv(netdev);
 		pf = np->vsi->back;
-- 
2.38.1


