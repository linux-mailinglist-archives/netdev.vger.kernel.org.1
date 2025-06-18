Return-Path: <netdev+bounces-199272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9DADF968
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC95619C9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687C2877E1;
	Wed, 18 Jun 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcUX+rYa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D389281505
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285512; cv=none; b=Em3TlpVwCggIpVv1tH/moA1TQw871TX/12T7Sd4lcv5+V1hMtpLtBWKyC0DYYMmSp06W4SGu+Fjbfo2StY5MmO2O1i9n24Jr8grD/VPpCzLeJKl6aL8Zys8ICbGtLPrEjiXAocNQQUHXzexNjtaK8goI5pCQKQho1gKDFIbZmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285512; c=relaxed/simple;
	bh=iAU0fMeHTqflINE2bDtzjWRAbN0eR6rupCjNhm6N7pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ibu5tWsutMZGST8Ng8d2oMwWgZwCrxxfwuq+m8p3d4zsjSriG3y8RsnMnuh3ydSViheB8WBHlwTf5s6sLXYW93K6Asu9r8cBD1B+vSfJ3BJiPQomNhzV0hq/E660uRgmeji6zFabaiQEkaUko0oJU200e0Dm5L5cC/WG9TfQIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcUX+rYa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285511; x=1781821511;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iAU0fMeHTqflINE2bDtzjWRAbN0eR6rupCjNhm6N7pc=;
  b=OcUX+rYaKcCezHwei4+bVcdnegl/pbLR+rkS8nQ3NtYeNmSlNPCX1T8J
   Msm599/Rd18P8XM9T32vKS7EasAoMp27oK+fJoXJ0y5zAnlgxZCOt1UWU
   Yw87nSUq0tnuehwA3LI2xx3AppycMxwGt+kuHbNjlPsG6e64rSF2HAr7x
   HWqFTZj7XoxTDN/n5SrJJ2wtlyefJXloZwaI76/Oh81YZDBMwaHb3K/pL
   q3OKjah7UtM2yJO6wOSObaWl9AdDv0vh76vJZiCQJwTOZ9TrbqK0KRsGd
   NaM1PD8fkxC7s+UEVfxBAPkK+zaQqialYW7PIFguFRvIuYGnuUtkpj8Ui
   Q==;
X-CSE-ConnectionGUID: qn6fMmiHSBWGZg+8DO1YHA==
X-CSE-MsgGUID: 5OMbKMMGTXKAdFSlyEN70A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447746"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447746"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:05 -0700
X-CSE-ConnectionGUID: +A7NjLOUQ0OUPJBXBcV83Q==
X-CSE-MsgGUID: C1tZlMVJQg+0gU2Zi3FygQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870028"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 15:24:43 -0700
Subject: [PATCH iwl-next 8/8] ice: introduce ice_get_vf_by_dev() wrapper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-8-72a37485453e@intel.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

The ice_get_vf_by_id() function is used to obtain a reference to a VF
structure based on its ID. The ice_sriov_set_msix_vec_count() function
needs to get a VF reference starting from the VF PCI device, and uses
pci_iov_vf_id() to get the VF ID. This pattern is currently uncommon in the
ice driver. However, the live migration module will introduce many more
such locations.

Add a helper wrapper ice_get_vf_by_dev() which takes the VF PCI device and
calls ice_get_vf_by_id() using pci_iov_vf_id() to get the VF ID.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h | 26 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sriov.c  |  7 +------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index a5ee380f8c9e53d6e5ac029b9942db380829a84f..e538b4ecc6cec7d8bd26b7d198197fd5c3ed2e60 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -239,6 +239,26 @@ static inline bool ice_vf_is_lldp_ena(struct ice_vf *vf)
 
 #ifdef CONFIG_PCI_IOV
 struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id);
+
+/**
+ * ice_get_vf_by_dev - Get pointer to VF by VF PCI device pointer
+ * @pf: the PF private structure
+ * @vf_dev: the VF PCI device pointer
+ *
+ * Convenience wrapper to call ice_get_vf_by_id() using pci_iov_vf_id() to get
+ * the VF ID.
+ */
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
@@ -265,6 +285,12 @@ static inline struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 964c474322196fa8875767ac2667be5d550a6765..9ce4c4db400e1239edf974ae85d27da3abf4c083 100644
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
 

-- 
2.48.1.397.gec9d649cc640


