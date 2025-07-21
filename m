Return-Path: <netdev+bounces-208663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B0B0C9CA
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458036C1250
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7AD2E1C57;
	Mon, 21 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5NbtiFH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF32E1741
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119464; cv=none; b=ixILBgF1/6GM/6vNun0Qvs0qu3mjAxVHVJ9R6EML2lonlUmgnWN4ewayIuqCmzVvjC1z6GoEqsYjfsMXVPy8+mqCYvqSFQ7y3oa1m0nKEEuH+nnO6n5PHH/b51mJ/EtgtvvfY/oIrcR1qWq5ZFWQUdCIuOcKfCC3sI24NiSFal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119464; c=relaxed/simple;
	bh=w+GfFB+FWnl4jBy7CaBWZcl9Wva7AXvzI8nbRMt66OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHKZDxnpfm12Qp3VKBJrKcGVsX5DQvi/M7+rEzY4zmWeBEihIcLKZvVdVCsfQD1kJm9yDvVi1XMYiXyseo5jBH4pCnzWkDLwWD7cxZ0Kj1Uel51qlfnrJ8/CtdUPe9aaZB7ugamJg2cL3mBv8xHWSoO/LwwPKOD0xy01u/M/1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5NbtiFH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119463; x=1784655463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+GfFB+FWnl4jBy7CaBWZcl9Wva7AXvzI8nbRMt66OI=;
  b=a5NbtiFHn7h73JIQbu3ABGlrepkAmZVrT9nSmkSe4+1aylOhxzh8EVYJ
   hRe4fN1IJFTYgNVDzlVJcnBrArRM5sH+om1+dywsWQNwQuErFhf1pSPlb
   sNwT65UXgbtDe1vzloIW9Zx1TRCGpVySA1PwDfs+jLGrL3adtMzOyVOIv
   vXLj7+foEzsEKLY4zVscL7lizEcj0l54fJJMASDwJITRa0lzu9irCwHDm
   GitvmF6RR0PGaZOWj+YHWZndrITE3Wl67mgTlfPqykCI3SUP5QfZmm84l
   re1chclWGyd0zISt/TtNKUXGb4UWXqxUQyrt586e4QrCsfGU6l70Df+wU
   g==;
X-CSE-ConnectionGUID: vtgdpfqeReqoGgF0DOA5nA==
X-CSE-MsgGUID: D/3JxIcoSemTC6SFYOZPaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55193182"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55193182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:37:41 -0700
X-CSE-ConnectionGUID: 5fMmi1HSSFSnJRUdQyG8zQ==
X-CSE-MsgGUID: OyhYoVPURTyi+tXyO6aWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158231563"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 10:37:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	anthony.l.nguyen@intel.com,
	mschmidt@redhat.com,
	brett.creeley@amd.com,
	ivecera@redhat.com,
	horms@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/5] i40e: When removing VF MAC filters, only check PF-set MAC
Date: Mon, 21 Jul 2025 10:37:23 -0700
Message-ID: <20250721173733.2248057-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
References: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jamie Bainbridge <jamie.bainbridge@gmail.com>

When the PF is processing an Admin Queue message to delete a VF's MACs
from the MAC filter, we currently check if the PF set the MAC and if
the VF is trusted.

This results in undesirable behaviour, where if a trusted VF with a
PF-set MAC sets itself down (which sends an AQ message to delete the
VF's MAC filters) then the VF MAC is erased from the interface.

This results in the VF losing its PF-set MAC which should not happen.

There is no need to check for trust at all, because an untrusted VF
cannot change its own MAC. The only check needed is whether the PF set
the MAC. If the PF set the MAC, then don't erase the MAC on link-down.

Resolve this by changing the deletion check only for PF-set MAC.

(the out-of-tree driver has also intentionally removed the check for VF
trust here with OOT driver version 2.26.8, this changes the Linux kernel
driver behaviour and comment to match the OOT driver behaviour)

Fixes: ea2a1cfc3b201 ("i40e: Fix VF MAC filter removal")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2dbe38eb9494..7ccfc1191ae5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3137,10 +3137,10 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		const u8 *addr = al->list[i].addr;
 
 		/* Allow to delete VF primary MAC only if it was not set
-		 * administratively by PF or if VF is trusted.
+		 * administratively by PF.
 		 */
 		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
-			if (i40e_can_vf_change_mac(vf))
+			if (!vf->pf_set_mac)
 				was_unimac_deleted = true;
 			else
 				continue;
-- 
2.47.1


