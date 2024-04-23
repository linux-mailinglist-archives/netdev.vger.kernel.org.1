Return-Path: <netdev+bounces-90593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AA48AE9A0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CA6281E0F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE21F959;
	Tue, 23 Apr 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sob+d08f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153719470
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882907; cv=none; b=VQGmTIoA7SdLu1iPD3bOHgf+JAnlwQPh/0jCTX9ioyL4kHHjomdhLAIDzud4Dgmy3VKoG/PVmBzivMu0qeiFOfIuhHhL6rR3RePEOXdCXPCvETYU4nOL/zYIman2WK6WG3dytU3/hsMwcQQuTfyGZqP5AkJSGGmJzzVaGbix2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882907; c=relaxed/simple;
	bh=JJeDsjTN75HCqhlyAhfBJzYPhMpKfc9FiSlj9/utqQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8pD8yTZHUmD/+EUA5P0AkrdRI5PiVXie9zOzJRvcP8nJd2Yq3Ys1X7S0AZ1sBtY5EAtBm5CsJ6uNyfbdzwbsuMUIvAZTwdrnFApmrR+vS1gTWxvRFO0MIElajCxI2gaLBeXzIbHSbvIIKcWo7/+lI9Z/vJXeBEZFCKUQGNAi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sob+d08f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882906; x=1745418906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JJeDsjTN75HCqhlyAhfBJzYPhMpKfc9FiSlj9/utqQ8=;
  b=Sob+d08fETF2+kpWsTIjvm9TV5TQEIk9H8qkgvB8AXiRCBpCUP+0+340
   U5koAe75Erx2WFer424gk86gQqfwzoo6fiCg1oA2HJyTslTVv41PLYkKS
   nS1OoXElDR0rTAswNFL9UDh8YndupqAUQXyBcX6UY/p5XojdiJpXWJiGU
   Re7ZOOXYXIXlivk62tHyTc7wK+SazykSmluykb0G+J5VRbPqyPFO7yFYr
   IPgzhgSkHIyAgF77RXR60cIGDQLbH4ANZWYvPdcgqXR/oLhrcbzXqNbxa
   bitmQkoK8RS+XDpAut7a/AhA0V6o+XUXynm3dEpfjfyoE90lGX08m70S1
   w==;
X-CSE-ConnectionGUID: IbP5VR/ZTNa9DUBPRW8u7Q==
X-CSE-MsgGUID: UUruH0pRRYGRyhi+3rkiyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20870920"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20870920"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:35:01 -0700
X-CSE-ConnectionGUID: dqkM8oChRHmUNfCdjg8Ofg==
X-CSE-MsgGUID: 1a3IM4mjQA6lAwjOa+VG+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24843324"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 23 Apr 2024 07:34:59 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C2DE3332BD;
	Tue, 23 Apr 2024 15:34:51 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next] ice: remove correct filters during eswitch release
Date: Tue, 23 Apr 2024 16:36:32 +0200
Message-ID: <20240423143632.45086-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
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
---
It is targetting iwl-next with fix, because the broken patch isn't yet
in net repo.
---
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


