Return-Path: <netdev+bounces-205951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE5B00E11
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EF84E7133
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB0D29A30A;
	Thu, 10 Jul 2025 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3dUbaUV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69C293C57
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183932; cv=none; b=mkm2nCOfheguf2Opcw/0fCcUiaWpoSRU3jDCq0SCsqyUY9qU3osF4h0dqztlmboKfxgzCjrhDmkR6DRjHnIOPTQ71WEmbsif47Bl4gl1dYkt7D31Z6HfhVXqksxivnVXk7yKkJSAFN79xHyuUBZ8FJhIBQUHwTWzGYQEfIYARfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183932; c=relaxed/simple;
	bh=ru3zARL+IYX5nXukE4JANWjxynAQnZOH8TVajAU4p+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYgiVjO8Hvq3WV19g8cMX2Ipf4eRmkF1dEX3XYzG/x/W4NTWCjEpdo2ecpl8s7W/93SIDhJGsBJOXsOmLtwhmb5S9ZnglMoF9x6d9fe9qe+x0xv2NEiqSqYScsanyqj0cpZmiQmSdrLd5MFQJwRAVy/hS6DwpVF6zHn0RJBEY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3dUbaUV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183932; x=1783719932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ru3zARL+IYX5nXukE4JANWjxynAQnZOH8TVajAU4p+g=;
  b=E3dUbaUVQ2LtIf/21BTBbFiI3N8dH4DBmKrrOZR2IynUgQ5XfihqimNa
   rAYEz0aEO11AjWCyBU1Jm6ZvObWFDkL9GbDAWwMlLHqSP3jlBZoP6DZ6w
   JiBhS8do6h/4Jw5F3mOkNCVeEK0bO1i2h99qLkadb6fOb1DV/A4lByFj0
   ai7bJgZbU3W4KSxFuSl0E4Sr5tZqNxFMNJ4gDsZYoa3V2i5WMN6ZsCnrq
   c2UtkDMd8L6uf7S2CoLygG9IftFq7h5KskWYbCbcHvISHCe0QkJTurCzR
   GpBy7bYaePrUr8sVNzL/CpY7wnOmoWhCAgOVaEuuSEgAHH/HOsP4A/sff
   A==;
X-CSE-ConnectionGUID: twMaavwsTNekPaOSfrWOGg==
X-CSE-MsgGUID: dInWHFd9TBGFQPoQL2lmFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192392"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192392"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:29 -0700
X-CSE-ConnectionGUID: 6SajvlRWReSbNkyNDQQlLg==
X-CSE-MsgGUID: AbLJOso1QZWE6h3P4r3Nyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764964"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 8/8] ice: introduce ice_get_vf_by_dev() wrapper
Date: Thu, 10 Jul 2025 14:45:17 -0700
Message-ID: <20250710214518.1824208-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_get_vf_by_id() function is used to obtain a reference to a VF
structure based on its ID. The ice_sriov_set_msix_vec_count() function
needs to get a VF reference starting from the VF PCI device, and uses
pci_iov_vf_id() to get the VF ID. This pattern is currently uncommon in the
ice driver. However, the live migration module will introduce many more
such locations.

Add a helper wrapper ice_get_vf_by_dev() which takes the VF PCI device and
calls ice_get_vf_by_id() using pci_iov_vf_id() to get the VF ID.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c  |  7 +------
 drivers/net/ethernet/intel/ice/ice_vf_lib.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index f78d5d8d516c..c434326a4694 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -933,7 +933,6 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	bool needs_rebuild = false;
 	struct ice_vsi *vsi;
 	struct ice_vf *vf;
-	int id;
 
 	if (!ice_get_num_vfs(pf))
 		return -ENOENT;
@@ -952,11 +951,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (msix_vec_count < ICE_MIN_INTR_PER_VF)
 		return -EINVAL;
 
-	id = pci_iov_vf_id(vf_dev);
-	if (id < 0)
-		return id;
-
-	vf = ice_get_vf_by_id(pf, id);
+	vf = ice_get_vf_by_dev(pf, vf_dev);
 	if (!vf)
 		return -ENOENT;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index a5ee380f8c9e..ffe1f9f830ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -239,6 +239,18 @@ static inline bool ice_vf_is_lldp_ena(struct ice_vf *vf)
 
 #ifdef CONFIG_PCI_IOV
 struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id);
+
+static inline struct ice_vf *ice_get_vf_by_dev(struct ice_pf *pf,
+					       struct pci_dev *vf_dev)
+{
+	int vf_id = pci_iov_vf_id(vf_dev);
+
+	if (vf_id < 0)
+		return NULL;
+
+	return ice_get_vf_by_id(pf, pci_iov_vf_id(vf_dev));
+}
+
 void ice_put_vf(struct ice_vf *vf);
 bool ice_has_vfs(struct ice_pf *pf);
 u16 ice_get_num_vfs(struct ice_pf *pf);
@@ -265,6 +277,12 @@ static inline struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
 	return NULL;
 }
 
+static inline struct ice_vf *ice_get_vf_by_dev(struct ice_pf *pf,
+					       struct pci_dev *vf_dev)
+{
+	return NULL;
+}
+
 static inline void ice_put_vf(struct ice_vf *vf)
 {
 }
-- 
2.47.1


