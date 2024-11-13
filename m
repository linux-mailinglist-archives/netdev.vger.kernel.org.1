Return-Path: <netdev+bounces-144548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BA9C7BB1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA41F2170F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6420697D;
	Wed, 13 Nov 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VATervlm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF12064E3
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524085; cv=none; b=FqZEgWaUFLX3IYnQggyZ1AViOewdN0t3YpR7tMMN2IA3Xwl8hszGZuVQATYX7D13O1unnEZywhftZDYjWKYYeJ+UtJ1dGkuBP2dTRHSb5wY/ewzt0byrHQUDNO4gqdIidwYaSvgMUaeqOi9GDE3jBPFwu5ynH2V9ZZ2vByYUiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524085; c=relaxed/simple;
	bh=L9EaD1mXSy6ejHghcmSLw+ooOGvXJHcTlnffJFTLCWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+NLBPIyRNj/i0+HrYwQW9MKVuWIQpXDjNgqRPv9VhlxaI+C8MmHMbe1tt5u4fclCRqL5lr7yrDJynLgEigbOz53/7WsL8RbXV6eqi9i/dmT3Fb3mPB+LJfJ4Hc3if7pqK1NXSWtUczPGWa9/rHxbg3CD9v8M1oYn5g1k0bPLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VATervlm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524084; x=1763060084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9EaD1mXSy6ejHghcmSLw+ooOGvXJHcTlnffJFTLCWk=;
  b=VATervlmHWXNfSCMnjY8HN6eNL6ax6xPfyd7gjFfgjgDziWIi4rBklSh
   0hsXTOjBMdUAyu35GFXWTrwUDbzNC7mCePPRlLvFEmHkkgVD4MMK8Zn1B
   Dztw6VfrXi8IJg+xkS+gOqsQeyY58ajuDm+sDrRtkteSjolCrVxRtowoo
   Nsplm03c0n/uZxanz241dwV20v0TXjnL1AfS2fzg36Y1Eywz4+wBLzzMw
   bnlDMp5vPVlTTCNscHHIOaITzVorvzs4BLMRGrQbEeKIICjjFpZWVFJ7/
   OooRa/JP7MqkL1tzVQ6nKpnyLiyjSqxV/h154rT/wcsJ4naXLEDiC0jea
   A==;
X-CSE-ConnectionGUID: /63hzUr1SSCFQSSWmaBQ9Q==
X-CSE-MsgGUID: 9InvCoJ9Qi+2oF+V9y4OrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589515"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589515"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:41 -0800
X-CSE-ConnectionGUID: H2XUwxh9RFe/Vctjk772kA==
X-CSE-MsgGUID: q7hdJaj+QUKU/8wxcOpVSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520747"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 08/14] ice: use stack variable for virtchnl_supported_rxdids
Date: Wed, 13 Nov 2024 10:54:23 -0800
Message-ID: <20241113185431.1289708-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_vc_query_rxdid() function allocates memory to store the
virtchnl_supported_rxdids structure used to communicate the bitmap of
supported RXDIDs to a VF.

This structure is only 8 bytes in size. The function must hold the
allocated length on the stack as well as the pointer to the structure which
itself is 8 bytes. Allocating this storage on the heap adds unnecessary
overhead including a potential error path that must be handled in case
kzalloc fails. Because this structure is so small, we're not saving stack
space. Additionally, because we must ensure that we free the allocated
memory, the return value from ice_vc_send_msg_to_vf() must also be saved in
the stack ret variable. Depending on compiler optimization, this means
allocating the 8-byte structure is requiring up to 16-bytes of stack
memory!

Simplify this function to keep the rxdid variable on the stack, saving
memory and removing a potential failure exit path from this function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index bc9fadaccad0..f445e33b2028 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3031,10 +3031,8 @@ static int ice_vc_set_rss_hena(struct ice_vf *vf, u8 *msg)
 static int ice_vc_query_rxdid(struct ice_vf *vf)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct virtchnl_supported_rxdids *rxdid = NULL;
+	struct virtchnl_supported_rxdids rxdid = {};
 	struct ice_pf *pf = vf->pf;
-	int len = 0;
-	int ret;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
@@ -3046,21 +3044,11 @@ static int ice_vc_query_rxdid(struct ice_vf *vf)
 		goto err;
 	}
 
-	len = sizeof(struct virtchnl_supported_rxdids);
-	rxdid = kzalloc(len, GFP_KERNEL);
-	if (!rxdid) {
-		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
-		len = 0;
-		goto err;
-	}
-
-	rxdid->supported_rxdids = pf->supported_rxdids;
+	rxdid.supported_rxdids = pf->supported_rxdids;
 
 err:
-	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_SUPPORTED_RXDIDS,
-				    v_ret, (u8 *)rxdid, len);
-	kfree(rxdid);
-	return ret;
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_SUPPORTED_RXDIDS,
+				     v_ret, (u8 *)&rxdid, sizeof(rxdid));
 }
 
 /**
-- 
2.42.0


