Return-Path: <netdev+bounces-42748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D897D0096
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9901F23E7F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2935513;
	Thu, 19 Oct 2023 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtrYWmAq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA85347B7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4FA112
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736757; x=1729272757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bD+KmlAz1kdJoXk2RRTBYlpkpIozuwm8/4tl95TN1ms=;
  b=jtrYWmAqovD0AxkAFWNQmiVDaUWODq5Mwa9T4tOzrT2qOYDhqbdXWVXc
   9CN/h3nIenbNfhznVF3xTrH0f/8oyX31ceOcmH/ALKnHlZPiTnC4m2Fqh
   toLemfK2i4EDtmG8UqFmgN+z44jEDWZ2WQ6nw2i/JMTQrASrAAAfnR6DV
   I01J45HdvLRR40iRESV5CWkucJN4LG2u+NtSUNlSdHNYkgXumppEEo7eE
   vOjhRMk0K6y/02aLgv1TLPL4s6K3FlNYghHyaWpU3P15wiDQA8/Kq4ikE
   8ebCjkg1pqOmOnGUaI0oX3YgQltabxQqqx9sId514lXZAV9GrOU4rF6NU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183699"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183699"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722689"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722689"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:34 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 05/11] ice: add bitmap to track VF MSI-X usage
Date: Thu, 19 Oct 2023 10:32:21 -0700
Message-ID: <20231019173227.3175575-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Create a bitamp to track MSI-X usage for VFs. The bitmap has the size of
total MSI-X amount on device, because at init time the amount of MSI-X
used by VFs isn't known.

The bitmap is used in follow up patchset to provide a block of
continuous block of MSI-X indexes for each created VF.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h       | 2 ++
 drivers/net/ethernet/intel/ice/ice_sriov.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 988b177d9388..351e0d36df44 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -554,6 +554,8 @@ struct ice_pf {
 	 * MSIX vectors allowed on this PF.
 	 */
 	u16 sriov_base_vector;
+	unsigned long *sriov_irq_bm;	/* bitmap to track irq usage */
+	u16 sriov_irq_size;		/* size of the irq_bm bitmap */
 
 	u16 ctrl_vsi_idx;		/* control VSI index in pf->vsi array */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index d345f5d8635b..49adb0b05817 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -138,6 +138,8 @@ static int ice_sriov_free_msix_res(struct ice_pf *pf)
 	if (!pf)
 		return -EINVAL;
 
+	bitmap_free(pf->sriov_irq_bm);
+	pf->sriov_irq_size = 0;
 	pf->sriov_base_vector = 0;
 
 	return 0;
@@ -853,10 +855,16 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
  */
 static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 {
+	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	int ret;
 
+	pf->sriov_irq_bm = bitmap_zalloc(total_vectors, GFP_KERNEL);
+	if (!pf->sriov_irq_bm)
+		return -ENOMEM;
+	pf->sriov_irq_size = total_vectors;
+
 	/* Disable global interrupt 0 so we don't try to handle the VFLR. */
 	wr32(hw, GLINT_DYN_CTL(pf->oicr_irq.index),
 	     ICE_ITR_NONE << GLINT_DYN_CTL_ITR_INDX_S);
@@ -915,6 +923,7 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	/* rearm interrupts here */
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	clear_bit(ICE_OICR_INTR_DIS, pf->state);
+	bitmap_free(pf->sriov_irq_bm);
 	return ret;
 }
 
-- 
2.41.0


