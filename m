Return-Path: <netdev+bounces-280407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPkOLePB6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A11446138
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E96BD30598C5
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF793DCD9F;
	Wed, 22 Apr 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtRsKYsH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5F3DC4C7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861357; cv=none; b=Vc1M1in8+0DsTe7ZsgBXYw/QaamWyKiXhW2TKk3p13fZhQxah6Ps5SAcHy5cMwW/JC06Yj+RkbFwX+6WQs7atLmj4/3TRNmZ/73PqYgVGQ/uqaOFFwAIbwnyTktPIrIs9GtSa7r+i0nrhcJbDoJOPFpFk1L4G4d6gCEfCA4wGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861357; c=relaxed/simple;
	bh=wDLA3/GJGEO1IbM955Q5FElcfpvCOUEomPnwlKEBe7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nq0RWKLevBUBbRQx827DfPAhw0NuS5dpxo95ax62KL8vlvE2yw/W/v0oJiHUdeNcwO5FNGExx8Sl5tA7m+VvUlOkwUYegP/Al1rutE7JeQrnLqZ5C9YaS3By49fVRN1sXzi/SlwLLmi+DaS8zbMKPRt7XllXPzdyTvbmPpOEiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtRsKYsH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776861354; x=1808397354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDLA3/GJGEO1IbM955Q5FElcfpvCOUEomPnwlKEBe7g=;
  b=XtRsKYsHLMMIOvBawBL7pVE0F3l7lPgw1J3Dd4mnjYZWONW7GkpKKe5Y
   /csQC2k2c2xQ7u1qLX5tshUe24HDkDEjcV/wn0azWzm400gLPEXymVQwY
   9li/0BgpcfDCQn7GQ2VsXQjt7LYDc2ywQ2Gh1nE7xLN3uJ5CgRqFNOica
   C6rrEcQFJ5ChTgCk3XF0GKnO0Nl90dXGU2+9SNgpo6vYDkNUyXCrYCi+T
   lET8sjunlJYCVxK7xd6vdikoRkPvISRABiun18orZ1zkKwuMxnaGm/rZJ
   UJR1S4MZWkEpT6aeO0L+y4MDQLAMGcRzV5pKPROGv60JPqpDar8Iz97lo
   A==;
X-CSE-ConnectionGUID: 2S1JhPu4TPm1/ZEqjjsBeg==
X-CSE-MsgGUID: 7l5HGe8ASBuZ7DcXmGh2rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77826165"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77826165"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:35:54 -0700
X-CSE-ConnectionGUID: jnPp+D69RzWk8HTMMSZLhg==
X-CSE-MsgGUID: SIJp+xLLQbOKFjQTNtXCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229167437"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa007.fm.intel.com with ESMTP; 22 Apr 2026 05:35:52 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net 2/2] ice: ptp: use primary NAC semaphore on E825
Date: Wed, 22 Apr 2026 14:31:44 +0200
Message-Id: <20260422123144.485930-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260422123144.485930-1-grzegorz.nitka@intel.com>
References: <20260422123144.485930-1-grzegorz.nitka@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280407-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 31A11446138
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.39.3


