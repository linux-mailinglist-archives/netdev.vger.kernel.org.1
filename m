Return-Path: <netdev+bounces-79421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F7879269
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF55282F97
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933869D0C;
	Tue, 12 Mar 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMLggJjO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5F59147
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240527; cv=none; b=BygI/niDPz+J1x4ydxl7c0Xqa6yGOj7bAGLbQkuEd2ogw6N619QPBEueIdMeenAZY9bh1MJIZtuxVnEZ3M1SY4jW6N83h/vfYuuCW2jWJXlrJikF/mcaHqpifDP1s4Jtd6teBTPDRyrd6EtvdLHXxKaUHsTapkxLN9n3b62Wprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240527; c=relaxed/simple;
	bh=XqpuxNww9Li/38WNhwzwGk9ImbAMuDJdMYjPXKQiHXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iodfIhn4ufgAN4VUnJtMTTur43cyITuplLgTR2OIiQHF1/7+nudmHOA4qhSRq+nYHcH47MaAoJcxdX0bCBBO1vBr5OlK+gC+0qFpNtvUyV7SNRXso7UzaJXJFzBycfaL0X2TyjlP/PqfKLKnP8phnmKhlyo80hfTEFXAKwXCuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMLggJjO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710240526; x=1741776526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XqpuxNww9Li/38WNhwzwGk9ImbAMuDJdMYjPXKQiHXo=;
  b=AMLggJjOSgfRBzP1AYvYEYOOu09mJx8TijZU02J5m2O4OtErvzhySlL1
   rc1zs8T9Z9XnlQcNwPyKJ0DsC4Ms8fwGepDuRnzdz+iSx/X7X/k5UFrY+
   B2r4hJhMr9Iq3cISDzXv7xonfryXPS3+B09DMT1wtWWpO+0t3vcNd/DFM
   a99jnaWaSmvbLhUCo7o1u5d6uJyYFoKZQ7DINvGikBJHGkMkBxT/kKAsW
   peIuveYlm0UFvbX/0oYtGK108AMAdZpNaQznl7yh+h+U8DgXOhT9U+ML+
   IHE/O8YcwRe8Rw8SlKJatpKPzGhJSjHk7+ZJ1sEKKxbJjcIA9kWBhUQMe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8758553"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8758553"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12095203"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2024 03:48:44 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [iwl-net v1] ice: tc: do default match on all profiles
Date: Tue, 12 Mar 2024 11:52:59 +0100
Message-ID: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple non-tunnel rule (e.g. matching only on destination MAC) in
hardware will be hit only if the packet isn't a tunnel. In software
execution of the same command, the rule will match both tunnel and
non-tunnel packets.

Change the hardware behaviour to match tunnel and non-tunnel packets in
this case. Do this by considering all profiles when adding non-tunnel rule
(rule not added on tunnel, or not redirecting to tunnel).

Example command:
tc filter add dev pf0 ingress protocol ip flower skip_sw action mirred \
	egress redirect dev pr0

It should match also tunneled packets, the same as command with skip_hw
will do in software.

Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 --> v2:
 * fix commit message sugested by Marcin
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index b890410a2bc0..47f28cd576c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -158,7 +158,7 @@ ice_sw_type_from_tunnel(enum ice_tunnel_type type)
 	case TNL_GTPC:
 		return ICE_SW_TUN_GTPC;
 	default:
-		return ICE_NON_TUN;
+		return ICE_SW_TUN_AND_NON_TUN;
 	}
 }
 
-- 
2.42.0


