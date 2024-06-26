Return-Path: <netdev+bounces-106922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB23918181
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0796F1C20F3C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06EE181335;
	Wed, 26 Jun 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjPI/VH6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC89181D07
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406585; cv=none; b=tKYt7V2N5hqUxOD5JfHQmTfWG3DhJArli5DoIb3YGmop9/hlDdrCDimJctSxLsMS+H1Op6MDbdw+VkRdENVmzaJ1RKFr1xetTu3a1+VabgWIePIU12gDlaz8O7rCkrOE5jzyZpX4N9iXB6S67CMCIX0sEyxFKCwwcvw5ETu1V94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406585; c=relaxed/simple;
	bh=zRkWdP/V/ihiCFhoWaRYKlgJ6N+PAWNhR2x3Kv40m8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0Nx0u8JXSH3RD59hUD2svNSl3C1Zt9pqGdhC1EE2Jz3q0PwuIoVHp+huPcgU4JEGZdaGIhe19YthOzkEDNK97eaxk8vzOQb+i6wrBrcQ+tYC0ho5lgtzcX1wkbaO4wy3EUjxsleB1y/Kgh7s/OD1cyT3uNRbC4RVSxiddjg0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjPI/VH6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719406584; x=1750942584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRkWdP/V/ihiCFhoWaRYKlgJ6N+PAWNhR2x3Kv40m8I=;
  b=YjPI/VH6MwzJZnd6J/u+GaXPV+mtFS/RqWwOaiMXSCgpaGFmv4QOv8PM
   RHTHBGYI3mnKSiUd/3IIcpDol6EQGrNMAcCrp7WyLB2A3+IlDtw8EPbWG
   UCBtHGCDgoAR10GnK/jAtPanpSHhQQM7L8vKC7ayZ3hhgn2ZGw3rsTOxk
   HnVazFaM00uDrv1hl8U9nCzUSN9Ke8LrfSgjUp0k4cDiF0St+tTnS4NcR
   OJBeM87SjcJ7KoOALnNcaeck5fHW5xwhQsvlzdJWrHjOFsN3bzJqe35uK
   7e9qZSu3RfumnjrXPACbb2T+J30pL2A36UOnRdF60Jm+WdOwv6O76Yr8B
   Q==;
X-CSE-ConnectionGUID: hHo9eXVfRcGL9rOCQEBoNA==
X-CSE-MsgGUID: x/lReRCcR0iqkwFYw/YRyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16158107"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16158107"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:56:24 -0700
X-CSE-ConnectionGUID: rgXF8XcRQQSEpWUpDlaj0w==
X-CSE-MsgGUID: ZBSE9j7bSjunPM/Q8VD64w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48594644"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jun 2024 05:56:23 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2 2/4] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
Date: Wed, 26 Jun 2024 14:54:54 +0200
Message-ID: <20240626125456.27667-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
References: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
in the functions that do not use ctrl_pf directly.
Add the control PF pointer to struct ice_adapter

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 9d11014ec02f..c5ed6f56b36e 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,18 +8,22 @@
 #include <linux/refcount_types.h>
 
 struct pci_dev;
+struct ice_pf;
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @refcount: Reference count. struct ice_pf objects hold the references.
+ * @ctrl_pf: Control PF of the adapter
  */
 struct ice_adapter {
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 
 	refcount_t refcount;
+
+	struct ice_pf *ctrl_pf;
 };
 
 struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 2f32dcd42581..53a3b6fc9dec 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -16,6 +16,18 @@ static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
 	{ "U.FL2", UFL2, PTP_PF_NONE, 2, { 0, } },
 };
 
+static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
+{
+	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+}
+
+static __maybe_unused struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
+{
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+
+	return !ctrl_pf ? NULL : &ctrl_pf->ptp;
+}
+
 /**
  * ice_get_sma_config_e810t
  * @hw: pointer to the hw struct
-- 
2.43.0


