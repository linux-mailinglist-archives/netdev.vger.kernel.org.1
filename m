Return-Path: <netdev+bounces-205947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F26B00E0C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7169D4E7997
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637C17C211;
	Thu, 10 Jul 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ga3wSaOL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11D290092
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183930; cv=none; b=uA9v8hUec1WzGg3RudNceMGeMqHb3DQtGbtKksqSRCsVf9B7rfxdVCV9PR36yeKwiWXyTWEK+Al1POUARs7cKfhQHHzh4pLehppOix9nLpr4ZI14UDd2M8mjoO7ovUdM0GCAlUWpVtYnUCYTKDpWRX6/4JCEyEKrkG7j2MYRsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183930; c=relaxed/simple;
	bh=kSUBMduIJUz8yB+qRtfONeCYT946k82w+UBMPAUxQvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JprZc4MNDVqyMjo+4Z/5OCXbBlTjPqe7K/11f2ewNDb+3LVEbDOVZXLX2rhrlEVoEhnNm+V77aIzJAVyaqnpzVdw2B7sDLw6CZxsW6v+oT8kptZJE72xMbY9jhT/4fJDdXyhxPUlJ7tSvlKmYb9zi76YAePcNF6XZBIeN+8Ivs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ga3wSaOL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183930; x=1783719930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSUBMduIJUz8yB+qRtfONeCYT946k82w+UBMPAUxQvo=;
  b=Ga3wSaOLK9SJlI7eyFna2jdjDeVe1v9TuTzI+MyjwffuoRIgI73/DUzD
   iEgnlukDjmq2l8WbLzRrgy6m2qf7VHZq7ZGjvIdZJdWh0swsfVDRcFJ91
   4gkEoCzcC3fV6ol2vDGT67l7zYjy/T9BxgIHUu3OvStBUJ7gWN5iAdFzp
   Fd92nejDh9otWLpAZoTHdocz+RWC8nQDCpdfcy9IO79lz4z3SXGM0xzMn
   WgqyRWd6fBRhFTWNoQQ+NC+rrX7Ehhznu8idxsicP+oAj5v8wyA7MMkCR
   Pe8q2DmpR/LT2JQZ+9qXI8rhhO/TU5fjVyCBa9hb2ENrYSa5UZ4nL2zCI
   g==;
X-CSE-ConnectionGUID: pk4ntGABSHCIb1CPDsvf9Q==
X-CSE-MsgGUID: zBf5LguiSPaE0IIZpy3VzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192379"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:28 -0700
X-CSE-ConnectionGUID: o/rGrV7kTYyF2AIQNlNrSA==
X-CSE-MsgGUID: ii1loF/0RdSrh0NUzniHQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764955"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:27 -0700
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
Subject: [PATCH net-next 6/8] ice: use pci_iov_vf_id() to get VF ID
Date: Thu, 10 Jul 2025 14:45:15 -0700
Message-ID: <20250710214518.1824208-7-anthony.l.nguyen@intel.com>
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

The ice_sriov_set_msix_vec_count() obtains the VF device ID in a strange
way by iterating over the possible VF IDs and calling
pci_iov_virtfn_devfn to calculate the device and function combos and
compare them to the pdev->devfn.

This is unnecessary. The pci_iov_vf_id() helper already exists which does
the reverse calculation of pci_iov_virtfn_devfn(), which is much simpler
and avoids the loop construction. Use this instead.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 0e4dc1a5cff0..f88bfd2f3f00 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -952,17 +952,11 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (msix_vec_count < ICE_MIN_INTR_PER_VF)
 		return -EINVAL;
 
-	/* Transition of PCI VF function number to function_id */
-	for (id = 0; id < pci_num_vf(pdev); id++) {
-		if (vf_dev->devfn == pci_iov_virtfn_devfn(pdev, id))
-			break;
-	}
-
-	if (id == pci_num_vf(pdev))
-		return -ENOENT;
+	id = pci_iov_vf_id(vf_dev);
+	if (id < 0)
+		return id;
 
 	vf = ice_get_vf_by_id(pf, id);
-
 	if (!vf)
 		return -ENOENT;
 
-- 
2.47.1


