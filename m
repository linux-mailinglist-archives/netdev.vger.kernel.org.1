Return-Path: <netdev+bounces-142114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544EA9BD878
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858381C22432
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED121644E;
	Tue,  5 Nov 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGMNTEMo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094A216A07
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845445; cv=none; b=LdHkIB9dFQtH64g2+VnKR06cpQhyb6MqIJ9zzrv+CMYBiX/lOTmP+XBH+pkaSFj1Wss87uUyWi2DFKDBzV/OISsF31RqDyZztjfKh2emZ/YtkgUo3rOgIJnhO1xJUxJiDKess2IgmiFZllqINlPi3YOc5tr5QEVEuoRT6HTMF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845445; c=relaxed/simple;
	bh=L9EaD1mXSy6ejHghcmSLw+ooOGvXJHcTlnffJFTLCWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMnqaC66ZEVE7/J05UaGvbTYAbZe9nf4S/NrAw0LTCqJca9v9G3AWldeeG/kCTYJEXLBWTg3q9IaYiB+5v6Cj+IfqRJzAcDPp0BeRIgRXSMyRXAEIegf3SUN+s3piST9+8Bg74me8uujkxAhJdnTPoYY69NdAIDAppKpg5e3QTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGMNTEMo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845444; x=1762381444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9EaD1mXSy6ejHghcmSLw+ooOGvXJHcTlnffJFTLCWk=;
  b=HGMNTEMohuJcA09d5V2ZOIsH9KIuTUu1L3yVuUY2B9dvdcETcL+A5lxS
   vzDDqf01MMQ22ejRZYcnMQ8PWuHVm2ASs5MBcT5mnVDOkUBlYlfBR9qNt
   uQ7W3TqJwDA2vRK47xyILu3CnLxCKrgXz3zWz+ZTPBhjbU2kIcCFO8f/1
   HMWuQpvum0NGd7GlPMzP9THaLEJTLfOpMS+rAVmNfd01MEbcEnpbUh4N5
   8GvH+ZrliVhQXKwby6UsO4QjXojYB/W7+IUjsx1jekdECusV2WMYrhwuM
   kTA73fLYErWfIs9Erpa2bC/Le8vG9g6T0t+uYIiQTa6Q50qiKwCkkh6v8
   Q==;
X-CSE-ConnectionGUID: JMMRuKA8RP6TBxak2EeQ3w==
X-CSE-MsgGUID: RH2RUi5nR7KkqW6Z9nxDYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314302"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314302"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:01 -0800
X-CSE-ConnectionGUID: lixNti0HQTOEUwKiqHxvig==
X-CSE-MsgGUID: 1ASa+u/AQg2ngtpac0lzeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322460"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:00 -0800
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
Subject: [PATCH net-next 09/15] ice: use stack variable for virtchnl_supported_rxdids
Date: Tue,  5 Nov 2024 14:23:43 -0800
Message-ID: <20241105222351.3320587-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
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


