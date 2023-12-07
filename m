Return-Path: <netdev+bounces-54943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E5808FB0
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495A91C20924
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A04D596;
	Thu,  7 Dec 2023 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7k/GWtB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ADE10E3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701973204; x=1733509204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uh6ICvHM5Z9cI9fvL4WpgaNh4HLyMbOCcZVHnRMxEfQ=;
  b=k7k/GWtBWK8xh5ivhkZMajMVIfrAZ2QYvjWaBlXyZbbj50MGasXMJtIo
   lz6B01EaWmqdbvYfbyzloxKCqlU5gdZ+QzDX2xp+UqhkIOPtFAudozy2p
   egisgQ/TAct5cK9d3TzM3d+wUEZhCFaF9tNCw09WiFTnKXJs0L+djEImT
   9TY9fe4rjFGK8bNOOSQuP9QnaiXu6DPXRnd0Ots+RwwEc/3XXiUXYny4c
   tjuiakBdL9eLN0aEEju259umKNjNiCukb+XZuFrZxtGMw0DuV8DDYo0Oc
   FQfgtLAWFpAV0T2darmH9d5ioSzWFHZQ7NaifWnvaKz9/izM/DOE9+wZM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1349376"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1349376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721566108"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721566108"
Received: from dmert-dev.jf.intel.com ([10.166.241.14])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:20:03 -0800
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next] ice: alter feature support check for SRIOV and LAG
Date: Thu,  7 Dec 2023 10:21:58 -0800
Message-Id: <20231207182158.2199799-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the ice driver had support for using a hanldler for bonding
netdev events to ensure that conflicting features were not allowed to be
activated at the same time.  While this was still in place, additional
support was added to specifically support SRIOV and LAG together.  These
both utilized the netdev event handler, but the SRIOV and LAG feature was
behind a capabilities feature check to make sure the current NVM has
support.

The exclusion part of the event handler should be removed since there are
users who have custom made solutions that depend on the non-exclusion of
features.

Wrap the creation/registration and cleanup of the event handler and
associated structs in the probe flow with a feature check so that the
only systems that support the full implementation of LAG features will
initialize support.  This will leave other systems unhindered with
functionality as it existed before any LAG code was added.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 280994ee5933..b47cd43ae871 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1981,6 +1981,8 @@ int ice_init_lag(struct ice_pf *pf)
 	int n, err;
 
 	ice_lag_init_feature_support_flag(pf);
+	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
+		return 0;
 
 	pf->lag = kzalloc(sizeof(*lag), GFP_KERNEL);
 	if (!pf->lag)
-- 
2.40.1


