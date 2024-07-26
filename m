Return-Path: <netdev+bounces-113183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAD93D136
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463861F21A25
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A022176227;
	Fri, 26 Jul 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFyCWRQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BB14277
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989910; cv=none; b=rV3NoSzebnn8ugxliZ8XiBukGJQTsSX70kU8MCyzAK2JJwhtDb1GKyIrXmX/EJEJIMi8jJn+TT2tvlGH5o1FFotJMhEkX4vihvD3Si2eh0u2PMmijszxJyolPaPiQK5Dm8E40gCDnPgzpGFdPPVdiFO0FBwurptO8GswIVdnckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989910; c=relaxed/simple;
	bh=+O4pbmRzYkPAuPXMxDQIsMy+G9AHX62ZmuJIP+QIIEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNwK5Bxsqp22N2gqupqyeNK2KjlzoRmqxBNFkanribDvPmg99yOQO85JcpJmEAf2QmO75rvVRW1MgFC2IA98pe86BnAxhKi3XYDrLBzzivNKCfOL4xiPIwdyBSzCe+nooJvQmZaB+TaN655/E68xOLqCbG6rOTtCs58RFgAIaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFyCWRQZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721989909; x=1753525909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+O4pbmRzYkPAuPXMxDQIsMy+G9AHX62ZmuJIP+QIIEA=;
  b=JFyCWRQZhG5wWJbaKrYEy4kkk9CMAq9oJnuK5i+yDJwfN0omGVzBQstF
   a3wffeFAvJXzY5reqzLDuhC32Kyk3cuSPjIWHViokmeyqgg80qlEyD3QC
   +jzi8PybVzI3XXF+0oJHMmSJyMJITAAh3xtL9BgY/kp0BjxT+8O7uKZUM
   jrRQW+Pl8B5ECbgS37tcTQc3F/tpvXN82xzJx8id+sUvvFpn5EBnUUr/I
   2nGh2cJtMzlZ1WGSWJ5hUyMbwdkocrlDnnuQGpKcHHEJF0bDH+T8bH0Qx
   mbeBJBcwYJKacDKF5Je2aCQALWd7cW2AMNpCb20+lgSM5cxr++MThOqit
   g==;
X-CSE-ConnectionGUID: zA7KyjcuQ6Wu+BrtQ3EsSg==
X-CSE-MsgGUID: AlK5JegkTriU5mYMp4IG7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19961709"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19961709"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:31:49 -0700
X-CSE-ConnectionGUID: ad5voPjCSv2v8BPcJSddsA==
X-CSE-MsgGUID: CG58LzpERTaCFURT9ehRJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="76448474"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jul 2024 03:31:48 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D035D28198;
	Fri, 26 Jul 2024 11:31:46 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: Fix incorrect assigns of FEC counts
Date: Fri, 26 Jul 2024 06:19:28 -0400
Message-Id: <20240726101928.21674-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit
ac21add2540e ("ice: Implement driver functionality to dump fec statistics")
introduces obtaining FEC correctable and uncorrectable stats per netdev
in ICE driver. Unfortunately the assignment of values to fec_stats
structure has been done incorrectly. This commit fixes the assignments.

Fixes: ac21add2540e ("ice: Implement driver functionality to dump fec statistics")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8c990c976132..bc79ba974e49 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4673,10 +4673,10 @@ static int ice_get_port_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
 	if (err)
 		return err;
 
-	fec_stats->uncorrectable_blocks.total = (fec_corr_high_val << 16) +
-						 fec_corr_low_val;
-	fec_stats->corrected_blocks.total = (fec_uncorr_high_val << 16) +
-					     fec_uncorr_low_val;
+	fec_stats->corrected_blocks.total = (fec_corr_high_val << 16) +
+					     fec_corr_low_val;
+	fec_stats->uncorrectable_blocks.total = (fec_uncorr_high_val << 16) +
+						 fec_uncorr_low_val;
 	return 0;
 }
 
-- 
2.38.1


