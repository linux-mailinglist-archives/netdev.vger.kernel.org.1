Return-Path: <netdev+bounces-92578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6D8B7F72
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41CF28537F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7842190684;
	Tue, 30 Apr 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEipXvFI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A5181CEA
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500407; cv=none; b=ogXax5TqI0D3TRmsvBMde/BJp9pzfJsAWUNAy/HbW38+IV3csQm0/5rt19Yb+r5ft+pYCE+pb7FEeMFnPoKVyZgH64cVByYHHocYmhFZP2jS/8u4yJ8LyniW2gX6/iYwcqS0QdTRYJwUhdQq/A9Dk746XV4zuqAg/DZ+qlYJUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500407; c=relaxed/simple;
	bh=/wliapDShNeNGhBWUHNo+NRtrqS0xb7XcN8rbXev5bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPQULtwhNVv+Dpwm0Nbb443M1G9fYaOcsJHfCwGNSnDYkQ5HsuYTCp4DxoKTcMeh8hYLeKwyZS9qVLP1FRkmCiAAoZr/j+vjEW68IvDJTzesl8CjqOF9CyyyodKop32rT8ILAp2Rbs6v97ug6sy/0CrOxwWoYcwSigD6XTFB57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEipXvFI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500406; x=1746036406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/wliapDShNeNGhBWUHNo+NRtrqS0xb7XcN8rbXev5bU=;
  b=nEipXvFIuQ9fgx2IsgcnWZtju8jo86EAQrYKmAbyUgc1etTIXU/v4rI2
   8Sa2nPEjsDlIKDkrjpQGeidz71/RNYgxVYHANHS4MV6gHUFcrA0wKT1Gl
   F+2S6OZpuxftncd0xGMCtbhgZ97ATFnSQfEFbCBDxSBi5y0qA4qublkyE
   KOyge3+dH6p6H6WUZUqG/smyzg36snC95wrezW0e7Ju3WWFnNBJjC7g8R
   o2hFNtK7XfN64ZpN271efOkqbs3+Ad9/FuammNM2ztGi3CimH8ggSB8OY
   FFkIfJeHGJKlkT6met1YxUbISA4rEBRQGwhsIZxZR3LaJWTSf7rb/rCI1
   g==;
X-CSE-ConnectionGUID: pGm0NuXqQPGgEqhbm/0ltg==
X-CSE-MsgGUID: 0x+R82PiQ1CiTQl3uMDYSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20839420"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20839420"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:06:44 -0700
X-CSE-ConnectionGUID: Nx/bR6uWRaGjpYmL4ZRnVw==
X-CSE-MsgGUID: iGRwUsLuQLGPZVyNcbaZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31147297"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:06:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/7] i40e: Refactor argument of several client notification functions
Date: Tue, 30 Apr 2024 11:06:32 -0700
Message-ID: <20240430180639.1938515-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
References: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Commit 0ef2d5afb12d ("i40e: KISS the client interface") simplified
the client interface so in practice it supports only one client
per i40e netdev. But we have still 2 notification functions that
uses as parameter a pointer to VSI of netdevice associated with
the client. After the mentioned commit only possible and used
VSI is the main (LAN) VSI.
So refactor these functions so they are called with PF pointer argument
and the associated VSI (LAN) is taken inside them.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_client.c | 20 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 12 +++++------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5248e78f7849..0792c7324527 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1236,8 +1236,8 @@ static inline void i40e_dbg_exit(void) {}
 int i40e_lan_add_device(struct i40e_pf *pf);
 int i40e_lan_del_device(struct i40e_pf *pf);
 void i40e_client_subtask(struct i40e_pf *pf);
-void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi);
-void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool reset);
+void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf);
+void i40e_notify_client_of_netdev_close(struct i40e_pf *pf, bool reset);
 void i40e_notify_client_of_vf_enable(struct i40e_pf *pf, u32 num_vfs);
 void i40e_notify_client_of_vf_reset(struct i40e_pf *pf, u32 vf_id);
 void i40e_client_update_msix_info(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index b32071ee84af..93e52138826e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -101,25 +101,26 @@ i40e_notify_client_of_vf_msg(struct i40e_vsi *vsi, u32 vf_id, u8 *msg, u16 len)
 
 /**
  * i40e_notify_client_of_l2_param_changes - call the client notify callback
- * @vsi: the VSI with l2 param changes
+ * @pf: PF device pointer
  *
- * If there is a client to this VSI, call the client
+ * If there is a client, call its callback
  **/
-void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
+void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf)
 {
-	struct i40e_pf *pf = vsi->back;
 	struct i40e_client_instance *cdev = pf->cinst;
+	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_params params;
 
 	if (!cdev || !cdev->client)
 		return;
 	if (!cdev->client->ops || !cdev->client->ops->l2_param_change) {
-		dev_dbg(&vsi->back->pdev->dev,
+		dev_dbg(&pf->pdev->dev,
 			"Cannot locate client instance l2_param_change routine\n");
 		return;
 	}
 	if (!test_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state)) {
-		dev_dbg(&vsi->back->pdev->dev, "Client is not open, abort l2 param change\n");
+		dev_dbg(&pf->pdev->dev,
+			"Client is not open, abort l2 param change\n");
 		return;
 	}
 	memset(&params, 0, sizeof(params));
@@ -157,20 +158,19 @@ static void i40e_client_release_qvlist(struct i40e_info *ldev)
 
 /**
  * i40e_notify_client_of_netdev_close - call the client close callback
- * @vsi: the VSI with netdev closed
+ * @pf: PF device pointer
  * @reset: true when close called due to a reset pending
  *
  * If there is a client to this netdev, call the client with close
  **/
-void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool reset)
+void i40e_notify_client_of_netdev_close(struct i40e_pf *pf, bool reset)
 {
-	struct i40e_pf *pf = vsi->back;
 	struct i40e_client_instance *cdev = pf->cinst;
 
 	if (!cdev || !cdev->client)
 		return;
 	if (!cdev->client->ops || !cdev->client->ops->close) {
-		dev_dbg(&vsi->back->pdev->dev,
+		dev_dbg(&pf->pdev->dev,
 			"Cannot locate client instance close routine\n");
 		return;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e27b2aa544b6..aa874d6ff8c3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11276,14 +11276,12 @@ static void i40e_service_task(struct work_struct *work)
 		i40e_fdir_reinit_subtask(pf);
 		if (test_and_clear_bit(__I40E_CLIENT_RESET, pf->state)) {
 			/* Client subtask will reopen next time through. */
-			i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi],
-							   true);
+			i40e_notify_client_of_netdev_close(pf, true);
 		} else {
 			i40e_client_subtask(pf);
 			if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
 					       pf->state))
-				i40e_notify_client_of_l2_param_changes(
-								pf->vsi[pf->lan_vsi]);
+				i40e_notify_client_of_l2_param_changes(pf);
 		}
 		i40e_sync_filters_subtask(pf);
 	} else {
@@ -16217,7 +16215,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+	i40e_notify_client_of_netdev_close(pf, false);
 
 	i40e_fdir_teardown(pf);
 
@@ -16476,7 +16474,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+	i40e_notify_client_of_netdev_close(pf, false);
 
 	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
 	    pf->wol_en)
@@ -16530,7 +16528,7 @@ static int i40e_suspend(struct device *dev)
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+	i40e_notify_client_of_netdev_close(pf, false);
 
 	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
 	    pf->wol_en)
-- 
2.41.0


