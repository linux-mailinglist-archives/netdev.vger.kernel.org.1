Return-Path: <netdev+bounces-289912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBHtLGqkDWpM0wUAu9opvQ
	(envelope-from <netdev+bounces-289912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A671B58D516
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580CB3032583
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DC3D811E;
	Wed, 20 May 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPjcZYGW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0B3ACF01
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277810; cv=none; b=EPcJ1b5OaDWGxTG+Jz9gu886kBhKOVEeq4C01dlEhdt9TpvaoIKrlgWKc6noVc1epKSkQ0IAVayZ/kfGu96PQQC4Nlx0Z9Y5ygVV/wJ9OhjOeqwjiQ6pgaJFV0P8q2GeSHJk4PD1j+LHY67AsYfJdyrK3y0OFmwa62lEaH06fYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277810; c=relaxed/simple;
	bh=zPj1Z4TXNV7bjfsNs+8ZdzoNcOa6GBLLRh60fYgacQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVkhzpw6ud1U/S7N+e+xZAwk2XcK8cC9Cy8M+NNPgPHP1ibY06lZOjUVSIw6z8U2jU4OlwVY6vsyKpUYLh3riegZh2xE5Q+1Rt5GBji6noXbcyj7lILDitjtl59py6JsAvoaZ0RsjSoXI1tViTaMmZu2JVf7xwVfkHPtcsZgYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPjcZYGW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779277808; x=1810813808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zPj1Z4TXNV7bjfsNs+8ZdzoNcOa6GBLLRh60fYgacQQ=;
  b=YPjcZYGWd8j0M0VSLjQI6m0jlJKWfsHjX0msLRO9flh3YbMf9hMm7UQt
   THkUZCCvb7GADkcE5SlYwnGyVC0RfQwbiiUnuSMUET/VH7drrydNzq4Ep
   uixJi1gwMBC4OalloASsxy7xNIl9WzhK312QaMyrIu3Uff8ztCoHu38hb
   lT9aQGZqcN9p/QsZmr8ZTvEpnxI1Rk/C61zWp+c0nMAvo1mAbaF6p3YKR
   TFf3A+ZXpS6XOShq+llTFMy9RyuKzZ9CdHE07iSGolmO98y+GqgSY8qQR
   pn33TEHbb6kl00o1pN29kE+/uZACoV94qGRoUqe3r11DCK8QXIRG8PESd
   A==;
X-CSE-ConnectionGUID: 8gRMJC34Rwm7INQWnjkMNA==
X-CSE-MsgGUID: BQe/QFOjRP2Z/ucFPjKyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79320434"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="79320434"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:50:06 -0700
X-CSE-ConnectionGUID: D2eCtjfWQZqK2cv1F579lg==
X-CSE-MsgGUID: v2roAv3FR0mTP5wxyx0g+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="263948176"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2026 04:50:04 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	horms@kernel.org,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net v2] ice: suppress DPLL errors during reset recovery
Date: Wed, 20 May 2026 13:50:06 +0200
Message-ID: <20260520115213.10864-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289912-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: A671B58D516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During reset recovery, the admin queue returns EBUSY which is expected
behavior. However, the DPLL subsystem was logging these as errors and
incrementing the error counter, potentially leading to unnecessary
warnings and even disabling the DPLL periodic worker if the threshold
was reached.

Suppress error logging and error counter increments when the admin
queue returns EBUSY, as this is expected during reset recovery and
not a real failure condition.

test case:
- ethtool --reset eth3 irq-shared dma-shared filter-shared offload-shared
mac-shared phy-shared ram-shared
- observe if dmesg EBUSY errors are gone

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
v2:
add missing EBUSY check in ice_dpll_pps_update_phase_offsets()
v1:
https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-przemyslaw.korba@intel.com/T/#u
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 0704e92ab043..815792567a94 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -784,7 +784,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 				   ret,
 				   libie_aq_str(pf->hw.adminq.sq_last_status),
 				   pin_type_name[pin_type], pin->idx);
-	else
+	else if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
 		dev_err_ratelimited(ice_pf_to_dev(pf),
 				    "err:%d %s failed to update %s pin:%u\n",
 				    ret,
@@ -2821,7 +2821,8 @@ static int ice_dpll_pps_update_phase_offsets(struct ice_pf *pf,
 	*phase_offset_pins_updated = 0;
 	ret = ice_aq_get_cgu_input_pin_measure(&pf->hw, DPLL_TYPE_PPS, meas,
 					       ARRAY_SIZE(meas));
-	if (ret && pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_EAGAIN) {
+	if (ret && (pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_EAGAIN ||
+		    pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_EBUSY)) {
 		return 0;
 	} else if (ret) {
 		dev_err(ice_pf_to_dev(pf),
@@ -2883,10 +2884,12 @@ ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
 		d->dpll_idx, d->prev_input_idx, d->input_idx,
 		d->dpll_state, d->prev_dpll_state, d->mode);
 	if (ret) {
-		dev_err(ice_pf_to_dev(pf),
-			"update dpll=%d state failed, ret=%d %s\n",
-			d->dpll_idx, ret,
-			libie_aq_str(pf->hw.adminq.sq_last_status));
+		/* EBUSY is expected during reset recovery, don't log error */
+		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
+			dev_err(ice_pf_to_dev(pf),
+				"update dpll=%d state failed, ret=%d %s\n",
+				d->dpll_idx, ret,
+				libie_aq_str(pf->hw.adminq.sq_last_status));
 		return ret;
 	}
 	if (init) {
@@ -2955,7 +2958,9 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	    d->periodic_counter % dp->phase_offset_monitor_period == 0)
 		ret = ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);
 	if (ret) {
-		d->cgu_state_acq_err_num++;
+		/* EBUSY is expected during reset recovery */
+		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
+			d->cgu_state_acq_err_num++;
 		/* stop rescheduling this worker */
 		if (d->cgu_state_acq_err_num >
 		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {

base-commit: 7fd738d8cf34f46a7ec485426e2a5423ade8a63b
prerequisite-patch-id: 45f595ded339d5f7feea2ea7ff196db3c08e3503
-- 
2.43.0


