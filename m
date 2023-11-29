Return-Path: <netdev+bounces-52080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D767FD399
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9433FB213D5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0938199A5;
	Wed, 29 Nov 2023 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9xRroiV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733AE1
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701252576; x=1732788576;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcXVVs2hlViGP6v0YIAXDTaYl5u9PA6AXiePriwmiyU=;
  b=Z9xRroiV5PHwtHlpn9ylB6WsNdi1LNtn7ClkmP8gqJbNA/n8icABsruJ
   0jDqqCBkSqTqcr1wKzw1ibiGiSAiP9Re3cyegw0NgHuOsZHGiN7UgOgt2
   Dr6ngGlruTELg1XLi/Ye8Uf2cOjojVjg0eNf5Atkm1erfWZgYeF3v+8T4
   lBpyViPXi0pzkNJ5FPWsdEf/EViSxHYvNZG/MDipWRe9WBbMoqShP9YNN
   u++XGue0EF/gWGNIkJVn5YFzMGyDkCTEgUCHpBKnjDBTM6gnWRh5BKnYE
   yKYR8bGn/NnfXgMl94vjkwWoGx6J6BD/BPnjkL66QXbwYtxTr3U5sTiMx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372503088"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="372503088"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:09:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016218517"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1016218517"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2023 02:09:34 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>
Subject: [PATCH iwl-net v1] i40e:Fix filter input checks to prevent config with invalid values
Date: Wed, 29 Nov 2023 11:09:33 +0100
Message-Id: <20231129100933.2753577-1-aleksandr.loktionov@intel.com>
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

Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


