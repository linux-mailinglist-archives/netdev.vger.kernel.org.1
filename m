Return-Path: <netdev+bounces-52092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0EC7FD40B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF261C20A26
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0A19BC2;
	Wed, 29 Nov 2023 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwI4cCLt"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 02:24:17 PST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11EBA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701253458; x=1732789458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v1nCldua3WBiSnVPuy5LnS6E/cq1uTZoCreErVFP1p4=;
  b=HwI4cCLtLDrCwtBxcElGkpduGGE1v8H3fuuDeC89sVPSn3p7GlRn/Xcn
   5uGxBU77SnIoqXoPl7u7pr5NZvMVwr62uSOgj61G6L0a7nAG3SFlN0uNc
   aWbtGGlN7aA13qQGORpG7kZ3iNxt2chIx0NlKVuX6Ls1YJV8jLhUgu5xI
   AVLZH+dbV6QMwioIjvaK73/lOefGSa4ep2zAK3AwysrhtJ6hHcJMq3Pjx
   fAz5J2WxsIryVzLLeP+1vx2MS5GGLorO9F5TMaE/mpQdWYFDIkdi/ZHhs
   FLAK5CUZ0vQ4KWpAxffIZm78HJRy5yWMzx5eDW95Tnuj6DXbMPDQL9Vrl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="121480"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="121480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718712474"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="718712474"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2023 02:23:12 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>
Subject: [PATCH iwl-net v2] i40e:Fix filter input checks to prevent config with invalid values
Date: Wed, 29 Nov 2023 11:23:11 +0100
Message-Id: <20231129102311.2780151-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Prevent VF from configuring filters with unsupported actions or use
REDIRECT action with invalid tc number. Current checks could cause
out of bounds access on PF side.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2 add 'Fixes:' tag into commit message
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3f99eb1..031b15c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3521,16 +3521,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	bool found = false;
 	int bkt;
 
-	if (!tc_filter->action) {
+	if (tc_filter->action != VIRTCHNL_ACTION_TC_REDIRECT) {
 		dev_info(&pf->pdev->dev,
-			 "VF %d: Currently ADq doesn't support Drop Action\n",
-			 vf->vf_id);
+			 "VF %d: ADQ doesn't support this action (%d)\n",
+			 vf->vf_id, tc_filter->action);
 		goto err;
 	}
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > I40E_MAX_VF_VSI) {
+	    tc_filter->action_meta > vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
-- 
2.25.1


