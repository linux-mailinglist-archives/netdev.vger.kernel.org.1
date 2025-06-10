Return-Path: <netdev+bounces-196239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B763AAD4024
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7E23A4DF9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B11244673;
	Tue, 10 Jun 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+N3P1EY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B1242D98
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575637; cv=none; b=Ip6+BptJgVKkL9/DBiOSE9HM/MaErpG3Ii0OR0klJZjuIoPPBHLLW6pPUKCNSzHyv1OkojRQERljR+rPm6ThriHy3WLgwCqHug7bxUSHpm1+rsYQpmscbRTuY89uwKbuq3clf3biG7IRNsQzaLGwXZi6WX5nHN0p9fYjqwZUdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575637; c=relaxed/simple;
	bh=0kFcVPkmzw+vvLIC3ejIFhxTVcUG8AikP4NArTpSvU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THZKD1wS3g1r64p7dYXNYFczlxoVdvH4KidZCrHBeK7/Nbi/h7rjVntsum4swblemfx7svMxJBVP3r/2GmqQPXYMGmiUcX+lDKfhLfo2vxmj57BOajaeE2Xpmx9g1PeWEso8/tCw+7zJqGu92kRmvV/tPhSWUlGsoHY4PzcXwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+N3P1EY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749575636; x=1781111636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0kFcVPkmzw+vvLIC3ejIFhxTVcUG8AikP4NArTpSvU4=;
  b=E+N3P1EYY88UuYOfMAZfyTogqOBwc1j77xY/lEeTZjdKizgAPPBo3PvY
   BA/ojbnseUX8w1f9TuErpf6OwnINLpQkB1Xv7g9Ks4ykkvNYHl+bih6VO
   thIHdm4jOG9HTb+LcHpfOgtauuX1U1vzc/Dt4wQNijiRIx2pNwjZLi08r
   19Q/Q41qrZs/LGguVmtbVeSxu7HbF6V4Z+aX8gaHQOveqs3MxTqlbhyed
   RtkAsTBpMk7/bne9Xq6+MKvXW0W5OPEfWxfm/MH/nCfHafyGDp56DsEdo
   H2NPGwmUEWlNnGQ6BthjADyJw8cln0Ll7tjMuMrSPl3jJ+HodhUnanR4r
   w==;
X-CSE-ConnectionGUID: JpO1WMDyQaGS7e88J4c68Q==
X-CSE-MsgGUID: I0a/6KTxQxSzK9FRzeK9JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51554649"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51554649"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:13:54 -0700
X-CSE-ConnectionGUID: enDlfHnaQc6+UcoYqsQNrw==
X-CSE-MsgGUID: T1N9/IyqR6+4btaSxT7mSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147850437"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 10:13:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Robert Malz <robert.malz@canonical.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/5] i40e: return false from i40e_reset_vf if reset is in progress
Date: Tue, 10 Jun 2025 10:13:41 -0700
Message-ID: <20250610171348.1476574-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
References: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Malz <robert.malz@canonical.com>

The function i40e_vc_reset_vf attempts, up to 20 times, to handle a
VF reset request, using the return value of i40e_reset_vf as an indicator
of whether the reset was successfully triggered. Currently, i40e_reset_vf
always returns true, which causes new reset requests to be ignored if a
different VF reset is already in progress.

This patch updates the return value of i40e_reset_vf to reflect when
another VF reset is in progress, allowing the caller to properly use
the retry mechanism.

Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1120f8e4bb67..22d5b1ec2289 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if the VF is in reset, resets successfully, or resets
- * are disabled and false otherwise.
+ * Return: True if reset was performed successfully or if resets are disabled.
+ * False if reset is already in progress.
  **/
 bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
@@ -1566,7 +1566,7 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 
 	/* If VF is being reset already we don't need to continue. */
 	if (test_and_set_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-		return true;
+		return false;
 
 	i40e_trigger_vf_reset(vf, flr);
 
-- 
2.47.1


