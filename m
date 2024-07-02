Return-Path: <netdev+bounces-108563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765C9244CE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD9BB25DFA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695841BE85D;
	Tue,  2 Jul 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxmHiI7e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE131BE241
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940507; cv=none; b=T28MwLM321gX8aiiOhCXNrzNDLqQPa5Ga+BADWpmcitOMHnVzHEPgvDyC0imAIb1RJRJImWctWtRln9GOvfXavyrdaR78T/7ErRq1mjxe0NgFIcXoBQX8I+q3t3Izn0Hg1EVOnvm6mBWAFBnGP4rcOkZCgroOr9q61u9Bt7zIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940507; c=relaxed/simple;
	bh=1Rt6OtQXismlIOnE2IE20ILNbRzP28fyMN40MkS4IGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvJ8xwH20lW0R8OThQTIrsnDFqAAmyje1PN2DTK8v7xDRK6D4faf7AmgDHuwy9L5z1pcwIMHPZH9A4HOLnvNuE8a5ZRNO/f9xoBCIkFNtmZwKltqyGq9EdlMxjI4dKkbPDBE8LHj+6NxV+RyP8M9ZFD3LkSrfjjqQkSCSOxZBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxmHiI7e; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719940506; x=1751476506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Rt6OtQXismlIOnE2IE20ILNbRzP28fyMN40MkS4IGg=;
  b=bxmHiI7efHWb4cLfbyzsXFs5n/tifLLN0ZlqO42/sx7TGMai+7EmZJBF
   Gf5sofy/3QF99zLhX/vnaS7mm5BMWmWv3S2BBU97x8yoCSannboF8fWrg
   8YVbuX2nFxkZ/rFGPQys3BYNLmDVy4SdkSfZvgkZRaoOmqDdExO1qzP0s
   99OiwGim4AHXKDHh2j+2iIxzApWSLY2DbND9thwl8QNJ2pzSg/5yH0Hya
   1Px/ru7SOA7Mw03PErUb+CiIGmEaxz8cnwPFBLQD45sOaTEu3qUdkLUjv
   QsH3PC9CctXev5dJMkZ7ACL/2V3+errUTDMnJJhXNn7Dx2bluPn5MRUo1
   g==;
X-CSE-ConnectionGUID: 4FQgcTJrQIykOhz/oSb6fQ==
X-CSE-MsgGUID: uhh0f/pKSA6bFTowyEiFaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20032330"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20032330"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:15:03 -0700
X-CSE-ConnectionGUID: T7aOkldLTluv+ZJVD1dyqw==
X-CSE-MsgGUID: CFRvy5qBRWCJkPIA1yG+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76708753"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 10:15:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2 2/4] ice: Don't process extts if PTP is disabled
Date: Tue,  2 Jul 2024 10:14:55 -0700
Message-ID: <20240702171459.2606611-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4d6555fadd83..9fef240bf68d 100644
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
2.41.0


