Return-Path: <netdev+bounces-259625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIfTOTSul2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53099163EDF
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108A7306B9D3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3391E5B7A;
	Fri, 20 Feb 2026 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wot0SwEe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E821ABB9
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548042; cv=none; b=PAlVzLzz0iMrYCO8uNA9aEMQkRq/S795+S8m6ki9WGgD8E4g63fyXMTLupFOPh1N7REYk5EE1+NDr16V3NcrBuxFWePaqGCB4/mBX08zOGEDoo1HTCBb88cMa4mv0eXrRR6yTG4au/j+3g7UBHmj6Dqd3se8B5UWvuzb/4PK4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548042; c=relaxed/simple;
	bh=oX0yAl67JyP8BwS18Z/c6GjHPT+tP5I2JN/sY2t6Hu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElclXcH3/zmYTKhIEs7yfC6mEch9K0+R+YE5Fs4D+Tb9nl775CtCHXmtm8mqd7cziT+KYp1LIjZ3cyt26FJk6h1wji3rscJiEkXVm/EvJe5wRDePuYO3bBJ0c9JF4xF5S8WFq4zdesd5tNOJCR3D1HSRCmeuyS9NOm4kY2EbC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wot0SwEe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548038; x=1803084038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oX0yAl67JyP8BwS18Z/c6GjHPT+tP5I2JN/sY2t6Hu0=;
  b=Wot0SwEeUto775Kt3ghv1GpsNEBIkh5QwDmyhHMOg3UzfbjH2YfVkDnY
   oKt1YvJqkpUT0GQ1gUI5UR6FWV6Wn8RIaxs37DqiaL7yT/mkJ0JEa80hP
   +Gdy/i3SaNQLA9mtxMMrtgx7KwSeOAXX4NthOnqbiUgbmowmqBk1ksJPT
   HLAA79o7WMI8pyfhuT1paa6FwWvamtCgXsdA4gNz0OnyAQCDPDRK6Cag0
   HP0E1t3Y3NTwf0NBp8DItisItN+Cxa2J4kSV/WlYKcwRR2P6x9GFLpOWn
   +w0+bVaXe/m5qCQj/t+qS07taVPJfkrWVH1j6H+e6WLoiZXwWeYKisbHB
   w==;
X-CSE-ConnectionGUID: He8W0bqSQS2KKBecAwqCiw==
X-CSE-MsgGUID: 5hYNWSBUS3aqixYFAON0KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484210"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484210"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:34 -0800
X-CSE-ConnectionGUID: x52dgI9aRuCDQiqUIwAutQ==
X-CSE-MsgGUID: GVV5VKovR+ONxCPZqajT1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850483"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
	anthony.l.nguyen@intel.com,
	en-wei.wu@canonical.com,
	przemyslaw.kitszel@intel.com,
	david.m.ertman@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 07/13] ice: recap the VSI and QoS info after rebuild
Date: Thu, 19 Feb 2026 16:40:19 -0800
Message-ID: <20260220004027.729384-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259625-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:email]
X-Rspamd-Queue-Id: 53099163EDF
X-Rspamd-Action: no action

From: Aaron Ma <aaron.ma@canonical.com>

Fix IRDMA hardware initialization timeout (-110) after resume by
separating VSI-dependent configuration from RDMA resource allocation,
ensuring VSI is rebuilt before IRDMA accesses it.

After resume from suspend, IRDMA hardware initialization fails:
  ice: IRDMA hardware initialization FAILED init_state=4 status=-110

Separate RDMA initialization into two phases:
1. ice_init_rdma() - Allocate resources only (no VSI/QoS access, no plug)
2. ice_rdma_finalize_setup() - Assign VSI/QoS info and plug device

This allows:
- ice_init_rdma() to stay in ice_resume() (mirrors ice_deinit_rdma()
  in ice_suspend())
