Return-Path: <netdev+bounces-286531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ph6NyKWAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9F50A3A3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3616A300C313
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DE3BF679;
	Mon, 11 May 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzRAX9Em"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B43BFE25
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488598; cv=none; b=pjJ5Nws410EF0HLrRx7tXcb/33jAB7R46Qs34nXSz3Queb3lw6j9z5rHCr8H0MFY+8Ac0T6JLMbuiBDN9KRz1Ng24x3uaIjA0biu2HIXIaBDaPsmJ6uyEwSolhG7nsWtRXLyCK8I5NN78kLrvloAR6YU4FHcPjVKw0yf+KLFAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488598; c=relaxed/simple;
	bh=r30RqNFozcTqFUhCYlFOyV9kPyO69Cj27zyVe/0S2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgBZ3cjc1u4oV2eklBgZnofxTEiYtt8N9cqQ9idcteNl5pu2fN22bHu7AJPOHaptpc58OA4tuFlDBjBL3h1zf+u9sM6er19jC9BCDZDHsuU/dwzeQAbcb7XcfR+YDwA/0LEZfrI25CVP+ZQzPNpIssqWF3mOHW9EtIkPIDXCHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzRAX9Em; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778488595; x=1810024595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r30RqNFozcTqFUhCYlFOyV9kPyO69Cj27zyVe/0S2ss=;
  b=FzRAX9Emc6JCZufwXG+tnI5yDyvhjVWvYuNzPQtJz/T8hGcNuFOuQuoL
   ZiaSMYTRaIoQMiWmwnm5k0tveLed5fX2VMw231nUULtho4gTADekE6jcM
   9H02cmW+T/qQX9PBhzGG3Ji2w63Mcx7kPeBGNspuIQAqqucwkJSXj9To3
   ZdkyWtaAc+z376Jm7moYfTpcU9Tx1LcmnJCOovANZbb1DdH1LJpwrfy3q
   Vf6bioGU7id/HBkv5IOKoDhTIvQe9WKuuHROzKVCrI7iTlNvISwlB+QTa
   oCviTWbAu+0iEUNNuglhJYlm7cOfon2FFxDodmkA1TBXbVKgbM9PYxVuC
   w==;
X-CSE-ConnectionGUID: 3/ECGCuyRhC6blsK6J+aHg==
X-CSE-MsgGUID: w4gvR02WQJGD3AgDWjUy5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="66901504"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="66901504"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:36:31 -0700
X-CSE-ConnectionGUID: G58sAqQ/TIaU7aX6ReWs+Q==
X-CSE-MsgGUID: 1r4oMGpwRQSkbcXe1Trmzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="231002893"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa009.fm.intel.com with ESMTP; 11 May 2026 01:36:28 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: suppress DPLL errors during reset recovery
Date: Mon, 11 May 2026 10:38:26 +0200
Message-ID: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69B9F50A3A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286531-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 0704e92ab043..78b8836b534b 100644
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
@@ -2883,10 +2883,12 @@ ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
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
@@ -2955,7 +2957,9 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
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

base-commit: 80b47e88f7ead00b0795e9f2833f1d0cafe11d90
prerequisite-patch-id: 45f595ded339d5f7feea2ea7ff196db3c08e3503
-- 
2.43.0


