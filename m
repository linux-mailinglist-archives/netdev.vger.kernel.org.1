Return-Path: <netdev+bounces-77248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B768870CEE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586E21C23FD1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEE85B1FE;
	Mon,  4 Mar 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIvD/irY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A77BAFD
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587783; cv=none; b=MqFEK2ol2DAM800lCcSAgRABJ7wvl2UtJ/NuTAB265asMOFf15WH3gProc1euP6Mf8eclbVs9k5kOZGvCvvec5aJXQZrPUMgJyk9Qxn+zbovv7QM5QN5r8nfEbtSN5uaZyXMwo2nGHIH/UAV5ovt5KVkF0WDwCFRid3yXIqIYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587783; c=relaxed/simple;
	bh=GZVPh96yDKnfoItbpXS7EBV7LJQ/+GSz6fmyNrnvxCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVw8ibZbnn3Vqrc+ULBn7dFqgn0BNgmAy74qudRDlsJhLl+p7hyir4i8I1ofnAc9BUN5NY5+G1jJTk9YqI88xhBby2/lQXr9YVDDAzdNWa4MBL2eiKfdF+LsnykemTz89mB9GyRkO0FVcMG5NqvIuuiDHoDRp3QyC96mtVbziqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIvD/irY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587782; x=1741123782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZVPh96yDKnfoItbpXS7EBV7LJQ/+GSz6fmyNrnvxCg=;
  b=MIvD/irY2i15SpLWTbBwIQjR2GDSwKBotHUN/thsYuIOtjzsjr2aeZDm
   qxYwxpjrujZeyfzT1K1zkVkgSMp376sO/1QKYHcU3hCV++w8e/E/kyjek
   NNY8Np3ZlbHlCFv+letCXdw/NstBT8ol72V3m+5arJR+TzLuH2Paoi9O6
   BNsJ7ut+HzVyVHvoR1cnnB4nHXb8uMqoXJGRHXl2/BGrpVfq67vV0qMBo
   E646VfCvECNjxtrha38ExQ4cJMOQlDc2sgLzfNhIHRei5CkULIuDNCG2J
   /5nm14Ui0q2sxyjtVJBwYJaRbv9t/2Y9JlftjLFPARBbuwoNSz2yh3xaf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968067"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647872"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 2/9] ice: remove unnecessary duplicate checks for VF VSI ID
Date: Mon,  4 Mar 2024 13:29:23 -0800
Message-ID: <20240304212932.3412641-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_vc_fdir_param_check() function validates that the VSI ID of the
virtchnl flow director command matches the VSI number of the VF. This is
already checked by the call to ice_vc_isvalid_vsi_id() immediately
following this.

This check is unnecessary since ice_vc_isvalid_vsi_id() already confirms
this by checking that the VSI ID can locate the VSI associated with the VF
structure.

Furthermore, a following change is going to refactor the ice driver to
report VSI IDs using a relative index for each VF instead of reporting the
PF VSI number. This additional check would break that logic since it
enforces that the VSI ID matches the VSI number.

Since this check duplicates  the logic in ice_vc_isvalid_vsi_id() and gets
in the way of refactoring that logic, remove it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index f001553e1a1a..8e4ff3af86c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -94,9 +94,6 @@ ice_vc_fdir_param_check(struct ice_vf *vf, u16 vsi_id)
 	if (!(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_FDIR_PF))
 		return -EINVAL;
 
-	if (vsi_id != vf->lan_vsi_num)
-		return -EINVAL;
-
 	if (!ice_vc_isvalid_vsi_id(vf, vsi_id))
 		return -EINVAL;
 
-- 
2.41.0


