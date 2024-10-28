Return-Path: <netdev+bounces-139482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43699B2C4A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B21F22B32
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2A1D365B;
	Mon, 28 Oct 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6TNgGP2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797801D0DE7
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109857; cv=none; b=Y9rCZFTC4ImtXgeAlYQhS4DxBgwu3Xq7bIjJjLg877tCwE4cMzs0UFEUyF6o2CxirH4PsdjWJGCFn7V4uYCQeIdqECTfvUkf1iu3jYCcdT21myVN/W2aPmJOR07JmNV4BHjNlgsfhE2rnNC2AjtnikYpV8sUhbt5GLyfwEE0mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109857; c=relaxed/simple;
	bh=bNMiaOO8wUNylIk9gISuKsnF9jJ0waLC+cK5MBdQs1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjXjkGUnaNYtBrHUYDQPw2nqY33DtZP7G0n5Q1cNg6Xnl3WUYh9bhVs0HzOA2BpnpLLJpx1yPZaQrc6D2J8cFdW+32woDHPmMZiKayckUbDRy1r+rseIqH/xJYnCbOoYhG1f9Iwr8GE3JmDf8F/CRBzjb8b+AGoMfRu83tv5fJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6TNgGP2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109856; x=1761645856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNMiaOO8wUNylIk9gISuKsnF9jJ0waLC+cK5MBdQs1o=;
  b=b6TNgGP2cZdiB1nOJSqyLsNLk6FyW7HW6rctOGdwGD4fnzj0Vdo69MSX
   H5LsvS7QmFGJ9T5n2QMBHF7i+DEqCHhMcpHJFuxR79jQq3B1biF6O/iSR
   za4yLwbPLwk5RFUpNFHiw6LRh2OjksS5CJmcGNHK7Qmb+xsWPQW2hWRGz
   D2V+M42kL1V6EC2Bvjkuzcs2/sFNsawswWqnZjFX9jeoFxY1nf7TEf35k
   wYUlF/WZ4m8EsDs0KMxj83sE09mZCWI9q1uGK48isnTaQKT3MeEgNWbfb
   hfpQigr2VdbIkHhXygg5hN6kggJgn5d7WSwD+yYGrMaEejlEQD4CJcS15
   g==;
X-CSE-ConnectionGUID: Wb6SncJ+RgudOv3jOEBLUQ==
X-CSE-MsgGUID: ky0Subd4SjWwyUuqQ3l4sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29560809"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29560809"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 03:04:16 -0700
X-CSE-ConnectionGUID: Nzw1Den3Q6mH0npFuWkOjg==
X-CSE-MsgGUID: XkaUc/syR2GGSNXuLVtt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86182517"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 28 Oct 2024 03:04:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM
Subject: [iwl-next v6 9/9] ice: init flow director before RDMA
Date: Mon, 28 Oct 2024 11:03:41 +0100
Message-ID: <20241028100341.16631-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f3dd300a7dad..b819e7f9d97d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5168,11 +5168,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5180,6 +5181,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5203,8 +5205,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0


