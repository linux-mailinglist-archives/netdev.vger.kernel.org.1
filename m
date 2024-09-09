Return-Path: <netdev+bounces-126698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C09723D8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBF6B22C56
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7818A940;
	Mon,  9 Sep 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7mfcWbb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1018B470
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914349; cv=none; b=XAg3BP1mOJyjeoq6EbzwDOeUH/z0UqwgyxKWy+dZ0R0YncHhwMfCN/m9NtAoJd/XQhRU5msOfacna3RlGhes6yVHQD5jpdrZkeh3LL30HYo8SNkLVE0aZphf0FXsJZb2Gfq+xVdHRrLWQi9CYhxke9PJFDbIAAk7Jws1lwFfu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914349; c=relaxed/simple;
	bh=x/qZRdIfOf+Q27rpWJRGHLZJxuyAjmLn0ITLU+YUE2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhqqaPZGkf4uZTHwWB0OLMyRStvz/o2CLWvDkZSubQ0igemoKnuAN38q/WTw/3kGrcDLjTlmWiTFrUAOD3TE21pAepWJ7of6yD1XMQhtkF0A1Ku9yhrU7iEsRlVkg/vsC2ne8Uuq+w/RFdyNzEOHGFckYD398Qudd1knexzflGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7mfcWbb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914347; x=1757450347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/qZRdIfOf+Q27rpWJRGHLZJxuyAjmLn0ITLU+YUE2I=;
  b=h7mfcWbbq9UrpjGXEqBczVbpyevW0IW38ayM6lPAL35faDT8g776hc2y
   YTgAxQu1iJ5xRw4S6BMomLJnJ5IDVpaZubLab9giztA/2sA22VfWwlVkX
   PDviVQNq04Ck8IJxUC4YurljrC+PbM1y//duDLkdmwHVsEOJ91RexgyG8
   hYo74ZFDgdjSyoIqa1c5kMq+iac0RLF1r20SA3tP2I9QaxESLQWxv7uUA
   DMRNMynUYoCE7k1E7q/yVdLxffKkKGY28V4tZbrUIga8GDj2f1POgyu+W
   9wf6MO/9BdPlUWoErKAPqk8qwlq7xVC3nSDH905OT6ZVBHJnI79a05DII
   w==;
X-CSE-ConnectionGUID: ss6v52pMQnmv1lrxoraW0g==
X-CSE-MsgGUID: 6J9b2g3URha6Nn5GztgB6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24787112"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24787112"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:39:01 -0700
X-CSE-ConnectionGUID: NZZ5NnffRV2M4DQ2iiLN5g==
X-CSE-MsgGUID: DTNamRvxTGyhlaoZsDHeXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054812"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 13:38:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/5] ice: fix accounting for filters shared by multiple VSIs
Date: Mon,  9 Sep 2024 13:38:38 -0700
Message-ID: <20240909203842.3109822-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
References: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

When adding a switch filter (such as a MAC or VLAN filter), it is expected
that the driver will detect the case where the filter already exists, and
return -EEXIST. This is used by calling code such as ice_vc_add_mac_addr,
and ice_vsi_add_vlan to avoid incrementing the accounting fields such as
vsi->num_vlan or vf->num_mac.

This logic works correctly for the case where only a single VSI has added a
given switch filter.

When a second VSI adds the same switch filter, the driver converts the
existing filter from an ICE_FWD_TO_VSI filter into an ICE_FWD_TO_VSI_LIST
filter. This saves switch resources, by ensuring that multiple VSIs can
re-use the same filter.

The ice_add_update_vsi_list() function is responsible for doing this
conversion. When first converting a filter from the FWD_TO_VSI into
FWD_TO_VSI_LIST, it checks if the VSI being added is the same as the
existing rule's VSI. In such a case it returns -EEXIST.

However, when the switch rule has already been converted to a
FWD_TO_VSI_LIST, the logic is different. Adding a new VSI in this case just
requires extending the VSI list entry. The logic for checking if the rule
already exists in this case returns 0 instead of -EEXIST.

This breaks the accounting logic mentioned above, so the counters for how
many MAC and VLAN filters exist for a given VF or VSI no longer accurately
reflect the actual count. This breaks other code which relies on these
counts.

In typical usage this primarily affects such filters generally shared by
multiple VSIs such as VLAN 0, or broadcast and multicast MAC addresses.

Fix this by correctly reporting -EEXIST in the case of adding the same VSI
to a switch rule already converted to ICE_FWD_TO_VSI_LIST.

Fixes: 9daf8208dd4d ("ice: Add support for switch filter programming")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index fe8847184cb1..0160f0bae8d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3194,7 +3194,7 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 
 		/* A rule already exists with the new VSI being added */
 		if (test_bit(vsi_handle, m_entry->vsi_list_info->vsi_map))
-			return 0;
+			return -EEXIST;
 
 		/* Update the previously created VSI list set with
 		 * the new VSI ID passed in
-- 
2.42.0


