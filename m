Return-Path: <netdev+bounces-288416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK1KCR9lB2q90wIAu9opvQ
	(envelope-from <netdev+bounces-288416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:25:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8065556258
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C1463016D37
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C274F799E;
	Fri, 15 May 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/MVpfQc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F43FF1B5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869472; cv=none; b=EUPq6ybiHNSMR4mElfe9etRWtESGyBpNQLYXzMH4oqKYsTRkOzx97uMdCCYOHYWGD28ly3+45PyXxbK9t2vDJEJz49+cX2Qyt8MEh4gH8wRhJetutJwlGdXFY/ads8yE8LDVn4D4WXIU3fmvPV7yaY1FXEHEMgVaqlBtmrPOcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869472; c=relaxed/simple;
	bh=bIZS3XVYKtfTqMYiFPSUVZSQDveyIbEN5ZiO02Mt1OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHaynDMHsQyj+JT/9U34S1AKP7H0xw7zol4mNcvMVajLeZwXhQbtcTTSpB7Q2kFziDkqeC6NYc/Upf8g5QLHQ5BvqBvL/mrWBokGb9cGN1gIcWUMXyuSmBRkwNJ4aGVf/ZCAEaXRoTZEGRj3+ASPPqHiQpZDdztwyFxaqPztfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/MVpfQc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869471; x=1810405471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bIZS3XVYKtfTqMYiFPSUVZSQDveyIbEN5ZiO02Mt1OY=;
  b=R/MVpfQc5ZVv1BrmuMJ8rI0u2whgxkPuLHwrOEJQE27WskPx75D8I1UY
   s9uicUCQAi59T+pAuvWeA73OuRsQwaYP83vvkp9vKWN1fclxhoEAz6OR+
   TfbzdW+zq1JALe7LwB5uy92A1KM2IjOWigIZlnSI5eAPfImo/oJ4QvDac
   /9rJHWa/2Ymt8TR/sKDUGP5aej7g44I49IT/lYsZ+X2y5SwoMqJeph4Ba
   zCxphhyCxnf1YLqAaGY3cQWDKEt09wBHv27h5fBmlBQM5puRaN8Kb4viR
   PHfg2lCfau6rez9YpD7JKAXRZIx3csG1n3/DVsn3UHbvbrbCvRz2+IkSI
   Q==;
X-CSE-ConnectionGUID: HctYofKgSmWx+kcb0d4GuA==
X-CSE-MsgGUID: K+AKapysQOiqqLmPY5QVvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701154"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701154"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:27 -0700
X-CSE-ConnectionGUID: hCclpp14TbKXaBguhNNydw==
X-CSE-MsgGUID: h571s+yKRAqvHtLSojUhCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647448"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 05/10] ice: ptp: use primary NAC semaphore on E825
Date: Fri, 15 May 2026 11:24:12 -0700
Message-ID: <20260515182419.1597859-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
References: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8065556258
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288416-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

For E825 2xNAC configurations, PTP semaphore operations must hit the
primary NAC register block so both sides coordinate on the same lock.

Commit e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825
devices") updated other primary-only PTP register accesses to
use the primary NAC on non-primary functions, but left ice_ptp_lock()
and ice_ptp_unlock() operating on the local NAC. As a result, secondary
NAC PTP paths can take a different semaphore than the primary side.

Select the primary hardware in ice_ptp_lock() and ice_ptp_unlock() when
the current function is not primary, keeping semaphore operations
symmetric and consistent with the rest of the 2xNAC PTP register access
path.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8bb94e785f2a..2c18e16fe053 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5264,9 +5264,13 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
  */
 bool ice_ptp_lock(struct ice_hw *hw)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 hw_lock;
 	int i;
 
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 #define MAX_TRIES 15
 
 	for (i = 0; i < MAX_TRIES; i++) {
@@ -5293,6 +5297,11 @@ bool ice_ptp_lock(struct ice_hw *hw)
  */
 void ice_ptp_unlock(struct ice_hw *hw)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
 }
 
-- 
2.47.1


