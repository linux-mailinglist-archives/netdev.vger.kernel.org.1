Return-Path: <netdev+bounces-184893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC8A979B3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B432460CD2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2628137E;
	Tue, 22 Apr 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaF0kiDU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F827055E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358516; cv=none; b=Yp+EhyN0DIFFa/hNWOIhOirLWxaq92fD37udRW/ercjbSqsakjAx1uS0WOnla+nfdxNgduY+nXwFEhlLPvF+soHk7mQJ8+Z1salvrTDaj/hFQZ9z0VqoAnQTb92+FoNbgiY8JwMd1OYqDV+y3EHeKMRX8gFLWjSbYC7ActKXPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358516; c=relaxed/simple;
	bh=AkPA9+ChKNYGyL88tncLplFeiHuntjhi9ZHBYl7nTqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI0ZzwDhTONJ1wa69L0OED/Sq2SdMx8pNF7Ylo80OmHtm9bI02lvDOT2mVqrjpKh/0s+5YZYvvEgs06E+gYz06Xd1M6y75uEs1N4MIdlQHfw/23NL73qWJ2Qy7O1dizfH3Sl9+vlZoteLxidZoWDjngjpBl11SoPHI6VzsoL1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaF0kiDU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745358515; x=1776894515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkPA9+ChKNYGyL88tncLplFeiHuntjhi9ZHBYl7nTqc=;
  b=QaF0kiDUZmNRpz2WF+g4MjjlAJZWaU/n/6LA3/vlSfYlbjIKfY1KsUuw
   d51XgoWWaDd3+lf3zBIJCJ1t1ieE2Zv12mEN/CDIpvnFNkWQg4cMPXURc
   4whxP4b09fezFRTTadwPbNEOdt6URf1xVP+AHawPeHxgd+TaQX8SJT4cK
   10GuXEbBUJbqvp0vVOxiD4mX8axYKroMJKzH/RXM8EWg4KyMCgmf4AO09
   5b3hjHNGiGrGSvrh9tp+ZKz3EJRyHszBjSet5ZO/WjeEZjVZ6kQbKw581
   lvXrw3FQzy89FrnuEWLcS0zqcOeW26OuQz+l4dkQDOiftFlg3kTq1SMBU
   w==;
X-CSE-ConnectionGUID: Cnw3RiTDSze41YvhZygXjg==
X-CSE-MsgGUID: fUdmFaPRSLyhUiafJIIGUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46949138"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46949138"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 14:48:32 -0700
X-CSE-ConnectionGUID: FGNrzoUgQauuQmn+eZApnQ==
X-CSE-MsgGUID: wP1B3+2tSj2OFnC6qZ3r/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="163186554"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 22 Apr 2025 14:48:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/3] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
Date: Tue, 22 Apr 2025 14:48:06 -0700
Message-ID: <20250422214822.882674-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
References: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
pointer values"), we need to perform a null pointer check on the return
value of ice_get_vf_vsi() before using it.

Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 7752920d7a8e..1cca9b2262e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -2097,6 +2097,11 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
 	vf_vsi = ice_get_vf_vsi(vf);
+	if (!vf_vsi) {
+		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err_exit;
+	}
 
 #define ICE_VF_MAX_FDIR_FILTERS	128
 	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
-- 
2.47.1


