Return-Path: <netdev+bounces-108491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA594923F55
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B3A286105
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5E1B5829;
	Tue,  2 Jul 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2lNQNMg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BA1B47DC
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927909; cv=none; b=T/YhDRfAZuxmwIj7w6hhZ4JaoRXr/saMM0vWxHseshXbF9l6TqeDnwWWJtYb46v6S53RdHq9zGN21s9qpDdQh87m5hY7+/oa6rUWHiO/lv9gR8ZbnCZfZqnqfGXwGbHzSQSpdDxMKUwnZ1+PAurX5uCBKIwh0hE1u7LycZ5QStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927909; c=relaxed/simple;
	bh=CpqYtCIpwSmhP7EXWw0mfhxzEtWgoFkbm2G25RlGZJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAAQRVoWxF/I4BVIQl37IsJ1dr2Ctxhk1ekNdgQfR9yW/DuEIyb7kLZjCf9H29pmguMxDkA6IHeRZVl9wilWgIFFkkUr+6sS5IFlTvIvg4eKQYwxkhoM/a0hUslAQjHAVklLmY8tKV0hI3mF/4Ya95uQZUeYjsQ5BxSrxwJAZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2lNQNMg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719927908; x=1751463908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpqYtCIpwSmhP7EXWw0mfhxzEtWgoFkbm2G25RlGZJc=;
  b=D2lNQNMgEvPjH6Gc37gWiILyD13MpyCq7R9tP5MHYmwnGs2rqfYjUbAG
   kxwv/zO/wp1WLQYDSTkHU+km8l7F5hzAwylLZ5aNYcvbIoYXUpsqyBehP
   1Lh0bCJUTp+bMTqBupS+/igA1OQChjHBAs+nPSP8TYGGwBL16gb6ET8D2
   UfE+6Gzy3fnpbY1f6d7kmzgEyXxl3qeZus2CzPmDV6wgi9/B/ZhMRvnYi
   OP3yQNvwT6S2zh06L6BFAFBDAqqzXi5bvcPoJFXfjA+wuxeFgbOYjQYrW
   gJ6KkzLScVyAH0iusMbxGYRX23C09oqpnLbhQEbibm5POHy7MzVbQwtrF
   A==;
X-CSE-ConnectionGUID: bvryJFOfS8qy9cy0wy10nQ==
X-CSE-MsgGUID: KYBpG4nORk+uO6p9DdIFbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16826439"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16826439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:45:07 -0700
X-CSE-ConnectionGUID: sHmNrADzS769r/JDMtujsQ==
X-CSE-MsgGUID: M4uU9VOaQDatgexeqBJt1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="83460560"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 06:45:06 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v2 iwl-next 5/7] ice: Disable shared pin on E810 on setfunc
Date: Tue,  2 Jul 2024 15:41:34 +0200
Message-ID: <20240702134448.132374-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702134448.132374-9-karol.kolacinski@intel.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
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
index 82a198f28d3c..1594d10a0858 100644
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
2.45.2


