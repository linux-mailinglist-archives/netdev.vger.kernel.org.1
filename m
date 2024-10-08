Return-Path: <netdev+bounces-133336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E298A995B49
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B102837E7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E45217915;
	Tue,  8 Oct 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed2c+II0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D98216A21
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428474; cv=none; b=JdJNsuXsXsUC/+hzutH+XQbDFMCcibobv5sJLEqhjWm7dCvhnucrQeiput/eITKfIbQTwCgTVY9fZvOXJUzeeX5kkHRC5543X+jn7GmrZ+hpgd4KAto7aQqbRDH8LW+sFS79+bhJUBDmLyPzpDAvWxXIt7EhQoRig2SPzTJBilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428474; c=relaxed/simple;
	bh=7XyXJqfiNF825SX/6My4tvB2y9vPZ/Jp9eeDzkQVYw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ/tfb+8ihU9sqtDZoafUmUpiMpPeIgoVkJjL577TjX6mpEmRF/t+bAhDiCrKGOFrDlsio4njpzRzYC6JJyQESvOapdxKPaOvJZkqZpOPn1e/ty/tvUnXAv4ka1OsYhBUyfFNXQ3qZ1ttHxyKBVZBpDx/2z4p1kRFvxDZRB63jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed2c+II0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428473; x=1759964473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XyXJqfiNF825SX/6My4tvB2y9vPZ/Jp9eeDzkQVYw4=;
  b=Ed2c+II06HqPAFKDi8At4kbx9C3uO7AS0Dd0o+Rn4RAqaX1UrA2SJrDa
   bcRf+8UtaQ0T+U1bpmeahhGnAGWyHSQxUxo7msrrAGt83FiIuEUXoECy4
   ydnYrYYiu7ivH6x7h+fRY93gfPn23DQQGuo/BiCA8/G9l31jSxhzc/PWN
   b3FzYCVkOEzYsC3QFCU6abo/68znYQzH7xqzov8jqMow6NQttsKbfwrmJ
   52djM8gyKke9HLMLYndqfY+ky9Rf2VN0UauVR3d0AMdb7UWUyNdLEFLrx
   HJM5r7Z+IS1KUN08OMoW41931OewI9LYaEOIVA5QcYB4IFrXZWUi3T+2O
   A==;
X-CSE-ConnectionGUID: 7IXxCK0hReKPDHsrEy3Yiw==
X-CSE-MsgGUID: v2p3Vk2bQ0yy5FnPubya8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302417"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302417"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:10 -0700
X-CSE-ConnectionGUID: DJRu0z05QhW9ZB8r+SDT0g==
X-CSE-MsgGUID: 0emo9FP/RgS1NtdQX3eygg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787592"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	poros@redhat.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/7] ice: Fix increasing MSI-X on VF
Date: Tue,  8 Oct 2024 16:00:42 -0700
Message-ID: <20241008230050.928245-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Increasing MSI-X value on a VF leads to invalid memory operations. This
is caused by not reallocating some arrays.

Reproducer:
  modprobe ice
  echo 0 > /sys/bus/pci/devices/$PF_PCI/sriov_drivers_autoprobe
  echo 1 > /sys/bus/pci/devices/$PF_PCI/sriov_numvfs
  echo 17 > /sys/bus/pci/devices/$VF0_PCI/sriov_vf_msix_count

Default MSI-X is 16, so 17 and above triggers this issue.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
  Read of size 8 at addr ffff8888b937d180 by task bash/28433
  (...)

  Call Trace:
   (...)
   ? ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
   kasan_report+0xed/0x120
   ? ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
   ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
   ice_vsi_cfg_def+0x3360/0x4770 [ice]
   ? mutex_unlock+0x83/0xd0
   ? __pfx_ice_vsi_cfg_def+0x10/0x10 [ice]
   ? __pfx_ice_remove_vsi_lkup_fltr+0x10/0x10 [ice]
   ice_vsi_cfg+0x7f/0x3b0 [ice]
   ice_vf_reconfig_vsi+0x114/0x210 [ice]
   ice_sriov_set_msix_vec_count+0x3d0/0x960 [ice]
   sriov_vf_msix_count_store+0x21c/0x300
   (...)

  Allocated by task 28201:
   (...)
   ice_vsi_cfg_def+0x1c8e/0x4770 [ice]
   ice_vsi_cfg+0x7f/0x3b0 [ice]
   ice_vsi_setup+0x179/0xa30 [ice]
   ice_sriov_configure+0xcaa/0x1520 [ice]
   sriov_numvfs_store+0x212/0x390
   (...)

To fix it, use ice_vsi_rebuild() instead of ice_vf_reconfig_vsi(). This
causes the required arrays to be reallocated taking the new queue count
into account (ice_vsi_realloc_stat_arrays()). Set req_txq and req_rxq
before ice_vsi_rebuild(), so that realloc uses the newly set queue
count.

Additionally, ice_vsi_rebuild() does not remove VSI filters
(ice_fltr_remove_all()), so ice_vf_init_host_cfg() is no longer
necessary.

Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c          | 11 ++++++++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c         |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h |  1 -
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index c2d6b2a144e9..91cb393f616f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1121,7 +1121,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		goto unroll;
 
-	if (ice_vf_reconfig_vsi(vf) || ice_vf_init_host_cfg(vf, vsi)) {
+	vsi->req_txq = queues;
+	vsi->req_rxq = queues;
+
+	if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {
 		/* Try to rebuild with previous values */
 		needs_rebuild = true;
 		goto unroll;
@@ -1150,8 +1153,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	}
 
 	if (needs_rebuild) {
-		ice_vf_reconfig_vsi(vf);
-		ice_vf_init_host_cfg(vf, vsi);
+		vsi->req_txq = prev_queues;
+		vsi->req_rxq = prev_queues;
+
+		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
 	}
 
 	ice_ena_vf_mappings(vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 749a08ccf267..8c434689e3f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -256,7 +256,7 @@ static void ice_vf_pre_vsi_rebuild(struct ice_vf *vf)
  *
  * It brings the VSI down and then reconfigures it with the hardware.
  */
-int ice_vf_reconfig_vsi(struct ice_vf *vf)
+static int ice_vf_reconfig_vsi(struct ice_vf *vf)
 {
 	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
 	struct ice_pf *pf = vf->pf;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 91ba7fe0eaee..0c7e77c0a09f 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -23,7 +23,6 @@
 #warning "Only include ice_vf_lib_private.h in CONFIG_PCI_IOV virtualization files"
 #endif
 
-int ice_vf_reconfig_vsi(struct ice_vf *vf);
 void ice_initialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
 int ice_check_vf_init(struct ice_vf *vf);
-- 
2.42.0


