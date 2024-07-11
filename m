Return-Path: <netdev+bounces-110933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243692F039
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1801C20C0F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7116EB67;
	Thu, 11 Jul 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RF2vLV2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B319EEB0
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729182; cv=none; b=ZQflEbDX0UweDccQjMyCk5D50VKjDli0tdj+qB+exAtpbTO3B1iOFkTatbR1QqtTyjT56bCrkNvFnhwZBUFYKdv2/a7gkbXRlOuzsC5PilbaeqzEqlY90K8Utiup5U+rdr/LwjKE6CYuSUFqpxeKvv+Z65E/Grss4y5pXjHwxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729182; c=relaxed/simple;
	bh=Mok3R/mX/ctx4Y/hiDMsmWfpM3/0pGjFgUhUHccXxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcEJWxTitP20NSvS6EOrEG6cbVb8sA/3E8N1V/FIl6e7EGzbct+epbrDxldBRScHuOffiXeWPa+4UW50TeHRysGY0ZQJajhF/sW+EPJqq5vc8UV4FGQ0nRAnfLWuKg/w7Mh0Op3evxq6fG8fpDceIQHQDHGGTKASDOy3N72fjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RF2vLV2Y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720729181; x=1752265181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mok3R/mX/ctx4Y/hiDMsmWfpM3/0pGjFgUhUHccXxBA=;
  b=RF2vLV2YpTHaXgtBzuwISNkCVv91gj5yb3PRmtNGDHxOqoPcLuo3MpUD
   GMEhWm0LSN1nLsTZAR9dgWsHY7GBdUB/6UQXwxSXo7HhuzumiUk3YRw2P
   tbnFgjB7578GmIEmAYmNtdCr+ON7Q1wsJuBjXEVEo+Z7o3Vk+1jLkgTPO
   FNE+TlPFFz3xdEB2pa44kjhSSuFkRt3Y9fdM0okd3Yg5lPIn+D4TibZvp
   MlMpfB5uT4KTji67MGAQJPFAMBFeQTgL40+R71RG4hL1FLf+Up1MwIWM4
   ywxDXGi5QIZg79YZe9HYKkgteJYHX38EC5ju+zsX5uBlRsvg0BXKnHL3J
   w==;
X-CSE-ConnectionGUID: Z/xN+F4ZQ0Sq7u0YJt2+aQ==
X-CSE-MsgGUID: J1rFoAlnRqKRYHqH2W6F7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="12508402"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="12508402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:19:38 -0700
X-CSE-ConnectionGUID: BTCQeQ1qT/a5xLGZkd8IPQ==
X-CSE-MsgGUID: IC+pXDyCQOGDWXg2w5IhhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71887416"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 13:19:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 4/5] ice: remove eswitch rebuild
Date: Thu, 11 Jul 2024 13:19:29 -0700
Message-ID: <20240711201932.2019925-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
References: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Since the port representors are added one by one there is no need to do
eswitch rebuild. Each port representor is detached and attached in VF
reset path.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 16 ----------------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  6 ------
 drivers/net/ethernet/intel/ice/ice_main.c    |  2 --
 3 files changed, 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 4f539b1c7781..3cfa071e3718 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -536,22 +536,6 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 	devl_unlock(devlink);
 }
 
-/**
- * ice_eswitch_rebuild - rebuild eswitch
- * @pf: pointer to PF structure
- */
-void ice_eswitch_rebuild(struct ice_pf *pf)
-{
-	struct ice_repr *repr;
-	unsigned long id;
-
-	if (!ice_is_switchdev_running(pf))
-		return;
-
-	xa_for_each(&pf->eswitch.reprs, id, repr)
-		ice_eswitch_detach(pf, repr->vf);
-}
-
 /**
  * ice_eswitch_get_target - get netdev based on src_vsi from descriptor
  * @rx_ring: ring used to receive the packet
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 09194d514f9b..78fd39a6935d 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -10,7 +10,6 @@
 void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf);
 int
 ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf);
-void ice_eswitch_rebuild(struct ice_pf *pf);
 
 int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
 int
@@ -54,11 +53,6 @@ static inline int ice_eswitch_configure(struct ice_pf *pf)
 	return 0;
 }
 
-static inline int ice_eswitch_rebuild(struct ice_pf *pf)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
 	return DEVLINK_ESWITCH_MODE_LEGACY;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bd3a60dd779f..ec636be4d17d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7702,8 +7702,6 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_vsi_rebuild;
 	}
 
-	ice_eswitch_rebuild(pf);
-
 	if (reset_type == ICE_RESET_PFR) {
 		err = ice_rebuild_channels(pf);
 		if (err) {
-- 
2.41.0


