Return-Path: <netdev+bounces-28620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C577FFF1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD4228220A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92311D308;
	Thu, 17 Aug 2023 21:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D11DA21
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A5E6B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307780; x=1723843780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3SvxtUZ68xe5d9qMh2ZENTBIYeOM7tQgXuMfEyeROM=;
  b=Nih4dPoankoLGaEilY/kRU+EmJOAOTiFQxa6XNOdLwpVvU8B2cgfJ0d2
   tzDGx19RJb17Tkmt8Ki2kk6/sFxKvan3FoV3v+YFHd/The/dLuwPZQi3h
   BX11JtJjOogAy8Eht7WAdN4OLqvMoDsur1hUmOhmUmFGIHmybF1B/oppJ
   3iywbJTbxlBrhu59y6OwySUj/XKPhFVvfWdkFacqG0cQNGe9HwVA/zu/W
   tqDxi3384myPuv7Y3eStlHeJcksxn+8JYPh+panFUFtRb9cy5jlBPgjoH
   UsStVrSGnI8gSHk0riOyGb2YFcvyv++buRhU251lEvDTiOQng4oEgsqB+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095102"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813732"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813732"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 11/15] ice: use list_for_each_entry() helper
Date: Thu, 17 Aug 2023 14:22:35 -0700
Message-Id: <20230817212239.2601543-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yang Yingliang <yangyingliang@huawei.com>

Convert list_for_each() to list_for_each_entry() where applicable.
No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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


