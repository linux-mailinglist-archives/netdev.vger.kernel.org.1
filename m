Return-Path: <netdev+bounces-148355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD39E13B2
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEA42829C4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD63189BAF;
	Tue,  3 Dec 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGCRvQVg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A932188A18
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209139; cv=none; b=OXwjCFbqIzXSka/dnrr/V291BlRj9RAiLFM2YuOYHm9XIiCT9ugXIHKMlSHlCwcqdZDf0FZhB1SH4Ta69LRUnQpvJcVsJTpWD6U+uYVfDS3vZrLuYhWk8L3IrsF1loYWPu34Tmm4CbIZG4pZCxeFA4ZFNs+4RkZ/PnyZtEcCHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209139; c=relaxed/simple;
	bh=TqMn5ZoOpTAoAK8iWGxuf7LA1zoNOY5g+SWXA7iZEuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/8UIoOohFXYcL84VXyN+L/BFBigbea/9YmftC1og6RY+hhYZ/van1ljihHnaPp8FpwiSFwX4CvjjedxyS7aJIUy70fysBkWYxLqXgEFFakU6HlDyztdoc33fuJH2tpJ91aVmHuMPzSv9p3eiBNfwLByC3ZbtgSB4aO+TZSuGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGCRvQVg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733209137; x=1764745137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TqMn5ZoOpTAoAK8iWGxuf7LA1zoNOY5g+SWXA7iZEuA=;
  b=AGCRvQVgzLhDJHvYXeRm6x3Pc2ifhwSKfIJbOLItf+gFMTY5wv6gZxMF
   OVYHuorgX97whyPHl+Gzxg2JncLDMX+oGe4DG5YXPvPG6e38PJED3XNn8
   XeeEOYT/7f2HJ/RHGLMvMqcrBoTARDzj3ZvHu1zREPQj9a52EUf+TCiZx
   rZb5/qv1RIMPY1IPPp8p8c7aoojUD+4FaiH6r10t0uOtMbPQveDxLuLM7
   BK0+xREKjBPxuozRWy9zYthajT6F4xujaTJXA3My9aFIYj7ODiGlnU/jj
   Kfzek3mrnJUcD9oOOfVfpa6TfwARxOb580OJNb1hVlx7lEULx4xvlSqXU
   A==;
X-CSE-ConnectionGUID: 7qZ1HeN3S6SXvNw+cg2LEA==
X-CSE-MsgGUID: euwjVdPbTeemQCLs7Ted8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33330580"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33330580"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:58:57 -0800
X-CSE-ConnectionGUID: 4Mn7tKIATLyVZ0N26wumDA==
X-CSE-MsgGUID: tRK8sG7lQwukv3KNZUdECw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93673763"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2024 22:58:54 -0800
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
	mschmidt@redhat.com,
	himasekharx.reddy.pucha@intel.com,
	rafal.romanowski@intel.com
Subject: [iwl-next v9 9/9] ice: init flow director before RDMA
Date: Tue,  3 Dec 2024 07:58:17 +0100
Message-ID: <20241203065817.13475-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
References: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7b9be612cf33..576bff42f440 100644
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


