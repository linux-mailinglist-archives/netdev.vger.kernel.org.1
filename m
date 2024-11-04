Return-Path: <netdev+bounces-141543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAC9BB46D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044D2B2664D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6391B6D0D;
	Mon,  4 Nov 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wwu0up9F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9B1B6D08
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722457; cv=none; b=hGDL3QsRJ/UJO3ScrJy8n2RKEWUGe8szuUyioBlYBBk2saLRdayo+1K2bMOgTHy9jgC992ZG9XVuy96tHrjVdB8OrsgkEM612EZrr3BdY05E48YTfxFbnpCz3a2KX+dvQ/7VavK9q1ZlDoruGL2mvC4qZZ1jcO/FSWxhFKxCmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722457; c=relaxed/simple;
	bh=iNYGweqdVVelpNzoPuvQ7BW304Y7BVlMN23yH/IOVFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHN+OkYLQCKV+2FvxKJLtkgzORL5ND3ddvQvMD10LKlKGsRC8TA+5B4wuREohxJihjV+DQ38kCqzGqEp/AyEMSfrmL4gyOaBNSmBwb7FAR7xOZP0oT7yHYALxernObdtKvsGUhY9CXokEnuf0zkBz+I22MXi8jvph9aqr1Kqwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wwu0up9F; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730722457; x=1762258457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iNYGweqdVVelpNzoPuvQ7BW304Y7BVlMN23yH/IOVFw=;
  b=Wwu0up9FGhZTeXZ2s3NwILjCr71BxvqJ+rv9O7rkJ6oX3qbySgPfIDpK
   QhezVY4cvxLKlPV352d1LB1wsPI63ykd5mC7DjZNTnDPVdhO86dsLdKuc
   7BIIXuUdXdPiI2arRPTvTFTUizKd6pwo2lyJYPbxib227rmufAiR2NQrr
   bPMDipjFXopSde6XRbWcPJsnp2uoDZ8uOltN/ZVoSiE1nAoHss4h6uzBw
   MUxpnuzc1o/pH4SnkgqwN5mQqusp5qX2e6jZwQSvY0gHwF++3xO7ayPQh
   NJH5FtbyR7+MMj+YTy2R06jdO0jqWlrcu7tuPptvTq3dqWaN6RVzttewT
   A==;
X-CSE-ConnectionGUID: bmfop7khQkScM8M+t/dL/g==
X-CSE-MsgGUID: 2WQaMYBNSP6S9+Wx929ZPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29843739"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="29843739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 04:14:16 -0800
X-CSE-ConnectionGUID: ELVJu/1oTtac2xXBkLRibA==
X-CSE-MsgGUID: laZmn+d8RKO6Bcnu+DDMjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83525808"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2024 04:14:13 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com
Subject: [iwl-next v7 9/9] ice: init flow director before RDMA
Date: Mon,  4 Nov 2024 13:13:37 +0100
Message-ID: <20241104121337.129287-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 41f0d0933c2b..95c9d45994f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5180,11 +5180,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5192,6 +5193,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5215,8 +5217,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0


