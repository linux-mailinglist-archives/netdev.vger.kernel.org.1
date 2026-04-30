Return-Path: <netdev+bounces-282832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKfjI31K82ngzAEAu9opvQ
	(envelope-from <netdev+bounces-282832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7E4A2BFC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA154301E3C0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80326402BA7;
	Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCe9/GJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C6402B9D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551969; cv=none; b=bRQCyIf7Vu8RtVSRDi8LjETI1hykV2/T2GUdLfx9dPPKmF29GbpiVWiyhLK65WQAcK5hCQbeWFjUC2vfvA49zu4NR5Yg3uvMmgEu34ayD+UIRn1a9PJkDOCQJWOeLibn2tAIP5li835m8/3606KqLXY74G43TS016B288wqN6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551969; c=relaxed/simple;
	bh=WmUk/hzZFJcKObTRWjUXnGHFK9+dUHG3QByEE5jydN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avWLA5kq+GEG591VB1mbQnC/tgeBG7uKI+1Ui5XFfr/QpdrarwR1hs8dsdrbyT75ZN4YK3EDMO0ghHM1F/9U3J46MpL61uZWHnzvqbs93gQ0L5kitWEcYJFVJIgMUQ+5Ivg6xugGiCMHsxi19lAYKUqWnKAtuFYtXL+mvxsfyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCe9/GJJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777551968; x=1809087968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WmUk/hzZFJcKObTRWjUXnGHFK9+dUHG3QByEE5jydN8=;
  b=PCe9/GJJpZWaa9+ShBlk3xpBCGXvj73i6/pnu3bdNbawmxyaGU+XK+fz
   BzTHT2RvaJjFM6iplWaUalaVJmy3iJdeOwM41QiWSuZMCXp7EqimPJiGI
   xcfp9IxapYV/ft7Py20ivHgYxwKJz4mLyXAq3ZSQozRJVEzSbCdrh7jpd
   qaEaTMwpHJ7jWc3o/qHN0cUXjPXILaW2uMx31ZX49P5n1JasyHWtsSWZn
   KOVZrY/a988Lt4Z+Qj0SCaLz80HpSkd1ZYr52fFKw3rdkbWv/MpjQENTY
   rsSEnODJdv+99P+AxKPz2dItphaR+BeLIEqnG3ly6zw9dqClDQFHRUsqU
   A==;
X-CSE-ConnectionGUID: DyJBGtloRUOghMDwV/FpKw==
X-CSE-MsgGUID: QboQ6NGqQxCvBy+nAbXhsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689185"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78689185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:26:07 -0700
X-CSE-ConnectionGUID: MAPtY//6SAC9yo/g4nHqNA==
X-CSE-MsgGUID: KMYtALv/QB+btlJa445l+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233538429"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:06 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 2/5] ice: remove unnecessary PF_SB_REM_DEV_CTL write for E82X
Date: Thu, 30 Apr 2026 14:25:59 +0200
Message-ID: <20260430122602.126722-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18E7E4A2BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282832-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Karol Kolacinski <karol.kolacinski@intel.com>

Remove the PF_SB_REM_DEV_CTL register write from ice_ptp_init_phc_e82x().
PHY access is enabled by default on E82X devices and the driver does not
need to configure switch device access. The register write was a
remnant of an earlier SWITCH_MODE workaround for a FIFO issue and is
no longer needed.

Also update the kernel-doc comment to refer to the E82X family rather than
E822.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 61c0a0d..7b1b402 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2767,22 +2767,13 @@ static int ice_ptp_set_vernier_wl(struct ice_hw *hw)
 }
 
 /**
- * ice_ptp_init_phc_e82x - Perform E822 specific PHC initialization
+ * ice_ptp_init_phc_e82x - Perform E82X specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Perform PHC initialization steps specific to E822 devices.
+ * Perform PHC initialization steps specific to E82X devices.
  */
 static int ice_ptp_init_phc_e82x(struct ice_hw *hw)
 {
-	u32 val;
-
-	/* Enable reading switch and PHY registers over the sideband queue */
-#define PF_SB_REM_DEV_CTL_SWITCH_READ BIT(1)
-#define PF_SB_REM_DEV_CTL_PHY0 BIT(2)
-	val = rd32(hw, PF_SB_REM_DEV_CTL);
-	val |= (PF_SB_REM_DEV_CTL_SWITCH_READ | PF_SB_REM_DEV_CTL_PHY0);
-	wr32(hw, PF_SB_REM_DEV_CTL, val);
-
 	/* Set window length for all the ports */
 	return ice_ptp_set_vernier_wl(hw);
 }
-- 
2.52.0


