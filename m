Return-Path: <netdev+bounces-141539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAFA9BB467
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3502B2625C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDEE1B983E;
	Mon,  4 Nov 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG0kKIzo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178701B6CFB
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722446; cv=none; b=m57iAJffW1/YpwE9FTwVsuNB/3ueJB/P/wwtMrPWqsa96W8n3ECMVqkEdpQ1sU23Opv/S6seoJMi10kXms1TIbA2p9yWOWAHnsrbEhDJsfWDBPm84d03A6wTgo6VYPeQKvWdyzwHvVt7jxmP7jzseX0hTmUxQURF1Tkld/g88lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722446; c=relaxed/simple;
	bh=WJyoEl694veiSM2t8QqIfUsb+FEq3Hm2ht8zyFG8PJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by9ZIGlktGFiKgp+u0Wo1GWwF9XT0XRuVf1Aa8tuZEMp45xFHYROOTImBI/5zPBzl2H5G1p8Rdqz5lSQ4B1AftLC+VEeXPFBDUEvN2QkMTWTLDe/tw2SGqeLfZ8syUpZSjWMxCHPulm7lV4gVE44u5KxAGMpvKSreXtbQgjRT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG0kKIzo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730722445; x=1762258445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJyoEl694veiSM2t8QqIfUsb+FEq3Hm2ht8zyFG8PJc=;
  b=PG0kKIzoDo/GE8N4MJ6nmwTtQ+gPEpO3NF6Ta74SWpCA+HYrO1wiqguh
   eEl4Wq2/eQDGdu4qgtw5tFmtDFPvZ7sXbgXQy2Ea8D5Zv/mg3C6HtkHhw
   OUBSDn+1NAkZgdLoXuBV9mqYG/72V3XxkZ1eNjTL3m3qzzX45y8bHZZti
   IwlfUsi82z0wud39S1kPpJPatLzlRrWQoLmJj+P0q7LHDvVBEkT/yykqG
   NCPMRw1viJG19jltva7sXpfY4sQ2XjyCYujSUmAhxeNAyLj5ejoHY7XwW
   +A55nmoUNnt/mWBuZgBIl2+WIaOCtE9t4iOGjzs6diwLwGhBBoNCh/eYi
   g==;
X-CSE-ConnectionGUID: vVvlv5GSSnCd9eCpyf//1Q==
X-CSE-MsgGUID: sCM0f1h/R7qGghBZSX1mCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29843714"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="29843714"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 04:14:05 -0800
X-CSE-ConnectionGUID: bF/zb+uRRkijz7PViDhpNw==
X-CSE-MsgGUID: +T7D0FQHTPitwClMhUgTSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83525784"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2024 04:14:01 -0800
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
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com
Subject: [iwl-next v7 6/9] ice: treat dyn_allowed only as suggestion
Date: Mon,  4 Nov 2024 13:13:34 +0100
Message-ID: <20241104121337.129287-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_irq.c | 25 ++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c |  2 ++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 80c9ee2e64c1..d466d29b2ef1 100644
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
@@ -137,7 +138,7 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 /**
  * ice_alloc_irq - Allocate new interrupt vector
  * @pf: board private structure
- * @dyn_only: force dynamic allocation of the interrupt
+ * @dyn_allowed: allow dynamic allocation of the interrupt
  *
  * Allocate new interrupt vector for a given owner id.
  * return struct msi_map with interrupt details and track
@@ -150,20 +151,20 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
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
index ecc850a43643..01afa5f84af9 100644
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


