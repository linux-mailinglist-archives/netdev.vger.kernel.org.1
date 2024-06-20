Return-Path: <netdev+bounces-105256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3331910442
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D55CB23C0C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B391AD400;
	Thu, 20 Jun 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdA5MB2C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443881AD3F2
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886723; cv=none; b=JJ70Xk/27RqJcrQA9xdzDp3EbbhPtPbiL7mjgkSaxkxcD5qd7gHLQokO3pNt3jgu5D7KhvXhbdTitwlMpEjC0vv8ug6aWT03Lsj65Bz3mSsh0IYlMfVjx/+7J2VKmvixvCI5hdlGifWC7XChSCjFgSSuTCPgkZW+IjCBYOJXcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886723; c=relaxed/simple;
	bh=PMLnNOEM3hY2pdDZ57EQrF3YgMbUMNWJSiQ68f2BKxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzb1XGwZUWqy9GLTPelc0jkPXDUkMOFvjCizN0jeOB8N8z5sxwsfdr/yIW6APW1gKnOqI292iZ3Fam75XXLIEHHPvSYvhBxvsID4hDRUBtZdbx5pjWR4izX50TDNyUCakysEW9BNz2zAUo2I27AhYOa15B0LH4OR3G+2nryPuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdA5MB2C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718886721; x=1750422721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMLnNOEM3hY2pdDZ57EQrF3YgMbUMNWJSiQ68f2BKxo=;
  b=OdA5MB2CZEdlHMC1WDbH0Qii/7dIK5x5RAsO7boxhzEbLfM2Iup6+mn/
   adlc5qpaiR+JtUaRFt/I38wnP/+oL4K3LeLNWU+qrD87OM1vL34Bv/Rnq
   BNilZDceGViPNVfk79nhm8YFq7GbI9xGLydHgEIkc60ltsPmx9wuBPKBR
   CY0+4nt3ML4Neam4IySMEY7zbad9UaXIJNd8rq84ETCK0k0Atb4aurnjO
   zEPoX0iM8G3EyUHZtUo/hhckgA9ecg2APBDrxrBwgG7HbTHgTzWKGyuRH
   x1FBS4qLUWTlIpdm/s58sx6vDgqXUr416JSe473yYgFR1NHoYTpxRvbHO
   w==;
X-CSE-ConnectionGUID: lH22QWViTMiR0v4N9HNB8Q==
X-CSE-MsgGUID: a0xI3Jx5QJWlgF+Qmi3Qgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41262889"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="41262889"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:32:01 -0700
X-CSE-ConnectionGUID: WwrAAiU+Sn6erMW+RB5PHA==
X-CSE-MsgGUID: Kf4xHDCCS0qOJqkYll4eQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="79712953"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 20 Jun 2024 05:31:59 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-net 2/3] ice: Don't process extts if PTP is disabled
Date: Thu, 20 Jun 2024 14:27:09 +0200
Message-ID: <20240620123141.1582255-3-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620123141.1582255-1-karol.kolacinski@intel.com>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_extts_event() function can race with ice_ptp_release() and
result in a NULL pointer dereference which leads to a kernel panic.

Panic occurs because the ice_ptp_extts_event() function calls
ptp_clock_event() with a NULL pointer. The ice driver has already
released the PTP clock by the time the interrupt for the next external
timestamp event occurs.

To fix this, modify the ice_ptp_extts_event() function to check the
PTP state and bail early if PTP is not ready.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: removed unnecessary hunk of code and adjusted commit message

 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d8ff9f26010c..0500ced1adf8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 	u8 chan, tmr_idx;
 	u32 hi, lo;
 
+	/* Don't process timestamp events if PTP is not ready */
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	/* Event time is captured by one of the two matched registers
 	 *      GLTSYN_EVNT_L: 32 LSB of sampled time event
-- 
2.43.0


