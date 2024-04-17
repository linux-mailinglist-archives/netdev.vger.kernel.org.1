Return-Path: <netdev+bounces-88814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9824A8A896F
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBC1F24545
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71E17108B;
	Wed, 17 Apr 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaWx5IEn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65D171071
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373004; cv=none; b=GoE9GCvMcWlgmGYjJ0hVjsPr+56JI5M6kDk8NvstT94gpM9ouVfh6jDqNgYjZ7aSAAxPirp8yd/pysf3LYm9cjpSTBl4T/k5HT6ZjwAAcThkR2CBkTMvrgfT8iRo0UZ/fuYm9bXw4zaHdWXRW7NbIP8vmnfjKRs8Q1dwH3fslU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373004; c=relaxed/simple;
	bh=UNHXbiPN7410xMhCJZuPlJNB4RzFR5VCyU3wmS4kHzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/EBllBg4A4qgbYEfwmn0QZG81g1slIqi/bKyhnaOCPphi4D6uiRAyCiXd7Dy1wrkrLeO/yV/Fy9LuYIIZWypGGH74OcmlRRYP87e2yMNKYNE01kHAN5nplXm5K6ktofLN0hPQOQPHqC4phq25ef1QCPwfNvOpSHmVqZ8jfpks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaWx5IEn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373002; x=1744909002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNHXbiPN7410xMhCJZuPlJNB4RzFR5VCyU3wmS4kHzY=;
  b=EaWx5IEnM6JUaqz/neMmNqJJSlLioAuplWsEk59fF+aku6AFZghq/Xqj
   B7a1GYpJy7kH9YPzBMzV/SExhEEOCvnoaoyx66LTjRv6B3CTI2HNJUcqo
   ENxMVd9s2VMzbuDZeC7/QEj5djhrW4Hy3+M6udHQ/4vbEzWKXPOXGfYOU
   76rMWqs/HB5w2BAj+iM1hQfnNOaJOodA6uv16B0BzGbXKRlulJ7xBYG/N
   ILkUgrC+riKpJ1zVsZpf5StyLniWc7V8YAl/4YTVWrSvCp7Zpn8vIGin4
   5HuHJZhmFt/1I1MY/YMcELCyimBXG1jixY4jibkLOzobKmDRPetUc3nCB
   A==;
X-CSE-ConnectionGUID: Qig72+WjTlaqnkpGDbfAGQ==
X-CSE-MsgGUID: KAVuHGZQRR2HEvH83f8mcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9047291"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9047291"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:56:40 -0700
X-CSE-ConnectionGUID: +J83yb7hRGGJSkCcYK4etQ==
X-CSE-MsgGUID: 6bp8tUYQQrqF2tLbyeh1/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27257619"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 17 Apr 2024 09:56:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 2/2] ice: Remove ndo_get_phys_port_name
Date: Wed, 17 Apr 2024 09:56:33 -0700
Message-ID: <20240417165634.2081793-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
References: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>

ndo_get_phys_port_name is never actually used, as in switchdev
devlink is always being created.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 34 -----------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index b8009a301e39..d367f4c66dcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -9,39 +9,6 @@
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
 
-/**
- * ice_repr_get_sw_port_id - get port ID associated with representor
- * @repr: pointer to port representor
- */
-static int ice_repr_get_sw_port_id(struct ice_repr *repr)
-{
-	return repr->src_vsi->back->hw.port_info->lport;
-}
-
-/**
- * ice_repr_get_phys_port_name - get phys port name
- * @netdev: pointer to port representor netdev
- * @buf: write here port name
- * @len: max length of buf
- */
-static int
-ice_repr_get_phys_port_name(struct net_device *netdev, char *buf, size_t len)
-{
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_repr *repr = np->repr;
-	int res;
-
-	/* Devlink port is registered and devlink core is taking care of name formatting. */
-	if (repr->vf->devlink_port.devlink)
-		return -EOPNOTSUPP;
-
-	res = snprintf(buf, len, "pf%dvfr%d", ice_repr_get_sw_port_id(repr),
-		       repr->id);
-	if (res <= 0)
-		return -EOPNOTSUPP;
-	return 0;
-}
-
 /**
  * ice_repr_inc_tx_stats - increment Tx statistic by one packet
  * @repr: repr to increment stats on
@@ -279,7 +246,6 @@ ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 }
 
 static const struct net_device_ops ice_repr_netdev_ops = {
-	.ndo_get_phys_port_name = ice_repr_get_phys_port_name,
 	.ndo_get_stats64 = ice_repr_get_stats64,
 	.ndo_open = ice_repr_open,
 	.ndo_stop = ice_repr_stop,
-- 
2.41.0


