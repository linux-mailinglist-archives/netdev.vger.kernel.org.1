Return-Path: <netdev+bounces-18028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084D7543A9
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ED61C20833
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227232772A;
	Fri, 14 Jul 2023 20:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F72419E
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:18:40 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E230F4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689365918; x=1720901918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uatwuBXrczKWkKd36qGKdfnAa6x1B3xR678SLlgVbbU=;
  b=MjWN7YclH+OAuFozOfi9dAZlvsV+8dwWYwUt8hH97NUbnGarYRgbj9w/
   r+ioCsPTWnze/aTsnPYLK0xjmkuT4EfLn88wckIdz6ScgudFm6HCxh0UM
   GqUNUJbK77T+4qq7Pash/OstJEuFfL0TU1jI3hDP4Te5DLlK1cWfXCbya
   /yD+rVnoLSCONNPsw1WqYQhI/BnPQS0Z9TAkYwXdTeqmpiC7B+5h89QdB
   +YtkJdGaFHdLKmGedUsNdN7NBcs/GMSNoFVknvb67vhRMj8EjlCWtV9r1
   aa+hHUJHuHu2i81LOVzHsXJ8aA9025iRXQctg/b6t+S3ABJGogz2VwZJr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="364438486"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="364438486"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="722521108"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="722521108"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 13:18:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	leon@kernel.org,
	simon.horman@corigine.com,
	Ma Yuying <yuma@redhat.com>
Subject: [PATCH net-next v2 1/2] i40e: Add helper for VF inited state check with timeout
Date: Fri, 14 Jul 2023 13:12:52 -0700
Message-Id: <20230714201253.1717957-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
References: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ivan Vecera <ivecera@redhat.com>

Move the check for VF inited state (with optional up-to 300ms
timeout to separate helper i40e_check_vf_init_timeout() that
will be used in the following commit.

Tested-by: Ma Yuying <yuma@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index be59ba3774e1..b203465357af 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4304,6 +4304,38 @@ static int i40e_validate_vf(struct i40e_pf *pf, int vf_id)
 	return ret;
 }
 
+/**
+ * i40e_check_vf_init_timeout
+ * @vf: the virtual function
+ *
+ * Check that the VF's initialization was successfully done and if not
+ * wait up to 300ms for its finish.
+ *
+ * Returns true when VF is initialized, false on timeout
+ **/
+static bool i40e_check_vf_init_timeout(struct i40e_vf *vf)
+{
+	int i;
+
+	/* When the VF is resetting wait until it is done.
+	 * It can take up to 200 milliseconds, but wait for
+	 * up to 300 milliseconds to be safe.
+	 */
+	for (i = 0; i < 15; i++) {
+		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
+			return true;
+		msleep(20);
+	}
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
+		dev_err(&vf->pf->pdev->dev,
+			"VF %d still in reset. Try again.\n", vf->vf_id);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * i40e_ndo_set_vf_mac
  * @netdev: network interface device structure
@@ -4322,7 +4354,6 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	int ret = 0;
 	struct hlist_node *h;
 	int bkt;
-	u8 i;
 
 	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
 		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
@@ -4335,21 +4366,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto error_param;
 
 	vf = &pf->vf[vf_id];
-
-	/* When the VF is resetting wait until it is done.
-	 * It can take up to 200 milliseconds,
-	 * but wait for up to 300 milliseconds to be safe.
-	 * Acquire the VSI pointer only after the VF has been
-	 * properly initialized.
-	 */
-	for (i = 0; i < 15; i++) {
-		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
-			break;
-		msleep(20);
-	}
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto error_param;
 	}
-- 
2.38.1


