Return-Path: <netdev+bounces-84615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B768979B2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B125B24666
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734B155A4F;
	Wed,  3 Apr 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZyS4/Yw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C115574B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175580; cv=none; b=bz2k5jwEh3DhmhkwcoyuUKnATu/Oe5VGo59qGheU9eqyTIXzyjFAhZYLBhwOD5QJVZEjojx9L1PcY2e1x1iMDG564pyn15/5ZlaClB8kUvzLvQZtgMoOb0g5oFGkTdYARLHc1iywmNwjt/8q0WpxA9/kgzNaZe67A/buhvyMbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175580; c=relaxed/simple;
	bh=9H2lwI4Bsjuj+5xkt2aHUfOhrY/43BLjMOJ8ztq2o1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQ+1UBv+s2deP1wGGb7/UZ7nFobEhMcss1ZEZg9mH8C9O0HVhKx79OBDytD+P5Hlu8M1x3Va34rd/i9tU3ozH4zwLyqvMUjxrrTRdZQs+67eB+/uFYtu/9HUmFirY11R708YY+INAX9nxKhcl0GgDPK4545PTm1AymsAi/5q8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZyS4/Yw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712175579; x=1743711579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9H2lwI4Bsjuj+5xkt2aHUfOhrY/43BLjMOJ8ztq2o1c=;
  b=JZyS4/YwCOHgQ9jLwDCkwI+LSWFTEd/3nc2m11DQsIN7fO4zH7tk04GP
   YC7qM5ByCC7eba7xG/nxE6hBDrd9cRUtpRonZJ21i+0mki086UZrc62aL
   cFsxiR2DDrnr8uYsUkp5CeVqiR/4jCAYpuIp9p4JbSgni+J3uvmae69H2
   Fe40dv61YQ9T3f4KGxVkwMaZnNIFsAFdqMCLQK8gNXtGCvPvPTZR+dB9Q
   M1cIDoBJBQAsXOHkg6bz3o/Za3UxGSIFk10m2NGiA6vQ2G3xJzKiAyIMC
   FGdmqlwdv1/rCtxZ1tGNcCcpzQHi8hvnpjE/JWSs13omXFxlb3GDoghNy
   w==;
X-CSE-ConnectionGUID: qwPn1mbYR8iJW75Naack1w==
X-CSE-MsgGUID: w1We7ttOQ1qut3YsRoHNUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18165808"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18165808"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:19:38 -0700
X-CSE-ConnectionGUID: nw3JSSvRTjWagZcvWP2BPQ==
X-CSE-MsgGUID: bdGwvaixR3Khl7bAW4sitg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18662695"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 13:19:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/3] ice: fix enabling RX VLAN filtering
Date: Wed,  3 Apr 2024 13:19:27 -0700
Message-ID: <20240403201929.1945116-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
References: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Oros <poros@redhat.com>

ice_port_vlan_on/off() was introduced in commit 2946204b3fa8 ("ice:
implement bridge port vlan"). But ice_port_vlan_on() incorrectly assigns
ena_rx_filtering to inner_vlan_ops in DVM mode.
This causes an error when rx_filtering cannot be enabled in legacy mode.

Reproducer:
 echo 1 > /sys/class/net/$PF/device/sriov_numvfs
 ip link set $PF vf 0 spoofchk off trust on vlan 3
dmesg:
 ice 0000:41:00.0: failed to enable Rx VLAN filtering for VF 0 VSI 9 during VF rebuild, error -95

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
index 80dc4bcdd3a4..b3e1bdcb80f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
@@ -26,24 +26,22 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
 	struct ice_vsi_vlan_ops *vlan_ops;
 	struct ice_pf *pf = vsi->back;
 
-	if (ice_is_dvm_ena(&pf->hw)) {
-		vlan_ops = &vsi->outer_vlan_ops;
-
-		/* setup outer VLAN ops */
-		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
+	/* setup inner VLAN ops */
+	vlan_ops = &vsi->inner_vlan_ops;
 
-		/* setup inner VLAN ops */
-		vlan_ops = &vsi->inner_vlan_ops;
+	if (ice_is_dvm_ena(&pf->hw)) {
 		vlan_ops->add_vlan = noop_vlan_arg;
 		vlan_ops->del_vlan = noop_vlan_arg;
 		vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
 		vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
 		vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
 		vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
-	} else {
-		vlan_ops = &vsi->inner_vlan_ops;
 
+		/* setup outer VLAN ops */
+		vlan_ops = &vsi->outer_vlan_ops;
+		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
+		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
+	} else {
 		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
 	}
-- 
2.41.0


