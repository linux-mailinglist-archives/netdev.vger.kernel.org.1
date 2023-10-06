Return-Path: <netdev+bounces-38670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE37BC0D2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BEE1C2085B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1A4447A;
	Fri,  6 Oct 2023 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFf46bK7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27038FA6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 21:00:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A27BBE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696626013; x=1728162013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1DpSrKIs+hAEukPt4xle9xxxAoy6cCiHpiGwkrwOOIU=;
  b=nFf46bK7ZJ0lRMjW2A8ivwloZ8bZAosP+Kne6CK0n9PMGdzPRoZpi+ws
   tucqyt2Dg7AVPI/oOgNb3SnQb57cVp3Cr0JSXx4MiOmX8nO8T+vSmtBdc
   dItugrLlqV8yfK3slZtBe8eKX2yJbfDNObRt9O/EeBfPs//5gfZDKLXKk
   2WCZVlcWFExq5PRC3LDMo0rI/axtX3GzCXDrDQqF40hj7SFcoc29p4DZS
   Q+hXEXLAn6U8fanMK6kw/l0A7zLofP9qB+mJYGQ4t7TmyI7ApXhWPRFhx
   PszDF1INrCxkEEiK4P/f9SkzTovrqrbqa+tDsrVGhpJ7+VlsOHfX5dY7d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386662133"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386662133"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 14:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818138798"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818138798"
Received: from dmert-dev.jf.intel.com ([10.166.241.14])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 14:00:12 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ice: Fix SRIOV LAG disable on non-compliant aggreagate
Date: Fri,  6 Oct 2023 14:02:11 -0700
Message-Id: <20231006210211.1443696-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.40.1
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

If an attribute of an aggregate interface disqualifies it from supporting
SRIOV, the driver will unwind the SRIOV support.  Currently the driver is
clearing the feature bit for all interfaces in the aggregate, but this is
not allowing the other interfaces to unwind successfully on driver unload.

Only clear the feature bit for the interface that is currently unwinding.

Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messaging for SRIOV LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 2c96d1883e19..c9071228b1ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1513,17 +1513,12 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 {
-	struct ice_lag_netdev_list *entry;
 	struct ice_netdev_priv *np;
-	struct net_device *netdev;
 	struct ice_pf *pf;
 
-	list_for_each_entry(entry, lag->netdev_head, node) {
-		netdev = entry->netdev;
-		np = netdev_priv(netdev);
-		pf = np->vsi->back;
-
-		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
+	np = netdev_priv(lag->netdev);
+	pf = np->vsi->back;
+	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
 	}
 }
 
-- 
2.40.1


