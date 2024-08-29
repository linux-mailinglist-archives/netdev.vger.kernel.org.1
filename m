Return-Path: <netdev+bounces-123225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727D964326
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48F51F2497C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2A192B7C;
	Thu, 29 Aug 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKeGCtrf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F2191F94
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931196; cv=none; b=QdWUB4ggBFahCNgaSrKDbii6uUq41urDketkgSiDAR85Dejo/KIOQjPI6GmYlKC5f0PLLd/eDH9HU82A14vwGj/z5Cb9UQDSRiXc89SrFU4mJc14FJ/qNSw2faoFbzPttjEbCfVK9HNwnU77J8wWAPX11licsTYenn+VHd087AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931196; c=relaxed/simple;
	bh=/IcPBdXvjD/f4VkKlk7OQVr9f4DE8fR8skgDvmj1WZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azktLIEn688PfBBc3DkzmFaAP+IiVgKn+FJhfd3j8kShWuagckUHKxTRhGrlXOJRjTaT2bLKJcQSN3CUz5h+7NUU6o0StxN5C6yFrU70LOiEAR2NryB/fIlLZ/l/bMQyqS4UsUwayNZcmh52YWDTeQFEdmXTsttjdmbGXl/vx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKeGCtrf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724931195; x=1756467195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IcPBdXvjD/f4VkKlk7OQVr9f4DE8fR8skgDvmj1WZ0=;
  b=VKeGCtrfT0GbqaR55ryW0Yz6qihhRfZ8X7JiDRtu8U826iMjeYMWQ1rW
   WQoF3hStFRrRFnxYDNaG82VxADpUc2W36Z+8J0buFPdfTdQNXB3DOebOj
   oIFF6l82C7PhuE1pcAA/CFY+YpRLcUzl49Jh0WFtTBeU+hKOUnU+wxB+b
   /XtU7ZBbhzNIGTk+3hhI31ShVnySeaCN5zGaK4arDD+qhOWGY9/cDrxPu
   NWIPGgKpbHZ5BVm7cSZJ3H4BLLa4N0ojl2QJwkAZbKlws4hxwIwCNxSMB
   yUGTJuWucmdwLaziEMf+4N16mLek9Woxu2CCcmuDObbxBaoMdpt1zUJkp
   w==;
X-CSE-ConnectionGUID: yn8JL5rHQWia01/8kIVeRQ==
X-CSE-MsgGUID: jsJ/ZHvcSSS0g7S1eLWZLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23677879"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23677879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:33:14 -0700
X-CSE-ConnectionGUID: 31yXvDvjSLKE2ju/WU5XIw==
X-CSE-MsgGUID: 0TngHQFXStCkwaYRAggdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63230614"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa007.fm.intel.com with ESMTP; 29 Aug 2024 04:33:13 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v3 iwl-next 5/7] ice: Disable shared pin on E810 on setfunc
Date: Thu, 29 Aug 2024 13:28:12 +0200
Message-ID: <20240829113257.1023835-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829113257.1023835-9-karol.kolacinski@intel.com>
References: <20240829113257.1023835-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting a new supported function for a pin on E810, disable other
enabled pin that shares the same GPIO.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: Fixed incorrect call to ice_ptp_set_sma_cfg_e810t()

 drivers/net/ethernet/intel/ice/ice_ptp.c | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 45e4b8654317..26f6ebc7bb84 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1852,6 +1852,63 @@ static void ice_ptp_enable_all_perout(struct ice_pf *pf)
 					   true);
 }
 
+/**
+ * ice_ptp_disable_shared_pin - Disable enabled pin that shares GPIO
+ * @pf: Board private structure
+ * @pin: Pin index
+ * @func: Assigned function
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int ice_ptp_disable_shared_pin(struct ice_pf *pf, unsigned int pin,
+				      enum ptp_pin_function func)
+{
+	uint gpio_pin, i;
+
+	switch (func) {
+	case PTP_PF_PEROUT:
+		gpio_pin = pf->ptp.ice_pin_desc[pin].gpio[1];
+		break;
+	case PTP_PF_EXTTS:
+		gpio_pin = pf->ptp.ice_pin_desc[pin].gpio[0];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < pf->ptp.info.n_pins; i++) {
+		struct ptp_pin_desc *pin_desc = &pf->ptp.pin_desc[i];
+		uint chan = pin_desc->chan;
+
+		/* Skip pin idx from the request */
+		if (i == pin)
+			continue;
+
+		if (pin_desc->func == PTP_PF_PEROUT &&
+		    pf->ptp.ice_pin_desc[i].gpio[1] == gpio_pin) {
+			pf->ptp.perout_rqs[chan].period.sec = 0;
+			pf->ptp.perout_rqs[chan].period.nsec = 0;
+			pin_desc->func = PTP_PF_NONE;
+			pin_desc->chan = 0;
+			dev_dbg(ice_pf_to_dev(pf), "Disabling pin %u with shared output GPIO pin %u\n",
+				i, gpio_pin);
+			return ice_ptp_cfg_perout(pf, &pf->ptp.perout_rqs[chan],
+						  false);
+		} else if (pf->ptp.pin_desc->func == PTP_PF_EXTTS &&
+			   pf->ptp.ice_pin_desc[i].gpio[0] == gpio_pin) {
+			pf->ptp.extts_rqs[chan].flags &= ~PTP_ENABLE_FEATURE;
+			pin_desc->func = PTP_PF_NONE;
+			pin_desc->chan = 0;
+			dev_dbg(ice_pf_to_dev(pf), "Disabling pin %u with shared input GPIO pin %u\n",
+				i, gpio_pin);
+			return ice_ptp_cfg_extts(pf, &pf->ptp.extts_rqs[chan],
+						 false);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_verify_pin - verify if pin supports requested pin function
  * @info: the driver's PTP info structure
@@ -1886,6 +1943,14 @@ static int ice_verify_pin(struct ptp_clock_info *info, unsigned int pin,
 		return -EOPNOTSUPP;
 	}
 
+	/* On adapters with SMA_CTRL disable other pins that share same GPIO */
+	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
+		ice_ptp_disable_shared_pin(pf, pin, func);
+		pf->ptp.pin_desc[pin].func = func;
+		pf->ptp.pin_desc[pin].chan = chan;
+		return ice_ptp_set_sma_cfg(pf);
+	}
+
 	return 0;
 }
 
-- 
2.46.0


