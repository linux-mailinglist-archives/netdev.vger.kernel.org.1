Return-Path: <netdev+bounces-77635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C1872719
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50569288F7E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B4241E5;
	Tue,  5 Mar 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEGKTKf0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1371B81A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665067; cv=none; b=iEF6NCygxo8tcRmCTVkwhZVv44f1lOw62Hd4WlaM6cZDmREqsVNqK/CL86gNnYu6W2PhzT7QQ4O64dtWVUxEJaUWw2YhboIoFuSRtsiwzLf2pIE2EHkdcdkHQNTI4i1B9BqA+cBCLOYclNtf4mJHYK6COfuWJWTjOQuNI3MGG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665067; c=relaxed/simple;
	bh=qXxWfrbFLOwYKPeGo2ifLUn7suN8lhhyGBJeOLt8Rlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vsy9XgU2E1pv/vGgmkilVCSthvNcIuJT56MjTztz9WxbGnsvp7xOv+5X4lNzJXWtcQyHsuXJe6t4miQcat/fLDF4nH9/Vig+SNjpmcq9Ju8lcWKGXyUur0+mlJ43tIeB0y4m7RDrSN/6rsZTgxrrvz0xhFdi+dZMcwZjHX2fv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEGKTKf0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665066; x=1741201066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qXxWfrbFLOwYKPeGo2ifLUn7suN8lhhyGBJeOLt8Rlw=;
  b=HEGKTKf0g1Asxr5n8rd3nxeHbb6vqbsirWJuDgHgQLNURUNjYT6d7MKE
   ZHt78PMVipxl/EtMgej4b2l1rCNgDsIMZbONusK7GHC45qoRIu+h1xFmq
   FjzUMobhJNZWE3Jsuc83lwLfF1OOEbu/ECK/xQSvFFw5/fb1+7nSOa070
   VEx+KeNT6/dS9GVRHHOEPYjS+i7V7Wt7LEv0Yju3s7azMtowy2xH03J9Q
   +wELFPbR2/QiawzKKOEITyFa4w274QIkjACr+VFkhlgTFtQ7zmUjMdJvg
   Re1D1YM5A4Cp/P3Nlpf1vn4yOphU2rlCA07Nb/cwZDuUY0p7E1GzQJxZC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822187"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822187"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337200"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Alan Brady <alan.brady@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/8] ice: virtchnl: stop pretending to support RSS over AQ or registers
Date: Tue,  5 Mar 2024 10:57:30 -0800
Message-ID: <20240305185737.3925349-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The E800 series hardware uses the same iAVF driver as older devices,
including the virtchnl negotiation scheme.

This negotiation scheme includes a mechanism to determine what type of RSS
should be supported, including RSS over PF virtchnl messages, RSS over
firmware AdminQ messages, and RSS via direct register access.

The PF driver will always prefer VIRTCHNL_VF_OFFLOAD_RSS_PF if its
supported by the VF driver. However, if an older VF driver is loaded, it
may request only VIRTCHNL_VF_OFFLOAD_RSS_REG or VIRTCHNL_VF_OFFLOAD_RSS_AQ.

The ice driver happily agrees to support these methods. Unfortunately, the
underlying hardware does not support these mechanisms. The E800 series VFs
don't have the appropriate registers for RSS_REG. The mailbox queue used by
VFs for VF to PF communication blocks messages which do not have the
VF-to-PF opcode.

Stop lying to the VF that it could support RSS over AdminQ or registers, as
these interfaces do not work when the hardware is operating on an E800
series device.

In practice this is unlikely to be hit by any normal user. The iAVF driver
has supported RSS over PF virtchnl commands since 2016, and always defaults
to using RSS_PF if possible.

In principle, nothing actually stops the existing VF from attempting to
access the registers or send an AQ command. However a properly coded VF
will check the capability flags and will report a more useful error if it
detects a case where the driver does not support the RSS offloads that it
does.

Fixes: 1071a8358a28 ("ice: Implement virtchnl commands for AVF support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Alan Brady <alan.brady@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c           | 9 +--------
 drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index c925813ec9ca..6f2328a049bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -440,7 +440,6 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 		vf->driver_caps = *(u32 *)msg;
 	else
 		vf->driver_caps = VIRTCHNL_VF_OFFLOAD_L2 |
-				  VIRTCHNL_VF_OFFLOAD_RSS_REG |
 				  VIRTCHNL_VF_OFFLOAD_VLAN;
 
 	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
@@ -453,14 +452,8 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->vf_cap_flags |= ice_vc_get_vlan_caps(hw, vf, vsi,
 						    vf->driver_caps);
 
-	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
+	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_PF;
-	} else {
-		if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_AQ)
-			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_AQ;
-		else
-			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_REG;
-	}
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index 5e19d48a05b4..d796dbd2a440 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -13,8 +13,6 @@
  * - opcodes needed by VF when caps are activated
  *
  * Caps that don't use new opcodes (no opcodes should be allowed):
- * - VIRTCHNL_VF_OFFLOAD_RSS_AQ
- * - VIRTCHNL_VF_OFFLOAD_RSS_REG
  * - VIRTCHNL_VF_OFFLOAD_WB_ON_ITR
  * - VIRTCHNL_VF_OFFLOAD_CRC
  * - VIRTCHNL_VF_OFFLOAD_RX_POLLING
-- 
2.41.0


