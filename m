Return-Path: <netdev+bounces-28619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33277FFF0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2131C21565
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B111DA2A;
	Thu, 17 Aug 2023 21:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0011DA21
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6D10C0
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307780; x=1723843780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKaYT+O9unWUoVGWtTN6LFr5yT5iaJgilDeE52iVJdQ=;
  b=W5wr9Rpx+UAnCfGoncQxXBJDReBa0qDmHc9SGVIAT7TDh/W34joTqXf3
   p4zCZd5UPEYQpXORvViasQcO9zIPBCK9qldXzOJewtVnCxJODdrRrUWAW
   Fzl2eqa4vu+lFqWZgv9sTZz7K02tZFHXCcXUfYPLIlGC6mvbH+F5oku9o
   QHZ96nKe6ifWqqcyHi7DXNHBSsuswlzt/4if7nRAIjoDLzR7voYVr2bGz
   nqTzn8EPTzrjyVzQ57RKEwr2axI+OZppSrGrY4F2S3M22XR/pT1J0oPWu
   kWZbtg+TOGoHsilEfpskASrtZ5eaQjZZRF+OQYDniyxdRKr+dR6+aFTg+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095095"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095095"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813729"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813729"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 10/15] ice: Remove redundant VSI configuration in eswitch setup
Date: Thu, 17 Aug 2023 14:22:34 -0700
Message-Id: <20230817212239.2601543-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Remove a call to disable VLAN stripping on switchdev control plane VSI, as
it is disabled by default.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 9a53a5e5d73e..62b54100273f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -84,10 +84,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	struct ice_vsi_vlan_ops *vlan_ops;
 	bool rule_added = false;
 
-	vlan_ops = ice_get_compat_vsi_vlan_ops(ctrl_vsi);
-	if (vlan_ops->dis_stripping(ctrl_vsi))
-		return -ENODEV;
-
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 
 	netif_addr_lock_bh(uplink_netdev);
-- 
2.38.1


