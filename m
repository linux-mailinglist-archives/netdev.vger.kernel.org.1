Return-Path: <netdev+bounces-77251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B063870CF2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0BE1F21583
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938587C09A;
	Mon,  4 Mar 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2iJsQ8O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0A7BB05
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587785; cv=none; b=YAWftzGBQ/04bTgUgx+HzyFuaqYZphv3G1lttaBYlJEGk6hPCVUZdxcEpWvMW56too0VloOslSRpYRUhKJ6FJCShgtK9z06JbULyW7jrozcO91WIRbB+MLQjyO1t8aZOGfR4/v4J0G6hD603uD543IDCLDzYo3X6IPaZX4IkBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587785; c=relaxed/simple;
	bh=ryI2o5dQHWP2jv9FblrEa8kfhuMJwq/tLt4ntTowu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlCab+s/+3ObsdVLyF+WOE1YDUf45Q40OpFkI8dYzhocUMEs6D3LjjS3fzGrasL7hPyqFEL4JceC/hGpfRr/i5m+n/YiaWAPbmZWo66YgnEUmxYWanskrnhtle8ZkWhJYdXJHvk4cP7HMhGT09d2OwqVtD07ndAic2Xus0ih6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2iJsQ8O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587784; x=1741123784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ryI2o5dQHWP2jv9FblrEa8kfhuMJwq/tLt4ntTowu/s=;
  b=N2iJsQ8OsAxOSJuFA0Tpo7o9/kwFtsdY48kxN4fcM1cKvTg3K+AQXX0t
   mR3DmOPPfwj9kxcnlc1UkQUH4OIQ3xoUjBIL4FybIHtrIps4DDVnFJS2J
   zPuePizgGkKJKbHGJJ3xEVAcgQ9gQ6+R921bOJtJUwfg1qZHt0zVmK3Ds
   BeW3dGHb/0araBieXDOFa069qwORoKTyHTiDMICtp/cKaWptrf9HUgUAu
   T7TGwRsPSpyXKmRa/RI0p+4bw/biVCLbybnaDZcHQ6GexZNFZFC83Mio5
   dn4sKhDkU0TaabNoaloa/g0o2KSpLgPGGbV8HL2hLeP0BJEQ81jHvpzZm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968078"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647878"
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
Subject: [PATCH net-next 4/9] ice: remove vf->lan_vsi_num field
Date: Mon,  4 Mar 2024 13:29:25 -0800
Message-ID: <20240304212932.3412641-5-anthony.l.nguyen@intel.com>
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

The lan_vsi_num field of the VF structure is no longer used for any
purpose. Remove it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c  |  1 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 10 +---------
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  5 -----
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a94a1c48c3de..a2f8dbe3cb82 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -240,7 +240,6 @@ static struct ice_vsi *ice_vf_vsi_setup(struct ice_vf *vf)
 	}
 
 	vf->lan_vsi_idx = vsi->idx;
-	vf->lan_vsi_num = vsi->vsi_num;
 
 	return vsi;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 2ffdae9a82df..21d26e19338a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -280,12 +280,6 @@ int ice_vf_reconfig_vsi(struct ice_vf *vf)
 		return err;
 	}
 
-	/* Update the lan_vsi_num field since it might have been changed. The
-	 * PF lan_vsi_idx number remains the same so we don't need to change
-	 * that.
-	 */
-	vf->lan_vsi_num = vsi->vsi_num;
-
 	return 0;
 }
 
@@ -315,7 +309,6 @@ static int ice_vf_rebuild_vsi(struct ice_vf *vf)
 	 * vf->lan_vsi_idx
 	 */
 	vsi->vsi_num = ice_get_hw_vsi_num(&pf->hw, vsi->idx);
-	vf->lan_vsi_num = vsi->vsi_num;
 
 	return 0;
 }
@@ -1315,13 +1308,12 @@ int ice_vf_init_host_cfg(struct ice_vf *vf, struct ice_vsi *vsi)
 }
 
 /**
- * ice_vf_invalidate_vsi - invalidate vsi_idx/vsi_num to remove VSI access
+ * ice_vf_invalidate_vsi - invalidate vsi_idx to remove VSI access
  * @vf: VF to remove access to VSI for
  */
 void ice_vf_invalidate_vsi(struct ice_vf *vf)
 {
 	vf->lan_vsi_idx = ICE_NO_VSI;
-	vf->lan_vsi_num = ICE_NO_VSI;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 0cc9034065c5..fec16919ec19 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -109,11 +109,6 @@ struct ice_vf {
 	u8 spoofchk:1;
 	u8 link_forced:1;
 	u8 link_up:1;			/* only valid if VF link is forced */
-	/* VSI indices - actual VSI pointers are maintained in the PF structure
-	 * When assigned, these will be non-zero, because VSI 0 is always
-	 * the main LAN VSI for the PF.
-	 */
-	u16 lan_vsi_num;		/* ID as used by firmware */
 	unsigned int min_tx_rate;	/* Minimum Tx bandwidth limit in Mbps */
 	unsigned int max_tx_rate;	/* Maximum Tx bandwidth limit in Mbps */
 	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
-- 
2.41.0


