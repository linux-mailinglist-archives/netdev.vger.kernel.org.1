Return-Path: <netdev+bounces-131032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2E98C69F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C42847CE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F141CEE83;
	Tue,  1 Oct 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4A7ARtL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621C1CEAB7
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813839; cv=none; b=rB8mt+PjgTWE4s24iLeMzdPqCeyf9KsMH2acM/XUMrSx/nytQkQLQiCbOw7FJbkembYmjlmzUckrptaoDNuXZzq8Ysc42lNkhXhP3gCDf8Q0bT3U6y+iLfiBxZ9Ymmq8IpdQp50Y4J4eIU1rkKAByAGMj0QasLwzKHUTTtK0hSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813839; c=relaxed/simple;
	bh=kkqlP3bl8iuRT0gDPwh+oXldNHnVf0j4CvndqY5kxJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkA1A8dOw8nU1Nbb0JC3fUmESbb14+XCsttb+lRZLx4CY6uupsazjZLjzL63fRn45MmLMohmN6xEn1BtB6CJrHNjmCluDrGsM+b4nJEWVDLtRoGaKOroLrOraM8hRbJBnxJzkakRVeQQUu+2dRfAWsjKt7aBrkjgcuQqOfOPTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4A7ARtL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813837; x=1759349837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkqlP3bl8iuRT0gDPwh+oXldNHnVf0j4CvndqY5kxJ8=;
  b=S4A7ARtL1hBYKVpjwFTXuclU+zKXUAproXSjQaKeLC/7P2kYjTeKLLhd
   AqKiOV22l3GUvG6PmFhHaVTSy5R5W1fKDpUZuRsxZYA90v3uco9aFbDjo
   wYdVx2n57yNi7dYDPgbQ4w4sG73yOkvqFu3KSlIirdS6d2pynIII3lb/f
   ylNS1hFUYgdX+X+0gaE39eAMhqUkdZih6qvACoziazOVfp/a7Z3hD5kLJ
   u7vU7y69GeFwBwBtPA2tXls4+4m7up4WQ7BwQSblcj6ittNjSx/EtBDXf
   7ofa6HRFD5R4hOFfKyrEBoCjvGfGmLt7pT6hXJYeyvxe5jzx1RaWz3kYM
   Q==;
X-CSE-ConnectionGUID: URxGRQARTIS7CYj4g+xfjg==
X-CSE-MsgGUID: i7FlfPmmR+WSsoj/S69sJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27063081"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27063081"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:17:14 -0700
X-CSE-ConnectionGUID: ZlRVuU/iSCyvwEY2ZD1CoQ==
X-CSE-MsgGUID: AhPz8NCZQdiNYSA2qqnkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73761858"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 13:17:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 05/12] ice: Disable shared pin on E810 on setfunc
Date: Tue,  1 Oct 2024 13:16:52 -0700
Message-ID: <20241001201702.3252954-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
References: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

When setting a new supported function for a pin on E810, disable other
enabled pin that shares the same GPIO.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4d6f7efe18da..f733e673bf26 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1838,6 +1838,63 @@ static void ice_ptp_enable_all_perout(struct ice_pf *pf)
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
+	unsigned int gpio_pin;
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
+	for (unsigned int i = 0; i < pf->ptp.info.n_pins; i++) {
+		struct ptp_pin_desc *pin_desc = &pf->ptp.pin_desc[i];
+		unsigned int chan = pin_desc->chan;
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
@@ -1872,6 +1929,14 @@ static int ice_verify_pin(struct ptp_clock_info *info, unsigned int pin,
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
2.42.0


