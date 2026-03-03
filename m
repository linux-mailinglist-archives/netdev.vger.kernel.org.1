Return-Path: <netdev+bounces-263457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ExpUCMdqp2mWhQAAu9opvQ
	(envelope-from <netdev+bounces-263457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:12:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6071F8473
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D910303AE66
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08639185F;
	Tue,  3 Mar 2026 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvMksDlS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D63932FD
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579522; cv=none; b=oarboKuBXB4P/RF4u51s34mU8gc+FDsykZmDqft8T1Ug5PaooMMtHZep/hq5JR/WwiAkVng+//ngbmVJgUv93bX8tWtM9hTsiwarofBPPQXRZ/ffahf3cKvxTO4ADy8bC2vlZ0ZBooJsdpltG0kfKydtesxRgKlLPH4Gqu9G82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579522; c=relaxed/simple;
	bh=iXA5oGXc/zYj9mOtlwqVvYFTCXZ3t4pHavmfO5nNuEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1Y5+5Q+mXWMI5yINUImnTyzOFhIkcJ7TF7fVZsHrlDa5oYC0LvUlq+sU0KP3OlPYal9mhwD3hnRdoV4BPFthjK0NPVKqjOD9ZcjToSvD3pbFtRpy0vY08fLwAdf5ga1pacy6xwtw1UJLYdW8oFl+wkAIq7NLAeDFTg5u+9kpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvMksDlS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579520; x=1804115520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXA5oGXc/zYj9mOtlwqVvYFTCXZ3t4pHavmfO5nNuEQ=;
  b=EvMksDlSaDFqvuLHcha5irU6q3lujovFE6xDTaIDqLhIXNya3pBT3S2O
   MKdex2T1At58oW3Zf1gLv3wL/c6Qm9q1qcK4bu6JUFqvhAyLiRwNMKVjL
   JY4nNhnptAltUas8suh0zp2gn5BPHjSJJ8VrBDyhVFv95Q3g7jPQkkO2P
   ZNKUsiunktdiQL4ZwMLE2T7iUaJG9owOHFNFqQUnbCHx0N+rliU0OZdFj
   wyPiNMLw+SiGPiWGnmD51Ha8SOgiz85vpkfu2Z6BXKmgb4quHcB4e42k5
   4JpbE+0NOjY3EpXCe89qE/v0FAyuA4ArmQvbw/LQgf0AaHjUkjwFxbkpi
   A==;
X-CSE-ConnectionGUID: nsJ3E3mwRxmvPTQyQf6BIw==
X-CSE-MsgGUID: WVtt5O6KQR26Knxy4zc1PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238789"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:58 -0800
X-CSE-ConnectionGUID: HSoX9SKrRG+ts85SLh5efA==
X-CSE-MsgGUID: AVEpCak3SlG1sN0L/mFk8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633796"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:11:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/8] ice: fix adding AQ LLDP filter for VF
Date: Tue,  3 Mar 2026 15:11:47 -0800
Message-ID: <20260303231155.2895065-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E6071F8473
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-263457-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Larysa Zaremba <larysa.zaremba@intel.com>

The referenced commit came from a misunderstanding of the FW LLDP filter
AQ (Admin Queue) command due to the error in the internal documentation.
Contrary to the assumptions in the original commit, VFs can be added and
deleted from this filter without any problems. Introduced dev_info message
proved to be useful, so reverting the whole commit does not make sense.

Without this fix, trusted VFs do not receive LLDP traffic, if there is an
AQ LLDP filter on PF. When trusted VF attempts to add an LLDP multicast
MAC address, the following message can be seen in dmesg on host:

ice 0000:33:00.0: Failed to add Rx LLDP rule on VSI 20 error: -95

Revert checking VSI type when adding LLDP filter through AQ.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6cd63190f55d..74fe74225277 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6391,7 +6391,7 @@ int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add)
 	struct ice_aqc_lldp_filter_ctrl *cmd;
 	struct libie_aq_desc desc;
 
-	if (vsi->type != ICE_VSI_PF || !ice_fw_supports_lldp_fltr_ctrl(hw))
+	if (!ice_fw_supports_lldp_fltr_ctrl(hw))
 		return -EOPNOTSUPP;
 
 	cmd = libie_aq_raw(&desc);
-- 
2.47.1


