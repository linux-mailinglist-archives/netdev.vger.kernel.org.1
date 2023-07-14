Return-Path: <netdev+bounces-18029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB27543AC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56CB281C8D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554922AB2F;
	Fri, 14 Jul 2023 20:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B22419D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:18:41 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17C30FB
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689365919; x=1720901919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gG53R4f4PCWBohqirY66E1wTY2owHL+dZ3+oxNpNs+g=;
  b=mf3lkvrbkeSDUaGIP0+dv+geDu24f/TwyfMZ7CL9P7IELnxB0xSOPSLk
   WPSLMWIhsncKF2JAZgq9ACCViCKHzPR2U/2wQioLgliCKEbg0LD0q3PWs
   ILdYOvhL8+3+QgBMsfjXvf+ke2Mz09aGEVgDkK6xEbeTdTZxQ7d86b01X
   v0J1EZBlIArjD/PMHjg9KNTbldH1q/3QUOnZSghsicbTWvf5sInnfN7i8
   9zu/Iz9lqr/F66fx370WR3R1U0uXKjc8mWSItQ3UALIpka6wOLRyS3eJ9
   BcTpmrFf6Is9qQTRjCe/9jYuzQLltSqKw80cscIVA5Tcm9UdKIGCa8lsj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="364438490"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="364438490"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="722521111"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="722521111"
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
Subject: [PATCH net-next v2 2/2] i40e: Wait for pending VF reset in VF set callbacks
Date: Fri, 14 Jul 2023 13:12:53 -0700
Message-Id: <20230714201253.1717957-3-anthony.l.nguyen@intel.com>
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

Commit 028daf80117376 ("i40e: Fix attach VF to VM issue") fixed
a race between i40e_ndo_set_vf_mac() and i40e_reset_vf() during
an attachment of VF device to VM. This issue is not related to
setting MAC address only but also VLAN assignment to particular
VF because the newer libvirt sets configured MAC address as well
as an optional VLAN. The same behavior is also for i40e's
.ndo_set_vf_rate and .ndo_set_vf_spoofchk where the callbacks
just check if the VF was initialized but not wait for the finish
of pending reset.

Reproducer:
[root@host ~]# virsh attach-interface guest hostdev --managed 0000:02:02.0 --mac 52:54:00:b4:aa:bb
error: Failed to attach interface
error: Cannot set interface MAC/vlanid to 52:54:00:b4:aa:bb/0 for ifname enp2s0f0 vf 0: Resource temporarily unavailable

Fix this issue by using i40e_check_vf_init_timeout() helper to check
whether a reset of particular VF was finished in i40e's
.ndo_set_vf_vlan, .ndo_set_vf_rate and .ndo_set_vf_spoofchk callbacks.

Tested-by: Ma Yuying <yuma@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b203465357af..398fb4854cbe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4468,13 +4468,11 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	}
 
 	vf = &pf->vf[vf_id];
-	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto error_pvid;
 	}
+	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	if (le16_to_cpu(vsi->info.pvid) == vlanprio)
 		/* duplicate request, so just return success */
@@ -4618,13 +4616,11 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	}
 
 	vf = &pf->vf[vf_id];
-	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto error;
 	}
+	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	ret = i40e_set_bw_limit(vsi, vsi->seid, max_tx_rate);
 	if (ret)
@@ -4791,9 +4787,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 	}
 
 	vf = &(pf->vf[vf_id]);
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto out;
 	}
-- 
2.38.1


