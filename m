Return-Path: <netdev+bounces-122081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A595FD6C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3211F2268C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9251A0703;
	Mon, 26 Aug 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNEfls+1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521C1A01B4
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712428; cv=none; b=neba5KHLUdxB9Z+R9rQtwR1jpo1Wj5o6AintgZ7mxQ3KlNHqKwh/OOCPrU2V+KOROs+yCCe+wrQwvftM0Haj4VFE3jJT9m1K5/CT4tM1meHMhkgcRVPMq7ifYsTP/bqhcqcrxm+byDReykPgma4WH3DHmGNoiQ7VpJCS4CXhEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712428; c=relaxed/simple;
	bh=rhMFAdYMYtCndSg/6IQRdAdJBHzcPOSYR3Dlb672MHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAWrnEUH51E8Sh9oV7GgtoB0SmH/5QpkMryrHwJgPu4KiE6ZBEYsihPahReW6EqECXGH3hhGxqBdKinyX8FnrTRlvPyQyJilKvgIuaDEfnSSGQAN+kyKzcL40vB1jij5n9adMaBGnKx/Klof8umUaFPWCZhA+I/rx+pZuH9ETog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNEfls+1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712427; x=1756248427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhMFAdYMYtCndSg/6IQRdAdJBHzcPOSYR3Dlb672MHw=;
  b=lNEfls+1tJ7OShZnI2rQ6MfjT6hOhIzOBOhYBCaq3Wp+GO6P3vns/BJv
   vdwfWP4ahf8N8LQZ+G/pCYNcP0A9Yvd14MSUn4GW7rLu4BvjzDteWT9/D
   fpj5u/OmkU1wjsYWAqTY6qT5jyYDCTzMvJW6EYxxwoux1HvPkSryU5k8y
   6OZ1zTEoi26azg1oRo9KMCwfw0koP/oO77+/tSiimbHCi4jFsmvF5qvDB
   08G4lfvMZJJ2GgRmJID27PS0on/4BNNrFrT/pbYdF/mQghM09551iEFpt
   B8ryQLDaO/eZikg7Pz7ntMgK3c+6AY+/FATX8ANUIFHjGNO85sJWOAgde
   w==;
X-CSE-ConnectionGUID: iej02nqhQuqbb3kw7C6now==
X-CSE-MsgGUID: t2xjwlp0S7Wwl3KTv5l98g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030990"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030990"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:02 -0700
X-CSE-ConnectionGUID: WdWCmYUEQHK1p/YT985XVQ==
X-CSE-MsgGUID: nNCugksfTgivqrTPQUbA0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822488"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	anthony.l.nguyen@intel.com,
	lvc-project@linuxtesting.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 8/8] ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()
Date: Mon, 26 Aug 2024 15:46:48 -0700
Message-ID: <20240826224655.133847-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Mishin <amishin@t-argos.ru>

In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
devm_kcalloc() in order to allocate memory for array of pointers to
'ice_sched_node' structure. But incorrect types are used as sizeof()
arguments in these calls (structures instead of pointers) which leads to
over allocation of memory.

Adjust over allocation of memory by correcting types in devm_kcalloc()
sizeof() arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index ecf8f5d60292..6ca13c5dcb14 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
 	if (!root)
 		return -ENOMEM;
 
-	/* coverity[suspicious_sizeof] */
 	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
-				      sizeof(*root), GFP_KERNEL);
+				      sizeof(*root->children), GFP_KERNEL);
 	if (!root->children) {
 		devm_kfree(ice_hw_to_dev(hw), root);
 		return -ENOMEM;
@@ -186,10 +185,9 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 	if (!node)
 		return -ENOMEM;
 	if (hw->max_children[layer]) {
-		/* coverity[suspicious_sizeof] */
 		node->children = devm_kcalloc(ice_hw_to_dev(hw),
 					      hw->max_children[layer],
-					      sizeof(*node), GFP_KERNEL);
+					      sizeof(*node->children), GFP_KERNEL);
 		if (!node->children) {
 			devm_kfree(ice_hw_to_dev(hw), node);
 			return -ENOMEM;
-- 
2.42.0