- VSI assignment deferred until after ice_vsi_rebuild() completes
- QoS info updated after ice_dcb_rebuild() completes
- Device plugged only when control queues, VSI, and DCB are all ready

Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on ACPI S3 resume")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c  | 44 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c |  7 +++-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index def7efa15447..2b2b22af42be 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -987,6 +987,7 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
 int ice_plug_aux_dev(struct ice_pf *pf);
 void ice_unplug_aux_dev(struct ice_pf *pf);
+void ice_rdma_finalize_setup(struct ice_pf *pf);
 int ice_init_rdma(struct ice_pf *pf);
 void ice_deinit_rdma(struct ice_pf *pf);
 bool ice_is_wol_supported(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 420d45c2558b..ded029aa71d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -360,6 +360,39 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	auxiliary_device_uninit(adev);
 }
 
+/**
+ * ice_rdma_finalize_setup - Complete RDMA setup after VSI is ready
+ * @pf: ptr to ice_pf
+ *
+ * Sets VSI-dependent information and plugs aux device.
+ * Must be called after ice_init_rdma(), ice_vsi_rebuild(), and
+ * ice_dcb_rebuild() complete.
+ */
+void ice_rdma_finalize_setup(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	struct iidc_rdma_priv_dev_info *privd;
+	int ret;
+
+	if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
+		return;
+
+	privd = pf->cdev_info->iidc_priv;
+	if (!privd || !pf->vsi || !pf->vsi[0] || !pf->vsi[0]->netdev)
+		return;
+
+	/* Assign VSI info now that VSI is valid */
+	privd->netdev = pf->vsi[0]->netdev;
+	privd->vport_id = pf->vsi[0]->vsi_num;
+
+	/* Update QoS info after DCB has been rebuilt */
+	ice_setup_dcb_qos_info(pf, &privd->qos_info);
+
+	ret = ice_plug_aux_dev(pf);
+	if (ret)
+		dev_warn(dev, "Failed to plug RDMA aux device: %d\n", ret);
+}
+
 /**
  * ice_init_rdma - initializes PF for RDMA use
  * @pf: ptr to ice_pf
@@ -398,22 +431,14 @@ int ice_init_rdma(struct ice_pf *pf)
 	}
 
 	cdev->iidc_priv = privd;
-	privd->netdev = pf->vsi[0]->netdev;
 
 	privd->hw_addr = (u8 __iomem *)pf->hw.hw_addr;
 	cdev->pdev = pf->pdev;
-	privd->vport_id = pf->vsi[0]->vsi_num;
 
 	pf->cdev_info->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
-	ice_setup_dcb_qos_info(pf, &privd->qos_info);
-	ret = ice_plug_aux_dev(pf);
-	if (ret)
-		goto err_plug_aux_dev;
+
 	return 0;
 
-err_plug_aux_dev:
-	pf->cdev_info->adev = NULL;
-	xa_erase(&ice_aux_id, pf->aux_idx);
 err_alloc_xa:
 	kfree(privd);
 err_privd_alloc:
@@ -432,7 +457,6 @@ void ice_deinit_rdma(struct ice_pf *pf)
 	if (!ice_is_rdma_ena(pf))
 		return;
 
-	ice_unplug_aux_dev(pf);
 	xa_erase(&ice_aux_id, pf->aux_idx);
 	kfree(pf->cdev_info->iidc_priv);
 	kfree(pf->cdev_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4da37caa3ec9..62914167d121 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5138,6 +5138,9 @@ int ice_load(struct ice_pf *pf)
 	if (err)
 		goto err_init_rdma;
 
+	/* Finalize RDMA: VSI already created, assign info and plug device */
+	ice_rdma_finalize_setup(pf);
+
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5169,6 +5172,7 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
+	ice_unplug_aux_dev(pf);
 	ice_deinit_rdma(pf);
 	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
@@ -5595,6 +5599,7 @@ static int ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
+	ice_unplug_aux_dev(pf);
 	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
@@ -7859,7 +7864,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_health_clear(pf);
 
-	ice_plug_aux_dev(pf);
+	ice_rdma_finalize_setup(pf);
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
 
-- 
2.47.1


