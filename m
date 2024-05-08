Return-Path: <netdev+bounces-94690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B78C0337
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5C1B2527C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC3912DDA1;
	Wed,  8 May 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKYle/7n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E312BF06
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189637; cv=none; b=EMof9QVMssK9BGRTYU29H4EMvC6DgLn+aZGovBSekHPVEo/ZYu7HeAtcodRzt1/ZUxQja+DWLy8o1pAfH+HokrbNyOWjpi7blloIg5qny4//obk4oi7uEJIMC7wtB9ayUnxjbMgk4XczmjvJj/HQYNzq5whnOTd6vr5QnTPLvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189637; c=relaxed/simple;
	bh=bd4feFvKbjqOv94UXOdYnIEnDyv/yB3NTDkVfaG20HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW9UBnOp0ixxluLhmUS9wSmCt1yq3J+3sz9GuELF8pdyooZPniv3wVA4fgWZ+cc+dFk+xZMnXq5yCtvfwVG4816avVBTKZrIBiJNZWCGI3vIETmiGVCyfd89JbvgLs95qA64XwGuY9h/pvPFsMZA0iq7zKwQWs6kYOfrdq0OKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKYle/7n; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189635; x=1746725635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bd4feFvKbjqOv94UXOdYnIEnDyv/yB3NTDkVfaG20HU=;
  b=SKYle/7n7pNe1HectSH835o24KtNLLUVE8371ISQG+feZqYLCRtHGD5n
   Nxg71ySD2CdfI4shRWJM5YOUzNKoeIfaYxhJWpuZQ94LiCddbRCje/hfh
   qRm1Fpz7Gyo3ofk8lS5YvfclAnBJSYKLms3j1uWa3YscIbVwXfW2Col4E
   bE1wqqb95b0f4QnEzRt+dRXtrZfdq0tq0e9/WF/4wLiHzJVLbg94Rj9C+
   kAs3Pwpx0tdu5k0FSTiur+sOQtEcUWzFQSLgaQGCzqqxRFuO8cSbXbYsI
   GJHfTLi/CDWOQpxtu7sGlqLtH9F8LXV7iO7ZqlBgl5tjYWLp0MnUEk6u3
   A==;
X-CSE-ConnectionGUID: l43CHNByTj2vFeHf0KXueA==
X-CSE-MsgGUID: YgD+AQqsSBuKL7n7btvtSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938970"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938970"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:52 -0700
X-CSE-ConnectionGUID: t17WCCHnRya9CsOjDRGhdA==
X-CSE-MsgGUID: dAtnRWIGRxWpBqJBZwfCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843719"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 10:33:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 5/7] ice: remove correct filters during eswitch release
Date: Wed,  8 May 2024 10:33:37 -0700
Message-ID: <20240508173342.2760994-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
References: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

ice_clear_dflt_vsi() is only removing default rule. Both default RX and
TX rule should be removed during release.

If it isn't switching to switchdev, second time results in error, because
TX filter is already there.

Fix it by removing the correct set of rules.

Fixes: 50d62022f455 ("ice: default Tx rule instead of to queue")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
It is targetting net-next with fix, because the broken patch isn't yet
in net repo.

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c902848cf88e..b102db8b829a 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -246,7 +246,10 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	ice_vsi_update_local_lb(uplink_vsi, false);
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 	vlan_ops->ena_rx_filtering(uplink_vsi);
-	ice_clear_dflt_vsi(uplink_vsi);
+	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
+			 ICE_FLTR_TX);
+	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
+			 ICE_FLTR_RX);
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
-- 
2.41.0


