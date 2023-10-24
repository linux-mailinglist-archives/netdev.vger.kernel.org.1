Return-Path: <netdev+bounces-43824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B558E7D4EE4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7028A28196F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51600266A2;
	Tue, 24 Oct 2023 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJxqTNWD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE9266BE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:34:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98ED79
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147291; x=1729683291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOP4TaA1QFKZPS4/quiy5ENIcIphfAumHFGGIkT2f5k=;
  b=KJxqTNWD1iIc2HqEjCPFyMbt7BH0GjV6rtvwM4PhlLYglC4kPFxl5V8/
   CzXHd0OnhZtw50nsoxDNJwPQmDLYNlWYr3sayu6+kLzJfL1E/Zzl1GrXx
   IlTB7t17+z8A+84KmJKN+OxIow+VREfN/e6GUkcXU5sOy5HyWrFo5z2S5
   /JpG1JgRAc5+eMf1Oyr1mQptspv3Et1T4/jglpkjOSFXWnkzmrLjihXJP
   1GgzffX6IR1LU8nkXq0+D2yx8tCt982hgISx1LG+zUccCZHYCPBcHlyvA
   ewZwON3QktTwXhqYUL8InBsjoKF1uZPbiOmk+cckeb8Ey/YySAX250LP8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660541"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146037"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:32 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 05/15] ice: use repr instead of vf->repr
Date: Tue, 24 Oct 2023 13:09:19 +0200
Message-ID: <20231024110929.19423-6-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract repr from vf->repr as it is often use in the ice_repr_rem().

Remove meaningless clearing of q_vector and netdev pointers as kfree is
called on repr pointer.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index a2dc216c964f..903a3385eacb 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -355,16 +355,16 @@ static int ice_repr_add(struct ice_vf *vf)
  */
 static void ice_repr_rem(struct ice_vf *vf)
 {
-	if (!vf->repr)
+	struct ice_repr *repr = vf->repr;
+
+	if (!repr)
 		return;
 
-	kfree(vf->repr->q_vector);
-	vf->repr->q_vector = NULL;
-	unregister_netdev(vf->repr->netdev);
+	kfree(repr->q_vector);
+	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(vf);
-	free_netdev(vf->repr->netdev);
-	vf->repr->netdev = NULL;
-	kfree(vf->repr);
+	free_netdev(repr->netdev);
+	kfree(repr);
 	vf->repr = NULL;
 
 	ice_virtchnl_set_dflt_ops(vf);
-- 
2.41.0


