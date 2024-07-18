Return-Path: <netdev+bounces-112054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4842934C0A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D95B21B3E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157B13665D;
	Thu, 18 Jul 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hD3e/UEU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D3132132
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300074; cv=none; b=Bv/fQFfzPuqXu4Yj8QYD9WavIF5GGpckEfUx7I37AyKHVbBu7W8LLpJeOHGSpMEpqvwzCPRqvgUaoDn2Aw23aB5CQL2wrS7OH6bNIirTb5FfqdB8qJjmCRcwK/snWklATSElZFk63FPGWiXIZz2sc+q5d3UEnDUhr+xW7RdCPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300074; c=relaxed/simple;
	bh=SXUTjuLbd86WPMG5JGmxpzwxEKlbhdkj0htFiOTP3A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeuW3UzMCt3YuphUSFdSAgKBHwu4cmXd/i8PKLmFAVKcaqoKVPR3TfRsrdUlmINewbGazqJ1Cj5bxvwp2wb+cLhWM8U36/12z4t48SqvwPP1PeWs6iO2vxukbwnrfxERdAX//gkUdpAO6Hdku7Jgm9PeBAQ2qGwMBu0J7cU9sHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hD3e/UEU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721300072; x=1752836072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SXUTjuLbd86WPMG5JGmxpzwxEKlbhdkj0htFiOTP3A0=;
  b=hD3e/UEUAtc++9B+HvOIvkDfJC7oh1BM3z+Wawe419+hRVb8DTSUZU+n
   dSzdJ36lFmrWzNBNWSQPO9LOQ40/ZvySuTKiwb+W8gmSLEQcYKt7HS2Yv
   fOWM8vHrFTwDtnxFwQOL3wahCdzOfVJEWS3zh6MEvRa/JRrGVmuCECT81
   MUVtaBDs7BkD8MhWruG8+X/J9Vnp4mFgm+OEiNOh6Pb2JTn2LgfG8i3DS
   mPfYE0YTbvWJQ094q6PD87oAlxKWCcs4Zr580iNqF0MEIGfFdoF0dA5Iq
   iUYm2QrOtL+V9qQ3daeaSrmFhbM/UNtDKwsSbPV7RTq2FDHUgw2ylISdb
   Q==;
X-CSE-ConnectionGUID: /6tLUj1vQ1CWllx/PymCHA==
X-CSE-MsgGUID: ErE2FCUkRcSg3ngDzYOrdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18987492"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18987492"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 03:54:32 -0700
X-CSE-ConnectionGUID: L3kq+rnYSrCoftu7OjGGew==
X-CSE-MsgGUID: 7yZGX9AIRO+oc7HwcwSfDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50774583"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa009.jf.intel.com with ESMTP; 18 Jul 2024 03:54:31 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v4 2/5] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
Date: Thu, 18 Jul 2024 12:52:50 +0200
Message-ID: <20240718105253.72997-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
References: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
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
Rearrange fields in struct ice_adapter

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 9d11014ec02f..eb7cac01c242 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,18 +8,21 @@
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
+	refcount_t refcount;
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 
-	refcount_t refcount;
+	struct ice_pf *ctrl_pf;
 };
 
 struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 038f6b8f43df..1cf620eebc2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -57,6 +57,18 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e810_sma[] = {
 	{  UFL2, { -1,  3 }},
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
  * ice_ptp_find_pin_idx - Find pin index in ptp_pin_desc
  * @pf: Board private structure
-- 
2.43.0


