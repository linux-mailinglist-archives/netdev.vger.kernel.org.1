Return-Path: <netdev+bounces-108431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3083923C44
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37C81C22149
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACA15B13B;
	Tue,  2 Jul 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsyV/gON"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496A15B122
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919110; cv=none; b=q9uOcvPzbH5eFiO3k8Jsn6ivPMxK1Fb6RxaT1flX6DIbezkZ/eCSndMnYq2V2wTfEzVD2cswQtg048S9ySS15jGbR9ztSUxr0+9jt/yzGsQObZL/vv8yzEGo7uigBnS5ZwI+vdbo6mtI+y3awpQYuZfYst9q6Odv5oMKhxwNFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919110; c=relaxed/simple;
	bh=aFkWVFydsAlxeC8n6298/kG3CWBvKp5eWmqUjVGjlao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZF2MEoOshLls5SdBahbswJnoE1C+DHOGKUijWbhoMCqYdGjjLpX6DUpN5USrmDtWW/HIGvnJ7q4LUtCse/Im4leWx3silk+xOe6Mc1VfcV7obX31lpgYX8K2CP9GzhkXr/kjrjy3NUqfeMnTsBrf4cqXHnxrK2iUNPOn4vwjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsyV/gON; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719919110; x=1751455110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aFkWVFydsAlxeC8n6298/kG3CWBvKp5eWmqUjVGjlao=;
  b=HsyV/gONOETGsFCWZcsyptXHrQy37teYC+1lhCGsUxgXmdNSm4csKh+6
   Yypasxv3KhkcbeAtTOTwadKPqME5xBjg55b7VnLeN4JxuilPa0jD6bllH
   2IuO09e4pMfDC2dzn+plvfVv+WxYM3FQTXifKDtRa2ARQBi36j7EN9Jl6
   z4niqrvU60n67v9TBas6FRmb7ODeMMxrRNtV1xKB41Xe6mFSgq71CFch8
   uu8w2vcq2xLkPPqJ3B4PMPV1PfDZAEuZHsKX8EYCei2PVkDAWjTZvXNI/
   YYv0kFO97ExmZrjuNsjzJgUgpTWb7Jgd1yNsLK3afW8zeuMhPHEV4pnlh
   w==;
X-CSE-ConnectionGUID: HLuDQQ2tT2m1Quj7k7wmUw==
X-CSE-MsgGUID: lhbhw7dAS4e8Z/CU+4VcZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28482090"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28482090"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 04:18:29 -0700
X-CSE-ConnectionGUID: aKo4bRzOTqS9bkDgVTV35Q==
X-CSE-MsgGUID: X9r2oimQTqmpJjILJ+wdxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46006203"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2024 04:18:27 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-net 2/3] ice: Don't process extts if PTP is disabled
Date: Tue,  2 Jul 2024 13:13:20 +0200
Message-ID: <20240702111807.87802-3-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702111807.87802-1-karol.kolacinski@intel.com>
References: <20240702111807.87802-1-karol.kolacinski@intel.com>
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
2.45.2


