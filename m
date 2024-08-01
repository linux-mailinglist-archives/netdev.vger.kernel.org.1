Return-Path: <netdev+bounces-114879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9032944871
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA961C24577
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F296184539;
	Thu,  1 Aug 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rwk/SWjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149B18453F
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504712; cv=none; b=MjVSpyxoE52bdMVpVi5sVRBV58/uZYs0vMjaJ5dpCvkg312f4uTFrvHmXA6wThahxu1q89NtAUbR4QVOIA0WiA0GwVVD5VB9k0w30/EImbXcLieGg37/+Olg7APCEApWbU5pkUwo8Bbhfv5/iGLcxMMrU25zjazctw5PJaY9l2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504712; c=relaxed/simple;
	bh=f0qw0qlnQ9L5TU7f4M7GxKFe1ltwk2Ipo1UW4vejtPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr4/MMmcqS/fdvVsk/0/uR/Hd3wIcG7SBVfwlG7UAgT7bWL9ZqzGDLcWU4ITbl5hIAI8aj/6N0t5Bwg38DvuYZpRQ7MKsC0ONX7+VoA8bbN/Hwk0uiacUV4v8ZM15adtDyEIq4B8pCV6WdcJtPtdriIOoWZvrJB3WLx+lgxbxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rwk/SWjQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722504711; x=1754040711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0qw0qlnQ9L5TU7f4M7GxKFe1ltwk2Ipo1UW4vejtPA=;
  b=Rwk/SWjQy/BgIOlhavi/4GKjpM54jtEHLEDa51Yn348/6GpBpq4nQIsl
   84DBzyIwMhNhlGoHdXa65gRgL43nIm/9sndyIkCoFL58KffW2hJyZxw8g
   bfxad31qL5pzJmawDHWbpdBX6NtydNj1aVPn8n/ylJ4esBLOGuxthtCjC
   EnwpPQyUWdA8LX9LXoJRYeFvc6C695/XsfwKaZue6g+jrGeaSoO6VDBuj
   X4QX9v7TpOk/TfKk32bPe9UANmEecf20Gt1IFiwJAkFAqfZoqdSLueu4o
   wMvgw4CoaPEI+fO+M4DP44B91/8leKUrr/N6Xs+cpcx+gidmYyGo3rCzy
   A==;
X-CSE-ConnectionGUID: AuCAwZmORmuuew8/DxwxHA==
X-CSE-MsgGUID: cPoWZq2XTPOAp3BRnuvzlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="23363453"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="23363453"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 02:31:34 -0700
X-CSE-ConnectionGUID: Uy//AsSvSoy6P+hTGp8Jsg==
X-CSE-MsgGUID: 7WIkUr8XQsW2XTtV9s4dHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59628233"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 01 Aug 2024 02:31:30 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us
Subject: [iwl-next v2 5/7] ice: treat dyn_allowed only as suggestion
Date: Thu,  1 Aug 2024 11:31:13 +0200
Message-ID: <20240801093115.8553-6-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
References: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can be needed to have some MSI-X allocated as static and rest as
dynamic. For example on PF VSI. We want to always have minimum one MSI-X
on it, because of that it is allocated as a static one, rest can be
dynamic if it is supported.

Change the ice_get_irq_res() to allow using static entries if they are
free even if caller wants dynamic one.

Adjust limit values to the new approach. Min and max in limit means the
values that are valid, so decrease max and num_static by one.

Set vsi::irq_dyn_alloc if dynamic allocation is supported.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_irq.c | 25 ++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c |  2 ++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 99b82662434b..10caacaae804 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -45,7 +45,7 @@ static void ice_free_irq_res(struct ice_pf *pf, u16 index)
 /**
  * ice_get_irq_res - get an interrupt resource
  * @pf: board private structure
- * @dyn_only: force entry to be dynamically allocated
+ * @dyn_allowed: allow entry to be dynamically allocated
  *
  * Allocate new irq entry in the free slot of the tracker. Since xarray
  * is used, always allocate new entry at the lowest possible index. Set
@@ -53,11 +53,12 @@ static void ice_free_irq_res(struct ice_pf *pf, u16 index)
  *
  * Returns allocated irq entry or NULL on failure.
  */
-static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
+static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
+					     bool dyn_allowed)
 {
-	struct xa_limit limit = { .max = pf->irq_tracker.num_entries,
+	struct xa_limit limit = { .max = pf->irq_tracker.num_entries - 1,
 				  .min = 0 };
-	unsigned int num_static = pf->irq_tracker.num_static;
+	unsigned int num_static = pf->irq_tracker.num_static - 1;
 	struct ice_irq_entry *entry;
 	unsigned int index;
 	int ret;
@@ -66,9 +67,9 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
 	if (!entry)
 		return NULL;
 
-	/* skip preallocated entries if the caller says so */
-	if (dyn_only)
-		limit.min = num_static;
+	/* only already allocated if the caller says so */
+	if (!dyn_allowed)
+		limit.max = num_static;
 
 	ret = xa_alloc(&pf->irq_tracker.entries, &index, entry, limit,
 		       GFP_KERNEL);
@@ -78,7 +79,7 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
 		entry = NULL;
 	} else {
 		entry->index = index;
-		entry->dynamic = index >= num_static;
+		entry->dynamic = index > num_static;
 	}
 
 	return entry;
@@ -133,7 +134,7 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 /**
  * ice_alloc_irq - Allocate new interrupt vector
  * @pf: board private structure
- * @dyn_only: force dynamic allocation of the interrupt
+ * @dyn_allowed: allow dynamic allocation of the interrupt
  *
  * Allocate new interrupt vector for a given owner id.
  * return struct msi_map with interrupt details and track
@@ -146,20 +147,20 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
  * interrupt will be allocated with pci_msix_alloc_irq_at.
  *
  * Some callers may only support dynamically allocated interrupts.
- * This is indicated with dyn_only flag.
+ * This is indicated with dyn_allowed flag.
  *
  * On failure, return map with negative .index. The caller
  * is expected to check returned map index.
  *
  */
-struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_only)
+struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_allowed)
 {
 	int sriov_base_vector = pf->sriov_base_vector;
 	struct msi_map map = { .index = -ENOENT };
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_irq_entry *entry;
 
-	entry = ice_get_irq_res(pf, dyn_only);
+	entry = ice_get_irq_res(pf, dyn_allowed);
 	if (!entry)
 		return map;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1a1418454e5c..e211cf5e8ba0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -571,6 +571,8 @@ ice_vsi_alloc_def(struct ice_vsi *vsi, struct ice_channel *ch)
 			return -ENOMEM;
 	}
 
+	vsi->irq_dyn_alloc = pci_msix_can_alloc_dyn(vsi->back->pdev);
+
 	switch (vsi->type) {
 	case ICE_VSI_PF:
 	case ICE_VSI_SF:
-- 
2.42.0


