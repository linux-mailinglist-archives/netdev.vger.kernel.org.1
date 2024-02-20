Return-Path: <netdev+bounces-73444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EB85CA2A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56AE1F23006
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F1152E05;
	Tue, 20 Feb 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFI2yPwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A84152DE5
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465498; cv=none; b=gZmhZzRL89b771pKRMH4MdphVDHTISaZCCiwPNu9j6rW2Y/IQ0YAzPmrw7sWwHx//YsozTrwRLl7ed4llzafJIpEXoe/uslF5QGQaTj5GstinApqTbXXEwgNxszn7GJ2nB4zsM+tD9ImUOVUjskf3ncwsNHUNn3b+Nnjxg9kCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465498; c=relaxed/simple;
	bh=VN+Z5lLAyKA22kcJZ/2Sdg7+GGqhFPWHckRSVhc4txQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF9/vmKZqo412mBm6mXgwq0tzt3Zv/BdZHSfZSvgPod8bul5IqJHHO4z0Iwm/2wL2kcRqTqch51TtHb0g81lJq71gibAFgQs9LUOcIzlBrgpGablZvZ1h5dZ844EIO4vgRabDVsGC9rH0iepblKbo2TCQFN9IuPnyXPNsY3+5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFI2yPwu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465497; x=1740001497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VN+Z5lLAyKA22kcJZ/2Sdg7+GGqhFPWHckRSVhc4txQ=;
  b=SFI2yPwuTyBzLGCL0h+eWgwmtbK/cOEDs6PibXnQLCW7Hq1xsdU7sPO3
   68AiXXzAV0yDwv8AO6ZAPa+GctxEQ8TnW2QMocnttJakxPItdZRRYtAtb
   bmA7GAGL/iETQi375FT3TxPUvLxeQwhZnMElGuDhlwmFv+031MYjTUL8y
   nMoenLQO+ESLskY4XAVPnnhaxlOByKMJH8IOEOF2a9lF0o17QKBs1Az3V
   isDUMTG78Op4RBreg1T4pbovr0OzuEk+aVK4cB7kG8GoHKCm+rsVoIwrs
   1b5s2PaB8o0uuoYHbULy1OrwNUtAJ+81rGwxWzgUx4js06NL0yYN3nup1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472725"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472725"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614939"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/6] ice: fix dpll and dpll_pin data access on PF reset
Date: Tue, 20 Feb 2024 13:44:39 -0800
Message-ID: <20240220214444.1039759-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Do not allow to acquire data or alter configuration of dpll and pins
through firmware if PF reset is in progress, this would cause confusing
netlink extack errors as the firmware cannot respond or process the
request properly during the reset time.

Return (-EBUSY) and extack error for the user who tries access/modify
the config of dpll/pin through firmware during the reset time.

The PF reset and kernel access to dpll data are both asynchronous. It is
not possible to guard all the possible reset paths with any determinictic
approach. I.e., it is possible that reset starts after reset check is
performed (or if the reset would be checked after mutex is locked), but at
the same time it is not possible to wait for dpll mutex unlock in the
reset flow.
This is best effort solution to at least give a clue to the user
what is happening in most of the cases, knowing that there are possible
race conditions where the user could see a different error received
from firmware due to reset unexpectedly starting.

Test by looping execution of below steps until netlink error appears:
- perform PF reset
$ echo 1 > /sys/class/net/<ice PF>/device/reset
- i.e. try to alter/read dpll/pin config:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
	--dump pin-get

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 2beaeb9c336d..343b2a668959 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -30,6 +30,26 @@ static const char * const pin_type_name[] = {
 	[ICE_DPLL_PIN_TYPE_RCLK_INPUT] = "rclk-input",
 };
 
+/**
+ * ice_dpll_is_reset - check if reset is in progress
+ * @pf: private board structure
+ * @extack: error reporting
+ *
+ * If reset is in progress, fill extack with error.
+ *
+ * Return:
+ * * false - no reset in progress
+ * * true - reset in progress
+ */
+static bool ice_dpll_is_reset(struct ice_pf *pf, struct netlink_ext_ack *extack)
+{
+	if (ice_is_reset_in_progress(pf->state)) {
+		NL_SET_ERR_MSG(extack, "PF reset in progress");
+		return true;
+	}
+	return false;
+}
+
 /**
  * ice_dpll_pin_freq_set - set pin's frequency
  * @pf: private board structure
@@ -109,6 +129,9 @@ ice_dpll_frequency_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_pin_freq_set(pf, p, pin_type, frequency, extack);
 	mutex_unlock(&pf->dplls.lock);
@@ -584,6 +607,9 @@ ice_dpll_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	if (enable)
 		ret = ice_dpll_pin_enable(&pf->hw, p, d->dpll_idx, pin_type,
@@ -687,6 +713,9 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
 	if (ret)
@@ -811,6 +840,9 @@ ice_dpll_input_prio_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_hw_input_prio_set(pf, d, p, prio, extack);
 	mutex_unlock(&pf->dplls.lock);
@@ -1090,6 +1122,9 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 	int ret = -EINVAL;
 	u32 hw_idx;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	hw_idx = parent->idx - pf->dplls.base_rclk_idx;
 	if (hw_idx >= pf->dplls.num_inputs)
@@ -1144,6 +1179,9 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	int ret = -EINVAL;
 	u32 hw_idx;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	hw_idx = parent->idx - pf->dplls.base_rclk_idx;
 	if (hw_idx >= pf->dplls.num_inputs)
-- 
2.41.0


